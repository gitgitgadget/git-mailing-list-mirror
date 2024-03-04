Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133127BAF3
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592724; cv=none; b=BwFB6uMQe222bVo/UQZEd9dazSjN8+W2PaHF7z3pNYLmGWW36eKguFiuj/Zsrg/QVAFzPHKfTCBUTLGRvflqhe1M4mAZ7teqQ7+6X2PDi5dyQBUFTf2DKKDb8b7vF+xPn3vqCJgeiauLow2rfJam//zJLl1Oqg9hXzRTrljeRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592724; c=relaxed/simple;
	bh=I7RjA4s+12ndD5O8Y4zXTXwDyGGpCRgtAh/fLOBVUyA=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B5QbsOTce6flIPF+HvUpsygRgXDCkFv+m48RRTh2iAG7hsKM6GHSWT2NCqWrK6ktOmm8pji+3VXv2cRPi5nSh1DLmpA9E+LVhJBSmPf840NsetVY/eo3hoBCBzwOsMwWC/h3hF6YnaHoyMWaz7LltdNTttjC/xCPVqqKLz5UZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRUQcQuw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRUQcQuw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so36363f8f.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 14:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592720; x=1710197520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9RdDtKCdsDAx7+oK7RBpBxTr4w6FP/DfxB3mqW+YbFA=;
        b=CRUQcQuwydYHz6Z1TM9ygfQe/N0UMVvl4kAw5+mFhnQoAVZ+GmDFBCJ4bKV1/DveDr
         30Q13SWKPjXjEPlv2eVGfm8FT8rFWqxnA0Hev/c2WIKhql4gIVMavSq9AaIoOaVqMVbq
         6qtTeSsbj7/H1ZGf8/N0x5xqVC/AjbgA/9UadkKH7+chJiIlGUGOru5nDt39Y+XLKvav
         AciB8DfQq2y23r8+Ucb+k4gdLej55YowZViygwbb8aQMMkG41megg8Op7Y58WWi104LO
         BJpJpI5ep8pz8ccAtVu2dfDh/v4GJ98hV5DAEbQdBkaJA5ZSetwvmrn5+gSu/EdbJ5h+
         Bxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592720; x=1710197520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RdDtKCdsDAx7+oK7RBpBxTr4w6FP/DfxB3mqW+YbFA=;
        b=R5e/hDMoS0lDsdVT8UuiVA+FfzrYXdQggBuu9SeYAvI3bUoP6xqRMvUNRBaiJVyA4V
         Cf7vvQoEf12EN8T8QbdN8CWJUvoBuqT9QQxwWC4KEY+2KHUoVMJSeZ9oZKtOBuTHQ/8e
         PabNEF8icqVygOLwGTUsTbO8Wbr9MEJ4CEudSN0QFSblDrrLcl1dO0MRGVwLMt8RnTfw
         u6YJQU0P0pZSg+xUFtPZMoDirtJex+1AYNLgGLiqOEVGdpkn38wGV2Kv2d2ZxwV2pInR
         02Yr6IteOJVZNawYGGkOTFgOdOG9JS+JYlp7YxTEalf2XvooCMAmKwYvGQxESyMnB7cv
         KmAQ==
X-Gm-Message-State: AOJu0YxYo5yJSwChoRXFCKF2tiIZW6Eu79vCk4hoWGk4LddDIXauOr/w
	Iu9oLFm3tYllbj9xf7F3mEwqXkz9Y5jeQLN6Ezm4ShHt7gVRRw69jBjJRnIq
X-Google-Smtp-Source: AGHT+IHDHTmL88xv4yKqN6qHYOooKnjaNLB3RWh4CNMzDzFKB/EN/ofvtMiJzZMtGMDc6pivAYrE4Q==
X-Received: by 2002:adf:b649:0:b0:33e:1f2b:a468 with SMTP id i9-20020adfb649000000b0033e1f2ba468mr7141640wre.24.1709592719712;
        Mon, 04 Mar 2024 14:51:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3-20020adfa4c3000000b0033dd2a7167fsm13404733wrb.29.2024.03.04.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:51:59 -0800 (PST)
Message-ID: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 22:51:58 +0000
Subject: [PATCH] show-ref: add --unresolved option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

For reftable development, it would be handy to have a tool to provide
the direct value of any ref whether it be a symbolic ref or not.
Currently there is git-symbolic-ref, which only works for symbolic refs,
and git-rev-parse, which will resolve the ref. Let's add a --unresolved
option that will only take one ref and return whatever it points to
without dereferencing it.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    show-ref: add --unresolved option
    
    For reftable development, it would be handy to have a tool to provide
    the direct value of any ref whether it be a symbolic ref or not.
    Currently there is git-symbolic-ref, which only works for symbolic refs,
    and git-rev-parse, which will resolve the ref. Let's add a --unresolved
    option that will only take one ref and return whatever it points to
    without dereferencing it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1684%2Fjohn-cai%2Fjc%2Fshow-ref-direct-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1684/john-cai/jc/show-ref-direct-v1
Pull-Request: https://github.com/git/git/pull/1684

 Documentation/git-show-ref.txt |  8 ++++++
 builtin/show-ref.c             | 33 ++++++++++++++++--------
 t/t1403-show-ref.sh            | 47 ++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ba757470059..2f9b4de1346 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=<pattern>]
 'git show-ref' --exists <ref>
