Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16388190664
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004565; cv=none; b=ea+PQG3hDo27WiekJsCgdEKRYioALdo4lD52H9WEoKS7IYoapNVC6g/9HC6u0G1/a2AIpWpJ/zxgpfkVYcq9aKsWrcf7BUkNo2QR8gdktBEpLLY8QTGNR9gpID34Uj8CGCNioqTcAqRUhj2zVeOxIk7gShcrstqFYBvNRtfNhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004565; c=relaxed/simple;
	bh=0Nf5AGtzCSFTmnaSVtirnCXKemBVTtwwPh9V8hDxbN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bVDQQ5S2rMoGaWjUqGGV9aGivl0kMIEocOJcswo/VOPxVzuy9m7vrzGlmTznkydmLoY0iXAV3oApgxmWgiS6iodtD4sxh9msxXyYmIXJcqcvN6tCWHcBHV2PeqIbTGIcIbG0o+ycQIVcibK8USS5Q3Y1yGpTeooUiF7mmKBFdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEjK0bWR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEjK0bWR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2827219f8f.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004561; x=1738609361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77K8kgoMDyRhMx8QhVVcok8ld6dm3mng1ayqE/yzTtc=;
        b=iEjK0bWRK2RchtGJ967udFV22eWXPG2JYoTSGolrWt7RHqk6adtGXmVsBOV+VH93m3
         thN/DAtrXDnC6PexTv4rOI/+eWqPBxGSe0Gpz5qLkzoUqHDnYFZE/NrD4nYlPzN2dzWl
         jFFjCUL1PLmhLSFmGg5I+DL4wDm32+LYFHH1YXbpgCCC+Xs6grYFe3DqORy63z2irZcJ
         2X+jy/QMAKwanZY8qUtJbwh7QvcAvs3rXlGaEEEMRK9WhDgmmTLE9EQYsJ9WYpb57muF
         9UriG4F1e4ktCH1M2OOwMdS4fhnvoFVhZpk3pnX0EEw4Z7vei9xaDPtrvvBXDOW5L7u+
         N/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004561; x=1738609361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77K8kgoMDyRhMx8QhVVcok8ld6dm3mng1ayqE/yzTtc=;
        b=XuxKmrmEyRNRdldnKrbSVOePSGxQKIHn8oZI9hcQq6TGqLltiqB50kI1Lu/fyXrJEB
         MD8xPedd4Ko2isYH8UZnFG8v/zbE7euCo4Q0DX0nsCRHiN+EI9hPl3IzDreMKR/QuYQ3
         jSGnQPAn5lll+nFf+YNOaaPQQhNBE6X5lwzeZGAQQqNxBW8h2rdbO5H7w1ef0wjfUSOz
         7Zowr17kSWdt2so8rZNO4QHoy7P1yVbhjO+W4UvVc/zBCnUDnKJmcM761LDn1vFyYKch
         w9dshYd7BjUNW99dEMjAJ1SpKEBESVulY1ea8GtpLcGrWAzgablhSwY164AZ7JYnkMQW
         mgTg==
X-Gm-Message-State: AOJu0YxYtnmoavybvNhbAQD9PbTbYChYdIk6nocAVuk7CtuQGYg0jKZ+
	bJmNoNfAPB2p709TiVoJjRAW0RdSkLXOjK9gG9P4Ch0kfrZVuV+I/ENIgg==
X-Gm-Gg: ASbGnctaW0cMUn5b7rveFIOlWGhwyQjYBzgKGAGevzD//F1CKiq9rHgZZM2lk6oiDk+
	W08aNTiIdtQTzH67i+QHZlAiCZYMLpHd6GHIkJWITOaga2mLk/lo+RkruGnrlMD9r91WpQPsLNx
	blbb9+GLx9LvlNYvYlcBY8hfiEhM+hSUU8ymhhh03xInDa6NsA7qNp+Zpxb4cKL49hWU/PbYAiZ
	LfyUp03KBaYlo3tL0MxlbZRYyPGa0OcL4LLMZS8mXe5WPiC06I0JpLg3EwJBQzm1ytQCnQa2B7/
	jBBhcg==
