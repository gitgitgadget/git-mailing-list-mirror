Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264724A3414
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952398; cv=none; b=Q4c/zoD+6U+tmOH0HLP0nB1/NhYHwDrX06z35LUyEQD4QGf2hSAlDuY0lPCkXO1luRAKHg+JmNgYwyzQQdkaGFO1BxTtr/s8vPe6xv+fNevr7qL+L2NN5ubI1IGCm0gzzVsFzd7LZQ67UmJPm42FRLw+toBAmFOKBuj8rw0XWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952398; c=relaxed/simple;
	bh=aJLDVLYzECvSHBrK4whzNllH8zHsiJqqFIJqGvPvCUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvf07Muv+0NFkxWh8CRx8VhM+lL75/UVEDKzLnjnCQpg7RANOhedktRgxR/ElwBL2D9mv88T48aVZO8GeK2/g+/vwpD+AdefY5XWCcr+JoBSpMraSH1M+xFj8jQwB7eKyPQOYFoJsV51LBofsWF1VLTq9LADwcP5kKFzJrwLpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QuWhXI3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U86AJrvi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QuWhXI3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U86AJrvi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 58240EC00DB;
	Wed,  9 Sep 2026 07:13:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 07:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952386;
	 x=1789038786; bh=CWDf/hfG/HBLPP6Zq1Ugzg7cXKbARpqFy4SrTteqRps=; b=
	QuWhXI3Lr2auUEH/oWUeQZnpuxaAss8+Fl38AUm7zgv+lZeG5T2Qwo8ntziLSoTV
	TGXM1/ykCKMnJxHqK5tX89GiTn27Le0wFak1MdgdSbM7xyeaevX6vtKOTPNzJNqB
	TF1czAdjgv0cNLAm8Rnva78VW0uHDjxtGsQktN/W6h54adHC0h8shTaUN0SvvI3F
	hWtgigcQbvp+w9E6oATI8gU5RGfXzu5DTT0rORdigT/3+ymHgC42tudro7tkS0HR
	x64ul7eb++Qoe7CtwK+rtXFgYPne2lGfz0QfE9h/ZaqFbKrGEyDWy05Dx6BFDJ0J
	wEltfzIBRqy4dXDvixOfjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952386; x=
	1789038786; bh=CWDf/hfG/HBLPP6Zq1Ugzg7cXKbARpqFy4SrTteqRps=; b=U
	86AJrvi6ObcTqqxWODgIuY/yHsQBKMFLeJEOfNTskQp9fWMgCPF6wp9URrKLrdwd
	b5nPDSfhJ5wpmAEgPBlcnr8R9TzlcO6O2dWO+CjWyCBf9ywHOyQkEhdzPzSvrxlY
	+lAxWvkEAVUhb70k7wh0FJmtdYJgtmBCoojQv+ZT41mdxZylAU2fyzmPNb9Y+nJz
	r+QLfhU79RwkryuIML/QdxoEbLarr9/vIjZ2iFlvpEeAekgO/WuIfAuUbhhTmEhd
	upiHM+aHqJA2KQ+UoCNWaylQ7AaRKG4a4WvvgBFQUYzBCt6U8b2JlJGLEMLPWLW0
	LETUSvXtypNShhCITXLgg==
X-ME-Sender: <xms:Qj-hah_jLsNwS9_bDMmFE65uBxIWSlm1lRpvhNhIbsai02I0LX7RwQ>
    <xme:Qj-hastOx-AjYnihbGZIkLPGXoF9K31PWc1n0qKWg5LL4N68a61BuURyOekwY062o
    _FDHO2XOhKsQt8sk4brhEPfeXou5ysaPAesfFpFoxUv_ReVLVdg8C8>
