Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D5AECAAD5
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 00:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiH0AIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiH0AIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 20:08:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2DE831D
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 17:08:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so2050287otd.12
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NFiklxQvhb1Q4mVVCS2cSdbdyMYVWg76Z+KJjbNqxEw=;
        b=mMihlqiC6dW91JObT7PkVvypm7ykmWWSj41rEH3PZZwnygR9+sSQFn7PqLEeQ7XHYg
         Q+bGvrHJAZiyvdoXpSYKvC/y1ARGYEe7rTNGHDCVKp3OwTMHUJ7d+gfXUADj0MuHwXB4
         UNUFMMKZn3vasXIa+lC1SGNPeZmzM7b+NQwbDjKfLhWjM3xmM75rA3uoDMJ6MZexSleH
         /pwZNXAWeeiitxXwW/4WOPiGagfLvuuk1VBDQGX1s/NeHgRV9b6Q+wXKP3MB3RRahDId
         VGfzpLvVSiBv2bIdhUGj1SdxMLOGEVURkDTXOaMg+wOCiInybgzfksWVbKaq0x2Vl9bx
         zQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NFiklxQvhb1Q4mVVCS2cSdbdyMYVWg76Z+KJjbNqxEw=;
        b=OI3JrW+5tGwTb7/6+RLmL3ws5BL2gKsGLJnFxYkJOGc25X9oQlhkIxa2NvsKOem/8x
         iZLAjCsOUKSUNcPnvYNyhmEWhHYqAzGr02WFDGQO1OsA36HDRCqE71OkeleEr82tOS/a
         2dhDfIZpkwCOMvHymNxzkX9MCz/bRIz9SSlTGqQiT4GjdCPcGtN5GZ0I8gpF4omFiKFl
         fgSabGNLAq6Ep8U/PJj7kRKrrbG/i4tU/BU7xFUu3yRnF3t+OY42XvElvG/iHTDeArew
         kKkgv1GZRZcSGzQqYlBkodV1aq6KE+p3CO/VqMQhwFa/+MM8ovX+0MJnrf/0I+Ud+vFe
         wnWQ==
X-Gm-Message-State: ACgBeo1ehUMrMcC5uImx5ciNk9vNkniLjGxQ5mwnK0Hztk0hZtU/1Nv0
        nI6QKjkCZ+6DISD0ozCeANGJgCA1Scs=
X-Google-Smtp-Source: AA6agR5Z4SaTFfrkXWAKaKgrRPwDjCTT/PWKpQMCPJQ/orlTZ3G1giCjZDgyvn80sBbbRoBhO92p3w==
X-Received: by 2002:a9d:5a88:0:b0:638:911a:d7fd with SMTP id w8-20020a9d5a88000000b00638911ad7fdmr2190706oth.6.1661558892497;
        Fri, 26 Aug 2022 17:08:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:94d:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808009800b00342e8bd2299sm1694179oic.6.2022.08.26.17.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:08:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Joakim Petersen <joak-pet@online.no>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: prompt: use generic colors
Date:   Fri, 26 Aug 2022 19:08:10 -0500
Message-Id: <20220827000810.2917816-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the prompt command mode was introduced in 1bfc51ac81 (Allow
__git_ps1 to be used in PROMPT_COMMAND, 2012-10-10) the assumption was
that it was necessary in order to properly add colors to PS1 in bash,
but this wasn't true.

It's true that the \[ \] markers add the information needed to properly
calculate the width of the prompt, and they have to be added directly to
PS1, a function returning them doesn't work.

But that is because bash coverts the \[ \] markers in PS1 to \001 \002,
which is what readline ultimately needs in order to calculate the width.

We don't need bash to do this conversion, we can use \001 \002
ourselves, and then the prompt command mode is not necessary to display
colors.

This is what functions returning colors are supposed to do [1].

[1] http://mywiki.wooledge.org/BashFAQ/053

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

FTR, it's possible zsh will implement these \001 \002 markers too, so
there would be no need for different behavior depending on the shell.

 contrib/completion/git-prompt.sh | 19 +++++++------------
 t/t9903-bash-prompt.sh           |  8 ++++----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1435548e00..01bd807657 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -96,9 +96,7 @@
 #
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
-# the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
-# but always available in Zsh.
+# the colored output of "git status -sb".
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -255,12 +253,12 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \[ and \] around colors is necessary to prevent
+		# Using \001 and \002 around colors is necessary to prevent
 		# issues with command line editing/browsing/completion!
-		local c_red='\[\e[31m\]'
-		local c_green='\[\e[32m\]'
-		local c_lblue='\[\e[1;34m\]'
-		local c_clear='\[\e[0m\]'
+		local c_red=$'\001\e[31m\002'
+		local c_green=$'\001\e[32m\002'
+		local c_lblue=$'\001\e[1;34m\002'
+		local c_clear=$'\001\e[0m\002'
 	fi
 	local bad_color=$c_red
 	local ok_color=$c_green
@@ -564,11 +562,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
-			__git_ps1_colorize_gitstring
-		fi
+		__git_ps1_colorize_gitstring
 	fi
 
 	local f="$h$w$i$s$u$p"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a30f5719c..594042f562 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
-c_red='\\[\\e[31m\\]'
-c_green='\\[\\e[32m\\]'
-c_lblue='\\[\\e[1;34m\\]'
-c_clear='\\[\\e[0m\\]'
+c_red='\001\e[31m\002'
+c_green='\001\e[32m\002'
+c_lblue='\001\e[1;34m\002'
+c_clear='\001\e[0m\002'
 
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&
-- 
2.37.2.351.g9bf691b78c.dirty

