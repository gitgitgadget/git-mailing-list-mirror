Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C4C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB60F61427
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhDUKT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhDUKTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:19:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41488C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:19:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so62739631ejo.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VYIrEZU0gFR+7PzEquVBpwX/q9s60U8SBhpYOA0KZGw=;
        b=bUZottQYdrxpi/UHGCCDHd3hT8o3QUzJV90F3Vnp3S0yL6JJd+FPIzd+o2WAoeNZXv
         kw1JF5mJdRBrchUiaJA8fFA85Nfhxn2e+saP13pha2SINWH/g0rMJ49ZKUgvzcKz5nUW
         wc7ocCJ14vy+wuCaJlYOxBUxKTOEYdhFepeNJsL3br6I0cbP739ZHuwF0j2+/BHtYlVN
         DixxMKZk+S59C6vlConWKhJuNQNI3xA95Xk3YBdTBJ1ZW8/SU/X//IIbc563/67zpA2l
         4n14i9ZzBaoVlEUGBq7sL0S1UHTT8scBJVgDlTbnfmByw8ewYXgf94HfGz1LyiBKVDcU
         sLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VYIrEZU0gFR+7PzEquVBpwX/q9s60U8SBhpYOA0KZGw=;
        b=QBCs6YueKw2yLJaSguOGXkWtlwPK2mnjym84lOaFQl3VEGOov4oSwxHq7CDlPcOZ+h
         AmDo6qmXeDp34vRGgFk1m2tq1OW2fSpLc7h/aFWIc62/rjDjc7ickMT87PvA4RsRwdAx
         z5MRLRyI+ANd75WnFPRcEfIqPHChC5891RC/86m62d5QdOEq7bGBw8yju3b2WB3oObjF
         sEho2uYMi9w2gnlMjiq0kwLXNHjFVq5GbQZWTjrnSjn7pFlNtZoVLE1mGNBDTZZqKfHL
         IJjl27pdWhei/yllxSNwEYG5t4a3S73VMbkbhJaxrjlkF/lJ3hn1cn29tEy1glrx6Dz7
         5Vtw==
X-Gm-Message-State: AOAM533WuN77NWdpzyAVjSkZhQ7fMYrKoCdBH3CnzVUolfX43cQTVnwB
        qOLzKnE9AXAqFro9Pk4d72w=
X-Google-Smtp-Source: ABdhPJzuHze33a1F499zrbPFClzSTrNc2qx6sjLFeUUAg9Cn9gZfY/FZqM2e/pPT2VFUF7pfB4LBpg==
X-Received: by 2002:a17:906:3111:: with SMTP id 17mr31590617ejx.403.1619000359933;
        Wed, 21 Apr 2021 03:19:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b22sm2597848edv.96.2021.04.21.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:19:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
 <20210419025754.GA26065@dcvr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210419025754.GA26065@dcvr>
Date:   Wed, 21 Apr 2021 12:19:18 +0200
Message-ID: <87o8e82b4p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Eric Wong wrote:

> Son Luong Ngoc <sluongng@gmail.com> wrote:
>> [...]
>> 3. Isssue with archive:
>> 
>> - I don't find the ML archive trivial for new comers.  It took me a bit
>>   of time to realize: 'Oh if I scroll to bottom and find the "Thread 
>>   overview" then I can navigate a mailing thread a lot easier'.
>
> (I'm the maintainer of public-inbox, the archival software you
> seem to be referring to).
>
> I'm not sure how to make "Thread overview" easier to find
> without cluttering the display near the top.  Maybe I'll try
> aria labels in the Subject: link...

I'd say the bare-bones style of it is probably jarring to most users
today. I had to check if the site even had any CSS at all.

I.e. I think a more intuitive UI to users today would probably be some
collapsible side-bar on the left of the screen, which would have a
threaded view. The "Archives are clonable" would probably belong in some
"help" tab in such a UI.
