Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C7C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA760C3F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhHISQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhHISQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:16:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEEC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 11:15:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w6so24822104oiv.11
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Te3v+LAAICMRqd670E/15URCZ9eXaFfBdS3oORhUFhA=;
        b=lRLOZjPfwvORYlA9vwfXpLnXBvj6zIxaN7mzg4jGZiOwzWLFkWnSsclEiwe0iYTBX9
         xESL/Ws0JGCx2LI1Jfa8S0FzAzEVkALqwk/dmCRoRhVu/oFlzQPp53/SJ5qJpl/EatQi
         WWI2LDlxocE2sqtT+KuoaJCtnXF34HA6fEYik7upYGn/omzFxp56vP2oz5kkG/7pHhD9
         /PHPse/QuN+xyEILypnT0K64gTc+QJUkKbJEdccqb0UqFOiFwqPuf/sE442yh1ALmoC2
         NxcI6znRcHl8cuBdqz//I1+Lo1TBGCnHDPSSTOGp1VUG7IAFFfSewboV0VT+F8Z/VE8o
         234A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Te3v+LAAICMRqd670E/15URCZ9eXaFfBdS3oORhUFhA=;
        b=seMD8+kHGpqoUSvN1zE0JoRtiSk8suxUCiwW3MozxYKBXuja8Bxpl+50ebOwfsVQBB
         6XBLchHM1qWwOsdqJ5X3RLfMSlM6XLFIRl3ePgPu1vf8cWJhZW2aQzF4ftcTBL6uHtM2
         T8/0Elmn2pXGxYWhS4iFGg7zn6cc1L6y/EywPlELW8K/Hjyga0LvHXaecC8aSMSPSkD9
         opcKs7CZb1vBl8UZFE20zujcuRrYQooQkj14md3guVXDBGY/1hEktkXRqR6h/gJK0wK6
         qDopVeXnYnnDXzfLAeebVTTj2F3jLZtfuhh8UAhs1IGoF6wyFsy730ZZJRvjUPuFxlWD
         2yJQ==
X-Gm-Message-State: AOAM533PC4UFitOTlSTvEzf2nGORY59wszFLm2oTTnB2/u9aELkFhYuT
        EgX7UQT/GwLtCchmFA5bXNESH5PkcsBn9k6jFCY=
X-Google-Smtp-Source: ABdhPJyuYN4NAmhnEXDfZtG/TxoCwb81TIihrTj2TiBkKG36LV2BoUgSi0mVIV+CArGSMcOIJWVf5sht/VZr4P/gQOE=
X-Received: by 2002:aca:902:: with SMTP id 2mr317232oij.167.1628532955509;
 Mon, 09 Aug 2021 11:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
 <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
In-Reply-To: <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Aug 2021 11:15:44 -0700
Message-ID: <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 8:45 AM anatoly techtonik <techtonik@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 3:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Johannes Sixt <j6t@kdbg.org> writes:
> >
> > > Am 02.03.21 um 22:52 schrieb anatoly techtonik:
> > >> For my use case, where I just need to attach another branch in
> > >> time without altering original commits in any way, `reposurgeon`
> > >> can not be used.
> > >
> > > What do you mean by "attach another branch in time"? Because if you
> > > really do not want to alter original commits in any way, perhaps you
> > > only want `git fetch /the/other/repository master:the-other-one-s-master`?
> >
> > Yeah, I had the same impression.  If a bit-for-bit identical copy of
> > the original history is needed, then fetching from the original
> > repository (either directly or via a bundle) would be a much simpler
> > and performant way.
>
> The goal is to have an editable stream, which, if left without edits, would
> be bit-by-bit identical, so that external tools like `reposurgeon` could
> operate on that stream and be audited.

There were some patches proposed some months back[1] to make
fast-import allow importing signed commits...except that they
unconditionally kept the signatures and didn't do any validation,
which would have resulted in invalid signatures if any edits happened.
I suggested adding signature verification (which would allow options
like erroring out if they didn't match, or dropping signatures when
they didn't match but keeping them otherwise).  That'd help usecases
like yours.  The author wasn't interested in implementing that
suggestion (and it's a low priority for me that I may never get around
to).  The series also wasn't pushed through and eventually was
dropped.

However, that wouldn't fully solve your stated goal.  As already
mentioned earlier in this thread, I don't think your stated goal is
realistic; the only complete bit-for-bit identical representation of
the repository is the original binary format.

Your stated goal here, however, isn't required for solving the usecase
you present.

[1] https://lore.kernel.org/git/20210430232537.1131641-1-lukeshu@lukeshu.com/

> Right now, because the repository
> https://github.com/simons-public/protonfixes contains a signed commit
> right from the start, the simple fast-export and fast-import with git itself
> fails the check.

Yes, and I mentioned several other reasons why a round-trip from
fast-export through fast-import cannot be relied upon to preserve
object hashes.

> I understand that patching `git` to add `--complete` to fast-import is
> realistically beyond my coding abilities, and my only option is to parse

It's more patching than that which would be required:
(1) It'd be both fast-export and fast-import that would need patching,
not just fast-import.
(2) --complete is a bit of a misnomer too, because it's not just
get-all-the-data, it's keep-the-data-in-the-original-format.  If
objects had modes of 040000 instead of 40000, despite meaning the same
thing, you'd have to prevent canonicalization and store them as the
original recorded value or you'd get a different hash.  Ditto for
commit messages with extra data after a NUL byte, and a variety of
other possible issues.
(3) fast-export works by looking for the relevant bits it knows how to
export.  You'd have to redesign it to fully parse every bit of data in
each object it looks at, throw errors if it didn't recognize any, and
make sure it exports all the bits.  That might be difficult since it's
hard to know how to future proof it.  How do you guarantee you've
printed every field in a commit struct, when that struct might gain
new fields in the future?  (This is especially challenging since
fast-export/fast-import might not be considered core tools, or at
least don't get as much attention as the "truly core" parts of git;
see https://lore.kernel.org/git/xmqq36mxdnpz.fsf@gitster-ct.c.googlers.com/)

> the binary stream produced by `git cat-file --batch`, which I also won't
> be able to do without specification.

The specification is already available in the manual.  Just run `git
cat-file --help` to see it.  Let me quote part of it for you:

       For example, --batch without a custom format would produce:

           <sha1> SP <type> SP <size> LF
           <contents> LF

> P.S. I am resurrecting the old thread, because my problem with editing
> the history of the repository with an external tool still can not be solved.

Sure it can, just use fast-export's --reference-excluded-parents
option and don't export commits you know you won't need to change.

Or, if for some reason you are really set on exporting everything and
then editing, then go ahead and create the full fast-export output,
including with all your edits, and then post-process it manually
before feeding to fast-import.  In particular, in the post-processing
step find the commits that were problematic that you know won't be
modified, such as your signed commit.  Then go edit that fast-export
dump and (a) remove the dump of the no-longer-signed signed commit
(because you don't want it), and (b) replace any references to the
no-longer-signed-commit (e.g. "from :12") to instead use the hash of
the actual original signed commit (e.g. "from
d3d24b63446c7d06586eaa51764ff0c619113f09").  If you do that, then git
fast-import will just build the new commits on the existing signed
commit instead of on some new commit that is missing the signature.
Technically, you can even skip step (a), as all it will do is produce
an extra commit in your repository that isn't used and thus will be
garbage collected later.
