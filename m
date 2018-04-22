Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0A51F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeDVXax (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:30:53 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46723 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeDVXaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:30:52 -0400
Received: by mail-pg0-f48.google.com with SMTP id t12so7064304pgp.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vqukeaUzus5NsO0ufJLagMVpc0P1mG2tCrTrupWql4=;
        b=wdMVGAHQWfxSwCzuDiFO0u9nilAqr+pLhEoAmNkkMFHCrIxSX9K7nwWIwAXtu+HtaO
         f47jDlrAGMHD2SOnO8i8UrWW6s64KI/3QswFf5e2bhJqYriJbo+i1ZqIsEtCQTk/CjTs
         Nfbapcdb4fPViJ2W5wTl2urycl0M7md15vdWwVkgqE/L3qDjM3X8kVY7kXIDMzKtVj7a
         xyG0r9yR5MXtPv0q9Jhd7SzPvcbbUYrmGjRVQSXV12SwUGqybHaMS6N1qjeKa452P2sZ
         DqRqgqOoadH/zht/XwwlOMMcoXxX3K3pOa52k9oXmHazwSZi9sPSxXHMVr/hIfWZzOr2
         Zdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vqukeaUzus5NsO0ufJLagMVpc0P1mG2tCrTrupWql4=;
        b=YmSxEDOY/xdWtWfjv3FB6/hRl6nBo10Uj1GCiMuPzNUHy4QTFirkLGkuAgTv3dZz24
         M3qmp8ZyiT276TNeQCsuSr3pn86CJChnPBiW8MxeOh/ajcOJl6Ad5yMwPNRpiLwSRxhZ
         GaoyBXUYx243PAP6DK9Yaxdt7uL29FfNM8Obeexvt7gUJCYeRw5filahOExMF1iI1naI
         Lv3XTTT27OXboYOCJWejXiSfAW+OOeDTmBUjXEFL/duQ4OslJjgC071fnG8S85qiZEzs
         Py8hZygfmI/dUbQzCPFfJe/4ZC5qfkYiAIIEORqasurEmLWLlMS06pHB17Z5D5QRK5vU
         tbQg==
X-Gm-Message-State: ALQs6tAfXk/FwmoH0ey/1RAfrQ58mvXdhyd8sNjrVdbc7W7N80C41S+c
        5onyACfilz0qBJ6vZjPjFEOHdA==
X-Google-Smtp-Source: AIpwx4/Ltnf/jG37AXXC/IpbkcTxav+9QAysI25/4O3f3sBN+myk3TZftPt7qIl48dQblPnDN9j/0g==
X-Received: by 10.99.49.205 with SMTP id x196mr13353252pgx.397.1524439852013;
        Sun, 22 Apr 2018 16:30:52 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id g15sm16145559pgv.42.2018.04.22.16.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:30:50 -0700 (PDT)
Date:   Sun, 22 Apr 2018 16:30:50 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] grep.c: take regmatch_t as argument in
 match_line()
Message-ID: <20180422233050.GD48072@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <73eb315b1f9daa518405c3ab1b28087c38f27ce5.1524429778.git.me@ttaylorr.com>
 <CAPig+cRfCZQ8aPvc6AVoojtpuiWgNS_9A+9m5mV2mOC1BwemQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRfCZQ8aPvc6AVoojtpuiWgNS_9A+9m5mV2mOC1BwemQQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 07:14:58PM -0400, Eric Sunshine wrote:
> On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > In a subsequent patch, we teach show_line() to optionally include the
> > column number of the first match on each matched line.
> >
> > The regmatch_t involved in match_line() and match_one_pattern() both
> > contain this information (via regmatch_t->rm_so), but their current
> > implementation throws this stack variable away at the end of the call.
> >
> > Instead, let's teach match_line() to take in a 'regmatch_t *' so that
> > callers can inspect the result of their calls. This will prove useful in
> > a subsequent commit when a caller will forward on information from the
> > regmatch_t into show_line (as described above).
> >
> > The return condition remains unchanged, therefore the only change
> > required of callers is the addition of a single argument.
>
> Is 'rm_so' the only piece of information which callers will ever want
> to extract from 'regmatch_t'? If so, this patch's approach might be
> overly broad, unnecessarily exposing too much of match_lines()'s
> internal implementation. An alternative would be to narrow the
> interface and limit exposure by passing in an 'int *matched_col' or
> some such.
>
> (Not necessarily a big deal, but something to consider.)

Thanks; I do not think that this is overly broad, although I suppose
that it does bind us to the implementation of regmatch_t. The definition
of regmatch_t, however, is fairly minimal:

	typedef struct
	{
		regoff_t rm_so;  /* Byte offset from string's start to substring's start.  */
		regoff_t rm_eo;  /* Byte offset from string's start to substring's end.  */
	} regmatch_t;

I can imagine that other callers would be interested in the other piece
of information, 'rm_eo', as well. Therefore, I think it makes sense to
provide access to it along with 'rm_so'.

I think that if we are concerned with being bound to regmatch_t, then we
could typedef a new struct that contains a 'start' and 'end' unsigned,
but I think that this extra effort would not be fruitful, since the
majority of grep.c assumes regmatch_t (and friends).

> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/grep.c b/grep.c
> > @@ -1299,17 +1299,17 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
> >  static int match_line(struct grep_opt *opt, char *bol, char *eol,
> > -                     enum grep_context ctx, int collect_hits)
> > +                     regmatch_t *match, enum grep_context ctx,
> > +                     int collect_hits)
> >  {
> >         struct grep_pat *p;
> > -       regmatch_t match;
> >
> >         if (opt->extended)
> >                 return match_expr(opt, bol, eol, ctx, collect_hits);
>
> The new 'match' argument has no impact in the 'opt->extended' case.
> Perhaps this deserves calling out in the commit message.

I have noted this in the commit message, which I'll include in the next
re-roll.

Thanks,
Taylor
