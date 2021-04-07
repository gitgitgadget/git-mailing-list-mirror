Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92351C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5726121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhDGWSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDGWSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:18:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F314C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:17:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x4so1696759edd.2
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zTNa5Y5odr4nnM3turTlcPglFBeoBKjaax8THSxamPQ=;
        b=oys0GzGT4cTfMLMTLAunCUYdTsNXV/bWfN+LbcM5fQxP6EG/XKjm0tajEETwxGwKED
         R81FLoTF25Vi5gL/qvTJPwKHUsfreSsX8Cz6Dr92W+70Su8CwHNoMVrXXOZ60LEHHL89
         ZxemZEgMnWRqf+cXIuRjiHrdS64typPCMHO35HUeWndZgx9hpL3fk5Z+WW7/WV/CiSP2
         x1eN2CZ7zDTNBRl0V+xwnQuHoS4QDWjHaW0ePwwvmu4vm76VMXyzVRc07qV4tvQ06y9E
         EIZi1fucys/S0GvwapGTc81tUiS8hcJQHdUxdMVEtqUTZ96QQocvjPA3wTEmgzEm8Cy8
         XPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zTNa5Y5odr4nnM3turTlcPglFBeoBKjaax8THSxamPQ=;
        b=B1OkenjPch9ubPM941hzEyFxbLocvtYuYgp/HQYp3RPgfraCVlvLWjJINZdWtXtKqw
         Az815gaiejsLYiKs0ZbmYZD0NwDFU0dAG0mKQjGsihYbB2ng9rJMtK6EUGrBfugQ9Gsj
         5iGMTKmcvNEL7Bof8OY64s+ukA+P2+cPHprJjEd/ltdIxyLqDyp3vY5CeGi+wDbnDtqH
         Arz3KJJIVKQhPlefqaSJnNCWURo/EnkdUDSDvPmgA6lgXtoBxwPw2uv9Fl28Bj91XtfN
         x5UuDJ9/uLMOeaVzrmK5634Y46Ubw8HhKnui4KwEZoxITJo+xTLKxpuNRjDF41UXw3uc
         1xzA==
X-Gm-Message-State: AOAM530ZEhvt0ICDV4tcfEPLjb4fiQNwkvhD+KtQUOVyznt6W+q1fhK9
        zFwA4sdLeUfLbOjgeuFc9izb9CyFDdrNTw==
X-Google-Smtp-Source: ABdhPJwCJEdAEVC/M1J4qXvAoVocAKlV8WfNdIIRMSwyufjV9HNHfjbmsgJl/dt4XI16Ajb287XLQw==
X-Received: by 2002:aa7:c1cc:: with SMTP id d12mr7395086edp.136.1617833871118;
        Wed, 07 Apr 2021 15:17:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q18sm755791edr.26.2021.04.07.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:17:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Subject: Re: No error when overwriting ignored files
References: <2056254759.360640.1617825398727.JavaMail.zimbra@inf.utfsm.cl>
 <YG4Tl1IPlFBIhV4l@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YG4Tl1IPlFBIhV4l@coredump.intra.peff.net>
Date:   Thu, 08 Apr 2021 00:17:50 +0200
Message-ID: <87a6q9kacx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 07 2021, Jeff King wrote:

> On Wed, Apr 07, 2021 at 03:56:38PM -0400, Horst von Brand wrote:
>
>> When pulling from a repository that tracks a file listed in
>> `.gitignore` that would overwrite a local file, this is not reported.
>> 
>> For example, in the attached repositories, when doing `git pull tst1`
>> in `tst2`, it is (correctly) reported that `ignored.not` would be
>> overwritten, while `ignored.txt` is not reported.
>
> This is behaving as intended. Ignored files are not considered
> "precious". You can find more discussion by searching for that term in
> the list archive.
>
> There is no concept of "ignored but precious" in Git. However, here's an
> old patch series that tries to move in that direction (using an
> attribute):
>
>   https://lore.kernel.org/git/20190216114938.18843-1-pclouds@gmail.com/
>
> AFAIK nobody is actively working on it right now.

Having re-read that thread now I still think by far the most useful way
forward with this for anyone who's interested is to investigate/add
missing tests for our current behavior, why/when it got introduced,
whether anyone wanted it or if it was emergent etc. See [1] for a
summary.

That's quite a bit of work, but is work that someone with little/no
previous familiarity with git's development should be able to do with
enough time & motivation....

1. https://lore.kernel.org/git/87ftsi68ke.fsf@evledraar.gmail.com/
