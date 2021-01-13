Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8564DC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B112151B
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbhAMUOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbhAMUOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:14:01 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4788BC061795
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 12:13:21 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id v126so3773113qkd.11
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1JxQ2UJaOhrkc2T9yR9jJQFc9r600v4mtWsblEkb3ZM=;
        b=NxLlBiv5RvEX+4jpjuuz41d7HwhLaRPuv1Mi8SegEjJqIuRJqcdD5x426Z4ZhiOXuT
         sj/a5gifOd/LgcyC8d/1Xun8oZEErM9L3Tu8Nr6TZs9B7En7avxfFv623jj/ECYRfuZB
         JcUue6u8Ohtdar7LJ2A+ewB7wD+SX9rDguUfZsvC0+vQnX2gxca8eqy94BcQYl2vW26N
         zP3DdXuxo7CRtSPT4DBvKnnJexh7WWLcBYgDaosrfY3XHeTJNh3WtXS4U2MYAYqdWTtG
         fEjfpXBBfZlJttXwpBV3okUqEKtjIxsAEH4mku4eRCUb0PYeaCh80BvlqqDtafGxkGKZ
         uvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1JxQ2UJaOhrkc2T9yR9jJQFc9r600v4mtWsblEkb3ZM=;
        b=OVNCi7vDWHXjJdIsXyzRbjQXHtMpjNpfcAo0JTuKvvqna9baOO4k69gr+mrqkfpLOt
         wWtHWlsKdCusjozxXU55VXbcuVyOIc4S3set7PNpW4nGNWgHn+8qBqrvHtSnNaWJAgss
         6Oaqfu5YNVDcFMMbHA27srfbMAxgqE6BpmkrPfFxpIxp7Ngjz7f6At6ZX16KmcYh2dr5
         PCuvUNOxDjtqcZyf7Rqapiphe/I9Zscs0QYX9Oe/ZU1LIcwxXu95qEfvwUHvxmIp2dL/
         g/WRWOv5ies02QPjA/xWAL6Oxa/4PmyefElXBXtNT54OebAKV+wrWS8fILJs4CtU4uy/
         1OcQ==
X-Gm-Message-State: AOAM5329SaHD0Qp20gLIL2U0VUXnhIbOdqLkhMeGXh3ou72qleabZIuZ
        V3aFf6TP1r7QVT54ISoy6oMw/A==
X-Google-Smtp-Source: ABdhPJyyMmh7KsUnSN0QYs5yYpNN/uMppryKVn2QHyj6bAV27LGaJp4PtIbc+wd+HMDFquPJ00jSpA==
X-Received: by 2002:ae9:de45:: with SMTP id s66mr3848159qkf.197.1610568800540;
        Wed, 13 Jan 2021 12:13:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id w127sm1659451qkb.133.2021.01.13.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:13:19 -0800 (PST)
Date:   Wed, 13 Jan 2021 15:13:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/9UXrCzihwa+ivu@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
 <X/5ER+ml/MhDjROA@nand.local>
 <xmqqft35ziog.fsf@gitster.c.googlers.com>
 <X/5nsw6uqKDCHGql@nand.local>
 <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
 <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
 <X/8THO3ck3bjJH+K@nand.local>
 <xmqqft34y53j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft34y53j.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:06:08PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But I tend to agree with Peff that (in this case since a clear
> > deliniation already exists) it may save us time to just send two
> > separate series from the get-go.
>
> As long as the two serieses are marked as such clearly, not just in
> the initial round but in all subsequent rounds, it is OK.  But in an
> unproven initial round, you may regret having to move a patch across
> topics, from the bottom one to the top one or vice versa, instead of
> just reordering inside a single topic.

Sounds good. Like I said, the last thing I want to do is create undue
burden on your or anybody else when queuing or reviewing these topics.

So, I'll try to err on the side of stating the dependency between topics
too often rather than not often enough. Hopefully the first ~20 patches
are boring enough that they will make their way to master soon enough
and we don't have to worry about it.

Ordinarily, I would have held off on the second series until more the
first one had graduated, but I felt that the pure refactorings didn't
make much sense on their own without the new file-based backend to
motivate them.

Thanks,
Taylor
