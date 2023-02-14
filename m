Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C465C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBNQ3a convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 11:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNQ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 11:29:28 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D085267
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:29:27 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id b1so10540963pft.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axAHFFDUeEksceSlHbBUxYEsJQXYF4w26kExcl+EEAs=;
        b=qefwvz/tzcgUg8sxztZZttlCrioTREdAgTf9AkMuCo3IsRSzPZHMBZytfLZww2YAlk
         ejbZ6hXp0adj6wA5Ad65ED0GLKwJKBWpFcQvQyn2R4YacmZp1jjMZvtJHpMS5M1WN9yY
         Em6zb34s4F4oeuFv36O1kXzIVooFFIUsXnSf8A7O5uQ16qL/TAeSQN1cuIjAXrUWGRiB
         1uM9OaH2pPK+4EycJjrV4m1eKqVDUHA8dvPElgFE2nKj58WN8dJt5SJQr8sfUaVwZVnL
         pdrkg2iY+7MJJp4/YE7nVwip6vaxC14WsTKBHDXjmo48wX0IpKX0o226FZZBbUuXxYz3
         octw==
X-Gm-Message-State: AO0yUKUXKMBgH/7jmOIiS5dQXeS3kQ8RfrjMoz+2yMlFbfGSFYKeiWQN
        5iBs/21HSCG8f4ervEaxn9OJDisbYrOrUMVhGL4=
X-Google-Smtp-Source: AK7set9vnuDQmLmm6fICztOkRkaiTfM8UV+VOIHDDPzVd1HJjs0jmMbES+BP67iWQeSUdb+DzHtrWaefrgEU6/nRxVw=
X-Received: by 2002:a63:3809:0:b0:4eb:ee7f:baa2 with SMTP id
 f9-20020a633809000000b004ebee7fbaa2mr399202pga.65.1676392167061; Tue, 14 Feb
 2023 08:29:27 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net> <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g> <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g> <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
 <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
In-Reply-To: <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 11:29:15 -0500
Message-ID: <CAPig+cTH1hUTSN+TRCo9brGMosEW-OWV0JVBATK+moB0EZec3w@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 11:01 AM Jeff King <peff@peff.net> wrote:
> On Tue, Feb 14, 2023 at 01:55:32AM -0500, Eric Sunshine wrote:
> > On Tue, Feb 14, 2023 at 1:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > > Using (presumably) valid LANG codes results in the buggy truncated
> > > > output, but "LANG=C" produces the correct result:
> > > >
> > > >   $ for i in C en_US fr_FR de_DE ru_RU zh_CN; do printf "$i: " &&
> > > > LANG=$i.UTF-8 git symbolic-ref --short HEAD; done
> > > >   C: 测试-加-增加-加-增加
> > > >   en_US: 测试-?

Imadummy. The example loop incorrectly uses LANG=C.UTF-8 rather than
LANG=C for the first item. However, LANG=C does indeed result in the
correct output:

  $ LANG=C git symbolic-ref --short HEAD
  测试-加-增加-加-增加

> >   $ LANG=bogus git symbolic-ref --short HEAD
> >   测试-加-增加-加-增加
>
> Oof. So it is some weird locale thing that scanf is doing. I don't even
> want to think about what the details could be. ;)
>
> Since scanf is such a bad and error-prone interface in the first place
> (and I'd actually like to put it on the banned list), what about just
> parsing manually here? We are already implicitly assuming that each
> rev-parse rule has a single "%.*s" in it. Armed with that knowledge,
> it's not too hard to match using skip_prefix() and strip_suffix(). Or
> with a little bit more custom code, we can avoid the step to pre-process
> the rule strings completely. Something like:
>
> +/*
> + * Check that the string refname matches a rule of the form
> + * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
> + * "foo/%.*s/baz", and return the string "bar".
> + */
> +static char *match_parse_rule(const char *refname, const char *rule)

Yes, this works nicely and fixes the reported problem:

  % $GIT_DIR/bin-wrappers/git symbolic-ref --short HEAD
  测试-加-增加-加-增加

I'm all for this approach. Fewer scanf()'s, the better.

The new code itself looks correct; I think it properly covers all the
edge-cases (at least those that came to my mind).
