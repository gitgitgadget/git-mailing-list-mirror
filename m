Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32E31F404
	for <e@80x24.org>; Fri, 24 Aug 2018 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeHYBGd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 24 Aug 2018 21:06:33 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:40664 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHYBGd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 21:06:33 -0400
Received: by mail-qt0-f180.google.com with SMTP id h4-v6so11741060qtj.7
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 14:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIpl51RF/31pAzaBXGVFqf3hykBwRQQPSZwxAxLYs1I=;
        b=I+tKv0GoUzy/QzRFWpTLCBbYIgOdZLzdKrpI+5KLSMh2H+Rdf2KpNE0HZ3jT8KTpIF
         8t3xH1mrCQRmyfviYVSbBxlHp4wmQVNlzHaiXxscyq2pP13v740bX4n+oOUMMFl6xO9U
         4nkhILM6ExGIPVpG96x3F4G61+djZww2jMHzszgkhzpu8bQJi1mXUNbJaAnxY3O1Y6r4
         pcypsRrZPOUmo5eeqNclWkY2h9nuHmrr97Zpzd7hI2ruNmeqUoD5l8qnXAWscxBl6t7f
         aKY6v+l5XJBYMdPN4SVkVTive9knVaID/L0/W8cCLuXJ0BwZQKUIMjfyNpLYcbPaXMry
         MH8w==
X-Gm-Message-State: APzg51AjfS18r//FantrpZYDOfWozFfvW8SIg3oKJBLd5jQNMHyOH2JK
        s8wGtsXkOhkgHMsryiV5XeVAqBFSzxbD3HqeSgY=
X-Google-Smtp-Source: ANB0VdbDZaxO2aliP3GdglQeMtNGgGhuoDbeXqvTKpHTmFalMuVNdlaZGCnXYZD0QP8/SHiCsjODejkobXoCE3TPtik=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr3788489qvl.62.1535146210942;
 Fri, 24 Aug 2018 14:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
 <20180824152016.20286-5-avarab@gmail.com>
In-Reply-To: <20180824152016.20286-5-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Aug 2018 17:29:59 -0400
Message-ID: <CAPig+cQxUdr0g+i6AztcH4Q51X-W4MtdhKGv=wau+b6SFsniAQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] tests: use shorter here-docs in chainlint.sed for
 AIX sed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 11:20 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Improve the portability of chainlint by using shorter here-docs. On
> AIX sed will complain about:
>
>     sed: 0602-417 The label :hereslurp is greater than eight
>     characters

Shortening the names makes them ugly and often unreadable. That's not
a complaint with this patch; just a general observation regarding
8-byte limitation with this platform's "sed" (and POSIX). See a few
suggested improvements below, but probably not worth a re-roll.

> This, in combination with the previous fix to this file makes
> GIT_TEST_CHAIN_LINT=1 (which is the default) working again on AIX
> without issues, and the "gmake check-chainlint" test also passes.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

FWIW,
Acked-by: Eric Sunshine <sunshine@sunshineco.com>

> diff --git a/t/chainlint.sed b/t/chainlint.sed
> -:checkchain
> +:chkchn

":chkchain"

>  # found incomplete line "...\" -- slurp up next line
> -:incomplete
> +:icmplte

":fold" (for "fold out NL")

>  # found nested multi-line "(...\n...)" -- pass through untouched
> -:nestslurp
> +:nstslurp

":nesteat"

> -:nestcontinue
> +:nstcnt

":nestcont"

> -:nestclose
> +:nstclose

":nestend" or ":endnest"

>  # found closing ")" on own line -- drop "suspect" from final line of subshell
>  # since that line legitimately lacks "&&" and exit subshell loop
> -:closesolo
> +:clssolo

":endsolo"
