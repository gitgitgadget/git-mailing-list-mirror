Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D9ECAAD3
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH3CNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3CNx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:13:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1F9D8F0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:13:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b9so7472811qka.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+dF9TSvip1bHjjnRQlzR8KfxELX9Jbi/gJ9gR3IiXoI=;
        b=NxZ7eVHp8r/Qpp7i7gpMLRKGdF+XTDk+j9cjo8nefcrXchC/1SfMkvuKdctYTbI358
         FZS8M+wPn7V2lFlLqYH9LVDYHVoWMbwsPpkZN++q31NBVN04JaQbNKzUOrx927Vc4zzT
         WwVArb2J6ZsYWJEqW7JqzIWRuwN6PmmvCZGCtPZP/M8p7YgrV5jfjtzcITdaL+pPARvI
         OofYybXXKzhXwmT9NkXjxKJTicOgrOliOct2ZRVJIeaLoIjWOkXz3Qcj8gFoRPqM//rp
         HEejmFCV8p5gbbGVsuCabB8V5ql7WQCe3lE4Pwu0YCCSBsRBBevrgBjQZIymWjRUb8Gl
         XrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+dF9TSvip1bHjjnRQlzR8KfxELX9Jbi/gJ9gR3IiXoI=;
        b=rKOdy/Bpc0Fn1TowS5eaME1zDhTn/1uiNIG2sO+k6NBhq1zu1tPgVXby2+IYLm04zI
         ovsnbtKzFgjM8zSM6v2/+dcv/fp4OyF5XSKm7Uo0x5Zi2MmtLsE+VLp7bw0jVztSgp7E
         2l3glXuphFU2KJVGx8BWIOHsncq9/sqJVRgtyNr9+oh+5sNiJNgT2i3bJa7tR6HsJnha
         BxsqVdaiNEO4zO+YCrhsckVesh+VC89ZlmNhqiNY4GNTnLg5ipdv4j/Q7Q+ieS2tlHU4
         du3svQOQoDU4ib89kdiTATgPDdC/vUgb3MiJH5J5qNShxDqHC2mUmLvbVTSMDCAfiDhi
         7cEA==
X-Gm-Message-State: ACgBeo2KQvya4mDHss7FySYS3HIwLjPIv1CHQ/zrEkSpIUMSFMildrAo
        Fe3fVsgHrsyi8bD5iMgEB09NsHuxOZ+ybxdqoUL7GuYqtiw=
X-Google-Smtp-Source: AA6agR6bS5jYgxnkDt5LfpBNwLPvcTpJ55GmnaMnlBsk/2hsiLf3fCDbXw56Q51S/vm2eRftsGMTcbHK/YiE+Z4ItQA=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id
 d29-20020a05620a205d00b006bb2393b610mr10614100qka.413.1661825629941; Mon, 29
 Aug 2022 19:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
 <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
 <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
 <9p08998o-n88r-2nno-8703-s99o5qpn9o35@tzk.qr> <CABPp-BF24DO7vfYf856gXcfP7pT4moaiz-BUazCwYngmVCP5Pg@mail.gmail.com>
 <6p614ron-qrsq-p802-1892-o2r4o8n72p44@tzk.qr>
In-Reply-To: <6p614ron-qrsq-p802-1892-o2r4o8n72p44@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Aug 2022 19:13:38 -0700
Message-ID: <CABPp-BE0DA6jN7i8zHj+zy_SXo0DV_JyiRgDR1OwBYRTv6M6Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name first
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 8:35 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> I'll top-post because I will still need much more time to wrap my head
> around everything you said in your very thoughtful reply.
>
> By the way, have I mentioned before how much I appreciate well-edited,
> well-crafted mails? It must have taken quite a bit of care and editing to
> write this, and I just want to thank you for that.
>
> As to the problem we are discussing: I am fully on board with you on the
> necessity to keep the door open for rename detection and recursive merges
> and the zoo of conflict types that comes with it.
>
> After thinking about this for a couple of nights, I think I want to tackle
> the design from the "other" side, namely from the UI.
>
> At this stage, I _think_ it would do well for me to give a more high-level
> context as to my motivating factors.

This is helpful, but I would really like a few concrete examples too.
I tried to provide some in my last email with alternative guesses at
what you might want.  It'd be great to have an answer on those.  I'll
highlight them again at the end.

