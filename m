Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD4C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7694361002
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFMHTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:19:21 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:45908 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMHTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:19:21 -0400
Received: by mail-ej1-f51.google.com with SMTP id k7so11074793ejv.12
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ihu9YUXKwsYe2vyCQhniU0wopGvWxw0/GPCa55YK5vw=;
        b=gXHU4xcPJQbJ7qLKyim2yoL7j/xQzy52RcLIKCQuyEuQ1MdAE9h7bbJUE5vFCgddRo
         L89Leh8H2BLL5yeKRkj1PrQs1RtJ9i9JYqYqMnJQLx6BSOKyABdw8hVLFT6bxoFQ3VL5
         Qw/JvHhdpo4jeXz8iDd4Gx6YC/cGXd8qUs6JPcjp93pKce4K/FYEIiIxvANU3wi+44DQ
         7madDSoqM7lXJ5rSTtGSTzs0kHNspSRcJWm7ItlxDgcwUhJxiuHrja9IzB4VZ1lIftkR
         1CoD70flHY4zONlwCdswHFNukHa4YW5v54+JLb56aP+wkwBrqbnYLbN2ZhG61jeyjSEc
         ODHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ihu9YUXKwsYe2vyCQhniU0wopGvWxw0/GPCa55YK5vw=;
        b=LwGg3DMCV9ep25n76PO/9S/dbjZjBTl3Aj3jikZK4R+Eyt5rXSzfDfsWIP/UZvx+kp
         o3+lPiOlCNSCl0sd9IQijxiAKFu6V5NJBrATh6plQwoUh5F7yXuiLLEt5gFcWhSD+8Gq
         IrrzGxh7kxOtKQiir3vXmQ3mgG5uWRfzwsx2MdgoPNJrRHm9wUcykTuptlQuFd7PKKuR
         MKqpQl+X9i1bHB+MnxzcI5EGiVhkF19YYzBaHhXIet/vdg/toe1Ov1OUXmDTABOBXSu2
         2Vtqd4Now5B6668pTSVVDmjrAEXRxm6H6e+ePnBGzMuUHYoDl3yZG2Od87/rx1qMSs50
         DZ+Q==
X-Gm-Message-State: AOAM533D3PsL/2OzJ7q9BGum0BROuh19jZHXCR8it3FbU3uME1kzEupF
        3VDtHwiLIxmN5mwZCUdm2yI=
X-Google-Smtp-Source: ABdhPJyhgupctbrFzm1euTggkGguU0DvXZWG+VLJ2i4Cai8M/Mp38rnsfBBVMWA9s2Gx+iyq12fcFw==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr10323641ejz.382.1623568567575;
        Sun, 13 Jun 2021 00:16:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j22sm4141282eje.123.2021.06.13.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:16:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Avoid gender pronouns
Date:   Sun, 13 Jun 2021 09:15:01 +0200
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210611202819.47077-1-felipe.contreras@gmail.com>
Message-ID: <87k0my1bgp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 11 2021, Felipe Contreras wrote:

> The latest solution looking for a problem [1] is to use the actively
> debated among linguists singular "they" [2].
>
> Leaving aside the linguistic intricacies that not all singular "they" are
> equal [3], and the overwhelming sentiment that these kinds of political
> discussions don't provide value for this community [4], the "issue" can
> be easily solved by simply using different wording.
>
>   - The reviewer herself
>   + The reviewers themselves
>
> Problem solved.
>
> Cheers.
>
> [1] https://lore.kernel.org/git/pull.975.git.1623085069.gitgitgadget@gmail.com/
> [2] https://www.theatlantic.com/culture/archive/2013/01/singular-their-affront-good-writing/319329/
> [3] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they
> [4] https://lore.kernel.org/git/87wnrooa17.fsf@evledraar.gmail.com/
>
> Felipe Contreras (2):
>   doc: avoid using the gender of other people
>   comments: avoid using the gender of our users

This looks good to me, especially the reduction in verbosity in hunks
like:
	
	- * parameters to the callback, `strbuf_expand()` passes a context pointer,
	- * which can be used by the programmer of the callback as she sees fit.
	+ * parameters to the callback, `strbuf_expand()` passes a context
	+ * pointer with any kind of data.

The comment gives you the same information, but now it takes a shorter
time to read it.
