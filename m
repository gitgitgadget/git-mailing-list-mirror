Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A06C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A0F6139A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbhESLUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbhESLUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:20:35 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2EC061761
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:19:15 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c196so4590706oib.9
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q+5NDRKveoVrbIcn6An+VwW7KBvzhSoABUULijXLEh8=;
        b=rST3icgNmOX7t7JifOXYDCF9EApiedLikYiYRYYPPy04RFN1wxN1AYzCTs0ZjHBVy8
         s04dP2iQJIrFANSTD/PK1GqKIPt15LFxwBcLG1jNjW/liUYkYJOwENp8yJk3Rp28Wq/m
         Jf2F8caUpU2qzoE0yBjbkSJqi+Kp8IifjCQv1zQ+4z8h2zsX1SZq8dVPpqbO53hX5ybY
         8mLoBTPKpr6uyA4hxwA5gZBIiVLKmuyjlATFy6l3fNH72bd8nMlfolm4CR0HHFpmoBzP
         U24B02tcrcxK7KqJxvKeQQDuqzMzgorvisIhPOAx8tqXUm7jit/Qw+pfjWEBD/CsQ5QU
         4IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q+5NDRKveoVrbIcn6An+VwW7KBvzhSoABUULijXLEh8=;
        b=SLBFBd+yZsT9PUN2oAF3tytw0VGcol+Z2J9utbVP29TBpR+aqpkW9MePfDffhAbwfV
         aNqKMdqs83fvqOma0zq5POs11bTXOtgaHCh/HvF0V1bfkm2Nd9S3Jhdk2x5ernRaQ0sC
         8BZcRBNQndYvc4iMZ5rgGspFI4WG43f/2b5c/NtCJkG3ZtwKI5AYMXjHRcoljdvdOqDb
         aOGxKC3ZQ2lajkcghn+5Kznid+FXxudTKYU8/6WWM4elLrCmco/T0jdhykIGVgRddRWS
         T4rrEkNv8OGqZdrqSAjYWv7fk1I4w9qMDJYuEGag/RAq7k/BTXTXa4zAoEOopLKTq8j0
         Bk/Q==
X-Gm-Message-State: AOAM532bZbki6m2GPk7EzUsdl7w9VtDmEmOx2Fx2di0oZhxmyClkVjPp
        D3PlU4MLVqnSS7RTkLq2CWuKKJxzOnl2fA==
X-Google-Smtp-Source: ABdhPJznGkt6GyV6kypL+jRua4nK6136rfXym60IG5PWMHGGFOauIniuZCNCC75+OLdsjlDOc7XAiw==
X-Received: by 2002:aca:3ec6:: with SMTP id l189mr7704451oia.8.1621423154863;
        Wed, 19 May 2021 04:19:14 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p3sm280620oov.2.2021.05.19.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:19:14 -0700 (PDT)
Date:   Wed, 19 May 2021 06:19:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a4f4312264f_86a82089b@natae.notmuch>
In-Reply-To: <87im3fqci9.fsf@evledraar.gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Tue, May 18 2021, brian m. carlson wrote:
> =

> > [[PGP Signed Part:Undecided]]
> > On 2021-05-18 at 03:22:37, Felipe Contreras wrote:
> >> brian m. carlson wrote:
> >> > I think we should let the user decide whether they want to set thi=
s
> >> > feature themselves instead of setting it for them.  For example, I=
 have
> >> > specific colors set up with these environment variables, and I'd l=
ike
> >> > Git to honor them without having to configure Git independently of=
 less.
> >> > I expect other users will expect Git's rendering of the manual pag=
es to
> >> > work like other instances of man(1) on their system as well.
> >> =

> >> It does respect them.
> >> =

> >> This would render the man page with the color specified in the
> >> environment, not the default of git.
> >> =

> >>   LESS_TERMCAP_md=3D$'\e[1;33m' LESS_TERMCAP_me=3D$'\e[m' git help g=
it
> >
> > It still doesn't work like other instances of man(1) on the system.
> > While you claimed that "that's a preference others don't share", I'm
> > pretty certain that I'm not the only person who feels this way.
> >
> > There's a big difference between Git coloring a Git UI, like a diff, =
and
> > Git coloring a separate program that already has sensible, standard
> > defaults.  A user who has not configured any color settings would
> > probably not want Git to render manual pages one way, cargo to render=

