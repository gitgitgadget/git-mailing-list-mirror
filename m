Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B339220285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdH3SX0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:23:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33630 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdH3SXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:23:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id r62so2032315pfj.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2p3clySs3sauZuDjACEgLlcmSFJOCFP+oQ4+P1aX0XA=;
        b=aTnC3/dfPxcVIY3+nX2DT4oAtcjZgwGov0TBiz6OGp+QaFThEniZb24/0UBv5K6ggd
         CX7HKIDgQknCPsbd5Al9oIaxscLy4eE5rE1Tsbf0bxk2lvj2QciwuFDzsClsD1Mgwp6S
         2zaEHNK1Cm8Hp3+akxt9VZagm2+/DqFyTB97bwfFCrPywwbkG4GUs/F3qnMhS1vQax8g
         kk9HPLlrkNv/867/yUQrMXooPSoqC2OUFVhGXAHyVBLQ46fTdPEvjBKRytaEXNzjjBxF
         7Q3Ln06uP5/4ShhbBb8oYP3HdCgXZ6/hbzLTex7E8BxTbO+PoMx+J/1GrmNIN4hLlSvE
         YjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2p3clySs3sauZuDjACEgLlcmSFJOCFP+oQ4+P1aX0XA=;
        b=GTMMEEdM+YiVKliawv1PNYRuXS+wwaA4Mc6TyxAwp+NCclGzkc7okgBs8wV/Fcn/mN
         xRX0R/rSuka62ySZI7Smt7Ev5lInHS0yQNjX5Cd5eNPky6GsP0CHF2gAGVYOutbW1JXm
         ecUi14we769Ubm/YK9M9xzOO4YozeiEW3a0ae54p+WC6y4tEKq8KG7HDQRhVm2ssehHN
         EhalngXGrcGHi23sy7uMxLf144Q7VJOCOZCzoSPrRqXc4wQ6MRk/CcEUcy7WvufbGa64
         oSaQ0b76sW6zAQ792DjdKsmUjJ0QzPhjk1RdbAwxAn9hG+mSw5SfzQivj0xPeqNYOvRy
         hRCw==
X-Gm-Message-State: AHYfb5h39tADfVETW0IPZJikqXQp9gEX6Atvz46jSJW3z9PJgk+bXA3+
        +iWJ7SKZvjbisx9J0uhaXTrxVPO3Zw==
X-Received: by 10.99.112.20 with SMTP id l20mr2419336pgc.362.1504117405193;
 Wed, 30 Aug 2017 11:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.197 with HTTP; Wed, 30 Aug 2017 11:23:24 -0700 (PDT)
In-Reply-To: <20170830175005.20756-18-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-18-l.s.r@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 Aug 2017 20:23:24 +0200
Message-ID: <CAN0heSopzQdkO373_eTHM8=z9fAWJFhyo6a5tVPWW-j8p0V2xA@mail.gmail.com>
Subject: Re: [PATCH 17/34] mailinfo: release strbuf on error return in handle_boundary()
To:     Rene Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 August 2017 at 19:49, Rene Scharfe <l.s.r@web.de> wrote:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  mailinfo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index b1f5159546..f2387a3267 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -911,48 +911,49 @@ static int find_boundary(struct mailinfo *mi, struct strbuf *line)
>  static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
>  {
>         struct strbuf newline = STRBUF_INIT;
>
>         strbuf_addch(&newline, '\n');
>  again:
>         if (line->len >= (*(mi->content_top))->len + 2 &&
>             !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
>                 /* we hit an end boundary */
>                 /* pop the current boundary off the stack */
>                 strbuf_release(*(mi->content_top));
>                 FREE_AND_NULL(*(mi->content_top));
>
>                 /* technically won't happen as is_multipart_boundary()
>                    will fail first.  But just in case..
>                  */
>                 if (--mi->content_top < mi->content) {
>                         error("Detected mismatched boundaries, can't recover");
>                         mi->input_error = -1;
>                         mi->content_top = mi->content;
> +                       strbuf_release(&newline);
>                         return 0;
>                 }

Since this code path can't be taken (or so it says): How did you find
this and the others? Static analysis? Grepping around?
