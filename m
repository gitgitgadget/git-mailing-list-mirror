Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407991F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJUT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:19:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34189 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeJJUT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:19:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so5215675wrt.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VqM+eQhhhiKOiBuDesyv7eoamuNr3/zI8gk+SvHCjaQ=;
        b=CqMgb9ARcTiqF82w3dMosx5agb7VkqIJkpBVoO0nEZMcCBdNm/XYVcSHHyqZ7REBqY
         QYvLJyJ31tiu5O/cew3j6lxDVf48iwYCB5qiEouBmVuW/Z2Nv/v1GN/TCwHKJRlhZsXM
         EErjINBghEw+VxAnwSnF5/YLQ7idM3zsq1Wk8bT5kQRO6+yiIutVFJtOWzEetJF416nD
         ExL3x4qKqzUteeIdS9Oa/ZPoH/6LZHBRUljBN7MFC8iU0fNrCl+jyEEIc/kBV+yNOukO
         1m4UllQh0OMj16pQr1dTc3Vjov5RaMRb83htVFNJgzgEq+E65vI86IV/gWGQXnccvsyu
         Yd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VqM+eQhhhiKOiBuDesyv7eoamuNr3/zI8gk+SvHCjaQ=;
        b=Z0YAX0dwkALpPLZvnU1z3MWPX45chZOsUvW2j7WnUyyi5FYy1B4QQgMtDdrSE1wyHS
         VPzDA1Zfqi6JDctv0PNB0eBamqGvKTydm+2MK/1iu74al7cSjhrSFyXp9su+oy60aPAq
         /fZR0KStPGNOobYL3GEER0qFheWhQ2o7XBRU4Ou/I3z4OaOp+YahiBeH4TvqI1jft/N/
         y8/1tKLYkmT6Wb5ldP9RjB5e/shSBt/nEOf4l4ve98DAKQVQP52nX7C3Ak5Ix+BSQbvl
         mCitq7soISDjicOeznM5muN40VKbU8uBJylpHLMkEtyTk+T8EnvaEfWl2u4Jld1FC1WF
         QrMg==
X-Gm-Message-State: ABuFfog/ws6RtWIuB5wZOIdf8RQshcgZ6bEL03z8VW2fgeouHDJH/vMg
        RMyLH3Xof69uYmkL2xstqU+kLg49Z44=
X-Google-Smtp-Source: ACcGV602POA9WBPdfanxMfAnz7SLBKmjUX6ZLFdd6f3FowMF1HKfe5U7A+V7dvHTYPi1BiNU92rRag==
X-Received: by 2002:adf:e7cb:: with SMTP id e11-v6mr24212289wrn.27.1539176273237;
        Wed, 10 Oct 2018 05:57:53 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4700949wrp.42.2018.10.10.05.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:57:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] send-email: only consider lines containing @ or <> for automatic Cc'ing
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk> <20181010111351.5045-3-rv@rasmusvillemoes.dk>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010111351.5045-3-rv@rasmusvillemoes.dk>
Date:   Wed, 10 Oct 2018 14:57:51 +0200
Message-ID: <871s8yez74.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Rasmus Villemoes wrote:

> +			if ($c !~ /.+@.+|<.+>/) {
> +				printf("(body) Ignoring %s from line '%s'\n",
> +					$what, $_) unless $quiet;
> +				next;
> +			}
>  			push @cc, $c;
>  			printf(__("(body) Adding cc: %s from line '%s'\n"),
>  				$c, $_) unless $quiet;

There's a extract_valid_address() function in git-send-email already,
shouldn't this be:

    if (!extract_valid_address($c)) {
    [...]

Or is there a good reason not to use that function in this case?
