Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81345C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiFNJJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiFNJJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2583FBE5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 02:09:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso5850413wms.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=N5EEshzyHNwusRFuCOt0szQsnkyTgNGdQE2tyPquGoU=;
        b=MNXNqxtT+/5NPGjv3zybOcLQR2pX4wsXE00UIrxDKRfpBYknx+JWSQY1cli0AOOXH6
         Ksq22cl2ELEgdqBXCQEDI0omn8zDUemiDcX1jQpzJW8y9ILRKvlMnQizANjO4s2fOBD5
         UjWj0yI/nhCoylezUyG6l0KyH2uvWMpTHmH0olSdWd4HU/IYMtsH2Y8xWgnz2qxS8EeX
         qTubK/xV7p6DYxIQOOjd0CaSfVXeyduVdIwy5QYNer9Ur/3AUGRJSpVaaiIYiuuQhPt5
         Q/+EvQsVUKJvJAkmWw59DzavOx+I3AwgDhy1yUZCUqSzztSk7eNPGGsoBHUUZ3lUGUkS
         rRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5EEshzyHNwusRFuCOt0szQsnkyTgNGdQE2tyPquGoU=;
        b=Y/5ErRGZoJ+vYuT/w3w+HZ1G1FMCdP5R9XQdk6zyLtUP/A5KvxzhsC37gOOfuh4H4u
         83Izqiq9SuPT2E/lX4qkiSWfRvnpc3Tpk48Le4EgCCgxeUP2FA3kVkKPKt5q7LthpN9c
         EgsmvdO7CzbLzoImOsNu+UHkmwjKqKBfCy0XUwVkN1iqXu4JpWr69TyndMTkW3OLmEVn
         /H02CT0UjEyN7NMKSX/4UWs8So9sU2jr/TQhbLZtMUNXcaKIqUGJPTE0uaP7TySTWG8s
         Waw1U0qdwiM9CnssZSJP2Tbhq2ksxsQWDZE8dggnTS1fPinSC97zgm7jFDEGaEDIycoi
         0rDw==
X-Gm-Message-State: AOAM532lgQi17Pt+f6BAhkEIdmRZGx2z7wvBWsvgpoMSiTDrRKmLeK4p
        YORfTYku0GwDkAmUFpGpR0uVh2j9/CxP6Q==
X-Google-Smtp-Source: ABdhPJyCk7PmW/kau7wrfLn7/h8GooW8S0lfGQlNro4L3Jf9qsrEuEeNGQkXyrzJqjU1RUb/N7ZBaw==
X-Received: by 2002:a05:600c:3b8c:b0:39c:60e3:36db with SMTP id n12-20020a05600c3b8c00b0039c60e336dbmr3025391wms.77.1655197753044;
        Tue, 14 Jun 2022 02:09:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b0039c948dbb61sm5835711wmb.26.2022.06.14.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 02:09:12 -0700 (PDT)
Message-Id: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
From:   "Brad Forschinger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 09:09:11 +0000
Subject: [PATCH] git-prompt: use builtin test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brad Forschinger <bnjf@bnjf.id.au>,
        Brad Forschinger <bnjf@bnjf.id.au>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brad Forschinger <bnjf@bnjf.id.au>

