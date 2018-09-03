Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D8E1F428
	for <e@80x24.org>; Mon,  3 Sep 2018 19:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeICX2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:28:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35030 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICX2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:28:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id j7-v6so1561418qtp.2
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 12:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUEO7Q/wo9dNzytrdKXY5+eGALIczQeepuCGqBpUxwk=;
        b=PJPhlEIk0lCvmrIUZHNJFuE7rZ12zn7g0OdtrTQAsRUIU+aztV1k2+gVvxCPeY6Hh/
         JZocaJ3LItQkqqdj0Fuhc+WEdN3+EVH/lV5Il3NodZY26kNKHAiQdEwzDc5t0szRCw+s
         xBZun1hCwqn09Lpzp4mt2qKU7Px5MGF7Evd7afUV/d0jUyQIYb2pe8y0NRMHpsEuIsTv
         M6wCoQJGUOMdt7w2ieMTi27GeAC/xXksm2JroZTQ08iIbyD0sTLNDDvMx2+8gvIcm2hX
         ActYlZsgomyLtSBcaauBX8uMPToqQzcCTynHNYnqun+hIOi3l94jMP0jGISol9yymy/z
         liWA==
X-Gm-Message-State: APzg51CrMncY+rfyBQPi6zfE8mvJ5xrz2Iz/c4Hy5+19yGN2yrE6AhWt
        lgYlgyqKBo/KONqKWB/uPbnYUx/8H/lIVyK+G0Q=
X-Google-Smtp-Source: ANB0Vda4G1N9Q0K2ZjsxbSIi14GjIWWacSvIhjHU+tKJIo3A5rsY4oNbqlR+iPgIx8xxIbRVx2Fj3QNPU1S8XP8q7DM=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr27798900qtd.101.1536001625282;
 Mon, 03 Sep 2018 12:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
 <6832c979c8dca2a3584ed3cf828a6de060413cda.1535665109.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1809032031090.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1809032031090.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Sep 2018 15:06:54 -0400
Message-ID: <CAPig+cTGBi1P5V3uGwtKCvoCn=-17y1dY3dBkS13Yx1ikjpXcQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v8 17/20] stash: convert save to builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 2:44 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> where `strbuf_join_argv()` would be implemented like this (and I would put
> it into strbuf.c and strbuf.h:
>
>         const char *strbuf_join_argv(struct strbuf *buf,
>                                      int argc, const char **argv, char delim)
>         {
>                 if (!argc)
>                         return buf->buf;
>
>                 strbuf_addstr(buf, *argv);
>                 while (--i) {

s/i/argc/

>                         strbuf_addch(buf, delim);
>                         strbuf_addstr(buf, *(++argv);
>                 }
>
>                 return buf->buf;
>         }
