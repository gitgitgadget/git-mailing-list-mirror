Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7E31F461
	for <e@80x24.org>; Wed, 15 May 2019 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfEOS2R (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 14:28:17 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34518 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEOS2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 14:28:17 -0400
Received: by mail-qt1-f202.google.com with SMTP id o32so704138qtf.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=he1bo+zC+OknOSea9ViSvf/SH08RX4uKXcWgTjZBfjE=;
        b=Fkdyjr3awnkylcuaR71SKmULqguYsAUt2k5AnkS3Vjn1AEy0axDCAIQuKLYNMqg7Vh
         +EUob1/jYNUH9TYHSYW0aaeABuZ1yGmB2VNJm33mDKg0gbVeZDJ0CQqsm/sDH4d6yrzW
         EpAuZfOsnKV/8/F3wWYyruM+zCaq9vFjg6R+d6mn9Wiresy5EK+uMlzFgHxQfg/vSUPT
         Hnycw5BNZxnxhje4NtTy/D5XS828m6kz8cd5fvITQyuwKRpmce2NkF5l7yhvkQWpivjU
         oKUemn4Fpo4lGc4g1uzT9zg4NRLbzlAyoe2oZr9WrmE6Y9grcZ2SVFtY5sGslXsJJ/eW
         SxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=he1bo+zC+OknOSea9ViSvf/SH08RX4uKXcWgTjZBfjE=;
        b=dThkGz6fCVLrRpMg23Ee+u6QL7KG7DYZskX2ForS2Fd7t84L0Ymha+XPf5AW4H/sez
         I4ceK//EwOLG263TXBC5BoICIwLiX9bfQ3ifrtyc61w1Q6Hbl/ICcrO3XvqakS/sZZZM
         3oN9024dXYYWxeAdGrd51WKXwz/2DlG+KsCWxnicD17NcJPTOSKetTmEHJchNd5VGmZi
         Ztcai/NZXBLuphe3/6SuPKJD4ZPoDGu8Q38I18FnTeZMf6ny9+7KhD+5ssI3+lNiCYh/
         WI/3Kk1wqybvpcJnxws3mufPzABdFfz5DXk0nr3Us06bl+Vk/u8oemhhWRFRkoGJXVA6
         HKdw==
X-Gm-Message-State: APjAAAWKfU1EMEMSbda0mEeqqwiddT3UeGH3LSRHa+Nojotv3crIYAhl
        UpZNDKgUaZqIvl3U1xPeFt1cYUOdw3AWdTT9UjU4
X-Google-Smtp-Source: APXvYqxsEvcmCv27557zIlfCYtz1T0vaErb9Xmje9haoouilxiummH2NhisjFeZ5a0PSJFq7u3xZUHSDEKt+nT/I6Oio
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr34548160qkg.347.1557944896068;
 Wed, 15 May 2019 11:28:16 -0700 (PDT)
Date:   Wed, 15 May 2019 11:28:12 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905151040240.44@tvgsbejvaqbjf.bet>
Message-Id: <20190515182812.107420-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1905151040240.44@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > To resolve this, prefetch all missing REF_DELTA bases before attempting
> > to resolve them. This both ensures that all bases are attempted to be
> > fetched, and ensures that we make only one request per index-pack
> > invocation, and not one request per missing object.
> 
> Hmm. I wonder whether this can lead to *really* undesirable behavior, e.g.
> with deep delta chains. The client would possibly have to fetch the
> REF_DELTA object, but that would also be delivered in a thin pack with
> *another* REF_DELTA object, and the same over and over again, with plenty
> of round trips that kill performance really well.

When the client fetches the REF_DELTA base, it won't be a REF_DELTA
object itself because Git makes these fetches without any "have" lines,
so the server doesn't know anything to delta against. Admittedly, this
is just due how to we implemented it - if later we find a way to
optimize the lazy fetches by adding "have", then we'll have to revisit
this.

Quoting from the commit message:

> > (When fetching REF_DELTA bases, it is unlikely that
> > those are REF_DELTA themselves, because we do not send "have" when
> > making such fetches.)

I tried to address this point with this sentence in the commit message.
If you think that this should be addressed more clearly in the commit
message, let me know if you have any suggestions.

> Wouldn't it make more sense to introduce a new term like `promised`
> (instead of `have`)? Both client and server will have to know about this,
> and it would be a new capability, of course, but that way the server could
> know that it has to send the entire delta chain.
> 
> Of course, this would be quite a bit more involved than the current patch
> :-(

I think this can also be solved by omitting "thin-pack". We might want
to do this once we optimize the lazy fetches by adding "have".

Thanks for taking a look at this.
