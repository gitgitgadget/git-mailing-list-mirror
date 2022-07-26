Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85FC433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 01:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiGZBXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiGZBXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 21:23:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEE286C1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:23:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a11so7831283wmq.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BCwoZPGiIqHDKC5AGU6kHCrnweMTpx1J7lFxkHjbjTU=;
        b=Kzcg2yiveRBtQlg3o/ruHkRnbkIKAfrxrnO68O548ijFzraew4Uamh9Fpg+G0AKKzL
         7db5Z0r1MfRD/oQb4oaZ/RRHFB1zV2d2g19MJJMNBcjVaNEnUNPLr3aPGY643KKmseJp
         O3cISpgZ+y0hm2nbzYhSxlsegcGIPmGYwtda8ORhB4Q0mNMLn4M/vLq4hT/nnIn7IEmJ
         DnZQerk3rswNeE/6DlXQy7qZE7cLeTgLGKr/fTwOOV6XoPhdmueZx8x1Mqx15Sy9ko6+
         Smwu6V3JX+DPkV2DSIXSrGON872qQFVIlXtoQZHkht7i7FB+buZu3NnNKfm8IvRfmL4w
         Qo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BCwoZPGiIqHDKC5AGU6kHCrnweMTpx1J7lFxkHjbjTU=;
        b=1llaLuQ2VLeH7nxXh7Xd2UwpGmieX9FqTkvifhQb4dm9GEa6Hlwdfbsxf7xmiblCfm
         My0ZhMneB+c5noWn0bdFeUSHLat4AR+shc9+ugBEUCS6XiPDCR7ayqs+eQ6rzvRs9Lsl
         u3s8MaO/9Srnud8KOrOwFPFnWKrzWjYUvcljNab18kgluP4ko85C1DtftS8Oj2X40LH4
         +tjtACh3NVW18TJ4ulP7bvMqo+3jTuTAjESTVJ+X2TDNh2AUfW4TMbDVZSEDk3WaFc0n
         DCTqC9mIzh/RoJfF4DL7qMYP+zOQK4KDL8B3obt0MgDKWea+ZRV84gwI9VVYHeV6VMvr
         5TVw==
X-Gm-Message-State: AJIora+KEKjXGg9RxtuxyXw5EobK2LSJR4nwyeAyvnl+iKyguWsdDdci
        ib7S3aT4Wcs1nfmvwzUmHLrv5AAv3EM=
X-Google-Smtp-Source: AGRyM1uXfVMpQAcEMRja2lsuHQ2NQDVBm3fwtX5EV/Y0xMYKh2nwppnBvNWwpbOm/D+96JJyp9l0Hw==
X-Received: by 2002:a05:600c:4113:b0:3a3:4b67:d086 with SMTP id j19-20020a05600c411300b003a34b67d086mr8717696wmi.20.1658798596702;
        Mon, 25 Jul 2022 18:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c2ca700b003a3253b706esm14797630wmc.34.2022.07.25.18.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:23:16 -0700 (PDT)
Message-Id: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 01:23:15 +0000
Subject: [PATCH] git-prompt: show 'CONFLICT' indicator at command prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

When there are unresolved conflicts, show the word 'CONFLICT' on the
command prompt. Similar to other state indicators, this provides
information to the user about the current state of the repository.

Example prompt: (main|CONFLICT)

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
    Show 'CONFLICT' indicator at command prompt
    
    This patch adds functionality for bash/zsh to show 'CONFLICT' on the
    prompt in cases where there are unresolved conflicts. It includes the
    ability for the functionality to be disabled by setting an environment
    variable (enabled by default).
    
    The conflict state is determined by running git ls-files --unmerged. In
    my testing, the performance was very good. It took around 0.01 seconds
    to run git ls-files --unmerged regardless of the number of conflicts, or
    their depth, even on vary large projects (Linux kernel). However, if
    anybody has any concerns with this, I'm open to other options.
    
    I had to make some changes to several tests in t9903-bash-prompt.sh to
    make them pass (adding '|CONFLICT' to expected output of __git_ps1). The
    changes clearly make sense, since there is a conflict in those test
    cases. But I'm curious if others think it's the best approach.
    
    Test options considered:
    
     1. Set GIT_PS1_OMITCONFLICTSTATE before the tests. This would prevent
        the new functionality from taking effect.
     2. Update the tests to include "|CONFLICT" where applicable (this is
        what I've done so far).
     3. Duplicate the tests that needed to be updated, and do #⁠1 for one of
        the tests and #⁠2 for the other.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1302%2Fjustinrdonnelly%2Fconflict-indicator-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1302/justinrdonnelly/conflict-indicator-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1302

 contrib/completion/git-prompt.sh | 11 ++++++++++-
 t/t9903-bash-prompt.sh           |  9 +++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1435548e004..2d30eb5c17e 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,9 @@
 # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
+# When there is a conflict, the prompt will include "|CONFLICT". This can
+# be omitted by setting GIT_PS1_OMITCONFLICTSTATE.
+#
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
 # to one of these values:
@@ -508,6 +511,12 @@ __git_ps1 ()
 		r="$r $step/$total"
 	fi
 
+	local conflict="" # state indicator for unresolved conflicts
+	if [[ -z "${GIT_PS1_OMITCONFLICTSTATE-}" ]] &&
+	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
+		conflict="|CONFLICT"
+	fi
+
 	local w=""
 	local i=""
 	local s=""
@@ -572,7 +581,7 @@ __git_ps1 ()
 	fi
 
 	local f="$h$w$i$s$u$p"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a30f5719c3..9314776211c 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -183,7 +183,7 @@ test_expect_success 'prompt - interactive rebase' '
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE 1/3)" >expected &&
+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --merge b1 b2 &&
@@ -193,7 +193,7 @@ test_expect_success 'prompt - rebase merge' '
 '
 
 test_expect_success 'prompt - rebase am' '
-	printf " (b2|REBASE 1/3)" >expected &&
+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --apply b1 b2 &&
@@ -203,7 +203,7 @@ test_expect_success 'prompt - rebase am' '
 '
 
 test_expect_success 'prompt - merge' '
-	printf " (b1|MERGING)" >expected &&
+	printf " (b1|MERGING|CONFLICT)" >expected &&
 	git checkout b1 &&
 	test_when_finished "git checkout main" &&
 	test_must_fail git merge b2 &&
@@ -213,11 +213,12 @@ test_expect_success 'prompt - merge' '
 '
 
 test_expect_success 'prompt - cherry-pick' '
-	printf " (main|CHERRY-PICKING)" >expected &&
+	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
 	test_must_fail git cherry-pick b1 b1^ &&
 	test_when_finished "git cherry-pick --abort" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual" &&
+	printf " (main|CHERRY-PICKING)" >expected &&
 	git reset --merge &&
 	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
 	__git_ps1 >"$actual" &&

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