> The thing is, these worktree-less merges do not live in a vacuum. They are
> backing the Pull Request UI. There exists a relatively simple UI to
> resolve simple merge conflicts, which factors into what I want from `git
> merge-tree`.
>
> You've pointed out in the past, very rightfully, that the simple way to
> "pre-resolve" conflicts that I have implemented over here is just not good
> enough except for a very, very limited manner of driving `git merge-tree`.
> These "pre-resolved conflicts" are currently essentially a map of <path>
> -> <OID> pairs.
>
> Now, to design a much better way to present conflicts as well as allowing
> users to resolve some of them (the simpler ones, like content conflicts)
> in a web UI, we need `git merge-tree` to give us not an `ls-files
> -u`-style output, that only works reliably for very simple cases.

I agree we should not _only_ pay attention to `ls-files -u` info;
that's too simplistic.  And, in fact, that's the reason for having
merge-tree provide another section of information.  If we used both
sets of information, we can handle more complex cases...

> In general, I think the design would work best if we parsed the `messages`
> part exclusively on the server side (ignoring the `ls-files`-like output,
> probably even suppressing it) and if we received enough information to
> recreate the conflicts from there. Which means that we need the involved
> paths (whether munged or not, I am less and less concerned) together with
> the modes and OIDs. It would probably be helpful even to provide a tree
> OID for the directory part of any file/directory conflict, where the web
> UI could then present the contents in a tree view to the user.

By the `messages` part, do you mean the existing <Informational
messages> section, which consists of multiple entries of the form

    <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL

?  Or do you mean the <message> part of each entry from that section,
or do you perhaps mean something else?  I'll assume for now you mean
the full <Informational messages> section rather than some
sub-component or something else, but let me know if I'm wrong.


Also, why ignore or suppress the `ls-files -u`-like output?  Doesn't
it provide the modes and OIDs that you want?

> This way, we could present multiple conflicts, even multiple conflicts for
> the very same file, and allow resolving them individually.

You seem to still be assuming separable conflicts?  I tried to ask
about two concrete examples in the last email with lots of different
possibilities for what you might want to show the user (search for
"Example 1" and "Example 2"; I'll also include them at the end of this
email and snip out the other parts of the old email).  I'm not sure
either example is one where it makes sense for a user to attempt to
resolve conflicts individually.

Or is this more of a limited UI thing, where you want to search
through the conflicts and affected paths, and if the conflicts aren't
separable then you want to tell users to resolve the conflicts some
other way, but proceed and allow users to use your UI if the conflicts
are simple enough that they are separable?

> And we could associate resolutions with the exact list of paths, modes and
> OIDs involved, then teach `merge-tree` to optionally take such resolutions
> into account, to produce merges with resolved conflicts.

This seems like future work we could address another time...but
perhaps I could follow the tangent for just a second.  Why would it
make sense to add conflict-resolution information to `merge-tree`?
When you ran `merge-tree` the first time, it already provided you with
a tree, and a list of conflicted files.  If you have updates for those
conflicted files, you can update the tree yourself without needing to
redo any merges...right?  Why would extending merge-tree and calling
it again and having it repeat a merge even help?

> Doing it this way will require substantial changes on the server side, in
> particular in the UI, which currently does not have any support for
> handling conflicts involving renames. It will be a lot of work, and I am
> certain that I will have to pivot many times regarding the design of `git
> merge-tree` features supporting that UI. I'm excited to start that
> journey.
>
> What do you think?

I'm open to going down new paths and even doing a lot of refactoring
to get what we need, I'd just like to understand why they are needed
first.  In particular, I'm confused why you feel you should only ever
use part of the "git merge-tree -z" output.  Previously it seemed you
were trying to use only `ls-files -u`-style output, now you're trying
to use only the <Informational messages> section, and I'm trying to
advocate for using both.  I think you can already handle many of the
cases you are concerned about if you do so, without any further
merge-ort.c changes, and that the remaining cases should be
addressable with just a few small tweaks to some rename-related
path_msg() calls.

But maybe I'm still not understanding something about the usecase, or
there's something I'm missing about why the information provided
really isn't sufficient to solve the cases you're currently facing.
Could you look over the concrete examples I provided and give some
feedback on what you want to do with them?  That might point out what
I'm missing.  Let me quote the two relevant sections of my last email
with these examples, in reverse order:

> > I'm not so sure you need additional information.  Don't the
> > <Conflicted file info> and <Informational messages> provide enough
> > info already, for the usecases you are considering?  In particular,
> > you were trying to add a testcase in your series for a simple
> > directory/file conflict, but for such a case you can already determine
> > original filenames.  The <Conflicted file info> and <Informational
> > messages> sections of the `merge-tree -z` output for these, after
> > replacing NUL characters with newlines, would be:
> >
> >     120000 <HASH> 3 origfile
> >     100644 <HASH> 1 origfile~branch
> >     100644 <HASH> 2 origfile~branch
> >
> >     2
> >     origfile
> >     origfile~branch
> >     CONFLICT (distinct modes)
> >     CONFLICT (distinct types): whatever had different types on each
> > side; renamed one of them so each can be recorded somewhere.
> >
> > Now, the "distinct modes" conflict always results in filename munging,
> > with both names listed.  So, from this output, you know the original
> > name is "origfile" whenever you see "origfile~branch".  So now you can
> > present all the `ls-files -u` output from the first section with
> > remapping munged filenames back to original filenames.
> >
> > Doesn't that solve your immediate usecase already, without even
> > needing any merge-ort changes?

