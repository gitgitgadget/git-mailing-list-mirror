Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EB19E7FA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727662; cv=none; b=PC5ZWOCGRgb3xQM6VwDrk0RTPBw9vrSF/ZU7ZWWiCy7g1jZ/Sw+KwKCKlnpg14+DQt/3IvZ+BaVdnr74BJmt55s3vEPBYN4Lqb2Oy6R01T5wh3mt3tcZ/E7Um8sjMb0VniXAg2NSrpCuvp51xD5nrmkY2JK5NzrmebPcNj1BEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727662; c=relaxed/simple;
	bh=Y/eflf72LHbfyadXjodWb8yDEzd6vBwvAvyrlVdBjOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g2tgO5yFg1THLLt6N7QxWFxlDeLDO6FKcebdUdaid0/YXpm2PjfJrQgTzw31QqCgJILG5Nm8mQmqjTDgj2q3k1tCi2ELs49Ynp8viryBMl2WYEMzXrYHbJe9INZJnFYvSSxAP4pBGBFHdwQBIl2eEEX/I/aeF3/mQ3DZcH19OxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an54m3NI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an54m3NI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so6433685e9.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727659; x=1724332459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=an54m3NIPmXbWCm99pA057pPeUOIW5yjdkIjCVCn4c+YSq5Y/d8NGl9onr3tDFzY3Q
         61mg1p0Mu7N3Q03bI0BnXQCS2IrSdjxaPG8SaGWEeh3RrwQ96KkHhyWz5rd082y5SiiV
         4d7gwaHoumdgVRfKS+9c82eYnNxJsGf2yCPi6LvpZd9j0L1sjgh5nVenXisX4RkSs+3z
         kZnCt4vnsbJ7V78+9NL88I+CxhYons3NLmk6t3EaD/SSo6HEsk9DKpWOmgI6bcKegMVF
         WyxAx0yzN8AvPEy+7xEkEM8M/9K3VaEXkPueOx4VdpUR/oWzw+C8QGaPDq1EW7vwl9Yr
         1evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727659; x=1724332459;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=WIhnzNkY5iKp6AZBfWBAOSnpoN/4PBqTiTMUWOv4RHh8ZHACO4q20nL0/fShbNCi9w
         M1LTuroq4MIYXYpUUK9mxEg40k1eUYSPNg0yoO8aQHuzGFMxigL3+1UKBfarhIdO2pfH
         EYNvlEttXRsfDGnrtchb7Kgi3+9Re4Ijt/TXofC8n+8uOoMj9Y03K/VpL/tAQixooR3B
         g7EM1f6JDEeh8JC/bVe9rpC7Idv0bamrOAP004a7XQQTWlV8iZ5aLaqGW6k+VPaSVyna
         fAlzrLcFS38Cc0GwM/UKh54PDBnxaaYIDkolP25PdoiXgTrs55VAww8nnob6Wf4Md7Dr
         4wfw==
X-Gm-Message-State: AOJu0YzADeU+gKSuxjD/Uu7hyL5SRbsSW/NUqG+bBGtpe0ry4Prodiz5
	YZpAmsAp+dDrII7r7jopCItmdKgMhrePO7mttLdMmFqAeSxNS/XwBOQXfg==
X-Google-Smtp-Source: AGHT+IEd+yokNVrGXCNw+GQst608zoKOLRvwde4yytWpwsP9d+Qrfx7K26neDMyqT0la9aRmprkSQA==
X-Received: by 2002:a05:600c:1c0a:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-429dd23b13cmr38845145e9.9.1723727658491;
        Thu, 15 Aug 2024 06:14:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7df6248sm19751965e9.25.2024.08.15.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:18 -0700 (PDT)
Message-Id: <232340902a1feeafe526528eb88b8d0814d11545.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:09 +0000
Subject: [PATCH v2 4/8] git-prompt: replace [[...]] with standard code
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

The existing [[...]] tests were either already valid as standard [...]
tests, or only required minimal retouch:

Notes:

- [[...]] doesn't do field splitting and glob expansion, so $var
  or $(cmd...) don't need quoting, but [... does need quotes.

- [[ X == Y ]] when Y is a string is same as [ X = Y ], but if Y is
  a pattern, then we need:  case X in Y)... ; esac  .

