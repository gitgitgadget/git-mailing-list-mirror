Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A83C25B08
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 02:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiHUCAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 22:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHUCAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 22:00:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126682C64E
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 19:00:34 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b2so5914572qvp.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bzOI46pTFuWLX1i4vfzQp070RSQSpG9TCPcKTXf9wUw=;
        b=pyWxqobrI/wPj+K3C5TEmUgFJfYJhOu+iMUDdu4IvPOf264q0t9QmnHBpxYKM7czni
         4uMy9KkIwqbNF0s1Tj16n6un/mfLiCIYsQ6JUaMuafrgzlcPDUaN2wQVS8EpexhUElYN
         VdfmE+g+DyXMY2tgroTqeDUxaXvuX9a0QkC8L1/jFiK622EpnOzZPG8UwFcfegJzp8sl
         tN9u+6vQqVm3xj0UkEYeBPI6hHYPkEHVqwXRRFzRCg9RpxLAiyy/o/HySwl5MSOeKXuE
         eG4V4Z5YSFBJbcVIQP+uAR/c1tAuHICGzA+RxQjONcMWo4wUxmIL+jrGwA+iXgBkLkm9
         MBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bzOI46pTFuWLX1i4vfzQp070RSQSpG9TCPcKTXf9wUw=;
        b=N/8lHN88lTPyO/rbLCEPA20kDfkF+dmtZ5XrGAOwmnomvylk/VSvE9N0S1EhT30mds
         UQP1cmeR1cLolQvLy3InzOJu44O2MS9YpZFarBrBpMpEjYtvOK04yYOKGRbDuCb4aWhX
         occZUuXf6Qccsfn3evSTS8nahsF9Y6hB31ZNoBBBpBgoz5OP6WZgUYs8flNnSOi2/BbU
         aWkPo7YTOkYJm47QmrU9u1cHCbqP6TgVCkUskuSfbvscBhvKmQl4tdWFr1T2Oc5tLOZy
         xT6PYZAw8V8y0EsfSgN+OZMLOSVYhyFyaWRFCzXHWqqRfGU7XhE7i1jQxa57frQtvrad
         MV0Q==
X-Gm-Message-State: ACgBeo3Bz9Yu63WA3EH87HDatHGL2bRczURLYGG8zBje+Xlaw8+RqEkH
        YAmZfiAKigJ5ywHpeyOYYWgdiH8Y+jFfgdI6BVs=
X-Google-Smtp-Source: AA6agR6xzxhNiNGWLy23O9bK2b6MTqH+ZORnjppeBRWVPt4+dRzxacJGRXmuv+auuRLYRcl6qXsj8DK1VUAKAz4zego=
X-Received: by 2002:a05:6214:2a82:b0:476:b707:e1c4 with SMTP id
 jr2-20020a0562142a8200b00476b707e1c4mr11142143qvb.99.1661047233061; Sat, 20
 Aug 2022 19:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
 <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
 <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
