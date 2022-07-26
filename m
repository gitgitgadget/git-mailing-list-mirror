Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2090AC43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 01:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGZB7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiGZB7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 21:59:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C524F20
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:59:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o1so10035046qkg.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gfJJCt0UVWqJfhzIC64FAu+nw0yc7sYfmG8kpEjxwSw=;
        b=CDgQvW17SsAZs2pht/cHzJdHoakK04v5YBpM4Elkz7G3jGcnUJXxGYwVX+f9nNgcRc
         Lvl+Q8W3JdFRUhUag2YCrUEe7JMKjQiSEXPumsinUB/btCzGpGV9pt/v1IobX9UOf+q4
         q2bwerH6bsdW/SLNuxknq8sDYteJsMEEAU/DzSZ8lqCAVokAEHq7y7D3tRF/RE62j3Z9
         AG6UgZF8opltJXZJx5cRxTlTZpSMWOhco1Kc9qYyDFAErQyHiO0Ym6BKQe0fUl/O4dZf
         SiqsWSMhydHPN8NLgpJSNux8o316+douxfLgAuZwyTYnB27WXPCaJFe0JT4OAQu4L8dc
         LVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfJJCt0UVWqJfhzIC64FAu+nw0yc7sYfmG8kpEjxwSw=;
        b=0Pn4WnBTDyR/vj7AmhcgMv7eQN7ApSfw5RAxwdpm5cSk9CVQ2ZMQCeyrUPz1xnqW1c
         i48SKEL3nPmAQMK+LTFwj5uXmWubakEVWDqiv2QtgPUm0GfXD2yjFVyLq4JHh7RroP3Q
         QI31Iog6C3LX/+S5CiPP6WFNAydh7fvvmH+YbXzNOSCWTTaa82QHi+dWXi12jYHtzDLz
         L6/nCFNvDDhebkHszFkWVf0JkxeUSLBlhsMKn0XRaj9yoYSKdvGY3vHwrQlOar7d30k0
         z5eABfEdGIOppLdttp8fhOp6UL2fsZctSfskDoPvJv8J2kp+YB2udIquWKcxiA92vMou
         TH1g==
X-Gm-Message-State: AJIora9A81ekAhb+ka9as2QnyZ49ygCbh2omq79fnaMlt1NbFqQ2I4Xl
        jnKnQGEUA3lQ7hE4+BiJslOk7Ydsy98Xh4aZjbE=
X-Google-Smtp-Source: AGRyM1uQOD6lc3d9CaVNfhwCP2KlnvGd+hHsFUdPsrSBhkzuyNKe6KfNv/QKrDq4eG2SZVVEzLG4KSROpbpTeRjwCbA=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr11213576qki.183.1658800744277; Mon, 25
 Jul 2022 18:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com> <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
 <220722.86sfmts9vr.gmgdl@evledraar.gmail.com> <CABPp-BHToEDv=8W9nf4XDC8b+5=EVuc=OnoT6xCRGWxB9CKWfw@mail.gmail.com>
 <220723.86h738qsr9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220723.86h738qsr9.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Jul 2022 18:58:53 -0700
Message-ID: <CABPp-BE99NVBKRn9Uh3HMcgzV-egtmgnuVJdvT1Rk5VrEKnd4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 10:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 22 2022, Elijah Newren wrote:
>
[...]
> > So, ignoring the return code from diff-index is correct behavior here.
> >
> > Were you thinking this was a test script or something?
>
> We can leave this for now.
>
> But no. Whatever the merge driver is documenting as its normal return
> values we really should be ferrying up abort() and segfault, per the
> "why do we miss..." in:
> https://lore.kernel.org/git/patch-v2-11.14-8cc6ab390db-20220720T211221Z-a=
varab@gmail.com/
>
> I.e. this is one of the cases in the test suite where we haven't closed
> that gap, and could hide segfaults as a "normal" exit 2.
>
> So I think your v5 is fine as-is, but in general I'd be really
> interested if you want to double-down on this view for the merge drivers
> for some reason, because my current plan for addressing these blindspots
> outlined in the above wouldn't work then...

Quoting from there:

> * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
>   git commands, they'll usually return their own exit codes on "git"
>   failure, rather then ferrying up segfault or abort() exit code.
>
>   E.g. these invocations in git-merge-one-file.sh leak, but aren't
>   reflected in the "git merge" exit code:
>
>src1=3D$(git unpack-file $2)
>src2=3D$(git unpack-file $3)
>
>   That case would be easily "fixed" by adding a line like this after
>   each assignment:
>
>test $? -ne 0 && exit $?
>
>   But we'd then in e.g. "t6407-merge-binary.sh" run into
>   write_tree_trivial() in "builtin/merge.c" calling die() instead of
>   ferrying up the relevant exit code.

Sidenote, but I don't think t6407-merge-binary.sh calls into
write_tree_trivial().  Doesn't in my testing, anyway.

Are you really planning on auditing every line of git-bisect.sh,
git-merge*.sh, git-sh-setup.sh, git-submodule.sh, git-web--browse.sh,
and others, and munging every area that invokes git to check the exit
status?  Yuck.  A few points:

  * Will this really buy you anything?  Don't we have other regression
tests of all these commands (e.g. "git unpack-file") which ought to
show the same memory leaks?  This seems like high lift, low value to
me, and just fixing direct invocations in the regression tests is
where the value comes.  (If direct coverage is lacking in the
regression tests, shouldn't the solution be to add coverage?)
  * Won't this be a huge review and support burden to maintain the
extra checking?
  * Some of these scripts, such as git-merge-resolve.sh and
git-merge-octopus.sh are used as examples of e.g. merge drivers, and
invasive checks whose sole purpose is memory leak checking seems to
run counter to the purpose of being a simple example for users
  * Wouldn't using errexit and pipefail be an easier way to accomplish
checking the exit status (avoiding the problems from the last few
bullets)?  You'd still have to audit the code and write e.g.
shutupgrep wrappers (since grep reports whether it found certain
patterns in the input, rather than whether it was able to perform the
search on the input, and we often only care about the latter), but it
at least would automatically check future git invocations.
  * Are we running the risk of overloading special return codes (e.g.
125 in git-bisect)

I do still think that "2" is the correct return code for the
shell-script merge strategies here, though I think it's feasible in
their cases to change the documentation to relax the return code
requirements in such a way to allow those scripts to utilize errexit
and pipefail.

>  >>  * I wonder if bending over backwards to emit the exact message we
> >>    emitted before is worth it
> >>
> >> If you just make this something like (untested):
> >>
> >>         {
> >>                 gettext "error: " &&
> >>                 gettextln "Your local..."
> >>         }
> >>
> >> You could re-use the translation from the *.c one (and the "error: " o=
ne
> >> we'll get from usage.c).
> >>
> >> That leaves "\n %s" as the difference, but we could just remove that
> >> from the _() and emit it unconditionally, no?
> >
> > ??
> >
> > Copying a few lines from git-merge-octopus.sh to get the same fix it
> > has is "bending over backwards"?  That's what I call "doing the
> > easiest thing possible" (and which _also_ has the benefit of being
> > battle tested code), and then you describe a bunch of gymnastics as an
> > alternative?  I see your suggestion as running afoul of the objection
> > you are raising, and the code I'm adding as being a solution to that
> > particular objection.  So this particular flag you are raising is
> > confusing to me.
>
> I wasn't aware of some greater context vis-as-vis octopus,

I didn't expect everyone to be, but that's why I put it in the commit
message.  ;-)
