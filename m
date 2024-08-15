Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F719F498
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727664; cv=none; b=btAGd82B99MFRFjO9Xst70PsRYDzB5JUFRYexld3Nt37/nmb1FcaCtpOtel3ErbxYbrKHPWASIXT9Uc0DfFgfz+pwuMHXWsTlaiW9AgGy63bN+hi2BJ1S42YPnthkkeNvYGqlFupVuDUgCWpiCG+Kp6yNqnpWwg15M+5Wfkkezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727664; c=relaxed/simple;
	bh=+OzamXJet4poQcDjfbocCqRQTImWRURbURYBdomHj0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ASmFQuFjlFc3zifkHgMHg7+sIZGRCKhocWjcyVK2867iAt0kZWA+cy99SoZwzWqgvsHE/b7k/05BS7H+xIFVRYFzOY2khmvMbXfDfZMm+wSHo2ydLMBQTgeo+hK9j5js0rTsHoSYobq3Bj4pKpzxNECtD6FgKnEEkzqKz+ONapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmDDl0q5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmDDl0q5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so5789675e9.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727660; x=1724332460; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=QmDDl0q5RwGPvTWqR6HAwPjIZUTf6gO5QqhboCbq9vwfitdm5ncmWycJw64+nJYICt
         mv9tfv0m+n4PisDjBHW7CijIx3AypHzSIU1ttPc5BK4TUNzMhG8fzD3q7RjEO18htWKj
         jrGGMAfyhQ+HsD+a7KIcwfJD/crbdGpa8I2HG78dd+B8a3TeC0JyRuh8him3/KyqQmZr
         wamjE2BgYtv2OVaET9P1HZGF4WPxYGfUvF0YzYRXeApB0/hVx9AIPpNKdfCx+fb5DQt9
         z2IBi8epXvFHch4c5JHUK8XfNRgX4Q7K7KEvoDrTDYspY4geO5OBBPU5Xu3ZLhMqaIRY
         DTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727660; x=1724332460;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=EnYzlpb0nVTmIPOOvv/3AOSAa3z0sdx5pqRrUjfnQFKz776aclOUpmoXcdrFKi+0YZ
         qzYVZtN/eZCDSkopDKbeixnWoa6cuxdUnSlD3oFhSdsjxaZQccgaUD/AfFiVzqo6p+8y
         R2ouwGGjLsCN/kVYc+RjbddYjVWGNsuYU0GnGqZcraoDbk4J/Gin2o0r1LSvy3XSMSlD
         MKs6NZ0Ou0bzfKOa5Jd03sOxzNWXPk21wZzm7C+yBY9sjeY18sZ2U0oItQaR0WZxXZaC
         osJU8gPHfBX2NKO+uah1L+/+GtIVND0uR0pf8bL6i7A17iyZhKJpkTxzANT4lGrWwOP5
         oNYg==
X-Gm-Message-State: AOJu0YwOp6sWnkVHuxVamiiFidqsStYkL4JJotyuCxLhuoWZT+wANUfh
	7MBJE7IDvzliajL6YWN4uWY7L9FUE8cvAWJj1um9mrmEJNBiRhRLGZGE3A==
X-Google-Smtp-Source: AGHT+IHiA3lGHKuO+SkA5QX2y5tflX8bK0KOdKjgBAA44Vu+ROlG6WPURl2UPZA9339pNTJxVioaEg==
X-Received: by 2002:a5d:6c6e:0:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-3717778ad57mr4497486f8f.17.1723727660024;
        Thu, 15 Aug 2024 06:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e10ddcsm19577055e9.32.2024.08.15.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:19 -0700 (PDT)
Message-Id: <363b7015763a0203771780d3af63eea903228d43.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:11 +0000
Subject: [PATCH v2 6/8] git-prompt: don't use shell $'...'
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

