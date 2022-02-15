Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE441C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiBOPMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:12:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiBOPMN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:12:13 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A9C60
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:12:03 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id o23so1583672oie.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FWKBnjjja81ADguY3KCKsqrcfAtlfqIxfWwHca5Lr/g=;
        b=I48tYycWpplOlFwEbeYUAkNS4tQb30B2fF5JgbdQIVg5B2bJLttmndK/IbSk0JidJo
         tidlaOF/H46GBumoFvVsKqiy83LHpwfNB/M1gti0B0NG+JBASV4850a+MOfXQGg/EuGu
         2Q6/vL37+IxXDwiVKNaIc+hCSInY2hkNJNJDZgIwhtJQ6Ugj44n9Vm5mRtPwHilF/q5T
         cq33ZKdm7bT+hjw82YFYvbJTyox4w5YTx/g6WsDl3zGmYUhQowKeXXUaXQ5SnjZujZiQ
         MTswECYV4JxeEcGMOekB6ZiRTIp8qkt0xvoxm6KJMYXKniJ+yu3KIoFzHhf1XwRXs3FP
         cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FWKBnjjja81ADguY3KCKsqrcfAtlfqIxfWwHca5Lr/g=;
        b=BqDNV3LNBWJHO8E9HIbgARiNFgB+lqqXIQ13gZwwWspmdrD0cMI+3qWyTHl6QTJlJ5
         OE4iQiZ62V8EORrQB/0qaocJ06imUSye0dk9qxXkhjr1+xQHbDNih8kSB/xKtkNOO3f+
         VB0lHu5qw6ov14W0FBA/PrcIiWrvXaBSoKRWrrld8iCfFFaWAkFojt3fvls2UKYDRWPy
         iH/TEl1fLYhkYSuk8aR7pxFF2Aa339sAUgYO6tSQL1/D9ibTEdY9CYryycCHbIDgogHN
         /H6RI1dC7OYtdt0pBDFssm4KfCkbyRkzDWB8JrBPUZCfDD05szb9Hv/37HSmi/laP6FC
         JTSg==
X-Gm-Message-State: AOAM5328OtHm1NkupWQUlNBqKDOTu65t+jTBifQvJOwPSvGaZxOM10Jk
        nHvPF97OAS9bVkSyjAx5/lu7
X-Google-Smtp-Source: ABdhPJzSEtmL70uR+bIOeoC2wl0B6u0Dib6DlFu67Nnfx1TPDeGITCM1ups8dH77XipYQ0v9yofzjQ==
X-Received: by 2002:a05:6808:309b:b0:2d4:2ecf:1741 with SMTP id bl27-20020a056808309b00b002d42ecf1741mr683965oib.85.1644937923025;
        Tue, 15 Feb 2022 07:12:03 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s6sm16185931oap.32.2022.02.15.07.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:12:02 -0800 (PST)
Message-ID: <081b7b15-9194-6606-97fa-2effd30292a1@github.com>
Date:   Tue, 15 Feb 2022 10:12:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/7] RFC: sparse checkout: make --cone mode the default,
 and check add/set argument validity
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <dfda7d2e-940b-bb54-6d2b-cda3a00abc0a@github.com>
 <CABPp-BGWRFTcNxbpMkVAqnpGO0iEA=-dAMJ979GfYSSL=t+ZTQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGWRFTcNxbpMkVAqnpGO0iEA=-dAMJ979GfYSSL=t+ZTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 12:12 AM, Elijah Newren wrote:
> On Mon, Feb 14, 2022 at 8:19 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
>>> Note (reason for RFC): this is RFC primarily because of dependencies (you
>>> may not want to pick this up yet, Junio), though there is also a question of
>>> whether to split patch 7 into two steps -- one for now and one we take in
>>> some future release. In particular, the first step could be to have
>>> sparse-checkout error out if neither --no-cone nor --cone are specified and
>>> then change the default to be --cone in some future release. I don't think
>>> splitting it into two steps is needed given (a) users who are unaware of the
>>> change will still get useful error messages telling them that directories
>>> are expected due to patches 4-6 of this series, and (b) the huge
>>> "EXPERIMENTAL" warning and explicit note about likely behavioral changes in
>>> git-sparse-checkout.txt serves as warning about the changes. However, the
>>> two step approach is an alternative.
>>
>> I support this change. This will also require an update to the 'git clone'
>> documentation around the '--sparse' option, as I imagine we are going to
>> be changing behavior there. (If not, then we should do that as part of the
>> deprecation.)
> 
> Why would that be needed?  The documentation does not specify anything
> about cone vs. non-cone mode, only that the initial working tree will
> only have files from the toplevel directory present.  So, the
> documentation is correct without any needed changes.

OK. That makes sense.

>> I took a close look at these patches and mostly have minor typo fixes. There
>> was one behavior issue: I don't think you should warn for file paths in non-
>> cone-mode. Being able to select a single file in a directory full of large
>> files is one of the main reasons to use non-cone-mode, in my experience.
> 
> In which case shouldn't we still show a warning when users specify a
> path rather than a pattern, since the former risks selecting more than
> one file?  (Adding a leading slash should be recommended for such a
> case, right?)

Yes, that is enough of a tweak for me. Thanks.

>> We can also consider if we need a release or two where this behavior
>> change is announced, but not actually done. I'm not sure if that is
>> necessary. Making '--no-cone' required might stir up some noise that
>> indicate how much of an impact the change would make.
> 
> We can discuss this more later, but I think it's worthwhile to
> consider what happens even if folks didn't read the BIG warning about
> behavioral changes in the git-sparse-checkout.txt manual, and didn't
> know about the default change, and tried to use it anyway.  If they
> specify something other than a directory, then they'd get an error
> message due to the first six patches of this series -- at which point
> they can look to the manual and decide to add --no-cone to their
> command.  In other words, it basically does the same thing that we'd
> do if we decided to have an interim period with an error when neither
> --cone or --no-cone were specified, other than the error message
> perhaps being slightly different.  What if the user does specify
> directories and doesn't know about the default mode change?  Well,
> that's where the two modes overlap and things work fine (with only
> minor differences in behavior, such as better performance, and files
> from leading directories being included), so the user would be able to
> continue with their work.  So, I'm not sure that an interim period
> where we error out when neither --cone or --no-cone are specified is
> going to buy us much of anything.  And besides, we do have that super
> big scary warning in the manual.  Anyway, I'll bring this all up again
> when I resubmit the final patch broken up into a separate series.

I suppose the warning/error messages are a way to help users
self-correct to this behavior change. I'm willing to see how that
plays out.

Thanks,
-Stolee
