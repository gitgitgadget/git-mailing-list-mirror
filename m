Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7EA1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967807AbdDSVXM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 17:23:12 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36311 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967718AbdDSVXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 17:23:09 -0400
Received: by mail-lf0-f51.google.com with SMTP id c80so19119554lfh.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vAU1JEqNf2ypb2Z5pAX7i+gdshiwn8eodcVwizOhtpw=;
        b=atZrwK2lG3yqQ5svY3EGGSOmkM7qxjbtYFWLwbjLj4e/vlwqu8TUX2HW3LB88KGgMW
         DMEVzzpyjRcVEJXwxf+KL/ZuwV9fLPlB3/XOyWinqmy3Ir3/BWjqh0U6UbKviGYAYLLG
         HPrdX1jbcXYGwhozZGpg+UEzUimzVBKFBOky/H2ItsJgEVU/FHSFnt3474CYb3P6Q9f+
         sUD1pEsNFta08bJ2cnPufkhVW/WUurZ0TyMmfbpQLvINIwReWJZYyO1o83rDpilhhHuS
         9qK5+ewZeICMQvYosXNZeso3+S+5lWhPq96sQXTxp0kY5qvBvjpFxRmZO4wFLlejNFKQ
         Re+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vAU1JEqNf2ypb2Z5pAX7i+gdshiwn8eodcVwizOhtpw=;
        b=dgez94d+fKbDxzEYjZSExo+vowvaIGUgf/JG8TnZ32NOOkW45hp1xk77YfvGXD7BNG
         cjx8YxR1b0uOeX3YyqQykhdZflmgV/V+VW0rNAH9FdOjc6ls6qckroJSpZar7D79DG8D
         Et7sJPGr1JkJYgJblcD6BVm1qHm29T6Qf2VFVpQfcN3IxgMV4JcNX2i3x2/Qvq7LFf7j
         kVk7B+2cH5kAi63Kb9BG5Unt7WEM66Zg5P23WOo5SsP3xbx1k5Wq09mE6w+P2/reSlpf
         o1Xwx62eHFQDekV9mJWg1C4KbsYECu1fHRdAy/Xwd71e+2qWHn9h4Pji43cJfoUZ93J7
         SjJg==
X-Gm-Message-State: AN3rC/4CUK5dFuK2+5EUnA/iEteZf9AVYTji03WBwKzQjyTOx5lWo03e
        2fvycteNNOC8sn/TeutKgNWd9WYYRw==
X-Received: by 10.46.22.4 with SMTP id w4mr1650683ljd.123.1492636987977; Wed,
 19 Apr 2017 14:23:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Wed, 19 Apr 2017 14:22:47 -0700 (PDT)
In-Reply-To: <20170419210028.sky24qda7kp4pl5y@sigill.intra.peff.net>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
 <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net> <CA+P7+xqo6BJ8LXy8EVvq0JXPD4r-jZ6boOGT=2XY8SVnWfVMcQ@mail.gmail.com>
 <20170419210028.sky24qda7kp4pl5y@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Apr 2017 14:22:47 -0700
Message-ID: <CA+P7+xpahRim9H1cHuHmzjGggYt2qbvxrDYyi+ri0QsDEUAkcw@mail.gmail.com>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 2:00 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 19, 2017 at 01:54:06PM -0700, Jacob Keller wrote:
>
>> This is why it's an RFC. I don't really feel that it's too much of a
>> problem. As for the reason why I thought it might want a flag itself
>> is because of concerns raised earlier that we might have something
>> liek
>>
>> OPT_BOOL( ... "no-stage" ...)
>> OPT_INT(... "stage" ....)
>>
>> or something already which might be broken and the only proper way to
>> disable no-stage is no-no-stage?
>>
>> Is this actually a concern? I thought this was a comment raised by you
>> earlier as an objection to a change unless we specifically flagged
>> them as OPT_NEGBOOL()
>
> I think the breakage in that case would be caused by "--no-stage" taking
> over "--stage" as well. And your patch doesn't change that; it happened
> already in 2012.
>
> Your patch only affects the --no-no- form, which I think we would never
> want. I don't think it needs callers to trigger it explicitly.
>
> -Peff

Right, I was just thinking in the weird cause were we *do* have a
"no-option" that does want the "no-no-option" to negate it. Maybe this
isn't ever a thing and we don't need to worry at all..?

Thanks,
Jake
