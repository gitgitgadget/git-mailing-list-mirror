Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A277CC001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjHDEIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjHDEIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:08:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D230E7
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:08:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso26253181fa.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691122126; x=1691726926;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrdNopu6pW1T3AmkBes7/q+oHqeQGTN231Iw3meJPUg=;
        b=fvVez8BJbCtAJLlFEECCdPhY2vIXlqLF4GLoQGsAJP+zMVf1h2cJb882liG0Dcl7bw
         TAsLK+r9xcJbIJo02IDS9vm4pQtWQgwaPTV+gbjwBNqTX9PblsmyFjwSnfNuEDmlfCj1
         55alGLyyh38WqlZzB1m6sE3yVePAZ66TID//H2nwhzsfYVTSMJ9Ghn1voGmonMtFiroY
         5Zr4edP4AgY9MXgQ3oUPglsTKg1e6lhkta2k+CVJ/NCds94zAkEc6Da22dyaOq7pOTcy
         YcsLG9ZwPA1HGp12LoWaVXd8jK9u4ZZJenYgKvo80Ds1Av1LiDwj9DA0uSxbOq3NdGNC
         SH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122126; x=1691726926;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrdNopu6pW1T3AmkBes7/q+oHqeQGTN231Iw3meJPUg=;
        b=KIjynksMIfmxrZerAZo217e3APu8eIhORKuQY6MP7KV5QLQLbzeRNDyTo4cuakOXoE
         gMdCWAK+VYu5rK85zczrieynkhUxOO2h6YxytI9x+sHjvq3FARAi9iIFycMkLPMUvqKw
         mHH94Z3xMK+ew9mUT2qo8ksvoqaUjyPeXRFaZzxlI5TLlIHN8z2pKB2hvg53PN9uInHM
         TVeIOXBCwk3ZkkH2DlSKqfd2s8+BfH2vk0lYMdb+IWoHo5GirclaQ7VyJ97uJObQ3SNB
         aOoDh8qjJQQ2iKFWs+uJ+11k/eVcommyjv9azSY53DYTFjWM+teu+RCu9RMlxydF+C3h
         M/XA==
X-Gm-Message-State: AOJu0YyAm6JAfe7IY0SLYWAHgRO3+IbMEuz28bIJxJXZwUGy9FjztRSD
        t9Xf/ueQNgsH/FvxdEX+JKtJeqBHAaI=
X-Google-Smtp-Source: AGHT+IGQgDV5M3STc/3h5lgbAU8qXHiA1f2gSLcPkk2eAwf12OYvk1YkWUjn0bpIqTGHvHML9aRWFg==
X-Received: by 2002:a2e:3208:0:b0:2b4:65ef:3af5 with SMTP id y8-20020a2e3208000000b002b465ef3af5mr538673ljy.30.1691122125837;
        Thu, 03 Aug 2023 21:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a056000000c00b003063db8f45bsm1398641wrx.23.2023.08.03.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:08:45 -0700 (PDT)
Message-ID: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 04 Aug 2023 04:08:41 +0000
Subject: [PATCH v2 0/3] git bisect visualize: find gitk on Windows again
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Louis Strous reported a regression in git bisect visualize on Windows[1]
that caused git bisect visualize to use git log instead of gitk unless
explicitly called as git bisect visualize gitk. It was introduced during the
conversion of git bisect visualize to a builtin.

This patch series fixes that regression.

Changes since v1:

 * simplified patches 1 and 2 based on Junios feedback.
 * expanded the new wording in the documentation to clarify which variables
   users might encounter

[1]
https://lore.kernel.org/git/VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM/

Matthias Aßhauer (3):
  run-command: conditionally define locate_in_PATH()
  compat/mingw: implement a native locate_in_PATH()
  docs: update when `git bisect visualize` uses `gitk`

 Documentation/git-bisect.txt | 11 ++++++++---
 compat/mingw.c               |  5 +++++
 compat/mingw.h               |  3 +++
 run-command.c                |  2 ++
 4 files changed, 18 insertions(+), 3 deletions(-)


