Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D51428EA
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762319; cv=none; b=srkVsr5+7+kr38uwNXZMIT7p8OO/Mog4yETHCaRH3yIyvv747ig6jbB39LJcLFoo1XCW8vJLlBTXHiMIdThfDTcK+Mwt4C8hDH5/3DKVnyC2THAEALr5IIy0WcWoojuM77aqitCNERatv5AzU1fAC+H7znZu2fbTmIhXsPw1qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762319; c=relaxed/simple;
	bh=Q2XHlLPDSA59hcZLR19KMhng2ZRaD9lLdamc7EC/GfY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eW0TE63aqmJlXqPugQJUHYtMMgAjc4eV0NPO5MTvbRrp3HR7f5pmvTSs2iWYD7Fxuw0XUaTDTYBp/cSaywq4qRF4HTwJKEplgqarDJydYtc4Tl13woaM1O2bJWVpn525PdNk2jq7vFpNHbEYSOLeGo96HUvZNpHDD4ztr1QOmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYiZ6hzn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYiZ6hzn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9a369055so101080366b.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762315; x=1722367115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+v+ejSTc6SCQMvsFihFgg/BNnm4VCnNTZNOsUxclIY=;
        b=IYiZ6hzn4kd2Wd0xtUrgWk6zEtx5K6PXKz7nJrIeysjLGd7FRHty/haosY3OJXt4mE
         Wb4SeQtTV5annYY/9UcNnZsebzZGG2nuOKeokCr3+6h3dKzYrrOfX1+xxycFEF1Su2TR
         Nqw00czmFKeqziHEdN5dXvPFExuy0UBV/vJlCiVm8gmVr3JmuJCsYExU6lJKCtKJI23n
         F6a/HFYprMrWUhVF9qvQvBSlIotZVS8Zo5wHunJU7eJ2p91qx719p9N8swK5fcUc1KdO
         1p92L3cjBmMHJWrY5D2usYZVEG/n2+OuJRJEnOJYFCr0nEOgUbywn6wjhXmN1OUGf3Wh
         HBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762315; x=1722367115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+v+ejSTc6SCQMvsFihFgg/BNnm4VCnNTZNOsUxclIY=;
        b=ZIzDET3NfSnJxfib3MsefCyYXWZ0JANx4wXw6vaTqSevdNrAwhJUafiuKN0Ai08fmx
         8Xh++fK/iLAFrnSzjHPbqdIkM7e/V6GmKtmYEEfEWvQa74pWEoP1cl9q7iCklxR7gzpd
         bQBy8AvyverhpwxulPdl2ofI2Opz4ejtIdFpSGrQg5o29Epq+7LZcT1raVSh0kImsmzO
         n+Ea4WRb+MFm3mHoLi1LjV2KLVxNnJ2lcjBExtDa6/ptn/+Jy2nmwXU2uMojCl4KUuAV
         RD8ljGEgGw6pbzg2JfFMogZX9YOolvVbC5JDXx0qHtCAWL1cxEmL1u06a2rVWIRCnwy6
         b/zg==
X-Gm-Message-State: AOJu0YyOA/2kF3aob8CZn3IZq7DiutXwlgWmn4m07Ah4be+Tuc5+Mvmz
	QbihWIlX9vGFPkbhQ1XWlFVrcd96Np3tXT8njTYiiKpXqt2veu4lm7tKdw==
X-Google-Smtp-Source: AGHT+IGOmvt+GP8/Q24rPlB36x66ZlbWQyRyoEjAsXChuGSUkdb/h+9qovgcGty2we/nZGYXh4Hc9g==
X-Received: by 2002:a17:907:97c4:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7a4c0100c6mr801110066b.16.1721762315522;
        Tue, 23 Jul 2024 12:18:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c9508d3sm569281866b.204.2024.07.23.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:35 -0700 (PDT)
Message-Id: <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:24 +0000
Subject: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

$'...' is new in POSIX (2024), and some shells support it in recent
versions, while others have had it for decades (bash, zsh, ksh93).

However, there are still enough shells which don't support it, and
it's cheap to provide a fallback for them, so let's do that instead
of dismissing it as "it's compliant".

shells where $'...' works:
- bash, zsh, ksh93, mksh, busybox-ash, dash master, free/net bsd sh.

shells where it doesn't work, but the new fallback works:
- all dash releases (up to 0.5.12), older versions of free/net bsd sh,
  openbsd sh, pdksh, all Schily Bourne sh variants, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 52 +++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5d7f236fe48..bbc16417ac9 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -111,6 +111,17 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
+__git_SOH=$'\1' __git_STX=$'\2' __git_ESC=$'\33'
+__git_LF=$'\n' __git_CRLF=$'\r\n'
+
+if [ $'\101' != A ]; then  # fallback for shells without $'...'
+   __git_CRLF=$(printf "\r\n\1\2\33")  # CR LF SOH STX ESC
+   __git_ESC=${__git_CRLF#????}; __git_CRLF=${__git_CRLF%?}
+   __git_STX=${__git_CRLF#???};  __git_CRLF=${__git_CRLF%?}
+   __git_SOH=${__git_CRLF#??};   __git_CRLF=${__git_CRLF%?}
+   __git_LF=${__git_CRLF#?}
+fi
+
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -118,7 +129,7 @@ __git_ps1_show_upstream ()
 	local key value
 	local svn_remotes="" svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
-	local LF=$'\n'
+	local LF="$__git_LF"
 
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
@@ -271,12 +282,16 @@ __git_ps1_colorize_gitstring ()
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
@@ -312,7 +327,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
+	test -r "$1" && IFS=$__git_CRLF read -r "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
@@ -430,19 +445,20 @@ __git_ps1 ()
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

