Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DBC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 14:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiGNObP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiGNObK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 10:31:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638B46554B
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 07:31:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu1so2793494wrb.9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yd2ORi+oHLgvJe4b6vovtEmaupdeI8fypcl/bopoeuo=;
        b=P3zDMFj0ZSX4OrSwTyNVZRsf2Nz3y6je+nTHlhFPJMLpdSasymERDuf9CDxRlM08rt
         uoWPSS1iFJo1GkOLvGTLscvIdV8NvdOlX6pNey+epUUZK/0Pl10rqjFswL2+v+y8qfW/
         rNPEmbVMlIDuEUDCHGH0QULMywYmFk1hx/vpJ/nDh7cWdmwWbcHjq6q1GFs2qBR7V60M
         rESSbMmNh/sFUgH8lFv0tQsfiAEgEehfyRhLGhZ1x0Creyc2Bx7KzWf1NL+c+bLsSttL
         WPK5SElR1jK3onRcWe/ZXhs+yYu5vi88DOECvTACuHvtRCE0PWcm1caR0+TxzJm5tXmc
         E6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yd2ORi+oHLgvJe4b6vovtEmaupdeI8fypcl/bopoeuo=;
        b=A1QZu9kSSGsxhH3vsQnwMfAkTgElD0TRYGR6rwzjkio8Kb2IGlvUvPsO/p2o5wL9sH
         ZWLM4KyZWyNmrfBVuBCpmK9qPzNPl9HWZd9J8Rapw81i1pwiAZvQIopdiSMVZWt/A+c9
         31USGxLQSj69EPu0At8utniQ+Um2EMqWbf8R/amjClHtwoVhubuF/7+vnKrDnK9FrcTE
         U3D+4GnR1MWcWZqDacxwVbRwXljcRwJxLMmod1mceJDCQoa/uXu8JGnEDbByiFn7s6tC
         nu3H1OyPxx/ldN4ZAKwbgh2Nh1LU5J+DYiPCTE2rBJjesb14+rdkwCwseaVJsxanDqcF
         7XKg==
X-Gm-Message-State: AJIora8JfvMrJQQRzNSG9ow4b8th+uZR9uFMvpg4fAxC5HdP5WLTrOzs
        6AzOR0h20Bwcbt2QMlFhf2eI95xzym8=
X-Google-Smtp-Source: AGRyM1tNnIT94rGxu0FPaSD523ovzKm9VwcrBci500wQcWGx+WdaXUrmjQWKGUmsbHKcdv2lFMD4ZA==
X-Received: by 2002:adf:d090:0:b0:21d:aa9b:9998 with SMTP id y16-20020adfd090000000b0021daa9b9998mr8764499wrh.33.1657809065255;
        Thu, 14 Jul 2022 07:31:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b003a0323463absm2526489wmb.45.2022.07.14.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:31:04 -0700 (PDT)
Message-Id: <pull.1287.v2.git.1657809063728.gitgitgadget@gmail.com>
In-Reply-To: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 14:31:03 +0000
Subject: [PATCH v2] mergetool(vimdiff): allow paths to contain spaces again
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
    
    Changes since v1:
    
     * Using base_present=false instead of the misleading base_present=1
       (thanks Junio & Fernando!)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1287%2Fdscho%2Ffix-vimdiff-with-spaces-in-paths-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1287/dscho/fix-vimdiff-with-spaces-in-paths-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1287

Range-diff vs v1:

 1:  dde9c7cd2ea ! 1:  7de381b6913 mergetool(vimdiff): allow paths to contain spaces again
     @@ mergetools/vimdiff: run_unit_tests () {
      +		done
      +	}
      +
     -+	base_present=1
     ++	base_present=false
      +	LOCAL='lo cal'
      +	BASE='ba se'
      +	REMOTE="' '"


 mergetools/vimdiff | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 461a89b6f98..f7e7f270285 100644
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
+	base_present=false
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