base-commit: fb7d80edcae482f4fa5d4be0227dc3054734e5f3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1560%2Frimrul%2Fwin-bisect-visualize-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1560/rimrul/win-bisect-visualize-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1560

Range-diff vs v1:

 1:  6ed968e1288 < -:  ----------- compat: make path_lookup() available outside mingw.c
 2:  bf8b34aaef3 ! 1:  dc9c0812d20 run-command: teach locate_in_PATH about Windows
     @@ Metadata
      Author: Matthias Aßhauer <mha1993@live.de>
      
       ## Commit message ##
     -    run-command: teach locate_in_PATH about Windows
     +    run-command: conditionally define locate_in_PATH()
      
     -    since 5e1f28d206 (bisect--helper: reimplement `bisect_visualize()` shell
     -     function in C, 2021-09-13) `git bisect visualize` uses exists_in_PATH()
     -    to check wether it should call `gitk`, but exists_in_PATH() relies on
     -    locate_in_PATH() which currently only understands POSIX-ish PATH variables
     -    (a list of paths, separated by colons) on native Windows executables
     -    we encounter Windows PATH variables (a list of paths that often contain
     -    drive letters (and thus colons), separated by semicolons). Luckily we do
     -    already have a function that can lookup executables on windows PATHs:
     -    mingw_path_lookup(). Teach locate_in_PATH() to use mingw_path_lookup()
     -    on Windows.
     +    This commit doesn't change any behaviour by itself, but allows us to easily
     +    define compat replacements for locate_in_PATH(). It prepares us for the next
     +    commit that adds a native Windows implementation of locate_in_PATH().
      
     -    Reported-by: Louis Strous <Louis.Strous@intellimagic.com>
          Signed-off-by: Matthias Aßhauer <mha1993@live.de>
      
       ## run-command.c ##
      @@ run-command.c: int is_executable(const char *name)
     -  * Returns the path to the command, as found in $PATH or NULL if the
     -  * command could not be found.  The caller inherits ownership of the memory
     -  * used to store the resultant path.
     -- *
     -- * This should not be used on Windows, where the $PATH search rules
     -- * are more complicated (e.g., a search for "foo" should find
     -- * "foo.exe").
     -  */
     - static char *locate_in_PATH(const char *file)
     - {
     -+#ifndef GIT_WINDOWS_NATIVE
     - 	const char *p = getenv("PATH");
     - 	struct strbuf buf = STRBUF_INIT;
     + 	return st.st_mode & S_IXUSR;
     + }
       
     ++#ifndef locate_in_PATH
     + /*
     +  * Search $PATH for a command.  This emulates the path search that
     +  * execvp would perform, without actually executing the command so it
      @@ run-command.c: static char *locate_in_PATH(const char *file)
     - 
       	strbuf_release(&buf);
       	return NULL;
     -+#else
     -+	return mingw_path_lookup(file,0);
     -+#endif
       }
     ++#endif
       
       int exists_in_PATH(const char *command)
     + {
 -:  ----------- > 2:  8b8c8c3f70a compat/mingw: implement a native locate_in_PATH()
 3:  c872431b608 ! 3:  04227199089 docs: update when `git bisect visualize` uses `gitk`
     @@ Documentation/git-bisect.txt: as an alternative to `visualize`):
      -If the `DISPLAY` environment variable is not set, 'git log' is used
      -instead.  You can also give command-line options such as `-p` and
      -`--stat`.
     -+If none of the environment variables `DISPLAY`, `SESSIONNAME`, `MSYSTEM` and
     -+`SECURITYSESSIONID` is set, 'git log' is used instead.  You can also give
     -+command-line options such as `-p` and `--stat`.
     ++Git detects a graphical environment through various environment variables:
     ++`DISPLAY`, which is set in X Window System environments on Unix systems.
     ++`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
     ++`MSYSTEM`, which is set under Msys2 and Git for Windows.
     ++`SECURITYSESSIONID`, which is set on macOS in interactive desktop sessions.
     ++
     ++If none of these environment variables is set, 'git log' is used instead.
     ++You can also give command-line options such as `-p` and `--stat`.
       
       ------------
       $ git bisect visualize --stat

-- 
gitgitgadget
