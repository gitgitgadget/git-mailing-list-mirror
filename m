Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE7C4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEFE600CD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhHKKbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbhHKKbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:31:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8422C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:30:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so2089848pll.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=zvvevIVNUGgh6n6/87sm0eC2Scio+sAEnkjuazyh7f4=;
        b=Ia1YWejNzB3Dd5euKOQJqrZCVh75yxXvHupVfqCX77x3zDi8vOfRkcyJ9w4gvNNu0c
         fQXLHPhbShdNSBG7UOguuafMjbIYxQsKIsvcXfbF+GwqvsrmrCZt80PHYm4NnDc87P6y
         S12yEoxMlvAL363BarBlHe/lrtiavJQWCjgCrgiQmRqqSTM8IbhdAK4pDyqd+G102Ie4
         FvK7KjmZTKtFu34IEMdVZXgebrj2aLH5aYFzyQVp5fl9jXROC6LPt/NdpJ3gaWa1IyVU
         nHGfh7jK2jgCG49CXuaaeW+Qtl0oiXTmIUc+MKMtBC5lR08VzslJLV1Qg0qIhgHgmK31
         NDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=zvvevIVNUGgh6n6/87sm0eC2Scio+sAEnkjuazyh7f4=;
        b=DfB+Ypn3KdCDrLUJc6ZlUaYSeSxKcjgHuPVOw8q7SzihdHKn+RAyKkPs08F0nf39/i
         dYJ948UoznwhPXdd0pSzM2J6EF4KUF2YXUiewDoBqNO2gHKXfKWpl1svIvpCTbBi+c29
         WTRtV2r7sqhSHcD4jKeGVYntGqjDMQFFqdEkWyeWMHNC7MkZHWl9DnJ6aXQA7lk74fnW
         AoopyFJI1UqJItg/Yn+rnGRW47Ix9hvryVosJnfiIoEWxVQMCwCO6B2lXikCSO2rIhKE
         9iy3BNTKpzWob2E2YPBYF6Ok1PXEir6MYZixXHEAkd+7Ilnd1l65ZimbQ4hRzhn/Prqw
         9E0g==
X-Gm-Message-State: AOAM530UHyadQb+wLaowtPshJSByHti8Xe9Cu9y59Kst/vb4quJs+d2q
        nPSvOJGnF37pURysSexPqmY=
X-Google-Smtp-Source: ABdhPJz9GAdEC+b5Zk69edF2+nAu/Moo3GQfMmIUifXANySXZwfXFsjL4Cqp6rXRLGtY5bhyK6g9yg==
X-Received: by 2002:a65:6883:: with SMTP id e3mr221420pgt.90.1628677845383;
        Wed, 11 Aug 2021 03:30:45 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id q140sm22913128pfc.191.2021.08.11.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:30:45 -0700 (PDT)
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
 <20210810114641.27188-2-raykar.ath@gmail.com>
 <21917b01-94f7-2698-b904-2d75f37af447@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v5 1/9] submodule--helper: add options for
 compute_submodule_clone_url()
In-reply-to: <21917b01-94f7-2698-b904-2d75f37af447@gmail.com>
Message-ID: <m2pmuk9stu.fsf@gmail.com>
Date:   Wed, 11 Aug 2021 16:00:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 10/08/21 18.46, Atharva Raykar wrote:
>>   	if (git_config_get_string(remotesb.buf, &remoteurl)) {
>> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
>> +		if (!quiet)
>> +			warning(_("could not look up configuration '%s'. "
>> +				  "Assuming this repository is its own "
>> +				  "authoritative upstream."),
>> +				remotesb.buf);
>>   		remoteurl = xgetcwd();
>>   	}
>
> Why did you split warning message? We could keep that in one line.

That line was too long, and given that I was moving the function and
changing it a little bit, I decided to make it adhere more closely to
the CodingGuidelines [1] and local convention.

[1] https://github.com/git/git/blob/6c85aac65fb455af85745130ce35ddae4678db84/Documentation/CodingGuidelines#L190
