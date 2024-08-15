Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425419EED2
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727663; cv=none; b=sENrhGO/kFPX3MIbklxMCwLRNrfzCMMBYk5RwBugs46RM/rXYq2zrw1wn622g36mQnAFxyIWekK9oC414SIRTd+cs6Cd41DGONL2ox7e+3af8gpSlkAza+Rq/2SA7yL+O5tAdg/ppbzp7AUuxLekhYf6QItUazqCgDTcAKZk1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727663; c=relaxed/simple;
	bh=6w00k9+c3G9p0OFCKpTfLoJYrHe7xtK6Q68P4pNSGFM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hsOywskMWzv8ADp3d+9OCEkjnO7W11zqcPpszpuBMqm60LMJX9O0YYnOKjvFiIHN06Zw3QeozHZYmLIEBY6p1pkoq7JjiKRi7joFltPMBkptg8Du0CKvrLHZ4tQocw1/ZBbvgUPn8/y2t5L8531+cM0YoMKeF0vpN2nkiUE+dD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkAWhc9s; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkAWhc9s"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-369f68f63b1so529482f8f.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727659; x=1724332459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRA+5SmsjtaOpQD+SKfEoxPR3u9Wix32fAl2ggOOZmo=;
        b=mkAWhc9sGiyg6/c6J71R5QIYSbzjMdp5wsFQ5G7XlKQH7ADHDH5cJKGAAHfyTMt9o+
         YyPuuBzMwnkoLfUQ70S02yWDdYjnWeY5ZdVwpf+OAlzISkp6RqG2g9D0j0mqTyFAIM46
         IWova5W6xK7NWP9cCh9i8iths1sdRAO/9qgQJV0h7nuh3CG7gy4InjaZbfoiyLMcOM86
         jR7ELwpSbFHNEqmUEflw1y4IfyJj4K03WqXZ8NdnVJb4v5Dwx7shRSDCXkImTNOFWRX+
         DAo4K0BYQAPFO7LkRdgKwOCY7HRrfd+ijmSDo6bKsEtHTw1FN+VeGQYhPFAyfYa4o5fj
         XEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727659; x=1724332459;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRA+5SmsjtaOpQD+SKfEoxPR3u9Wix32fAl2ggOOZmo=;
        b=WfgoBvh9Kiy3dN+S3E9O6TohGQsSd3/UoTUCD8ZBBGHidxMy7klUKMhAAEpRD1w5fu
         5Z7Ti/0S1EhepMVM7R8VwuC0gEYoVufpXxBEOFnZWILhgXkQ+8TDAVOxXedMaWGLpzRV
         CMZKOloO8uIqY35kRlrsvpPeJZWRODW0fgq/XPj6hxwtHmjjm0AbayYMjZNKW9C6u9Bl
         2/Pl4mtQn/scNVK9+cYGuOpFWeLODK290SxpyDL3HC5cYoUYZO1P1ojAeMud5eGKn0ZA
         i+fy+Zng1pX9b3BPpH21hvKz2sXlvBlat829wmdsO0OQ8IZ4uao3ORxcUDzp2fUfvp3S
         tfSQ==
X-Gm-Message-State: AOJu0YzhWBWjxSDNoovJnvblSbuKZhyZ15hoAsSo3dWcZMMKjkkS2s68
	0YLxSA+Xjk9TBrf0bd7zjRahXQIQ0Bcvmr+VZpq4vLL6sFCmP9/Sw1tacw==
X-Google-Smtp-Source: AGHT+IFVPmBcSXBMppT2CSsIuTEZxVReGjLIH6TrZIpiwrUymnfj84s7NsRp5d+65h57zyay3Vzhkw==
X-Received: by 2002:adf:c784:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-371778091a3mr4551688f8f.45.1723727659238;
        Thu, 15 Aug 2024 06:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded29fcfsm49424485e9.20.2024.08.15.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:18 -0700 (PDT)
Message-Id: <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:10 +0000
Subject: [PATCH v2 5/8] git-prompt: add some missing quotes
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