X-Google-Smtp-Source: AGHT+IFmKlyKVlePIeczZqGsz3iGdetftJGS5L6YfKmNTUfJ+KLCAjtz0qghWMo8w1BEel43TrKqzA==
X-Received: by 2002:a05:6000:1f81:b0:385:eb8b:3ec6 with SMTP id ffacd0b85a97d-38bf5674369mr39981440f8f.29.1738004560679;
        Mon, 27 Jan 2025 11:02:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0dfsm12179075f8f.63.2025.01.27.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:40 -0800 (PST)
Message-Id: <a4f3d1276861ff0b96e1ffe94b8ff6db1df24729.1738004555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:30 +0000
Subject: [PATCH v4 3/7] repack: add --name-hash-version option
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The new '--name-hash-version' option for 'git repack' is a simple
pass-through to the underlying 'git pack-objects' subcommand. However,
this subcommand may have other options and a temporary filename as part
of the subcommand execution that may not be predictable or could change
over time.

The existing test_subcommand method requires an exact list of arguments
for the subcommand. This is too rigid for our needs here, so create a
new method, test_subcommand_flex. Use it to check that the
--name-hash-version option is passing through.

Since we are modifying the 'git repack' command, let's bring its usage
in line with the Documentation's synopsis. This removes it from the
allow list in t0450 so it will remain in sync in the future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt |  9 ++++++++-
 builtin/repack.c             |  9 ++++++++-
 t/t0450/txt-help-mismatches  |  1 -
 t/t7700-repack.sh            |  6 ++++++
 t/test-lib-functions.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..5852a5c9736 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--name-hash-version=<n>]
 
 DESCRIPTION
 -----------
@@ -249,6 +251,11 @@ linkgit:git-multi-pack-index[1]).
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
 	containing the non-redundant packs.
 
+--name-hash-version=<n>::
+	Provide this argument to the underlying `git pack-objects` process.
+	See linkgit:git-pack-objects[1] for full details.
+
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84ae..5e7ff919c1a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,7 +39,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--name-hash-version=<n>]"),
 	NULL
 };
 
@@ -58,6 +60,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int name_hash_version;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -306,6 +309,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->name_hash_version)
+		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1203,6 +1208,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_INTEGER(0, "name-hash-version", &po_args.name_hash_version,
+				N_("specify the name hash version to use for grouping similar objects by path")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..c4a15fd0cb8 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -45,7 +45,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c4c3d1a15d9..b9a5759e01d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -777,6 +777,12 @@ test_expect_success 'repack -ad cleans up old .tmp-* packs' '
 	test_must_be_empty tmpfiles
 '
 
+test_expect_success '--name-hash-version option passes through to pack-objects' '
+	GIT_TRACE2_EVENT="$(pwd)/hash-trace.txt" \
+		git repack -a --name-hash-version=2 &&
+	test_subcommand_flex git pack-objects --name-hash-version=2 <hash-trace.txt
+'
+
 test_expect_success 'setup for update-server-info' '
 	git init update-server-info &&
 	test_commit -C update-server-info message
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab503..af47247f25f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1886,6 +1886,32 @@ test_subcommand () {
 	fi
 }
 
+# Check that the given subcommand was run with the given set of
+# arguments in order (but with possible extra arguments).
+#
+#	test_subcommand_flex [!] <command> <args>... < <trace>
+#
+# If the first parameter passed is !, this instead checks that
+# the given command was not called.
+#
+test_subcommand_flex () {
+	local negate=
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+
+	local expr="$(printf '"%s".*' "$@")"
+
+	if test -n "$negate"
+	then
+		! grep "\[$expr\]"
+	else
+		grep "\[$expr\]"
+	fi
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget

