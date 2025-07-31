Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9328E55B
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949269; cv=none; b=WZlPhpfIG9pyBSY8SSp7awYcOP+uxPBd09FKSYd9If0P42qSoV6WFfEpM+AObSClpzBP/wOqM1B6r2BMLAXP7j75GHl37NBc6YZB9AWsNcmtn5xz+9icc+s5pomGCepmrzTNpaQKFxy8AC1guc3ajxN4ItoA3p0rEe+4sEMNlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949269; c=relaxed/simple;
	bh=A4/BlFeyEDol4vlukNb/U0ogTv3Z2xfGdVDq9o1Bqcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYvoCYy8qGza0PzUt5jsvW0tIBzHUmdrEjNkXmNTuUZuPRiVhszOW1yT8ObRypAeFf5Rju/tDqcPKc0y/8MjF4IGDTdHn58CyK6byfopKaS+07QQov5oWavjqdVRJHOLJ0D6Idk3dRajMPeitVkHCaHLruRVnz9RvRRNe8EH+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu9iosTJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu9iosTJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so1918409a91.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949267; x=1754554067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN+CSoQW4ootQjnlBHr/OyZjJfb3XPCsK17qeTo/roY=;
        b=Tu9iosTJFYwFdsVHxCZZTtC0qwJnaaINMT3G15WFnSiLByfu0PbOLVHGgW8sKnF/IU
         bwNNVHUqfznSeiCE3k2fcbDwEaC7G1bL94NUtqwWqsX9wHzL/PM450S0FNL39QE9CkNv
         RjfUCMB6w81aDlHwnRxSSacVu/tNst6Ss3BIYckv2bP1F5zZ7EJHfggH/tWSRUb9EaFA
         /kV7FQStY6KPS1VJSIW2x/Jv1LnJtun5exS7eS/+LvRS9v+yb4Cx7Y77b4zyTuqfSWPR
         bQ//pCK21lGgePvXwvdnRdRlf/tCY5+JDnAU4qaGH4+QCSBaswohpWmYN18z/gyGWYYJ
         EyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949267; x=1754554067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN+CSoQW4ootQjnlBHr/OyZjJfb3XPCsK17qeTo/roY=;
        b=rZDr95QAMaC0WbNG5FzsUPOw8WJOEQoLZZ4uOKlBdANBqP5hzgdAHO+IuchWpzPCMP
         2zI5MCTlKnpnMy4z2/N6dUz4o447TDSu5N6JVbqdNOj4BC918xeYkQq8Ti8vzHi3kPMo
         pz3LVzx/7dUdtS48QQUDx33SpK/O5coteV0P47eRVk3YqfxbIt5I+tZ+/1DgBQlbRaWb
         Ty9d+f2czM6njdwNKv4CPecUEMzaUJNJT2y/HSBO5Wt79wjeuG8rxmH13iZ2usdijgRg
         Fd2x2DeiaPHyTZ2hCy8PnYI7B7j0f8DDW3Kcxhn0xI6ycgd4dojeF0+VBJUdVS35myCJ
         hH0Q==
X-Gm-Message-State: AOJu0YyIUnVk1iD05qGItC5xn8GnJG9s65zLLXjyh2z8Cfzt5rJD6zKm
	Ou9Li4mZ304K+NdKFKv9PGqxgk2nnthkLOGp+TU51K09aIxO92KnYv+ViJwb5Q==
X-Gm-Gg: ASbGncsUjFcqOWrJpPIMbCMWM6WW9AQqwW1Sw0OEITO7pvTjgRSCTNDqfsWQGGPRsRp
	viWTK/odt1OGj05MniB9+22s2VPRd6KKbgK4ngk3piYIAvry9Ui9Mzs1HSP5yg7IOndX1b1rEMM
	c/VO89dRrOD4Y7H0ogYEDgzgUS5GwaHWM1xvQNlRAgaDvg89OewYnuDgVRrFNd5ptG5hlh8ZU7m
	C6VI2+uL4PvMJJLOhJ/1fPFxJBW42r5YQDN1qajjHaYjEBevWjrCztMlfDn0je6MZolMUcNmbzT
	IPhbOS5nStE7WVL2OVPj9D/5iwLl+XXMPe4xQX+wQfSMY7OpVT0lOyr+CXBvydGehRUJXK//9j1
	VLAB9ZtCUKA3uftTcRfS1qAmUzQ+t8h/zo4badsExzG3fysWvc9Wntqq0nyyXOxC+eoUzJ6oE
