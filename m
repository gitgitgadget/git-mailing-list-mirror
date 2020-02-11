Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A19C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671D920842
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 12:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqxYjmmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgBKMho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:37:44 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41452 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgBKMho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 07:37:44 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so6156523vsc.8
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/kzVsry4ITNjBpvjZ3OJLf+LoSSw7GzhNpB6YTBU4Y=;
        b=oqxYjmmUWDZ3ErkQDP2t03yuQbegtR6kSxv0eu9kFjdMLqT4NqvwJVb/Ht91MEsgvU
         ZSKIWtenTDq81Ir1kNsd4cwasES0Ep9rFQ0En6FCrCvAM1oUWLIV/02nbDKFNUODgVYG
         GORsclGGl+xM+Zkb0xdhtyYWfcwUsXFa5wytRJAqrZTwZK/TXR4EI+IFDgOlCAHHUo0u
         vxLOVD1pGv6V/wCQb7CjrXW6LEp/Iosri5PvfIAUjOeeeTi3t7Endc4s3yIg2hFXhJY0
         f3i4ZZ0gghqPNNZ1uPatItmBpDJRFxVSzKQmmlD2/cLHU1XXwyUOc4yg7ZAySQ6OBdQU
         Twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/kzVsry4ITNjBpvjZ3OJLf+LoSSw7GzhNpB6YTBU4Y=;
        b=ipAbkAglbJY4AbBKbQFIegOT3WEutx51luwaDHaYoQsxAikf3xZURZ5KNGmYBuUlw6
         6E45Zunsmf420vlYFzhK/TGw87jDgB6cbL/o864C6oFZP+i+3TAoNgNz+kcYrnkeyibj
         /b49Pzz9D3srOKeccRS9Zh6kZzqHDRlsExcn5Ir4HpomHL5BhuhOxX+P532oMDUO86lW
         z3ElODg5QzMZVt9z9s9ejiBKY+xkdmcfLqmVysiY3sVptcck++VBciWLb95+3UJ5eNjh
         O+AVHhAiFqiUuO4MKZgSrsDWGwCVMq6v0+6INQfCgA0PfkXZC18YXbMfpBAkw+i+yoiQ
         lxdQ==
X-Gm-Message-State: APjAAAWhIaW0XptIxysaA6OF60zKcMHgKXZGk5UNdh6GlsuDyYpSIyY3
        aDyYnN8rtNLG4/CN9Eo2A9+0weUHUurxtq7OHrI=
X-Google-Smtp-Source: APXvYqw/PSp7KEw2RWyGamdpJrqKnWHR3eGShEILty0obao2EB9UVO3hW85nrP8ha7uWkpNx9kfZ306DjxcYXBSrWQs=
X-Received: by 2002:a67:f847:: with SMTP id b7mr9007478vsp.40.1581424663522;
 Tue, 11 Feb 2020 04:37:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
 <pull.478.v7.git.1581294660.gitgitgadget@gmail.com> <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
 <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com> <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
 <xmqq5zgdy7pu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zgdy7pu.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Tue, 11 Feb 2020 07:37:32 -0500
Message-ID: <CAOjrSZs7aN08joo9mjvw6EvLHRRKofETVzAWvPuQAo1rBwZMvw@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 1:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matt Rogers <mattr94@gmail.com> writes:
>
> >> How are you reviewing the patches in your own series before sending
> >> them out?  This round is better than the previous rounds where we
> >> didn't have a matching change to the tests so "make test" may not
> >> have passed in the middle of the series, though...
> >>
> >
> > I went through each patch individually using rebase -i and built/tested it.
> > Although just to save time I only did t1300 and t1308 since I believe those were
> > the only ones that should be affected.  I can write a script that
> > would run the whole
> > test suite overnight for me and make sure the series shakes out okay,
> > if you'd like.
>
> What I like does not matter.
>
> What I pointed out for 04/10 wouldn't have been caught by your
> testing anyway, as both the code and the test had matching
> unnecessry changes.  I was wondering if you are relying too heavily
> on just tests and without actually proofreading the changes to see
> if they still make sense in the context of the updated series, and
> if my suspicion was correct, if there are something reviewers can do
> to help the authors.
>
>

I do try to proofread patches, I'm just not the most careful of reviewers at
times, partially as a personal problem and partially as this is a new workflow
for me.  As for the particular issue, I just thought it was a good idea at the
time and I didn't think it all the way through


-- 
Matthew Rogers
