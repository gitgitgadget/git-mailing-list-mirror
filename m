Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7E13DDD5
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762319; cv=none; b=QFcMgZ0jjaCAg1Tb1OKl8bE5xVbT5w5ux9berqrchHfSwxtd2FQo1nCGlnlYn1L0K0gOeIrb6/tFdXKzAAIZKZhL7U8zpIAO+VW+6Zwi6VCmxKCbgA0OSeJARGuYMGJvgFdQAyz6DIoKxkPHFUHfQ64g+O1Y/IC0fwwSLNgTpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762319; c=relaxed/simple;
	bh=6w00k9+c3G9p0OFCKpTfLoJYrHe7xtK6Q68P4pNSGFM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JxNLVEmgA7rqDq6y4HG80L/ceeMMkSQJKMkuT5Up3Fq4SKBdtrOCDF+cmkhUzWTnWAtIbGdcaMpqI8+19XF4lFSv2KI/CP/vHhMdnOaVpqGoYDIWumeYwzvSd4XZHigLMg/H0RtM//GwtUvOMCx8nCI43V9d/gcwwhgSwnnH02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaGbrvRM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaGbrvRM"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so5207199a12.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762315; x=1722367115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRA+5SmsjtaOpQD+SKfEoxPR3u9Wix32fAl2ggOOZmo=;
        b=XaGbrvRMuIsjcj7jbDcpJwUI1yFLNGHFjgYbg9T1bcTwjWs9iVVbpVinBehyKk958A
         N0b18DxPYtQeRgHmYZQO4zfdlxUM7PdKelM4a4DPqRhpg/n7oLUOnjKCi9YqwJwT0iJK
         HVnMVLxdOrwxIps7r7C2cBzaaFzpb0rlYsMTEUIKzVWxLgqgtM7el18KHrm/IsQ5PO1v
         1Lz1CboNx0lJOm9XpoWDWI0VPy1gK2RGdcNqIB41V4Uo8Ga8zCI4lJ70ZtN7/vNNbZAL
         iErwt4Q2NZaYg+FUs4HErniz3ikl2L8e+a6K812p8das4kGCRkMKuSBN5FdTnf5V9+Lf
         XTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762315; x=1722367115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRA+5SmsjtaOpQD+SKfEoxPR3u9Wix32fAl2ggOOZmo=;
        b=sGmMeCOveAmKWMC1G6ed4AhD1mwLm7g0pfWtpp1BuOzoHDzbth3n4NtTY+FE3ry7Zk
         JwnuzVAu/Z35eLgkqGDmmIwO6rZdWG+X+e/vneclw+Glz0MESwai+QzxaVdBo7ZE44Fp
         MGV7vb+ODOkjrsjtMg+fAAjmEUsj9UB17yo8VcjtstjO+P4NYfrVZIf6wmhtTUZoEBy3
         w2brHNQTEjNtyagwGfC6OIiGYWhhqQn5ac2GPhXzp7/AioK/ZxiulVQDqGNXfCEYmmvL
         3p28PqrZt2cxorNOZzHWC7XXYogvLPx8awpvCD4b/eBGaFV99EPQPCgSAZPfxDdAkekV
         ffYg==
X-Gm-Message-State: AOJu0YyF5S7Nfj7hdtfWPtXljE9XM0dTFmp4pni0dVihq0hOAJjl3NQ/
	b9XKi33tKB/ORL8ayOgbC0yUcHQOaa7ad9uv3hkYc6MCv16Ndtlsvv2IpA==
X-Google-Smtp-Source: AGHT+IHv7RZW/Y0P2jJkEpAWzQxRNZt96rKc9JKeE/KqYEKP3WgD0Ah0kar6PF4RIWrB/EcNhu9b7w==
X-Received: by 2002:a50:d6dc:0:b0:5a0:f8a2:9cf5 with SMTP id 4fb4d7f45d1cf-5a3f089d878mr7217660a12.29.1721762314778;
        Tue, 23 Jul 2024 12:18:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6e67sm7920210a12.17.2024.07.23.12.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:34 -0700 (PDT)
Message-Id: <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:23 +0000
Subject: [PATCH 5/8] git-prompt: add some missing quotes
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

The issues which this commit fixes are unlikely to be broken
in real life, but the fixes improve correctness, and would prevent
bugs in some uncommon cases, such as weird IFS values.

Listing some portability guideline here for future reference.

I'm leaving it to someone else to decide whether to include
it in the file itself, place is as a new file, or not.

---------

The command "local" is non standard, but is allowed in this file:
- Quote initialization if it can expand (local x="$y"). See below.
- Don't assume initial value after "local x". Either initialize it
  (local x=..), or set before first use (local x;.. x=..; <use $x>).
  (between shells, "local x" can unset x, or inherit it, or do x= )

Other non-standard features beyond "local" are to be avoided.

Use the standard "test" - [...] instead of non-standard [[...]] .

--------

Quotes (some portability things, but mainly general correctness):

