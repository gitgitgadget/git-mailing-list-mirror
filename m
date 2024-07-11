Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527841DFE3
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739502; cv=none; b=gVsEzm7HM/rrqwySstsDlJnMtth84uOJdts/gGSPMObwWytfQh4n9ZDQGPVUDhXiK0kdSPwpr9bESf7GMhMls4IP3RBoAUWNgcHfZS8J7d1qXHtk9AeCkqjJc0APLoFZYTUozIzqukiUyOcN4/lUgC7bBkdxB8T2oJIW9rctPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739502; c=relaxed/simple;
	bh=eDykyp348YR+ijlMNqT8A+jvN6iQlVCvFxDIGLRnxuU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZwZ2pGRNcxLZhJCOSP1bQDuluVIG/TTid71bT9GJn4bZpRhZzBxLLTyOlrpjX8i9qKbBskuf48Io3tIvLrB6TCd/9p3Krtha+vMuZb69+FwjJV7QhYEXr+AuBSFJScaeITAmxclGdtJUdY42fVFJg1sx8UAC+lWYka5oEgI5DIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVBPUvkM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVBPUvkM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so9120365e9.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739498; x=1721344298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Fo7lmGng3nAQQV2kFYMYrHB448ONhSW/pW+It1O50=;
        b=MVBPUvkM9PVouc7NN0zyohMCpvFrUkWO3ndmuuVD/XTttdm46+fiT7t5yiUGnvLuNb
         WfQ7a+5KClyl/UovRRe1AtXoBSGupDpCG4WKEzbOUOBjAZ7qPixcs4R9A6urkTpyhjmw
         0MBcBJGexNGxPysGD2OhWU8Tbbd1+Onp5iZjRak5y8CLvcD+w2kpidePKVJWnHUVk/0v
         qZiXnUj3iF05lFRUqe7CjOv5efnJMQOhSaEZEe06W/xUhCEDXYfrA2p4vmFxHBGzqmiY
         ffIQZN6agDj5JblaEq0KODVjSgudB2ZTp8wfIEqTmIjw6n2gxKweLfRruUsl5I/HLWdS
         9BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739498; x=1721344298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5Fo7lmGng3nAQQV2kFYMYrHB448ONhSW/pW+It1O50=;
        b=AjDoOVjsxdvFaXfdpwu2Yu4xxYTF8Z/doRhyPqH+BuZwhsnun/+H9aZNe8JxXCR0Kt
         AyRBOIYJWqD23arHTsNjLGgbFrkEcUvlVgy+skI4f6Bt3yK0o5PDXo8tPHheknfylpnX
         ZwhVBxQhGUBfhrgBiDO96a0hC7XvciF5EqTcZL/VxapdTtEIDOUVN56e7J1nlaW1d7gl
         TdTRiweFFBkzr5qTvsaeTKQ2MnV/5V+LhI8LdROydkYn6jJmqKCVL+i4RWDKYID4QqgJ
         hlk54s/+d9hbkkoE/B371VUSQW/SDQ8JtumzVsS/PKcYp5y+jnlx4qO6cLxdW5f9++Fo
         57fw==
X-Gm-Message-State: AOJu0Yy7jL9Wwp3lfDLaX1zj3Qw7kGDT2RhJwfMABDubJHgifeqgFtWy
	z+pgK9ITNtq1FDuU3KtKiCuFUkCuhf1dFoaejmEgpSnm1F1id1O9dW8tIw==
X-Google-Smtp-Source: AGHT+IFSW4NMKQUP1M9e3Zrs7iV/sQfCLoLuKR3tjVZKGLQpo0bG1rTPUnKejBpfzge+kxglfC1j5Q==
X-Received: by 2002:a05:600c:3ba9:b0:426:647b:1bf7 with SMTP id 5b1f17b1804b1-426708f151bmr67276235e9.32.1720739498084;
        Thu, 11 Jul 2024 16:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f244934sm3420285e9.8.2024.07.11.16.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:37 -0700 (PDT)
Message-Id: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:29 +0000
Subject: [PATCH v2 0/7] var(win32): do report the GIT_SHELL_PATH that is actually used
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Changes since v1:

 * This patch series now shares the logic that determines the path of the
   Unix shell that Git uses between prepare_shell_cmd() and git var
   GIT_SHELL_PATH.

