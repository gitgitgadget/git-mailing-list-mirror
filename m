Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A69C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiGMPmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiGMPmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 11:42:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD29F33377
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 08:42:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l42so6687893wms.5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xEcIh2X2gzLSpz+MAI+HD1K1CNpMUBTVnTRdhCvMHZE=;
        b=dkfHLiecB5GVRKf5b5LqCiYE5vEM33pOLTCiJDAW1KL5zXNHvtbvi30lX6r681VA+0
         JNlsb1TkCUpRe97UsRMBNcf0t6zlpZ6OZq4UD05Tu5uqq2z9Q9Q/yGk/gQ+8G/aAgzTY
         3alBi0TpqVRnvyWFl8U/F7jf+llh4fhx7J2leNk/IMzdInsZTCRfjGVk/BB3gX4u4e/f
         PK88zbAxqe6KdUEUHjjiiZzvqMrIwItfjrgHEWdhJuyKJbHxqIiLh9mheuqq0+R57jKa
         InGMcRkyWPNdMMk6DzuBmAOEuC0ZYVxO8zuL4vQnYRe1K7/7hHZ2Yir0omIF/SO06lNH
         GnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xEcIh2X2gzLSpz+MAI+HD1K1CNpMUBTVnTRdhCvMHZE=;
        b=Eoz03ZgFgy/fbmlYba7QgfvvNHXrSp9ZSG8Lg05T7Jw/rKDsd5MTkeWUuB4htZ3Nwb
         ibHQju/iMZO0xGrvwx6v19LFU/GphvFw9PspimtgCuoB+byyRuGtDA+lTX2CyrDU/k6/
         uE/47tvBOA/TR/T1ewaLPvEPb4rBUE4/sqRHfQUTcPwMQllaOuUTuT0PxspjfpvpWX6F
         /OYT10sNtjZuNwykId8Inra/7EY6Ydg/OpRtxZhiUJ69naZSS9R83MqiSiLGdVzomNee
         pj5MG17zMHsxIom9foXHPQAwQAbKsV9RBW6WuBzKpvhF4igpZVgSM5uaQW3PbIND54hL
         sbRA==
X-Gm-Message-State: AJIora+BRTmU6ImteXm8Z5JTbPb/0rcZ92cFhWfBfGCn7y6+gaTrNbAd
        Mw64sKBc7CxgTjomiUw5+kzMO6aKO8E=
X-Google-Smtp-Source: AGRyM1ti9CGuDni3g67WzZ2kSgcLc3MBzJy2MNM0r2IiNCN/t4m7eKjuWXcmeFG10WHoKxzFL5rx1A==
X-Received: by 2002:a05:600c:a198:b0:3a2:f88a:65c0 with SMTP id id24-20020a05600ca19800b003a2f88a65c0mr4282842wmb.25.1657726970958;
        Wed, 13 Jul 2022 08:42:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0021dac657337sm6282824wrt.75.2022.07.13.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:42:50 -0700 (PDT)
Message-Id: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 15:42:49 +0000
Subject: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 0041797449d (vimdiff: new implementation with layout support,
2022-03-30), we introduced a completely new implementation of the
`vimdiff` backend for `git mergetool`.

In this implementation, we no longer call `vim` directly but we
accumulate in the variable `FINAL_CMD` an arbitrary number of commands
for `vim` to execute, which necessitates the use of `eval` to split the
commands properly into multiple command-line arguments.

That same `eval` command also needs to pass the paths to `vim`, and
while it looks as if they are quoted correctly, that quoting only
reaches the `eval` instruction and is lost after that, therefore paths
that contain whitespace characters (or other characters that are
interpreted by the POSIX shell) are handled incorrectly.

This is a simple reproducer:

	git init -b main bam-merge-fail
	cd bam-merge-fail
	echo a>"a file.txt"
	git add "a file.txt"
	git commit -m "added 'a file.txt'"
	echo b>"a file.txt"
	git add "a file.txt"
	git commit -m "diverged b 'a file.txt'"
	git checkout -b c HEAD~
	echo c>"a file.txt"
	git add "a file.txt"
	git commit -m "diverged c 'a file.txt'"
	git checkout main
	git merge c
	git mergetool --tool=vimdiff

With Git v2.37.0/v2.37.1, this will open 7 buffers, not four, and not
display the correct contents at all.

To fix this, let's not expand the variables containing the path
parameters before passing them to the `eval` command, but let that
command expand the variables instead.

This fixes https://github.com/git-for-windows/git/issues/3945

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mergetool(vimdiff): allow paths to contain spaces again
    
    In https://github.com/git-for-windows/git/issues/3945, it was reported
    that as of v2.37.0, git mergetool --tool=vimdiff fails to handle paths
    containing spaces. Let's fix that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1287%2Fdscho%2Ffix-vimdiff-with-spaces-in-paths-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1287/dscho/fix-vimdiff-with-spaces-in-paths-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1287

 mergetools/vimdiff | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 461a89b6f98..59e1e2f5ca5 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -414,8 +414,8 @@ merge_cmd () {
 
 	if $base_present
 	then
-		eval "$merge_tool_path" \
-			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+		eval '"$merge_tool_path"' \
+			-f "$FINAL_CMD" '"$LOCAL"' '"$BASE"' '"$REMOTE"' '"$MERGED"'
 	else
 		# If there is no BASE (example: a merge conflict in a new file
 		# with the same name created in both braches which didn't exist
@@ -424,8 +424,8 @@ merge_cmd () {
 		FINAL_CMD=$(echo "$FINAL_CMD" | \
 			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
 
-		eval "$merge_tool_path" \
-			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
+		eval '"$merge_tool_path"' \
+			-f "$FINAL_CMD" '"$LOCAL"' '"$REMOTE"' '"$MERGED"'
 	fi
 
 	ret="$?"
@@ -614,6 +614,37 @@ run_unit_tests () {
 		fi
 	done
 
+	# verify that `merge_cmd` handles paths with spaces
+	record_parameters () {
+		>actual
+		for arg
+		do
+			echo "$arg" >>actual
+		done
+	}
+
+	base_present=1
+	LOCAL='lo cal'
+	BASE='ba se'
+	REMOTE="' '"
+	MERGED='mer ged'
+	merge_tool_path=record_parameters
+
+	merge_cmd vimdiff || at_least_one_ko=true
+
+	cat >expect <<-\EOF
+	-f
+	-c
+	echo | split | vertical split | 1b | wincmd l | vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	-c
+	tabfirst
+	lo cal
+	' '
+	mer ged
+	EOF
+
+	diff -u expect actual || at_least_one_ko=true
+
 	if test "$at_least_one_ko" = "true"
 	then
 		return 255

base-commit: 980145f7470e20826ca22d7343494712eda9c81d
-- 
gitgitgadget
