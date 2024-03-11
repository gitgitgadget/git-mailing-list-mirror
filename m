Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4141757
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164068; cv=none; b=gtwZyTD+Vrhkm+x3Gb6UeKkqCG3+k8nX0u8jiCJdSj6dvMSCz6oa6pH3zurO7SceW40jpyoVBeiBaJOW6kFrM9iTQjYzJAna0KQivreNBp79qM8yDb1RixPfkluZx7mhwWVf9yiBbSF4JYNzgZhUXawrgqd5gs0CzACewOQVXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164068; c=relaxed/simple;
	bh=mPZy5X07c4wa8LD03A0niDB2dXxK5srBBDWyvD7nT8M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FibRKWMcCjqJvG2SJLK1pQmvZDcdA0PZ43VtiLSnLQeI56FGGiV+OaSNtiay/eQ/o2bQ/bnZrGerBL+aV5VcqTbwlU/Hj6xi47lwQHgO2WYL6F2zFwUxBubSOcKdIlyOWPeLzfoB6V3uVk0Yowp7ZqlQLscqHHvA0nJm9z73CO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7pdEK0p; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7pdEK0p"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2664040276.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710164065; x=1710768865; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9ct3YOJPVW/N72n3Hmb/iJ1+nHxPRZrfI6KfHazniY=;
        b=X7pdEK0pWkwX/+w9avnNy86niubuLFCMkEaJlGoglVlhL9/sAlFGAh/3Gu1Foum1mj
         IJollBYpJBGu38EZX9h8DSwB5DVREoprL2GRw2JZxwndzMlGwBSxvnFdSSkXtK6NwK9/
         ZQj26GUmcbrZCE1zDdzzNu9qEEAvHj3PPumOWfQQLVdhNOQq/O3wQqoZH5zKciwTrDY/
         aifgckxJdwhf9NlW3OLIMBocmBhwCqzzJKHbpZqIDbjgZzx/rWsrqtnxqmLnwSRy29Ex
         yjCXmRl+stx+Lq2dA6o5U6PJVgH85207/iVlGnH0pCphfDhpgQ+uB7a+MUy8ip4IyZo4
         tKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710164065; x=1710768865;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9ct3YOJPVW/N72n3Hmb/iJ1+nHxPRZrfI6KfHazniY=;
        b=SeXeJ52i2QIUS8ob44w/wS5BKqxg8FXTtAOPWviCIhRckgbPbW4FSqbcvTbVO1mtss
         tOhC+qG6rynh6sOvDlZbxITmQHOCeZ7jMaZFAzlCrXhL4sB0eLqn5yuaGQkNf5Nh8qtY
         QJ2bZZQd5Rm0CqwcSHjuxNQWlJ/hKQ/7c4/A/4eySgjVUgjhno7FMNIdIdzepTsDQXUn
         GJ6Mc8iCbjdhfjm2kzUGlMfqgcTv4xdgCmuzVbNmS8USM1MRzWR8cUxboJDc4GsowvM1
         nAr8Y2dzx0P1i8ngQFVjUKa3R9pKVcGlsvDeiN4dWbvaf0x+/Ghm/Pn5hdCSLWXr4T6a
         WgIA==
X-Gm-Message-State: AOJu0YxU1E956xEiiJCDY/x2IAqWstL+zStERNaVfonVv1k6IB9PmxX+
	SeijkOssOysFoh2rkYgt8phzcDRqdZmQEuvAFQP7U5Bqt+0wwvtSLT/kR7MDg+9yAXSoWIeQNdr
	1+vEVC9M5cQJQnFv5Gt3Hq+dRjZYpctv0mkUUkw==
X-Google-Smtp-Source: AGHT+IHg3xm2U2LpHo+n+DUdI6PRl0zHgcQ8coZ0FRwbMawC8oRAlco3ONf8NbukgQa32ltnxnc7+BuVx0iPLJEapxs=
X-Received: by 2002:a25:a290:0:b0:dcc:8f97:4c42 with SMTP id
 c16-20020a25a290000000b00dcc8f974c42mr4416709ybi.13.1710164065055; Mon, 11
 Mar 2024 06:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: RQuadling@gmail.com
From: Richard Quadling <rquadling@gmail.com>
Date: Mon, 11 Mar 2024 13:34:14 +0000
Message-ID: <CAKUjMCUEmrC8XfVKC4AkCzDyqWziPjDh5EiNmx02xQF=SVBVzQ@mail.gmail.com>
Subject: Using git-prompt.sh is wrapping text to early in Bash.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The changes introduced in
https://github.com/git/git/commit/7ee1af8cb8b97385fc4e603bc024d877def5adb4
causes early wrapping of the command line whilst typing your commands
in Bash, when you are using the git-prompt.sh as part of the
PS1_COMMAND. I do not know about other platforms or shells.

The following setup is what I have:

