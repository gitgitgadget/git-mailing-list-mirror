Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7451EC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 04:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhKXEjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 23:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhKXEjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 23:39:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC1C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 20:35:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x6so4473095edr.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 20:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Ft6BxRhjizfOIDThZlMSqXXpOzHQwXGxOfrpXiBB9U=;
        b=eZw4Njw1ccjnIY9qop07eVSw2Kq6QdkLtcg66OBcY85lcz8xmqkp19G3dQUbbveH2G
         nBUCTzGxFWOX+AFeKW6Ze4SW8IdqCHxZatQ0NJxV89VQ9YuHVnzs7A/haqs7IZdxXZAb
         Sm9q696dCn/JZL5HFd8FcnxxNiryEe/uk62F11wB8zt4LC+ItN5UmE+Wksxr3Pk+VzAb
         vFcVqJeOeERRnvX55dSyhcpuKr0YL26Ie9Yh1PZgbnq4/I9r81TgWpIyfLKfnGF5Benz
         e2gaiedUzaU2aw4fnmQz/uRbeA4ue+4D7XchkrrqrjLBlyJXdWNLpfS7yuzsp7wKkgzv
         VcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Ft6BxRhjizfOIDThZlMSqXXpOzHQwXGxOfrpXiBB9U=;
        b=SpGq5WS5Wn1fDA2mOv6xWYBMy+31o4ptX6cxEWrKT6YnSxpCtq7F9uTRaLA8oig/kL
         WU9H2CHWtYr+R0KZ6Y8TSxn6fc8cUlq8LSYlTnVHYzS/H3oEfBu9kD02Cx5KNVueVvA+
         7ePkx8Xj5ciMmqm0RNfwn5J61UKDfxwQphMhDZV2JmEqlYQJHL4TBh/+zMSiCF8ek3Sw
         nXdokmuZPVmhNRDs2AS4qZtO11sYPmNNAbVf2UARo97feN3HuGoJ4HVOXijA+tptU21k
         cXZhuTgn77cyWNmSuoE3X+ofI0oegkAZgloBwF+/5OSKb7wfQjYBv6fYn89V2s4dJEGZ
         1BaA==
X-Gm-Message-State: AOAM531YNwR0fAZWHEbVzItMCJb5rBCE7EcwZG9KI3teVpF9vJIxdGYV
        7X+J5eSVB2OHeB2L8LtIZGsJzk9NmXSF1vfg4kY=
X-Google-Smtp-Source: ABdhPJy9umhAkcLi3AYpPWXwGrqSnNoGdpbRtm66rH9Jwwp9De8q1NFCcDhyXjP9f2vxQnnue7aEq6F5HDRXygORKj8=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr15739921ejc.520.1637728556164;
 Tue, 23 Nov 2021 20:35:56 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com> <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
In-Reply-To: <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 20:35:44 -0800
Message-ID: <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 5:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Nov 23 2021, Elijah Newren wrote:
>
> > On Tue, Nov 23, 2021 at 10:19 AM Glen Choo <chooglen@google.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >> [...]
> >> I'm not going to say that we'll *definitely* need remove_path()
> >> in its current form, but mixing concerns like this is an invitation to
> >> unexpected behavior. An (imperfect) example that demonstrates this
> >> principle is https://lore.kernel.org/git/24bffdab139435173712101aaf72f=
7277298c99d.1632497954.git.gitgitgadget@gmail.com/,
> >> where we made a change to a generic path matching function in order to
> >> speed up unpack_trees(), but accidentally ended up breaking gitignore.
> >
> > There's no mixture of concerns; my patch is correcting this library
> > function to more fully match its documented intent; from dir.h:
> >
> >     /* tries to remove the path with empty directories along it,
> > ignores ENOENT */
> >     int remove_path(const char *path);
> >
> > Since the parent process's current working directory is still likely
> > parked in that directory, there is a good reason to treat it as
> > non-empty.  Thus the cwd should not be one of those directories
> > removed along with the specified path.  No need to die, just stop
> > removing the leading directories once it hits the cwd (much like it'd
> > stop once it hit a directory that had files left in it).
>
> I can buy that we'd pick this new behavior as a worthwhile trade-off,
> but not that anyone intended for this to be the behavior all along.
>
> I don't think "a process is sitting in it" has ever been anyone's idea
> of a "non-empty directory". Rather it's what rmdir() returning EEXIST or
> ENOTEMPTY maps to.

Yeah, Junio commented on my reasoning in that same paragraph of mine.
Bad reasoning on my part, and you were both right to call it out.

