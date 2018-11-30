Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7686E211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 09:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeK3Ukk (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 15:40:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33626 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3Ukj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 15:40:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so5214180qtp.0
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 01:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhqmiGPv4E9QmD3qv6HcwW7KAsV09pT1ceHVLqiPTg4=;
        b=RwZQWDWoMF9y3D0iSoTI/DKRsZ2pwohf+yGMV3Bw21fO9+wiv3cfRLeXnhPIp9Gfr8
         yUXTs+zvOKYX3ivqzIaMaeh9ItvWYJRFdvWMut2AYUmj5mPm4DVuv5Jrvj3ok3wVZNLb
         C6k2+i3wWc/jQKLayLsjsk4UyzLniNAvKKYYboopoWo//kG2P5SBurCA4Kinbj/ol0uU
         pFjKU+AY9CrFPdPe3MY7nvRIiziH094sEU4YLeKwKznzuvvfSgzV/ScwIesLyZIJDzCC
         raHzFUdb90cwomW38/nrE0e1Sn9B/irYVI71NcBV2AsDHMXsqTYDbUE8Ri1Q1W+t01UF
         EFAw==
X-Gm-Message-State: AA+aEWYLtC5rbCX7uqIvAvKSwN0d8y+4WJBcrRf/XSQN8HUORrdJogJc
        EZ8oaMQfKgufgEo9t+uJ9z1stKMWUo6Saciap4A=
X-Google-Smtp-Source: AFSGD/XJYqw0/IupyKQ/Y/qnTp0Vqvkh9tUcTksKUn4XGCgOL4HYDDzKEHhGfTqDfKGWcvpxEsXH46jURstt0KXB7xE=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr4806068qve.203.1543570317971;
 Fri, 30 Nov 2018 01:31:57 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com>
 <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet> <871s74yms3.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com>
 <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com> <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Nov 2018 04:31:46 -0500
Message-ID: <CAPig+cS4peHDOz0cK7RJEHb6ch0+czvau_aGTD1j6xM23G0-pQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: do not let its diff-options affect
 --range-diff (was Re: [PATCH 2/2] format-patch: allow for independent diff &
 range-diff options)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 11:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > In any case, I tend to agree with the conclusion in the downthread
> > by Dscho that we should just clearly mark that invocations of the
> > "format-patch --range-diff" command with additional diff options is
> > an experimental feature that may not do anything sensible in the
> > upcoming release, and declare that the UI to pass diff options to
> > affect only the range-diff part may later be invented.  IOW, I am
> > coming a bit stronger than Dscho's suggestion in that we should not
> > even pretend that we aimed to make the options used for range-diff
> > customizable when driven from format-patch in the upcoming release,
> > or aimed to make --range-diff option compatible with other diff
> > options given to the format-patch command.

I agree that this way forward makes sense. It's clear that I
overlooked how there could be unexpected interactions from passing
git-format-patch's own diff_options to show_range_diff(), so taking
time to think it through without the pressure of a looming release is
preferable to rushing out some "fixes".

> So how about doing this on top of 'master' instead?  As this leaks
> *no* information wrt how range-diff machinery should behave from the
> format-patch side by not passing any diffopt, as long as the new
> code I added to show_range_diff() comes up with a reasonable default
> diffopts (for which I really would appreciate extra sets of eyes to
> make sure), this change by definition cannot be wrong (famous last
> words).

I, myself, was going to suggest this approach of leaking none of the
git-format-patch's options into range_diff(), so I think it is a good
one. Later, we can selectively pass certain _sensible_ options into
show_range_diff() once we figure out the correct UI (for instance,
--range-diff-opts=nopatch,creation-factor:60).

A couple comments on the patch itself...

> diff --git a/range-diff.c b/range-diff.c
> @@ -460,7 +460,11 @@ int show_range_diff(const char *range1, const char *range2,
> -               memcpy(&opts, diffopt, sizeof(opts));
> +               if (diffopt)
> +                       memcpy(&opts, diffopt, sizeof(opts));
> +               else
> +                       repo_diff_setup(the_repository, &opts);

The first attempt at adding --range-diff to git-format-patch invoked
the git-range-diff command, so no diff_options were passed at all.
After Dscho libified the range-diff machinery in one of his major
re-rolls, I took advantage of that to avoid the subprocess invocation.
Another benefit of calling show_range_diff() directly is that when
"git format-patch --stdout --range-diff=..." is sent to the terminal,
the range-diff gets colored output for free. I'm pleased to see that
that still works after this change.

> diff --git a/range-diff.h b/range-diff.h
> @@ -5,6 +5,11 @@
> +/*
> + * Compare series of commmits in RANGE1 and RANGE2, and emit to the
> + * standard output.  NULL can be passed to DIFFOPT to use the built-in
> + * default.
> + */

It is more correct to say that the range-diff is emitted to
diffopt->file (which may be stdout).

Thanks for working on this.
