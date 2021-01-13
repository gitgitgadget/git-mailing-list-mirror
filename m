Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D371C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 03:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412E422CAF
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 03:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbhAMDYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 22:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbhAMDYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 22:24:15 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A22CC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 19:23:35 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h13so229090qvo.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 19:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=baByDr1WSZfVbOseGbJh8QEIoswKPl4k7Ov0VRDOwYI=;
        b=hxgFT/flagAsVs0uO39GpiLkNpW1xBwKSX+GMdIH7uC/WfTWT4mc38ACeBzdPFpiB6
         lVAoXETddKGxPUgE5eJZna1uuQgWpq2bRm86UozkFyUMoi5EbOzj30xiB3vigeg84zEq
         IATJbnryw4HaALr5ZWBmXEN1hYUDlWJSICKuQovHS61sK4aH5QQBHaeT34lN3OGG4ih6
         o/4Z5xp0L0+ytq+b0DmvPhpLX8MM6JXMn3Y1wtHFTq0xQMzSG2Wyz7BO8NDvndz3RwoL
         2el62F/7H2Z2GP54tTIYco1G8lWJJpCCdZqKMq5TZUDMYR3G4NH0tMyawpIpjMtYCPWx
         2g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=baByDr1WSZfVbOseGbJh8QEIoswKPl4k7Ov0VRDOwYI=;
        b=DQQLbyaQnt5DGCaLU9b4ZDJKSAml+6SrNOvCa8Rtm+5Mtu23tB+VRbdD+B5jF+TP77
         eYfnwELK2IlxA9TIO2JnCDSRwiaeQNZWNoZuMPRIU7iNeoisT7VyGu6A4N4bjxNSmGDF
         Ik+9jjMJ26LqoJiklkaBjjSELx2jhqWlODmHdFG/Wt1ubGepEYq45dd0qANtoeg74Toq
         jZZ4s8hJwVHT3bw/aHxtfsKZq0IgzWj62/Up6C1JlEqBf9SiI2kIkqeqqz7H6K13a7Ni
         kDxfjOFVLs4PW5k8AJD2SOaC2dDmIANvoRnVWbG36nSA1cNRrdo4LwcdT+7KfXvo2n/t
         EqwA==
X-Gm-Message-State: AOAM530N82rvQGTqdoimQ/waIL55BiT3vFtHtVmPjCtmnGSphISVNmsX
        0vKJ1Acgszv/Fyho45Ct4iSbcg==
X-Google-Smtp-Source: ABdhPJwJDFRpjCRJrL5tbBDeNV9g90ZMhjYStgZRnsdsqrQtfNGbX9aUtH5WqmSNqGIcRhhi1zHpHw==
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr284706qvt.28.1610508214680;
        Tue, 12 Jan 2021 19:23:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id p58sm345904qte.38.2021.01.12.19.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:23:33 -0800 (PST)
Date:   Tue, 12 Jan 2021 22:23:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/5nsw6uqKDCHGql@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
 <X/5ER+ml/MhDjROA@nand.local>
 <xmqqft35ziog.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft35ziog.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 06:15:11PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Did you want to queue these two topics separately?
>
> Unless it is a reasonable amount of certainty that the bottom topic
> will not have to be rerolled, I'd rather not to have separate topics
> on top of each other.

Hmm. I certainly do not want to create any tedious work for you, but I
do think that we're in a situation where the bottom topic is stable and
the interesting discussion will happen in the newer topic.

> It is tedious and error prone, having to rebase the old iteration of
> the top topic on top when a new iteration of the bottom topic comes
> out.  I'd rather see that the top one get rerolled whenever the
> bottom one gets rerolled to make life simpler.

Indeed, my local v2 of the bottom topic requires the top topic to be
rebased onto it, and so I'll plan to send a v2 of each tomorrow morning.

> Even in a single topic, I would encourage people to put thet
> foundational and preparatory work early so that we can make them
> solidify before review really gets to later parts of the series.
>
> And when a series is structured like so, it is perfectly fine to say
> something like:
>
>     Here is a new iteration of the last 7 patches---the early 13
>     patches are the same as the previous round, so reset the topic
>     to bb6414ab (packfile: prepare for the existence of '*.rev'
>     files, 2021-01-08) and then apply these 7.
>
> if you do not want to send all patches in a nontrivial series when
> it gets updated.

I am happy to do it this way if you would prefer. If so, you may want to
rename this topic while queuing, since it is not just about a new
revindex API, but rather about introducing the on-disk format. (I would
suggest tb/on-disk-revindex, if you were looking for alternate names).

If you agree that the bottom topic is stable, I'd prefer to send the top
one separately. Otherwise, I can send both together. Let me know.

> Thanks.

Thanks,
Taylor
