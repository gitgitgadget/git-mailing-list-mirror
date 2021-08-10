Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A481EC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A28060527
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhHJSSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhHJSRG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:17:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EAC059347
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:58:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so45999otl.9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHQ2YbhZJ8mfF7GZbkHI7zjCObvWr7UpfRuc9La2dkY=;
        b=hzcxq9TJRXWDiQcPoXfFOK7QLtvjgWQHInEu7SZGNpTWUSApkLiS/JtvSMWpn31DwR
         Fi/t8sqnx69wUDJ/EFwk4uSzLsur2RK6G5VcES297VWsN0mc96u0CWeJxzfgP5pUyAdw
         pwM0sGwqXK6PB6ASSX5fZZjLZTp21XoLalMkx9e8CJDiEL6Y0N/eHe5iU1L738qSQ2PB
         WZXQ8BVuKkDIx0uCMH2ykpbyiKRhHqzczl5mzuL3waJqZVu4Z+d0sD1/+oZXoPEINGtn
         FcZnuB/dumkK94gbrB8DfK45Ri7cP39Htuc9Qj5uYbLESlRW2II+2BenYcdaTUzBAB3b
         qxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHQ2YbhZJ8mfF7GZbkHI7zjCObvWr7UpfRuc9La2dkY=;
        b=LLu9keuH3aKSL4Qdii00vKQ2Ohv7JAhjTssV74cdHPpRJoE1+8vVPPz6AHuR333RXd
         ZfJ6qftU9UnNwebJvDSs5WmWwKwDgkrb8N+wMbtT/72OZXDc3jfTZXQhRD+gB5kelAiI
         4kgCV11D//dxSI4WR6RznIU3Yt1l97HwLOj6OeHeo/umfAJdu/CBDDnOYXkLBYQv5gzG
         NO7FV+gpF3oVCdJSLUQJXwjknLlSHCU23XbVGEwK/SdrB3LHkbSb1UooMEM/GkXGUSn0
         MrHkovGOEe/VlTN03ZMrTmblJS72D7t+0TBFfEyGFhmjsUf4bcygRTLV0DlnSPZceAGt
         yWtA==
X-Gm-Message-State: AOAM532Ek8HbchQXpEmstBuuJ2wUFO2C3Lo1TVOoL0zSJCUxLqvUCLe2
        b2/qe0QFdUYFygSCHm1MbXEjkVfN+SW6/b2QtF4=
X-Google-Smtp-Source: ABdhPJzCbAHgGOZjXuM9Jl4B56FwGHQdUM9zZRQg6PVbS+r3XSl7iRQYXeTBL5obkInHEkwGKN+Wvf5/LNEJkF3r6Sw=
X-Received: by 2002:a05:6830:1da:: with SMTP id r26mr6567451ota.162.1628618285155;
 Tue, 10 Aug 2021 10:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
 <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
 <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com> <CAPkN8xLN_fKdbU8ugxLYJ1YeCJ8CxBWh+kdhAq1mR8hfAe-NAA@mail.gmail.com>
In-Reply-To: <CAPkN8xLN_fKdbU8ugxLYJ1YeCJ8CxBWh+kdhAq1mR8hfAe-NAA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Aug 2021 10:57:54 -0700
Message-ID: <CABPp-BEqvmSaqVrK=nQsk-8PNXq6Pzq4Y-=RopYwTDjtyitAuw@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 8:51 AM anatoly techtonik <techtonik@gmail.com> wrote:
>
> On Mon, Aug 9, 2021 at 9:15 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > The author wasn't interested in implementing that
> > suggestion (and it's a low priority for me that I may never get around
> > to).  The series also wasn't pushed through and eventually was
> > dropped.
>
> What it takes to validate the commit signature?

I'm not familiar with any of the gpg libraries, and don't even have an
active gpg key.  So, I don't know.  Some quick grepping shows that we
have gpg-interface.[ch], so we have some functions we can apparently
call.

> Isn't it the same as validating commit tag?

gpg signatures of tags are somewhat different than gpg signatures of commits:

* gpg signatures for tags are simply part of the annotated tag message
* gpg signatures for commits are stored in a separate commit header,
not just as extra text at the end of the commit message

This gpg signature handling for tags means that fast-import isn't even
aware of whether the tag is signed; it simply sees a commit message
and records it.  fast-export also would have been unaware and just
exported them as-is if someone hadn't written some special parsing for
it.  fast-import would need to do similar special parsing to become
aware of whether the tags are signed or not.  For now, fast-import
just keeps any tag messages as-is, and thus potentially writes invalid
tag signatures.  (The only way people have to control this is at the
fast-export side with the --signed-tags flag, which gives you the
choices of abort, strip, or keep the signatures even though they'll
likely be wrong.)  If fast-import were to gain knowledge of tag
signatures and an ability to validate them, it could offer smarter
options like keep-if-valid-and-discard-otherwise.

In contrast, the fact that gpg signatures for commits have to be
recorded as a separate commit header means they cannot be recorded in
fast-import without additional code changes.  And both the fast-export
and fast-import sides have to be made aware of and specially handle
the commit signatures for them to even get propagated, let alone
validated.

> Is it possible to merge at least the `--fast-export`
> part? The effect of roundtrip would be the same, but at least external
> tools would be able to detect signed commits and warn users.

