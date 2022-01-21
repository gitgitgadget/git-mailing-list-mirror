Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C5FC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 14:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350997AbiAUOaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 09:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381187AbiAUOaC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Jan 2022 09:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642775401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwaW0jzB85Y/kE+ptcuandEt3hvnMMPcQfakyKwQdE4=;
        b=YaLaWht7IGFS8oOGL+9vK01Wxed0I5xInO2O+oeAO3/x0RunRQfNQ27iFXTA4dsdkpjrID
        2kxj6XGwwXoPzmHHmxcxhDBWc9mUG9yMJioLsVFEM1To9HkKbOh9p9NfhmDbG3GnPMp30g
        FV6LnxpdgzS1jSDbn/pEXMsNWLemtBo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-bhg7FVqDNxGI48Wn0VtSqQ-1; Fri, 21 Jan 2022 09:29:58 -0500
X-MC-Unique: bhg7FVqDNxGI48Wn0VtSqQ-1
Received: by mail-pj1-f69.google.com with SMTP id k2-20020a17090a658200b001b399622095so6377128pjj.9
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 06:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LwaW0jzB85Y/kE+ptcuandEt3hvnMMPcQfakyKwQdE4=;
        b=SJd09mk4feNlv7V1WIZhBlHSpPvrKs8cLuwaENoi+WWx3mqt7HNu85S7GcvSBsSg/8
         OQqSG1zPpvRXx2fWU7CwjgGUo7bQRP7XMOVXbD9eObTd9dz05LmjckTIv6NyYlWg8PPI
         H5rtf7IWSfGF3f/gSeM/4rcq6iTc1RMQLzPaYZihlJRWvFc/CN0Rgssq2ofSjylPrBze
         mKhgPRy6BuPFDPNUhljUmwctDXBy91m7XaDwOvAOCGJ3BzM5SKGvEPfjsuK3c/sGIX5I
         4welqSHgay8O+RIm/aN/aOPGqYlOkz0gun7+STTICXJeYU4I2bxtn6k0B+XpPH/Vb+Wl
         9dAg==
X-Gm-Message-State: AOAM5309Izomw9E7jfgT/T8Dl7FAFD9P6QKpfYQbTZXtzW6tbeaWpjZC
        C9iAd+6bl9e1DzviAC3rbcGKH7tbrPTLxFfMYdnOjLeLZXumPnPiiqG26iBHeS6oohQa6T420Bk
        JoJRWJpVd5Gr4jdVIw12/aenHei2H
X-Received: by 2002:a17:90b:4c42:: with SMTP id np2mr991777pjb.201.1642775396926;
        Fri, 21 Jan 2022 06:29:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNSszG8MFEwaWzqiY4YEO9+hj80K/l3HUDi1sZLPQGs7pFrBNV3zCwPLJhJc7/We2nRcANJlx4jS4fgdyyQ4Y=
X-Received: by 2002:a17:90b:4c42:: with SMTP id np2mr991752pjb.201.1642775396580;
 Fri, 21 Jan 2022 06:29:56 -0800 (PST)