X-Google-Smtp-Source: AGHT+IHEPGSIgdwKLH4ThzAWm+uhuWdLMYeFTDfzDz/whuELCX4pCfIhSpWNbyx3+2yuBAkAUJhGKg==
X-Received: by 2002:a17:90b:3845:b0:31f:14b:f397 with SMTP id 98e67ed59e1d1-320da5a2414mr1965630a91.1.1753949266455;
        Thu, 31 Jul 2025 01:07:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6b69sm1237309a91.2.2025.07.31.01.07.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Jul 2025 01:07:45 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	johannes.schindelin@gmx.de,
	mlevedahl@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2 0/5] git-gui: workaround deprecation of Tcl/Tk 8.5 in macOS
Date: Thu, 31 Jul 2025 01:06:23 -0700
Message-ID: <20250731080628.27917-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.ge15fa7359c
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series, adds improvements to allow running `git-gui` in macOS, which is
stuck in an ancient version of Tcl/Tk that is no longer supported by git.

Patches 1 and 2 are minor fixes that could also apply to maint, but the main
change is in Patch 3, which removes the long obsoleted "Git Gui" app that was
tied to the system provided Tcl/Tk framework and that has been broken for a
while.

Patches 4 and 5 are needed to avoid the system framework and facilitate using
a third party provided package of Tcl/Tk 8.6 instead, but the last patch also
protects against a conflict with the Xcode provided git that for some reason
includes a copy of `git-gui--askpass`, even if `git-gui` is missing.

Carlo Marcelo Arenas Belón (5):
  git-gui: remove uname_O in Makefile
  git-gui: fix dependency of GITGUI_MAIN on generator
  git-gui: retire Git Gui.app
  git-gui: honor TCLTK_PATH in git-gui--askpass
  git-gui: ensure own version of git-gui--askpass is used

 .gitignore                              |   2 +-
 GIT-GUI-BUILD-OPTIONS.in                |   1 -
 Makefile                                |  61 ++----------------
 generate-macos-app.sh                   |  30 ---------
 generate-macos-wrapper.sh               |  35 -----------
 generate-script.sh                      |  22 +++++++
 git-gui--askpass => git-gui--askpass.sh |   0
 git-gui.sh                              |   4 +-
 macosx/AppMain.tcl                      |  29 ---------
 macosx/Info.plist                       |  30 ---------
 macosx/git-gui.icns                     | Bin 28866 -> 0 bytes
 meson.build                             |  79 +++++-------------------
 12 files changed, 46 insertions(+), 247 deletions(-)
 delete mode 100755 generate-macos-app.sh
 delete mode 100755 generate-macos-wrapper.sh
 create mode 100755 generate-script.sh
 rename git-gui--askpass => git-gui--askpass.sh (100%)
 delete mode 100644 macosx/AppMain.tcl
 delete mode 100644 macosx/Info.plist
 delete mode 100644 macosx/git-gui.icns

Changes since v1:
* no more silly Makefile issues
* a simpler implementation of patch 5

Range-diff against v1:
1:  423b945 = 1:  423b945 git-gui: remove uname_O in Makefile
2:  e7183ab = 2:  e7183ab git-gui: fix dependency of GITGUI_MAIN on generator
3:  1054496 = 3:  1054496 git-gui: retire Git Gui.app
4:  7fdd8b5 ! 4:  5d908e3 git-gui: honor TCLTK_PATH in git-gui--askpass
    @@ Makefile: GIT-GUI-BUILD-OPTIONS: FORCE
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
      
     +git-gui--askpass: git-gui--askpass.sh GIT-GUI-BUILD-OPTIONS generate-script.sh
    -+	$(QUIET_GEN)$(SHELL_PATH) generate-script.sh $@ $< GIT-GUI-BUILD-OPTIONS
    ++	$(QUIET_GEN)$(SHELL_PATH) generate-script.sh $@ $< ./GIT-GUI-BUILD-OPTIONS
     +
      ifdef GITGUI_WINDOWS_WRAPPER
    --all:: git-gui
    -+all:: git-gui git-gui--askpass
    + all:: git-gui
      endif
     -all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
     +all:: $(GITGUI_MAIN) git-gui--askpass lib/tclIndex $(ALL_MSGFILES)
