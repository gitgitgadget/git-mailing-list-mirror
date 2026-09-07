Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944A46D2B1
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780016; cv=none; b=Ib89bRAhlYb8HiDeOAR1bqQnQKzYt47DcLftcbzIAv56K04wUpUATpjP2pPLvA0c6GHESu7+c9bFCoZFduZNP7skCJe3gVRcwDa5nuknfM3w0cBRGt4okmgjh4jDgXZ3cvTND4c6YHHJ9ZF9S/WrCAvRC0NCIERVxCQC2L+KafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780016; c=relaxed/simple;
	bh=6GpUfYfKCevQd8ydZj0vlMFrtRQZUxFwnW9HjdLyDmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQTJePa4yf9mDj+2astsr0jHUl/0YYdJSyEXZNvsj3J+Wa1Ck22kZ29bYOXpABF/j7aL0Wj1sapGIynKpQ4A8VGC8nu7prEZgO/E4XCviyxSTI62DIzVY3/V/GKFjHlTTYLSoIs1OxFnrJhghnOHq/phAGUgIjIaiFGC3+JORaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qAkvKCJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9FA8N9x; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qAkvKCJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9FA8N9x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 09E5EEC0230;
	Mon,  7 Sep 2026 07:20:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 07:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780013;
	 x=1788866413; bh=JcodnueiaFL9X//KINcV44QaVToP41Cp33jeN1Ah8WI=; b=
	qAkvKCJcGkVuvyaudhCT5Fj1PWZE/llrSJ2XAl8tdYiVs3QhxXpoh6bq/epWjo/J
	pg8DC4rlb/ScF4T0x4dBOdouIYf2q4PAIjXiv78aDvZVUJUHG/49gneFz44Awwyw
	yFTMmTEX4nPwx7b4TrtF2YotUAI7NxYyZJG6d9ymXYYIDWOtN9N8frmqqp540JN6
	bE7Z1vTMOav8QAK2aN3WjN0gC2fCHCkGhewIR7po7WZ+D/FTacvHBv4m5opelxGH
	Sb0fc4SYshWSI11Z1xRwvSR/eRQ7RM5VqKymeATndBUyx8dZpEF1nsLQCfqnoo68
	JOjoFGUmFzB4bmCSF/1c9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780013; x=
	1788866413; bh=JcodnueiaFL9X//KINcV44QaVToP41Cp33jeN1Ah8WI=; b=v
	9FA8N9xaTg7DuZ9FZAjPwvGb1fratN6QDAyzde+Kt6tXh+UpAL8MgVwLbnKkg1VY
	vBmI2VN4XwCNAj7vJCiQBR19Fm0CYwwTlSvD9rS/JlEgEk+jK5NRbH6idH1q5UJ3
	Nualn2IeRUPNVBoDWathWMUcjydeI9y72aZH6BgEGPHkqX7eFQcyia/AoQK0H2vD
	qfgjPmK6Qps9bsJHmG7aWcpDM+UfpT7AT+LlJemVYRQbQiP56RCuAwVAbIBz4Kny
	0TXmnkO5Hifla6JG1+M6i5g+hKBxdYyj3MPYCyYOeKf2wKaO9TV46ebgltd289Wp
	inhsFSbbvAmSrYjrnEUVA==
X-ME-Sender: <xms:7J2eaqTDhdkDQh_QMUZjqewr5UQKalTqxCoZdil0l-2mE08BTlcn8w>
    <xme:7J2eanOcuxBjbmcl-iRjoTVhC2Fdgz02nzMF3rRcAyuH91SwvDZw6ZnmRoDOIuZ8p
    gLgSoYA91Vy9AkDgfPW2Ht0BPVntgKYxMYZQvPxD4n5VXkmXqoRhg>
