Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F3200A3
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118522; cv=none; b=E5hLa41bmzTOmRRDhAcV4m/stQg9FUZI2nD72VbCaal6neYfQJCDqMsfTjz1VnT5X/rCPM6Gwa1DVvDFAHMn/pm68YsREmcW0I8hpqW34s2OjzgbY+SWGSH6sV03Q30y9aZT2gGDzAauv9qPhcnY5okGmrsTrt+eTI7glswlXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118522; c=relaxed/simple;
	bh=Y/eflf72LHbfyadXjodWb8yDEzd6vBwvAvyrlVdBjOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q5RTjR89HCGEqLOir8YW919QOt3UZ/TML2EVJk0firuKO/dSWwBNTGdSGoVIL4DsYVA6NBgo+b+2DWo9aXvN9zPXlA9r6rXGb0MNPNy3az6fJY5TCOfx6NicepLCH3MgNap8WhxVK7ojNFAXr0Dt/NrCjCvo3iFURZpqN1uKPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYI0g08V; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYI0g08V"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so6775721a12.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118518; x=1724723318; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=XYI0g08VCMaVQQ0zEyzaudL63s47yGw830tdICWb0mDzzOLN6F2UQsBvi4dO9a6jNS
         IdxWzY0BbU9Ph0gMQj9DQ+K2dcbsDwPs0xTMLIt7Shs1E0vmvnYpVHQ2DzHsehT8vGcZ
         UCYQs+z5G1AacEWY8+/S8SHpSGi1wC424wd2LS3i78RTRkFiwiW/mkgLBH2isWmBPF5W
         jL7Qelgun4I6QhG41tuLV9KRMCv5TGyaB4XVmTxRoMWV13jvc6dd3guudAjyCEOlMKU3
         RLCRSghZgM8iHM3qK1Wmnu18v38BJTwa4BI03w0Nx3OERaxHqTJa2P/Vt0n/R8Rz/S53
         MgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118518; x=1724723318;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=S84fh3JsQH+jVxYrbwrHLAuJCZ6rBUMo32cDM7lS12bEdp9cMduAJsHQnlzeAz7t9P
         N7RInQFhVCigbLkIGy3a9DlnyzVElS/nTObS2D6sHynYpEXwdbbNSfXK5LuL83e+45wc
         sBLbZUP7UO0Gt9qtxMSNlovbT8g8IbsFJ8skJ8WGQTG733sICf8IOb/w9VjW/iWVKL0I
         Gmdw5brb1JtUrVVQSWDQ+f/Wd0Rhw9wSIunKUgKPSI4eKZC7t0Cz+Z3Zq+pqFnz1rPpx
         qi0PmNfcanFabahDXKppHDHpR/bNQROdB03fPZFRZn/h7hK/c7Gg0x1yEB0rS4CX3Yix
         3L+A==
X-Gm-Message-State: AOJu0YwZ9O20wAz8eyzMkM6FFBH1i7xpkdOh1bVrozB+nhk1p3y+qWA+
	CaxsjMkMIAlaYxjGnNfotZtJfoSpgQ84GnKd8Unyazgz3Jk58C0LLhvfVw==
X-Google-Smtp-Source: AGHT+IFkPLEtgf0B/3DwpiGJicD7Qe4Ff3oTn2Z5YMM0jPamkF2zlG90JVR8f0FqbMD5Ldxh+esH3A==
X-Received: by 2002:a05:6402:2087:b0:5be:ddbf:c81e with SMTP id 4fb4d7f45d1cf-5bf0ac39256mr1210828a12.12.1724118518026;
        Mon, 19 Aug 2024 18:48:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48e7sm6341294a12.26.2024.08.19.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:37 -0700 (PDT)
Message-Id: <232340902a1feeafe526528eb88b8d0814d11545.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:28 +0000
Subject: [PATCH v4 4/8] git-prompt: replace [[...]] with standard code
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
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

