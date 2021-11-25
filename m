Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E23C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhKYLy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhKYLw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:52:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED94BC06179F
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:47:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so24286651edd.13
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KoFii6kAMV6An4wfYCRdUpFKGTsSy8w8quu5SxQXNvY=;
        b=l4/Fuf+/GyRXWt+mQYpTowZk9ZoO8a9XsLbDZIjiUEe4KQLmaBadZWLFEPX++OrMoA
         5mFdTkeFZGbfCdPxSQIRUDW3yetVV7kSZ08JE7crEpEuPwJH83dKbD70qY70hFhLNhcF
         +K34HRoT4+F+JdDmcfXJwDabxZEwyWoe4pKEaFDor44B+v4h2tjeGtHRGamYd04QSTDx
         yXHLzURGZnnzXc3L/oQWNHg1hOLR83k2NHFsL1UTtqyxzXDHkhUpRfsB7bKbMffFewj8
         Hn9Kl3XUzgIvByqEQjqwnmQhQaSN1IJo5LgznvbH+8u136lXcqwvRIxIQj1DAoztT1Zt
         UxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KoFii6kAMV6An4wfYCRdUpFKGTsSy8w8quu5SxQXNvY=;
        b=tsmULqqsIH24j3OlZvyqVm/G1z36mRT3gsp1uRKZBqmLtk+OP0RffDF6/w3fGurVHY
         /2uxEQVVsz52U1lNtMbDzRS6mtFVw05or9ACbVOUhTvrY09BJwLHvmEvmmqCrkHXiqEw
         U7RrE16CVd7UYS4DBFIQfm7cyV5PZJROZGo7p06ZnzhsJR3ZptN2NWmnAed4e/m+R8LU
         LKuqwhqVUVXWK1Eb2ATDn7zMptiKMbYAJVVSJeBySnCirmPxMoe0b7U6RXPzHr28hFzY
         kPONwdHaovxsadRC169LEFktfszCMFqwAyytG9csR5sVPCG0Gz0ui7pbK/9LWX+KWWeX
         od7w==
X-Gm-Message-State: AOAM533uLNJQwCRLdLn9E0HhjajwjNOChJJhKn5G/psjqbHJLOpRhcc3
        LQZnA/3qf7oSP5k0U/Noi/A=
X-Google-Smtp-Source: ABdhPJxw2cfOZCZCE7Oz3guaW6hagkOhykzxhtcZ1qHtXc1EX9lfNIINnj7oYsHBT+MaMoRoIePjAA==
X-Received: by 2002:a17:907:b17:: with SMTP id h23mr30884348ejl.80.1637840832289;
        Thu, 25 Nov 2021 03:47:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c8sm1598121edu.60.2021.11.25.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:47:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqDDb-0005sr-7h;
        Thu, 25 Nov 2021 12:47:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/8] t2501: add various tests for removing the current
 working directory
Date:   Thu, 25 Nov 2021 11:04:46 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
        <211121.867dd11jbl.gmgdl@evledraar.gmail.com>
        <CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZeOH1kRw@mail.gmail.com>
        <211123.86czmrwqqo.gmgdl@evledraar.gmail.com>
        <CABPp-BH-MtGLAk3vkFCXr8sB3KmMEp98J1wpjO=v6MbXH4tPHg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BH-MtGLAk3vkFCXr8sB3KmMEp98J1wpjO=v6MbXH4tPHg@mail.gmail.com>
Message-ID: <211125.86tug0ihj4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Elijah Newren wrote:

> On Mon, Nov 22, 2021 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Nov 22 2021, Elijah Newren wrote:
>>
>> > On Sun, Nov 21, 2021 at 9:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
>> >> On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:
>> >>
>> >> > From: Elijah Newren <newren@gmail.com>
>> >>
>> >> > +test_expect_failure 'checkout fails if cwd needs to be removed' '
>> >> > +     git checkout foo/bar/baz &&
>> >> > +     test_when_finished "git clean -fdx" &&
>> >> > +
>> >> > +     mkdir dirORfile &&
>> >> > +     (
>> >> > +             cd dirORfile &&
>> >> > +
>> >> > +             test_must_fail git checkout fd_conflict 2>../error &&
>> >> > +             grep "Refusing to remove the current working director=
y" ../error
>> >> > +     ) &&
>> >> > +
>> >> > +     test_path_is_dir dirORfile
>> >>
>> >>
>> >> I'd find this & the rest of this series much easier to understand if =
we
>> >> started out by positively asserting the current behavior here, and
>> >> didn't test_cmp/grep for erro r messages that don't exist anymore.
>> >
>> > Yeah, this is my fault for my bad commit message.  I stated I was
>> > adding tests checking for the problems of interest, making it sound
>> > like I was testing existing behavior, but I should have stated I was
>> > adding tests with the behavior we'd prefer to have (i.e. basically a
>> > test-driven-development) setup.
>> >
>> > Also, there really wouldn't need to be so many tests for describing
>> > the existing behavior.  It's basically just `git
>> > $OPERATION_THAT_REMOVES_CWD_AS_SIDE_EFFECT` followed by nearly any
>> > other git command will cause the second and later commands to fail
>> > with:
>> >
>> > ```
>> > shell-init: error retrieving current directory: getcwd: cannot access
>> > parent directories: No such file or directory
>> > fatal: Unable to read current working directory: No such file or direc=
tory
>> > ```
>> >
>> > However, we do need a lot of tests for corrected behavior, because
>> > there are so many different codepaths we can follow which will lead to
>> > deletion of the current working directory.
>>
>> Currently if I do e.g.:
>>
>>     git checkout master
>>     git clean -dxf
>>     cd perl
>>     git checkout v0.99
>>     cd ../
>>     git clean -dxfn
>>
>> Nothing breaks and I don't end up with an empty perl/ to remove. With
>> these patches we'd either die on the "checkout" (I think) keep the
>> "perl" and have an empty perl/ to report in the "git clean -dxfn" at the
>> end (I'm not sure which, I forgot and haven't re-read this series just
>> now).
>
> You'd have an empty perl/ left after the checkout, which would be
> cleaned up by your final git clean command.

FWIW that's with a -n, just showing that we've got things left.

I.e. just a demo of the new state, in any case not really applicable
since the end-state behavior is that we die...

>> I think changing it anyway might be justifiable, but changing the
>> behavior of things like that tickles my spidey sense a bit. I.e. I can
>> see people having written scripts like that which would break (it's
>> often easier to cd around after globbing than staying at the top-level,
>> then jump back).
>
> I disagree this would break any user scripts.  If people expect a 'git
> checkout' or 'git rebase' to always work, their script is _already_
> broken.

Broken as in they'll upgrade git and a previously working script or
cronjob stops working.

Maybe it's too obscure to worry about, but saying nothing broke that
wasn't working before seems to be moving goalposts to an odd place.

Anyway, I see from
https://lore.kernel.org/git/CABPp-BETpWU9Rkd6pcxh6+gav2QtYnu_5V8ji_1_3kMnVs=
wp1Q@mail.gmail.com/
that you're not really saying that & that we've partially got a split
thread here. Just replying here...

> The presence of any untracked files within the directory
> already results in a hard error -- we refuse to remove non-empty
> directories (unless all files are tracked and unmodified).  This rule
> deserves a clarification: treat the current working directory as
> non-empty since the parent process is likely still parked there..

I'm not going to make this my hill to die on, and honestly wouldn't care
that much if this were changed, aside from wondering how much is really
the x-y problem of setup.c.

But just in the interest of clarity, what I'm talking about is that git
is a *nix tool, and usually just follows *nix FS semantics.

I think we should have a strong bias towards continuing until the OS
tell us to stop for any FS operations. Rather than aborting early in
anticipation of an eventual error, particularly when as I've shown that
eventual error is fixable.

> Further, our own commands are broken/misbehaving due to us not
> erroring out; see e.g.
> https://lore.kernel.org/git/xmqqv93n7q1v.fsf@gitster.g/ and its
> grandparent.  User scripts likely have lurking problems too.

*Nod*. Not to go on about it, but I think those issues are pointing out
things that would be fixed by the the more narrow WIP patch I've got of
"let's just make setup.c not suck in that case" :)

>> So I wonder (especially with Glen's comment in
>> <20211123003958.3978-1-chooglen@google.com>) if this is being done at
>> the right API level.
>
> Glen's comment was interesting, but provided no specifics about how
> the changes I made could cause any possible harm in his case.
> Further, the fact that others are adding extra places doing cleanup
> sound like additional codepaths that should be protected for the exact
> same reasons.  I think we absolutely want my changes affecting his new
> codepaths.

Again, "not my hill" etc., but I think the harm is pretty much that
every time we start adding any sort of unexpected special-sauce on top
of doing stuff until we get a syscall error we're subverting the default
expectations of users.

I think about this as being in the same category as changing "checkout",
"rm" etc. to error out if we detect the target file is open (Windows),
or refusing to remove an executable that we detect as being in use
(AIX).

If you're not on those platforms having a random tool you're scripting
imposing strictures outside of what the OS would do is just another
thing to explain to users. Let's just try and run into the OS error, or
fix our handling of the subsequent error (if any).

>> E.g. maybe it would be better for some commands to
>> ease into this with an advise() or warning() and not a die() or error(),
>> or have the die() be in the likes of "git switch" but not "reset
>> --hard".
>
> The commands that don't need to remove the current working directory
> but just were as a convenience, no longer do and continue on just
> fine.  Commands that need to remove the current working directory in
> order to place a file there will error out, just as they would have
> when trying to remove a directory with untracked files.  I see no need
> to ease into anything here.

Whatever direction we decide on here, I really don't think it makes
sense to think about tracked and modified local content the same as
untracked and unmodified content.

For "tracked and modified" we clearly "own" it, and erroring out is what
everyone would expect us to do. We don't want git to shred user data.

For "untracked and unmodified" (the part after "and" being redundant
:-)) we've got the "precious" edge-case, i.e. we could shred something
the user cares about (which you've also been working on & I very much
applaud).

But I think by any sane definition we'd still classify such content as
less important (since in those cases of shredding it's matching a
.gitignore).

And surely *way lower* in that foodchain is "untracked and
irrelevant". I.e. it's conceivable that someone is making meaningful use
of an empty directory, but it's very unlikely, and in any case your
argument for this change isn't that the directory is important per-se,
but that=20

You note in
https://lore.kernel.org/git/CABPp-BETpWU9Rkd6pcxh6+gav2QtYnu_5V8ji_1_3kMnVs=
wp1Q@mail.gmail.com/
that for "rm -r" we already left the directory behind for a "dir" that
had partially tracked/untracked content, that's correct. I'm referring
to the case where "x" is entirely tracked.

>> Or maybe not, just food for thought...
>
> You may also be interested in reading more of the other thread I
> linked to from my cover letter; all these cases were discussed in good
> detail over there.  For example, look at
> https://lore.kernel.org/git/CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDb=
dz7CCA@mail.gmail.com/.
> Peff's previous suggestion was to just make the commands error out if
> they'd normally remove the current working directory and require the
> user to run from a different directory instead.  My version lightened
> that requirement so it only errors out if the current working
> directory needed to be removed in order to place something else there
> (and if nothing else was needed to be placed there, then just leaving
> the directory around).

I've read through those, and might have missed something, but it seems
to all really be discussing the shortcomings of setup.c's handling of
failing getcwd() by proxy.

That and references to other 3rd party commands potentially being
equally confused.

In summary I think we should aim more towards:

    $ grep -m 1 Git ../README.md=20
    Git - fast, scalable, distributed revision control system

Than:

    $ git grep --no-index -m 1 . ../README.md=20
    fatal: Unable to read current working directory: No such file or direct=
ory

Which fails due to the setup.c issue I've noted, but also because we
stupidly really translate that to the equivalent of a (in an x/ that
doesn't exist anymore):

    $ grep -m 1 Git ../x/../README.md=20
    grep: ../x/../README.md: No such file or directory


