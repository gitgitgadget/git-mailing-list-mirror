Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF89C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 11:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhKXLg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhKXLg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 06:36:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EDC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:33:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so8892497edq.7
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Zs/YOTywqoRHW3pp3K+jqn8aIcFgI8PYNkntOWRoBTs=;
        b=pw9Mjym0zsbgIjfRx/w0n7rn6L2DfAiMWJLSgixKO+VuyjPQ7BUKDMnKNCWaUA5tgz
         ifrHNuaB95XFTJnmfGevtgpHfQJiAcMXGi7HXa7uY7DF/XUMyFoh2NZgbm1MTQuOIR62
         cOe7HF2bAEVHb8SVByIYGFtVuIYxJftP9WZNFZ4dZQGeVNWDwWKhDO+7b1Ws0e5LHAcA
         dAWkpn7CLCZMpRXXiZm8TR3mUPKwiID2FQ9+Hb4P7zYrcduWClpboPAQxkan3htLtUSv
         D1tYvVf/hiqPpgaIz6rWaIImyorJy7yxUIED+RhZluAEVBTXSpZaqLMdaJb/AetA+biV
         yWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Zs/YOTywqoRHW3pp3K+jqn8aIcFgI8PYNkntOWRoBTs=;
        b=jmXEQTVaWfFkSGQLaRMkWm23QNb1wkCKhVOt2gtE/H1yy71SK0HsxZrOtRCPA2b5Dp
         uGUqUqfgC51WQq3liTujU3403wKqG+ROCH931J3mKPYILcT9qHM3Qjka1yKxK46iGaRJ
         6hAYyXPjXkg/wuqlmvZVKWbF46Rk8WuAoC3dIOVo9feW6bnOBLrjGVno39RxuD3wjwQu
         hmLFqGcBbowuVX0sYgt5rzIpHvoBz4IuUF+5P23Fq2hGYFckSJE2eQ6LFRJ05Btywn2X
         5yo2etclKB9FKfHRmJIl1aDz6BILdu7djNbQQluVpVSl6ldrr+SPgyacB+5ah4XbJlVb
         oMkg==
X-Gm-Message-State: AOAM531dR3grHjL3HqtAhjghbZtucuf1vMEUEABMWlS6BqTf/GWd8SWj
        5AgLavWHDP1eg/oprSMJpUuddafXyL6o7A==
X-Google-Smtp-Source: ABdhPJzB2G36bf9m1cZkdQdIlw1SvAOJpPuIubPswAHSjDiwqhdeYs4o6z0qOlhRBaCk2LaIssomOA==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr23944703edu.186.1637753626471;
        Wed, 24 Nov 2021 03:33:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p26sm6742154edt.94.2021.11.24.03.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:33:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpqX3-000AqS-Ej;
        Wed, 24 Nov 2021 12:33:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Date:   Wed, 24 Nov 2021 12:14:05 +0100
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
 <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
 <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
Message-ID: <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Elijah Newren wrote:

> On Tue, Nov 23, 2021 at 5:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:

>> Doesn't this series also change the behavior of e.g.:
>>
>>     cd contrib/subtree
>>     git rm -r ../subtree
>
> Yes, of course!
>
> Before:
>
>     $ cd contrib/subtree
>     $ git rm -r -q ../subtree/
>     $ ls -ld ../subtree/
>     ls: cannot access '../subtree/': No such file or directory
>     $ git status --porcelain
>     fatal: Unable to read current working directory: No such file or dire=
ctory
>     $ git checkout HEAD ../subtree/
>     fatal: Unable to read current working directory: No such file or dire=
ctory
>
> After:
>
>     $ cd contrib/subtree
>     $ git rm -r -q ../subtree/
>     $ ls -ld ../subtree/
>     drwxrwxr-x. 1 newren newren 0 Nov 23 19:18 ../subtree/
>     $ git status --porcelain
>     D  contrib/subtree/.gitignore
>     D  contrib/subtree/COPYING
>     D  contrib/subtree/INSTALL
>     D  contrib/subtree/Makefile
>     D  contrib/subtree/README
>     D  contrib/subtree/git-subtree.sh
>     D  contrib/subtree/git-subtree.txt
>     D  contrib/subtree/t/Makefile
>     D  contrib/subtree/t/t7900-subtree.sh
>     D  contrib/subtree/todo
>     $ git checkout HEAD ../subtree/
>     Updated 10 paths from c557be478e
>
> Very nice fix, don't you think?

