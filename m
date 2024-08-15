Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC219DF9C
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727661; cv=none; b=pZAXmZ5kIVp2g+HlPEFBFhTihkjrZAaNlZytVBpEnh42W0el0JpBmIBuS+7/8hrKcSdJxb3yoVhbRyS2fpoTmXSJ1VSpnForv+QQK5yRhxTlWny6AgWpBaifWbYr9IrxORdllSVpPPc/cJ7U75vmxeckCyE3TG2rxa9hMZpnbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727661; c=relaxed/simple;
	bh=p/jqA9gX8l00DDL8hIGrnZJ3zN3+zLxdtSLBkGRh4Gs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TbAxAX6Ei3gycRdK9hjKm8KgOOijep9aJGkmaWywapmzAsX8DZACimLHLbfzKKeLkhIru/C2q/g8FSBZtY0FNJ6PZbmYJwIEBzoyJ7VISfhqbZVYMCWZrvKMTtffW3lPEIgnHKRrTpN4IWavPh+MDyN9io2r4Hf8J5JkS8EtKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EujOy0dK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EujOy0dK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428243f928cso5977425e9.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727658; x=1724332458; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scQQcYhZj7QegWybZvw4rIUqVDfa3YFL+8LLt/4ZwzY=;
        b=EujOy0dKu1yLD2O3sdFCQy7xBrX0nrDPoNzAIHDiInny8pzcPBb25A8ujCH24HAExR
         peMEUvVyeVD5vXFMZuYqoBGwUidRRiuD2EY8AgjbfSgSFYYbiwBA7bDiyd4P31j0LzrM
         8YPEaau12wSrH1N5+67Jhe8FdFmpgdhf1VlemDmeyicagcaA8C9amUKegMplUHgq4WQV
         dLFMSF8TxBcIKnEPNYPKJF0Yq1YGw8mmzs77JceegjM+g9Mk9hCDR1qW8QFkaDL6nkR1
         cJ7Mq1OWWepI17jGvUL7XVFae91Ixz76UXDsuIBXym0vX0gWO8iKCEl6a7NhsSl4zQjF
         MzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727658; x=1724332458;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scQQcYhZj7QegWybZvw4rIUqVDfa3YFL+8LLt/4ZwzY=;
        b=H0OkVdLUETO5fDJIM+elJiDf3y3pQR3WU4i48MWS5FOW/IrKh7AH70z4eDqHgOE48l
         zqoa1Xk230+55gM4busfU+enAYw8ft1zyINTEVbnQr3on640ZpRgPD3ACSFGrJp4x3ew
         feoN+LOjnvRv8EhC7laSy8f8obN01sFJ5KrrmcbXkkWzyzidpVmABa5PXaUzZNxwytd0
         DdVC4bgtcGFVaVON12up0it3T95EoMudbBslSAPHNC6FxE87NDHqMvYprLhxp86v0BAu
         C7Q9nMa85Hd7EDzznIFOKvbVVwVnI7flwM9yskQ5HWj2Dei7LLvCrjN2ocStvap9IWN/
         bBig==
X-Gm-Message-State: AOJu0YxXxNSGRbQo0MlJemuIxLGorvJ5SCpzR8lPy8DIXliZDTP2Zk1M
	J8XKLdL3wrLd1AwOCtidhuJoVHXluyxz1YrJUYTp4G9azFBEZ92kr0W/Sg==
X-Google-Smtp-Source: AGHT+IHE8/8vRwv6nudsPW+GO0RLW7aoJkgtVqf5MYnfa6C3Hea5a9oxDu6QLdvAlMuvH4yibpwQ7A==
X-Received: by 2002:a05:6000:1b83:b0:368:3789:1a2 with SMTP id ffacd0b85a97d-37177771c37mr3908609f8f.21.1723727657661;
        Thu, 15 Aug 2024 06:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7df64e5sm19984535e9.28.2024.08.15.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:17 -0700 (PDT)
Message-Id: <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:08 +0000
Subject: [PATCH v2 3/8] git-prompt: don't use shell arrays
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

Arrays only existed in the svn-upstream code, used to:
- Keep a list of svn remotes.
- Convert commit msg to array of words, extract the 2nd-to-last word.

Except bash/zsh, nearly all shells failed load on syntax errors here.

Now:
- The svn remotes are a list of newline-terminated values.
- The 2nd-to-last word is extracted using standard shell substrings.
- All shells can digest the svn-upstream code.

