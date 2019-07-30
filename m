Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBBB1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 13:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfG3NCG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 09:02:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36167 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfG3NCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 09:02:05 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so24212894iom.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=neWa1oZzZzNY3ibR78HDoSnEnTithFdfJE820NLNczU=;
        b=SdD5Juq/U7YcD7WSW3yuA1+w9BZXJzus7cOmAe+sG9gQt8JXrZ411Z4rHKhP5FLNgA
         zFErJD57vSRoWpZmhepvRHD9VWVw8MEQV2BEsNWc7W3LFfNx3M57MwFHVCzFZnpBH4KC
         e4q8gjkR3XldwZDfd6j83wdcTQ8P3PXmWHS+r79rg/xK+QLpJtIagubvo33UnVzuefJr
         HAS1c1SsS0Lu1SHnSYb3N7RLR9BWCmtitcwMG8Wfl5+wIMUd5HvEbtR4gEaxLp39fDye
         vkX/Aq3ppP9qHef3XtD+GwiFBBb2AW5uHz9ckOyNXfT4kBvKS3YtyH/4U1JSxTxOL5t1
         +g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=neWa1oZzZzNY3ibR78HDoSnEnTithFdfJE820NLNczU=;
        b=rbClot2zraghYPxZ3GyNw/qqvd/dVGthavMDs5o025SCVdbr1jN/fGFyH1HYrpHuAe
         fV31eQT9cEHOnO//7VGW6YOsBSpGCiV9W6ob5iqhlbZEFwSwyv95Egy7axONWDgu3JJk
         meqSfbHTqvl14Mb5QWfnAbLKAZbycXOS3+7F87DYeaoX0LBje1TpJwHQjh7QkKalSt0W
         OMA1sxoPgWseczwp0vqWDow7M6bf8YSWEOjhqBbPM5wU/ZTUVL+hMvhmn0qNKwvUOPb0
         t24ljjbUYrViAAuBR81ceshsfpEbkBlgWUtUMc33tWi8xOqRwHI7cvCywJ2HEGosEXM5
         5duA==
X-Gm-Message-State: APjAAAXSSBVHihbmHmNqUGhzEL7C/m+c4RkJUTn+0dDBrQGQmh+Qd4Q8
        wA+Qgtt+H//jtxD0lEBEvndyH4UgOx66you2V4I=
X-Google-Smtp-Source: APXvYqwA3JLGLypJA7vIWo8cdtndguZNx+KZ6Btg6OMl3TCw0tnJHc94KaeAJMZ3FAyQunJPbOpDu0VzDjVOLIkSADY=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr9988393iok.252.1564491724262;
 Tue, 30 Jul 2019 06:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <8736ip6wzk.fsf@evledraar.gmail.com>
 <CAPUEspgQNCENviPYP6X790DvSgj_RpJVo2KP_39voLQnVc65pQ@mail.gmail.com> <87wog15834.fsf@evledraar.gmail.com>
In-Reply-To: <87wog15834.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 30 Jul 2019 06:01:53 -0700
Message-ID: <CAPUEspiqKim_Ypc+PPZPKvqQu9DvW7D+mHxB9cyheo8FDQs3VQ@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 5:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jul 29 2019, Carlo Arenas wrote:
> > On Mon, Jul 29, 2019 at 1:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Mon, Jul 29 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> >>
> >> > PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 neve=
r
> >> > had one, forcing the use of JIT if -P was requested.
> >>
> >> What's that PCRE1 compile-time flag?
> >
> > NO_LIBPCRE1_JIT at GIT compile time (regardless of JIT support in the
> > PCRE1 library you are using)
>
> Ah of course, I was reading this as "regexp
> compile-time". I.e. something like (*NO_JIT). No *such* thing exists for
> PCRE v1 JIT AFAIK as exposed by git-grep.

correct, but there are still other knobs like (*UTF), (*UCP), (?m) or
(?i) that also
affect some of our assumptions.

> >> > After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> >> > the PCRE2 engine will be used more broadly and therefore adding this
> >> > knob will give users a fallback for situations like the one observed
> >> > in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:
> >> >
> >> >   $ git grep 'foo bar'
> >> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >> >   $ git grep -G 'foo bar'
> >> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >> >   $ git grep -E 'foo bar'
> >> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >> >   $ git grep -F 'foo bar'
> >> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >>
> >> Yeah that obviously sucks more with ab/no-kwset, but that seems like a
> >> case where -P would have been completely broken before, and therefore =
I
> >> can't imagine the package ever passed "make test". Or is W^X also
> >> exposed as some run-time option on OpenBSD?
> >
> > ironically, you could use PCRE1 since that is not using the JIT fast
> > path and therefore will fallback automatically to the interpreter
>
> ...because OpenBSD PCRE v1 was compiled with --disable-jit before, but
> their v2 package has --enable-jit, it just doesn't work at all? Is this
> your custom built git + OpenBSD packages of PCRE coming with the OS?

