Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4350DC43214
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED3461054
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbhIATKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbhIATJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 15:09:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2DC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 12:08:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z1so450772ioh.7
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKTRK2RfuKnxZMFQ8E+kmePgIuhBChEfrKf1mWFenNg=;
        b=CI1iEwgSW3LReJz63X9bpFi0smSKBgsQtsfIOCzOU5qPE3KhqXfCEp575ORhcpKM8F
         XmmS6rbSElcrSDe6VSM/IcOrQDCrX0Hnu10P4UNG/owD7x+EuVZc6TYufRWRu5fkIYzf
         vo3vDa9BSK4bTIzxuOx+Bnc/qYdJg0Sl8pSs2FR6NmG0aHbkmYVK+yC0pBPm3I8rgMjz
         re/hQuoxmQASxWTau/T3Wch7WpvldL96MELBQkQJEnDQAeM6+0TyPPNJ0A45+doV2Uog
         7w37i5JfxTHv7rR35vczbbelBmVRFaK/uIZKU4+SpNpcCG10RN/IzDpsUu0z0fUTC+sH
         fggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKTRK2RfuKnxZMFQ8E+kmePgIuhBChEfrKf1mWFenNg=;
        b=sxxhlDOaCaUrid81yQFQVIm08Jqe/AxGzPM3QubY/kDPMzuOAwn0cgzsGJjMmHlAwF
         2UELG1VK3Y+wpYfrPU9bmu1Yhtht4CR6LRVwHdknxWoUvPipSCDOUHN8D0JsC2yClnCN
         zyDsfXdqx0eQmvjeLNnld8fYvJwLTs9HvcTxu82hT35C2oNglYVNPvjXXsrtkV8ZcbYT
         4+1Dm0nw2KagxgeyzQ32TT9AsdzKenEIuguQknR55s/s5mQuCjcrTzmFfJZEDdr9QIgk
         1Bk0JRTLf/0vL+Av2IjJHWca+H9cA+TcSoVBBZPlJoNif5fc7f+Fz/EHpPiMHODj0vmG
         uBjw==
X-Gm-Message-State: AOAM531vegVNkS7I9HNigaoWEia2RbwBeds+8aBOH/yG2bVB6sixYvjq
        yqO8RoUbdWM76WkzRZl+J2htkw==
X-Google-Smtp-Source: ABdhPJwyJMFf6PAbCjAEAWtovZQMqp97svBZfPV+/DyhOLYKe2Q76PM5TyrGoMz+kY1VUFMYgNSEBQ==
X-Received: by 2002:a05:6602:3404:: with SMTP id n4mr899118ioz.45.1630523307632;
        Wed, 01 Sep 2021 12:08:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6sm210104ilb.59.2021.09.01.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:08:25 -0700 (PDT)
Date:   Wed, 1 Sep 2021 15:08:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YS/Pqc7lkMlnlBYR@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
 <xmqq5yvkqidc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yvkqidc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 11:07:59AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> >     +@@ Documentation/git-multi-pack-index.txt: OPTIONS
> >     + 	Use given directory for the location of Git objects. We check
> >     + 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
> >     + 	`<dir>/packs` for the pack-files to index.
> >     +++
> >     ++`<dir>` must be an alternate of the current repository.
>
> After replacing the previous round with this round and running "git
> diff @{1}" on the branch, I noticed this documentation update, but
> did't find any new code that tries to ensure that the requirement is
> met.  It's a bit curious omission.
>
> I think it is OK to allow running this command on <dir> and then add
> it as a new alternate (iow, the <dir> being an alternate is not a
> strict requirement for correct computation and writing of the midx,
> even though it may be a requirement for correct use of the resulting
> midx), so perhaps that is where the lack of validation comes from?

I wasn't sure whether to include it or not, since we technically will
still write a MIDX in that object directory (alternate or not), but we
won't load up an existing MIDX that is already there to reference. So
we'll get the same result, just slower.

I'm comfortable with saying what's written in the documentation, since
even though it happens to work today, we should leave ourselves open to
not supporting directories which aren't alternates.

But I'm equally OK if you would rather drop this hunk from the
documentation when staging.

Thanks,
Taylor