- [[ ... && ... ]] was replaced with [ ... ] && [ ... ] .

- [[ -o <zsh-option> ]] requires [[...]], so put it in "eval" and only
  eval it in zsh, so other shells would not abort on syntax error
  (posix says [[ has unspecified results, shells allowed to reject it)

- ((x++)) was changed into x=$((x+1))  (yeah, not [[...]] ...)

Shells which accepted the previous forms:
- bash, zsh, ksh93, mksh, openbsd sh, pdksh.

Shells which didn't, and now can process it:
- dash, free/net bsd sh, busybox-ash, Schily Bourne sh, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 75c3a813fda..4781261f868 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -126,7 +126,7 @@ __git_ps1_show_upstream ()
 		case "$key" in
 		bash.showupstream)
 			GIT_PS1_SHOWUPSTREAM="$value"
-			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+			if [ -z "${GIT_PS1_SHOWUPSTREAM}" ]; then
 				p=""
 				return
 			fi
@@ -187,14 +187,14 @@ __git_ps1_show_upstream ()
 				upstream_type=${svn_upstream#/}
 				;;
 			esac
-		elif [[ "svn+git" = "$upstream_type" ]]; then
+		elif [ "svn+git" = "$upstream_type" ]; then
 			upstream_type="@{upstream}"
 		fi
 		;;
 	esac
 
 	# Find how many commits we are ahead/behind our upstream
-	if [[ -z "$legacy" ]]; then
+	if [ -z "$legacy" ]; then
 		count="$(git rev-list --count --left-right \
 				"$upstream_type"...HEAD 2>/dev/null)"
 	else
@@ -206,8 +206,8 @@ __git_ps1_show_upstream ()
 			for commit in $commits
 			do
 				case "$commit" in
-				"<"*) ((behind++)) ;;
-				*)    ((ahead++))  ;;
+				"<"*) behind=$((behind+1)) ;;
+				*)    ahead=$((ahead+1))   ;;
 				esac
 			done
 			count="$behind	$ahead"
@@ -217,7 +217,7 @@ __git_ps1_show_upstream ()
 	fi
 
 	# calculate the result
-	if [[ -z "$verbose" ]]; then
+	if [ -z "$verbose" ]; then
 		case "$count" in
 		"") # no upstream
 			p="" ;;
@@ -243,7 +243,7 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			upstream="|u+${count#*	}-${count%	*}" ;;
 		esac
-		if [[ -n "$count" && -n "$name" ]]; then
+		if [ -n "$count" ] && [ -n "$name" ]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
@@ -265,7 +265,7 @@ __git_ps1_show_upstream ()
 # their own color.
 __git_ps1_colorize_gitstring ()
 {
-	if [[ -n ${ZSH_VERSION-} ]]; then
+	if [ -n "${ZSH_VERSION-}" ]; then
 		local c_red='%F{red}'
 		local c_green='%F{green}'
 		local c_lblue='%F{blue}'
@@ -417,7 +417,7 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=yes
-	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
+	[ -z "${ZSH_VERSION-}" ] || eval '[[ -o PROMPT_SUBST ]]' || ps1_expanded=no
 	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no
 
 	local repo_info rev_parse_exit_code
@@ -502,11 +502,13 @@ __git_ps1 ()
 					return $exit
 				fi
 
-				if [[ $head == "ref: "* ]]; then
+				case $head in
+				"ref: "*)
 					head="${head#ref: }"
-				else
+					;;
+				*)
 					head=""
-				fi
+				esac
 				;;
 			*)
 				head="$(git symbolic-ref HEAD 2>/dev/null)"
@@ -542,8 +544,8 @@ __git_ps1 ()
 	fi
 
 	local conflict="" # state indicator for unresolved conflicts
-	if [[ "${GIT_PS1_SHOWCONFLICTSTATE-}" == "yes" ]] &&
-	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
+	if [ "${GIT_PS1_SHOWCONFLICTSTATE-}" = "yes" ] &&
+	   [ "$(git ls-files --unmerged 2>/dev/null)" ]; then
 		conflict="|CONFLICT"
 	fi
 
-- 
gitgitgadget

