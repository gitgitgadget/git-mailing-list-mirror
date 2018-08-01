Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6006B1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbeHAVdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:33:37 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36217 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbeHAVdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:33:37 -0400
Received: by mail-yb0-f193.google.com with SMTP id s1-v6so8015101ybk.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfo+MrfKC1B0tdum5jR7PQFSJ/9p8exVgA4b8rR4yxQ=;
        b=TUAdATX4GHMI8IWmJbaUu8hk437wfTSr0vytlRY6g35sv0Y3OoqUxx7bTnbUpETel5
         860L5R7kcf8IHIJs5CydAgK+IahjunvIJ6lbVGb30oeO+Fn9tII0x1TAXlE4nCsGTv21
         UKSG7DrIc7aB3cEQKA5yVbrdDzzhnk2fqZ9raz+iS/PuJR8mkOB3VFvD2i1R6wkij7mA
         8yrEztZiIl5PHporV+0jVHXY7P9+MgtayPwEv0U6F3utxvaDmdW0CxeRSPwGSZiLLK8u
         IFcHkOSascBlgcONfT72ICJxKTMEuvYW+3iXiQB8VThJ/GGFhEQLXXt2phumhdf4GroA
         l4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfo+MrfKC1B0tdum5jR7PQFSJ/9p8exVgA4b8rR4yxQ=;
        b=kncdm3VpwE/yXIFTkL0navtazAd0EjYZ46KqnG8wCuerhvDurbS720qBofYjRvT6Tg
         xzuyPUvGXMYyalmHc8pFIJuXnVfNfNcC1shqTfz6FrGXxcyThQy4lOGPpj91+11y+yqk
         hftqS5HlrI3hxmpiDOqWdUXSuf7a3ZikfD/YQ5fA3D1bxuQhpWBA5DmpJImCvZzpNR4E
         gFp87WCDf4bvLmn76u1VuSS6CLukInqTefRUnJw4fMCQaaa3LRTsxCtX6d4eJEIRhGa9
         DdYSOk4KUHLmKbkQMcGzIYi23jsx9cbAG25BjJr2mh3r5i1ZDWVikplhFjGGmEqtDQsd
         4H9A==
X-Gm-Message-State: AOUpUlE0DHEv2ZULxALKLv/8NUcLsyHi/b8+L/+zQstlNoeDA0aQ0mNZ
        vTLCJeK5kldC1nItgwPIYw/6TS5uff+MrDbqd0aAenLtHjw4bw==
X-Google-Smtp-Source: AAOMgpfotiIbijXg6kT4/XJf9saVj03vproA07SJelYhCTyrL23VwJu/cVHh5e2DX1HuCIA5EDN+jmxZoE0KwYqoArU=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr14912507ybi.247.1533152775273;
 Wed, 01 Aug 2018 12:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
 <xmqq8t5p7veb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t5p7veb.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Aug 2018 12:46:04 -0700
Message-ID: <CAGZ79kbkWEa2zchvSo8nr2RFt8NaeU-bnzY7=z=50D+GUZMqKA@mail.gmail.com>
Subject: Re: [PATCHv2 0/8] Add color test for range-diff, simplify diff.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Stefan Beller (8):
> >   test_decode_color: understand FAINT and ITALIC
> >   t3206: add color test for range-diff --dual-color
> >   diff.c: simplify caller of emit_line_0
> >   diff.c: reorder arguments for emit_line_ws_markup
> >   diff.c: add set_sign to emit_line_0
> >   diff: use emit_line_0 once per line
> >   diff.c: compute reverse locally in emit_line_0
> >   diff.c: rewrite emit_line_0 more understandably
> >
> >  diff.c                  | 94 +++++++++++++++++++++++------------------
> >  t/t3206-range-diff.sh   | 39 +++++++++++++++++
> >  t/test-lib-functions.sh |  2 +
> >  3 files changed, 93 insertions(+), 42 deletions(-)
>
> As I cannot merge this as is to 'pu' and keep going, I'll queue the
> following to the tip.  I think it can be squashed to "t3206: add
> color test" but for now they will remain separate patches.
>
> Subject: [PATCH] fixup! t3206: add color test for range-diff --dual-color

Thanks for dealing with my stubbornness here.

I assumed that the contribution would be a one time hassle
during git-am, not an ongoing problem during the whole time
the patch flows through pu/next/master, which is why I punted
on doing this change and resending in a timely manner.

Further I assumed the sed trick as below is harder to read,
but it turns out it is not. It is still very understandable.

https://public-inbox.org/git/nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet/
sounds like DScho wants to incorporate some white space related
stuff that might collide with the later parts of this series, so
I am not sure how easy it will be to carry this through pu,
so feel free to drop it as well.

Thanks!
Stefan