The test and [ commands are used throughout the prompt generation.  They
also happen to be valid function names that can be defined, leading to
unintentional results.  Prevent the somewhat unusual case of this
happening by simply using [[, which is reserved.

Signed-off-by: Brad Forschinger <bnjf@bnjf.id.au>
---
    git-prompt: use builtin test
    
    The test and [ commands are used throughout the prompt generation. They
    also happen to be valid function names that can be defined, leading to
    unintentional results. Prevent the somewhat unusual case of this
    happening by simply using [[, which is reserved.
    
    Signed-off-by: Brad Forschinger bnjf@bnjf.id.au

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1260%2Fbnjf%2Fprompt-use-builtins-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1260/bnjf/prompt-use-builtins-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1260

 contrib/completion/git-prompt.sh | 92 ++++++++++++++++----------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 87b2b916c03..e5a887a7c21 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -230,7 +230,7 @@ __git_ps1_show_upstream ()
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
-			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+			if [[ $pcmode = yes ]] && [[ $ps1_expanded = yes ]]; then
 				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
 				upstream="$upstream ${__git_ps1_upstream_name}"
@@ -266,7 +266,7 @@ __git_ps1_colorize_gitstring ()
 	local flags_color="$c_lblue"
 
 	local branch_color=""
-	if [ $detached = no ]; then
+	if [[ $detached = no ]]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
@@ -274,16 +274,16 @@ __git_ps1_colorize_gitstring ()
 	c="$branch_color$c"
 
 	z="$c_clear$z"
-	if [ "$w" = "*" ]; then
+	if [[ "$w" = "*" ]]; then
 		w="$bad_color$w"
 	fi
-	if [ -n "$i" ]; then
+	if [[ -n "$i" ]]; then
 		i="$ok_color$i"
 	fi
-	if [ -n "$s" ]; then
+	if [[ -n "$s" ]]; then
 		s="$flags_color$s"
 	fi
-	if [ -n "$u" ]; then
+	if [[ -n "$u" ]]; then
 		u="$bad_color$u"
 	fi
 	r="$c_clear$r"
@@ -294,7 +294,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
+	[[ -r "$1" ]] && IFS=$'\r\n' read "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
@@ -304,11 +304,11 @@ __git_eread ()
 __git_sequencer_status ()
 {
 	local todo
-	if test -f "$g/CHERRY_PICK_HEAD"
+	if [[ -f "$g/CHERRY_PICK_HEAD" ]]
 	then
 		r="|CHERRY-PICKING"
 		return 0;
-	elif test -f "$g/REVERT_HEAD"
+	elif [[ -f "$g/REVERT_HEAD" ]]
 	then
 		r="|REVERTING"
 		return 0;
@@ -399,8 +399,8 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=yes
-	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
-	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no
+	[[ -z "${ZSH_VERSION-}" ]] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
+	[[ -z "${BASH_VERSION-}" ]] || shopt -q promptvars || ps1_expanded=no
 
 	local repo_info rev_parse_exit_code
 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
@@ -408,12 +408,12 @@ __git_ps1 ()
 		--short HEAD 2>/dev/null)"
 	rev_parse_exit_code="$?"
 
-	if [ -z "$repo_info" ]; then
+	if [[ -z "$repo_info" ]]; then
 		return $exit
 	fi
 
 	local short_sha=""
-	if [ "$rev_parse_exit_code" = "0" ]; then
+	if [[ "$rev_parse_exit_code" = "0" ]]; then
 		short_sha="${repo_info##*$'\n'}"
 		repo_info="${repo_info%$'\n'*}"
 	fi
@@ -424,18 +424,18 @@ __git_ps1 ()
 	local inside_gitdir="${repo_info##*$'\n'}"
 	local g="${repo_info%$'\n'*}"
 
-	if [ "true" = "$inside_worktree" ] &&
-	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
-	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
+	if [[ "true" = "$inside_worktree" ]] &&
+	   [[ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ]] &&
+	   [[ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ]] &&
 	   git check-ignore -q .
 	then
 		return $exit
 	fi
 
 	local sparse=""
-	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
-	   [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
-	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
+	if [[ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ]] &&
+	   [[ -z "${GIT_PS1_OMITSPARSESTATE-}" ]] &&
+	   [[ "$(git config --bool core.sparseCheckout)" = "true" ]]; then
 		sparse="|SPARSE"
 	fi
 
@@ -443,34 +443,34 @@ __git_ps1 ()
 	local b=""
 	local step=""
 	local total=""
-	if [ -d "$g/rebase-merge" ]; then
+	if [[ -d "$g/rebase-merge" ]]; then
 		__git_eread "$g/rebase-merge/head-name" b
 		__git_eread "$g/rebase-merge/msgnum" step
 		__git_eread "$g/rebase-merge/end" total
 		r="|REBASE"
 	else
-		if [ -d "$g/rebase-apply" ]; then
+		if [[ -d "$g/rebase-apply" ]]; then
 			__git_eread "$g/rebase-apply/next" step
 			__git_eread "$g/rebase-apply/last" total
-			if [ -f "$g/rebase-apply/rebasing" ]; then
+			if [[ -f "$g/rebase-apply/rebasing" ]]; then
 				__git_eread "$g/rebase-apply/head-name" b
 				r="|REBASE"
-			elif [ -f "$g/rebase-apply/applying" ]; then
+			elif [[ -f "$g/rebase-apply/applying" ]]; then
 				r="|AM"
 			else
 				r="|AM/REBASE"
 			fi
-		elif [ -f "$g/MERGE_HEAD" ]; then
+		elif [[ -f "$g/MERGE_HEAD" ]]; then
 			r="|MERGING"
 		elif __git_sequencer_status; then
 			:
-		elif [ -f "$g/BISECT_LOG" ]; then
+		elif [[ -f "$g/BISECT_LOG" ]]; then
 			r="|BISECTING"
 		fi
 
-		if [ -n "$b" ]; then
+		if [[ -n "$b" ]]; then
 			:
-		elif [ -h "$g/HEAD" ]; then
+		elif [[ -h "$g/HEAD" ]]; then
 			# symlink symbolic ref
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
@@ -480,7 +480,7 @@ __git_ps1 ()
 			fi
 			# is it a symbolic ref?
 			b="${head#ref: }"
-			if [ "$head" = "$b" ]; then
+			if [[ "$head" = "$b" ]]; then
 				detached=yes
 				b="$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
@@ -502,7 +502,7 @@ __git_ps1 ()
 		fi
 	fi
 
-	if [ -n "$step" ] && [ -n "$total" ]; then
+	if [[ -n "$step" ]] && [[ -n "$total" ]]; then
 		r="$r $step/$total"
 	fi
 
@@ -515,41 +515,41 @@ __git_ps1 ()
 	local p="" # short version of upstream state indicator
 	local upstream="" # verbose version of upstream state indicator
 
-	if [ "true" = "$inside_gitdir" ]; then
-		if [ "true" = "$bare_repo" ]; then
+	if [[ "true" = "$inside_gitdir" ]]; then
+		if [[ "true" = "$bare_repo" ]]; then
 			c="BARE:"
 		else
 			b="GIT_DIR!"
 		fi
-	elif [ "true" = "$inside_worktree" ]; then
-		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
-		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
+	elif [[ "true" = "$inside_worktree" ]]; then
+		if [[ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]] &&
+		   [[ "$(git config --bool bash.showDirtyState)" != "false" ]]
 		then
 			git diff --no-ext-diff --quiet || w="*"
 			git diff --no-ext-diff --cached --quiet || i="+"
-			if [ -z "$short_sha" ] && [ -z "$i" ]; then
+			if [[ -z "$short_sha" ]] && [[ -z "$i" ]]; then
 				i="#"
 			fi
 		fi
-		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
+		if [[ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]] &&
 		   git rev-parse --verify --quiet refs/stash >/dev/null
 		then
 			s="$"
 		fi
 
-		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
-		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
+		if [[ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]] &&
+		   [[ "$(git config --bool bash.showUntrackedFiles)" != "false" ]] &&
 		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
 		then
 			u="%${ZSH_VERSION+%}"
 		fi
 
-		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
-		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
+		if [[ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ]] &&
+		   [[ "$(git config --bool core.sparseCheckout)" = "true" ]]; then
 			h="?"
 		fi
 
-		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+		if [[ -n "${GIT_PS1_SHOWUPSTREAM-}" ]]; then
 			__git_ps1_show_upstream
 		fi
 	fi
@@ -557,14 +557,14 @@ __git_ps1 ()
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
 	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
-	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+	if [[ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]]; then
+		if [[ $pcmode = yes ]] || [[ -n "${ZSH_VERSION-}" ]]; then
 			__git_ps1_colorize_gitstring
 		fi
 	fi
 
 	b=${b##refs/heads/}
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+	if [[ $pcmode = yes ]] && [[ $ps1_expanded = yes ]]; then
 		__git_ps1_branch_name=$b
 		b="\${__git_ps1_branch_name}"
 	fi
@@ -572,8 +572,8 @@ __git_ps1 ()
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 
-	if [ $pcmode = yes ]; then
-		if [ "${__git_printf_supports_v-}" != yes ]; then
+	if [[ $pcmode = yes ]]; then
+		if [[ "${__git_printf_supports_v-}" != yes ]]; then
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 		else
 			printf -v gitstring -- "$printf_format" "$gitstring"

base-commit: 5699ec1b0aec51b9e9ba5a2785f65970c5a95d84
-- 
gitgitgadget
