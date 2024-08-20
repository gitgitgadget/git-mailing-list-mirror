Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEEC36B17
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118524; cv=none; b=fZGTKfZ8KvnD1ce9hTEondjCIdrk7HX0DphpyvuAeSLPnjO0DbkCmthcUeiQi2Jl4hqBYLahjdYHNzwkrW7ZTNjekTy0OoQrzcuJZoAsHsrglsW2TnZEfc/bcEJxzLAnmW38BR+qXDPFua8bAgriebxWVPgv9VpOF6fE9QjhxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118524; c=relaxed/simple;
	bh=+OzamXJet4poQcDjfbocCqRQTImWRURbURYBdomHj0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Th7UmImWR3sA5zciUARf4x67zHjsyRLZcdFvdtbgVaCB67Tf1MH0B/Nn/hrl0+9m9rvV1v1vVrpKKNcFjbXIGGO31NoybxaRVYwfXquU00KE1JPgI0OdNZXdfDZdKrA9GNtMzsAQSk4n/Ai351ZrXH/LbWdqdDYdGeP0kxHWBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6vlAY7F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6vlAY7F"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso3816677a12.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118520; x=1724723320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=S6vlAY7FqFIT0wbXG/D/919H5FCQPX0bGvjk3/ylILOqr4a3oWCD5HRWf+nQdN/k/M
         QoM0R5BZTU3GvTuIzW00TIkaLo19VxdUztVc/tXGyxKHWxVrYMeKa5B3EB+/cL1iWMIX
         /J4aHc/CSdoavDvDx1XoA5QdXPtCb0zIYP3CzDjwDcd7jCwg2Gpgh0QWX+gCHegoBkcZ
         RGxErltUrIX8YcIP6sjp/qbWBnafFNI4tAzPA9fAlmOhGx2q8m7bvPlsWvrfWVPe78S5
         oq0qitbR6C3LyqbuUghYEZwUTxEmdOzk7rZXE6zoqdX2BWlcrQwWuDuzMe3nnuoCruQm
         6J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118520; x=1724723320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=nAnQcNB57T6/ZBuUVJomv99A5LaKCGus8J8l/xve/vQtsHiFRHNFY1rwJ4u/rGugoP
         WeJKw09hywaUiFIOI9rbncn0+qZT3iX0s6aKsxayXFNVLqDGK1H6cCAnzk35hLtqckRD
         voctzSQs6F2f3HHIaG89q0pYx+J10LRWJ9lbsGP8fiRkGS1Ni/wyPOSCf384/H8QPc8A
         BZPowgpaiZf+vNbeVXV29o7Z+dTz178s1xhBAl7RCcHSre3zOIr71KRY/+qr7Fd1ij/q
         hDdsq+t93KskeMyFQIOkkoEK33cKxGNqD/S0tbpMHibQfBnM4EJr1f0VwsGpPwCGsiK9
         pQOg==
X-Gm-Message-State: AOJu0YzzH17xTqH/XcX0qdHzGc2Etrpy+LVX7wIRkV1X3JJT84DsJQly
	xF5NTYf1aaXMCYsoDA1nEiyze/BrqR9TfGQ+FVrUzbvrq9z/SYaVKXuNIg==
X-Google-Smtp-Source: AGHT+IEwA/iBGUtMTS0hIHvTPuexo2Pjnkq9jLooQJDT2NCXjYq06384Vytz8+XWuHxIJbgAMso06A==
X-Received: by 2002:a05:6402:4020:b0:5be:d7d8:49ac with SMTP id 4fb4d7f45d1cf-5bed7d84b61mr8064337a12.11.1724118520056;
        Mon, 19 Aug 2024 18:48:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f92dsm6147730a12.60.2024.08.19.18.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:39 -0700 (PDT)
Message-Id: <48aa31feedb117a687484651378fe682fe7c39c8.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:30 +0000
Subject: [PATCH v4 6/8] git-prompt: don't use shell $'...'
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

$'...' is new in POSIX (2024), and some shells support it in recent
versions, while others have had it for decades (bash, zsh, ksh93).

However, there are still enough shells which don't support it, and
it's cheap to use an alternative form which works in all shells,
so let's do that instead of dismissing it as "it's compliant".

It was agreed to use one form rather than $'...' where supported and
fallback otherwise.

shells where $'...' works:
- bash, zsh, ksh93, mksh, busybox-ash, dash master, free/net bsd sh.

shells where it doesn't work, but the new fallback works:
- all dash releases (up to 0.5.12), older versions of free/net bsd sh,
  openbsd sh, pdksh, all Schily Bourne sh variants, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 47 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5d7f236fe48..c3dd38f847c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -111,6 +111,12 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
+# like __git_SOH=$'\001' etc but works also in shells without $'...'
+eval "$(printf '
+	__git_SOH="\001" __git_STX="\002" __git_ESC="\033"
+	__git_LF="\n" __git_CRLF="\r\n"
+')"
+
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -118,7 +124,7 @@ __git_ps1_show_upstream ()
 	local key value
 	local svn_remotes="" svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
-	local LF=$'\n'
+	local LF="$__git_LF"
 
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
@@ -271,12 +277,16 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \001 and \002 around colors is necessary to prevent
-		# issues with command line editing/browsing/completion!
-		local c_red=$'\001\e[31m\002'
-		local c_green=$'\001\e[32m\002'
-		local c_lblue=$'\001\e[1;34m\002'
-		local c_clear=$'\001\e[0m\002'
+		# \001 (SOH) and \002 (STX) are 0-width substring markers
+		# which bash/readline identify while calculating the prompt
+		# on-screen width - to exclude 0-screen-width esc sequences.
+		local c_pre="${__git_SOH}${__git_ESC}["
+		local c_post="m${__git_STX}"
+
+		local c_red="${c_pre}31${c_post}"
+		local c_green="${c_pre}32${c_post}"
+		local c_lblue="${c_pre}1;34${c_post}"
+		local c_clear="${c_pre}0${c_post}"
 	fi
 	local bad_color="$c_red"
 	local ok_color="$c_green"
@@ -312,7 +322,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
+	test -r "$1" && IFS=$__git_CRLF read -r "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
@@ -430,19 +440,20 @@ __git_ps1 ()
 		return "$exit"
 	fi
 
+	local LF="$__git_LF"
 	local short_sha=""
 	if [ "$rev_parse_exit_code" = "0" ]; then
-		short_sha="${repo_info##*$'\n'}"
-		repo_info="${repo_info%$'\n'*}"
+		short_sha="${repo_info##*$LF}"
+		repo_info="${repo_info%$LF*}"
 	fi
-	local ref_format="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local inside_worktree="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local bare_repo="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local inside_gitdir="${repo_info##*$'\n'}"
-	local g="${repo_info%$'\n'*}"
+	local ref_format="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local inside_worktree="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local bare_repo="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local inside_gitdir="${repo_info##*$LF}"
+	local g="${repo_info%$LF*}"
 
 	if [ "true" = "$inside_worktree" ] &&
 	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
-- 
gitgitgadget

