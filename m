Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B242B327
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518184; cv=none; b=S6L0JG5w3qMZyUwgETp5Yy0msDqFrxUb6ygyjwEDy47rM0/Sg17N0PEc9ybRCcBKMjB/QC6jmXShaVBXdTC2uvBJixTjS0PbIw1bEGpxCI6VD0mRc1BdUjY2/VLZCYls6iMWEfA2jZHcAbvyZe4ta4QqF/qnnDsATiWEoQlCyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518184; c=relaxed/simple;
	bh=MHcqCNF1O9orcDTbbJ89OJlSKuk24K7RSWnYfKLw+e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Avdfne+giggGFPdDE1wLRPY3D0X+i8A/tXXHtYFbD5AKaxU1wMNqs2Ou43tTjX6I9sbkSwMo/Mf9ZQxYVUyaT6JwAaYsw5hcMSeQ53A2caMyukAPpq4Ngq0/1DCYJKSqfq/AALhVWDhidGpX9nhakv3sva8SSxmix4SiDmh7+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/EE5CQQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkS/wJUH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/EE5CQQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkS/wJUH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9DC37A0140;
	Fri,  4 Sep 2026 06:36:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 06:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518181;
	 x=1788604581; bh=ybEsdGoLiVD2aGndKDZ/aWUkNJdPmDo7qJY2l5NUueo=; b=
	T/EE5CQQmG+rvywr9NlpM5yfy9W8lIRoqeF5he9BWN6v+2C0jOCcPZJPtEfkRq0P
	zf4/Fnb8LnjJo+VZOVt4bKLO7rmlQ39SINfetjDWNrRfp9X/o3px68W+iya+qrIK
	YC95Sxvpk6qp46IVLiloqhuPshZxTtVh+0l29e5Ty4kPwJ5j62VUbL2RYR4aOdoP
	ZO/BlWoGNYw/HSNv6XIhteioFsJAUB7xsl4Bfe/l1Hz1REY9wB+bcsxPv0OnOT2e
	nvwLA8Q8CB5SDCADjikyPXodGrV3hLtCb3wKNjRYXZdjHzO4LRBEZR5lmD2Xw12a
	Ht8nIgFRO1Ll+KRLQLJQUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518181; x=
	1788604581; bh=ybEsdGoLiVD2aGndKDZ/aWUkNJdPmDo7qJY2l5NUueo=; b=I
	kS/wJUHjSImnBljMaYNdnk0ODjz5g9+fU6RiiOSwZ/YrCIe0yIO+KCM0Sb1YOs4u
	zaIiqEVf1piKzwp0bXONhebm3S1VjoNG31ROxUS1zd6KKAE6BgUNejhFMu2AAif2
	B49hVjqJjXVHVhrJVydr84G7mMzRV+2/YyaiuZX0PGtSO+R2EhGCc5bBVib1EEO4
	ZAVN2VsYQ0/edcl7iD9fFnddC94+jQzkFrcQI3ll5lXNGNdUtZ2n+783Ox9feNQN
	+2z6lPL1wMOmW3fZW3HuKXqke0zDsj/kSTjwLeYj2nl3skTC5B2W1uxA+zltjGcj
	6P8/DewNwB2IGi39vh1VQ==
X-ME-Sender: <xms:JZ-aallmcGkCZEBRhYrncs7f1H3-zoQjHX2n73FEbRSRtcHUu8cLuw>
    <xme:JZ-aam0pb0ETT5UlN6WSZj8NuZxvkvn-JupfBR8Ma2cOSSkNuU6uB1bJ632ZvqfMy
    7JPmaNz3E40_zzvmmGXpIce73INp5P2VRJlNDYA8fR6Qh-ma3XZGPc>
