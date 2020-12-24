Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E7C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 03:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FE5224B8
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 03:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgLXDOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 22:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgLXDOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 22:14:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46FC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 19:14:04 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w3so817882otp.13
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y5rJELhRxLoRqjohZuZNU0DocM1XAW+wIhySw8oZOtQ=;
        b=loSaJ/yoWJWf//XlkPOUJ2Owh4HDZTpIA6Z6ITO07ibVvf5s4OhznP1Rim4XKdtFb2
         fVIJCHM72mC+dtfz2XgjsZ2Iw+l1EEh5N3gJ/cf7tPHiRMvk+RG3YvPJthDyIH55rEZx
         dWT9avJdykhw2z42mM2uLfVVxMBGRb0La0wFgFCaj3Ki7BK8A/lsT906DllfjueYbQR8
         GNUYSzdmhwBydoKFgnVFCEmjGMofWcxwLa6kzsYe+clZ5BqhYUwCFytrK+0YCtHfUJ6L
         H2nwr4THOrLCQDvOsnNfKSqPQQOfnJbH1CZMTQFuVxrO7NV6kctm/LqYdP+lf6qnUHhM
         H1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y5rJELhRxLoRqjohZuZNU0DocM1XAW+wIhySw8oZOtQ=;
        b=BvhNNltKkdgt0mvnVlNOj1uWgEzBD0ZKj2G7v8ccwuhZYMi8H0GK/1Qxc7xsWV4BRv
         FVwzpHQ5lov9iHUy4roem6cqQk1XAVZw9q8vDFfMLMWaWI/N274vZ2cEqfmEzzAAzomM
         YRSb/7MRYWcOub/nEOSmWsPxr9P4X8nmn7ViFJU2O1Q0NtPoQonmKdmGtHxU2+0Kw+IS
         4aNU5ETWc9Ty6V3fzsGnUgDkL5hMwc+hWwQHMGiEt87Oq/LBNGyG10hLRazI68mz4SVK
         pUJIJNJmhFbfc6rmeNtdbK5YkBxPSBIVIHVEc5ux4bvtN8BY1Rb6WIAJJbhzJ/hcsZ04
         4xUg==
X-Gm-Message-State: AOAM530ON2AyWfys4XaD/C8v+7w1VejtdEpMp51Xr8mJbuL1KufTMdZC
        tog9pphldDBHf8xA4PpdgbI=
X-Google-Smtp-Source: ABdhPJyi1jZ6YnZcYIj+GelnP+BsPpFp6QoAoM4LC90zmZGZoE8GoIAuzHhsyK+dff2ZD7QTBqgCXQ==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr21014724otk.187.1608779642751;
        Wed, 23 Dec 2020 19:14:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h93sm6443429otb.29.2020.12.23.19.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 19:14:01 -0800 (PST)
Date:   Wed, 23 Dec 2020 21:14:00 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
Message-ID: <5fe40778321c5_7855a20819@natae.notmuch>
In-Reply-To: <87wnx8uirn.fsf@evledraar.gmail.com>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <87wnx8uirn.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Dec 23 2020, Felipe Contreras wrote:
> =

> >  * Using welcoming and inclusive language
> > -* Being respectful of differing viewpoints and experiences
> > +* Being tolerant of differing viewpoints and experiences
> >  * Gracefully accepting constructive criticism
> >  * Focusing on what is best for the community
> >  * Showing empathy towards other community members
> =

> [I happen to be on the PLC, and I'm not speaking for the PLC, just
> myself]
> =

> Generally speaking, and not just commenting on this specific patch: I'm=

> not in principle against us forking the upstream CoC if we as a project=

> & community deem that a worthy trade-off for whatever reason.
> =

> But in the case of this specific patch, (and I'm focusing on points not=

> already raised by others):
> =

> 1. The specific wording you're changing is something that changed in th=
e
>    CoC from version 1.4 (which we adopted) to upstream's 2.0.
> =

>    My reading of the 2.0 wording is that it contradicts your
>    interpretation, it talks about "being respectful of differing
>    opinions".

I don't see how the change from "differing viewpoints" to "differing opin=
ions,
viewpoints" contradicts my interpretation.

>    If the CoC means to enforce something about privately held views as
>    you seem to suggest (and not just behavior in public),

No, that's not necessarily what I'm suggesting.

Let me try again:

  1. Respecting differing opinions is an internal matter. You can't
     really do it, even if you want to. Also, it can't be enforced,
     because nobody can know if you are actually doing it or not.

  2. Behaving respectfully of differing opinions is an external matter.
     You can do it, even if you don't really respect an opinion, you can
     act as if you do. It can be enforced, because others can see how
     you behave.

Even if the CoC is trying to enforce #2, it's still not desirable to do
so.

Now, it's debatable whether or not "being respectful" is taking about #1
or #2, I don't think it particularly matters, since #1 is asking for
something impossible, and #2 is asking to lie. Either way it's not good.

>    then it seems like a paradox to me that it also asks participants
>    to be respectful of differing opinions.

I don't see how "views" or "opinions" alter the argument.

>    To be clear I don't agree with your reading of it. I'm just
>    suggesting that any proposed updates to the CoC that rely on reading=

>    specific intent into the wording therein attempt to do the legwork o=
f
>    convincing this ML to accept the proposed change in a way that
>    provides more context for the change.

It is not my reading; it's literally saying "being respectful". The word
"respect" has an established meaning, and it doesn't matter if they are
asking to actually *be* respectful (#1), or merely *show* respect (#2);
both are a problem.

So at the very least it's asking to show respect.

What is your reading? Does your reading not imply showing respect?

>    Discussing that upstream has changed the relevant part from A to B,
>    but we're proposing a change from A to C seems highly relevant.

Yes, it is relevant, and I will contact upstream about it, but even if
they deny the change, what part of the rationale is not correct?

Many more people with a lot more knowledge about the philosophy of
freedom of speech weighted in the University of Cambridge debate, and
the exact same rationale applies here.

> 2. The CoC has official translations into a bunch of languages:
>    https://www.contributor-covenant.org/translations/
> =

>    So I think that even if we deem a git.git-specific change to the CoC=

>    to be worthwhile losing a 1=3D1 mapping between our version and thos=
e
>    translations should give us pause since we'd be less inclusive to
>    non-native English speaking contributors of the project.
> =

>    Furthermore, I think a really basic sanity check on any specific
>    reading or interpretation of the CoC is to see if also holds true if=

>    you read some of the official translations.

Yes, that is a good point.

This is why usually it's a good idea to look back at the etymology of
a word.

In both words the etymology goes back to Latin, and since I speak
Spanish I can grasp pretty clearly what is meant in the four cases
{English,Spanish}{respect,tolerance}.

From my point of view it's really simple:

 a. Respect: hold in high regard
 b. Tolerance: endure

Whether it's "respect" (English), or "respeto" (Spanish), doesn't really
change the meaning. Same with "tolerance" and "tolerancia".

>    In the language I speak natively this reading of "respect" doesn't
>    agree with your interpretation.

We would need to see which interpretation you are talking about.

One example to show the difference is that you are supposed to hold in
high regard (respect) your parents, or the King, whereas in a Thanksgivin=
g dinner
you are supposed to endure (tolerate) your uncle talking about conspiracy=

theories.

These are of course culturally-specific examples. But I hope you get the
point.

How is it different in Icelandic?

Cheers.

-- =

Felipe Contreras=