+'git show-ref' --unresolved <ref>
 
 DESCRIPTION
 -----------
@@ -76,6 +77,13 @@ OPTIONS
 	it does, 2 if it is missing, and 1 in case looking up the reference
 	failed with an error other than the reference being missing.
 
+--unresolved::
+
+	Prints out what the reference points to without resolving it. Returns
+	an exit code of 0 if it does, 2 if it is missing, and 1 in case looking
+	up the reference failed with an error other than the reference being
+	missing.
+
 --abbrev[=<n>]::
 
 	Abbreviate the object name.  When using `--hash`, you do
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1c15421e600..58efa078399 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,6 +18,7 @@ static const char * const show_ref_usage[] = {
 	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=<pattern>]"),
 	N_("git show-ref --exists <ref>"),
+	N_("git show-ref --unresolved <ref>"),
 	NULL
 };
 
@@ -220,11 +221,11 @@ static int cmd_show_ref__patterns(const struct patterns_options *opts,
 	return 0;
 }
 
-static int cmd_show_ref__exists(const char **refs)
+static int cmd_show_ref__raw(const char **refs, int show)
 {
-	struct strbuf unused_referent = STRBUF_INIT;
-	struct object_id unused_oid;
-	unsigned int unused_type;
+	struct strbuf referent = STRBUF_INIT;
+	struct object_id oid;
+	unsigned int type;
 	int failure_errno = 0;
 	const char *ref;
 	int ret = 0;
@@ -236,7 +237,7 @@ static int cmd_show_ref__exists(const char **refs)
 		die("--exists requires exactly one reference");
 
 	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
-			      &unused_oid, &unused_referent, &unused_type,
+			      &oid, &referent, &type,
 			      &failure_errno)) {
 		if (failure_errno == ENOENT || failure_errno == EISDIR) {
 			error(_("reference does not exist"));
@@ -250,8 +251,16 @@ static int cmd_show_ref__exists(const char **refs)
 		goto out;
 	}
 
+		if (!show)
+			goto out;
+
+		if (type & REF_ISSYMREF)
+			printf("ref: %s\n", referent.buf);
+		else
+			printf("ref: %s\n", oid_to_hex(&oid));
+
 out:
-	strbuf_release(&unused_referent);
+	strbuf_release(&referent);
 	return ret;
 }
 
@@ -284,11 +293,12 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	struct exclude_existing_options exclude_existing_opts = {0};
 	struct patterns_options patterns_opts = {0};
 	struct show_one_options show_one_opts = {0};
-	int verify = 0, exists = 0;
+	int verify = 0, exists = 0, unresolved = 0;
 	const struct option show_ref_options[] = {
 		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with heads)")),
 		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can be combined with tags)")),
 		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),
+		OPT_BOOL(0, "unresolved", &unresolved, N_("print out unresolved value of reference")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
 		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
@@ -314,16 +324,17 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
 
-	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-existing",
+	die_for_incompatible_opt4(exclude_existing_opts.enabled, "--exclude-existing",
 				  verify, "--verify",
-				  exists, "--exists");
+				  exists, "--exists",
+				  unresolved, "--unresolved");
 
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
-	else if (exists)
-		return cmd_show_ref__exists(argv);
+	else if (exists || unresolved)
+		return cmd_show_ref__raw(argv, unresolved);
 	else
 		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 33fb7a38fff..11811201738 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -218,6 +218,16 @@ test_expect_success 'show-ref sub-modes are mutually exclusive' '
 	test_must_fail git show-ref --exclude-existing --exists 2>err &&
 	grep "exclude-existing" err &&
 	grep "exists" err &&
+	grep "cannot be used together" err &&
+
+	test_must_fail git show-ref --exclude-existing --unresolved 2>err &&
+	grep "exclude-existing" err &&
+	grep "unresolved" err &&
+	grep "cannot be used together" err &&
+
+	test_must_fail git show-ref --verify --unresolved 2>err &&
+	grep "verify" err &&
+	grep "unresolved" err &&
 	grep "cannot be used together" err
 '
 
@@ -286,4 +296,41 @@ test_expect_success '--exists with existing special ref' '
 	git show-ref --exists FETCH_HEAD
 '
 
+test_expect_success '--unresolved with existing reference' '
+	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
+	cat >expect <<-EOF &&
+	ref: $commit_oid
+	EOF
+	git show-ref --unresolved refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--unresolved with symbolic ref' '
+	test_when_finished "git symbolic-ref -d SYMBOLIC_REF_A" &&
+	cat >expect <<-EOF &&
+	ref: refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+	EOF
+	git symbolic-ref SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	git show-ref --unresolved SYMBOLIC_REF_A >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--unresolved with nonexistent object ID' '
+	oid=$(test_oid 002) &&
+	test-tool ref-store main update-ref msg refs/heads/missing-oid-2 $oid $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	cat >expect <<-EOF &&
+	ref: $oid
+	EOF
+	git show-ref --unresolved refs/heads/missing-oid-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--unresolved with nonexistent reference' '
+	cat >expect <<-EOF &&
+	error: reference does not exist
+	EOF
+	test_expect_code 2 git show-ref --unresolved refs/heads/not-exist 2>err &&
+	test_cmp expect err
+'
+
 test_done

base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
-- 
gitgitgadget
