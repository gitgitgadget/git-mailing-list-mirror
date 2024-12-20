Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59386226549
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715204; cv=none; b=smwVEWUS4GsKJNoLPjn9O2I1CYiw7lBk45XSwBgd3CiEClSEe8r115tTFpQNXKi7Jf+A5FmYdBIuplbYjBRP2eqg+XylLxw47s8EAfvosTJKigQtzXovN7cz3TGGoXxTHn/NeEkZBpxQwYYO572xvMfWEf/pXCkyL7g0ONPKBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715204; c=relaxed/simple;
	bh=0Nf5AGtzCSFTmnaSVtirnCXKemBVTtwwPh9V8hDxbN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RzmPoN3LalteDAPopgIRB1fFgUUi7IQ8djdWZfhvN9eT7ShuGtO4btD/6Gp2TRt9kVZz48W2d94gLx7H/+gEd6B19wsJNHJ/+IUMmPgRcklfODcO4SU1zXOhFznHBgz9A0TOQPRDsnRwQ6vtKPV2d//aa+ZkJGtpEWvGjQOgJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grCB3Ufj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grCB3Ufj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so23545855e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715200; x=1735320000; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77K8kgoMDyRhMx8QhVVcok8ld6dm3mng1ayqE/yzTtc=;
        b=grCB3Ufjqf4EVRKGIpCpRrobBIInk8WVuHTCAMIMD8r+rw4seJOJctOEHXP7+534W3
         wa9I8oqq3aI5MxfDFrvS3xO+LTo014nE15zEWN7M1fNAJNr5OR8wJYHPL2ldxvfxpst3
         CCG0OPcdxIDsWDdMllRDqgHA/riHoAHbX5fJB+zylxcGKM4jF3DwCo5zgrBcbwQtPKWn
         YIf3pR6TwI9qEvQhLy4v89AnZD1W9V8vPLt98sOwoz4X/f7A1NywmvvMyW+9P8eWUDHV
         pTD5pIfPoPKiuRco3iaWxXA4tvkBR+NSe2wQMW+eAzp/8vzUyYqTWkh6DvtqavRR/an6
         HV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715200; x=1735320000;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77K8kgoMDyRhMx8QhVVcok8ld6dm3mng1ayqE/yzTtc=;
        b=k/wW4iSC2gIcWoUJu0OFg6TzsTzZdFFDXG9Rlmc3FkBQY/fns5SI83gsChET9f4AYz
         h3n/WN9dFxS9NFbiSvXbaLi7uttIB51LjaP1cyiuS3JCmaHlhT1F+trZaOrJ7vanVSpS
         YvnW2d8zsesX6MjCctkGRpihgIuPCy6xLFYB3uaVa8iN8g7pfno70KZr2/JKWyMnxf5x
         XgPpvlcQSZhJBCl+RhU5WA2ejtaX2IVOxk3jdhL5zrXazxGGj5k1n+h62buYKHMfwiZ7
         XJ3j0JogkMf+u8dRNDhfm+l3GSeib6t8J7UdK48KaRAHApHRn5HGcWQ5Z5bq6xBJagx4
         HwOg==
X-Gm-Message-State: AOJu0YyLvHv4DaLN4d63hT7mUrbambeI3Ohsyjglu8/Qmd77AsN5ynNd
	eFUOAy5rcnH3rei62LQnzFsdYmTfN83IPjg60MQfUD22vr0MVbFP4JISjQ==
X-Gm-Gg: ASbGnctVGtgdfFpqKshcyhumAIPHR6+BcqTddVIATp8fGZ2B54nREsjciKcx1LXqcAQ
	ScOG9Iv6dCuVmrH0jkAfv31cQ7g/HWVoq+PP5135NKLqemCjgrj7qp6iF4NEOFDatOHS6A8rY/i
	iJ4m5NSgYBk8iXkSOCde7UzuU9QpsFJKD88BviEBDDH5Moxl+nbcsg+ng6HopQcQbhIMUHiQMkQ
	VVWKCtgBPJ7Th1Ce78zNieHx1zLZ4qtw4h95azHINoxSFv+vhz/HmzHSA==
X-Google-Smtp-Source: AGHT+IFLpmzzhcrjZ2G7CFh0YpdbeVG5znCHi9s32rAz2JcmlH+EFJTWJ3QcyPhZghcTHJ68HIVFFw==
X-Received: by 2002:a05:6000:1846:b0:385:e88a:7037 with SMTP id ffacd0b85a97d-38a221e27afmr3609903f8f.6.1734715200170;
        Fri, 20 Dec 2024 09:20:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ac974sm4475728f8f.91.2024.12.20.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:19:59 -0800 (PST)
Message-Id: <e2191244f6b21792f2551946a89cfc48af3989c5.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:49 +0000
Subject: [PATCH v3 3/8] repack: add --name-hash-version option
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

