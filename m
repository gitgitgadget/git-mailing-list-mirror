Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD331F424
	for <e@80x24.org>; Mon, 23 Apr 2018 01:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeDWBMs (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 21:12:48 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:46888 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDWBMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 21:12:47 -0400
Received: by mail-pg0-f52.google.com with SMTP id t12so7185121pgp.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 18:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EI4NKJPORk/cahe6mJHQZ5vC+GdLE+4ReD1AOvQSj1g=;
        b=iR44KWvABGRRUIo2CPeARSeioA8/a4rmtKRbJDZ8Qg7H0KMrcVDKq5WYQRk72Dl53J
         +/1cSeGue2dym/WQ6chZMjlmCgDkE/ftFjJBA3SACm/EtdRxr9OVNFDrD/A1G8AvbBkp
         xYFPM8qKt2/HrZXixktviQ6pzRGzvJaDC17d9YPy29ZjIQveqjE77CQE1mqKndYKRUW5
         f34FjeiUjL/VCVGbuBsxJgh8Mm4zB37OG0P5JusN7fpElT+nAEVDfkV2T3Rim0bu34IM
         QzbHcmSqr+HwYvMmRsiD6oj/rIc5G5e/zzzI8//vPWe867ppqFUgHw/pwHG8qsUTltWR
         Nvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EI4NKJPORk/cahe6mJHQZ5vC+GdLE+4ReD1AOvQSj1g=;
        b=PzqH5m3VR3V3I1TH/+Up+GoCzx1bz/QxSAuxiNh7MnZEtugtdixBtKGSLHALfNDwLW
         ROCHBfHqkkiM941OmoRUxy9lh/PM6Rt6Pt4svcj1KB1NJpcrC4gTEuxy8qd4c636FE89
         zub3DbzaW0FU1SM3Xp0Kdb1+xzuRG9IZEFvMRPBq6Anva38a8iLBx5RaNlTkRo4EPheN
         L5SE5nPr3p+rPV9Phdp/KMdA9FAZO3BpYHBWWgClK5+688kFxdfA7BzthO7THY5+YKUh
         6IvH2EOYTQb89XPYmbEcd4mPiENjezdC/14GvAjkgMLnttpzxxc+nV4PhyPuQa6o6Yep
         Jm5w==
X-Gm-Message-State: ALQs6tDnd4fpXZhG8PO8CAKxRz4GuECYEKYVqbKlNjzfWvXSKVtierSI
        nWYoGCxlUtslqwsA4Dm4nVecWA==
X-Google-Smtp-Source: AIpwx48PRZ+gFaGDpYJn6ShkehwNhIHfUzvz4oip/dnGRBBSyXY5Rx4H6gXCAZNMkBbLNfIukKgAow==
X-Received: by 10.99.64.3 with SMTP id n3mr15407239pga.13.1524445966697;
        Sun, 22 Apr 2018 18:12:46 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id 133sm19404101pfy.113.2018.04.22.18.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 18:12:45 -0700 (PDT)
Date:   Sun, 22 Apr 2018 18:12:44 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] grep.c: display column number of first match
Message-ID: <20180423011244.GB78148@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <4531659687de87b1bc143cb5cb364b691a58c6c9.1524429778.git.me@ttaylorr.com>
 <CAPig+cR0unM2uKcapHyAFrvMyPx4VgsW4wDswb_GNwE4EcYb8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cR0unM2uKcapHyAFrvMyPx4VgsW4wDswb_GNwE4EcYb8Q@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 08:24:55PM -0400, Eric Sunshine wrote:
> On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > Building upon our work in the previous commit to add members 'columnnum'
> > and 'color_columno' to 'grep_opt', we teach show_line() how to respect
> > those options.
> >
> > When requested, show_line() will display the column number of the first
> > match on a non-context line. show_line() differentiates between context
> > and non-context lines through the '&& cno' check. 'cno' will be equal to
> > zero if and only if show_line() is invoked on a context line. It will be
> > a non-zero value otherwise.
>
> This interpretation of 'cno' seems important enough to deserve an
> in-code comment. (And, you may be able to drop some of the same
> information from the commit message if it merely duplicates the
> in-code comment.)

Thanks, I agree that the interpretation of 'cno' is subtle and should
not require a 'git blame' to understand. I have adopted your proposed
commit structure [1] and moved this description from the patch message
into grep.c as a comment above the relevant conditional.

Thanks,
Taylor