And, also the section of my previous email with the two more
interesting/complicated examples:

> > Can I ask in more detail what you want to present to a user?  Maybe
> > it'd help frame the conversation more.
> >
> > Let me provide two examples, each with lots of alternatives, to see if
> > any are the kind of output you want to be able to present to a user
> > (and assume in each case it's not just a block message but you have
> > some kind of programmatic knowledge of the components referenced in
> > the message):
> >
> > Example 1.

(Updated note: if you want to see Example 1 created in test code, go
to the en/t4301-more-merge-tree-tests topic, look at t4301, and find
the "directory rename + rename/delete + modify/delete + directory/file
conflict" testcase.)

> > Are you thinking of something like "The following files were involved
> > in a modify/delete conflict: foo, olddir/bar, newdir/bar,
> > newdir/bar~B", followed by three other conflict messages that also involve
> > those same files?
> >
> > Or, more like: "The following files were involved in a directory
> > rename, and in a rename/delete conflict, and in a file/directory
> > conflict, and in a modify/delete conflict: foo, olddir/bar,
> > newdir/bar, newdir/bar~B"
> >
> > Or, more like: "The following files were involved in a directory
> > rename, and in a rename/delete conflict, and in a file/directory
> > conflict, and in a modify/delete conflict: foo (from side A),
> > olddir/bar (from side B), newdir/bar (munged name), newdir/bar~B
> > (munged name)"
> >
> > Or, more like: "The file newdir/bar~B has a modify/delete conflict.
> > It was renamed to newdir/bar~B from newdir/bar because of a
> > file/directory conflict.  It was renamed to newdir/bar from olddir/bar
> > because of a directory rename.  It was renamed from foo to olddir/bar
> > on side B.  foo was deleted on side A."
> >
> > Or, more like: "foo was deleted on side A, and renamed to olddir/bar
> > on side B.  olddir/bar was renamed to newdir/bar because of a
> > directory rename.  newdir/bar was renamed to newdir/bar~B because of a
> > file/directory conflict.  newdir/bar~B has a modify/delete conflict."
> >
> > Or something completely different?
> >
> >
> > Example 2.

(Updated note: if you want to see a close neighbor to Example 2 in
test code, go to the en/t4301-more-merge-tree-tests topic, look at
t4301, and find the "mod6: chains of rename/rename(1to2) and add/add
via colliding renames" testcase.  That testcase is actually a bit more
complex, having three intertwined sets of each of these three already
tightly bound conflicts, reusing them in a way to end up with 6 total
intertwined conflicts.  But if you want to pick just one of the three
intertwined sets, instead of "file-one" through "file-five", look at
the files "two" through "six" from that testcase.)


> > Are you thinking of something like: "The following files were involved
> > in an add/add conflict: file-one, file-two, file-three, file-four, and
> > file-five" ?
> >
> > Or, is it more like: "The following files were involved in an add/add
> > conflict: file-one (from branch A), file-two (from merge base),
> > file-three (from branch A), file-three (from branch B), file-four
> > (from merge base), and file-five (from branch B)" ?
> >
> > Or, is it more like: "The following files were involved in an add/add
> > conflict: file-three (from [see details]) and file-three (from [see
> > details]).  Note that file-three was part of a rename/rename(1to2)
> > conflict, which involved file-one (from branch A), file-two (from
> > merge base), and file-three (from branch B).  Note that file-three was
> > part of a rename/rename(1to2) conflict, which involved file-three
> > (from branch A), file-four (from merge base), and file-five (from
> > branch B)"
> >
> > Or, is it more like: "file-three was part of a rename/rename(1to2)
> > conflict, which involved file-one (from branch A), file-two (from
> > merge base), and file-three (from branch B).  file-three was part of a
> > rename/rename(1to2) conflict, which involved file-three (from branch
> > A), file-four (from merge base), and file-five (from branch B).
> > file-three and file-three are involved in an add/add conflict"
> >
> > (Of course, all of this example is assuming we're just focusing on the
> > ultimate file-three vs file-three add/add conflict, not the additional
> > conflicts that file-one and file-five may be involved in.)
> >
> > Or are you wanting to display something completely different?