Johannes Schindelin (7):
  run-command: refactor getting the Unix shell path into its own
    function
  strvec: declare the `strvec_push_nodup()` function globally
  win32: override `fspathcmp()` with a directory separator-aware version
  mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
  run-command(win32): resolve the path to the Unix shell early
  run-command: declare the `git_shell_path()` function globally
  var(win32): do report the GIT_SHELL_PATH that is actually used

 builtin/var.c             |  3 ++-
 compat/mingw.c            |  2 +-
 compat/win32/path-utils.c | 25 +++++++++++++++++++++++++
 compat/win32/path-utils.h |  2 ++
 dir.c                     |  2 +-
 dir.h                     |  2 +-
 git-compat-util.h         |  5 +++++
 run-command.c             | 17 ++++++++++++-----
 run-command.h             |  5 +++++
 strvec.c                  |  2 +-
 strvec.h                  |  3 +++
 t/t0007-git-var.sh        |  2 +-
 12 files changed, 59 insertions(+), 11 deletions(-)


base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1760%2Fdscho%2Fgit-var-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1760/dscho/git-var-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1760

Range-diff vs v1:

 -:  ----------- > 1:  e0970381042 run-command: refactor getting the Unix shell path into its own function
 -:  ----------- > 2:  91ebccbc39f strvec: declare the `strvec_push_nodup()` function globally
 -:  ----------- > 3:  a718183bb3b win32: override `fspathcmp()` with a directory separator-aware version
 -:  ----------- > 4:  f04cfd91bd9 mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
 -:  ----------- > 5:  707daf246bd run-command(win32): resolve the path to the Unix shell early
 -:  ----------- > 6:  a74a7b4bb11 run-command: declare the `git_shell_path()` function globally
 1:  ef62c3fc122 ! 7:  8bfd23cfa00 var(win32): do report the GIT_SHELL_PATH that is actually used
     @@ Commit message
          associated with the current directory.
      
          To that end, Git does not actually use the path `/bin/sh` that is
     -    recorded e.g. in Unix shell scripts' hash-bang lines. Instead, as of
     -    776297548e (Do not use SHELL_PATH from build system in prepare_shell_cmd
     -    on Windows, 2012-04-17), it re-interprets `/bin/sh` as "look up `sh` on
     -    the `PATH` and use the result instead".
     +    recorded e.g. when `run_command()` is called with a Unix shell
     +    command-line. Instead, as of 776297548e (Do not use SHELL_PATH from
     +    build system in prepare_shell_cmd on Windows, 2012-04-17), it
     +    re-interprets `/bin/sh` as "look up `sh` on the `PATH` and use the
     +    result instead".
     +
     +    This is the logic users expect to be followed when running `git var
     +    GIT_SHELL_PATH`.
      
          However, when 1e65721227 (var: add support for listing the shell,
          2023-06-27) introduced support for `git var GIT_SHELL_PATH`, Windows was
          not special-cased as above, which is why it outputs `/bin/sh` even
          though that disagrees with what Git actually uses.
      
     -    Let's fix this, and also adjust the corresponding test case to verify
     -    that it actually finds a working executable.
     +    Let's fix this by using the exact same logic as `prepare_shell_cmd()`,
     +    adjusting the Windows-specific `git var GIT_SHELL_PATH` test case to
     +    verify that it actually finds a working executable.
      
          Reported-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/var.c ##
     +@@
     + #include "refs.h"
     + #include "path.h"
     + #include "strbuf.h"
     ++#include "run-command.h"
     + 
     + static const char var_usage[] = "git var (-l | <variable>)";
     + 
      @@ builtin/var.c: static char *default_branch(int ident_flag UNUSED)
       
       static char *shell_path(int ident_flag UNUSED)
       {
     -+#ifdef WIN32
     -+	char *p = locate_in_PATH("sh");
     -+	convert_slashes(p);
     -+	return p;
     -+#else
     - 	return xstrdup(SHELL_PATH);
     -+#endif
     +-	return xstrdup(SHELL_PATH);
     ++	return git_shell_path();
       }
       
       static char *git_attr_val_system(int ident_flag UNUSED)

-- 
gitgitgadget
