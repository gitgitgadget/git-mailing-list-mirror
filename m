Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC152C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B1061289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhEFVPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhEFVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:15:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9872C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 14:14:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n138so9819300lfa.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ba8WOD4Js99v+e+CPr4bN6OqZwagikeiiVbFzheg9wo=;
        b=NAJblHzgY2stjj4dTRJB+b8gCWHgcizHI8NtNyHKSq7xT6IEZU28W2/6GpbQnumXuL
         r9JPgPQ0e1MWnEJ6RLpEOaYWM6TyQD35OhizcEga6L+leo7cTY7RZ1Zp0hlqEcdx7CH+
         46Phx24EguV6zaWX7McXx+WNB8AAn8Myp6K9ndiimGOKpXdXRDdFREqKAlk2P+ZMm4/q
         ThLYl5/X/CO6c671e5QHMzMwTbUR4xDedcUNV7lzbcaJenMr7OSvjLQ/6BtcTh1CDLLx
         aiDqv+anhqYy2BiX2C73O7zy5+CTnrrHIgBzSLu4Yq1BydwWvVWWwdKYJH8v8uGEsE98
         s33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba8WOD4Js99v+e+CPr4bN6OqZwagikeiiVbFzheg9wo=;
        b=P6/CSadEHLS21CtJuEWXKtBcQSHkzWn+Zi2cEOPrWTeolKcwnqeWMgE7N9yA+L9zS+
         sxLoVjrIM3bYNw30oCJF/RE7ANr1LEMQQgRnNTK7csfUj7DighNqjqRFNLnrZvOSQiim
         /yI4qmt4Gm5ZPO/s+Ml+xIf0KxYyefxFJ7aNrKUlHyn/ZcyUVf81S31T/i6PUZ6IWN4t
         do4PDAj7oh2q6XMeSJ3JDjTBKZXm8VVv8qphJHBqBSHgbAMtBM3a1g2vIuBHjlY7mbMh
         Kpg3Z7DsOAzNQDk7fOslA4vQwk5r2kKAedBrqXycF/rkHUL3u/ltb1/XLHQqlMyThgrK
         +dqg==
X-Gm-Message-State: AOAM532Ik8M5DZKef2nlfxx3I5vPKHmI09sk3Q5j9oJLmbYGHv7fpaGW
        AXtulU23MLMyd3/f1MoUw7jIyG6h39PDL7HwE5ZuRA==
X-Google-Smtp-Source: ABdhPJxoWGPmAoSbzXCvoupqNW1tGuRGqMypVykVAjpbY4nftZJNhydtc6ZZdV9ud/XxdNhmpUeegw6e8ushG8KRB4s=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr4260342lfh.2.1620335674215;
 Thu, 06 May 2021 14:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <4f88ac58e46782c7cf335e13fabd14c8b4438267.1620329445.git.matheus.bernardino@usp.br>
 <YJRLim10cznG5G3d@coredump.intra.peff.net>
In-Reply-To: <YJRLim10cznG5G3d@coredump.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 6 May 2021 18:14:22 -0300
Message-ID: <CAHd-oW6oN7=8DwzEFmCXdSWRcvzpqGEKFDkTMzN3uP1M9Cphrg@mail.gmail.com>
Subject: Re: [PATCH] clean: remove unnecessary variable
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 5:03 PM Jeff King <peff@peff.net> wrote:
>
> Definitely not necessary, but on a patch like this I'll sometimes
> manually specify "-U4" (and I always have diff.interhunkcontext set to
> "1") to show the complete code between the declaration and use. It makes
> it even more obvious that the result is correct (though obviously
> applying and compiling shows it, too). #gitlifehacks

That's a good idea, thanks for the advice :)
