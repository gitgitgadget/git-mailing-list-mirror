Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234322F0E
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302757; cv=none; b=Jdu7i0oxUJa+5lA+xrt52sd6Bjwdx6ayHd2Xjx1gJw7fRl9/lE7bpZ+qxPj+LMKf6wTJn99onphoIK0Us3qiVvDedaxUR5K2FanM9DOxGrvhMwO4Om72RRzSiHEuW/gUpVz9NQDqQQ57OmvbBj3n34Pnci6F7dipBLd0SeBWnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302757; c=relaxed/simple;
	bh=lnh/YOrT7wA1kF+3AlMSzwgqPiJP2NLkduTyRV5DyN0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MAmMFneOOvxDJzHFpIpO6ycNhyXy2DDtRMHLOFyloyLVp01NFgsGykEI6JbS09Csnuf18UDlizr7cntO3NpWaahP2yvnrTZINrrzlPddsDO2Uk35kWYGlr0JFon1oGuD8c0VmaphaAzVc9tGCFD5O6VJu2LoolzySrciprbG4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyzmFw/5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyzmFw/5"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392291b21bso1113631f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302753; x=1706907553; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7NKk6TD50k4Nb2NhK/PPxDQh3iGT4oBhRr2M3b5fwg=;
        b=DyzmFw/5s6zTGpu707PsRC/fUz5pCIKAQ/z+atWok70qNE/esx3E99HfRXpeDyebPg
         tVaZk+u+wIXhWyyCYcApNRUdgPgFJdQhz56Ci0Xp/pkwmADXJwmTen/zPblqAWNamOQH
         tVHxKBKY4IPfiFpGdKIYPNnEo9KZ3MTSOK6WHL/Hev6BwySWy6SdteYWAw+MrUSdM2Uq
         ancs19DxiN78S/Pz/+K2a0dGvbMctW+Qj6UvFxxvGcrZTKjIN/1XUSWTFUATMzTzVOsX
         6iMI3lBEfsb2Fd75gafQBfTuaElX2PtgX6PbiiYmvxHx09ZTfqIkZ8LpIcZsj8kjd6Yl
         Rvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302753; x=1706907553;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7NKk6TD50k4Nb2NhK/PPxDQh3iGT4oBhRr2M3b5fwg=;
        b=PLPNCeqRI9EszXgkWFr1ntCAnJXCKQ6/3MjN3gL/8ZsC436Ay7DHhpOooq2tYM1owB
         G0tXelRW4zG/77wJGQW0OgrhyexiKOI8nNPKJckDDrRnDKe7djvQ5Pfp4M5ttiQTyN6z
         8EAc2f+FxT8lggI6k61I6D15isYsbXNWW7Bkd9F2TnNyBOh/RZZeQyNpLsGADmoh+Zax
         v7XW+E0y5nWOYNWfjdUWtx33YuaseWEqwF/uxuuvljL4lBKvu8sFaR56uU72P5ScDHVq
         kArVKX87MbIPZqckE/Sq4oSI4hV39ObbrDnrhdXVDttk8ZCdW1qajeCtjghU5GutwDCW
         d99Q==
X-Gm-Message-State: AOJu0Ywp7TEwpPxEiZKiLpkc08uk1KdubC3NaiAJqixufLolSC6ssm+J
	Ahz9sV7xoUJewkVKz3eTRmN4zph8IuJBUQ1PlLcDmnJmKcWCVufiXuq4fbev
X-Google-Smtp-Source: AGHT+IFM8Fb+U263almshsgcTRns021tSi3yVy5KmCMCjfeyZpAPRMC8KMuua8zTRpWRWamB6giIVQ==
X-Received: by 2002:a5d:6109:0:b0:337:c2fa:c710 with SMTP id v9-20020a5d6109000000b00337c2fac710mr177889wrt.133.1706302752682;
        Fri, 26 Jan 2024 12:59:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfed52000000b00337d92e8b9csm1967559wro.109.2024.01.26.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:59:11 -0800 (PST)
Message-ID: <a2b9adb93d8b515532662e65e4878fb2bee650e3.1706302749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 20:59:09 +0000
Subject: [PATCH v3 2/2] index-pack: --fsck-objects to take an optional
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

Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt | 17 +++++++++++------
 builtin/index-pack.c             |  5 +++--
 t/t5300-pack-object.sh           | 29 ++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 694bb9409bf..3db1062d1e4 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -96,13 +96,18 @@ default and "Indexing objects" when `--stdin` is specified.
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
---fsck-objects::
-	For internal use only.
+--fsck-objects[=<msg-id>=<severity>...]::
+	Die if the pack contains broken objects. If the pack contains a tree
+	pointing to a .gitmodules blob that does not exist, prints the hash of
+	that blob (for the caller to check) after the hash that goes into the
+	name of the pack/idx file (see "Notes").
 +
-Die if the pack contains broken objects. If the pack contains a tree
-pointing to a .gitmodules blob that does not exist, prints the hash of
-that blob (for the caller to check) after the hash that goes into the
-name of the pack/idx file (see "Notes").
+Unlike `--strict` however, don't choke on broken links. An optional
+comma-separated list of `<msg-id>=<severity>` can be passed to change the
+severity of some possible issues, e.g.,
+`--fsck-objects="missingEmail=ignore,badTagName=ignore"`. See the entry for the
+`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
+information on the possible values of `<msg-id>` and `<severity>`.
 
 --threads=<n>::
 	Specifies the number of threads to spawn when resolving
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 240c7021168..a3a37bd215d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
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
