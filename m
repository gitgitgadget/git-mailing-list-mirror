Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE2C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A494260724
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFWJcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 05:32:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F4C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:29:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so2909386wms.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w3+burFS1+6l+yqI9zTONsUIN7fRDzyzW3QF+V1DL8Q=;
        b=NRoL3Rbnmhpb/JkP6tuavmxHXE7w0e7z8VuvLinO63MgcPvNJVGDqoSOVRFDokKV5i
         j/p/wULMG4JzG7YQKUTI2x7PvAWIlazy5sLxgl2NaLeUDg2jx3JQ/MYWSiGDFNMyGsfl
         TVjYtfxd/7mPfACsdZZFzmzAXb+uGyjEPha7eYUXV6jLbQV9MJzy3ZZIoU1zugH/dGMB
         r7Ty3xQm0jYhM+8tGGZRbA6FjECHLeXzE40/Qm3/2BGDB9AdeTR9D/P+GOuaJfARJ911
         g4f91JnL3rZYyXGf8UA5ceLL5g0jVvJWjdtRninmATT/Y+VI7JCxPwzk4TikSnRmC3sA
         guFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w3+burFS1+6l+yqI9zTONsUIN7fRDzyzW3QF+V1DL8Q=;
        b=Wcgh5UvakxvN4jjBKRPiSyX3Xp+jP6bHzKJ/rUUUPMyLylIR8FJyRzutVkB86I8S9Z
         pZiCZDQE3uDEqBLXUpjVirvSIr3bEdPCZMv2vh6TawMnMOgw51guD9hm8Gcqz6BDm6av
         IyM1PnqteeMfDVQxsvN00oznKMlUzIuYV9erke9b58NcXSXleOUKzmLUx2H8qYxcvwMj
         tYrNn5Bk0AXPyilIBJjLu26UrOsEF+Kxgs+ahc1/hGz0+NTy1D3SCqCNMwZNuaoIBLeF
         Uys9nRzvvwMVNlu90KbO3DRdU+hmatTNUhGjLLIT9J6cXCJ5ysUnotkjY9fP+Oaobkwo
         e6Sg==
X-Gm-Message-State: AOAM532/sBcjfNq7jaq8lZpdDqbQxmBiNEC+Nbm12N6uJ7sySMz5ypOl
        9wsxfgRBRdghfI7Xj43MDSU=
X-Google-Smtp-Source: ABdhPJyrjidRi7n6PlosjozHYA/aW5DnrQTPFK8BYmr4pzzSDOQI8DPRGxrAlvuHrJSZ+GHxcdJ43w==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr9421667wmc.71.1624440598497;
        Wed, 23 Jun 2021 02:29:58 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id m7sm2480333wrv.35.2021.06.23.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:29:58 -0700 (PDT)
Subject: Re: Forcing git to use a pager without a tty
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Avishay Matayev <me@avishay.dev>, git@vger.kernel.org
Cc:     gitster@pobox.com
Reply-To: phillip.wood@dunelm.org.uk
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com>
Message-ID: <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
Date:   Wed, 23 Jun 2021 10:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/2021 10:05, Phillip Wood wrote:
> Hi Avishay
> 
> On 22/06/2021 23:40, Avishay Matayev wrote:
>> Hi there!
>>
>> Fugitive[1] is a vim plugin that wraps git and many of its commands
>> into the editor in a really awesome way, I won't meddle into it too
>> much as you can read about it in its README, but as you understand, it
>> uses git, a lot.
>>
>> Some git commands use a pager, which is usually a program that needs a
>> pty to function properly (`less`, for example). Fugitive can't really
>> use a pty for the pager as vim runs its subprocesses without a pty.
>> Therefore Fugitive just creates its own pager (which is a simple
>> window in vim) and pastes the git command output there.
> 
> If I understand correctly fugitive is reading the output of the git 
> command over a pipe and putting it into a vim buffer?
> 
>> The only problem left is that Fugitive can't reliably know when git
>> decides to use the pager, for example `git reflog show` does raise the
>> pager while `git reflog expire` does not. Fugitive currently maintains
>> an (very possibly) incomplete list of commands that need a pager but
>> maintaining it manually isn't ideal.
> 
> I don't understand, if as you say above there isn't a pty then git wont 
> use a pager unless GIT_PAGER_IN_USE is set which Fugitive does not seem 
> to,

Sorry that is confused. GIT_PAGER_IN_USE only causes git to act as if a 
pager is being used (for example so it colors things as if it was 
outputting to a tty), it does not invoke the pager

  so I'm not sure what you mean by 'Fugitive can't reliably know when
> git decides to use the pager'

I'm still confused by this - if there is no tty git wont use a pager.

Best Wishes

Phillip

>> I started discussing this on an issue in Fugitive's github page[2] and
>> Tim Pope (the creator and maintainer of Fugitive, thank you!)
>> explained that `git` doesn't use a pager if there is no pty so it's
>> impossible to override its behavior.
>>
>> We had some ideas how to make this feasible (as you can read on the
>> thread) but for brevity's sake I'll present the best (IMO) idea:
>> Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
>> `setup_pager`?) due to pty absence if a new environment variable is
>> present, perhaps something like `GIT_PAGER_FORCE` which will override
>> the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
>> apply custom logic through to pager to know if one exists and present
>> the window in vim.
> 
> I note that the latest comment [1] on the github issue talks about a 
> different solution that would cause all git commands to behave as if 
> there was a pty present.
> 
> [1] 
> https://github.com/tpope/vim-fugitive/issues/1772#issuecomment-866401942
> 
> Best Wishes
> 
> Phillip
> 
>> I will appreciate any written thoughts on the matter, thank you :)
>>
>> P.S. I am a complete newbie in regards to mailing lists etiquette,
>> pardon me if I've done anything incorrect
>> P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
>> changes to `pager.c`, sorry if that was wrong of me (You probably got
>> this mail twice because of a misconfiguration, oops)
>>
>>
>> 1. https://github.com/tpope/vim-fugitive
>> 2. https://github.com/tpope/vim-fugitive/issues/1772
>>

