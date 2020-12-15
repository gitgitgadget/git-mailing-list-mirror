Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC2C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869E122273
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgLOGfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLOGfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 01:35:43 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F8C06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:35:03 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h18so18345310otq.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=B+XC1zgRytDTwa/YaqvG/UYQSIsIveQUcQEZZoMLigI=;
        b=FEtHXihHzMrY7oE5CF7HbBm6J9hxXGn81MnW/V4NqxaGGcoRSuMCrGMOz4r76wZbYT
         /qQ2jagoBPViCRpV+auUs5ERiQLLQxKcn6yyHB9yKZG4tCIGRQ4iRmwPEirrQIM/a8AL
         jBu9b/Sx1YpGZO78JY76XWR8ooU/kASXDmOXWfrSp5jKULXS+rT3xJQvrct8woWFnYHp
         KqM6547HbNzqe2qEc9BvAoMF7mznJen9apQyPZHn9WckS+O7lWbjbWPS0JwjDxlqEozt
         7s96OlutTHXgDanEvEHand5tOEUnzUYB+IAoOSjaIwLtFKn9w/fP51djITzHGv1+YQik
         /yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=B+XC1zgRytDTwa/YaqvG/UYQSIsIveQUcQEZZoMLigI=;
        b=lH78npH5OWiZmyI/c9rY1uxSAhZjnv3OVWjhYOqqJaFd4sVSqKk5DGNes2DZ9Ex8V+
         Kkd8PpFKnxy/i53v6u9II+EWHVQ7fPEkqv3gNd//AxJYDogtltHmg63wPsIwy8JLz/Vf
         RxGsr1BFKwOsK292zYsplQYPP2flb6vV58vDKIJFUZDi/UP6CSp1m90zu87Q9iiA6S7m
         TXybYuZ5Lj3qTNejDn8O7zvLApI1n01j3o/qenCDjOI1ky0ZEf0eJLcMKjH2vzwkzxqR
         f9vNcLQJlAZQZGd0nxbrr1k/0cyj/iIOyF4ygfqnjxuSIDcXJyrChUTrmJL8H5Up/fLy
         Srxw==
X-Gm-Message-State: AOAM533JwPNYaNqNcagsFtGIB229A51hAKFDAVMQnelAurE3y24Ei+Cq
        jVnupDxCM2UkfBoqZ3bQBfw=
X-Google-Smtp-Source: ABdhPJx1H7i/YxQ8vtOIcAIqPjePKXIALbvDJbCp8VxEkGDXEXje3LuN3EnO8wW0nOt02I7Z3IYHUw==
X-Received: by 2002:a9d:3a24:: with SMTP id j33mr22204113otc.259.1608014103119;
        Mon, 14 Dec 2020 22:35:03 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y8sm4634562oix.43.2020.12.14.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 22:35:02 -0800 (PST)
Date:   Tue, 15 Dec 2020 00:35:00 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5fd859149990b_d7c48208d8@natae.notmuch>
In-Reply-To: <xmqqr1ns9drv.fsf@gitster.c.googlers.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-5-gitster@pobox.com>
 <5fd7d67c898e4_d44af20879@natae.notmuch>
 <xmqqr1ns9drv.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 4/5] pull: correct condition to trigger non-ff advice
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Then, we could just do:
> >
> >   if (opt_verbosity >= 0)
> >           advise(_(message_advice_pull_non_ff)).
> >
> > Or even better:
> >
> >   if (opt_verbosity >= 0)
> >           advise_if_enabled(ADVICE_PULL_NON_FF, _(message_advice_pull_non_ff));
> 
> I do not think we've decided what's the right way to squelch this
> advice, so it is a bit premature to favor the latter over the
> former.

I agree. Just thinking about the future.

> Between a fixed message[] variable and a single-purpose
> helper function I have no real preference.

OK. I just mentioned for consistencty with other parts of git.

-- 
Felipe Contreras