In-Reply-To: <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Aug 2022 19:00:22 -0700
Message-ID: <CABPp-BG0NGEmGCcF36HhGCNNGL6csJXqAa5s6cXvXWFJfDor7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name first
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 4:17 PM Elijah Newren <newren@gmail.com> wrote:
> On Thu, Aug 18, 2022 at 11:57 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
[...]
> > @@ -4022,7 +4022,7 @@ static void process_entry(struct merge_options *opt,
> >                         if (S_ISGITLINK(merged_file.mode))
> >                                 reason = _("submodule");
> >                         path_msg(opt, CONFLICT_CONTENTS, 0,
> > -                                path, NULL, NULL, NULL,
> > +                                orig_path, NULL, NULL, NULL,
> >                                  _("CONFLICT (%s): Merge conflict in %s"),
> >                                  reason, path);
> >                 }
>
> Here's another case where path == orig_path, so you haven't made an
> effective change.  But this one highlights something interesting...
>
> In addition to the fact that path/orig_path may be a location that
> didn't exist on either side of history, there might actually be two
> relevant paths from the two different sides of history which are
> involved in the content merge, with neither of them being path or
> orig_path.  Let me break it down, starting with a simpler two path
> case:
>
> If we have a standard rename, e.g. foo -> bar, and both sides modified
> the file but did so in a conflicting manner, then we will end up in
> this chunk of code.  The conflict info emitted by merge-tree -z which
> is always of the form
>   <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL
> will in this particular case be
>    1<NUL>bar<NUL>Auto-merging<NUL>Auto-merging bar<newline><NUL>
>    1<NUL>bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content): Merge
> conflict in bar<newline><NUL>
> Neither of these messages has any mention of "foo", despite the fact
> that "foo" was the name of the file in both the merge base and one
> side, and "bar" was only the name of the file on one side.
>
> Now, let's make it more interesting.  side A modifies foo, and renames
> olddir/->newdir/.  side B modifies foo in a conflicting manner, and
> renames foo->olddir/bar.  Our `merge-tree -z` conflict information
> emitted will be of the form
>    1<NUL>newdir/bar<NUL>Auto-merging<NUL>Auto-merging newdir/bar<newline><NUL>
>    1<NUL>newdir/bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content):
> Merge conflict in newdir/bar<newline><NUL>
> For this more interesting case, the only files that existed were "foo"
> and "olddir/bar", neither of which are mentioned in the conflict info.
> The conflict info only reports on "newdir/bar".
>
> And for both of these examples, your patch doesn't change the existing
> behavior at all since path == orig_path for this hunk of the patch.

But, actually, trying to create some more testcases for the testsuite,
maybe this isn't so bad.  For example, with this interesting testcase:

   Commit O: foo, olddir/{a,b,c}
   Commit A: delete foo, rename olddir/ -> newdir/, add newdir/bar/file
   Commit B: modify foo & rename foo -> olddir/bar

Which involves four different types of conflicts:

  * a directory rename (which further modifies foo->olddir/bar to end
up at newdir/bar)
  * a rename/delete (delete foo vs. rename to olddir/bar)
  * a modify/delete (since foo was modified as well on one side)
  * a directory/file conflict (newdir/bar vs newdir/bar/file, forcing
newdir/bar to be further renamed to newdir/bar~B^0)

The <Conflicted file info> section will look like
    100644 <oldhash> 1 newdir/bar~B^0
    100644 <newhash> 3 newdir/bar~B^0

While that only includes the name "newdir/bar~B^0" and not
"newdir/bar", or "olddir/bar", or "foo", the <Informational messages>
has all necessary information to tie it together.  Replacing null
characters with newlines, the <Informational messages> section is:

    2
    newdir/bar
    olddir/bar
    CONFLICT (directory rename suggested)
    CONFLICT (file location): foo renamed to olddir/bar in B^0, inside
a directory that was renamed in A^0, suggesting it should perhaps be
moved to newdir/bar.

    2
    newdir/bar
    foo
    CONFLICT (rename/delete)
    CONFLICT (rename/delete): foo renamed to newdir/bar in B^0, but
deleted in A^0.

    2
    newdir/bar~B^0
    newdir/bar
    CONFLICT (file/directory)
    CONFLICT (file/directory): directory in the way of newdir/bar from
B^0; moving it to newdir/bar~B^0 instead.

    1
    newdir/bar~B^0
    CONFLICT (modify/delete)
    CONFLICT (modify/delete): newdir/bar~B^0 deleted in A^0 and
modified in B^0.  Version B^0 of newdir/bar~B^0 left in tree.

This provides all the mappings to tie together foo, olddir/bar,
newdir/bar, and newdir/bar~B^0, and shows the four conflict types
present.  So, all the information you need is present, it just can't
be parsed out of a single line like you want.  (But adding the
"newdir/bar" name to the modify/delete conflict at least does seem
like it'd be a little nicer.)

And trying to parse it out of a single line is probably tantamount to
trying to enforce a 1-to-1 mapping between paths and conflicts, which
will paint us into a corner, as I've pointed out before[1,2]

[1] https://lore.kernel.org/git/CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com/