MIME-Version: 1.0
References: <YemTGQZ97vAPUPY0@pobox.com> <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 <xmqqee52ghwg.fsf@gitster.g> <220121.86iludl4d9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220121.86iludl4d9.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?B?UGV0ciDFoHBsw61jaGFs?= <psplicha@redhat.com>
Date:   Fri, 21 Jan 2022 15:29:40 +0100
Message-ID: <CABXw6YMztos7UYJn0LxKiWvZ_oy55mu+k__jABdXwAW0H3J0cA@mail.gmail.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 21 Jan 2022 at 12:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> On Thu, Jan 20 2022, Junio C Hamano wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >
> >> Fix a regression in my 9081a421a6d (checkout: fix "branch info" memory
> >> leaks, 2021-11-16) where I'd assumed that the old_branch_info.path
> >> would have to start with refs/heads/*, but as has been reported[1]
> >> that's not the case.
> >>
> >> As a test case[2] to reproduce this shows the second "git checkout"
> >> here runs into the BUG() in the pre-image. The test being added is
> >> amended from[2] and will pass both with this change, and before
> >> 9081a421a6. I.e. our behavior now is again the same as before that
> >> commit.
> >
> >> +test_expect_success REFFILES 'checkout a branch without refs/heads/* =
prefix' '
> >> +    git clone --no-tags . repo-odd-prefix &&
> >> +    (
> >> +            cd repo-odd-prefix &&
> >> +
> >> +            cp .git/refs/remotes/origin/HEAD .git/refs/heads/a-branch=
 &&
> >
> > I am not sure if this is a sensible test case to begin with.
> >
> > It sets up recursive symbolic ref in this way:
> >
> >       HEAD points at refs/heads/a-branch
> >       refs/heads/a-branch points at refs/remotes/origin/HEAD
> >       refs/remotes/origin/HEAD points at refs/remotes/origin/branch1
> >
> > The checked out branch (i.e. what HEAD points at) is nominally a
> > local branch, but it totally violates the spirit of the safety valve
> > that says "HEAD" MUST point at a local branch or otherwise it is
> > detached.  Creating a commit while "a-branch" is checked out would
> > not affect *ANY* local branch state and instead makes an update to
> > the remote tracking branch that does not reflect *any* past states
> > at the remote repository.  Even worse, a "git fetch" that updates
> > the remote tracking branches will make the HEAD, the index and the
> > working tree into an inconsistent state.
> >
> > Simply put, I think the BUG() is catching a case where we should
> > have been diagnosing as a broken repository.
>
> Yes, I agree that we should be spotting this . Todd/Petr: If you're able
> to describe it I'm curious about the original case you encountered that
> the test case is derived from.

Thanks for explaining in detail what's wrong about the approach.
We didn't know about the "HEAD must point at a local branch" rule
and copying the ref seemed to be the easiest way to create a local
branch pointing always to the latest content of the remote default
branch. I described the use case here:

    https://bugzilla.redhat.com/show_bug.cgi?id=3D2042920#c2

Basically we just need to checkout and reset --hard to the default
remote branch after entering a git repository while HEAD can be
pointing anywhere. Could you suggest some more straightforward way
to achieve this from a script? Thanks.

psss...

> > So from my point of view, BUG() is indeed inappropriate because what
> > the conditional statement noticed was a broken repository, and not a
> > programming bug.
> >
> > What we should never do is to promise this "only kosher in letter
> > but not in spirit" violation of "HEAD must point at a local branch"
> > rule will be supported.
> >
> > So, unless I hear more convincing arguments (and Todd's example or
> > anything similar that makes "git commit" from that state update a
> > ref outside local branches is *not*), I am hesitant to call the new
> > behaviour and 9081a421a6d a regression.
>
> Well, the user is doing odd things with git, but we should reserve BUG()
> for things that aren't rechable. Any time a user is able to arrange our
> tooling in such a way as to call BUG() is a ... bug.
>
> > What did the code before that BUG() do when faced with this nonsense
> > configuration?  If forbidding outright broke a sensible workflow
> > that happened to have been "working", I am OK to demote it to
> > warning() and restore the previous behaviour temporarily, whatever
> > it was (I think it was just old_branch_info.name was left unset
> > because we were not on local branch, but I don't know if the missing
> > .name was making any irrecoverable damage).  But the longer term
> > direction should be that we treat the "update HEAD ends up updating
> > some ref outside refs/heads/" a longstanding bug that needs to be
> > fixed.
>
> The behavior with my patch here is exactly the same as before. I.e. it
> was rather straightforward, the xstrdup() is new, but before we'd just
> take the un-skipped string that didn't start with refs/heads/ as-is.
>
> I agree that it's better to look at this more deeply, but given the rc2
> being out, and this surely being something we want in the final I'd
> think we'd want to keep this patch as-is.
>
> I.e. this is all a bit odd, but it was odd in exactly this way in v2.34.0=
 too.
>
> We can add a warning() or die(), but a change that does that & convinces
> you it's the right thing thing will require more careful consideration,
> testing etc.
>
> So I really think we should narrow our focus and keep this as-is.

