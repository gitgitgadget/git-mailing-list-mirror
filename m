Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189F71F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeCYQt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:49:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40212 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753513AbeCYQtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:49:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id 1-v6so8435207oix.7
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BlF4bqWryu/y1UgE/SGzf7gcaCHPx7B49y6FGQ6Iaao=;
        b=bOdupDCxRUbsLc+lpluCukPZWkIfYjIspmFGykJVe+N/ygolzDpBMihBP+0TqHpnjJ
         R/2GnXeui3G5gtslJ+LLA2kLSK5rbr8pqWQDzVtjjuOwuZ8rkrXNV5rGSBLt8L32uiox
         UrvxZz8iYcJqGIKsNjbaMA4SX+0HFboMzh+9uQOi10UrRe9Vel6o2esI/Pua0BRxaoI9
         zpvZtL5vwhin7GvzlNEqw+9n4H1Spx6mpagNTT+z/Ya0i38tEtzuI7bMuRRNttWVdMz/
         ulYWoR+LXGrd3b1c6WgWUbgQSPkkE3hXTGFK8J4fS8nxCeTWcCVmkGnWGoeroJaL02h0
         j1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BlF4bqWryu/y1UgE/SGzf7gcaCHPx7B49y6FGQ6Iaao=;
        b=r7Fxyb4kqIlDQy0YeLHy/G5TSJQwztUOH8HTenhhOoYagGm8gT2JhxJFU5I/zOZDnh
         NGdIZwrM3BE8VQ/h+Mwc+JQSd68yXLjEz6MHJAGkhJlRPA514TOG8bxYJBDYtFAjEaF3
         kbZm0VZAZL3UVjr9CuiVL8x3JCDNG/u1ic21E57uiOef9h+6YCCn7ycZa5ZD3N2npDYY
         G2kAldDKhEEnCDmwhs/cQ+IX3zH+299qUETPPnudi6GZTSgE8uftu5cX0HWQi/pXChoD
         V2jh5DfUJtj/10jjtvJT+8iztr/KJpnV70vOW7V0j01qTYzR4GBLPvx/9bmPdxmCOviI
         7LyQ==
X-Gm-Message-State: AElRT7G9yQC/1wwAmvLN4NlbZqvzo1kPogWR0jsJSFmvOg3wXufortkR
        tdMeXih9bWnjNV9ZGKm5ViShYzAxXFenWAdfhig=
X-Google-Smtp-Source: AG47ELuC9FphcDaLudrKnqbZXks/fB5ISa9Arb/v2kYDniL14aubOyGtcxYmOMHJt7w1O+hP8JOpSsjVd40qYZ+pcOw=
X-Received: by 10.202.206.13 with SMTP id e13mr21699429oig.34.1521996595003;
 Sun, 25 Mar 2018 09:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Sun, 25 Mar 2018 09:49:24 -0700 (PDT)
In-Reply-To: <19c993cf-7220-42e1-6a76-d257d97d6f55@web.de>
References: <19c993cf-7220-42e1-6a76-d257d97d6f55@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 25 Mar 2018 18:49:24 +0200
Message-ID: <CACsJy8C+JDqfg2a3Ju-rb8n+ovUsoXsn0P7vqJZ71PQ38Fs8gg@mail.gmail.com>
Subject: Re: [PATCH] run-command: use strbuf_addstr() for adding a string to a strbuf
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 12:57 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Patch generated with Coccinelle and contrib/coccinelle/strbuf.cocci.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> That line was added by e73dd78699 (run-command.c: introduce
> trace_run_command()).
>
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index a483d5904a..84899e423f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -621,7 +621,7 @@ static void trace_run_command(const struct child_proc=
ess *cp)
>         if (!trace_want(&trace_default_key))
>                 return;
>
> -       strbuf_addf(&buf, "trace: run_command:");
> +       strbuf_addstr(&buf, "trace: run_command:");

Obviously correct. Ack.

>         if (cp->dir) {
>                 strbuf_addstr(&buf, " cd ");
>                 sq_quote_buf_pretty(&buf, cp->dir);
> --
> 2.16.3



--=20
Duy
