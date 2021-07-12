Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283AC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ED460C3E
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhGLQ6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:58:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68AC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:55:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u15so6568409oiw.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9qkIYAfvuConPnMo13SNM6E4nd5qhvuphnzcD+p2wF0=;
        b=GuBB0MTm5NkGOAwJGncSzxwGx6UUKfLZ30rdrAOadSfpAfjCHXqXJu3d8fd0r3Fkie
         +j8/zqqRalL8Pj9K+nWxnV/9bJo4Tz77TXtAipevF1HuPdXJIuTvNqcJIMuYg2K0Lzbn
         FZG+hfDf+7UmZ70gsG9umr2ay7bSMr5eqT4oh3Y+9mept4I0fle2qKU94T/nJC11BU9k
         2+pUJKNkyJevCMbL2jejStudP+Wa5b9zZ/vSwTEvyaNuaK1v/dYFCVuLGZ70ye4Mpkf3
         OrzdW5Dcb9Mj29eJIpC15K0x9RAdxk1NR0ZgfMop+rGm1fm6e0axBdct7eOkRWyoUf3u
         Jpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9qkIYAfvuConPnMo13SNM6E4nd5qhvuphnzcD+p2wF0=;
        b=rxcS5bXrc0ebOHeye5Q7yz1uAZ4DzuaRJbMYH6Ef/rOUqdKq/d7I/DKsq3ViWgM+kb
         +e8qQx7IjSwPEnSxEqTx73Qke1TPFyW6MNuij6AnHkV82B7lb59pHecqug49th5otL7M
         tt4FlXg0xWq525Iyec6O2RSl5A0TRZPlVjxYSQa0sjf/HFpY+ab4S9sH6xG0CT9/TMoq
         lPvXHKMWI2Ic+5jPH0RoPjs+N5AdVTsBY3VajTU2CmnygBitJ7R8hkZ+Xu7/PQC5F5lZ
         OkGMZUwjx52KtDJ7hnwicxyg057LIIa5YhdhgAIQ5PUYg+MHMNvdAED3x5UUUoxUZg3V
         ejjw==
X-Gm-Message-State: AOAM531CVsOi1mEvqEdihJYt1yXwYSz9PI/XOnlQUaXvnmzWTBwsW/ki
        hbBQjm+0Q6j5Enq76lgQzFs=
X-Google-Smtp-Source: ABdhPJwpsXGaHJg8enaY3xBr2pL+/Yf2hSBbel+iBRZ/alYa7lOCKDB1jgJTWax3L+G6T7NKEZOYZA==
X-Received: by 2002:a05:6808:153:: with SMTP id h19mr11178360oie.8.1626108943145;
        Mon, 12 Jul 2021 09:55:43 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id w4sm3190482ote.33.2021.07.12.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:55:42 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:55:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60ec740d6c560_a4525208d3@natae.notmuch>
In-Reply-To: <87r1g3n5x3.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru>
 <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru>
 <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
 <871r85f39n.fsf@osv.gnss.ru>
 <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
 <87bl78eqv3.fsf@osv.gnss.ru>
 <AS8PR02MB730258D0643373CB476A18D39C159@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <87r1g3n5x3.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> "Kerry, Richard" <richard.kerry@atos.net> writes:

> > If I remember correctly, "branch" is used in Subversion and CVS only
> > for the creation of a branch. Likewise "tag" for creating a tag.
> > And I think they both use "update" to load the required
> > branch/tag/commit into the current working area.
> >
> > If git were to do that then I think we might get around some of this
> > confusion.
> >
> > In that case:
> > git branch = create a branch
> 
> Sorry, it's too late. I don't think we can actually do it.
> 
> > git tag = create a tag
> 
> Ditto. Too late.

It's never too late consider what would have been the correct UI.

Even if ultimately unachievable, exploring these ideas might give you
other ideas that are more achievable.

-- 
Felipe Contreras
