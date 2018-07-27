Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87761F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbeG0S5R (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:57:17 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42999 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbeG0S5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:57:16 -0400
Received: by mail-wr1-f51.google.com with SMTP id e7-v6so5795229wrs.9
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3STyhLCx13TJ/I0WzXSH+zspEW2LmNRHJ5cbmnUj3fw=;
        b=evt2bpnJZMoANcDqZz9spDh0HwQ3DeDItcif9ZofovFwsq5ybeOW8yDaEOqPrBd54y
         vF5NUGMqnz6qOcnTVCGhqeqA1vdRopI0E2DQ4Zf0YBjR0dc37gmloy5OFcCXWnitD7WK
         hct01DcgcptGGwKAVrgSv744+J/6H1WBGadaQIQGIewvD/nZaZvKt++p+ObTExjrCnlW
         Na3uc2/RU5Ak/FME0VXq8/gguWxOWil2NrpMnVxzxFFe1D0VxAWBZ7DaxmJNx70YUmCm
         zUUvVBuDt/wvqN7kWWcim90eRhATQGkSGfmP8Q8xAnzEG5dryLrbqRvgDWt3PDZ6xR2G
         pIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3STyhLCx13TJ/I0WzXSH+zspEW2LmNRHJ5cbmnUj3fw=;
        b=CS3CXGDE+zjCMRcYfjSIJWVsVilQfpLLHnHUcbXRqoxks6rXwn8mj2bgrf/J99zK1A
         1A+KJdgJGX46deOksBarUkRif8G0+StWtliVaW+LTzwDTpjgiHBsLXcvJg4RAMEhKD71
         JV3m2dDRHwN8JmZrRt3vg6R+1XKpKxiZeep5oLPCsvH7/nQzGOjClMo89zI/CnXvQtVk
         JH3VkiwMh1eWi82lAIrqVEvK1BH3FHoiZ+jzWSVBpg8qv9Hp4wrdKN8jQYqGmtrnIHdI
         KIOnHbnxV1nQprKUm3Usez0yD80RXJN+F5nFrUJXkn6KiKnEnl4FDbeaWIDcopkqNqr2
         g14g==
X-Gm-Message-State: AOUpUlEYFgS4V6DoFs+Fz8CjBDiMLeuFHR9FXMXecIs/2vk8gdjZ5XoE
        EtCmZO6X9rmUCyX7wN94ZA4=
X-Google-Smtp-Source: AAOMgpeWLliURG4BXnuYxeJ3D+ndOklKMY+tgSSM+ICRuBQH/47Yx0YfrMp603AYnId9FmlxdHm98A==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr5875464wrh.65.1532712861633;
        Fri, 27 Jul 2018 10:34:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f3-v6sm3200187wmb.22.2018.07.27.10.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:34:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/4] automatically ban strcpy()
References: <20180724092329.GA24250@sigill.intra.peff.net>
        <20180724092618.GA3288@sigill.intra.peff.net>
        <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
        <20180726065840.GA27349@sigill.intra.peff.net>
        <20180726072105.GA6057@sigill.intra.peff.net>
        <xmqqfu05rjfc.fsf@gitster-ct.c.googlers.com>
        <20180727080807.GA11932@sigill.intra.peff.net>
Date:   Fri, 27 Jul 2018 10:34:20 -0700
In-Reply-To: <20180727080807.GA11932@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 27 Jul 2018 04:08:08 -0400")
Message-ID: <xmqq8t5woa5f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  $ git rebase --onto HEAD @{-1}~3 @{-1}^0
>
> Interesting. I'd have probably done it with an interactive rebase:
>
>   $ git rebase -i HEAD~4
>   [change first "pick" to "edit"; after stopping...]
>   $ git reset --hard HEAD^ ;# throw away patch 1
>   $ git am -s mbox         ;# apply single patch
>   $ git rebase --continue
>
> Which is really the same thing,...

I have unfounded fear for doing anything other than "edit", "commit
--amend", "rebase --continue", or "rebase --abort" during a "rebase
-i" session.  

Especiallly "reset --hard" with anything but HEAD.  I guess that is
because I do not fully trust/understand how the sequencer machinery
replays the remainder of todo tasks on top of the HEAD that is
different from what it left me to futz with when it relinquished the
control.

Also "am" during "rebase -i" is scary to me, as "am" also tries to
keep its own sequencing state.  Do you know if "rebase --continue"
would work correctly in the above sequence if "am" conflicted, I
gave up, and said "am --abort", for example?  I don't offhand know.
