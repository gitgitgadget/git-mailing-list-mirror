Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76419FA90
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727665; cv=none; b=dA2d36fUb55f3nnLCiLS9b1kmSA2RNl4bLd6zuzb1riYInxvhgSZeCHRa0fkSW789HiQ6RZMVKYgwYZB0GxruXWbMsfVv5+pOarrvqQU/AWogxavYlyZiEzyOqJeAwiZ73nrC75yK9yUhvt4YaHEEXSW1qVJOXG2jdUj+q5pW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727665; c=relaxed/simple;
	bh=gH9B24is8SQhLK5rY5yQAUkz/w2jM26CevbBiWLH/tg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=azvI1lfPcOG4gNsWgBNb6gGsF2UKOSJYq7TTqkQu6OEmZAccWbY3A+piXvS7bZx/ycNhbPq38p8oUVCJZlqcQgMWEhErsgxMh4JWDuuQ+CiiGeejQP2i2AZRuL2UEUi1Hzhlw+z3RwDkEG+qtPPIhyy4g+NuoBbX9dgEIq/mf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl7+CDAb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl7+CDAb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367963ea053so604860f8f.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727661; x=1724332461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhSnxW7lIJKEstF6VbFlbb1yLro61xm8GM1hpiBvOns=;
        b=Kl7+CDAbyI9FZYWuRwlcrJmre9tHACJruFHHVdwyfwkucVirKRUyQmA6AYOqPcLc6H
         0tcyvBhEA5na9RDZkRDs68uOgKXcTYqhsAdm2dpUT3hLKifrootqvyvsy/1QN1TZdfZc
         tEyHgnus28BbfBoFvGuEYENfZg3Nj0USsP9dJOtzL5/02CcydWXxy0EHUiLsJK5mU58M
         oCdDGL3EPQIdi+RQXblUyr7l5KgW90CXJkzW6rJPUYxwPoal2W5mhL5d6G6VnGxFN0Ja
         SeG0CnfzcVryO5cYWMRLVlPHRiJBCmPBmNBg8lI7+MuD03vK71qctaz4KUxvdvngrV1X
         O8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727661; x=1724332461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhSnxW7lIJKEstF6VbFlbb1yLro61xm8GM1hpiBvOns=;
        b=ur02GEfs8SlAydlh7LsWfPmR5r6mkTmPA/r+Zl5lMCavhE1rob8xBeosYUSe0RaBOx
         V0+Tpz6NDEB9s8YOqu7amMqu5cp8ylqCF3YjRn71BY/ou83n+0dFbnEBOlVOYYl7DQHl
         QH9717V4dxftxHauIc92tHEgU3lxOPFdsFzhpeWdyADwp6DDJqtAwRj5/ic3vq451PR4
         MwYSocUK7dEmFhygo2sbbojOf5rrhC1gWBiCi9O6rLQx4L8wHuV3bQmimZsURvKWzBpV
         KsT+5y2tD4PNs8I+XT6BCOk54W+sSPwTxoxqcLZSrjgA2sT/hhNfIz7lzY3+qZ2HE6zM
         nxqA==
X-Gm-Message-State: AOJu0Yyk1AcMQrviAvP0yq2qjNoGGfHVu5YT30ouYHTkTh/aOQ8bKTLg
	yYW1jRzKR6grWZ9xB3pXmuWnlOxAFeQzbiNzjR/awwQZOEQWKk4zq8PYRA==
X-Google-Smtp-Source: AGHT+IHsz8xU0v6CcH/0t2G3IE6k9swL5PevBFIM5B/jGLmyYMEEQY3tTu2SP1Uh3WCiLJ1RLH2ngA==
X-Received: by 2002:a5d:6248:0:b0:368:7943:8b1f with SMTP id ffacd0b85a97d-371777e1238mr5457057f8f.43.1723727660843;
        Thu, 15 Aug 2024 06:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897066sm1522752f8f.76.2024.08.15.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:20 -0700 (PDT)
Message-Id: <4aa75cdb5dddca0fa2a4817e856d26f724cb43eb.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:12 +0000
Subject: [PATCH v2 7/8] git-prompt: ta-da! document usage in other shells
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

With one big exception, git-prompt.sh should now be both almost posix
compliant, and also compatible with most (posix-ish) shells.