X-ME-Received: <xmr:7J2ealP38tbkOBqa95faqAoPmmI24mxbqLrPPncoMp1dwZqZVr-4xg>
X-ME-Proxy-Cause: dmFkZTE4kwiwYwdPahxNPOJ07P64Nkj0zVbnSUY2LvxIt3z93vq7MJG3IovEN/+zfqFwQj
    SQU/HV3s0aNszXxjeKm+8KsB84CHl/P+859r10k3kkusZCiPpZ2vkCmOIA3b0Yv0iGpEk3
    hBQN59Vlps349F9gWOpO/QM5lRmPyu7RZnOj71jheOLKTY50TdMoMvRo/PRQg+mQLrVM3v
    JNk0yJHeyDSW5462ACohQTBguuayVk56QwRLi1TXL82G0uUYs3Mb/PprkCc4KB6YSXlVSE
    IIWdx1WWTGVxlBQqSYDqDfzLwiK9TjcH3MySVHfso5s026UzJbgKxs6Ec0Pvtz2ZL7qwTv
    ouH7qU0LwK8UullzLzMrnuP0uyete9URd2jVumfgUhgFxJzYgsWDA5Ou5uYjVeZwjgZZJW
    YL9QNjWfbKm+FzTP28hW1hUWqDmBs4Nr3k7cESNQ4QFb/g3kLuvzBd1LE/6TngArjomnOl
    QLJOo+28Ybbb2aGM8jHzF+DhGQ5dPOt+43h0BuTRIRCWbD0psgNCvBndGDcyIMxz3dRMLn
    /zKwQdkxOp7YXZPIi8SvTJ2zZisK9fAXkzezc5RS2ns3F30i8Q6YyLJJ5LYoMhX3MgZL7V
    44e3AIec1Gl830f3AICk3zPyh2j9gyv8ngnDa+U9A9wPI/PKox0wxEuLgrPg
X-ME-Proxy: <xmx:7J2eavtj9rIoS4c82F13lltruh2ZsDerDLBry0MO0mcN7hvnQ_R3FQ>
    <xmx:7J2eanWPgdCljPuIIC8HnghGAhb4VQlNpIPn1EhFRmOxnICTpKLozw>
    <xmx:7J2eavuzeu6cJ7C13MqV6WjgS0sW7W6zWBIb2T3pmy3P8vcBidHd5A>
    <xmx:7J2earUtKcsumiSQznuaRm-PD2i1e51EbmlU0kytGD0FnY_lgMwDNQ>
    <xmx:7Z2eanM0i1wBeCrRTS9QQFvwIJ-2lAUCM5JLdduj60zT4oG5rvpORssU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aa574f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:35 +0200
