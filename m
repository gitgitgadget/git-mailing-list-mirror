Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322CDC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 08:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED14E206C3
	for <git@archiver.kernel.org>; Sat, 23 May 2020 08:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txBorFYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgEWIzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 04:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgEWIzd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 04:55:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CBC061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 01:55:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so328995wmd.5
        for <git@vger.kernel.org>; Sat, 23 May 2020 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+qHdXfNmpiMbDUaWXTYNmMke3taUnQf3C/Q2/VIhrKI=;
        b=txBorFYHeYEZ/t4CCSRr58U1wPGxGYy7rO7ymtAaxhY0KdIWHSUmRpn+LT4KooGF7F
         4+SOQ2cVzgWWN8qEj3KJiwy3blWLltPnRH8A0hABjux9wWxiv9Io6Hvtlc/Op+2OEp5x
         thIbIDJLknu46ByyHx1fhf2xHdBbGJWszISwbwNKp2nsF/2171vUFWx/Mc3DSU38bcIH
         pfeaLYuLNRWksQAAD0Wk+2M19l5W6fpA6M57DZRdzotv9kDtVYpswptQzyqu7w9+fte/
         z4UeHghsPwOdspaLjd/iy25HBXLpm6wT2fTYoQIUAhsUIwXnw84SySjnK0juxWb9dcBQ
         ObcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+qHdXfNmpiMbDUaWXTYNmMke3taUnQf3C/Q2/VIhrKI=;
        b=NEn3FaoOsg5NNXScC/PQ6hkIkcFKLp5mP2OOaOHrl8r/1O+hmfESFa0/2v4xRrOxme
         KMSBRtou3D24nvHW5okuD//Q3NJ0+ncOazZao38G387568ir53LfpAbBMwrlbEj0VZMm
         7ZEAtgjJUQlbZcauo1IMGgkwuc0tTvJ/vVX06/AL1bSZjoxVkIlVVOPxZQFaFxRsFQbA
         AG1gyKyfab3MfJBMWGP99FTtgzg6H4xZNBYKLqW+cuO8EOvFt8l2KNLxO2YDYww8KBcY
         IZTmqlcgE8aafqmXh4FCpn0E18no0YVm0mT0h3o5whKo/QrkNHwQESRIwM+jFPLfLmOn
         BZag==
X-Gm-Message-State: AOAM530Zwhe4WiUkRPJ1uw0SkYBRsDVZW3hDtSs6QgoFUFmnJil0JQn5
        6FyqP8jgGLUEJYBtuy8jcDmornEC
X-Google-Smtp-Source: ABdhPJyWCYDYM+C/7XP4gcPCP3xiusJCuLkU1PpHtY1ohK8gISIOas1z0KQhSTAHRuGxFzqGqnMIBA==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr737762wmo.139.1590224131253;
        Sat, 23 May 2020 01:55:31 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id g69sm7470103wmg.15.2020.05.23.01.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 01:55:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/5] cleanup ra/rebase-i-more-options
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <CABPp-BFaexpFo-n-vPxZ2e4dF9aT45NXK8rnmJ6gi+qvLN+P+Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7bf6d78c-89b1-48c2-aeba-e674058be23e@gmail.com>
Date:   Sat, 23 May 2020 09:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFaexpFo-n-vPxZ2e4dF9aT45NXK8rnmJ6gi+qvLN+P+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/2020 16:54, Elijah Newren wrote:
> On Thu, May 21, 2020 at 3:15 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Thanks for the feedback on v2, I've updated the documentation as
>> suggested by Elijah and made the style fixes suggested by Alban but
>> I've not changed read_author_script() for the reasons explained in
>> https://lore.kernel.org/git/c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.com
> 
> All my questions were answered earlier; this round addressed my
> remaining feedback and I see no new issues.
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks Elijah
