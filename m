Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E456C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 03:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbhKYDPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 22:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbhKYDNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 22:13:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74C6C061A1D
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 18:48:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so19292717edd.0
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 18:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=70w3pSEmrrpFRwqCHH6Zn28iaLHBta2er3EVEdiXvec=;
        b=A8X8SofPhnua+L8fB8ny57LcvEpA2LG5SzHIdnTxAGClrMuDo2zEI4wpPWNjLUsO06
         VHqi+XyYVyjaBQzo9Hk65Rwt2O+p3Qs9skpdjG5bDl2SwjpH9XrhSrC+omzqiQ75knYa
         dk6pguOT5UCirhH1mcs6AjxE4U2I3qAvV6YNU3dLp8O9CHobxChTxxaZ85C4XWMqeAFU
         eSx0WKWLg0R23es4oLOCpeWqneLDmzpbngOQi2sgouD1H75bMdPnauj6qsOXJrJlDM0J
         mTANQWqvpKl32YMLibiQ4tM1TGr/WlfTXg/NfrnKikYGXqe7NUolPNkOhKY5+2l8tP0Q
         JLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=70w3pSEmrrpFRwqCHH6Zn28iaLHBta2er3EVEdiXvec=;
        b=M9QeLurVRRSGkCE1X2U9t2zA3XuXoiOg2d/JEBHzwvukA75tGgFshdhVcoXcsjwBD2
         qQWy1jOHpZNLtTNkQsLmNAueb/j4wWQ4TODxu6MLuTXGix2XKkbiBH3jvXsDTifN5yxs
         AQ4gx+Jq6PK8F1zkM0bxH4EJK8GiuGhPeI+2hxj+lt1gqvBioItiRAytisqVvSHiVJHG
         viL/YMra5DpzspDhBpa/SdIgo8hvcGh69oiDwVMfHw3YOEMLjgwEHbm65qbNgw5/sJkO
         rH4plgFRSWR40alnc6wis5T87vUPz+8G/zDa5yTfrs0+bZa03mVmY2Asmf2nexeS+hXD
         80/w==
X-Gm-Message-State: AOAM533P/kw8DqQS+h7e+C36KM1h5e9ZCRDjhj2yku4C1CRfh3ujO2RN
        9pCCU9tZMxDjAvGPp3mNUVZV2r54iDJk2shYqro/v3A8948=
X-Google-Smtp-Source: ABdhPJyGNLqy27hnaf77beLnRvf61Kz2xnF+gJw/+tAtIWlAPLUgFMcZnhIclgwebgqucmm3+KyhAo+Q9CyR7DYVyeE=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr33648849edx.244.1637808509280;
 Wed, 24 Nov 2021 18:48:29 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com> <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
In-Reply-To: <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Nov 2021 18:48:17 -0800
Message-ID: <CABPp-BETpWU9Rkd6pcxh6+gav2QtYnu_5V8ji_1_3kMnVswp1Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 3:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Nov 23 2021, Elijah Newren wrote:
>
> > On Tue, Nov 23, 2021 at 5:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
>
> >> Doesn't this series also change the behavior of e.g.:
> >>
> >>     cd contrib/subtree
> >>     git rm -r ../subtree
> >
> > Yes, of course!
> >
> > Before:
> >
> >     $ cd contrib/subtree
> >     $ git rm -r -q ../subtree/
> >     $ ls -ld ../subtree/
> >     ls: cannot access '../subtree/': No such file or directory
> >     $ git status --porcelain
> >     fatal: Unable to read current working directory: No such file or di=
rectory
> >     $ git checkout HEAD ../subtree/
> >     fatal: Unable to read current working directory: No such file or di=
rectory
> >
> > After:
> >
> >     $ cd contrib/subtree
> >     $ git rm -r -q ../subtree/
> >     $ ls -ld ../subtree/
> >     drwxrwxr-x. 1 newren newren 0 Nov 23 19:18 ../subtree/
> >     $ git status --porcelain
> >     D  contrib/subtree/.gitignore
> >     D  contrib/subtree/COPYING
> >     D  contrib/subtree/INSTALL
> >     D  contrib/subtree/Makefile
> >     D  contrib/subtree/README
> >     D  contrib/subtree/git-subtree.sh
> >     D  contrib/subtree/git-subtree.txt
> >     D  contrib/subtree/t/Makefile
> >     D  contrib/subtree/t/t7900-subtree.sh
> >     D  contrib/subtree/todo
> >     $ git checkout HEAD ../subtree/
> >     Updated 10 paths from c557be478e
> >
> > Very nice fix, don't you think?
>
> I'd be more sympathetic to this for the "checkout" etc. commands, but
> once I add a "-f" to that "rm" I'm *really* expecting it to rm the
> directory, but it won't anymore because it's in the underlying library
> function.