X-ME-Received: <xmr:JZ-aapSHUabl5uFxvTo1BT72pfrJjr8KAkzt0rmrP5vz3J0QAzGywx_Hhzg4NvaT-u9Org>
X-ME-Proxy-Cause: dmFkZTG2x+fmVe1u3q1UMO2DJGr/wKRPxmumDxQSltjoBWMsrInNZrpiA6CujEDhow3JJG
    JNEztDN3yS45hchXOtJQspAGV4GF3ne7uG+GH+URudl/dTkoT4kNB8e/27Xgvq02j/Wt2R
    Y5aFM1B8kkDz8/PuNh1eS1MlWptE6Mge7NXgtQMecUo5tHgBrMx/v2v3OJWV7gCSdp7Bwk
    JEMAkL0q1t7qnj+fRyRLpmm7+GNkO/if/FK1mpN4GZEiyz4Zli+cqjnwM1ZL/M2+MbNeQc
    FAoRNqFE+e2SFRdSotlZonm+b6QtIKllaLftj3MIpdKnEuyEOJQ6uJLOFZLDHAciyDRbL2
    0mkW6ufoLhpq6R6mKhvjTiYzJQDJJf3qkCmbeUvwj65dTCfvnDzioUnhfAu2SOCnqSdbZk
    RlWBZjj6n+3X4UFWDnROOvlv7MK8Po5exRmz6keK5wC8IBOA/Y6u17LF+JQrXCoX20jfKA
    CoNvuh9X4D0PhX8+vxESD78GlMZO7SrsyF6ZhBZvzurhHV/x3QUQle4lwEVGfcbkb3JbOv
    Osy9slIqTv0SBmXl11ZVmqKLZYjBahh2I0+3XOOIjCcHcd73t+N3cvRWo1ffz6gsLitf1w
    WNIdUia09u0JWQVNGMtiqTTlELIHrxnBu5AT51La9ptE6HmEM5anK0gtivNw
X-ME-Proxy: <xmx:JZ-aagv7z4wEVjPaDvrHpnKxJapWzrpwid82XAVbq9msTfCrY0tRMQ>
    <xmx:JZ-aamZDBLKqhnL1XnviMo4-M1IAO_S2H32UbFY3OnKDbLX3ycACWQ>
    <xmx:JZ-aattB_tNQr3O-4jDadWKq2C5uRDQTnJkr9l2eGyVG1R6kB0L3nQ>
    <xmx:JZ-aagF_5S2evRB_9Yjg1yXBvJk8HpmI9csi4jHzGeu_KERcckOyvQ>
    <xmx:JZ-aauVeBM4nad91Y8ik7Gaou_KRNKGh6W4vdiCBZMtynE_n3e_HLIoJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01d5dc43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:04 +0200
Subject: [PATCH 03/11] builtin/refs: rename "--ref-format=" to
 "--ref-storage="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-3-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage=" and keep the old name as an alias.

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
index 9063892651..823dbd72c0 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -9,7 +9,7 @@ git-refs - Low-level access to refs
 SYNOPSIS
 --------
 [synopsis]
-git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
+git refs migrate --ref-storage=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
 git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
@@ -97,8 +97,8 @@ OPTIONS
 
 The following options are specific to `git refs migrate`:
 
-`--ref-format=<format>`::
-	The ref format to migrate the ref store to. Can be one of:
+`--ref-storage=<format>`::
+	The ref storage format to migrate the ref store to. Can be one of:
 +
 include::ref-storage-format.adoc[]
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..b7faee5125 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1848,7 +1848,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"can either accept this as-is, in which case you won't be able to\n"
 			"store all remote references on disk. Or you can alternatively\n"
 			"migrate your repository to use the 'reftable' backend with the\n"
-			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"following command:\n\n    git refs migrate --ref-storage=reftable\n\n"
 			"Please keep in mind that not all implementations of Git support this\n"
 			"new format yet. So if you use tools other than Git to access this\n"
 			"repository it may not be an option to migrate to reftables.\n"));
diff --git a/builtin/refs.c b/builtin/refs.c
index 5cd21c25fe..deb9387375 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -10,7 +10,7 @@
 #include "refs/refs-internal.h"
 
 #define REFS_MIGRATE_USAGE \
