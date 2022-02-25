Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB5C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiBYLot (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiBYLol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC1E1137
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s1so4036191wrg.10
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8r4KzvmBJBcEcejQQCQP/18C5CUaTPDCtesBQXHNvBw=;
        b=KL6O5PwZr8Mj/xm6ILcvwDwtlRVlLDfmiH0tqAFwuXaOi46FOKHjLz1Ko4xAKf2JlB
         E9uWRpmFjvLed7zFqqhr4WqaXaef0woGm+plrvdsY7o1wbMfyYuLj6EFqDaNpHHNrggO
         KMgve6zYIRAMxNA2gqVipptyKKQlJT9FyhPW6Iv9b3Tn51Fg9HsGYfO3/bQ5ezKUDHcW
         SJW2cu1NC2HkhP5/qGa4yrHhTJ3t/lYgNdMgBt1x0KlH8NOBm4Q/vQ0OykoHZ1Sug94B
         MAznZVlGrVaZpw85WOENvBPiDfJCtHsoAyL8LYmrzQcWFn/kebYZ1ZRu8uGVKshle0eX
         bQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8r4KzvmBJBcEcejQQCQP/18C5CUaTPDCtesBQXHNvBw=;
        b=MSHi+QotgQEE8uq88KUoOIJu2CoiN605b9fFaItlwiCxfmlSjqKdqXvPXRhNUSsTVv
         LJyBURN+zMsDSB/5CnFu9OVlWhr4OYDNP9kKmjguNJ35BohN2JUbMc55iZJlC7KIBZbQ
         V7ja0ALIW1D7i0NqPDxgZhSKw/hvR8EHQyKeW/xflJ8uNAFOqZWyrN6aBPam4LvxolKv
         dYQWPoV7XgCu+qvsQGsrpTtKMFqByleHV/4TTk+lhqk0pl9gpzRvzKsztmvgGx/SSjXP
         iYtFm2HTHeF7JQ9VrnmymET1XGx8i3RYIfsUdHrePXPpkoJU/1esKUXYffo8ViyWSNS0
         Q0Fg==
X-Gm-Message-State: AOAM531s8CpIGTNelnbhRjsZGxKmSjez238SIiUkW2wZTSz8j0g2uu6o
        1fAnSj2RDzveoEaOB4RB4gDvnPp780g=
X-Google-Smtp-Source: ABdhPJw37Vm4WktiikbuLh/zQkRFjHOCv+j17a/jNrtxegxPmZViWI6pv9SJcMkYrVD5u2/bHSWq4A==
X-Received: by 2002:adf:fcd0:0:b0:1ef:31fe:d08e with SMTP id f16-20020adffcd0000000b001ef31fed08emr3951216wrs.667.1645789448266;
        Fri, 25 Feb 2022 03:44:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a1c7c12000000b0037c94766961sm2117573wmc.20.2022.02.25.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:07 -0800 (PST)
Message-Id: <1db836bb309989c4ad93ed6d32a5ef4075ac7020.1645789446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:44:03 +0000
Subject: [PATCH 1/4] git-prompt: rename `upstream` to `upstream_type`
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

In `__git_ps1_show_upstream` rename the variable `upstream` to
`upstream_type`. This allows `__git_ps1_show_upstream` to reference a
variable named `upstream` that is declared `local` in `__git_ps1`, which
calls `__git_ps1_show_upstream`.

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index db7c0068fb5..3997e099aa7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -115,7 +115,7 @@ __git_ps1_show_upstream ()
 {
 	local key value
 	local svn_remote svn_url_pattern count n
-	local upstream=git legacy="" verbose="" name=""
+	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
 	# get some config options from git-config
@@ -132,7 +132,7 @@ __git_ps1_show_upstream ()
 		svn-remote.*.url)
 			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
 			svn_url_pattern="$svn_url_pattern\\|$value"
-			upstream=svn+git # default upstream is SVN if available, else git
+			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
 		esac
 	done <<< "$output"
@@ -141,16 +141,16 @@ __git_ps1_show_upstream ()
 	local option
 	for option in ${GIT_PS1_SHOWUPSTREAM}; do
 		case "$option" in
-		git|svn) upstream="$option" ;;
+		git|svn) upstream_type="$option" ;;
 		verbose) verbose=1 ;;
 		legacy)  legacy=1  ;;
 		name)    name=1 ;;
 		esac
 	done
 
-	# Find our upstream
-	case "$upstream" in
-	git)    upstream="@{upstream}" ;;
+	# Find our upstream type
+	case "$upstream_type" in
+	git)    upstream_type="@{upstream}" ;;
 	svn*)
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
@@ -167,12 +167,12 @@ __git_ps1_show_upstream ()
 
 			if [[ -z "$svn_upstream" ]]; then
 				# default branch name for checkouts with no layout:
-				upstream=${GIT_SVN_ID:-git-svn}
+				upstream_type=${GIT_SVN_ID:-git-svn}
 			else
-				upstream=${svn_upstream#/}
+				upstream_type=${svn_upstream#/}
 			fi
-		elif [[ "svn+git" = "$upstream" ]]; then
-			upstream="@{upstream}"
+		elif [[ "svn+git" = "$upstream_type" ]]; then
+			upstream_type="@{upstream}"
 		fi
 		;;
 	esac
@@ -180,11 +180,11 @@ __git_ps1_show_upstream ()
 	# Find how many commits we are ahead/behind our upstream
 	if [[ -z "$legacy" ]]; then
 		count="$(git rev-list --count --left-right \
-				"$upstream"...HEAD 2>/dev/null)"
+				"$upstream_type"...HEAD 2>/dev/null)"
 	else
 		# produce equivalent output to --count for older versions of git
 		local commits
-		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
+		if commits="$(git rev-list --left-right "$upstream_type"...HEAD 2>/dev/null)"
 		then
 			local commit behind=0 ahead=0
 			for commit in $commits
@@ -229,7 +229,7 @@ __git_ps1_show_upstream ()
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
-				--abbrev-ref "$upstream" 2>/dev/null)
+				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
 				p="$p \${__git_ps1_upstream_name}"
 			else
-- 
gitgitgadget

