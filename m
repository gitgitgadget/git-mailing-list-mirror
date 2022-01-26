Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B63C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiAZRut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiAZRur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:50:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2310BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:50:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so131270plr.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TTK5iiUzMtqRrb/WVtuYCVaxmoHh0+G/6/ktCF9WqNA=;
        b=I+Vo2E5fRFtRJXpTtTnyNI29zby0Pm2AzgJr5j/uQ8C0ayOuHyAec+dRz3RMDtwmTW
         rVsg5Hg7Fexs7waOCdk4X+mAor9qydTSZMHaqhH95wKUrVXUStO6mezW+GDyfNVtxFxb
         1QFEQ0/nBhfENaieKnFr/2fcTLEPUfITVzoHvnCxu7EmeXt3gngKxdXxRXIdHdWw6eYk
         gKTu2GNxAb1qtQxlFy3K3MXUb96NQ0dA1/TDO1JGQmMU0p2nYBbieCcSu5HjCi2v1mDs
         hnbuxypYDTQE6K/OHRtFZBLea6eKEkQnoZti/igj2UZJxfbcPWsoj9Yj1A2DJXm6nh+S
         qCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TTK5iiUzMtqRrb/WVtuYCVaxmoHh0+G/6/ktCF9WqNA=;
        b=otIKhhOPL+WgvjRp2K3kwncURxjipABy/7ICUZ5OgXF7ttvQAiE1o8bT88fH8Igqrp
         nS6Ie9vWeEY+3CJRW8CDq7c1MUTB/0pJDdzr3oXHwSovh7vUgfrniXUMXFuap0Qnz/5r
         b1z7r6j1gtJaKU9GdtLAoecjirqRtIqEifLJDCXknFpGtmmVAZGubgHgEEgLxiTnDnOy
         sYodUFtbEFX7Z9rLxN4OTIRmcAl7fDVqYcgTfMjDUJBhz6GLuExd7hN1Dab0nJc3YdX+
         7HVW08vxFFlOLc+w4iQF3kWW+rOQrCbWojnJg+VPX4CZrttdLFyMMwnqAdrAJu21vOcI
         9fQA==
X-Gm-Message-State: AOAM532V48gk2Dbg3MmiNN3kW+TtvmMPcH3SFBjAVpi4506rWvP5iEKy
        TwT70L8VZbCAVDdxPzXSFVYFgLgKlcUOCg==
X-Google-Smtp-Source: ABdhPJzNLKYX9c+jOm09IDUgfaNQEPOxfNh6rPVJhjgK6Y9iv1lqzB8JIFZrdHzbO7PKv8CX+c/88R0iEv7JAQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d82:: with SMTP id
 oj2mr1099354pjb.1.1643219446367; Wed, 26 Jan 2022 09:50:46 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:50:44 -0800
In-Reply-To: <CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com>
Message-Id: <kl6lzgniz8qz.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq35lc53e9.fsf@gitster.g> <YfBTRuPrGGjepe+D@google.com> <CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com>
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git (Jan
 2022, #07; Mon, 24))
From:   Glen Choo <chooglen@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        gitscale@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> On Wed, Jan 26, 2022 at 2:02 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>>
>> Finally finding the time to write up another "what's cooking as pertain
>> to overhauling submodules UX" reply.
>>
>> [...]
>> >  Rewrite of "git submodule update" in C.
>> >
>> >  Expecting a reroll?
>> >  cf. <YWiXL+plA7GHfuVv@google.com>
>> >  source: <20211013051805.45662-10-raykar.ath@gmail.com>
>>
>> Sounds like Glen is interested in this series with regard to some edge
>> cases about cloning newly added submodules during a 'git fetch
>> --recurse-submodules'. I'm curious to hear from Atharva about the status
>> of this work :)
>
> Hi!
> I'll preface by saying that I haven't had the time to keep this up to date
> with the other submodule developments.
>
> My recollection was that this series had some small conflicts with
> es/superproject-aware-submodules. The last thing I had done was to
> rebase this on top of es/superproject-aware-submodules [0] and try to
> fix those conflicts. I had not rerolled that branch as a patch series yet,
> because I had thought that superproject-aware-submodules was still
> in flux.
>
> I won't be able to actively work on this in the near future. Feel free to
> pick this up in case this patch is a blocker for yours or Glen's work.
>
> [0] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware

No worries! It's more like we don't want your good work to go to
waste than a blocker :)

Emily is planning to reroll her series and in all likelihood, I'll
attempt the rebase of ar/submodule-update when that's done.
