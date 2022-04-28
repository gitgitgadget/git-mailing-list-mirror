Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6DC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 21:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351994AbiD1VFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351976AbiD1VFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 17:05:52 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92404C0E7B
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 14:02:36 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q2so5789053vsr.5
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R0z2emLDrYChgpgKtG91xhmKIxMmna7NdLWF5Grecds=;
        b=nbRskf+BrT5VlPtmsY6+wnJLfdTQwxriSen6/Rz6YiUD7J/hqXg1oSVMFC1ZDrJNCD
         lbhPlrwZiTz2QU0TKfwZGaviyHUQdLfHKFK29vKyTpgdUNzsEMXBu9dntyumZxTUTjx4
         Q6EbAaK58mUJZikidyBuk79mRaAbtzq2p2q9ty7/eTqAzQT88cwr9A2dwWQE4BMMIGI/
         ADZgO0bVVRY0aG1akdkDYiDrNT8Ji1IJDb04IufWfS/v1WI4ers69XAvxHplBd3TMdt2
         0XO/m54+t6is0FjDUz0mYZ5VB+niuH60RS94tU6yLpXImm6zan4fnLQKaLre2p5FXRoZ
         1N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R0z2emLDrYChgpgKtG91xhmKIxMmna7NdLWF5Grecds=;
        b=wojUHSD9JYHEmvYwGzMA7Aj28I0HivV5vAq8XcO96Ot/JxKxiMlqB6nM6ChA2kjTkZ
         B/ew7zsL5UypuhqpMG/RRp6X1FZCGMuDnUVzrWTOY4U4dx9L/WxkBc+V249c6hJNAea1
         +6KvZ9J+uBs2I9OLFIgeURLgaSxxvqTSHVuov434NUMfelY+9SxsssVt3ZuFstNZH7E9
         pfMx5oFldxDVRaOWogJy3oRn0YSM+4a1yv+0xw28e4KD83YSKhilZXNL/Ecea/MCvcvd
         L1jplxcOc1nRCikK5Wm7BrAPwbb5WohWxsJbajGr+lHbe1VBqeLOg5HT8uGcbt/TLeMM
         z8DA==
X-Gm-Message-State: AOAM531easL1a7MdU8Jh2ocZRbTmfvywyun6K7YX218i7SPssevO7Asy
        7pQOh/EFnzhmfL0lKQxtTF7jbqXW3tR60xvTosKbePrvUL4=
X-Google-Smtp-Source: ABdhPJxipu5d8QdM0wa/1lkphtErBmQAisGrLK3HQAzmeoKJqImQEa0nYi3MJnJE6jfNCcg+IyJb4AT8mMzer8erCUg=
X-Received: by 2002:a67:c905:0:b0:32c:69bd:18a3 with SMTP id
 w5-20020a67c905000000b0032c69bd18a3mr9706207vsk.5.1651179755581; Thu, 28 Apr
 2022 14:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
In-Reply-To: <xmqq7d79du6c.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Apr 2022 14:02:24 -0700
Message-ID: <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 9:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> > +is_root() {
> > +     test -n "$1" && CMD=3D"sudo -n"
> > +     test $($CMD id -u) =3D $(id -u root)
> > +}
>
> Style.
>
>         is_root () {
>                 ... body ..
>
> But more importantly, why do we need this in the first place?
> SANITY prerequisite checks if the user is running as root or
> non-root---can't we use it here?

my bad; tried first to use NON_ROOT but it didn't work and SANITY
seems way too complicated for what is really needed, plus this can be
shared by both prerequisites, and more importantly allows me to
introduce an exploit with that CMD trick, but Phillip's eagle eyes
already blocked me so it is gone and replaced with SANITY for v3

> Or perhaps my reading is wrong?  I assumed from its name that it was
> just "see if we are running as user 'root' and return 0 or non-zero
> to answer", but if it does more than that, like priming "sudo", then
> probably it is misnamed.

it does both indeed, and is also why I am pulling the SUDO
prerequisite on each test instead of checking once at the beginning of
the file and being done with it.

I would rather have some tests skipped if sudo can't get root without
password than a failed test, and want sudo to always work and not
"possibly hang, waiting for a password" during each run, not to block
CI either.

> We have a root-owned directory "root" with a subdirectory "r" owned
> by us.  We want to be able to use our "root/r" directory as a
> repository.  OK.
>
> The prerequisite allows this test to be started as root, but I do
> not quite see the point.

I have to agree that I was looking at it the other way, my concern
with allowing root to call this was to make sure that none of my
changes (or any future ones) prevent them to do what they should
normally do, hence why I only disabled for root the tests that
couldn't work because make no sense (just like is done for tests that
rely on a case insensitive filesystem, for example)

