Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B2C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBEC20637
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fxwvqyqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCUSvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:51:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39319 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUSvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:51:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id a2so10095370ljk.6
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku+gM9SwqahpZUSBCyPA+hTd5++Q8qHxdKdWQR+kJuo=;
        b=fxwvqyqjH6M1ljEKdBr/6jl30butgwbR+reYfw+ndqgLsk4NygMRrFS07iaMIkKJWX
         iv1hh0pKALrB9KFJWxrQAeOEAVEswYuMR7v5Bya7y2ItDPsSDn9xF4w5+kYOndYtLNNg
         uAavOD62C3kSgecDamdXjH11+FosyTlLHjmrDvIuO3SrRj/0o+brqQb8PSj4Ov+GmmFF
         o9o5vj3N23QuST7i2PYH4Py618lLQg6E9V2YiP5eJFNyR6UF9GoA/BqOvUVEILx0mKre
         YxgLqKfbaTPUr02S/eEhsU6K84z3dUJ3/d/A4WcSrE3n4KXrc8QqmzTOHVFReJb9AKJM
         2Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku+gM9SwqahpZUSBCyPA+hTd5++Q8qHxdKdWQR+kJuo=;
        b=DSjBhYoAkXOclwFKkkjBCXzTDRfXG8RKyZ1TE+5rZ6cGTNBpdlCOlS1BsRyJMwFb2p
         xVAckzEF1uEbaj+k66SxC3U0T6ndIrLE4AmAu4uyEh9hhWDWNc7s0MPtkS/G/XL0XOXw
         myHDNt3PFTztAGzuwnFdwEkRjX90UVeSjuIZVHDKZb+5X3Ofp77LoiDNX7ctMibdpKs8
         OVzbUXxu3qB73DHyr4ajNfJvxEnE/nLlYxVeDM4Fwk4kJti+HrJbBlbyIeWh3d4I6jhy
         CwQ59IT+Xg2UGsinA1n16cH8mNUNVJQE5j0P0HU6d9nDqhvzUg//HHeYTTk35NsAyNPS
         xvJQ==
X-Gm-Message-State: ANhLgQ157MLAdnZjMafsPAH8v2AY/+rvAoSPK86Wpi9rS/7QY6AkNRvT
        PTslNzITS8VIFeSd/uj+C9OBv6tpGyF5nphc5T5Dvw==
X-Google-Smtp-Source: ADFU+vtwxUvYP65oEchvS3Q3PhVtLOFzdTv5gmzebQ2d7UZrRthtiFDE8MA8MfJfr7bkHY94exU1WCDTe32EqeTw0Zo=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr9389829ljl.223.1584816666515;
 Sat, 21 Mar 2020 11:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
 <20200321062611.GA1441446@coredump.intra.peff.net>
In-Reply-To: <20200321062611.GA1441446@coredump.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 21 Mar 2020 15:50:55 -0300
Message-ID: <CAHd-oW4cGEwyge+BPRGiOsmMxr5ne9Ufk-BOM4EgG_i6qTxxMg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 3:26 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Mar 21, 2020 at 12:07:05AM -0300, Matheus Tavares wrote:
>
> > In cases like this, CLIs usually allow the short options to be stacked
> > in a single argument, for convenience and agility. Let's add this
> > feature to test-lib, allowing the above command to be run as:
>
> Most getopt implementations I've seen call this "bundling" rather than
> "stacking" (I don't care too much either way, but Junio mentioned being
> confused at the name).

Yeah, "stacking" wasn't the best word choice. I will replace it by
"bundling" then, thanks.

>
> > +     case "$opt" in
> > +     --*)
> > +             parse_option "$opt" ;;
> > +     -?*)
> > +             # stacked short options must be fed separately to parse_option
> > +             for c in $(echo "${opt#-}" | sed 's/./& /g')
> > +             do
> > +                     parse_option "-$c"
> > +             done
>
> I wondered if we could do this without the extra process. This works:
>
>   opt=${opt#-}
>   while test -n "$opt"
>   do
>         extra=${opt#?}
>         this=${opt%$extra}
>         opt=$extra
>         parse_option "-$this"
>   done
>
> It's a little convoluted. I'm not sure if saving a process per unbundled
> short option is worth it.

I quite liked this alternative with builtins. It's a little more
verbose, but it remains very clear.

> What happens to bundled short options with arguments? I think "-r" is
> the only one. We don't allow "stuck" short options like "-r5", so we
> don't have to worry about feeding non-option bits to parse_option(). It
> looks like we'd only examine $store_arg_to outside of the short-option
> loop, so we'd treat:
>
>   ./t1234-foo.sh -vrix 5
>
> the same as:
>
>   ./t1234-foo.sh -v -r 5 -i -x

Yes. I just thought, though, that if another "short option with
arguments" gets added in the future, the bundle would not work
correctly. I don't think we need to be prepared for such a scenario
now, but ...

> which seems reasonable. But:
>
>   ./t1234-foo.sh -rr 5 6
>
> would get garbled.

... we could prohibit using more than one "short option with
arguments" in the same bundle. This would not only solve the problem
for "-rr 5 6"[1] but also for the scenario of future new options. And
it's quite simple to implement, we just have to check whether
$store_arg_to is set before setting it to another value. I'll try that
for v2.

[1]: Someone that used '-rr 5 6' might have wanted the script to run
*both* tests 5 and 6. But I don't think we need to support that now,
since '-r 5 -r 6' doesn't do that as well (instead, the last value
overrides all previous ones).