5:  1eae516 ! 5:  c5ffefc git-gui: ensure own version of git-gui--askpass is used
    @@ Metadata
      ## Commit message ##
         git-gui: ensure own version of git-gui--askpass is used
     
    -    Propagate the `git --exec-path` that is defined at build time
    -    and use it when defining which askpass helper to use by default.
    +    When finding a location for the askpass helper, git will be asked
    +    for its exec path, but if that git is not the same that called
    +    git-gui then we might mistakenly point to its helper instead.
    +
    +    Assume that git-gui and the helper are colocated to derive its
    +    path instead.
     
         This is specially useful in macOS where a broken version of that
         helper is provided by the system git.
     
    +    Suggested-by: Mark Levedahl <mlevedahl@gmail.com>
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
     
    - ## generate-git-gui.sh ##
    -@@ generate-git-gui.sh: sed \
    - 	-e "s|@@SHELL_PATH@@|$SHELL_PATH|" \
    - 	-e "1,30s|^ exec wish | exec '$TCLTK_PATH' |" \
    - 	-e "s|@@GITGUI_VERSION@@|$GITGUI_VERSION|g" \
    -+	-e "s|@@GITGUI_GITEXECDIR@@|$GITGUI_GITEXECDIR|" \
    - 	-e "s|@@GITGUI_RELATIVE@@|$GITGUI_RELATIVE|" \
    - 	-e "${GITGUI_RELATIVE}s|@@GITGUI_LIBDIR@@|$GITGUI_LIBDIR|" \
    - 	"$INPUT" >"$OUTPUT"+
    -
      ## git-gui.sh ##
    -@@ git-gui.sh: set _isbare {}
    - set _githtmldir {}
    - set _reponame {}
    - set _shellpath {@@SHELL_PATH@@}
    -+set _gitexecdir {@@GITGUI_GITEXECDIR@@}
    - 
    - set _trace [lsearch -exact $argv --trace]
    - if {$_trace >= 0} {
    -@@ git-gui.sh: if {[string match @@* $_shellpath]} {
    - 	}
    - }
    - 
    -+if {[string match @@* $_gitexecdir]} {
    -+	if {[catch {set _gitexecdir [exec git --exec-path]} err]} {
    -+		error "Git not installed?\n\n$err"
    -+	}
    -+	set _gitexecdir [file normalize $_gitexecdir]
    -+}
    -+
    - if {[is_Windows]} {
    - 	set _shellpath [safe_exec [list cygpath -m $_shellpath]]
    - }
     @@ git-gui.sh: citool {
      
      # Suggest our implementation of askpass, if none is set
      if {![info exists env(SSH_ASKPASS)]} {
     -	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
    -+	set env(SSH_ASKPASS) [file join $_gitexecdir git-gui--askpass]
    ++	set env(SSH_ASKPASS) \
    ++		[file join [file dirname [file normalize $::argv0]] \
    ++			git-gui--askpass]
      }
      
      ######################################################################
    -
    - ## lib/about.tcl ##
    -@@
    - # Copyright (C) 2006, 2007 Shawn Pearce
    - 
    - proc do_about {} {
    --	global appvers copyright oguilib
    -+	global appvers copyright oguilib _gitexecdir
    - 	global tcl_patchLevel tk_patchLevel
    - 	global ui_comm_spell
    - 
    -@@ lib/about.tcl: proc do_about {} {
    - 
    - 	set d {}
    - 	append d "git wrapper: $::_git\n"
    --	append d "git exec dir: [git --exec-path]\n"
    -+	append d "git exec dir: $_gitexecdir\n"
    - 	append d "git-gui lib: $oguilib"
    - 
    - 	paddedlabel $w.vers -text $v

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
-- 
2.50.1.475.ge15fa7359c