Quotes prevent tilde-expansion of some unquoted literal tildes (~).
If the expansion is undesirable, quotes would ensure that.
  Tilds expanded: a=~user:~/ ;  echo ~user ~/dir
  not expanded:   t="~"; a=${t}user  b=\~foo~;  echo "~user" $t/dir

But the main reason for quoting is to prevent IFS field splitting
(which also coalesces IFS chars) and glob expansion after parameter
expansion or command substitution.

In _command-arguments_, expanded/substituted values must be quoted:
  Good: [ "$mode" = yes ]; local s="*" x="$y" e="$?" z="$(cmd ...)"
  Bad:  [ $mode = yes ];   local s=*   x=$y   e=$?   z=$(cmd...)

Still in _agumemts_, no need to quote non-expandable values:
  Good:                 local x=   y=yes;   echo OK
  OK, but not required: local x="" y="yes"; echo "OK"
But completely empty (NULL) arguments must be quoted:
  foo ""   is not the same as:   foo

Assignments in simple commands - with or without an actual command,
don't need quoting becase there's no IFS split or glob expansion:
  Good:   s=* a=$b c=$(cmd...)${x# foo }${y-   } [cmd ...]
  It's also OK to use double quotes, but not required.

This behavior (no IFS/glob) is called "assignment context", and
"local" does not behave with assignment context in some shells,
hence we require quotes when using "local" - for compatibility.

First value in 'case...' doesn't IFS-split/glob, doesn't need quotes:
  Good:       case  * $foo $(cmd...)  in ... ; esac
  identical:  case "* $foo $(cmd...)" in ... ; esac

Nested quotes in command substitution are fine, often necessary:
  Good: echo "$(foo... "$x" "$(bar ...)")"

Nested quotes in substring ops are legal, and sometimes needed
to prevent interpretation as a pattern, but not the most readable:
  Legal:  foo "${x#*"$y" }"

Nested quotes in "maybe other value" subst are invalid, unnecessary:
  Good:  local x="${y- }";   foo "${z:+ $a }"
  Bad:   local x="${y-" "}"; foo "${z:+" $a "}"
Outer/inner quotes in "maybe other value" have different use cases:
  "${x-$y}"  always one quoted arg: "$x" if x is set, else "$y".
  ${x+"$x"}  one quoted arg "$x" if x is set, else no arg at all.
  Unquoted $x is similar to the second case, but it would get split
  into few arguments if it includes any of the IFS chars.

Assignments don't need the outer quotes, and the braces delimit the
value, so nested quotes can be avoided, for readability:
  a=$(foo "$x")  a=${x#*"$y" }  c=${y- };  bar "$a" "$b" "$c"

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4781261f868..5d7f236fe48 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -246,7 +246,7 @@ __git_ps1_show_upstream ()
 		if [ -n "$count" ] && [ -n "$name" ]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
-			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+			if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
 				upstream="$upstream ${__git_ps1_upstream_name}"
@@ -278,12 +278,12 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue=$'\001\e[1;34m\002'
 		local c_clear=$'\001\e[0m\002'
 	fi
-	local bad_color=$c_red
-	local ok_color=$c_green
+	local bad_color="$c_red"
+	local ok_color="$c_green"
 	local flags_color="$c_lblue"
 
 	local branch_color=""
-	if [ $detached = no ]; then
+	if [ "$detached" = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
@@ -360,7 +360,7 @@ __git_sequencer_status ()
 __git_ps1 ()
 {
 	# preserve exit status
-	local exit=$?
+	local exit="$?"
 	local pcmode=no
 	local detached=no
 	local ps1pc_start='\u@\h:\w '
@@ -379,7 +379,7 @@ __git_ps1 ()
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
-		*)	return $exit
+		*)	return "$exit"
 		;;
 	esac
 
@@ -427,7 +427,7 @@ __git_ps1 ()
 	rev_parse_exit_code="$?"
 
 	if [ -z "$repo_info" ]; then
-		return $exit
+		return "$exit"
 	fi
 
 	local short_sha=""
@@ -449,7 +449,7 @@ __git_ps1 ()
 	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
 	   git check-ignore -q .
 	then
-		return $exit
+		return "$exit"
 	fi
 
 	local sparse=""
@@ -499,7 +499,7 @@ __git_ps1 ()
 			case "$ref_format" in
 			files)
 				if ! __git_eread "$g/HEAD" head; then
-					return $exit
+					return "$exit"
 				fi
 
 				case $head in
@@ -597,10 +597,10 @@ __git_ps1 ()
 		fi
 	fi
 
-	local z="${GIT_PS1_STATESEPARATOR-" "}"
+	local z="${GIT_PS1_STATESEPARATOR- }"
 
 	b=${b##refs/heads/}
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+	if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 		__git_ps1_branch_name=$b
 		b="\${__git_ps1_branch_name}"
 	fi
@@ -612,7 +612,7 @@ __git_ps1 ()
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
-	if [ $pcmode = yes ]; then
+	if [ "$pcmode" = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 		else
@@ -623,5 +623,5 @@ __git_ps1 ()
 		printf -- "$printf_format" "$gitstring"
 	fi
 
-	return $exit
+	return "$exit"
 }
-- 
gitgitgadget

