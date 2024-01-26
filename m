Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5081EB3D
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289187; cv=none; b=XUNdxxLhdrKetXQ748jSNn19mOPp4swlSSgKj60DONYcdABvf4SYrgRpsYX0N7LGjiGUPoQ2qh+J6SyBAgH1m/YV69mxbwYOTKDnktOfRAarp+RVJVSoqIejyOxDLrXW95ApPwdfck5/+oFormqeJkl0R/OwVWwDLiuXbshZmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289187; c=relaxed/simple;
	bh=m4IM3M3fnzvHGTJIInUYW+mIddH+rgmR7zkVFDsVnPA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dKZOHJr+X8dWl9LW5aDi6OHPda30NsEUCFNQ/JEKxNE2jOU7MZTVhK0flAQyA6pxHuOVm+W9bk4cu9+ELzsPkwzOvudN7zeTCktFZbQiJe1gfYpBB95Mo2uVZ+vZnFfNYaKRMWB89ullS48vvr9MxmfagoDM6Sju4A8UEwTq+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp6qNihW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp6qNihW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso4883135e9.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289184; x=1706893984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Bg2/Wt0GmYkE9Durb96bgw18SOTtvXu9iXETYma0M=;
        b=Lp6qNihWHwI7aRWS0hsTWc+5ptt/WhfOsZW/a9Dyb1oZ7WqTZfhl9bOUF+K3vUJUNE
         1nPAbxgj9ojM7HlUHq10yFnKs2UE7VGaDmMR4GGiZM3dxbbrP9CUCMV4qfe/+cLnYl/T
         y/X74H/+1uqscXwNo6zyr9q39tnWFPCDueM/8VJCDhJY/pzNuEp6t9e8M/U+wx45JetS
         RQC2duUP+8i+w1rJluJXUs5wlNJnlzOsf1zMndrf07+7zo55rAYfgLkoJW5RWiJa+eOS
         pIS4IGy+P0jbjoaCRHvXEOPCLu92ApDg/rqFa4Ykq0NjaK/QlxILtdY7Qm/ynjiP54ar
         tbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289184; x=1706893984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8Bg2/Wt0GmYkE9Durb96bgw18SOTtvXu9iXETYma0M=;
        b=KSdwnnSvkT0cTC6V02wPIqveHuahPJZdmR6C2KIZyHKXfQLJuZV9J4iKG8xokqzMQd
         /Tee14eqBPjk+SdedKTD9C/KmxiG3u0/DILWCO/hpFJ9uuIkJGYOivsvJyqLnDD4VTIb
         MaYbFu1OcuwzhVbJqyPrbU1yeu9Rm0nl8LqZrUuuFs8Wed/KueRY02xCbSz/1GsU3JIb
         7VnvRjDoUUS2vyDXkCnnSjLZ1VAvBMloduH7MXJ09xWUtlvDfsdE97xuw7I5sBNuOXh5
         wza9V85AlznpJi2/iUCDg8v4LGIJrA+pztiiwsy7XRg11T3UI/qJeSO61o7lv7NvHK7f
         9gKA==
X-Gm-Message-State: AOJu0Yz5rhgH0L8thQ74Gx/GzpjnQvs+aRZBdipPp4V4XZ7O6emQq3X/
	CqGrdh++fVKkNQmgAL7xDuZ7FNZ2zs/YnBhGTe+eBhV6UedLPNlpvwyHGNtD
X-Google-Smtp-Source: AGHT+IE1JrvRBZZHF3XTvEISlgygUv1qUBmjERYsi8iZ/p+4FHCN5pt1l5wBZSpqgd920SF/hsXvVg==
X-Received: by 2002:a5d:5191:0:b0:33a:dfe1:9004 with SMTP id k17-20020a5d5191000000b0033adfe19004mr24961wrv.47.1706289183502;
        Fri, 26 Jan 2024 09:13:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020adfedcf000000b00336898daceasm1636194wro.96.2024.01.26.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:13:03 -0800 (PST)
Message-ID: <cce63c6465fb1e29252d7e0918e03ff0f08d37f4.1706289180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 17:13:00 +0000
Subject: [PATCH v2 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
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

git-index-pack has a --strict option that can take an optional argument
to provide a list of fsck issues to change their severity.
--fsck-objects does not have such a utility, which would be useful if
one would like to be more lenient or strict on data integrity in a
repository.

Like --strict, allow --fsck-objects to also take a list of fsck msgs to
change the severity.

Remove the "For internal use only" note for --fsck-objects, and document
the option. This won't often be used by the normal end user, but it
turns out it is useful for Git forges like GitLab.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt | 10 ++++++++--
 builtin/index-pack.c             |  5 +++--
 t/t5300-pack-object.sh           | 29 ++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index f7a98bbf9c8..916652d3b1b 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -96,8 +96,14 @@ default and "Indexing objects" when `--stdin` is specified.
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
---fsck-objects::
-	For internal use only.
+--fsck-objects[=<msg-ids>=<severity>...]::
+	Instructs index-pack to check for broken objects, but unlike `--strict`,
+	does not choke on broken links. If `<msg-ids>` is passed, it should be
+	a comma-separated list of `<msg-id>=<severity>` where `<msg-id>` and
+	`<severity>` are used to change the severity of `fsck` errors e.g.,
+	`--strict="missingEmail=ignore,badTagName=ignore"`. See the entry for
+	the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
+	more information on the possible values of `<msg-id>` and `<severity>`.
 +
 Die if the pack contains broken objects. If the pack contains a tree
 pointing to a .gitmodules blob that does not exist, prints the hash of
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1e53ca23775..519162f5b91 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] [--fsck-objects[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -1785,8 +1785,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
-			} else if (!strcmp(arg, "--fsck-objects")) {
+			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
+				fsck_set_msg_types(&fsck_options, arg);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 496fffa0f8a..a58f91035d1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,8 +441,7 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
-test_expect_success 'index-pack with --strict downgrading fsck msgs' '
-	test_when_finished rm -rf strict &&
+test_expect_success 'setup for --strict and --fsck-objects downgrading fsck msgs' '
 	git init strict &&
 	(
 		cd strict &&
@@ -457,12 +456,32 @@ test_expect_success 'index-pack with --strict downgrading fsck msgs' '
 
 		EOF
 		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
-		PACK=$(git pack-objects test <commit_list) &&
-		test_must_fail git index-pack --strict "test-$PACK.pack" &&
-		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+		git pack-objects test <commit_list >pack-name
 	)
 '
 
+test_with_bad_commit () {
+	must_fail_arg="$1" &&
+	must_pass_arg="$2" &&
+	(
+		cd strict &&
+		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"
+		git index-pack "$must_pass_arg" "test-$(cat pack-name).pack"
+	)
+}
+
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_with_bad_commit --strict --strict="missingEmail=ignore"
+'
+
+test_expect_success 'index-pack with --fsck-objects downgrading fsck msgs' '
+	test_with_bad_commit --fsck-objects --fsck-objects="missingEmail=ignore"
+'
+
+test_expect_success 'cleanup for --strict and --fsck-objects downgrading fsck msgs' '
+	rm -rf strict
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget
