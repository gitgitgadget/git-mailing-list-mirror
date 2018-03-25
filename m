Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3F61F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeCYQtY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:49:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51036 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCYQtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:49:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id i75so11282850wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dmaYxpaAp+I7Z7kwbf3eS6IFFAhkjbLmSwf1Fjz4sy8=;
        b=BMJPQkp4+2OFhQJzCMQUTc0RUSi3GADerwohJPokl3UX10PwX+bW4pvcDLhb7O8kjp
         S+E4w6mKHwt8yJTFPnRPXflqosxm9mJbteq/HPLZ4a8aVQwrLgdV4UPYsDbSsX378Y0A
         cqgcdB7MlQbwwC6ViZdKtVVipkRQxtiZE7Mclf7BL5iNGXQw3DTBRQ9n/U4kgjQG364P
         Ux8tEqD0tz9JhxargZVdOXN/KibYeDCjpVzhZeMDr2OFZN3cgCRd7hoJHAktdJBWtD3q
         jR427G+6XMaUlrZUMDRh2yQU9LmyIt7G3D7yCHa0q8k4JZayIJ2JGkYDWPVqVp+bRZfg
         6ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dmaYxpaAp+I7Z7kwbf3eS6IFFAhkjbLmSwf1Fjz4sy8=;
        b=MJGcL1ECPDrcdRgo4N/3R6gyXeAHlEasEIJzrgg7MVIJdiU8LH7UrzKuontzLcTdkd
         wnR5ugDHSYAx/KmiQQprvxNkntf1TRgDVIFW5ypyZb2ZBzXu3MlV8KiTBQiCX2XGNHdp
         PBHr8TZcmLcZNMfXg90uQLAnmuZjkXL1MUp1PhSG871gOCKL9ZLzeHSOogWs1I/QRxgF
         G9pKWQLeurTv1lcjOSfkeZ74NWuP6n8yLKxIyE2pDyC5IDKXPkLYHuD7IYIuW7Drhck6
         D16VniFbttoN3VGGyC/GZUxl6B1qz/0pFGslxVI4klswDlL1vfH2mB9PN+HsQ2hNKIcN
         jPEg==
X-Gm-Message-State: AElRT7ElQavUUQgAVG+xV8sNDYEV9lqlaJFLrLaX7eFzfbf1x7rblf6E
        1FkztNP3htt30crgs3HVqFM=
X-Google-Smtp-Source: AG47ELsDp0QDj562M5otqSLh7vn7kTaCU9vJYbjtiftsnn0ynlb+nfJIK1Su/MeE3BBEg64ignGTZw==
X-Received: by 10.28.109.27 with SMTP id i27mr14159959wmc.109.1521996562545;
        Sun, 25 Mar 2018 09:49:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p197sm1176508wme.43.2018.03.25.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:49:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] run-command: use strbuf_addstr() for adding a string to a strbuf
References: <19c993cf-7220-42e1-6a76-d257d97d6f55@web.de>
Date:   Sun, 25 Mar 2018 09:49:21 -0700
In-Reply-To: <19c993cf-7220-42e1-6a76-d257d97d6f55@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 25 Mar 2018 12:57:50 +0200")
Message-ID: <xmqqbmfcf6cu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Patch generated with Coccinelle and contrib/coccinelle/strbuf.cocci.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> That line was added by e73dd78699 (run-command.c: introduce
> trace_run_command()).

Thanks.

>
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index a483d5904a..84899e423f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -621,7 +621,7 @@ static void trace_run_command(const struct child_process *cp)
>  	if (!trace_want(&trace_default_key))
>  		return;
>  
> -	strbuf_addf(&buf, "trace: run_command:");
> +	strbuf_addstr(&buf, "trace: run_command:");
>  	if (cp->dir) {
>  		strbuf_addstr(&buf, " cd ");
>  		sq_quote_buf_pretty(&buf, cp->dir);