But that reasoning wasn't the underlying motivation for Peff to
suggest the behavior behind this series[1] and this patch, nor the
rationale Junio used to say that the overall behavioral change behind
this series "makes sense".[2]

[1] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/xmqqo86elyht.fsf@gitster.g/

> Doesn't this series also change the behavior of e.g.:
>
>     cd contrib/subtree
>     git rm -r ../subtree

Yes, of course!

Before:

    $ cd contrib/subtree
    $ git rm -r -q ../subtree/
    $ ls -ld ../subtree/
    ls: cannot access '../subtree/': No such file or directory
    $ git status --porcelain
    fatal: Unable to read current working directory: No such file or direct=
ory
    $ git checkout HEAD ../subtree/
    fatal: Unable to read current working directory: No such file or direct=
ory

After:

    $ cd contrib/subtree
    $ git rm -r -q ../subtree/
    $ ls -ld ../subtree/
    drwxrwxr-x. 1 newren newren 0 Nov 23 19:18 ../subtree/
    $ git status --porcelain
    D  contrib/subtree/.gitignore
    D  contrib/subtree/COPYING
    D  contrib/subtree/INSTALL
    D  contrib/subtree/Makefile
    D  contrib/subtree/README
    D  contrib/subtree/git-subtree.sh
    D  contrib/subtree/git-subtree.txt
    D  contrib/subtree/t/Makefile
    D  contrib/subtree/t/t7900-subtree.sh
    D  contrib/subtree/todo
    $ git checkout HEAD ../subtree/
    Updated 10 paths from c557be478e

Very nice fix, don't you think?


> If so then re the "spidey sense" comment I had earlier: There's no rm
> codepaths or tests changed by this series,

That's not correct; I explicitly added a new rm test in the first
patch in my series.  Further, that same test was modified to mark it
as passing by this particular patch you are commenting on.

> so the implementation of
> doing it at this lower level might be casting too wide a net.

I'm getting the vibe that you are assuming I'm changing these two
functions without realizing what places might be calling them;
basically, that I'm just flippantly changing them.  Ignoring the
ramifications of such an assumption, if this vibe is correct, then let
me inform you that I've read over each and every caller (as well as
searched for other callers of unlink() and rmdir() throughout the tree
to see if they needed similar changes).  In my opinion, *each* *and*
*every* *single* *one* of the calls to remove_path() and
remove_dir_recursively() should take the behavioral change suggested
in this patch.

It's also not clear to me that you understand the point of the change
behind the series.  Clearly, I'm not doing well explaining it, but
have you read Peff's or Junio's comments on why they thought
protecting the_original_cwd makes sense?  Again, see the links [1] and
[2] above.  I think it'd help me understand how to respond to you
better if you could clarify to me whether you disagree with them, or
whether you agree with them but think I've gone wrong in the
implementation of their high level explanation somehow in this
particular patch.

> e.g. changing callers that use "remove_dir_recursively()" to use a
> "remove_dir_recursively_not_cwd()" (or whatever) be a gentler way of
> introducing this, and make sure that each step of the way we grok what's
> being changed, that there's test coverage etc.

I'll ask you the same two questions I asked Glen when he suggested
basically the same thing; if you can provide an answer to either one
of my questions that is compelling to me, I'd be totally onboard with
your suggested change:

(1) Can you point to any concrete example caller anywhere in the code
tree (or even provide a future hypothetical caller) that would in fact
be harmed by the change in this patch?

...and no, I'm not asking you to do my work for me; I've done that
same work -- in fact looking at all callsites -- and came up
empty-handed.  Since this and your previous email are essentially
claiming that I've probably missed things, I think it's a fair
question.

(2) What benefit would there be to introducing these new functions?

In particular, if I were to introduce these new functions, it would
look like this:

  * add new remove_path_not_cwd() and remove_dir_recursively_not_cwd()
function in one patch
  * convert all relevant callsites to use these new functions in the
subsequent patch(es)
  * delete the existing remove_path() and remove_dir_recursively()
functions for two reasons: (1) they are now unused, and (2) future
potential callers of these old functions would more than likely
reintroduce the bugs this series is trying to fix if they were to use
them and should be discouraged from doing so
  * rename {remove_path,remove_dir_recursively}_not_cwd() to remove
the "_not_cwd" suffix in order to have more memorable and less ugly
names

Once finished, the end result would be identical to this patch.  Well,
identical other than taking more patches to get to the same end result
and using up more reviewer time.  If there's some benefit to taking
this circuitous route, though, I'm more than willing to do so.
