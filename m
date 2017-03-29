Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A7E20958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbdC2W0X (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:26:23 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35579 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdC2W0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:26:22 -0400
Received: by mail-pg0-f47.google.com with SMTP id 81so19999182pgh.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORqMw9lAOyBWL+uWQeqTzsFS4aDBdIZxaQokV2I9FCk=;
        b=IdSzYxlGh4oRTzD72ykHp/zTUXvx5NvmDfY3pgsE+7cBPP1s0na5IVnbRHzvhJ51ul
         ZtAQGcMyjYf3WWwKDzK+RVikMwLYVmS0OGwM3d+Zes7lvlsvEovaR6fkATb5d3jUP8Cd
         XsWeqn9o07S3n8eCNMMomS3Ashu5OeA5cNJ/CwWb2eHD+zEJLdGn6EpbQvGxRmWmmr1/
         IXVbsmQvGaaZvoZFvt2eG1YAGqs87v08XRkbdr/Sced2zsgNiN9Jqi3zKis/xePZnWRz
         ny8j6Uj0n7tkvoQscQieteUfFXC8Na85S7pq0+Fl1xUeKMFXVi/s2fYlnK6teh8jSjRn
         fRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORqMw9lAOyBWL+uWQeqTzsFS4aDBdIZxaQokV2I9FCk=;
        b=OZpv3Bobg9aXrbIHs7yuuNxvTJ2Tp0I0KgcPERkP78sqMpz4B3FvrOuOBYmpRKE9n+
         qsEsZXwhI7CayUtx48+JTKHQCqanU+5oEgstCwipfVSP0+jPDJFLkhxeO4oX7tC2Wkgl
         cyXz8vMqM8/RxRZZ9kzSOhXzwLlsI9zbjnZZK/QqXhthtPS2tq7ajyYP05oFFwADgG7o
         gN344MdUi4U0maT3v1hWvY++WCFs8xF91n1uwUahcS6tgALVujrT2sFi9BA0BeQmv9Vy
         18BsM83L+544rLSXttbvlf2S4SmZ7iHsmXOFjPUz1VpzHz0vhSCncD+nkUfRqkEGkj8C
         NKYA==
X-Gm-Message-State: AFeK/H242cEFwOKZu0eUg0zUcE5otw4S3P+KAMoiOl3xZnKr2UUaoZE65Hdp+1iGfDtE66cw
X-Received: by 10.98.148.25 with SMTP id m25mr2723315pfe.45.1490826381447;
        Wed, 29 Mar 2017 15:26:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id c16sm244782pfl.7.2017.03.29.15.26.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 15:26:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 (6,7)/7] short status: improve reporting for submodule changes
Date:   Wed, 29 Mar 2017 15:26:14 -0700
Message-Id: <20170329222616.11077-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.442.ge9452a8fbc
In-Reply-To: <20170328230938.9887-1-sbeller@google.com>
References: <20170328230938.9887-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v9:
* This is a resend of the last two patches, i.e. these two patches apply
  at 5c896f7c3ec (origin/sb/submodule-short-status^^)
* below is a diff of this patch series against origin/sb/submodule-short-status
* better tests, refined documentation, thanks for the review, Jonathan!

Thanks,
Stefan

previous work:
https://public-inbox.org/git/20170328230938.9887-1-sbeller@google.com/

Stefan Beller (2):
  short status: improve reporting for submodule changes
  submodule.c: correctly handle nested submodules in
    is_submodule_modified

 Documentation/git-status.txt |  13 +++++
 submodule.c                  |  21 +++++++-
 t/t3600-rm.sh                |  18 +++++--
 t/t7506-status-submodule.sh  | 117 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |  17 ++++++-
 5 files changed, 177 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 01b457c322..d70abc6afe 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -186,7 +186,11 @@ Submodules have more state and instead report
 		     recorded in the index
 		m    the submodule has modified content
 		?    the submodule has untracked files
+since modified content or untracked files in a submodule cannot be added
+via `git add` in the superproject to prepare a commit.
 
+'m' and '?' are applied recursively. For example if a nested submodule
+in a submodule contains an untracked file, this is reported as '?' as well.
 
 If -b is used the short-format status is preceded by a line
 
diff --git a/submodule.c b/submodule.c
index 730cc9513a..3da65100e3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1082,20 +1082,18 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		if (buf.buf[0] == 'u' ||
 		    buf.buf[0] == '1' ||
 		    buf.buf[0] == '2') {
-			/*
-			 * T XY SSSS:
-			 * T = line type, XY = status, SSSS = submodule state
-			 */
-			if (buf.len < 1 + 1 + 2 + 1 + 4)
+			/* T = line type, XY = status, SSSS = submodule state */
+			if (buf.len < strlen("T XY SSSS"))
 				die("BUG: invalid status --porcelain=2 line %s",
 				    buf.buf);
 
-			/* regular unmerged and renamed files */
 			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (memcmp(buf.buf + 5, "S..U", 4))
+			if (buf.buf[0] == 'u' ||
+			    buf.buf[0] == '2' ||
+			    memcmp(buf.buf + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index ab822c79e6..055c90736e 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -17,6 +17,12 @@ test_create_repo_with_commit () {
 	)
 }
 
+sanitize_output () {
+	sed -e "s/$_x40/HASH/" -e "s/$_x40/HASH/" output >output2 &&
+	mv output2 output
+}
+
+
 test_expect_success 'setup' '
 	test_create_repo_with_commit sub &&
 	echo output > .gitignore &&
@@ -311,6 +317,10 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 	test_cmp diff_submodule_actual diff_submodule_expect
 '
 
+# We'll setup different cases for further testing:
+# sub1 will contain a nested submodule,
+# sub2 will have an untracked file
+# sub3 will have an untracked repository
 test_expect_success 'setup superproject with untracked file in nested submodule' '
 	(
 		cd super &&
@@ -318,6 +328,7 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 		rm .gitmodules &&
 		git submodule add -f ./sub1 &&
 		git submodule add -f ./sub2 &&
+		git submodule add -f ./sub1 sub3 &&
 		git commit -a -m "messy merge in superproject" &&
 		(
 			cd sub1 &&
@@ -327,13 +338,27 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 		git add sub1 &&
 		git commit -a -m "update sub1 to contain nested sub"
 	) &&
-	echo untracked >super/sub1/sub2/untracked
+	echo content >super/sub1/sub2/file &&
+	echo content >super/sub2/file &&
+	git -C super/sub3 clone ../../sub2 untracked_repository
 '
 
 test_expect_success 'status with untracked file in nested submodule (porcelain)' '
 	git -C super status --porcelain >output &&
 	diff output - <<-\EOF
 	 M sub1
+	 M sub2
+	 M sub3
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	sanitize_output output &&
+	diff output - <<-\EOF
+	1 .M S..U 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub2
+	1 .M S..U 160000 160000 160000 HASH HASH sub3
 	EOF
 '
 
@@ -341,6 +366,41 @@ test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
 	 ? sub1
+	 ? sub2
+	 ? sub3
+	EOF
+'
+
+test_expect_success 'setup superproject with modified file in nested submodule' '
+	git -C super/sub1/sub2 add file &&
+	git -C super/sub2 add file
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	 M sub3
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	sanitize_output output &&
+	diff output - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S.M. 160000 160000 160000 HASH HASH sub2
+	1 .M S..U 160000 160000 160000 HASH HASH sub3
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 m sub2
+	 ? sub3
 	EOF
 '
 


