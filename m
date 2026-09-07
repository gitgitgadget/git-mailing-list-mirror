Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052646F4AB
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780020; cv=none; b=kl8iBQmT6PMwOOZxfyxlRgcOupLZEkdVBEJx6SKdmLa+7/Y7qGeYo22kWNnORghtEe7BGuUeyYE/8Kxpqkibe0gJ5P8uS2cJ+HMJ92X9aYh00PzhoIaBjgYuPoyDnmGyit0LORxtluFbPkk2SIECQr/6NTJd9edAL+KR/2TC2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780020; c=relaxed/simple;
	bh=pDQNtHIyXHV6/2or7V3fSGbmfxjta6T2dqXDO7y52Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTE0coBSHEHcVe8+BnNrMuVNRy/GZPq5g9FpsXJxmhwawBmHu9ZPItTQQf8heOzKphQCuJQDtOsTl+RbYpc79Fuw/TCN6w4jCBDTANdVjlINnMkfCL4pchCC0LpehuJ43vheBLOE1aS9QU8uRqJTSw9UHJ/flNEOdAsNWjfDaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=psWD6zOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhOieOSZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="psWD6zOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhOieOSZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3BE914001CA;
	Mon,  7 Sep 2026 07:20:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 07:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780017;
	 x=1788866417; bh=H9Clmpy0DBI94MnDgeVQLabvoCPLkGwFAyDDzVWgPvA=; b=
	psWD6zOcEPQZp2szJmzuvbnB/6TM3lTD8w2HXDplKcwoUgMenoj1aKen2yaZ1j24
	jVN2xcL2X+voS9a+XnHpdBM6sycSdgh4mNFlZ6O0uutIphxj8mNCo8jyIvqE6TRY
	ush52mYsbj5CbJ0WJ07jPXARzC8OOAx0YpIjHXhuf5+UDcnDRh4EjftwFYkaa/Qc
	Zu0uiPeeF3UwJ+w37BTJjSxHz7fJalyGM0S8w1r0zXuAUhuxGzX9t+joTGB4U9eo
	4UW/X/EOi8qhUmYEoeeDu8knp/7/1oqaIrn8nEOjwYSPGG/40HaeA4FCFhy7Q/jp
	fvr+YZNK6CRom80JAdNQAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780017; x=
	1788866417; bh=H9Clmpy0DBI94MnDgeVQLabvoCPLkGwFAyDDzVWgPvA=; b=M
	hOieOSZWesDsagVtMkS4JhNJIlL4XeVwMNVUyYG7fOevK//G0i5EYlUReElaXvz7
	gEV4KqAK5pjkH0GBvtC836QFaez+p9+uRjB2lv+VDp+N9/eN6BqnuKLJcOVBLXod
	VFyR6aod9vjOz1oZWniWSlxre68bNgWSLPhrVtaWL9IBbHawWmxeCSaMoLX7SZg9
	P8+Hele1txQoeO5/4rJK4vl0zOnzCVhKbRPbPmdmXNVY7vXlOs75DsW+Ow211trT
	UNhXp7jfatpPBrh0mzLBsR+yxGeMG3HyrgNp4phZApgS1E2uSVUB7E7db+NPr8lY
	Wbbet2hzc+T+oBYwmHm0g==
X-ME-Sender: <xms:8Z2eajlfr1Gnnx6tljldviWL1tZ0ruQWCqIEGI1SJkXLsEtBOJBjxg>
    <xme:8Z2eauS4lj9uxsoXa7R7Y4QZgAKPha7FM4-g3r5vhGee8J7HimPQWeYuMyMGEQv-5
    GJzP_ojvOjjbB9lnJosYTGSdtXnZ63CtWtRmL0rZH47G7LnEipxIBU>
