Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC08C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAFA224F9
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438831AbgLNWbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406303AbgLNWbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 17:31:03 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39456C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 14:30:23 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j20so12961222otq.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Le9wsIT6ELsiAbLIbQkVfN2BPH1cwblw7jpEW7sq34M=;
        b=EopX/vWgA15MAmXuVi0QKnbGP38Xk0qsVX+9BAz5Uq+EmyMcZa2lZVwozxEF77kY30
         LBS81r5i+v85wEGZ9/sxjO9er52Ulb4007RYLSRJT1n/UTMOUL+5FCp8/Dwd+UogqlGN
         kTIqr03danmAZx6XW+OBojnhWk08Uh6ieRhCg/11Mad9EcvYwl8u5+1gICP4R45eRpDR
         SxIBsyhVngoAeUVannlrGm1hV2pzFovwV2vNhpUIi6wfu2j2ja5erZjfGu3f3QBsUAUW
         Q33Iv1v5M3Ug05CqIH/u4GSXVbdI5pFHhfHOorbYYZqdSW+08GWai/B5zwSIvMwQU//N
         EEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Le9wsIT6ELsiAbLIbQkVfN2BPH1cwblw7jpEW7sq34M=;
        b=EoshGjp2JXHJQcLdC5EUhS1UNbuuLGGvmFZWVbFXv9L7OwrgMAPnlvxEXs2Bqae+Ep
         uBUxCnp1gmCYFhHwxcs3a9wZmW+qzG1XEnekc5X5/RzXiHteqHwOoD8JIQfyM8JjWlmv
         stV0cywxmf10vHDW7acrJygs57G1svIYt0fDlnnioRLpeU6THRG2XqBulHTdn0HdbE+M
         bdTwqncZ0jlM6FjpSFA2m1p3Q1e+oLpcJ041xc6lKa0zQtCtG6rPHPv5oKvkZT1+rinb
         MKomYCmRFuWdUavRPR0oQEMY20rNwkqGWmMVywa023VVGal3qZZGJJe1K3suimRkpW6o
         xwzA==
X-Gm-Message-State: AOAM530rFSmHktqAuZt4uulaWfser2qf1wAWgCkk4MDjtvshit5xJJAa
        7pnJ64ZpAYXSOqiSzF67d03FedxUQlvlNA==
X-Google-Smtp-Source: ABdhPJw5XMwi15EyxGsz018ZW5WmA9LkvGeuhm1eJ3IEUgbDz6EqySvzi1vMW72VIFtl5dbWmdMcjg==
X-Received: by 2002:a9d:1b01:: with SMTP id l1mr8226907otl.295.1607985022609;
        Mon, 14 Dec 2020 14:30:22 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l134sm3908947oig.25.2020.12.14.14.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:30:21 -0800 (PST)
Date:   Mon, 14 Dec 2020 16:30:20 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Message-ID: <5fd7e77c78e06_d59852083e@natae.notmuch>
In-Reply-To: <xmqqh7ooje03.fsf@gitster.c.googlers.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com>
 <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
 <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
 <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
 <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
 <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
 <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
 <CAMP44s3CcNAT4dFogyo61zV+D1pZ-0K+1rDBk_BUk-RYVUW0RQ@mail.gmail.com>
 <xmqqh7ooje03.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > This is irrelevant.
> 
> Oh, now you are saying that you do not need a way to squelch these
> message to help unconfigured users choose between rebase or merge?
> I am confused.

We need a way to squelch the *advise* message, yes.

But this is a secondary priority. The first priority is not to break
current behavior users rely on.

> > As long as it's an error I don't care if it's short or long. I'm
> > against turning on an error from one version to the next.
> 
> Now you are changing your mind?  Current version and past ones do
> not make it an error to pull non-ff history without choosing rebase
> or merge---we go ahead and merge anyway.  I thought that in the far
> future agreed between two of us, it would be turnend into an error
> at some point.  There needs one version that turns it into an error
> for that to happen.  Puzzled.

Yes, in the future, *after* a deprecation period.

Once the users have had a chance to configure git to do what they want,
have tried the new mode, haven't had issues with the new mode, or if
they disagree with the proposed *future* behavior; complain in the
forums at their disposal.

Not before.

> >> I too initially thought that pull.mode may be needed, but probably I
> >> was wrong.  I do think this can be done without pull.mode at all, at
> >> least in two ways, without adding different ways to do the same
> >> thing.
> >>
> >>  - When pull.rebase is set to 'no' and pull.ff is set to 'only',
> >>    "git pull" that sees a non-ff history should error out safely.
> >>    The user is telling that their preference is to merge, but the
> >>    difference between merge and rebase does not really matter
> >>    because pull.ff=only would mean we forbid merges of non-ff
> >>    history anyway.  The message you'd get would be "fatal: Not
> >>    possible to fast-forward, aborting." though.
> >>
> >>  - Or with the advice that hides the latter two points, a user can
> >>    unset pull.rebase and set the advice.pullNonFF to false to get
> >>    the same behaviour (i.e. disable the more dangerous half of
> >>    "pull") with just the "we stopped" error message.
> >
> > So, after your hypothetical patch, there would be no difference between:
> >
> >   git -c pull.rebase=no -c pull.ff=only pull
> >
> > and:
> >
> >   git -c advice.pullnonff=false pull
> >
> > ?
> 
> We do not have to or implement both, but either should give us the
> "when pull sees a non-ff history, it should stop without merging or
> rebasing, and the user won't be given the advice on how to choose
> between merge and rebase" behaviour, I would think.

Right, so both should error out.

And what should these do?

  git -c pull.rebase=no -c pull.ff=only pull --merge

  git -c advice.pullnonff=false pull --merge

I'm going to answer because I think it's obvious what you would expect:
if you pass --merge, both should succeed.

Except they won't, because "git pull --ff-only --merge" fails.

Correct?

> >> I think either of these are close enough to what you want, and I
> >> think the latter gives us more flexibility in how we tone down the
> >> message with advice.pullNonFF.
> >
> > You are missing at least two things.
> 
> I am guessing that the '?' above I just answered is one you wanted
> to ask me, but what's the other one?

Yes. The other is what I explained above; we need a grace deprecation
period where we can explain to the user in a simple way what to expect
in the future.

And it's much easier to explain to the user that:

  git pull --merge -> pull.mode = merge
  git pull --rebase -> pull.mode = rebase
  git pull -> pull.mode = fast-forward

Than:

  git pull --merge -> pull.rebase = false
  git pull --rebase -> pull.rebase = true
  git pull -> pull.rebase = false + pull.ff = only

But those are not the only two. For example there's this additional
problem of how to interact with the other values of pull.rebase (other
than true and false):

  pull.mode = merge
  pull.rebase = merges

I would expect in this particular configuration that:

  git pull -> git pull --merge
  git pull --rebase -> git pull --rebase=merges

There's no way to represent that with just pull.rebase.

And there's more: some people suggested other modes in 2013, like
"pull.mode=none" (essentially "git fetch"), or
"pull.mode=merge-reverse-parents".

But the first one should be enough ("git pull --ff-only --merge" doesn't
work).

Cheers.

-- 
Felipe Contreras
