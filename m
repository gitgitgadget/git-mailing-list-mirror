Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCEB20357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbdGJQoq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:44:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34932 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbdGJQoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:44:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so15240235pfq.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kjw3Xv1kZbp0ML9jgCpMgDHGqdUB3cQ0v6xuWOX6/Ik=;
        b=sbJx4g5mftrZ/HACbUzSpY7jCb54ZdrD+qKX9fll1khg2+j004EO7V2IMESYo4Ih6g
         9P5VMl2o0cNZHjjLThdB2CAG74szxsADmvCCydGC9a/7N0shbEsLlI91dFYnITiRjG0t
         b5K//R58UpO5fDeMtVgqqHbTKSfJrhWexmuNT9henzwlYUohBGDLz3ZWdL+lD4kBWTFN
         SKekAPYFXAbbxlUMsY72z0k9AdEaKXoT/097NbrPirxEhYl19iinCQgNyJm4JizXjJ6c
         kQgvhvKDodXtmv4e8IISzdqGL5r38qcxYPMrOYAGkp0sw6n6Bf6mjJzXHKuetbVl39Tr
         MHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kjw3Xv1kZbp0ML9jgCpMgDHGqdUB3cQ0v6xuWOX6/Ik=;
        b=cDySLL5cKlQgpYBUyVNsMVNjEc7jQmblKtuR26O8SuPmR1Pv+aMtrGkGTbT8kcUPMJ
         jpqoMDUoAcdsqW/WWcEG6/b6TnfcCvYnkRq9AOluqpLHWJMhE7X+JSymqn6tObWDJ5Yo
         sxW2aFC/GzvqEwQaagWn6l5ihsoJl1Zd04GpmgTaT68LXM0It04eW0dBdf+EJguLRPdV
         iK89WUzVSNJ3jC8q+27fzpH9imDpnYly/XLXXYFRMDg7eM1qRbdGw4NYa8f89cvMbEUg
         cThaHMibyUByi8pi3RXiv/Dk1bYIELTIi6p7oWkOdfzmoID/G6j2Fp7jsHcS9INbz+yG
         Lmlw==
X-Gm-Message-State: AIVw112uJ1KJk+/MpKMLSBlMHm2wsDaqGKRl3RQs0VlxaTjtVX7iu77U
        SfWwhyK7xOk0CDMP+cA=
X-Received: by 10.98.198.208 with SMTP id x77mr46476213pfk.229.1499705085155;
        Mon, 10 Jul 2017 09:44:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id s64sm29339629pfd.77.2017.07.10.09.44.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 09:44:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 09:44:43 -0700
In-Reply-To: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 03:03:42 -0400")
Message-ID: <xmqqr2xo6y2s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> That way, we will see if there are people who need pre-C99 soon
>> enough, and we won't have to scramble reverting too many changes
>> when it happens.
>
> Neat idea. Something like this?

Yes, your log message said everything I wanted to say, including
possiblity that some compilers may have specific features without
supporting all of c99.

We accidentally started using "trailing comma at the end of enum
definition is allowed in c99", and we know it has been safe at least
for a cycle.  Credits goes to Brandon for 4538eef5 ("grep: add
submodules as a grep source type", 2016-12-16).

> -- >8 --
> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
>
> There are certain C99 features that might be nice to use in
> our code base, but we've hesitated to do so in order to
> avoid breaking compatibility with older compilers. But we
> don't actually know if people are even using pre-C99
> compilers these days.
>
> One way to figure that out is to introduce a very small use
> of a feature, and see if anybody complains. The strbuf code
> is a good place to do this for a few reasons:
>
>   - it always gets compiled, no matter which Makefile knobs
>     have been tweaked.
>
>   - it's very stable; this definition hasn't changed in a
>     long time and is not likely to (so if we have to revert,
>     it's unlikely to cause headaches)
>
> If this patch can survive a few releases without complaint,
> then we can feel more confident that designated initializers
> are widely supported by our user base.  It also is an
> indication that other C99 features may be supported, but not
> a guarantee (e.g., gcc had designated initializers before
> C99 existed).
>
> And if we do get complaints, then we'll have gained some
> data and we can easily revert this patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I suspected we could also do something with __STDC_VERSION__, though I
> wonder what compilers set it to when not in standards-compliant mode.
> gcc-6 claims C11 when no specific -std flag is given.
>
> And obviously before releasing this or anything similar, it would be
> nice to see results from people building pu. I'm especially curious
> whether MSVC would work with this (or if people even still use it, since
> Git for Windows is pretty mature?).
>
>  strbuf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 2075384e0..e705b94db 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -68,7 +68,7 @@ struct strbuf {
>  };
>  
>  extern char strbuf_slopbuf[];
> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>  
>  /**
>   * Life Cycle Functions
