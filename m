Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBFC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DD761164
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhEFQxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE9C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x5so6344597wrv.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfhLCTtetpaSUB3LZtfo8+KVSYEtVo7BE1XY4rg4x6E=;
        b=pOPT1s+JYJFJi+w5858OtqBilLTDCN1Ebi49wDb9aRwDbho3miPT2DbGqgEMnXRRJL
         0pl4w65x/JrBQguvGhcU7QerQX/WEDLWaUbyiEuI2tzUiVqNd4S3gN1fj1vw+9l2MF8w
         1GQZPrPx3aK5hcy3X2feGBN2BHkwvc/I3oCQva9g3BAKUkqLY9z9ytKztVJI5yaWXXLu
         T7/QOmibWcC70BsteKiux+khfIIgwMSmVQOANEsNYKze9YYUpFwa69/CMghOPwwUhByz
         IHAP9fWQR8nDckL2Kx9QedngoxRxJu/GFA5tNbOh1fwPihTNlP3lQKDT5OZtSvKhOSVu
         6d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfhLCTtetpaSUB3LZtfo8+KVSYEtVo7BE1XY4rg4x6E=;
        b=rajxyOhKbZFTTfYj8orREMLY8sfKClKDg/jloDKr0gk0vr7U+qpWaDuO2AGJ9XrrJE
         Mgy8BmzbVQmwpa95KpKqcYK1njVjqUulLBp/PKHp9aNYYyCKhxQTxcifESUbpp0kupqJ
         9FgJilXpAiamMtZrW6Kqe0tLL8qkWqf5JoI5CNroPVYkBr4IVatyjjATowY7lGL93e19
         /Uc1dI5Zww9bz5NOiVoT5Z1Ff14b5QW2y3Ay1GgyiCKpaVq4mh11isCae5CKheSWEfWL
         RXbzT061w5mOX6rFCTIQccxcAK/kD2a0DIW7jW1DFZvg3lOsMe7BC8QXnkwRCoN7YcFu
         rEXg==
X-Gm-Message-State: AOAM532MMlAqTa44ywfyzyMl+54qj9qdH1ftMgKGqfsFi3NYBlx6ZQ9D
        8RTzJ0i/WOdD7VT7sA8X4Bo=
X-Google-Smtp-Source: ABdhPJxmbQBhlVNXp97l5GcLOlmN278KQaNqiQ41CQiUhm9p1yfM8h94r6nqIIBZgpsMeQbJT8rQ5w==
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr6275148wri.275.1620319944215;
        Thu, 06 May 2021 09:52:24 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:23 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Date:   Thu,  6 May 2021 18:50:54 +0200
Message-Id: <20210506165102.123739-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This patch series aims to prevent git-format-patch from overwriting cover
letter and patches silently. It also tries to fix git_prompt but there
are still some works to do (see NEED HELPS).

BACKGROUND
==========

Currently, git-format-patch, along with the option --cover-letter,
unconditionally overwrites a cover letter with the same name (if
present). Although this is a desired behaviour for patches which are
auto-generated from Git commits log, it might not be the case for a
cover letter whose the content is meticulously written manually.

Particulary, this behaviour could be awkward in the following
hypothetical situations:

* The user can easily erase a cover letter coming from prior versions or
another patch series by reusing an old command line (e.g. autocompleted
from the shell history).

* Assuming that the user is writing a cover letter and realizes that
small changes should be made. They make the change, amend and
format-patch again to regenerate patches. If it happens that they use
the same command again (e.g. with --cover-letter), the cover letter
being written is gone.

This patch series addresses this kind of issue by asking confirmation
from the user whenever a cover letter or a patch is subject to be
overwritten.

CHANGES
=======

Substantial changes include:

* New options format.confirmOverwrite and --confirm-overwrite=<when>
  which decide when to prompt the user for confirmation to overwrite
  patches or cover letter. There are three possible values "always",
  "never", and "cover". The default value is "cover", which means "only
  prompt when a cover letter already exists".  This is a breaking change:
  prior this patch series, the behaviour of Git corresponds to
  format.confirmOverwrite = never.
* Some tests (t4014) who overwrites cover letter in silence are fixed to
  address this breaking change.
* compat/terminal.c::git_terminal_prompt is modified to accept input
  from pipe.  This makes Git subcommands using prompt.c::git_prompt
  testable. As far as I know, the two occurrences of git_prompt are from
  credentials.c and builtin/git-bisect--helper.c, and they are not
  tested so far (see BUG below).

NEED HELPS
==========

I would appreciate some guidance on the following points.

git_prompt
~~~~~~~~~~
There are currently three issues related to changes made into
git_terminal_prompt (see patch #1).

1. All tests have passed in my machine (Ubuntu 20.04), but CI reported tests
   in t4014 that all failed at the same point:

    fopen("/dev/tty", "w") in Linux and OSX, and fopen("CONOUT$", "wt") in Windows.
    
    - Linux error: No such device or address
    - Windows error: Invalid argument
    - OSX error: Device not configured

   I also observed that one cannot write into /dev/stderr. Is this a CI
   specific issue ? (see patch #5 for the new tests).

2. (BUG) While all tests passed locally, I realized that "git push" (to
   Github) can't read my credentials. That's because, for some obscure
   reason, isatty(0) returns 0 when "git push" is asking for credentials.
   Consequently, the new code will read input from stdin, which is wrong.

   What would be the reason that causes isatty(0) returns 0 when
   git-push calls credential.c::credential_getpass ?

3. Finally, while testing git_prompt's caller works, it uglifies the
   output of "make prove" (as git_prompt writes into /dev/tty). I tried to
   "redirect" the output of /dev/tty to /dev/null to silent it using the
   "script" command (along the line of "script -e -c 'echo Y | git ...'
   /dev/stderr 2>/dev/null"). Unfortunately, it is not portable
   (specifically, OSX doesn't have the option -e, and "script" is not
   available under Windows). Are there other ways to hide the output of
   the prompts ?

I will squash patches #2-#8 for the last version.

Thanks,

Firmin


Firmin Martin (8):
  compat/terminal: let prompt accept input from pipe
  format-patch: confirmation whenever patches exist
  format-patch: add config option confirmOverwrite
  format-patch: add the option --confirm-overwrite
  t4014: test patches overwrite confirmation
  t4014: fix tests overwriting cover letter in silent
  doc/git-format-patch: describe --confirm-overwrite
  config/format: describe format.confirmOverwrite

 Documentation/config/format.txt    |   5 +++
 Documentation/git-format-patch.txt |  20 +++++
 builtin/log.c                      |  65 ++++++++++++--
 compat/terminal.c                  |  47 ++++++----
 t/t4014-format-patch.sh            | 140 +++++++++++++++++++++++++++--
 5 files changed, 247 insertions(+), 30 deletions(-)

-- 
2.31.1.449.gf23dcf53bc

