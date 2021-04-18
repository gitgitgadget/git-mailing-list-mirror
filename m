Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B1C433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E036109F
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhDRFWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 01:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRFWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 01:22:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4EC06174A
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 22:22:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j12so11827942edy.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xv3ag8dIFHHaxslOgO1t2H5X6oEso9768kaObuw09vM=;
        b=hcMjoq+dOazVmAupzp83vPKYM8gvY8ZY0sVIXls5zRTXFG+JRcOL/cek651DlmSt8C
         sWvT3XK4Z4kQq1quUic53XHiEb1s+NcuoTUjqpxFYrqSgCykzeByLJ9mZEit9G6siZyZ
         I2reJ4Kv4pGQUj837au8ArXrfV5DoeNnEQhn50E9MywFMn6MxNGeX5YVhtetE9BQXXNf
         HYgRlWU2nXOV/Rrvm4CwxtZsh+NR+SovOdgHGNry7PrsTDw3cnASDbayvPGQNmpnnS8r
         fbXAWSrfj9IzZNGovTiJv2k8TgvHYCOWG9e9B242+7RcogQVFqQH71AdJe92rLbHFzl4
         OoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xv3ag8dIFHHaxslOgO1t2H5X6oEso9768kaObuw09vM=;
        b=bRwgYuXUMG7Tljk+HrBpZgCzkF83YAPtL9VPks1GufXld6IESISMsWec7pJWzWGnEA
         5YVDPdBvjFis6sPsNYumnOPK+kCx4rHCvUoi5OlU+xDwDlyyfBmtm3fEK1PNMz67hRNz
         dQCWeNiM5qv3Sa1igrE2zlHAsEP6ta2JyN9cVRfetbq3gd3QDsv1kq6DGUWycs+SdiWM
         Q0uYXH/JTkkYxAt1+iVbkS3MVLiY8ifnGo1OFyh4DGKUKJ/KklXWUP8Du8f8/FIfSZcY
         hlxOOinnFdlLRy/ke354AiTLosYu7sNXx8N3wbpdSErl8jEfVARUletSwxEqDWoFPdtT
         tSvA==
X-Gm-Message-State: AOAM533YGW3b1xdhVPr7YLuZx/7saHgSyYpLLNN5vN1DpC7bk5z6g/HL
        IMJuh6B1TTfpnN105aTBwgvnHclFqdiVK5Gamj0=
X-Google-Smtp-Source: ABdhPJzk1LuycJiPRilQaSoyxeL1m7QbwjwvF+XDc+JTGe2bsfj1KBAoaZiSVVI2cVN/sKY90TVfiJqjHVaaSNc4SsI=
X-Received: by 2002:a05:6402:1741:: with SMTP id v1mr18504009edx.127.1618723338604;
 Sat, 17 Apr 2021 22:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <YHofmWcIAidkvJiD@google.com>
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Apr 2021 07:22:07 +0200
Message-ID: <CAP8UFD0Ct8NofMdds=w0k1-jjX638L6QJQEJWVxqJ6ZPSoJUjg@mail.gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, albertcui@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Sat, Apr 17, 2021 at 1:39 AM Emily Shaffer <emilyshaffer@google.com> wro=
te:
>
> Hi folks,
>
> As hinted by a couple recent patches, I'm planning on some pretty big sub=
module
> work over the next 6 months or so - and =C3=86var pointed out to me in
> https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I pro=
bably
> should share some of those plans ahead of time. :) So attached is a light=
ly
> modified version of the doc that we've been working on internally at Goog=
le,
> focusing on what we think would be an ideal submodule workflow.

Thanks for sharing this doc! My main concern with this is that we are
likely to have a GSoC student working soon on finishing to port `git
submodule` to C code. And I wonder how that would interact with your
work.