X-ME-Received: <xmr:8Z2eanCZ99tcpLaLZj6209miu-W3iXYPjyfotS2tqZZBvgG9AA2Gmw>
X-ME-Proxy-Cause: dmFkZTEODmYfhcE6MkClXmAzaz/u/B/AKDElneu4mL0qUxdd8dsBrCmOKXS1tHl60eVFV2
    SymYRFYzuiLUqyPPFAGooBAERtLvf0X1LhcjqzMnX7gdc7DtqXstRRoihdSALfCxoWFzJG
    BbbIbG0MP1m8AhEq/eZrNtPsqwDGfS6kNpj3lzhC6fPFYomNFvg9RKzjO2WnGUQd1KA2IH
    sWYk5pONmMX+mdXpmpfGC22NTMapciJwOTHnIl8o4jd+7ZhCw8vFlPa824pJltjvaD3N4A
    MUB/oyFdCvhdQMSVTPOi3Wa2Ehbr/+fSxb1kUGZO2C7ytEHmk7HxP5nm8sCCeE5hTY4Ua7
    o1chx2ghqiIao4V/i0DM58nMBsASG4DP85Jks9d5kl/vgg71nxsYaz4Qv+G+4W3zjsCUKm
    hmeF93U8Drlb4q2ZRZbkqzim2m6+nhYpB+9SSqVuMbMDArxudkvQ2PJjmr4zBm9HOJaZZS
    o4nQcttyasGFaft7RZT3CwMNZYlWAfuXhID+IEC3w8QTt23JdhYVov96pKqvUP6pAkHI7N
    LVJbepNSmaee/0+WELO46qWqRJgJhrHqEvW1zIpO3bvC/5iankrqfDEl4piAoKVdXSCuhw
    GvQDsi64KMk0YrqtY27o3NMhmZx9iRAclVLO7GjUhy7nFicfWa80DmTduxlw
X-ME-Proxy: <xmx:8Z2ealR4UZgVG0z9HI3F-Q2cLsqcwFYiQdb57A91DShgFf_zqLJbow>
    <xmx:8Z2ealovnTy4T8oKxFV-1l-29FKXJhcAUfC2b9dhpqQ6ockMM1ROKQ>
    <xmx:8Z2eanyGAcXuVjQUb57ErnbEYpsPPaR7PED9pd5OcNB69xfYj_N2YA>
    <xmx:8Z2eaqK0nDBvQBgqofFqoS4kFc8VYAO8b-fGXE-nrYKTce5-jQ5w6A>
    <xmx:8Z2eaiToqlzXWm76eB_4dgXJq69-TqWRfCfjy_tdEy7v0HTpHVp-1rRJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bcef3c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:37 +0200
Subject: [PATCH v2 03/11] builtin/refs: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-3-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc            |  6 +++---
 builtin/fetch.c                        |  2 +-
 builtin/refs.c                         | 11 +++++++----
 t/t1423-ref-backend.sh                 |  8 ++++----
 t/t1460-refs-migrate.sh                | 12 ++++++------
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 6 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9063892651..09e9bde939 100644
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
@@ -97,8 +97,8 @@ OPTIONS
 
 The following options are specific to `git refs migrate`:
 
-`--ref-format=<format>`::
-	The ref format to migrate the ref store to. Can be one of:
+`--ref-storage-format=<format>`::
+	The ref storage format to migrate the ref store to. Can be one of:
 +
 include::ref-storage-format.adoc[]
 
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
index 5cd21c25fe..53b12accaf 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -10,7 +10,7 @@
 #include "refs/refs-internal.h"
 
 #define REFS_MIGRATE_USAGE \
-	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
+	N_("git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]")
 
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
@@ -44,9 +44,12 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 	enum ref_storage_format format;
 	unsigned int flags = 0;
 	struct option options[] = {
-		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
-			N_("specify the reference format to convert to"),
+		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
+			N_("specify the reference storage format to convert to"),
 			PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
+			N_("specify the reference storage format to convert to"),
+			PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
 		OPT_BIT(0, "dry-run", &flags,
 			N_("perform a non-destructive dry-run"),
 			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
@@ -62,7 +65,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
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
index 5eaf689d74..9081401509 100755
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
2.55.0.1007.g17ff1f9808.dirty