More on that in the next test.

> It may pass when started as root, but it
> is not testing what this test is designed to check (i.e. an ordinary
> user who has a repository at root/r can do things there).

IMHO these tests should validate that ANY user can do what is
expected, and that includes root (the two versions of it), not only
"regular users"

> > +test_expect_success SUDO 'sudo git status as original owner' '
> > +     (
> > +             cd root/r &&
> > +             git status &&
> > +             sudo git status
> > +     )
> > +'
> If this was started by 'root', root, root/r and
> root/r/.git all are owned by 'root' and we are checking if 'root'
> can run 'git status' as 'root' (or 'root' via sudo) there.  Such a
> test may well pass, but it is not catching a future regression on
> the code you wrote for this series.

It is subtle but it does, when run as a real root it will pass, but if
we run it through sudo it fails because of the change that was
introduced in this series.

> > +test_expect_success SUDO,!ROOT 'can access if owned by root' '
> > +     (
> > +             cd root/p &&
> > +             test_must_fail git status
> > +     )
> > +'
>
> And as an ordinary user, we fail to access a repository that is
> owned by a wrong person (i.e. root).  !ROOT (or SANITY) prereq
> should be there NOT because the test written here would fail if run
> by root, but because running it as root, even if passed, is totally
> pointless, because we are *not* testing "person A has a repository,
> person B cannot access it" combination.
>
> The other side of the same coin is that the lack of !ROOT (or
> SANITY) prereq in earlier tests I pointed out above misses the point
> of why we have prerequisite mechanism in the first place.  It is not
> to mark a test that fails when the precondition is not met.  It is
> to avoid running code that would NOT test what we want to test.
>
> The difference is that a test that passes for a wrong reason
> (e.g. we wanted to see of person A can access a repository of their
> own even when the user identity is tentatively switched to 'root'
> via 'sudo'---if person A is 'root', the access will be granted even
> if the special code to handle 'sudo' situation we have is broken)
> should also be excluded with prerequisite.

Agree I am abusing the prerequisites, I am instead removing the tests
since they are pointless when run as root in v3, which would have been
part of the first proposal, even if slightly more complicated.

> > +test_expect_success SUDO,!ROOT 'can access with sudo' '
> > +     # fail to access using sudo
> > +     (
> > +             # TODO: test_must_fail missing functionality
>
> Care to explain a bit in the log message or in this comment the
> reason why we do not use test_must_fail but use ! here?  Are we
> over-eager to reject anything non "git" be fed, or something?

correct since 6a67c759489 (test-lib-functions: restrict test_must_fail
usage, 2020-07-07) using anything but git fails, and improving that
now is IMHO not worth it.

The only protection we get from using test_must_fail instead would be
to know if we introduced a crash, but the same command has run several
times already so IMHO it is unlikely.

will obviously not miss the opportunity to enhance test_must_fail and
remove the TODO otherwise ASAP.

> Overall, I like the simplicity and clarity of "do not start this
> test as 'root'" in the previous round much better.

I disagree, and think that the fact that the second test changes
behaviour with this series proves my point.

I agree I was abusing the prerequisites, but was in the name of making
this change simpler, I am hoping
and slightly more complicated version that doesn't abuse them would be
better than having a simpler one where those issues are hidden and
even if we currently have no "run as root CI jobs" and last time I
tried one found it is broken somewhere else.

Either Way those issues are orthogonal to this change and would be
happy to discuss again after v3 which is still not ready and will be
posted most likely as an RFC including as much as can from the
feedback provided so far.

Carlo
