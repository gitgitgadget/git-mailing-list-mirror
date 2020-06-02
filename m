Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C583C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FF62072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gerczQpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFBETw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBETw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:19:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EF1C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:19:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a25so4180411ejg.5
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSrGY9fDu/Hs46fH+Han5VloL99vNYakiUaWZmBrkq0=;
        b=gerczQpyYpmueXpGiHUKkDWYhmyI16yrcdkl8yx0Vo2EPNYTvjKk5qVgcgxFqZTBwr
         XlBZq2T+zsjQgsUc0/7ChvmxXtbcJEv6gQH5ErOYcCRtngniBURWjoh9U73it6+N0MaA
         1WEZJzjmyaoM3IW70PJV2oJDvjrvSsQj0rToFwv8ysgz0GHXQiDL26o4gAgDUlcxGyti
         v/VIqPPMg+RFszVRR8kqE/IeUVPcZsjKMHnjnY/sRgynE70HXssrepm5r0g2rvcBU4OD
         orcaoKYcEn6b0TaeCUim/16js6kzLYzoso952PSX54M/4dN/km9MZmcXsAjfNtwryXcw
         bEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSrGY9fDu/Hs46fH+Han5VloL99vNYakiUaWZmBrkq0=;
        b=hOde3JTzngtVxonkjouGdhpkWTNQuoc0tq8A2qeIjcaefQP6kR6YUFlFh2ewxf+Mb9
         xyZPMjFcyzF3hEBRwt9P8iJuP/K4nP+dAhwsQ1SOmlkU4W7eROhWzemED/XWuJmh9X1r
         rS/UkYTo3lLiysVTtDtwUyGhZCz3aJsq3I3reBehuidx/xEunzETUFLPGYo6XF6688KF
         +vDsNN/9RFJ55JZsgDQ5mVVzRFbCtWK6rBsSrXkOPdpB1ZlSkA1h7zhKiXnXFLN9J5xt
         vp6LCIcXj/rJ+BrBP9aomA0O68BMu/gzO+hzxSUCydKKlJYkqiQHa8IfcRFbz2YuPoU1
         EVhA==
X-Gm-Message-State: AOAM531iPQRAnJz2MPYMhzuIw6jZRIuGHQcF24S4IWfpQMBLZmMMDLQQ
        i4lQaKDFvuwlg3rZSiLKYP4/UyPvW081Y6LQG5E=
X-Google-Smtp-Source: ABdhPJzU7zVCOQNIu8Zd6vn3QZIOvs3NzvqlWTK8tv8JOhzLu0DZnHb7gmWLmgxwCXwT9wOC6IZzrftVrvGA1kEJKmw=
X-Received: by 2002:a17:906:4406:: with SMTP id x6mr21852127ejo.160.1591071590116;
 Mon, 01 Jun 2020 21:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org> <20200527164742.23067-3-chriscool@tuxfamily.org>
 <20200527180611.GA4020820@coredump.intra.peff.net>
In-Reply-To: <20200527180611.GA4020820@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 2 Jun 2020 06:19:39 +0200
Message-ID: <CAP8UFD2mPb+kzsuM=X-KJTaQmMP0uMnRSTkCYSHj=ixE0xk5fA@mail.gmail.com>
Subject: Re: [PATCH 02/12] upload-pack: move static vars to upload_pack_data
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 8:06 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, May 27, 2020 at 06:47:32PM +0200, Christian Couder wrote:

> > They are only used by protocol v0 code since protocol v2 assumes
> > certain baseline capabilities, but rolling them into
> > upload_pack_data and just letting v2 code ignore them as it does
> > now is more coherent and cleaner.
>
> Is it perhaps worth keeping these v0-only fields grouped together within
> the struct, along with a comment?

Ok, I will try to do that in part 2 and part 3.

> That way nobody has to repeat your
> research later into which ones are used and which ones are not.
>
> > -static unsigned int timeout;
>
> This was unsigned, but gets moved as...
>
> > @@ -83,18 +80,21 @@ struct upload_pack_data {
> >       timestamp_t deepen_since;
> >       int deepen_rev_list;
> >       int deepen_relative;
> > +     int timeout;
>
> ...a signed int.

Yeah, not sure what happened. Maybe I needed some coffee when I did that.

It's fixed in my current version.

Thanks,
Christian.
