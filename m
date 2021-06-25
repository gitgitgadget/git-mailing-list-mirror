Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F781C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C4E6146B
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYVUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVUI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 17:20:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51227C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:17:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s23so12830104oiw.9
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EeQgj4eib9+muLutCY0L/f3azmtH/P+nxuTyax+03QE=;
        b=W5KAunKZtHJqwnd9ekk+oMYnXv2mgj/MSFNOB3MbvuoM5vzH9yQyYrRP9WiOw9hnou
         lT7J7/2hz0VE1d6CPjkonXp8ZetR5B8PSv/3OcL9FYf+rPFPdcRZ4wVYj5i4/OLVcH59
         9BksFqX22CmqyTdBKm1+2yuC3AB9W2KuQM10zLTTx/infgq0hPjTCHxxpnk0ATT0KIIA
         ak7KGzBtxgfpu33uv5cWYfwdGE9OOWBRtHvZiIyEDJ4vtBln9eJK+QE2dj77VKr/MoGe
         eLEVeXGV9FUD/6pqGuxAodRp6wG4/QrJcFzjNdVcjkBB2swVJtNdl/M70lMEqjZu4BPA
         DQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EeQgj4eib9+muLutCY0L/f3azmtH/P+nxuTyax+03QE=;
        b=sneO06Lz3FHxDghX/P41spYoTicM+mEYlM3R6YqeIg2Ml2D8sM6Z4U0G246CNCBlZ+
         KvUUO+HH3lgirscZN01KRujDXVmAyFJpdaSNLWcVf+bkmmWxsWwLcCPdD0nFRJZfJE9t
         /PdgaVBVLxdNqE/gjlLbnVM6N/pl0yZb5ezVkllUBfDBc2VXpP+I18hHbg0eJ6w41K1N
         9RU7y6NoNJrqywg7ASMcYwEQiHY+u3U2/1fLVajTw0wa+CIgOSbwIa9Q/YvpYc/MWISp
         6aX7lzWcue+aBt1rzZLBBaaqEL44LJ4KDL2I0x/EOLVeoYN7IOLsB4YPNiT/x5F2KZOZ
         HwKQ==
X-Gm-Message-State: AOAM533jDGZvyUBOIZ5ZxI1F7G8HXTzv8jrRFwYU71NK70uBnAy6CRFx
        BydhKlPOZROqNZb0/5qos4Y=
X-Google-Smtp-Source: ABdhPJwT4sRGWu3zN4+pgOY0SKD5dtk8hOx5yKlRqJ4yhDabScdjX4tKdzGW8b5Z8spv1B6tEfSWTQ==
X-Received: by 2002:aca:6743:: with SMTP id b3mr9829900oiy.8.1624655866550;
        Fri, 25 Jun 2021 14:17:46 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id bb34sm157828oob.39.2021.06.25.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:17:45 -0700 (PDT)
Date:   Fri, 25 Jun 2021 16:17:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60d647f8b427c_cc8d20877@natae.notmuch>
In-Reply-To: <YNSh0CskelTwuZq0@coredump.intra.peff.net>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Jun 24, 2021 at 03:16:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > This is probably all stuff that's been on list-before / known by
> > some/all people in the CC list, but in case not: I looked a bit into =
why
> > we'e so frequently re-linking and re compiling things these days,
> > slowing down e.g. "git rebase --exec=3D'make ...'".
> > =

> > These are all fixable issues, I haven't worked on them, just some not=
es
> > in case anyone has better ideas:
> =

> From a quick skim I didn't see anything wrong in your analysis or
> suggestions. I do kind of wonder if we are hitting a point of
> diminishing returns here. "make -j16" on my system takes ~175ms for a
> noop, and ~650ms if I have to regenerate version.h (it's something like=

> 2s total of CPU, but I have 8 cores).
> =

> I know I've probably got a nicer machine than many other folks. But at
> some point correctness and avoiding complexity in the Makefile become a=

> win over shaving off a second from compile times. You'd probably find
> lower hanging fruit in the test suite which could shave off tens of
> seconds. :)

That's not a good enough reason to not try to improve something.
In fact, it's a known fallacy called the fallacy of relative privation [1=
].

Also, your definition of "correctness" is not necessarily shared by
everyone.

I for one don't see what I'm gaining by running tests with
GIT_VERSION =3D 2.32.0.97.g949e814b27, and then 2.32.0.98.gcfb60a24d6.

What's wrong with GIT_VERSION =3D 2.33-dev?

Sure, I understand that some people might want to have a precise
version, but when I'm doing development I don't. Perhaps set a static
version when DEVELOPER=3D1?

[1] https://rationalwiki.org/wiki/Not_as_bad_as

-- =

Felipe Contreras=
