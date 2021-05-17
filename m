Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA83EC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D128660FEB
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhEQUTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 16:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbhEQUS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 16:18:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03406C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:17:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so285080pjb.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zpv100ol2lqfS3sAwG13vdcxhBDGayLgGOXaJokNVZU=;
        b=pKs6pVPgLREPeNEDQgXXYkABoFBsP3NXtTa1q12p87pN7t8l5wWZiylWKippSvboU8
         Vj72pfosLFskizIpOBsuHkgEW5KC8F2WTi6zOCWwWLk1E1lzVhlzkTkHMB1t8bTYB8rB
         qKCn6BeRJGNJE806QdOWHx1Ucy2tbBEujX22bXeS9Rzzz25S84v4wynVQ8K2GW70i5iq
         P84EeTzE9I7ugoxohiYSBL3BpqBM/40ahdFLsP5iLFeKiK4BMoBrwxpGHp0IhtK6d5o4
         SqlNhEVDKXDnF9n4PGKJFsd6q23RKXN1+7P1JaZo0AvkDEtAWaA7f6XLgd7BjgpvNC4H
         WSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zpv100ol2lqfS3sAwG13vdcxhBDGayLgGOXaJokNVZU=;
        b=QBXOqaDF8D6KGTh1rJ3vKgg7KPRTBXJNbmwZK+RvMkE9tvTNT9czNWaHTpJl4wpEBg
         B5N3wpU8HYqFgybLZEKgx3aH1hNc3CXh22B7MN3BI9dVZdDc2X+CqzNIDdpT+djA0ZRP
         ySjsAz/kCZ9B0D3ty4HgcbeGJ1H/jQ60AhbKxJgk0Qj09WjfmJFoht+7/h0iykh8OmBm
         r5a7RD12Q1y0FKyIeCQ7PXcNo7vZqd1zbOCWPrqfW0QoBHYI4HXj9oqy+N9HPRVW3zzv
         EXFFkRkUO8CJkjXh5NMuDBgbfQg+PEw4/ZFMGl3DVfFNgnh2PplYSyewLN6PUXRnA3xd
         UZsw==
X-Gm-Message-State: AOAM533jigNbm7HHxWqX694zzREotHDdkzLs1SjlqElaAdCXTvseHMPx
        9DfSMCI0ELLl2Eyx4URfm5go1w==
X-Google-Smtp-Source: ABdhPJxvbkPZ61o/5dR0BkFOAXJYHIfCuOXDS1/f+Hp8z5w2rSY5vSQ3pZZeIbRgheTI2D0IHOsBNg==
X-Received: by 2002:a17:902:7488:b029:ef:838a:3071 with SMTP id h8-20020a1709027488b02900ef838a3071mr228599pll.61.1621282662417;
        Mon, 17 May 2021 13:17:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:ed38:7870:f69f:9780])
        by smtp.gmail.com with ESMTPSA id n8sm10357903pff.167.2021.05.17.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:17:41 -0700 (PDT)
Date:   Mon, 17 May 2021 13:17:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
Message-ID: <YKLPYd/AYZFUzs57@google.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com>
 <87im3qu4gy.fsf@evledraar.gmail.com>
 <YJ70g0Nd1W1f6BIx@google.com>
 <xmqqo8db72zu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8db72zu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 16, 2021 at 12:48:37PM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > On Mon, May 10, 2021 at 02:29:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> >> We already have the nest-level as part of the SID, so isn't it
> >> sufficient (and portable) at the top-level to log what isatty says + set
> >> the initial SID "root" in the IDE (which presumably knows about git).
> >
> > If you already know all the IDEs and scripts which invoke Git, sure, you
> > could set the SID root - we do this with 'repo' tool today. But actually
> > we want this because we aren't sure exactly who at Google is invoking
> > Git in their tooling, how, why, etc. - this logline was supposed to help
> > with that. Chicken, egg, etc.
> 
> I agreed with Æver's suggestion exectly because I failed to read the
> above motivation from the patch.  If you are trying to find out who
> called, then you'd need to do the "find the parent process" dance
> when your parent did not give you their SID to append your ident to.
> 
> Perhaps it was obvious to the author of the patch, but it was
> unclear from the point of view of readers.  Perhaps the first
> paragraph of the proposed message wants a bit of rephrasing.  "we
> aren't sure exactly ... how, why, etc." part of the above really
> helped.
> 
> Thanks.

Thanks for the feedback. I was vacationing last week but should be
sending a rework today or tomorrow, will see if I can shore up the
commit-msg as well as the portability stuff Jeff H raised.

 - Emily
