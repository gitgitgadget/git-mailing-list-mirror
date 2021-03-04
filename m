Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DDC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728E0601FA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCDDD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhCDDDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 22:03:38 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32476C061756
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 19:02:52 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o1so14964066qta.13
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 19:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=55Pn89MARxdF/UwPkrVyYNV8wZGD+/zMU8Tod1tYMLw=;
        b=AEIhbk+C/lVg/Vp4d4qDbQH2QOExNMRudSF8ATE65feYiJLfqpJfMTVn5Ir6a6qp1H
         7JXXiztNMWUE23FAtLUlnN00uRdW8oTf1nVzML0iB1heFGOzljsmDvLW6J/N1vDSTpib
         gn+XLMIuWGCKRsMSarwhn96wvOCZfC8O4ECH9BT4x45jyLXdjw3xHlBFHzBZQ7Lmx1U2
         mOYEkXEPSr34OgdRbasTVrIyZ5ZH+YFIUTLaD5Hczl/t5POys+iHFAihTxYRHI7Ka71Y
         1IPBMbBPO3YWRk7m7ZJAc+hK5xiCQPnjcH6vuzkwpvZVWr5f/arE7rKuL0I811LZwis1
         6JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=55Pn89MARxdF/UwPkrVyYNV8wZGD+/zMU8Tod1tYMLw=;
        b=UPlwdRXGVgBDKHCT9vPPelF3p9AYsk7e4M5ExUYjnJTNMMatNIkXFM1uNQQ9adGdXk
         uetJjc9wogqMr+g0wYb+qHXXH7Uz/UVOemG8/zlXo6vGplXvqw4Rnjj75+DJWL14n076
         qltVoh6lXhKVqii2vGOwbmwIRe1ALUbE/jbiHbPKi3gAqhdvoh4PKlNbqVXvdIoWJkPD
         mgDXPP85M5xqJEESw27QFlazOl8nM07QCofc7Zf+v4PGv2dE0IqI/2F6rnXX3+5PpVMg
         QjxmIOfAWOsDIa8h2FpkuUKAWPen0IDrr5g6LkwhFWCg+5fZZMqEG6C/JFmtWu7VjrQs
         PvBA==
X-Gm-Message-State: AOAM5323kwSJ6u7RZ5sawmQpJdUFqhdOgWAe6oyt6107FGjJHyjh55qv
        bJTbuqrDmvW6TWb/+DtZCmBEnYTYx9jPeRDn
X-Google-Smtp-Source: ABdhPJzaBrjTMSRQqeN/RJ1axcAdiNyqj0zdsFU41Byr2Y//7Oqtl7dgF2krTM93EArtB1UkoLZ6uA==
X-Received: by 2002:ac8:47c2:: with SMTP id d2mr2343817qtr.348.1614826971467;
        Wed, 03 Mar 2021 19:02:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:661d:484a:c652:586b])
        by smtp.gmail.com with ESMTPSA id z1sm17038185qtu.83.2021.03.03.19.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:02:50 -0800 (PST)
Date:   Wed, 3 Mar 2021 22:02:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 04/15] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YEBN1ejeG3mBCnA+@nand.local>
References: <YD6Ly6EIcz4PT6uB@nand.local>
 <20210304015444.1801419-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304015444.1801419-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 03, 2021 at 05:54:44PM -0800, Jonathan Tan wrote:
> > On Mon, Mar 01, 2021 at 08:06:25PM -0800, Jonathan Tan wrote:
> > > > +static char const * const builtin_multi_pack_index_write_usage[] = {
> > > >  #define BUILTIN_MIDX_WRITE_USAGE \
> > > >  	N_("git multi-pack-index [<options>] write")
> > > > +	BUILTIN_MIDX_WRITE_USAGE,
> > > > +	NULL
> > > > +};
> > >
> > > I think this way of writing is vulnerable to confusing errors if a
> > > missing or extra backslash happens, so I would prefer the #define to be
> > > outside the variable declaration.
> >
> > Yeah, I can't say that I disagree with you. Of course, having the
> > #define's outside of the declaration makes the whole thing a little more
> > verbose, which isn't a huge deal.
>
> I think it's the same verbosity - you just need to move the lines?

Yeah, you're right. I'm being too subjective, and I don't really feel
strongly, either.

>
> > But I was mirroring what Ævar was doing in the sub-thread he started at:
> >
> >     https://public-inbox.org/git/20210215184118.11306-1-avarab@gmail.com/
> >
> > Unless you feel strongly, I think that what we have isn't so bad here.
>
> Yeah I don't feel that strongly about it.

I'll take your suggestion, thanks.

Thanks,
Taylor
