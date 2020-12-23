Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80CC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034FA229CA
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLWOrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgLWOri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:47:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83952C0613D6
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:46:58 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l200so18418162oig.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q3fREr9cR/1zsFu4OdY9INVlIbfx70tIOadFRHHKIhA=;
        b=UcceONA5Z5fuGsLtgYA6R+8KUuTfDXJG89Ii1C91EOt1NktK6F0M9Qz9vXv3HZMen1
         W+rhIx08CYNz5J+ZKCHTf/W+Uq1csoUCHOO+wEVTlbBvnBTuFXkARmIel/s5muLdRcWu
         Ig8hlioTxQibCl5e6JeA2VpJxZrx6a5YbbtmjMnoMmF1Qhll8u+miThLQSOEdYAWpjtY
         QWgtE0A5QQ+bYtqOlRYBg++R2WGqPgxvLvB945Qo17DPQ13VPrT68LY9GTwBILNqxYQz
         sg65Hot38m8MjE1PW6BykvDLN7L0g5IeLZP/9Bsq4eU16A6d551Ucr2yFWDEQLTeN/Hk
         FqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q3fREr9cR/1zsFu4OdY9INVlIbfx70tIOadFRHHKIhA=;
        b=MIEROQLQgOP1Bb4guhv0M0BHoSvU5zO0KDdvqPMczR5VmBXrQarZnUCXfu3OV19k1G
         Tvy8xKFt74+lp2mTsCjvWE2tQmwTx//eujyl14IKWPBdHMkpSBsgWkyaRV1uxF1J9lR1
         +8QKNVPzlaME0V4D4bsLsGne8PJCj2s9hDuZCrgoB3P/UXfTW0g5mMUE7rKzSlNhQYEp
         fqPLnZQhWiDP3Q8mh/f3AVWjHwylR7bJwuLmrqTR08+FgyeV4NHKznHi7wFo23KN0P3g
         RuNgoC0QFAnd2dw4kMsCyDpOOj3KnECwAXtSllQWMjSeFevU06PWPVv//r7jpL9gYG4x
         thrg==
X-Gm-Message-State: AOAM5300sr5HBKhGzIKOaChssliz0VavcsFR/xCP6d/nOggc9XFHbb7s
        PvwVFdDscXOXPsgchgMG+XAbmsasGrZypQ==
X-Google-Smtp-Source: ABdhPJw5VXbTC++QXih239bSGY5Z2FU3breR+5rSblx850WNgXG8ZsBBztO+Inuf2zPXa+j+9M/4zQ==
X-Received: by 2002:aca:538c:: with SMTP id h134mr108770oib.44.1608734817889;
        Wed, 23 Dec 2020 06:46:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i25sm5342575oto.56.2020.12.23.06.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 06:46:57 -0800 (PST)
Message-ID: <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
Date:   Wed, 23 Dec 2020 09:46:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Content-Language: en-US
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     git@sfconservancy.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20201223061718.102779-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23/2020 1:17 AM, Felipe Contreras wrote:
> As many argued; respect cannot be manufactured at will. If you don't
> respect an idea (for example that the Earth is flat), then it doesn't
> matter how hard you try; you still will not respect it.

...

>  * Using welcoming and inclusive language
> -* Being respectful of differing viewpoints and experiences
> +* Being tolerant of differing viewpoints and experiences
>  * Gracefully accepting constructive criticism
>  * Focusing on what is best for the community
>  * Showing empathy towards other community members

As mentioned in 5cdf230 (add a Code of Conduct document, 2019-09-24):

    This patch adapts the Contributor Covenant Code of Conduct. As opposed
    to writing our own from scratch, this uses common and well-accepted
    language, and strikes a good balance between illustrating expectations
    and avoiding a laundry list of behaviors. It's also the same document
    used by the Git for Windows project.

It is highly recommended to stick to the widely-used and carefully
crafted phrasing.

Specifically, "Being respectful" is different from "Have respect", which
negates your argument for changing this word. We can only enforce what
is evidenced by actual communication, not the internal lives of community
members.

I could just as easily argue that it is possible to be tolerant without
being respectful.

Thanks,
-Stolee