> > manual pages a second way, and still other programs to render manual
> > pages in other, incompatible ways.  We need to consider not only the
> > impact that our decisions have in a vacuum, but what results similar
> > decisions from other projects would produce in the software ecosystem=
 as
> > a whole.
> >
> > Would you consider various projects coloring their respective manual
> > pages differently to be a desirable state of affairs?
> =

> I think it's an important distinction that we're not coloring any manua=
l
> pages,

But we *are* coloring man pages. The docbook stylesheets format links as
blue.

Try this:

  GROFF_SGR=3D1 man git

> Right now our documentation seems to suggest that we won't do any such
> magic, but you can also set man.viewer to e.g. invoke a web browser or
> something instead of man(1).
> =

> I don't think it's confusing in that context if we learn to do some "ma=
n
> with fancy on top" in this mode.

But man already does fancy stuff.

You can open a browser:

  man -Hchromium git

You display some shitty X viewer:

  man -X git

You can send the man page to a printer, or generate a DVI file.

The pager mode in man is also just one of many modes.

I think most people have not read man man.

> I'm not running the patch in this thread currently, but I'm running wit=
h
> Felipe's earlier man alias noted in the other thread. So I see how
> losing the underline would be confusing.

But in my patch you don't lose the underline.

The function version I sent was an updated version of something I've
been using for a long time. But I did more effort in the version for
wide consumption, and the underline is preserved.

This is the equivalent of my latest patch:

  man () {
    GROFF_NO_SGR=3D1 \
    LESS_TERMCAP_md=3D$'\e[1;31m' \
    LESS_TERMCAP_me=3D$'\e[m' \
    LESS_TERMCAP_us=3D$'\e[1;34m\e[4m' \
    LESS_TERMCAP_ue=3D$'\e[m' \
    LESS_TERMCAP_so=3D$'\e[1;35m\e[7m' \
    LESS_TERMCAP_se=3D$'\e[m' \
    command man "$@"
  }

> I think there's good arguments for/against that, but I do think that
> ultimately it was a good choice, and programs such as hg(1) seemed to
> since have moved to git's more aggressive "color by default" stance.

I would say a lot of programs have been doing that, and I like it. The
last one I discovered is jq.

> > I should clarify that the patch doesn't permit them to be configured
> > using the normal Git mechanisms.  For example, unless the user sets t=
he
> > environment variables, which take effect globally, they're stuck with=

> > the colors that we've chosen here.  Yes, they can specify a single
> > environment variable before the command, but practically nobody will =
do
> > that.
> >
> > It's my argument that the user doesn't want Git manual pages to be
> > colored differently than other manual pages on the system, but if you=

> > believe differently, then we should allow the user to configure the
> > colors that are used in the Git-specific context using Git standard
> > mechanisms.
> =

> I'm in vehement agreement about this. If we do invoke "man" differently=

> based on how we'd do coloring for any other git program we invoke, we
> should of course be respecting the same configuration
> mechanisms. I.e. it should respect color.ui=3Dauto etc., you shouldn't
> need to set LESS_TERMCAP_md or whatever.

Yes, but good software is developed in stages.

You shouldn't expect a first patch to provide all the functionality in
the world. Not only does it take longer, increase the review burden, and
generate longer disucssions, but it increases the probability of the
feature never been merged.

Plus increases the probability of bugs bein introduced.

More features can be added later.

What is important is that users don't lose anything from what they have
now.

And unconfigurable colors is better than what they have now... Nothing.

> In any case, I think for these defaults we need to be considering the
> vast majority of users, who are mostly interfacing with one or two
> computers in their use of "git", and who are running some modern OS tha=
t
> supports terminal coloring, which is why color.ui=3Dauto became the
> default (to some objections at the time, but I think those have gotten
> less prominent as time marched on).

Exactly.

Moreover, if colors are really that bad, then users will complain (I bet
they won't), and then we can switch this off by default.

Easy.

-- =

Felipe Contreras=