Please note that the command `git rm -rf dir` does not mean remove
`dir`.  It means forcibly and recursively remove all tracked paths
matching the pathspec `dir`.  There is certainly a difference, because
while it sometimes might end up deleting `dir`, it also might only
delete a subset of dir, and in some cases -- due to our added
conveniences -- it may also delete things outside of dir/.  It's been
that way for a decade and a half.  As such, the complaint that "`git
rm -rf dir` sometimes doesn't rm the directory" is not something new
being introduced by this series; that was already a possibility.  Yes,
I'm adding another case where that happens, but it's not some entirely
new qualitative difference.  More on this below.

> But if the goal is to get "git status" and the like working isn't a much
> more pointed fix to have setup.c handle the case of getting ENOENT from
> getcwd() more gracefully. I.e. currently (and even with your patches):
>
>     $ (mkdir blah && cd blah && rmdir ../blah && git status)
>     fatal: Unable to read current working directory: No such file or dire=
ctory
>
> Whereas if we do e.g.:
>
>         diff --git a/strbuf.c b/strbuf.c
>         index b22e9816559..3f9a957ff9d 100644
>         --- a/strbuf.c
>         +++ b/strbuf.c
>         @@ -600,6 +600,16 @@ int strbuf_getcwd(struct strbuf *sb)
>                                 return 0;
>                         }
>
>         +               if (errno =3D=3D ENOENT){
>         +                       const char *pwd =3D getenv("PWD");
>         +
>         +                       if (pwd) {
>         +                               warning(_("unable to getcwd(), bu=
t can read PWD, limping along with that..."));
>         +                               strbuf_addstr(sb, pwd);
>         +                               return 0;
>         +                       }
>         +               }
>         +
>                         /*
>                          * If getcwd(3) is implemented as a syscall that =
falls
>                          * back to a regular lookup using readdir(3) etc.=
 then
>
> We'll get:
>
>         $ (mkdir blah && cd blah && rmdir ../blah && GIT_DISCOVERY_ACROSS=
_FILESYSTEM=3D1 ~/g/git/git status)
>         warning: unable to getcwd(), but can read PWD, limping along with=
 that...
>         On branch master
>         Your branch is up to date with 'origin/master'.
>
>         Changes not staged for commit:
>           (use "git add <file>..." to update what will be committed)
>           (use "git restore <file>..." to discard changes in working dire=
ctory)
>                 modified:   ../strbuf.c
>
>         no changes added to commit (use "git add" and/or "git commit -a")
>
> I think that getenv("PWD") trick is widely supported, and once we get
> past that we seem OK. The relative path to strbuf.c is even correct.
>
> Currently you'd need to set GIT_DISCOVERY_ACROSS_FILESYSTEM=3D1 because w=
e
> run into another case in setup.c where we're not carrying that ENOENT
> forward, but we could just patch strbuf_getcwd() or that subsequent code
> to handle this edge case.

Ooh, nifty.  This sounds like a useful complement to this series; I'd
be in favor of it.

...
> I'm not concerned that you didn't research this change well enough, I
> just find it a bit iffy to introduce semantics in git around FS
> operations that don't conform with that of POSIX & the underlying OS. My
> *nix system happily accepts an "rm -rf" or an "rmdir" of the directory
> I'm in, I'd expect git to do the same.

This seems like an odd objection.  Semantics in git around FS
operations that don't conform with that of POSIX and the underlying OS
have been with us for a decade and a half now:

For example, if we ran the following:
  mkdir -p a/b/c
  touch a/b/c/{tracked,untracked}
  git commit -m "whatever" a/b/c/tracked
  cd a/b

Then we'd see the following:

`rm -rf ../b`: leaves a/ as an empty directory
`git rm -rf ../b`: does not nuke a/b/; in fact, it leaves
a/b/c/untracked around afterward

Also, if left a/b/c/untracked out of our setup, then we'd instead see
the following:

`rm -rf ../b`: leaves a/ as an empty directory
`git rm -rf ../b`: not only deletes a/b, but also deletes a/ -- the
parent of what was specified

Also, prior to d9b814cc97f1 (Add builtin "git rm" command,
2006-05-19), git rm would never delete the directories, so I guess you
can take our non-conforming behavior back even further than a decade
and a half.

> But whatever research we do on in-tree users we're left with changing
> behavior for users in the wild, e.g. a script that cd's to each subdir
> in a repo, inspects something, and if it wants to remove that does an
> "git rm -r" of the directory it's in, commits, and expects the repo to
> be clean afterwards.

Yes, this series is about changing behavior.  It's not an
optimization, or a code cleanup, or new command or anything.  It's
very specifically about git's behavior of deleting leading empty
directories after removing other files being limited to when those
empty directories are not the original current working directory of
the process.

However, although I still didn't know of any concrete or even
theoretical examples of problems this series would cause, I decided
after your email to do a bit more work; perhaps some of it will help:

  * I split this final patch in two, one for each affected function,
with much more detailed history and writeup.
  * remove_dir_recursively() already takes a flags parameter; I added
one for specifying whether the caller wants the traditional behavior
or this new behavior.
  * I revisited each and every caller of remove_path() and
remove_dir_recursively() and re-evaluated each one in case I had
missed something.  Of the 32 callers, most are unaffected by the
change.  Of those that are affected, most should take it, but I did
end up finding one that sometimes, in a very specific corner case,
should get the old behavior (namely when a submodule is present and
cwd is within the submodule and you pass all of --git-dir and
--work-tree and -f to rm when removing the submodule).  I added some
testcases and ensured it worked.

Since the flag is used, it's not at risk of being deleted, and thus
library callers can pick their preferred behavior.  Does that address,
or at least ameliorate, your concerns?

I'll submit the new series soon.

> I did follow/read at least one of the the original discussions[1] a bit,
> and some earlier discussion I'm vaguely recalling around bisect in a
> subdir.
>
> If the underlying goal is to address the UX problem in git of e.g. "git
> status" and the like hard-dying I wonder if something in the direction
> of the setup.c/strbuf.c change above might be more of a gentle change.
>
> That approach of a more gentler setup.c also has the benefit of having
> git work when it ends up in this situation without the git commands
> having landed it there, as in the above "rmdir" example.
>
> Anyway, I really didn't have time to look at this very carefully. I just
> remember looking into this with bisect/status etc. in the past, and
> thinking that these problems were solvable in those cases, i.e. they
> were just being overly anal about ENOENT, and not falling back on "PWD"
> etc.

The fact that git aborts in such directories is one obvious
manifestation of the problem, but my commit messages and cover letter
both called out that it can happen with non-git commands too.  I
certainly think your suggestion is very intriguing and worth pursuing,
but I think it complements rather than supplants this series.

> 1. https://lore.kernel.org/git/YS3Tv7UfNkF+adry@coredump.intra.peff.net/