I'd be more sympathetic to this for the "checkout" etc. commands, but
once I add a "-f" to that "rm" I'm *really* expecting it to rm the
directory, but it won't anymore because it's in the underlying library
function.

But if the goal is to get "git status" and the like working isn't a much
more pointed fix to have setup.c handle the case of getting ENOENT from
getcwd() more gracefully. I.e. currently (and even with your patches):

    $ (mkdir blah && cd blah && rmdir ../blah && git status)
    fatal: Unable to read current working directory: No such file or direct=
ory

Whereas if we do e.g.:
=09
	diff --git a/strbuf.c b/strbuf.c
	index b22e9816559..3f9a957ff9d 100644
	--- a/strbuf.c
	+++ b/strbuf.c
	@@ -600,6 +600,16 @@ int strbuf_getcwd(struct strbuf *sb)
	                        return 0;
	                }
=09
	+               if (errno =3D=3D ENOENT){
	+                       const char *pwd =3D getenv("PWD");
	+
	+                       if (pwd) {
	+                               warning(_("unable to getcwd(), but can rea=
d PWD, limping along with that..."));
	+                               strbuf_addstr(sb, pwd);
	+                               return 0;
	+                       }
	+               }
	+
	                /*
	                 * If getcwd(3) is implemented as a syscall that falls
	                 * back to a regular lookup using readdir(3) etc. then

We'll get:
=09
	$ (mkdir blah && cd blah && rmdir ../blah && GIT_DISCOVERY_ACROSS_FILESYST=
EM=3D1 ~/g/git/git status)
	warning: unable to getcwd(), but can read PWD, limping along with that...
	On branch master
	Your branch is up to date with 'origin/master'.
=09
	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git restore <file>..." to discard changes in working directory)
	        modified:   ../strbuf.c
=09
	no changes added to commit (use "git add" and/or "git commit -a")

I think that getenv("PWD") trick is widely supported, and once we get
past that we seem OK. The relative path to strbuf.c is even correct.

Currently you'd need to set GIT_DISCOVERY_ACROSS_FILESYSTEM=3D1 because we
run into another case in setup.c where we're not carrying that ENOENT
forward, but we could just patch strbuf_getcwd() or that subsequent code
to handle this edge case.

>> If so then re the "spidey sense" comment I had earlier: There's no rm
>> codepaths or tests changed by this series,
>
> That's not correct; I explicitly added a new rm test in the first
> patch in my series.  Further, that same test was modified to mark it
> as passing by this particular patch you are commenting on.

Sorry about that, I didn't look carefully enough.

>> so the implementation of
>> doing it at this lower level might be casting too wide a net.
>
> I'm getting the vibe that you are assuming I'm changing these two
> functions without realizing what places might be calling them;
> basically, that I'm just flippantly changing them.  Ignoring the
> ramifications of such an assumption, if this vibe is correct[...]

Sorry no, I didn't mean to imply that. I snipped the rest, but hopefully
this answers the questions you had well enough (and in the time I have
for this reply):

I'm not concerned that you didn't research this change well enough, I
just find it a bit iffy to introduce semantics in git around FS
operations that don't conform with that of POSIX & the underlying OS. My
*nix system happily accepts an "rm -rf" or an "rmdir" of the directory
I'm in, I'd expect git to do the same.

But whatever research we do on in-tree users we're left with changing
behavior for users in the wild, e.g. a script that cd's to each subdir
in a repo, inspects something, and if it wants to remove that does an
"git rm -r" of the directory it's in, commits, and expects the repo to
be clean afterwards.

I did follow/read at least one of the the original discussions[1] a bit,
and some earlier discussion I'm vaguely recalling around bisect in a
subdir.

If the underlying goal is to address the UX problem in git of e.g. "git
status" and the like hard-dying I wonder if something in the direction
of the setup.c/strbuf.c change above might be more of a gentle change.

That approach of a more gentler setup.c also has the benefit of having
git work when it ends up in this situation without the git commands
having landed it there, as in the above "rmdir" example.

Anyway, I really didn't have time to look at this very carefully. I just
remember looking into this with bisect/status etc. in the past, and
thinking that these problems were solvable in those cases, i.e. they
were just being overly anal about ENOENT, and not falling back on "PWD"
etc.

1. https://lore.kernel.org/git/YS3Tv7UfNkF+adry@coredump.intra.peff.net/
