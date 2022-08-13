Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4276C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiHMJIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 05:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 05:08:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFDF12D3E
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:08:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so1450284wma.4
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=1dL0V8WsaP86T0GGTdIzazdVbc2fOUwClUK+/ikFMr0=;
        b=L4DU7P0EPQm89vhJVHXN9yQYzGP09SUbMWnj3aSLaU+yj1r+MTw2O4kliCd9J+E9Cw
         XXo2dP7DPu/MdANLpP/pD91At1GuHRjEtRSiahnHYXVfMVQE75B2WqmoEmftyD/bV2iZ
         zzMiytEaZ74rCXoezGxW77duUshSPIItzhsMWIO6Z37syfZ657LD2f0EqfbsSvXw/dVZ
         bfh3B3mJXEQLE0X0AziFNcLaMRjWdokjT8EptRUp9Wj3pZku7HqpK1UMqYoHQcLaNrTS
         f4+PFucdHZ35JEa6cdoUxFNYE7d12pj3wvodP8GmnyTlmnnYeABChm3WZklP2wVoAm62
         fVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=1dL0V8WsaP86T0GGTdIzazdVbc2fOUwClUK+/ikFMr0=;
        b=qTLDdyRRbcx14y98QDMbXjd0ASUqz4Eib/Tn1/hj87E08CcPCwbz6rvqaq/wulmIyQ
         baYaE28IOYkf7tRRA5pcLVhxJ/qpn8CQBuA4wwpaAA3e5sqPQBb9ZhQCa16gOAy68QhW
         TLFufZCoAtg7O8647vLDKJGrM9p5M6jLQJgfoN60aN21D3UTZyalI1hKYWgZXV9MDXUn
         X7yuUJFLlBYhBI1nth48qm5KNdWU78pVbED5iM/Fu69s0mya4zITwgtRIQCd/tMEdcZj
         g8Y/y2IDJT4Dxq3ICry6IJ+Wnc72g1p9De6tt2aTtK9j0nuwxIfVB91BYZSCzGLFkCp5
         NIQQ==
X-Gm-Message-State: ACgBeo3V2lktt8sfXnBvDDsY4PbfCwBqexoKXKMlQO4p71DBlFoW16xI
        YSXHpIpKRrAI0t3QhTXsjm+JL3qIVBR1HhcL
X-Google-Smtp-Source: AA6agR7ZTYMcFY+FUte8iYgLmc3IoZW8ZzrQpUw69yuYtCTuBPEI209LmxGheIjfhdnP1Yrl7M7ULw==
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr5109972wmq.64.1660381725385;
        Sat, 13 Aug 2022 02:08:45 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003a5b6086381sm2266637wms.48.2022.08.13.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 02:08:44 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <8b00e461-dbf2-1bd8-f9bd-b4c5673dd450@gmail.com>
Date:   Sat, 13 Aug 2022 11:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the /allow!

On Mon, Aug 8, 2022 at 3:26 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de>  wrote:

> Touching only the `delete_branches()` function suggests that other
> commands are left as before, e.g. `git branch --unset-upstream -` would
> probably fail.
>
> That's fine, but the commit message claims that the `"-"` special-casing
> is introduced for the `git branch` command, not just for `git branch -d`.
>
>>                        die(_("Couldn't look up commit object for HEAD"));
>>        }
> At this stage, we already handled the `--remotes` flag, therefore I think
> that this patch does not do the intended thing for this command-line:
>
>          git branch -d --remotes -
>
>> +     if ((argc == 1) && !strcmp(argv[0], "-")) {
>> +             argv[0] = "@{-1}";
>> +     }
> This means that we only handle `git branch -d -`, but not `git branch -d
> some-branch - some-other-branch`.
>
> Could you fix that?

I did it on purpose, to be interpreted in the context of "git branch
-d/D" with just one branch: "previous branch". I agree the commit
message does not suggest this, I can fix it.

My intention is a short-hand for "delete previous branch", the same
way "git merge -" is "merge previous branch".

The workflow to address is just allow doing:

$ git checkout work_to_review
$ git checkout -
$ git merge -
$ git branch -d -

Instead of:

$ git checkout work_to_review
$ git checkout -
$ git merge -
$ git branch -d work_to_review

The syntax @{-1} is hard for me to write, and I feel intuitive "-",
like in "cd -".

Make sense to me...

