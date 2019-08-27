Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B7E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 11:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfH0Lv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 07:51:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37784 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0Lv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 07:51:27 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so45575227iog.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zom4F8NldQFlsZpAJkm5RY/TUtPPveXnFAwHpJkTOp8=;
        b=f56ds8xMeOOhnAojHsXRuyojZ9Hag81Ea8mI0WtGHmetFHLDAytXK/04DwUi2a6gns
         sEaYb5j0tHMrjsrvBDLto/mba5r00OxCb0tmoX9X6Jmjsf0YXYPZEZadBOK7H2E4y4ZV
         BiYvWzouOLAGnl35kb62zJCpdj2/URXkZE82BHj1cMzaSxdobb1V9cpTHiOCGPIfJ6nO
         XgnWtJTV8VIL7MDO9tgRhG2W0kDGl0B7FUze+jHOsmVw8OxHwuCzoXs2a9iR879WtvV/
         fpV29YNH9b3lrPQ3Plo4vgQnactIhEIdW5RDC+503NSLRlt2O41NZH2bJXhAKW8+LgTs
         zH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zom4F8NldQFlsZpAJkm5RY/TUtPPveXnFAwHpJkTOp8=;
        b=s6cB9tmECubpk5RET+NGuQ7vqQ9eRPQa0YfJLFCF/8ftsc9lSN6bSpdRhtSejAZWyr
         h3RwLbhS2uebm2ggM79fU9lDskagupIVp6tIdYt6eIwzfV4ZQQlFrzLD4gaw/4HZgFxk
         m5yNOkd2eQulXaGdGy8590qHjSkvUza3z6oyHdauqzMbbybBSOG8NWY8/dp2rPerI2Xb
         5wi5sY6WnvTTstClG1ncLSbqR5wIfxLpjBJn8l8OG9+Zq5Tba6ket4b6nFZ8LINHGj8J
         2nxLGr2tCWPlhhmIwgiHib7n5gp/Uv3EBs7flNY492iCDK3SvrRN17u9pm6HJkPEggpR
         MwsQ==
X-Gm-Message-State: APjAAAVOaE9VF3N2WKG6LMOA7OlAN3Z9hRE1myhHxLk4C+8ZOl4PgVox
        C4KXrx1qdXB08mxbWQs79IGVEYZZ77QFnM9zgZo=
X-Google-Smtp-Source: APXvYqy1KjCHCXa6T/ZelxW6PdyYlqqJ9M6zGXN5g+jomEe/P02wwfuwfrHNZwN8QJm9nc0bzky0DyZgW8/hZBBwnn8=
X-Received: by 2002:a05:6602:186:: with SMTP id m6mr8084128ioo.162.1566906686203;
 Tue, 27 Aug 2019 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com>
 <20190809030210.18353-3-carenas@gmail.com> <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 27 Aug 2019 04:51:14 -0700
Message-ID: <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 2:07 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Unfortunately, this is _still_ incorrect.

I know, and that is why we worked out a v6 RC with Rene than then was
pushed to github[0] and validated to work thanks to your integration
as detailed in [1], I never got to send an update to the list though
because Rene wanted my squashing into his patch to be independent as
detailed there and because I assumed that when Junio didn't pull my
reroll, it was probably because your tree had a fix already anyway.

the recent discovery that xmalloc wasn't thread safe though,
complicates things further and that is why I was expecting to reroll
this on top of both ab/pcre-jit-fixes and jk/drop-release-pack-memory
(later one already in next) as detailed in [2]

> I pointed out multiple times that custom allocators can be activated at
> run-time rather than compile-time, therefore making the choice at
> compile-time is wrong. Besides, there is nothing specific to nedmalloc
> about this. So the patch is double-wrong on that account.

Just to clarify, I think my patch accounts for that (haven't tested
that assumption, but will do now that I have a windows box, probably
even with mi-alloc) but yes, the only reason why there were references
to NEDMALLOC was to isolate the code and make sure the fix was
tackling the problem, it was not my intention to do so at the end,
specially once we agreed that xmalloc should be used anyway.

> The patch has a yet even more immediate problem: t7816.48 is failing in
> the CI build for _weeks_ now: it requires that global context to be
> initialized, but no code path hits the initialization, resulting in a
> very, very ugly:
>
>         BUG: grep.c:516: pcre2_global_context uninitialized
>
> See
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=15151&view=ms.vss-test-web.build-test-results-tab&runId=41282&resultId=101710&paneView=debug
> for details.

IMHO this is probably testing V3 (from pu) and which was hopefully
fixed in the last github force push for my branch

> All of this could be easily avoided. As I had pointed out already, the
> obvious fragility is not worth the optimization, and we should just
> initialize the global context always, as does this patch
> (https://github.com/git-for-windows/git/commit/5e5b959169e6efee73e0b50e464166822b7d2d07).

ironically only found out about that patch after I got a windows box
(running Windows Home though) and had finished testing my own squashed
fix[3] that has succeeded being validated in GitHub

apologize for the delays, and will be fine using your squash, mine,
the V6 RC (my preference) or dropping this series from pu if that
would help clear the ugliness of pu for windows

hopefully this won't be repeated now that I am aware of github's
integration and have my own (albeit very slow) windows environment as
well.

Carlo

[0] https://github.com/git/git/commit/0ca5d0550c17a68d83b8922b71aeff891958ed0e
[1] https://public-inbox.org/git/CAPUEspiFuvgMQ3W1se1B=8aTTrQsJSZTyQTzG1TpiyN8HTOpkA@mail.gmail.com/
[2] https://public-inbox.org/git/CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com/
[3] https://github.com/git/git/pull/627
