Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C260BC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiBVSyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBVSyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111011475F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so35184507wra.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWNSc0ky0luVfstTVXfc2/uPb+ugVD5cdMD+Rt07TbQ=;
        b=hOf6eJrxt2g3R/cM6HL1ut7rWHjVifVhlyJxYyq8Hch+/oRmGKHPgDmtuMeERfxZTS
         bYHdFDbA4d95YfTUa5NMQvuZBE/pntAcxIr3LzBHjwRt2+QPkoKx5IDYFV6R1dmE0pNG
         4CIqNrrD/IQxbht8D4Q837eR/xtg7Gj9ajQL4cd8FmQNZ7p1XR9QmK0REQY1ifRWD0FI
         brKluW8XY2/wyiOkcOd6raIz/k0pbmZ1y58R/trNsMOC0hjXOgQEZZTZ8PcB+wmP6ABI
         NoWnmF24s/D+guE6CjOUflVd4xlthsZkvSRm1OS8Eqv2EivD6XV3dl1EO2K7DfuhuJE4
         zx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWNSc0ky0luVfstTVXfc2/uPb+ugVD5cdMD+Rt07TbQ=;
        b=d/L5mDcZJ1iuEPQt2cD4qyvoB7+wVVzFxJybGYTTLNtF/+dMBWtXp87tWZGIUTsb9+
         93EfgEEUmkCFaRaZGJkwHJwWpxq6SI/QFcwCmqjGsfLLwHTan66gvSmGstp+WPS/unOj
         G+kRHT0x/PrK6LCRBWe+/TIvaUNpSCx0bQeTTidvAGFKqrhbk7rH22EbQWo6hQXsXzuR
         93WJUoiYugN/8L00foAfQa710J912nd4KutTnkV1m0/eBE9FICTgD9cbTnfBjgwK+T2n
         G5xp9hXqWIV8TKEsp9kwSif4gn7WtP57xy4M2+hVX+Z+IC/6xG+oYwlkKuYHSHoi8Wgn
         uG9g==
X-Gm-Message-State: AOAM530J5k7+LKfw4vdhChsAwUjKSf6uWul/42Eq5Et2jsWk2vw/r+lG
        fC41yOosAnMzIKM5O+/rELSmmjfswmM=
X-Google-Smtp-Source: ABdhPJzdnEl2k14Wec21GzhvqhCzzu4HsMWhi7S7DCTvMh/UhWL/z/uHT6d7NgqTZhTbxeKIVRwhtA==
X-Received: by 2002:a5d:59af:0:b0:1e4:a027:ce3b with SMTP id p15-20020a5d59af000000b001e4a027ce3bmr19806415wrr.318.1645556016317;
        Tue, 22 Feb 2022 10:53:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm29038476wrr.16.2022.02.22.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:53:35 -0800 (PST)
Message-Id: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:53:31 +0000
Subject: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have added a new patch to the beginning of the series that fixes a case
where we did not call restore_term() when leaving read_key_without_echo(). I
have also reworded the commit message to patch 2 as SIGINT is actually
ignored while the editor is running (we should probably change that code to
use wait_after_clean instead).

Cover letter for V1:

Fix a couple of bugs I noticed when using the builtin "add -p" with
interactive.singlekey=true. The first patch is a general fix for the
terminal save/restore functionality which forgot to call sigchain_pop() when
it restored the terminal. The last two fix reading single keys in
non-canonical mode by making sure we wait for an initial key press and only
read one byte at a time from the underlying file descriptor.

Note that these are untested on windows beyond our CI compiling them

Phillip Wood (4):
  terminal: always reset terminal when reading without echo
  terminal: pop signal handler when terminal is restored
  terminal: set VMIN and VTIME in non-canonical mode
  add -p: disable stdin buffering when interactive.singlekey is set

 add-interactive.c |  2 ++
 compat/terminal.c | 29 +++++++++++++++++++++++------
 compat/terminal.h |  8 ++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1146%2Fphillipwood%2Fwip%2Fadd-p-vmin-v2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1146/phillipwood/wip/add-p-vmin-v2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1146

Range-diff vs v1:

 -:  ----------- > 1:  45609d61afc terminal: always reset terminal when reading without echo
 1:  9a3c2cea0f9 ! 2:  0020953f1cf terminal: pop signal handler when terminal is restored
     @@ Commit message
          external caller was removed by e3f7e01b50 ("Revert "editor: save and
          reset terminal after calling EDITOR"", 2021-11-22). Any future callers
          of save_term() should benefit from having the signal handler set up
     -    for them. For example if we reinstate the code to protect against an
     -    editor failing to restore the terminal attributes we would want that
     -    code to restore the terminal attributes on SIGINT. (As an aside
     -    run_command() installs a signal handler that waits for the child
     -    before re-raising the signal so we would be guaranteed to restore the
     -    settings after the child has exited.)
     +    for them.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  02009172e08 = 3:  7ae9b236554 terminal: set VMIN and VTIME in non-canonical mode
 3:  6d8423b6e1e = 4:  39b061a471b add -p: disable stdin buffering when interactive.singlekey is set

-- 
gitgitgadget
