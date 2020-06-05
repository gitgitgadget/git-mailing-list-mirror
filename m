Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A83C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 01:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC61F2074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 01:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTv0FOgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFEBqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 21:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEBqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 21:46:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35CC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 18:46:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x202so6872978oix.11
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YnPcH7ySC7fri6p8A/4w+b9XKjfeyOzX8pkcxUAzeg=;
        b=pTv0FOgPiMLyGUCbNMAQiUdP5J9jJOghe4d1F3teRmQfA5JzhIUo3CogxLCnbaiI5t
         4kx5gdKM9bAYN3248zam9qmgzaqIaUVzrhdpjXGzXV05BlUYuZM9ycogESCq35vjSfjx
         xC4Gh19pM+4pNXbV5SPoR5fntOq9HVSMwA5TJ2lrn1IxqBJrlXrqu6apz48Bd3YPuPVn
         jrkeREOgqtzHcwJzfmKnck/JKxr31fMxX1AUadb/U6LIv/VM6XdemBGsdGZwXXrfrvRp
         XSHvWnAteOGMPJaiBr4HwranAn0bC6PM/cYupaTE52kr4VBWt39R4Pw6HB4But1wKG5L
         fuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YnPcH7ySC7fri6p8A/4w+b9XKjfeyOzX8pkcxUAzeg=;
        b=DtlFnznsxRi2p97BLcoN6oJfavZIUClTnNGZV1J7iTLa4zD7ba9dD3RipMpwLvmDgV
         39/DJp6m15pXcsYYnOx4PisuPtNCHlV/NwrxBQjV/HRXM6iFPScLi2uxlAoVaeQYZLQD
         KjmEqsWiZb+yLklkFaq7Qx66cjfvGcoiiFV5rActJMu40CVT4x87l1w76IUeLEoQyvhU
         F2GcIwZaCIZ/GwIidf3zBpw3P9Sf/f8SDjEY6tQ9JJEGhkc3zDEyNSGia7msoVw7xqUd
         sdC6bBcfrL4r9QkkPEZeupDrFb1k0CLxf0iDpm+4eEiRP1x6FLQls1UL0qIY6g0vldTm
         YG0Q==
X-Gm-Message-State: AOAM533XQIUa0Hw6/LlBVDP+0rIRq8UkKUjgSzoMyrnTcf9DcDHIg9Lj
        LLTWFd9yrg9aJwkfTWud14S26BPhbgO3WyoKtbw=
X-Google-Smtp-Source: ABdhPJx58nvwS3m4jVx0aOtqWvf3QLPSfxquJJo6sDhnc8d5rN2MwNPnjn9Nyl9S+sPCUYoDIP7St1yr4Dwka1Bb7wc=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr495094oia.167.1591321573057;
 Thu, 04 Jun 2020 18:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com> <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
 <xmqqh7vqrimm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7vqrimm.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Jun 2020 18:46:01 -0700
Message-ID: <CABPp-BFLUZvycq_o6mPcx3ZQkeQy79nQ_mGD3B+JLzBwb6ER=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 7:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Jun 3, 2020 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Seeing a handful of regression reports [*] immediately after a
> >> feature release is made gives me a mixed feeling: people are eager
> >> enough to help by reporting issues they encounter, but there are not
> >> enough people who are eager enough to help by testing the tip of
> >> 'master' before the release.  Are there things we can do to help
> >> them become early adopters so that they do not have to scramble
> >> after the release?
> >
> > That's very diplomatically worded, but perhaps let me peel back that
> > deflection layer a bit and be more direct...
>
> Sorry, but you are reading too much into it.
>
> I am not worried about individual bugs; bugs happen and that is an
> inevitable part of development.  I have enough confidence in our
> developers to feel that we can promptly fix a regression once an
> issue is raised and clarified sufficiently to be actionable.
>
> > Now, it's possible these regressions could just be a reflection of the
> > fact that I'm focusing more on fixing inconsistent behaviors rather
> > than adding new features, which is a type of work where it's much
> > harder to avoid fallout and reported issues.
>
> Yes, and as I said already, bugs happen and they tend to happen to
> those who touch the trickiest part of the existing code---it is
> inevitable.  It is OK to be initially buggy as long as we can fix
> breakages promptly.

Thanks, I'm glad you're not worried about that.

2.26 drained me pretty bad, enough that I was somewhat apprehensive of
2.27 being released.  Then two quick reports after 2.27 was released
was quickly filling me with dread and had me considering how I could
change it.  Maybe I was just in an overly worried and drained mindset
when your email happened to arrive.

> I am however worried about how the issues often are not raised until
> a regression hits a tagged version.  As a piece of software gets
> used more and more widely, it would be used in more and more
> different ways, and some of these ways may not be covered by
> developers' minds; by definition, some regressions are noticed only
> after a new version hits end users' hands.
>
> Basing in-house releases a Git developer has control over on
> 'master' or 'next' would reach audiences that the Git developer has
> access to, and as long as the in-house users use Git sufficiently
> differently from the Git developer (is that a realistic expectation,
> though?), we'd gain more coverage before a tagged release happens
> that way.  Basing the version placed in a distro's 'testing' track
> on 'master' or 'next' may give us even wider exposure but it would
> be much harder to arrange, I am afraid.
>
> People from time to time suggest to merge trickier topics early in
> the cycle, and in principle I do agree that it may not be a bad
> idea, but given that we do not have enough folks on 'master', I am
> not so sure how much that would actially help.

True, though I thought jrnieder's reports from Google's internal
testing were pretty cool; they caught some important bugs even if they
didn't catch everything.  The more of us doing stuff like that, the
better off we'll be, even if it's not as good as getting on a distro's
testing track.

Another consideration we could make is just scheduling .1 releases
automatically, and not limiting them to security fixes but instead
considering the same kinds of things that would be allowed around the
time of -rc1 or -rc2.  I still want to push to make the quality of .0
releases as high as we can, but given that human nature seems to lean
towards avoiding things until they are labelled as official, and since
we benefit from that wider feedback, maybe we adjust slightly to take
advantage of natural behavior and do .1 releases?  Anyway, just a
thought.