X-ME-Received: <xmr:Qj-hakD8tOD15a4MlKsKdkojg3w4YKEFeA-1nqNlMJAiSn35qSrVzXUY6aAP8oDRlq0tHQ>
X-ME-Proxy-Cause: dmFkZTEwyGqQuR9qLhYIhdppnRDQCDSRRMsoaO5F6DlKBPQiKUVyhFkh3dhChyDPg7xzI7
    q2Y4ogx5rszY9ZUFAStJ61TbLln0IFUalLkGE3M327Lm7BIuCZWCyEOCiX7Y5pOWTR0zq4
    roYsvBrZJ3fMC4HYkTF6XJxhujPdtbgbMIqMTaCf55zmMnEhYAoI3dmjfRqDbgQpK9zacV
    T5+swyfV/9uc+p55ft7Zr0tKx2NY1U6hHiV3oMDTAOp+EVouKpvNdIDYOYf/MvlPL4Ciq7
    +cE7bbRPh3ZM5eFPwe9MXKfBIrKMiuvpXJ4QAJ0dE3kt8c84mE7/f7UNtzt3XIug+BNFod
    3FlVv2LXaMTWPZppuRKHS0dT4SDQsZQxv+H1oS0Ryd2aGsnZ5xHXMEHfYHmu/AbRgfEGkc
    3fIPwJ1qxJnwAFTnJZpVS9oEXqa44ueFuC17i0r0Bk9NWJJ+NhPYY9KR5YqPZz3zO3wUKF
    3eGChYiwSaouQsa3IgBRjIWoMDc5z/BIin8vBNIF2N/4uSyiVHZ8OViIRZK4u1MUQ/X/At
    h8kXOw4/SfhmXRuFXyDCS3BxQGi5NoYt+H1itJ+E4kfIXvZJSgg1xtm2NfPODv9a2X552Z
    LQWUu7yj23isWwziDEsGrg1N3ZpBEfiW5F8IRgSdCnPo9cc13epZk4Gk3DuA
X-ME-Proxy: <xmx:Qj-hakX10Cv1XlldKWFNtqgFmtzseiYNtheVQN8i7xO1bAr4l3CFrg>
    <xmx:Qj-haiCiMQPQJs0VWm2EjXX3IwGdn44g4eiEDfslfUNBxIce7OzVuw>
    <xmx:Qj-han8V4XecePtRISclq74U7kkuGDWRf-jg8bUFjVECDXhcNgpqUg>
    <xmx:Qj-hapFUJb_RJPUQrnksbn4am3r1Qd26r403yh8criid58XGM382zQ>
    <xmx:Qj-hanjylSyp95FTqOBJK4uecp9PCP2TdF3ceTy2WIc5EBsLlsukqeTW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9602dbcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:50 +0200
Subject: [PATCH v3 04/13] builtin/refs: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-4-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc            |  9 ++++++---
 builtin/fetch.c                        |  2 +-
 builtin/refs.c                         |  9 +++++----
 t/t1423-ref-backend.sh                 |  8 ++++----
 t/t1460-refs-migrate.sh                | 12 ++++++------
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 6 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9063892651..ae722c60e6 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -9,7 +9,7 @@ git-refs - Low-level access to refs
 SYNOPSIS
 --------
 [synopsis]
-git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
+git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
 git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
@@ -97,11 +97,14 @@ OPTIONS
 
 The following options are specific to `git refs migrate`:
 
-`--ref-format=<format>`::
-	The ref format to migrate the ref store to. Can be one of:
+`--ref-storage-format=<format>`::
+	The ref storage format to migrate the ref store to. Can be one of:
 +
 include::ref-storage-format.adoc[]
 
+`--ref-format=<format>`::
+Deprecated alias of `--ref-storage-format=<format>`.
+
 `--dry-run`::
 	Perform the migration, but do not modify the repository. The migrated
 	refs will be written into a separate directory that can be inspected
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..687909c0c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1848,7 +1848,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"can either accept this as-is, in which case you won't be able to\n"
 			"store all remote references on disk. Or you can alternatively\n"
 			"migrate your repository to use the 'reftable' backend with the\n"
-			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"following command:\n\n    git refs migrate --ref-storage-format=reftable\n\n"
 			"Please keep in mind that not all implementations of Git support this\n"
 			"new format yet. So if you use tools other than Git to access this\n"
 			"repository it may not be an option to migrate to reftables.\n"));