sorry for the confusion, custom builds of both PCRE and git.
and I was referring to the fact that after 685668faaa (grep: stop
using a custom JIT stack with PCRE v1, 2019-07-26)
and with my patches to avoid UTF-8 issues, git + PCRE1 was a much pleasant
experience than git + PCRE2 in OpenBSD (which is also why I didn't
even care about fixing it for pcre.jit=3D!1 yet)

as shown by :
$ git grep 'foo bar' Documentation | cat
Documentation/RelNotes/1.8.0.txt:   when the user says "git checkout
-b -t foo bar" (e.g. "-t" is not a
Documentation/git-rev-list.txt: $ git rev-list foo bar ^baz
Documentation/gitattributes.txt:abc foo bar baz
$ git grep -P 'foo bar' Documentation | cat
Documentation/RelNotes/1.8.0.txt:   when the user says "git checkout
-b -t foo bar" (e.g. "-t" is not a
Documentation/git-rev-list.txt: $ git rev-list foo bar ^baz
Documentation/gitattributes.txt:abc foo bar baz
$ git grep -P 'foo[ ]bar' Documentation | cat
Documentation/RelNotes/1.8.0.txt:   when the user says "git checkout
-b -t foo bar" (e.g. "-t" is not a
Documentation/git-rev-list.txt: $ git rev-list foo bar ^baz
Documentation/gitattributes.txt:abc foo bar baz
$ dmesg | grep git
git-grep(87484): mmap W^X violation

the last of which might be suppressed with `-c pcre.jit=3D0` once I get
to fix that

> I don't use OpenBSD, but isn't this their recipe? Seems they use "make
> test", and don't compile with PCRE at all if I'm reading it right:
> https://github.com/openbsd/ports/blob/master/devel/git/Makefile

yes, I was using OpenBSD as a testbase where issues with JIT would
be easily reproducible; their packagers are smart enough not to enable
JIT by default in PCRE or even link it with git as you pointed out.

NetBSD/HardenedBSD might be a better example of a native default package th=
at
would be affected in its standard configuration, if that is what you
were looking for.

> >> I.e. aside from the merits of such a setting in general these examples
> >> seem like just working around something that should be fixed at make
> >> all/test time, or maybe I'm missing something.
> >
> > 1) before you could just avoid using -P and still be able to grep
> > 2) there is no way to tell PCRE2 to get out of the way even if you are
> >     not using -P
>
> Right, no arguments at all about ab/no-kwset making this worse (re: your
> #1). I just really prefer not to expose/document config for what
> *should* be something purely internal if the X-Y problem is a bug being
> exposed that we should just fix.
>
> Particularly because I think it's a losing battle to provide run-time
> options for what are surely a *lot* of "make test" failures.

not sure I understand.  The knob was there to give flexibility to the user
to decide for himself how he wants to use the application and how that
use fits in their environment.

we can't predict either of those with 100% certainty and while it makes
sense we will impose some constrains we should understand that the
more inflexible those are, the more users will be alienated.

this specific constrain is particularly silly, even PCRE recommends using
JIT only as an optimization and fallback to the interpreter but we don't
follow that advice and the least we could do is give a escape hatch to
the users.

> If it really is unavoidable to detect this until runtime in some common
> configurations I have no problem with it, I just haven't encountered
> that so far.

guess it is sort of a chicken/egg problem and we would rather have
OpenBSD never linking their git with PCRE.

FWIW we can't know ahead of time if someone setup will include
running a PAX/SELinux enabled kernel on their otherwise regular
userspace encountering this problem.

there is also the case of Linux distributions without official packages
(like Gentoo and Arch) where each user decides which options they
want to use on their packages at their own time.

> patches =3D your recent
> https://public-inbox.org/git/20181209230024.43444-2-carenas@gmail.com/
> or something earlier?
>
> That patch seems sane without having tested it. Seems like the
> equivalent of what we do with v1 with PCRE2_JIT_COMPLETE.

I am missing context here; that patch was obsoleted by your ab/pcre-jit-fix=
es
branch and has nothing to do with PCRE2_JIT_COMPLETE.

if I recall correctly, was waiting on feedback on the series on top of your
original pcre-jit-fixes branch (with only 3 patches) and that was posted in=
:
https://public-inbox.org/git/20190726202642.7986-1-carenas@gmail.com/T/#u

> I *am* curious if there's setups where fixing the code for PCRE v1 isn't
> purely an academic exercise. Is there a reason for why these platforms
> can't just move to PCRE v2 in principle (dumpster fires in "next"
> non-withstanding)?

how can you expect me (or anyone else) to answer that question? obviously
we don't know, I personally for sure have no problem.

brian mentioned[1] some CentOS 6 users that don't have PCRE2 in their syste=
ms,
I mentioned Xcode's git in macOS as likely not updating since it uses
a system library
and that is also used by several other applications (like Safari)

but regardless of that, I see no reason for making their life more
difficult; PCRE1 is
widely used, it is still being supported, and they can use PCRE2 as an
alternative
most of the time (at least with git)

Carlo

[1] https://public-inbox.org/git/20190615191514.GD8616@genre.crustytoothpas=
te.net/
