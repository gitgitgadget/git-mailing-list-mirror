Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F8C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2966D2187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaWIdGcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgBNOou (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33614 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNOot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so2226304wmc.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zO5Wv7NgtB+qp+d0pSPtyZDCsce+c+gFRUyy0LCf33s=;
        b=LaWIdGcpmbZ/AX0FS3EKjsN1S0c60SkTFdg22O7v0AGq6rQCeu54+Aq5LE+d0f9okH
         hr0bcwyJX8v1pnOd6GP+o61ctwJhs3DdbcqvfjHUvOkcXnz1RX9hllRvagpzA7sYHLNa
         a+VvkaGqaCtN34yxI1W9cWzn3CSHPgfK3mv7ETutM/xoXoyK5ZnbRZ8MuBcsixdbyMLg
         I8yrxB7eHvcW3F5s9SHo2gQIBUi0ioNk6W6uHEfogrou/xviknbq9VXG5BY97wYLb0Ro
         Jo2xabOE1kimdJVeofCloUtJzyakJ8fRGfWe/+YHt2Q44lK/ymdxDRy3IB1Mw+mNgXBP
         cofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zO5Wv7NgtB+qp+d0pSPtyZDCsce+c+gFRUyy0LCf33s=;
        b=cR9pBghlEgJlrtUlfUAguIrTgkcx65c6OAHpo3mati+U29vcOEvvtLfCauerGMKD+J
         4sretmNliUcbRkF7Y9Q5lT+PT/eEYrPZiqC1JlzbCkX2OyjFsiyTzGOgoRro0UtBhk3o
         Ja09DNXvfa4o+gfSRf0A1dtaVQeDqnvrD16bNIn0hTuypmx6yCAizXmmDN+aZd3pCu1b
         eIQoAcu2vy+L0b56mEUU3EijWROmhvz62bfbtfN0oF09HFORoGkuEAiUiJTnxNOq6cBO
         smT4iPKX4blY1ya0QAw+loBjc2Qz0WbGkWWCtP+gB/Lq/rGeiA1wEQ2ONfmBDy/mc6Ol
         AmdQ==
X-Gm-Message-State: APjAAAXdObd5eP31pCSD0HilkkpZ0SI2QIR0QwbhO7HDXEiRWRiI0aUa
        pYP7mABxBTlQcw38EPSd8AGzQWJP
X-Google-Smtp-Source: APXvYqzFZHIwgrghENMyw5MFQi/W+6KsMLeX5P7Yu5EQSk8HTn//2UQc8WhOS5NSg6k8jCiTgfyi8w==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr4955639wme.78.1581691487298;
        Fri, 14 Feb 2020 06:44:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25sm7818469wmi.32.2020.02.14.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:46 -0800 (PST)
Message-Id: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:39 +0000
Subject: [PATCH v6 0/7] git-p4: add hooks for p4-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Request for help - if there are any experts with python and Windows, I would
appreciate a review of the changes that I have presented here.


----------------------------------------------------------------------------

Our company's workflow requires that our P4 check-in messages have a
specific format. A helpful feature in the GIT-P4 program would be a hook
that occurs after the P4 change list is created but before it is displayed
in the editor that would allow an external program to possibly edit the
changelist text.

v1:My suggestion for the hook name is p4-pre-edit-changelist.

It would take a single parameter, the full path of the temporary file. If
the hook returns a non-zero exit code, it would cancel the current P4
submit.

The hook should be optional.

v2:Instead of a single hook, p4-pre-edit-changelist, follow the git
convention for hook names and add the trio of hooks that work together,
similar to git commit.

The hook names are: 

 * p4-prepare-changelist
 * p4-changelist
 * p4-post-changelist

The hooks should follow the same convention as git commit, so a new command
line option for the git-p4 submit function --no-verify should also be added.

v3:2-Feb-2020 This version reorganizes the commits to be easier to read. The
function for running the git hook has been rewritten to include suggestions.
This version no longer restricts the executable supported by windows for the
hook. It will first look for a file with the hook name without an extension
and if found, it will pass it to sh.exe (Git for Window's MINGW shell)
Otherwise it will take the file with the lowest alphabetical extension and
ask Windows to execute the program.

v5:10-Feb-2020 Integrated the suggested changes from the mailing list into
this release. The changes are:

 * Restructure the commits to pull the p4-pre-submit hook changes into the
   commit for adding git_run_hook.
 * Update the git_run_hook to include additional tests for GIT_DIR being set
   if getting the environment returns no value.
 * Updated the windows file resolution to ensure that the script to be run
   is NOT the .SAMPLE version of the hooks.
 * Split the RCS keyword cleanup message into its own commit.

v6:
14-Feb-2020 Update commit for git-p4: restructure code in submit to be
python 3 compatible:

> This change comes from 'git-p4: restructure code in submit' in
> 'bk/p4-pre-edit-changelist' which introduced the use of the <>operator. In
> Python 2, this is valid but in Python 3, it was removed.
>
> We can simply replace the <> with != which is the new way of writing "not
> equals".

Ben Keene (7):
  git-p4: rewrite prompt to be Windows compatible
  git-p4: create new function run_git_hook
  git-p4: add p4-pre-submit exit text
  git-p4: add --no-verify option
  git-p4: restructure code in submit
  git-p4: add p4 submit hooks
  git-p4: add RCS keyword status message

 Documentation/git-p4.txt   |  45 ++++++-
 Documentation/githooks.txt |  51 +++++++-
 git-p4.py                  | 236 ++++++++++++++++++++++++++++---------
 3 files changed, 274 insertions(+), 58 deletions(-)


base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v6
Pull-Request: https://github.com/git/git/pull/698

Range-diff vs v5:

 1:  71c51ccfb0c = 1:  013b27760a0 git-p4: rewrite prompt to be Windows compatible
 2:  a2342f71619 = 2:  72c3d642a97 git-p4: create new function run_git_hook
 3:  5f2b47bf6aa = 3:  ae1a4614ee4 git-p4: add p4-pre-submit exit text
 4:  05b8c7ad673 = 4:  cf4de224f8a git-p4: add --no-verify option
 5:  5299f61e4e1 ! 5:  22ac4384bd5 git-p4: restructure code in submit
     @@ -130,7 +130,7 @@
                       if self.isWindows:
                           message = message.replace("\r\n", "\n")
      -                submitTemplate = message[:message.index(separatorLine)]
     -+                if message.find(separatorLine) <> -1:
     ++                if message.find(separatorLine) != -1:
      +                    submitTemplate = message[:message.index(separatorLine)]
      +                else:
      +                    submitTemplate = message
 6:  7a6d9fafcea = 6:  a240b292a17 git-p4: add p4 submit hooks
 7:  c0aca431858 = 7:  bdf07d8f7aa git-p4: add RCS keyword status message

-- 
gitgitgadget