diff --git a/builtin/refs.c b/builtin/refs.c
index 5cd21c25fe..31aafb9974 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -10,7 +10,7 @@
 #include "refs/refs-internal.h"
 
 #define REFS_MIGRATE_USAGE \
-	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
+	N_("git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]")
 
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
@@ -44,9 +44,10 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 	enum ref_storage_format format;
 	unsigned int flags = 0;
 	struct option options[] = {
-		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
-			N_("specify the reference format to convert to"),
+		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
+			N_("specify the reference storage format to convert to"),
 			PARSE_OPT_NONEG),
+		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_BIT(0, "dry-run", &flags,
 			N_("perform a non-destructive dry-run"),
 			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
@@ -62,7 +63,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("too many arguments"));
 	if (!format_str)
-		usage(_("missing --ref-format=<format>"));
+		usage(_("missing --ref-storage-format=<format>"));
 
 	format = ref_storage_format_by_name(format_str);
 	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 9ae295cf3d..ab119a6568 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -144,7 +144,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
 			)
@@ -159,7 +159,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
@@ -186,7 +186,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
 				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
@@ -218,7 +218,7 @@ do
 			test_commit 2 &&
 			test_commit 3 &&
 
-			git refs migrate --ref-format=$to_format &&
+			git refs migrate --ref-storage-format=$to_format &&
 			git refs list >out &&
 			test_grep "refs/tags/1"	out &&
 			test_grep "refs/tags/2"	out &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 8aded6597e..204dd79b41 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -42,7 +42,7 @@ test_migration () {
 		print_all_reflog_entries "$repo" >expect_logs
 	fi &&
 
-	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
+	git -C "$repo" refs migrate --ref-storage-format="$format" "$@" &&
 
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
@@ -77,7 +77,7 @@ test_expect_success "missing ref storage format" '
 	git init repo &&
 	test_must_fail git -C repo refs migrate 2>err &&
 	cat >expect <<-EOF &&
-	usage: missing --ref-format=<format>
+	usage: missing --ref-storage-format=<format>
 	EOF
 	test_cmp expect err
 '
@@ -86,7 +86,7 @@ test_expect_success "unknown ref storage format" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_must_fail git -C repo refs migrate \
-		--ref-format=unknown 2>err &&
+		--ref-storage-format=unknown 2>err &&
 	cat >expect <<-EOF &&
 	error: unknown ref storage format ${SQ}unknown${SQ}
 	EOF
@@ -107,7 +107,7 @@ do
 			test_when_finished "rm -rf repo" &&
 			git init --ref-storage-format=$from_format repo &&
 			test_must_fail git -C repo refs migrate \
-				--ref-format=$from_format 2>err &&
+				--ref-storage-format=$from_format 2>err &&
 			cat >expect <<-EOF &&
 			error: repository already uses ${SQ}$from_format${SQ} format
 			EOF
@@ -119,7 +119,7 @@ do
 			git init --ref-storage-format=$from_format repo &&
 			git -C repo worktree add wt &&
 			test_must_fail git -C repo refs migrate \
-				--ref-format=$to_format 2>err &&
+				--ref-storage-format=$to_format 2>err &&
 			cat >expect <<-EOF &&
 			error: migrating repositories with worktrees is not supported yet
 			EOF
@@ -211,7 +211,7 @@ do
 			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo refs migrate --dry-run \
-				--ref-format=$to_format >output &&
+				--ref-storage-format=$to_format >output &&
 			test_grep "Finished dry-run migration of refs" output &&
 			test_path_is_dir repo/.git/ref_migration.* &&
 			echo $from_format >expect &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 5f31d233e9..e61389af05 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -94,7 +94,7 @@ test_expect_success 'status with mixed submodule ref storages' '
 	git init main &&
 	git -C main submodule add "file://$(pwd)/submodule" &&
 	git -C main commit -m "add submodule" &&
-	git -C main/submodule refs migrate --ref-format=$OTHER_FORMAT &&
+	git -C main/submodule refs migrate --ref-storage-format=$OTHER_FORMAT &&
 
 	# The main repository should use the default ref format now, whereas
 	# the submodule should use the other format.

-- 
2.55.0.1074.ge7621b4bad.dirty