That exception is the use of "local" vars in functions, which happens
extensively in the current code, and is not simple to replace with
posix compliant code (but also not impossible).

Luckily, almost all shells support "local" as used by the current
code, with the notable exception of ksh93[u+m], but also the Schily
minimal posix sh (pbosh), and yash in posix mode.

See assessment below that "local" is likely the only blocker in those.

So except mainly ksh93, git-prompt.sh now works in most shells:
- bash, zsh, dash since at least 0.5.8, free/net bsd sh, busybox-ash,
  mksh, openbsd sh, pdksh(!), Schily extended Bourne sh (bosh), yash.

which is quite nice.

As an anecdote, replacing the 1st line in __git_ps1() (local exit=$?)
with these 2 makes it work in all tested shells, even without "local":

  # handles only 0/1 args for simplicity. needs +5 LOC for any $#
  __git_e=$?; local exit="$__git_e" 2>/dev/null ||
    {(eval 'local() { export "$@"; }'; __git_ps1 "$@"); return "$__git_e"; }

Explanation:

  If the shell doesn't have the command "local", define our own
  function "local" which instead does plain (global) assignents.
  Then use __git_ps1 in a subshell to not clober the caller's vars.

  This happens to work because currently there are no name conflicts
  (shadow) at the code, initial value is not assumed (i.e. always
  doing either 'local x=...'  or 'local x;...  x=...'), and assigned
  initial values are quoted (local x="$y"), preventing word split and
  glob expansion (i.e. assignment context is not assumed).

  The last two (always init, quote values) seem to be enough to use
  "local" portably if supported, and otherwise shells indeed differ.

  Uses "eval", else shells with "local" may reject it during parsing.
  We don't need "export", but it's smaller than writing our own loop.

While cute, this approach is not really sustainable because all the
vars become global, which is hard to maintain without conflicts
(but hey, it currently has no conflicts - without even trying...).

However, regardless of being an anecdote, it provides some support to
the assessment that "local" is the only blocker in those shells.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c3dd38f847c..75f272daa21 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -8,8 +8,8 @@
 # To enable:
 #
 #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
-#    2) Add the following line to your .bashrc/.zshrc:
-#        source ~/.git-prompt.sh
+#    2) Add the following line to your .bashrc/.zshrc/.profile:
+#        . ~/.git-prompt.sh   # dot path/to/this-file
 #    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
@@ -30,6 +30,8 @@
 #        Optionally, you can supply a third argument with a printf
 #        format string to finetune the output of the branch status
 #
+#    See notes below about compatibility with other shells.
+#
 # The repository status will be displayed only if you are currently in a
 # git repository. The %s token is the placeholder for the shown status.
 #
@@ -106,6 +108,33 @@
 # directory is set up to be ignored by git, then set
 # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
 # repository level by setting bash.hideIfPwdIgnored to "false".
+#
+# Conpatibility with other shells (beyond bash/zsh):
+#
+#    We require posix-ish shell plus "local" support, which is most
+#    shells (even pdksh), but excluding ksh93 (because no "local").
+#
+#    Prompt integration might differ between shells, but the gist is
+#    to load it once on shell init with '. path/to/git-prompt.sh',
+#    set GIT_PS1* vars once as needed, and either place $(__git_ps1..)
+#    inside PS1 once (0/1 args), or, before each prompt is displayed,
+#    call __git_ps1 (2/3 args) which sets PS1 with the status embedded.
+#
+#    Many shells support the 1st method of command substitution,
+#    though some might need to first enable cmd substitution in PS1.
+#
+#    When using colors, each escape sequence is wrapped between byte
+#    values 1 and 2 (control chars SOH, STX, respectively), which are
+#    invisible at the output, but for bash/readline they mark 0-width
+#    strings (SGR color sequences) when calculating the on-screen
+#    prompt width, to maintain correct input editing at the prompt.
+#
+#    Currently there's no support for different markers, so if editing
+#    behaves weird when using colors in __git_ps1, then the solution
+#    is either to disable colors, or, in some shells which only care
+#    about the width of the last prompt line (e.g. busybox-ash),
+#    ensure the git output is not at the last line, maybe like so:
+#      PS1='\n\w \u@\h$(__git_ps1 " (%s)")\n\$ '
 
 # check whether printf supports -v
 __git_printf_supports_v=
-- 
gitgitgadget