While using shell field splitting to extract the word is simple, and
doesn't even need non-standard code, e.g. set -- $(git log -1 ...),
it would have the same issues as the old array code: it depends on IFS
which we don't control, and it's subject to glob-expansion, e.g. if
the message happens to include * or **/* (as this commit message just
did), then the array could get huge. This was not great.

Now it uses standard shell substrings, and we know the exact delimiter
to expect, because it's the match from our grep just one line earlier.

The new word extraction code also fixes svn-upstream in zsh, because
previously it used arr[len-2], but because in zsh, unlike bash, array
subscripts are 1-based, it incorrectly extracted the 3rd-to-last word.
symptom: missing upstream status in a git-svn repo: u=, u+N-M, etc.

The breakage in zsh is surprising, because it was last touched by
  commit d0583da838 (prompt: fix show upstream with svn and zsh),
claiming to fix exactly that. However, it only mentions syntax fixes.
It's unclear if behavior was fixed too. But it was broken, now fixed.

Note LF=$'\n' and then using $LF instead of $'\n' few times.
A future commit will add fallback for shells without $'...', so this
would be the only line to touch instead of replacing every $'\n' .

Shells which could run the previous array code:
- bash

Shells which have arrays but were broken anyway:
- zsh: 1-based subscript
- ksh93: no "local" (the new code can't fix this part...)
- mksh, openbsd sh, pdksh: failed load on syntax error: "for ((...))".

More shells which Failed to load due to syntax error:
- dash, free/net bsd sh, busybox-ash, Schily Bourne shell, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 48 ++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4cc2cf91bb6..75c3a813fda 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,10 +116,10 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern="" count n
+	local svn_remotes="" svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
+	local LF=$'\n'
 
-	svn_remote=()
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
 	while read -r key value; do
@@ -132,7 +132,7 @@ __git_ps1_show_upstream ()
 			fi
 			;;
 		svn-remote.*.url)
-			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
+			svn_remotes=${svn_remotes}${value}${LF}  # URI\nURI\n...
 			svn_url_pattern="$svn_url_pattern\\|$value"
 			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
@@ -156,25 +156,37 @@ __git_ps1_show_upstream ()
 	case "$upstream_type" in
 	git)    upstream_type="@{upstream}" ;;
 	svn*)
-		# get the upstream from the "git-svn-id: ..." in a commit message
-		# (git-svn uses essentially the same procedure internally)
-		local -a svn_upstream
-		svn_upstream=($(git log --first-parent -1 \
-					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
-		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
-			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
-			svn_upstream=${svn_upstream%@*}
-			local n_stop="${#svn_remote[@]}"
-			for ((n=1; n <= n_stop; n++)); do
-				svn_upstream=${svn_upstream#${svn_remote[$n]}}
-			done
+		# successful svn-upstream resolution:
+		# - get the list of configured svn-remotes ($svn_remotes set above)
+		# - get the last commit which seems from one of our svn-remotes
+		# - confirm that it is from one of the svn-remotes
+		# - use $GIT_SVN_ID if set, else "git-svn"
 
-			if [[ -z "$svn_upstream" ]]; then
+		# get upstream from "git-svn-id: UPSTRM@N HASH" in a commit message
+		# (git-svn uses essentially the same procedure internally)
+		local svn_upstream="$(
+			git log --first-parent -1 \
+				--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null
+		)"
+
+		if [ -n "$svn_upstream" ]; then
+			# extract the URI, assuming --grep matched the last line
+			svn_upstream=${svn_upstream##*$LF}  # last line
+			svn_upstream=${svn_upstream#*: }    # UPSTRM@N HASH
+			svn_upstream=${svn_upstream%@*}     # UPSTRM
+
+			case ${LF}${svn_remotes} in
+			*"${LF}${svn_upstream}${LF}"*)
+				# grep indeed matched the last line - it's our remote
 				# default branch name for checkouts with no layout:
 				upstream_type=${GIT_SVN_ID:-git-svn}
-			else
+				;;
+			*)
+				# the commit message includes one of our remotes, but
+				# it's not at the last line. is $svn_upstream junk?
 				upstream_type=${svn_upstream#/}
-			fi
+				;;
+			esac
 		elif [[ "svn+git" = "$upstream_type" ]]; then
 			upstream_type="@{upstream}"
 		fi
-- 
gitgitgadget

