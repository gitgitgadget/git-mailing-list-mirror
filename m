Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B532B1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeDTRrB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:47:01 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:41394 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeDTRrA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:47:00 -0400
Received: by mail-qt0-f178.google.com with SMTP id d3-v6so10683648qth.8
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sKrgyyMMCGlj2qo1Yo1FByBAnUqGdnwhZ5xpkme3yIw=;
        b=UX0tzoRv1J/J2foTdpd58kyVqvl25/iZUKHc5qRzWnxeRyPwwimAHJYmdwzTGH0Xe7
         4q14R1o5Ck6wEToObzr1Wk/1HFXbMSFXn+x+BUC2UgcBhZsHPnUyz155kRbS2raRPp1y
         gWStpfIa4drgh7BjUpz3C2dIAXPkI1JT30bqy2dW7uU22QoZT75214jp4McMMES8yTHj
         A4BD1J/bivEZp15Fj+kOLeimP83FBLVQ4noUB1eEQo0n+bTsLbfWS8LjRUZR6WDAt0FY
         Eazc0B1HKBpiH1fz1iBpikVjjxeo4Sw3w9k7ywctZj/y5xCnVqIokp6i24FfwhXoi7Q5
         20Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sKrgyyMMCGlj2qo1Yo1FByBAnUqGdnwhZ5xpkme3yIw=;
        b=ADY21h1sHEsvC95/dOM/J4n8JHz/hSmI3dZbDvM2AXRmE5oEUJxpJPRAGMw09oQtMj
         MKICS9wf8zmqZTTz84zWHnCnWwrvVEgPKd34fpI2Ku2rzLAufkseBkU7KdBIU5jFb6fR
         jHwvtG5kJdrj9AT5Lqpw4TH0+H+CSHS4UcP0QzdArEiMZIS5p7arHCoEpKvL/veH/FMd
         Ha45I2jjnCvZC+PXp+6FIW5KUHmOziy3ZLvqtXco3ZsP2DWUr81G5hGJwJvqYjzDagVG
         QVMJkZCIbrBoNM01e1R5yR8sfBlXxsSq1ysH9GqO4JPnFfghJq/l7ZfegIEF0/sWYRW8
         hh8w==
X-Gm-Message-State: ALQs6tDSZ58a2PnxjesZXxZZ9q7tzrmCF/5WY7qwAf93i0glTVl487Tg
        nypN01Xo3v6wScjQPWUscKR5yo5136YWCC1op4I=
X-Google-Smtp-Source: AB8JxZodAtanaPeot1TeznuUP116pIlpIJRo2fM9i5FU8vPAOA331b7TO32VJEuixxZqaOSaRLk8csz7GXsmHDADAfc=
X-Received: by 2002:ac8:17d1:: with SMTP id r17-v6mr11564420qtk.314.1524246419989;
 Fri, 20 Apr 2018 10:46:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 10:46:59 -0700 (PDT)
In-Reply-To: <20180420121041.32558-1-chriscool@tuxfamily.org>
References: <20180420121041.32558-1-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 13:46:59 -0400
X-Google-Sender-Auth: oNoJj1Gqdicl6xSbZ6NJYGuOKSs
Message-ID: <CAPig+cSDYVGpaV-beNVG57r3YfQ=Ey5zuyHRkk_tf86NNRdY6w@mail.gmail.com>
Subject: Re: [PATCH v1] perf/aggregate: tighten option parsing
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 8:10 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> When passing an option '--foo' that it does not recognize, the
> aggregate.perl script should die with an helpful error message
> like:
>
>   unknown option '--foo' at ./aggregate.perl line 80.
>
> rather than:
>
>   fatal: Needed a single revision
>   rev-parse --verify --foo: command returned error: 128
>
> While at it let's also prevent something like
> 'foo--sort-by=regression' to be handled as if
> '--sort-by=regression' had been used.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> @@ -46,7 +46,7 @@ while (scalar @ARGV) {
> -       if ($arg =~ /--sort-by(?:=(.*))?/) {
> +       if ($arg =~ /^--sort-by(?:=(.*))?$/) {

Makes sense.

> @@ -76,6 +76,9 @@ while (scalar @ARGV) {
> +       if ($arg =~ /^--.+$/) {
> +               die "unknown option '$arg'";
> +       }

Nit: In this expression, the trailing +$ makes the match no tighter
than the simpler /^--./, so the latter would be good enough.

Not necessarily worth a re-roll.
