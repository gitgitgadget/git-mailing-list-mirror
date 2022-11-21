Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13DC43217
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKUA1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKUA1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:27:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FB2CE26
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p16so7419798wmc.3
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B99KkgV3FXi1gpR1Jt9RIZpMwW7+bkF3a2vun2ydh1U=;
        b=DQr/i9cOHMo1WJiQkgl+WxhYZsam9upNiKhXfEXWMrEv7VXNVAnhKoPzKaZdpEZuvl
         H9//qgYJHWOtb/PiuYs4UxWYi7Qx/yce1ZxLBEZ3Tccwmli+GaAgCj8VJRaToVFBWea+
         FmwiyRD4Xcl6EvfQGbiEaIB40OG8Q4oCvR6ao/1w7nA7OtJUKbjvRuJKuvXTdokxnVPX
         yq7c3PekhjIWhDTeM2XBVaee3cUPUGCWiejjm8GZ5wWuftUxKUDgoRblKSgY61LPsKmG
         mMKuUM59Pfxi48QZOVqvA6UHU8WBRTOSPEOLqjZUCJ8IqWmfW1WFU+LVF4OYzh0vBJKn
         pNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B99KkgV3FXi1gpR1Jt9RIZpMwW7+bkF3a2vun2ydh1U=;
        b=inm//uWG/WixTaOx0fkTqYn6rdPXPmNWgpct98Id6sG72XrmsgNKY5jIKREABcsgND
         tMCPM7IT6XVm0vltJsNbzG/p33lomNtbL1PQkKhoQ9fWN6fBGYU0dSmK5T4n7pp++U7z
         /eD/kzVQ/TGTPDE4Qfk4r+UyznjzuEeyBGFKchQwTL5nbXSOnXz/XkB9IJk8bZXvPFrr
         VFvq0cMDStMBOFiZO0wVrOT6GtdNIViNyWkRcb3E1aM2H0GG5L7T61UP/OL26s0RTaaP
         DL68tF4aCvLKxaK8TuX8rZfSpNa91H1Z2WrzZn0Weiz52z19OYl3EYS7s6Bf1vOyDnc/
         v76Q==
X-Gm-Message-State: ANoB5pnw7hzxEUbUfYNojDUpkW8nhKHOdeu82YvBBHNGPBjMWCXZNIE7
        KIs/N++9X717uEkikTVwfqcd249Y3+M=
X-Google-Smtp-Source: AA0mqf6o0VvNlphjTRIAnYOcHMWzg0xAuPFqjiHwk+2r1SQsEkyCiCEUN/NAVSeB0RaIlBPogq8QZg==
X-Received: by 2002:a05:600c:384f:b0:3cf:9377:c76f with SMTP id s15-20020a05600c384f00b003cf9377c76fmr14174798wmr.189.1668990421823;
        Sun, 20 Nov 2022 16:27:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b003c6b874a0dfsm13970179wmq.14.2022.11.20.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:27:01 -0800 (PST)
Message-Id: <a261a94877ad486073ae6e644e540b920a04c6b9.1668990419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
        <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 00:26:58 +0000
Subject: [PATCH v2 1/2] completion: add optional ignore-case when matching
 refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alison Winters <alisonatwork@outlook.com>,
        Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alison Winters <alisonatwork@outlook.com>

If GIT_COMPLETION_IGNORE_CASE is set, --ignore-case will be added to
git for-each-ref calls so that refs can be matched case insensitively,
even when running on case sensitive filesystems.

Signed-off-by: Alison Winters <alisonatwork@outlook.com>
---
 contrib/completion/git-completion.bash | 12 ++++++++++++
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d8..7dcf4b63562 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -58,6 +58,12 @@
 #
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
+#
+#   GIT_COMPLETION_IGNORE_CASE
+#
+#     When set, uses for-each-ref '--ignore-case' to find refs that match
+#     case insensitively, even on systems with case sensitive file systems
+#     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -646,6 +652,7 @@ __git_heads ()
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
 
@@ -659,6 +666,7 @@ __git_remote_heads ()
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
 }
 
@@ -669,6 +677,7 @@ __git_tags ()
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
 
@@ -688,6 +697,7 @@ __git_dwim_remote_heads ()
 	# but only output if the branch name is unique
 	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 		--sort="refname:strip=3" \
+		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
 	uniq -u
 }
@@ -765,6 +775,7 @@ __git_refs ()
 			;;
 		esac
 		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
+			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
 			__git_dwim_remote_heads "$pfx" "$match" "$sfx"
@@ -787,6 +798,7 @@ __git_refs ()
 			$match*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
+				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 				"refs/remotes/$remote/$match*" \
 				"refs/remotes/$remote/$match*/**"
 		else
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b800..d89d0a93a2a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2255,6 +2255,21 @@ test_expect_success 'checkout completes ref names' '
 	EOF
 '
 
+test_expect_success 'checkout does not match ref names of a different case' '
+	test_completion "git checkout M" ""
+'
+
+test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGNORE_CASE' '
+	(
+		GIT_COMPLETION_IGNORE_CASE=1 &&
+		test_completion "git checkout M" <<-\EOF
+		main Z
+		mybranch Z
+		mytag Z
+		EOF
+	)
+'
+
 test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
-- 
gitgitgadget

