Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FACC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiHVSIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiHVSIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:08:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B99C56
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:08:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so8540406qtu.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=otlyD8DU6ia0vyGrhtY+k4EwhMcyj8CB+TN4DiLewCY=;
        b=r3vikR82mWcQSFtXWMIKYXxZI9LULWKL1gyUmlVx6zNDun+8ZFa9Lzsde0xmIo+1fC
         k00szG+EFTUqGYoZYxwnCfVBNagQIugK//GeFdlbLGUJnBAgv3T9OZxmGXBz7hQXV2q7
         cVDaK3vM04y3NiKKoCXS9sBU4Lg9tSNI5CDUS2BLAHgHY2NPh17h4l2ja4pvSHqvo+Z/
         ABkyjMhVnomulf56KLSiXmDd0UQXcVxfTZSBQLkufgMtU1/eEpveKkL8B5xMzsAmcGay
         1F4mGqk9+TJ0m/CUpOk/aCGb5joEP4NFot+Jfx4mEcT1zCbwWxyjahP1kT9RInhPbU9e
         8JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=otlyD8DU6ia0vyGrhtY+k4EwhMcyj8CB+TN4DiLewCY=;
        b=QxhZWhcDWQurWH8A3gf47N7cdvRnEH0qbLdrx+Wv/kPFzVf0dlv207T6C7fuGgQA4h
         sn9yMS6DzY3YOxfH99ZZE48V/1ah99DbEONHW/ds11t1U9cHX3pR3QkINxTVpGSfRxx9
         YEi2cJS9aVqRXbC/sjq7hppm8wEB3cxFhF/ssMOxj9w/lqHRF0SFjZcwq2TenCuEjszH
         /xzqKLTcKOYlrM6zflyQlI9xCRZA5W1kWIwZkViWMbPcRAKoOyAxH+atSdWDeIFpIZu2
         xJ9+09akLrUyVaQl6dnNKyCpe+gdQgWepLG6S9/GtvCnvVGyxPSH8cSejFq/HpQWi3Ru
         40fA==
X-Gm-Message-State: ACgBeo30aOhhPGhQU7GAqu2Lyk3psL1lgx8sSeN8sEa8CuqwUchlQ8pA
        swjqhLnf47fs50T1j7/G6ifROA==
X-Google-Smtp-Source: AA6agR5SYdt42DqQlpvCzFVtsQcpHZI495n7EbYmBpzObfUN4Xy6l0cVQ6O3H7NEqoHu2s0umsUn8Q==
X-Received: by 2002:ac8:7d90:0:b0:344:ac48:af55 with SMTP id c16-20020ac87d90000000b00344ac48af55mr9519105qtd.106.1661191699625;
        Mon, 22 Aug 2022 11:08:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006bb49cfe147sm11441367qkp.84.2022.08.22.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:08:19 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:08:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        jonathantanmy@google.com,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 6/6] midx.c: include preferred pack correctly with
 existing MIDX
Message-ID: <YwPGEvf210HyLnLy@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
 <CAPOJW5zmbQ966KXjaEvxk-oHu01BsxwszUTu3et4SYGFCAegCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5zmbQ966KXjaEvxk-oHu01BsxwszUTu3et4SYGFCAegCA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2022 at 12:10:42AM +0530, Abhradeep Chakraborty wrote:
> On Sat, Aug 20, 2022 at 3:00 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > +               if (-1 < preferred_pack && preferred_pack < start_pack)
> > +                       midx_fanout_add_pack_fanout(&fanout, info,
> > +                                                   preferred_pack, 1,
> > +                                                   cur_fanout);
> > +
>
> All the other changes make sense to me but I have a question about
> this particular change. Instead of adding all the preferred objects
> again (but in this case these are being added from preferred pack) in
> `fanout->entries`, will it be better if we call
> `midx_fanout_add_pack_fanout()` function from
> `midx_fanout_add_midx_fanout()` when above conditions are met?
> Something like this -
>
>     static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
>                                         struct multi_pack_index *m,
>                                         struct pack_info *info,
>                                         uint32_t cur_pack,
>                                         int preferred,
>                                         uint32_t cur_fanout)
>     {
>      ...
>           if (cur_fanout)
>                 start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
>           end = ntohl(m->chunk_oid_fanout[cur_fanout]);
>           if (preferred) {
>                 midx_fanout_add_pack_fanout(&fanout, info, cur_pack,
>
> preferred, cur_fanout);
>                 return;
>           }
>
>           for (.....) {
>           ........
>     }

A slightly simpler approach might be to see that the pack_midx_entry
structure we get back from calling nth_midxed_pack_midx_entry() contains
the pack from which each object is represented. So if we see one that
collides with the preferred pack, then we can just skip it, since we
know they'll be handled separately down below.

I'll add another patch on top which makes that optimization.

Thanks,
Taylor
