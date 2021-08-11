Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC246105A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhHKVZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:25:16 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82142C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:24:52 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z9-20020a9d62c90000b0290462f0ab0800so5042804otk.11
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=92KqnpOG4aK7WOI4LQEpwboMOuc3GHN9YxFIBiyEUL4=;
        b=G8bQhnUSb3xWVEhURrgXrVHvX+VODRUj6fMc6lxBwp5OsX82L28+RP8lGUkdneUx+F
         xy04vYZeBzTVrUjHCEZRT9wGpLNLZl+18KwZsBQruDkq8ZiB4mmIMgyN6LXIQNeVs+4j
         QXPk7ba7fjcKWEk07l9x1Wy1EW/w7+xm/yH7SggDAalEukBQjhxi9L73jvrF9CMssgFi
         LwB+yilwGdjwkkPKD20AAl7GzNeQHU0yg8kbDheFjJYxmyPkizXOJu5jZJ4WrVystf5h
         JZnwMbLBlANJS1REvVJVXm09FPD58jj6JTEd0fHi9mk4EAPBFdUlcA5Er6ac+9+ptgtF
         zgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=92KqnpOG4aK7WOI4LQEpwboMOuc3GHN9YxFIBiyEUL4=;
        b=mubBc9FPdPZs0OMw+DOw0YI5UwpmLVJ5/UMZ1aaZA3MjxjQ1K3mVdylj/PKrpT+O+e
         w2UpDzS+IfvpplpofDw047yQpf8zBy2ut4dtO+aXTjo3gME8CKihpVRNxvutfB6Zy/h7
         S9/RgeyEXS3XsGIckAhINxvvzRXEbZNFB5MCiyQektxjfYN2r3G3KrLL9t9w5oLLgFAL
         np9UGga40HH3kvgN6pm0bikB54KwjLh3tJZaM6dHtYWTEAlPoLBAL6PjH8sAcN3eZ4A9
         ydXs9sx2wOK5LHEWZVltui4b0+cjjco0ST/kXMKOMxcn0VSSWv9tcafef40UAL0cIocT
         udTQ==
X-Gm-Message-State: AOAM532EKyUmo1ppWbsUPOsIB2QxJo4WCkm8naYKrup3JS9jcQivV9TJ
        a6+vfS3VOBBE1EXj7IqjmoQ=
X-Google-Smtp-Source: ABdhPJxU3aBhvcFWSU9yCsGZn3ASN4pOaL2QCt/qkzdlunGdain+fYeXR27+BkNtLLapgdA2SqaqVQ==
X-Received: by 2002:a9d:7d0d:: with SMTP id v13mr792204otn.252.1628717091794;
        Wed, 11 Aug 2021 14:24:51 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id l12sm82916oov.47.2021.08.11.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:24:51 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:24:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Message-ID: <61144021e75ac_1ed6208da@natae.notmuch>
In-Reply-To: <YRQzbPpk23dVqP+g@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
 <611430a5b83e1_19f82083b@natae.notmuch>
 <YRQzbPpk23dVqP+g@coredump.intra.peff.net>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Aug 11, 2021 at 03:18:45PM -0500, Felipe Contreras wrote:
> 
> > > One thing I find off-putting about "git stage --diff" is that to me,
> > > "stage" reads as a verb. So it is like "git add --diff", which seems
> > > out-of-place; there are two verbs in a row.
> > > 
> > > I do not mind the term "staging area", but using "the stage" as a noun
> > > is simply confusing to me in this context.
> > 
> > OK, but "stage" can be a noun.
> > 
> > Here is one of the definitions:
> > 
> >   : a center of attention or scene of action
> > 
> > This definition doesn't imply what the action is about, but
> > "commit stage" should be perfectly aligned with that definition.
> > 
> > Here's another one:
> > 
> >   : one of two or more sections of a rocket that have their own fuel and engine
> 
> Sure, I know the various meanings of "stage" in English. But I do not find it a
> synonym for "staging area" at all.

Nowhere did I argue that they are synonyms.

I said "stage" can be a noun. Just like "staging area" is also a noun.

They do not mean the same thing.

> Now my opinion may not matter, but:
> 
>   - I thought the goal of using a different name was to find something
>     that made intuitive sense to English speakers. I do not find "the
>     stage" any better than "the index" (in fact, I find it worse).

We already found something more intuitive to English speakers:
"staging area".

>   - Part of your argument seems to be "many people expressed an opinion
>     that the term 'staging area' was a good idea". My name was among
>     them.  But in the very email from which you quoted me, I am arguing
>     that "staging area" makes sense to me, but "the stage" does not.

I am perfectly aware of that.

Everyone agrees "staging area" is the way to go.

How that gets translated to the user interface is a *different* matter:

  * git diff --staged
  * git diff --stage
  * git diff --staging-area
  * git staging-area --diff
  * git stage --diff

My main concern is not precisely how this term gets transcribed to the
UI, it is that it actually gets done.

If it's easier to start by updating the documentation to start using
"staging area" since that requires less discussion about term mapping,
then I'll gladly attempt that first.

-- 
Felipe Contreras