Subject: [PATCH v2 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-1-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Back when we gained support for reftables we of course introduced the
ability to control the reference storage format that is used by newly
created repositories. This infrastructure has grown over time, and
unfortunately without consistency:

  - The command line parameter to specify the ref storage format is
    called "--ref-format=", while the corresponding repository extension
    is called "refStorage".

  - In most cases we refer to the "ref storage format" in our docs, so
    calling it "--ref-format=" is being inconsistent with them.

  - It is possible to override the ref storage format via an environment
    variable that is called "GIT_REFERENCE_BACKEND", which is not even
    remotely consistent with anything else.

  - There is also an "object format", but that format does not control
    how we store objects but rather whether we use SHA1 or SHA256.

So in summary, it's a huge mess.

This problem is about to become even worse though, as we're soon going
to introduce an object storage extension. This extension is the
equivalent to the ref storage extension, and of course we also want
users to be able to control which object storage format new repositories
are using. But we cannot properly name that parameter without creating
even more inconsistencies:

  - "--object-format=" would match "--ref-format=", but that parameter
    name is already taken to specify the hash function.

  - "--object-storage=" would be a good fit, but be inconsistent with
    "--ref-format=". Asking the user to execute `git init --ref-format=
    --object-storage=` just feels extremely awkward.

Instead, this and subsequent patches will fix the mess by consistently
referring to the ref storage format as such throughout all options,
environment variables and config settings. This new name much more
closely indicates that it is about how we store data and finally brings
consistency into this area. We will keep the old names working of course
for the sake of backwards compatibility.

Start with git-init(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc         |  2 +-
 Documentation/git-init.adoc            |  4 ++--
 Documentation/git.adoc                 |  2 +-
 builtin/init-db.c                      | 16 ++++++++-------
 t/perf/p1401-ref-store-tombstones.sh   |  4 ++--
 t/perf/perf-lib.sh                     |  2 +-
 t/t0001-init.sh                        | 24 +++++++++++------------
 t/t0610-reftable-basics.sh             | 14 ++++++-------
 t/t0611-reftable-httpd.sh              |  2 +-
 t/t1400-update-ref.sh                  |  2 +-
 t/t1423-ref-backend.sh                 |  6 +++---
 t/t1460-refs-migrate.sh                | 36 +++++++++++++++++-----------------
 t/t1900-repo-info.sh                   |  6 +++---
 t/t5510-fetch.sh                       |  8 ++++----
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 15 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index 7b4abdaf8b..a048f0bddc 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -15,7 +15,7 @@ endif::[]
 	this config.
 `init.defaultRefFormat`::
 	Allows overriding the default ref storage format for new repositories.
-	See `--ref-format=` in linkgit:git-init[1]. Both the command line
+	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
 	precedence over this config.
 
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index bab99b9b47..7e407d3ef1 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git init [-q | --quiet] [--bare] [--template=<template-directory>]
 	 [--separate-git-dir <git-dir>] [--object-format=<format>]
-	 [--ref-format=<format>]
+	 [--ref-storage-format=<format>]
 	 [-b <branch-name> | --initial-branch=<branch-name>]
 	 [--shared[=<permissions>]] [<directory>]
 
@@ -57,7 +57,7 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.adoc[]
 
-`--ref-format=<format>`::
+`--ref-storage-format=<format>`::
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..23ba65656e 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -593,7 +593,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_DEFAULT_REF_FORMAT`::
 	If this variable is set, the default reference backend format for new
 	repositories will be set to this value. The default is "files".
-	See `--ref-format` in linkgit:git-init[1].
+	See `--ref-storage-format` in linkgit:git-init[1].
 
 `GIT_REFERENCE_BACKEND`::
     Specify which reference backend to be used along with its URI.
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e96b1283b7..63f33154c0 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 static const char *const init_db_usage[] = {
 	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
 	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
-	   "         [--ref-format=<format>]\n"
+	   "         [--ref-storage-format=<format>]\n"
 	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
 	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
@@ -83,7 +83,7 @@ int cmd_init_db(int argc,
 	unsigned int flags = 0;
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
-	const char *ref_format = NULL;
+	const char *ref_storage_format_str = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
@@ -109,8 +109,10 @@ int cmd_init_db(int argc,
 			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
-		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_END()
 	};
 	int ret;
@@ -173,10 +175,10 @@ int cmd_init_db(int argc,
 			die(_("unknown hash algorithm '%s'"), object_format);
 	}
 
-	if (ref_format) {
-		ref_storage_format = ref_storage_format_by_name(ref_format);
+	if (ref_storage_format_str) {
+		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_format);
+			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
 	}
 
 	if (init_shared_repository != -1)
diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
index 9e3d8031aa..37ffe0c3a7 100755
--- a/t/perf/p1401-ref-store-tombstones.sh
+++ b/t/perf/p1401-ref-store-tombstones.sh
@@ -5,7 +5,7 @@ test_description="Tests performance of ref operations with many tombstones"
 . ./perf-lib.sh
 
 test_expect_success "setup" '
-	git init --ref-format=reftable repo &&
+	git init --ref-storage-format=reftable repo &&
 	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
 	for i in $(test_seq 8000)
 	do
@@ -24,7 +24,7 @@ test_perf "recreate refs after mass delete" '
 '
 
 test_expect_success "setup asymmetric" '
-	git init --ref-format=reftable repo2 &&
+	git init --ref-storage-format=reftable repo2 &&
 	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
 	for i in $(test_seq 8000)
 	do
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 2ac007888e..3ce49fd423 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -153,7 +153,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
+		"$MODERN_GIT" init -q --ref-storage-format="$refformat" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5cf2e5a35a..df9a2ff2da 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -696,9 +696,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "init with --ref-format=$format" '
+	test_expect_success "init with --ref-storage-format=$format" '
 		test_when_finished "rm -rf refformat" &&
-		git init --ref-format=$format refformat &&
+		git init --ref-storage-format=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -717,9 +717,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "--ref-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
+	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-format=$format refformat &&
+		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -735,9 +735,9 @@ do
 	'
 done
 
-test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
+test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
+	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
@@ -791,8 +791,8 @@ for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
 		test_when_finished "rm -rf refformat" &&
-		git init --ref-format=$from_format refformat &&
-		git init --ref-format=$from_format refformat &&
+		git init --ref-storage-format=$from_format refformat &&
+		git init --ref-storage-format=$from_format refformat &&
 		echo $from_format >expect &&
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
@@ -807,11 +807,11 @@ do
 
 		test_expect_success "re-init with different format fails ($from_format -> $to_format)" '
 			test_when_finished "rm -rf refformat" &&
-			git init --ref-format=$from_format refformat &&
+			git init --ref-storage-format=$from_format refformat &&
 			cat >expect <<-EOF &&
 			fatal: attempt to reinitialize repository with different reference storage format
 			EOF
-			test_must_fail git init --ref-format=$to_format refformat 2>err &&
+			test_must_fail git init --ref-storage-format=$to_format refformat 2>err &&
 			test_cmp expect err &&
 			echo $from_format >expect &&
 			git -C refformat rev-parse --show-ref-format >actual &&
@@ -820,12 +820,12 @@ do
 	done
 done
 
-test_expect_success 'init with --ref-format=garbage' '
+test_expect_success 'init with --ref-storage-format=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
 	fatal: unknown ref storage format ${SQ}garbage${SQ}
 	EOF
-	test_must_fail git init --ref-format=garbage refformat 2>err &&
+	test_must_fail git init --ref-storage-format=garbage refformat 2>err &&
 	test_cmp expect err
 '
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 35e98b43db..1cf96ce2c5 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -59,28 +59,28 @@ test_expect_success 'init: reinitializing reftable backend succeeds' '
 	test_commit -C repo A &&
 
 	git -C repo for-each-ref >expect &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage-format=reftable repo &&
 	git -C repo for-each-ref >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'init: reinitializing files with reftable backend fails' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage-format=files repo &&
 	test_commit -C repo file &&
 
 	cp repo/.git/HEAD expect &&
-	test_must_fail git init --ref-format=reftable repo &&
+	test_must_fail git init --ref-storage-format=reftable repo &&
 	test_cmp expect repo/.git/HEAD
 '
 
 test_expect_success 'init: reinitializing reftable with files backend fails' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage-format=reftable repo &&
 	test_commit -C repo file &&
 
 	cp repo/.git/HEAD expect &&
-	test_must_fail git init --ref-format=files repo &&
+	test_must_fail git init --ref-storage-format=files repo &&
 	test_cmp expect repo/.git/HEAD
 '
 
@@ -163,7 +163,7 @@ test_expect_success 'clone: can clone reftable repository' '
 
 test_expect_success 'clone: can clone reffiles into reftable repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
-	git init --ref-format=files reffiles &&
+	git init --ref-storage-format=files reffiles &&
 	test_commit -C reffiles A &&
 	git clone --ref-format=reftable ./reffiles reftable &&
 
@@ -182,7 +182,7 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 
 test_expect_success 'clone: can clone reftable into reffiles repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
-	git init --ref-format=reftable reftable &&
+	git init --ref-storage-format=reftable reftable &&
 	test_commit -C reftable A &&
 	git clone --ref-format=files ./reftable reffiles &&
 
diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
index 5e05b9c1f2..b030814b9f 100755
--- a/t/t0611-reftable-httpd.sh
+++ b/t/t0611-reftable-httpd.sh
@@ -10,7 +10,7 @@ start_httpd
 REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
 
 test_expect_success 'serving ls-remote' '
-	git init --ref-format=reftable -b main "$REPO" &&
+	git init --ref-storage-format=reftable -b main "$REPO" &&
 	cd "$REPO" &&
 	test_commit m1 &&
 	>.git/git-daemon-export-ok &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 269fdaa3ed..1a164c96f9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2361,7 +2361,7 @@ do
 	'
 
 	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
-		git init --ref-format=reftable repo &&
+		git init --ref-storage-format=reftable repo &&
 		test_when_finished "rm -fr repo" &&
 		(
 			cd repo &&
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index fd47d77e8e..9ae295cf3d 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -137,7 +137,7 @@ do
 
 		test_expect_success "$method: read from $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
@@ -152,7 +152,7 @@ do
 
 		test_expect_success "$method: write to $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
@@ -179,7 +179,7 @@ do
 
 		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo wt" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			(
 				cd repo &&
 				test_commit 1 &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 8f42697143..bb2507f571 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -105,7 +105,7 @@ do
 
 		test_expect_success "$from_format: migration to same format fails" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_must_fail git -C repo refs migrate \
 				--ref-format=$from_format 2>err &&
 			cat >expect <<-EOF &&
@@ -116,7 +116,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			git -C repo worktree add wt &&
 			test_must_fail git -C repo refs migrate \
 				--ref-format=$to_format 2>err &&
@@ -128,20 +128,20 @@ do
 
 		test_expect_success "$from_format -> $to_format: unborn HEAD" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_migration repo "$to_format"
 		'
 
 		test_expect_success "$from_format -> $to_format: single ref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			test_migration repo "$to_format"
 		'
 
 		test_expect_success "$from_format -> $to_format: bare repository" '
 			test_when_finished "rm -rf repo repo.git" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git clone --ref-format=$from_format --mirror repo repo.git &&
 			test_migration repo.git "$to_format"
@@ -149,7 +149,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: dangling symref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo symbolic-ref BROKEN_HEAD refs/heads/nonexistent &&
 			test_migration repo "$to_format" &&
@@ -160,7 +160,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: broken ref" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
 				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERIFICATION &&
@@ -172,7 +172,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: pseudo-refs" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo update-ref FOO_HEAD HEAD &&
 			test_migration repo "$to_format"
@@ -180,7 +180,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: special refs are left alone" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo rev-parse HEAD >repo/.git/MERGE_HEAD &&
 			git -C repo rev-parse MERGE_HEAD &&
@@ -190,7 +190,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: a bunch of refs" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 
 			test_commit -C repo initial &&
 			cat >input <<-EOF &&
@@ -208,7 +208,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: dry-run migration does not modify repository" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo refs migrate --dry-run \
 				--ref-format=$to_format >output &&
@@ -221,7 +221,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: reflogs of symrefs with target deleted" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			git -C repo branch branch-1 HEAD &&
 			git -C repo symbolic-ref refs/heads/symref refs/heads/branch-1 &&
@@ -234,7 +234,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: reflogs order is retained" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit --date "100005000 +0700" --no-tag -C repo initial &&
 			test_commit --date "100003000 +0700" --no-tag -C repo second &&
 			test_migration repo "$to_format"
@@ -242,7 +242,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: stash is retained" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			(
 				cd repo &&
 				test_commit initial A &&
@@ -259,7 +259,7 @@ do
 
 		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
 			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
+			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
 			# we see that the repository contains reflogs.
 			git -C repo reflog --all >reflogs &&
@@ -274,7 +274,7 @@ done
 
 test_expect_success 'multiple reftable blocks with multiple entries' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage-format=files repo &&
 	test_commit -C repo first &&
 	test_seq -f "create refs/heads/ref-%d HEAD" 5000 |
 	git -C repo update-ref --stdin &&
@@ -286,7 +286,7 @@ test_expect_success 'multiple reftable blocks with multiple entries' '
 
 test_expect_success 'migrating from files format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=files repo &&
+	git init --ref-storage-format=files repo &&
 	test_commit -C repo first &&
 	git -C repo pack-refs --all &&
 	test_commit -C repo second &&
@@ -313,7 +313,7 @@ test_expect_success 'migrating from files format deletes backend files' '
 
 test_expect_success 'migrating from reftable format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
-	git init --ref-format=reftable repo &&
+	git init --ref-storage-format=reftable repo &&
 	test_commit -C repo first &&
 
 	test_path_is_dir repo/.git/reftable &&
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..d115d2d9f9 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -39,10 +39,10 @@ test_repo_info () {
 }
 
 test_repo_info 'ref format files is retrieved correctly' \
-	'git init --ref-format=files' 'format-files' 'references.format' 'files'
+	'git init --ref-storage-format=files' 'format-files' 'references.format' 'files'
 
 test_repo_info 'ref format reftable is retrieved correctly' \
-	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
+	'git init --ref-storage-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
 test_repo_info 'bare repository = false is retrieved correctly' \
 	'git init' 'nonbare' 'layout.bare' 'false'
@@ -75,7 +75,7 @@ test_expect_success 'values returned in order requested' '
 	references.format=files
 	layout.bare=false
 	EOF
-	git init --ref-format=files ordered &&
+	git init --ref-storage-format=files ordered &&
 	git -C ordered repo info layout.bare references.format layout.bare >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..359c3cf99b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1803,7 +1803,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 test_expect_success REFFILES 'existing reference lock in repo' '
 	test_when_finished rm -rf base repo &&
 	(
-		git init --ref-format=reftable base &&
+		git init --ref-storage-format=reftable base &&
 		cd base &&
 		echo >file update &&
 		git add . &&
@@ -1814,7 +1814,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git update-ref refs/heads/branch @ &&
 		cd .. &&
 
-		git init --ref-format=files --bare repo &&
+		git init --ref-storage-format=files --bare repo &&
 		cd repo &&
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
@@ -1857,7 +1857,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
 	test_when_finished rm -rf base repo &&
 	(
-		git init --ref-format=reftable base &&
+		git init --ref-storage-format=reftable base &&
 		cd base &&
 		echo >file update &&
 		git add . &&
@@ -1868,7 +1868,7 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 		git update-ref refs/heads/branch @ &&
 		cd .. &&
 
-		git init --ref-format=files --bare repo &&
+		git init --ref-storage-format=files --bare repo &&
 		cd repo &&
 		git remote add origin ../base &&
 		mkdir refs/heads/foo &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 559713b607..1ca245c732 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -31,7 +31,7 @@ test_expect_success 'add existing repository with different ref storage format'
 	(
 		cd parent &&
 		test_commit parent &&
-		git init --ref-format=$OTHER_FORMAT submodule &&
+		git init --ref-storage-format=$OTHER_FORMAT submodule &&
 		test_commit -C submodule submodule &&
 		git submodule add ./submodule
 	)

-- 
2.55.0.1007.g17ff1f9808.dirty