GIT_PS1_COMPRESSSPARSESTATE=
GIT_PS1_DESCRIBE_STYLE=
GIT_PS1_HIDE_IF_PWD_IGNORED=yes
GIT_PS1_OMITSPARSESTATE=
GIT_PS1_SHOWCOLORHINTS=yes
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWUNTRACKEDFILES=yes
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_STATESEPARATOR=" "
PS1_PROMPT=' \\$ '
export PROMPT_COMMAND='__git_ps1 "$PS1_COMBINED" "$PS1_PROMPT";'

Change to any git directory:
cd ~/dev/GitHub/git

If all is setup properly for git-prompt.sh, you should see prompt similar to:
~/dev/GitHub/git (master|u=) $
depending upon your actual prompt.

Confirm things by running:
$ git remote -v

and I get:
origin git@github.com:git/git.git (fetch)
origin git@github.com:git/git.git (push)

Now start typing a LONG command.
echo 'This is a really long command that, as you start typing will
suddenly wrap around to the same line before it reaches the end of the
line'

The issue can be more greatly seen if you examine what is actually
added to the prompt.

My prompt has a more elements in it (datetime, shell level, count of
pushd's, whoiam@machinename.

So, if I run:
echo $PS1

I get ...

\001$(code=${?##0};echo ${code:+$(tput setaf 9)\002(${code})\
})\001$(tput sgr0)\002\001$(tput setaf 6)\002${PS1_SHELL_IN}\001$(tput
setaf 14)\002$SHLVL\001$(tput setaf 6)\002${PS1_SHELL_OUT} \001$(tput
sgr0)\002\001$(tput setaf 5)\002\D{%Y-%m-%d %H:%M:%S} \001$(tput
sgr0)\002\001$(tput setaf 6)\002\u\001$(tput sgr0)\002\001$(tput setaf
8)\002@\001$(tput sgr0)\002\001$(tput setaf 2)\002\h\001$(tput
sgr0)\002\001$(tput setaf 8)\002:\001$(tput sgr0)\002\001$(tput setaf
3)\002\w\001$(tput sgr0)\002\001$([[ $(dirs -p | wc -l) -gt 1 ]] &&
echo "\002 [\001$(dirs -p | wc -l | xargs)\001]\002")
(${__git_ps1_branch_name}|u=) \\$

You will notice a LOT of "\001" and "\002"s.

But none near the " (${__git_ps1_branch_name}|u=) " part.

To ensure that the current code in
https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh#L262
is actually sending out the "\001" and "\002", you can run
echo $PS1 | hexdump -C
I'm on MacOS, so the equivalent command that shows the hex and ASCII
output may be needed elsewhere to show this.

The output I see is

000001f0  5c 30 30 32 5c 30 30 31  24 28 5b 5b 20 24 28 64  |\002\001$([[ $(d|
00000200  69 72 73 20 2d 70 20 7c  20 77 63 20 2d 6c 29 20  |irs -p | wc -l) |
00000210  2d 67 74 20 31 20 5d 5d  20 26 26 20 65 63 68 6f  |-gt 1 ]] && echo|
00000220  20 22 5c 30 30 32 20 5b  5c 30 30 31 24 28 64 69  | "\002 [\001$(di|
00000230  72 73 20 2d 70 20 7c 20  77 63 20 2d 6c 20 7c 20  |rs -p | wc -l | |
00000240  78 61 72 67 73 29 5c 30  30 31 5d 5c 30 30 32 22  |xargs)\001]\002"|
00000250  29 20 28 01 1b 5b 33 32  6d 02 24 7b 5f 5f 67 69  |) (..[32m.${__gi|
00000260  74 5f 70 73 31 5f 62 72  61 6e 63 68 5f 6e 61 6d  |t_ps1_branch_nam|
00000270  65 7d 01 1b 5b 30 6d 02  7c 75 3d 29 20 5c 5c 24  |e}..[0m.|u=) \\$|
00000280  0a                                                |.|


In the ASCII output, you can see my "\001" and "\002"s.

But in the hexadecimal output, you can see `01` and `02`.

The following patch fixes this, resulting in the "\001" and "\002"s
being present in the PS1 environment variable.

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 71f179cba3..6585164efe 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -259,10 +259,10 @@ __git_ps1_colorize_gitstring ()
  else
  # Using \001 and \002 around colors is necessary to prevent
  # issues with command line editing/browsing/completion!
- local c_red=$'\001\e[31m\002'
- local c_green=$'\001\e[32m\002'
- local c_lblue=$'\001\e[1;34m\002'
- local c_clear=$'\001\e[0m\002'
+ local c_red=$'\\001\e[31m\\002'
+ local c_green=$'\\001\e[32m\\002'
+ local c_lblue=$'\\001\e[1;34m\\002'
+ local c_clear=$'\\001\e[0m\\002'
  fi
  local bad_color=$c_red
  local ok_color=$c_green


This is my first attempt to supply a patch to git considering it
pretty much never fails me!

If there is anything else needed, I hope I can provide it.

Regards.

Richard Quadling.
