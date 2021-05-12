Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86093C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DFB61465
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhELGq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELGq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:46:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6444C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:45:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i81so21383279oif.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6ENwTTHnc2ZOu0ROaupWpcZcUsr2OgStw7EVuLYfH4E=;
        b=D/2Z0+cgjvJTMANMELsBTFGQk36sZT0w0t1VjfaTsVWIU6xx7iX5lSnZVJujo/p3le
         HwGmdWuKSZxMVi51qJ2vRDgAe95hhwwlSdbBZFVEVXLYeKvF2/hiboc0fpPVL1ZykqWc
         EeiBj4CqGa4XSn7+t523go/c6EkGBCW5ryYRWkxl1owpPh7/FvbDj9PEyNGxBeP/DRMf
         poPnkVB88oV7UIMqIWxRKJtYE3L/B0xaAzcUO8Sju3GQ/74kYQqjtOs2kyPa0Wn5IhAW
         wvjO1FKcSPyX39M/+OUeDsU/YYq1kFqfpgnFV0NPOFazWbIh2R3ajLhcD5s1DvmnWdGO
         bRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6ENwTTHnc2ZOu0ROaupWpcZcUsr2OgStw7EVuLYfH4E=;
        b=EcEg2kXCNbP8fh4VwHt7cstCv++PHiFUckwC8jpv6K85dQc1jfbsBbWYBYG/QCJquP
         QhbO5njnACRgjj1WZJFantLvDO6/Muq0y0ijgazmp+GY09jvD8C7YJN8PM0CiGE5Hnw8
         z8gODDLlGBmrhi6zjy2HsryCksWt4boIXw6YoCVyh3hVOeGxk3fcmmaPzxu41H26tUL+
         tU9gjCqR4s8wvBjO+6EjX3Q5HY+RnVZ9t9UUpXj89dqwfMWqMMJn7Cnu/QMs7fU7ncj4
         /xbzPJTrp4eS5VcjmYyysUEIR+5+F+tsSmQNOFNkaAfT7PtI2xsjYzRWXpDXKEoCA75f
         mVXQ==
X-Gm-Message-State: AOAM5324ZFDJyedUgaIU6qTVDoCKLUDQfIvPWygzbm1qZHDZf+HOZ24s
        nZP0E8OPTiB+XdlwlFIE/bw=
X-Google-Smtp-Source: ABdhPJynvjKI0d2lDqJn5y4sow5U1e54dlStE0kR0Adpyi/fILq+8Jlix427Z/ZTMxCQjW/Zx9DCyg==
X-Received: by 2002:aca:3986:: with SMTP id g128mr20513334oia.126.1620801919273;
        Tue, 11 May 2021 23:45:19 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 186sm3745695oof.14.2021.05.11.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:45:18 -0700 (PDT)
Date:   Wed, 12 May 2021 01:45:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de
Message-ID: <609b797a818bb_6d897208ce@natae.notmuch>
In-Reply-To: <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com>
Subject: Re: [PATCH v2] Writing down mail list etiquette.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> Let's say that we had consented that my patch series was deemed ready at
> v5 version. From the paragraph above, I interpreted it as "now my series
> was consented ready, I need to send v6 to Junio (current Git maintainer)".
> In practice, the maintainer could instead merged v5 (without having me to
> send v6 [final]), because v5 is merge-ready in absence of maintainer's
> email address in either To: or Cc:.

Yes and no.

Consensus, mearge-ready status, and merged, are three very diffent
concepts. Generally they are one-and-the-same, but not always.

 1. A patch can have consensus, and yet Junio doesn't merge it
 2. A patch may not have consensus, and yet Junio merges it
 3. A patch may be merge-ready, no consensus, and yet merged
 4. A patch may be merge-ready, no consensus, and unmerged
 ...

I'm not going through every combination... You get the point.


Generally you don't need to worry about this, that's Junio's job. If
your patch is ready, Junio will merge it... But not always.

So no, you don't need to send v6, Junio will pick v5. If he doesn't,
it's most likely because it slipped through the cracks, and you can see
that in the next "What's cooking in git.git".

If you don't see your merge-ready patch series in "what's cooking", then
by all means send it again as v6, or reply to the "what's cooking" or
something. But generally there's no point in sending a v6 identical to a
v5.

Just poke Junio.

> Oh yeah, should mailing list's address be also in To:/Cc: when sending
> merge-ready patch series?

IMO the maxim should be: if it's relevant to git, send it to to the git
mailing list... *Always*... Don't ever hesitate.

But if you already sent a v5 that is is merge-ready, there's no need
to send an identical v6.


All these suggestions are of course based on my own experience. Others
might have different experiences.

Cheers.

-- 
Felipe Contreras
