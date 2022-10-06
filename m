Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F8C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 17:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJFRGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJFRGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 13:06:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28669E2DC
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 10:06:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so4885241pjs.4
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dFMKetTQak6j0VDLAYHg/12/6zA58JOcb5v51W00XJk=;
        b=RQj1GwnNPN5Sxzyj4HcRlcbTD1z+P70IA9hQkCdKqzPZoTAROtPoedEQVokFhrWxbh
         SA87c75xGePxE0X7Uaz/tkPJaZQqrbH1qWXOfMQwzj+/aUUNsGP3M095rsd5bIo1AyZ3
         6Kaj7e7t2oSaMYMU67mAYSSB9w1Ooodcd9eYYXd5U0IHbYVtZUO2yzWI99D7qSdE4jig
         lYt+PGank1SG5IFexEEheZFI1g1S2ukAPrEprd15vZAH6ApjQoBUyZDAjEMALj5OOSmp
         m6ubfwiJeUKuUuVM52egtWfob54hjCmDT0K2V1NwpjUHnjmnrmY+8Mfapf1jFcVa7f2k
         N+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFMKetTQak6j0VDLAYHg/12/6zA58JOcb5v51W00XJk=;
        b=2ahCX4iG12H4VTE79moWywtK45hhlr9jYDt9UBAMNaDwDTqQDMOmEsmgIxJC3VRqN9
         DjTinzQIaoZFLEQUlbUT0OojUaIDkQwcC6Ky7dSFXRM3WNjUKPqBIgXCA6XMaygLrcY4
         TIKzCtroABIlQK99uAeAo4ChyyqmoAPA9BsOQrGMDVzvNQ0u2gTRNtyW7uoY7TySZw/7
         lVoDkGWU+J0uMxBWZzlILvizDuzXeJboGeRjXAOtV/dU2/2YPY28Sd4jhT6Yn7+bUOpd
         QBVAvJ1ZQFyg5ld5wBkrPsTOp/LDcSUJifd5wsEQ2dp4tXeYwyLRUMsrDShZ+PMfvusX
         qKfw==
X-Gm-Message-State: ACrzQf1GCb7l94aqBzcVBdXP/gwjdAKskG7u9QxnEZw/cjps05zt8zSd
        e1UHTMxOCqXG04dzaAUUn00=
X-Google-Smtp-Source: AMsMyM6l0cf0OHXhMDmZRObfznFUKA4RVAvKMVG1NjR8XS7+s7Ilbm7ztUVAhiPKxMdwU6ZDA+3OFg==
X-Received: by 2002:a17:90a:930b:b0:20b:a5d:35d6 with SMTP id p11-20020a17090a930b00b0020b0a5d35d6mr4243801pjo.146.1665076004095;
        Thu, 06 Oct 2022 10:06:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 205-20020a6216d6000000b005613220346asm372987pfw.205.2022.10.06.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:06:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dsal3389 <dsal3389@gmail.com>
Subject: Re: [PATCH 0/2] Minor Refactors: remove useless else
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 10:06:43 -0700
Message-ID: <xmqqmta8lw4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dsal3389 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> git.c removed redundant else statement - it is redundant because all we
> actually need is to check if there are no arguments, the program print
> helpful information to the screen and exit, we don't need the else for that
>
> git-p4.py L371 - remove redundant else statement - same as git.c (made sure
> not to repeat what was already done on #1349
> [https://github.com/git/git/pull/1349]) git-p4.py L404 - minor, there is no
> need to decode the output and iterate over the variable if we may exit
>
> dsal3389 (2):
>   python file more pytonic, adjust "if" and "for"
>   removed else statement
>
>  git-p4.py |  9 ++++-----
>  git.c     | 14 ++++++++------
>  2 files changed, 12 insertions(+), 11 deletions(-)

Welcome to the Git development community.

A few general suggestions.

 * Familiarlize yourself with Documentation/CodingGuidelines and
   Documentation/SubmittingPatches.

 * See how commits in the project are explained in their log
   messages in "git shortlog --no-merges -n100" (for how their
   titles are written to help distinguish them among many other
   commits) and "git log --no-merges -n100" (for how they explain
   why making their changes is a good idea and helps the project).

 * Make sure the name and the e-mail used as the author of your
   commits match the name and the e-mail on the Signed-off-by: line
   in them.

 * Spell check before sending things out to the public list.