-	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
+	N_("git refs migrate --ref-storage=<format> [--no-reflog] [--dry-run]")
 
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
@@ -44,9 +44,12 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 	enum ref_storage_format format;
 	unsigned int flags = 0;
 	struct option options[] = {
-		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
-			N_("specify the reference format to convert to"),
+		OPT_STRING_F(0, "ref-storage", &format_str, N_("format"),
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
+		usage(_("missing --ref-storage=<format>"));
 
 	format = ref_storage_format_by_name(format_str);
 	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 26a3655058..20545d9db8 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -144,7 +144,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
 			)
@@ -159,7 +159,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
@@ -186,7 +186,7 @@ do
 				test_commit 2 &&
 				test_commit 3 &&
 
-				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs migrate --dry-run --ref-storage=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
 				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
@@ -218,7 +218,7 @@ do
 			test_commit 2 &&
 			test_commit 3 &&
 
-			git refs migrate --ref-format=$to_format &&
+			git refs migrate --ref-storage=$to_format &&
 			git refs list >out &&
 			test_grep "refs/tags/1"	out &&
 			test_grep "refs/tags/2"	out &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 44ad24f16e..4f2ff725ce 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -42,7 +42,7 @@ test_migration () {
 		print_all_reflog_entries "$repo" >expect_logs
 	fi &&
 
-	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
+	git -C "$repo" refs migrate --ref-storage="$format" "$@" &&
 
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
@@ -77,7 +77,7 @@ test_expect_success "missing ref storage format" '
 	git init repo &&
 	test_must_fail git -C repo refs migrate 2>err &&
 	cat >expect <<-EOF &&
-	usage: missing --ref-format=<format>
+	usage: missing --ref-storage=<format>
 	EOF
 	test_cmp expect err
 '
@@ -86,7 +86,7 @@ test_expect_success "unknown ref storage format" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	test_must_fail git -C repo refs migrate \
-		--ref-format=unknown 2>err &&
+		--ref-storage=unknown 2>err &&
 	cat >expect <<-EOF &&
 	error: unknown ref storage format ${SQ}unknown${SQ}
 	EOF
@@ -107,7 +107,7 @@ do
 			test_when_finished "rm -rf repo" &&
 			git init --ref-storage=$from_format repo &&
 			test_must_fail git -C repo refs migrate \
-				--ref-format=$from_format 2>err &&
+				--ref-storage=$from_format 2>err &&
 			cat >expect <<-EOF &&
 			error: repository already uses ${SQ}$from_format${SQ} format
 			EOF
@@ -119,7 +119,7 @@ do
 			git init --ref-storage=$from_format repo &&
 			git -C repo worktree add wt &&
 			test_must_fail git -C repo refs migrate \
-				--ref-format=$to_format 2>err &&
+				--ref-storage=$to_format 2>err &&
 			cat >expect <<-EOF &&
 			error: migrating repositories with worktrees is not supported yet
 			EOF
@@ -211,7 +211,7 @@ do
 			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo refs migrate --dry-run \
-				--ref-format=$to_format >output &&
+				--ref-storage=$to_format >output &&
 			test_grep "Finished dry-run migration of refs" output &&
 			test_path_is_dir repo/.git/ref_migration.* &&
 			echo $from_format >expect &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 1adac7baed..5c26fc18be 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -94,7 +94,7 @@ test_expect_success 'status with mixed submodule ref storages' '
 	git init main &&
 	git -C main submodule add "file://$(pwd)/submodule" &&
 	git -C main commit -m "add submodule" &&
-	git -C main/submodule refs migrate --ref-format=$OTHER_FORMAT &&
+	git -C main/submodule refs migrate --ref-storage=$OTHER_FORMAT &&
 
 	# The main repository should use the default ref format now, whereas
 	# the submodule should use the other format.

-- 
2.55.0.1007.g17ff1f9808.dirty

