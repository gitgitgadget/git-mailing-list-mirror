Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6884613AA
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhDSTYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhDSTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:24:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86674C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:23:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z8so40682243ljm.12
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gY0jfuC5VU8VlrFRiE79y9s7UyGDlMhEnicMSxR0UQ0=;
        b=VTz2yl8UdcSjP7b54zo2S2nNdag793TTVMvWMqQ/zW5NfcFG8GxXbwgs6J8EKkitXx
         8U4M7jfjuCRp/GHgzrlcylxM6Z5XZJ+FS+yDXnlID0PtFR/8LmN422M3ZFSQxE8DyUEB
         SDgC74y8w5hhst5T9Uv3pQcVe0EJ/0P3YOdA3H1/1/8iBWvpTnZll0ldgSYu3OKzus/q
         kFjW9asPVVu0yH0dfgxsyrhumXXCLkIaFTGjwdfxFLJnTyw8aWzgP+uR0g7LZV8rg2n4
         NX+sNsE3yjnkA2DkgCqGqQHuBQdFul56CGxUin6dZhvkg1M7X1ogpPaTIiEFqc9PnECj
         KHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gY0jfuC5VU8VlrFRiE79y9s7UyGDlMhEnicMSxR0UQ0=;
        b=iTRNnNhhuPKxGHX4Vko4sOKOSj9jKV9ZGlkWsb+KV8X4zD72/RS1poFwlkinwC0PBO
         eT8iQJmISoHfATA4QoA8Qo1vtHmgaWKjATd55C7eez/2oRv5zidZHBgz301XqcduvKd8
         XVvNboUAbrIl8f8SQbJ7aZcdZ/xlspebYlFuJ16CBTThSqWLLvmRI2d5eKu9OlfEkPRT
         3FPetQZfyF4knLxIbG7D3c3ftQESOx4X9NWTUYkSDUwiwAcOT75NBkPmCZOSLVcal7bU
         hXOoKzqei+NTKj6Bf7O41OZt0aOuwKIDCZR7Tfpf2Cn8t39e6GtinXXwXZGrTJiXoop9
         1H+A==
X-Gm-Message-State: AOAM531rss/HiMY3oUER8gToL/rp+P6O5C/m8YPMMFWmidcd6Wx95G43
        hjuHgiT8RlSEkZ+qc6gupFnarY07YF+pCbjoRqu5HFmQs7Zogw==
X-Google-Smtp-Source: ABdhPJw9sPnmHVPOEhIt3jvvWynWOHbFhiuuxh3lXr5nEhCNUbnJoa9hubnLIEPkIwG12UaSlkiq1W2A1Zh8/56xr6c=
X-Received: by 2002:a05:651c:307:: with SMTP id a7mr12521455ljp.166.1618860208931;
 Mon, 19 Apr 2021 12:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com> <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <87czuq4r4l.fsf@evledraar.gmail.com>
In-Reply-To: <87czuq4r4l.fsf@evledraar.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 19 Apr 2021 21:23:14 +0200
Message-ID: <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 10:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > If you send around code patches by mail instead of directly working on
> > Git repos plus some UI, that feels to me like serializing a data class
> > instance to JSON, printing the JSON string to paper, taking that sheet
> > of paper to another PC with a scanner, using OCR to scan it into a
> > JSON string, and then deserialize it again to a new data class
> > instance, when you could have just a REST API to push the data from on
> > PC to the other.
>
> That's not inherent with the E-Mail workflow, e.g. Linus on the LKML
> also pulls from remotes.

Yeah, I was vaguely aware of this. To me, the question is why "also"?
Why not *only* pull from remotes? What's the feature gap email patches
try to close?

> It does ensure that e.g. if someone submits patches and then deletes
> their GitHub account the patches are still on the ML.

Ah, so it's basically just about a backup? That could also be solved
differently by forking / syncing Git repos.

> To begin with if we'd have used the bugtracker solution from the
> beginning we'd probably be talking about moving away from Bugzilla
> now. I.e. using those things means your data becomes entangled with the
> their opinionated data models.

Indeed, it's an art to choose the right tool at the time, and to
ensure you're not running into some "vendor-lock-in" if data export is
made too hard. And aligning on someone's "opinionated data model" is
not necessarily a bad thing, as standardization can also help
interoperability and to smoothen workflows.

> > Not necessarily. As many of these tools have (REST) APIs, also
> > different API clients exist that you could try.
>
> API use that usually (always?) requires an account/EULA with some entity
> holding the data, and as a practical concern getting all the data is
> usually some huge number of API requests.

I'm not sure how relevant that concern really is, but in any cause it
would be irrelevant for a self-hosted solution.

> >> And to e.g. as one good example to use (as is the common convention on
> >> this list) git-range-diff to display a diff to the "last rebased
> >> revision" would mean some long feature cycle in those tools, if they'r=
e
> >> even interested in implementing such a thing at all.
> >
> > AFAIK Gerrit can already do that.
>
> Sure, FWIW the point was that you needed Gerrit to implement that, and
> to suggest what if they weren't interested. Would you need to maintain a
> forked Gerrit?

Sorry, I can't follow that. Why would you need to maintain a fork of
Gerrit if Gerrit already has the feature you're looking for? Is it a
hypothetical question about what to do if Gerrit would not have the
feature yet?

> Anyway, as before don't take any of the above as arguing, FWIW I
> wouldn't mind using one of these websites overall if it helped
> development velocity in the project.

I appreciate that open mindset of yours here.

> I just wanted to help bridge the gap between the distributed E-Mail v.s
> centralized website flow.

Maybe, instead of jumping into something like an email vs Gerrit
discussion, what would help is to get back one step and gather the
abstract requirements. Then, with a fresh and unbiased mind, look at
all the tools and infrastructure out there that are able to fulfill
the needs, and then make a choice.

--=20
Sebastian Schuberth
