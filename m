Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBAB420958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbdCWUGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:06:07 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32935 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbdCWUGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:06:06 -0400
Received: by mail-vk0-f42.google.com with SMTP id d188so153194401vka.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qS9UWVws/rQohKZthnZWATfs/zDnxQ0BbFhcB0yPdVI=;
        b=DWROkbPtg/XQOckgvgZUR0a1yM+Iw21wzBAWT8BFqBkUb9sdfdTJHNrdSHrn9qru1u
         dQHesOH9gs9gO/UlSKB+YSqn8dK6n2jvMZ1y7LhAmD7/27CvD8iWJsVDozUD6+XUT22U
         dXA4OMNLrGnN5H7z2ritukriRm60ATd90WivvOEkUjZ6Ir0/rD4aFrVbLFGghwQ4fwE4
         Wgb0PQbOZGDhtkd5U7E6cV9dv6uoxlEcUEL6TZQDD1I0vcdGMiZjMdz3clEN0wUpKxa1
         4sNWQuGTKPvBc7fbXVQTE2greVAR88uugG2E+KQgee9sYV15bH5fimKAECAGAjt60rMJ
         cGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qS9UWVws/rQohKZthnZWATfs/zDnxQ0BbFhcB0yPdVI=;
        b=OvRQ4zrNjq3QOS+sSrwaV+Dzr4Fvy/A6kLc/vY7qs4edOrbNwfTLGH4DCGnNF5Suhk
         EDVEikXB53wt/H/KXp4S/e6Nc6ZbaxWM+973zKDbPbX5kT9H8AxW2/3aAhu1GFA3miA0
         zAzxj7gQDk5stjhkYFJIvJLQnp7OLyINBRci+HntXH4RmCb3KpvU9+xF1mG6LYNUZv2Z
         2pwvRHJoy4xL+Z9FW8mzYDarRgMku0AbVFzL/UXsS6YlfQcXCOYFHtLg6zN8RIAUq+gk
         8GERn7EvvBTdmPUe+BpLI1b8MhCzOQ6bPgDj4V8Xg7rFphyVThGCX7AtOBFc9S+dpi0J
         swTg==
X-Gm-Message-State: AFeK/H19yFB4TRFm2mhG/xxD86ZYpuIWBlGMwPouGHh/uanrKmK8Nutpip49UPMmO+twQqaJA+snbPTnLKgejA==
X-Received: by 10.31.220.196 with SMTP id t187mr2076938vkg.44.1490299564758;
 Thu, 23 Mar 2017 13:06:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.150 with HTTP; Thu, 23 Mar 2017 13:06:04 -0700 (PDT)
In-Reply-To: <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
References: <20170323155012.6148-1-szeder.dev@gmail.com> <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
 <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net> <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
 <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 23 Mar 2017 21:06:04 +0100
Message-ID: <CAM0VKjkAMrePks4JikNvzs_v71YFidKF7yj0aNVugZ-nzx1kig@mail.gmail.com>
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 8:39 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 23, 2017 at 12:33:06PM -0700, Junio C Hamano wrote:
>
>> >> Nice, but why add the "if" when it's doing nothing?
>> >
>> > It's short-circuiting in the conditional.
>>
>> I think Ren=C3=A9 meant this:
>>
>>      /* just for side effects */
>>      skip_prefix(name, "refs/heads/", &name) ||
>>      skip_prefix(name, "refs/tags/", &name) ||
>>      skip_prefix(name, "refs/remotes/", &name);
>>
>>      return name;

That was my first version indeed.  Unfortunately:

> And it causes the compiler to complain that the value is not used.

Exactly.  So that 'if' was a way to shut up the compiler complaining
about the unused result of the ||-chain.  Perhaps not the best way to
do that, but I couldn't come up with any better.

I had a note about it attached to the commit, but then run
'format-patch' without '--notes'...  oh, well.
I guess I should have wrote that in the commit message to begin with,
shouldn't I?  Or in an in-code comment.