The fact that it wasn't merged suggests there was some issue raised in
feedback that wasn't addressed.  I don't remember if that was the case
or not, but someone would have to find out, address any remaining
issues pointed out by feedback, and champion it through.

Personally, I don't like shoving a half solution through and think
there needs to be validation on the fast-import side added at the same
time, but others may disagree with me.  I have plenty of other
projects to work on, though, so whoever does the work will more likely
be the ones to decide.

> > [1] https://lore.kernel.org/git/20210430232537.1131641-1-lukeshu@lukeshu.com/
>
> > Yes, and I mentioned several other reasons why a round-trip from
> > fast-export through fast-import cannot be relied upon to preserve
> > object hashes.
>
> Yes, I understand that. What would be the recommended way to detect
> which commits would change as a result of the round-trip? It will then
> be possible to warn users in `reposurgeon` `lint` command.

There is no function or command that would check that kind of thing
short of doing the round-trip.  I provided a list of reasons IDs could
change as a starting point in case anyone wanted to try to write a
function or command that could check, and to point out that it is a
long list and might grow in the future.

I think practically, if you're doing a one-shot export (as I
originally assumed from your email), that you'd find out and then just
manually fix things up by hand.  If your goal is writing or changing a
general purpose filtering tool, then I'd suggest instead using the
alternate technique I outlined in the other thread you started at [2].

[2] https://lore.kernel.org/git/CABPp-BH4dcsW52immJpTjgY5LjaVfKrY9MaUOnKT3byi2tBPpg@mail.gmail.com/

> > (3) fast-export works by looking for the relevant bits it knows how to
> > export.  You'd have to redesign it to fully parse every bit of data in
> > each object it looks at, throw errors if it didn't recognize any, and
> > make sure it exports all the bits.  That might be difficult since it's
> > hard to know how to future proof it.  How do you guarantee you've
> > printed every field in a commit struct, when that struct might gain
> > new fields in the future?  (This is especially challenging since
> > fast-export/fast-import might not be considered core tools, or at
> > least don't get as much attention as the "truly core" parts of git;
> > see https://lore.kernel.org/git/xmqq36mxdnpz.fsf@gitster-ct.c.googlers.com/)
>
> Looks like the only way to make it forward compatible is to introduce
> some kind of versioning and a validation schema like protobuf. Otherwise
> writing an importer and exporter for each and every thing that may
> encounter in a git stream may be unrealistic, yes.
>
> > > P.S. I am resurrecting the old thread, because my problem with editing
> > > the history of the repository with an external tool still can not be solved.
> >
> > Sure it can, just use fast-export's --reference-excluded-parents
> > option and don't export commits you know you won't need to change.
>
> How does `--reference-excluded-parents` help to read signed commits?

It doesn't.  I was assuming you were doing a one shot export, namely
of the repository you linked to,
https://github.com/simons-public/protonfixes, and that you already
knew which commits were not going to be changed (because you pointed
them out in your email to the list) -- and in fact that it was only a
single commit affected, as you mentioned.

Armed with that knowledge, you could just export the parts of the
repository AFTER that commit, and use --reference-excluded-parents to
make sure the fast-export stream built upon them rather than squashing
all changes up to that point into the first commit in the stream.

> `reposurgeon` needs all commits to select those that are needed by
> different criteria. It is hard to tell which commits are not important without
> reading and processing them first.

Right, so you aren't trying to just handle this one repository, but
modify/create a general purpose tool that does so.  See my response in
the other thread you started, again at [2] above.

> > Or, if for some reason you are really set on exporting everything and
> > then editing, then go ahead and create the full fast-export output,
> > including with all your edits, and then post-process it manually
> > before feeding to fast-import.  In particular, in the post-processing
> > step find the commits that were problematic that you know won't be
> > modified, such as your signed commit.  Then go edit that fast-export
> > dump and (a) remove the dump of the no-longer-signed signed commit
> > (because you don't want it), and (b) replace any references to the
> > no-longer-signed-commit (e.g. "from :12") to instead use the hash of
> > the actual original signed commit (e.g. "from
> > d3d24b63446c7d06586eaa51764ff0c619113f09").  If you do that, then git
> > fast-import will just build the new commits on the existing signed
> > commit instead of on some new commit that is missing the signature.
> > Technically, you can even skip step (a), as all it will do is produce
> > an extra commit in your repository that isn't used and thus will be
> > garbage collected later.
>
> The problem is to detect problematic signed commits, because as I
> understand `fast-export` doesn't give any signs if commits were signed
> before the export.

Signed commits is just one issue, and you'll have to add special code
to handle a bunch of other special cases if you go down this route.
I'd rephrase the problem.  You want to know when _your tool_ (e.g.
reposurgeon since you refer to it multiple times; I'm guessing you're
contributing to it?) has not modified a commit or any of its
ancestors, and when it hasn't, then _your tool_ should remove that
commit from the fast-export stream and replace any references to it by
the original commit's object id.  I outlined how to do this in [2],
referenced above, making use of the --show-original-ids flag to
fast-export.  If you do that, then for any commits which you haven't
modified (including not modifying any of its ancestors), then you'll
keep the same commits as-is with no stripping of gpg-signatures or
canonicalization of objects, so that you'll have the exact same commit
IDs.  Further, you can do this today, without any changes to git
fast-export or git fast-import.
