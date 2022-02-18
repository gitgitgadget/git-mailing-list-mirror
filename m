Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB945C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiBRRNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiBRRNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:13:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C1B47AE2
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d3so1855wrf.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fe2JNsEiTV16NoSD7pJhopAoGEyAVJvdVZxm6gsgjcU=;
        b=hooV2MXABlKE7hptc64NJLc36T+BQpaTAPgOkTViV2EQQSboeD4tMZaspd2Oqitu7g
         jDVd6dUsJVIA68/D5rJOLT4Q509/HLqIJmfxxvbv2p6yK/1WRIkFPinV+eL8A+aAWXQ+
         yT/iDfNYRh12VlxlUyxo+kNpTuGhivN4K5U5RCswkJFarefB+PMGsxZ9Kn97kWtx7+8O
         b+SM2ETzBtSM0OAu5qkt81MsSwV014mspMVaotRAt9pcVrQpFw3IBmIkKHH1CqwNR8NO
         F+P/en/81RAT/nI41gLbo+R1+9hjo5DvegB3YuS/ltYBDQLTf9QLUJtPp3yswUQUEjNT
         TXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fe2JNsEiTV16NoSD7pJhopAoGEyAVJvdVZxm6gsgjcU=;
        b=lPQ7NELuRbmztTul5fcFNAD4tfGUlYOfB/qubnBkrBmY/VbHc7PuzsRceqVNZiBsAr
         c5rt4s7kP0UWY3NdAgw4mfGWhI3C7LhMATJyiSziLRYo4ozOCSP4sN9G0MoHKMCALp3F
         7PDRraROSFAMrsDZ6HmkoFvTZTKtP5d3wksa9wIigQT0ZsmEgrG72RJzSFHQNPV/J44s
         xwUuL2Ca0HeEQg2/R0kgtNaBUSL4CMuPepTGPbl4A1Qh684hOo48ntCgheYKOTIpukfG
         6qJi1qEGjVg48HFjhUmGv3Zc4QWeOMwv1yN1m+3sFVSD4dH+ORAafCBCza+N5AgCfdNv
         mi8Q==
X-Gm-Message-State: AOAM533W9ZEademqUL2oyOcMlgH1ecFd0kpK+/k6kU/lNk4FR6zJtiz3
        FXBTH8Q6aGQMjEKkpo/ShicL/r3Ovb1DwnAv
X-Google-Smtp-Source: ABdhPJwlhpkFpB4qmKHfP52y0Pl7r2LLQE4Z0INuXWN4DnEXg+/nhbjzK6++mCXIUQ/nDrrfV0BDgw==
X-Received: by 2002:a05:6000:1b02:b0:1e6:80c4:effa with SMTP id f2-20020a0560001b0200b001e680c4effamr6877027wrz.646.1645204365526;
        Fri, 18 Feb 2022 09:12:45 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id h6sm14332wmq.8.2022.02.18.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:12:45 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: [PATCH v2 2/2] Add new tests functions like test_path_is_*
Date:   Fri, 18 Feb 2022 18:12:24 +0100
Message-Id: <20220218171224.262698-3-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218171224.262698-1-cogoni.guillaume@gmail.com>
References: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
 <20220218171224.262698-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test_path_is_file_not_symlink(), test_path_is_dir_not_symlink()
and test_path_is_symlink(). Case of use for the first one
in test t/t3903-stash.sh to replace "test -f" because that function
explicitly want the file not to be a symlink by parsing the output
of "ls -l". Make the code more readable and give more friendly error
message.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh        | 15 ++++++---------
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 11a0856873..0ec19a4499 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -390,10 +390,9 @@ test_expect_success SYMLINKS 'stash file to symlink' '
 	rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
-	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -401,10 +400,9 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
 	git rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink (stage rm)" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
-	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -413,10 +411,9 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 	ln -s file2 file &&
 	git add file &&
 	git stash save "file to symlink (full stage)" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
-	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	git stash apply
 '
 
 # This test creates a commit with a symlink used for the following tests
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85385d2ede..61fc5f37e3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -856,6 +856,16 @@ test_path_is_file () {
 	fi
 }
 
+test_path_is_file_not_symlink () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_file "$1" &&
+	if ! test ! -h "$1"
+	then
+		echo "$1 is a symbolic link"
+		false
+	fi
+}
+
 test_path_is_dir () {
 	test "$#" -ne 1 && BUG "1 param"
 	if ! test -d "$1"
@@ -865,6 +875,16 @@ test_path_is_dir () {
 	fi
 }
 
+test_path_is_dir_not_symlink () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_dir "$1" &&
+	if ! test ! -h "$1"
+	then
+		echo "$1 is a symbolic link"
+		false
+	fi
+}
+
 test_path_exists () {
 	test "$#" -ne 1 && BUG "1 param"
 	if ! test -e "$1"
-- 
2.25.1

