Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D04C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKJCUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKJCUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:20:31 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC361FCE2
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:20:30 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d3so401973ils.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xn/CDGK6FGCur2WNhSElIhvaKNuSzSzWvcT9i5KMcXo=;
        b=eM2DSAnDVNS88H+B8adeuDnsJ7xvIqIM/yADfccIM2OyBz2/PnkWYX/X1JrRMBYkia
         ENXW8WfkLkx2MkgajsKGzUKOx4MQOaUhteQeMUuCTPVihVqH5l+oVNYes7cyv9ifzR3o
         bVRmVf0cdjFSEuD+7efgPd+d/iNZwSBQ9kyB/bsXKwihJXuNB4eqN6SRpwUdhhKPn3Om
         0NqOruEBUHei4KJiU5cUloZ872sGLrrVaXyCoe7AKIB9wM9aVv9xTrAso7nrQcKBfmmI
         Iu/595DP20p+9jTjlQwl8Fc22WkX0NKJuuY5XKnDWvT5J/MYd+8YnCJBixCNP5a9XXC3
         gjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn/CDGK6FGCur2WNhSElIhvaKNuSzSzWvcT9i5KMcXo=;
        b=pfySma4GEmYEkxyor2+CUxs60Com8icyQ2mx7w2cRU4hyPgpA9VDFt3Sevus6ypevg
         gwzFN0jCzFt129JmnCpwGCCInknPBcgz9bWp91R8oB7snj1w2Px/41aNFROP1iBRW18O
         2/3rhGdz1gfUNT9AyzX0/zKrxYFty2UQ7RKDC/OORoGaOrn/jcHtN94tShZ77bw9GYgA
         Ehy0HGuv88k9Ujn+TVpb2EPEFS1NIB10M3FnOPSdfGGYHShbMoul4pdjZ3mFuQs/OV6m
         PD1USaNhxT1MabWHNO1vrN3s4mZvdIKxB4aeNTFgbwY79uhizlOc8Jc52njiLtuH41ja
         APxQ==
X-Gm-Message-State: ACrzQf3qJFjYucz38vuoL2uI6+FRgxm8g8cwJ8hOz9k2YIUju3+NoUGa
        mozZUdUttgsxq4sPAnN09+S2vg==
X-Google-Smtp-Source: AMsMyM5wTei6UehujB+5C9PmddHQc0FaFhhAnrIY0XbWVO8mm7bjTxl6pHnjHVmAJhbF0jIoczhJDg==
X-Received: by 2002:a05:6e02:e0d:b0:300:f436:d467 with SMTP id a13-20020a056e020e0d00b00300f436d467mr13978898ilk.46.1668046829858;
        Wed, 09 Nov 2022 18:20:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o25-20020a6b5a19000000b006ca9e36fec8sm5831710iob.54.2022.11.09.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:20:29 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:20:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
Message-ID: <Y2xf7HbAdqXOmgR3@nand.local>
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
 <Y2wwfQWrs+KYpWNv@nand.local>
 <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 12:18:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Nov 09 2022, Taylor Blau wrote:
>
> > Hi Ramsay,
> >
> > On Wed, Nov 09, 2022 at 10:46:05PM +0000, Ramsay Jones wrote:
> >> Commit 1c97a5043f (Makefile: define "TEST_{PROGRAM,OBJS}" variables
> >> earlier, 2022-10-31) breaks the cygwin build, like so:
> >
> > It seems reasonable to me, and I'd like to pick it up rather quickly (on
> > top of Ævar's branch), especially if this is going to break things
> > downstream in Git for Windows.
> >
> > Ævar: this sort of change is a little tricky to review without more diff
> > context ;-). Do you have any objections to me slotting this on top of
> > your branch?
>
> Yes, I've reviewed this, sorry about missing this edge case. This fix &
> analysis looks solid to me (it's still just in "seen", right?)

Yes, 'ab/remove--super-prefix' is only in seen for now. So that we don't
break the Cygwin build in the middle of history, could you send a reroll
of that topic that incorporates this patch squashed into the right
location so that each step builds independently?

Thanks,
Taylor
