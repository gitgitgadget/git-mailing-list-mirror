Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3F91F463
	for <e@80x24.org>; Tue, 17 Sep 2019 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfIQPsz (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 11:48:55 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37231 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfIQPsz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 11:48:55 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so2393461vsr.4
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6Skl7Prle8KmMaNHdVYtOmFf/WZosSsoHaovsve/vM=;
        b=an5FgAkdUTxY9RqZ3lGTGald48ME6WMs3evIhyi0azFy+q22q0o9p6tau71j0aqTUt
         iL7eydHYW71wjXPkbi8yAZ2mBfAcrK+ZMY4D6DnWV0fdgymnEALW4ALbh/eTO/nkGlLN
         VdeaEqhALnkA7pplBgVf7/ohOX7HiRoARV4nlBkstNUr9JDdcStMqjW1aJQ0EbKQzFPO
         YNAc4azIUtkNH0xyHILhScc0knJ5WRpPlq79KyX0BF8Ot/I7x7z5XYYNH5MwOJl718Ym
         cKQIjkeapHzHpYA3+e+qpa66zFJKWVwleQpSYSXxa8ojKOPwDncs2p+Nr6JeAZInoDHH
         KKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6Skl7Prle8KmMaNHdVYtOmFf/WZosSsoHaovsve/vM=;
        b=e/Kr9xsIt0p3p6oSLHxS6AhWGA1r688ecxbgu3UMHOTxrKCA90q0+UIlOveP42FKUy
         YoXigVU6HUIChNZOnXyLY05gQeVrM1f+7RPTH2MBcFXHTIZdb86Ug0scCAypfMblMXgR
         t44wZhHwsckC5OtJtj+2pQLjSR3obePDPgycztRzXh/AitdLXSS9+f0i7a031LmhViMs
         LpI2CkRdLsLa077UuC4AyjLPdPs+4P0s+Baz/MOKquVGd5+aXZU5jgV93xIskkkGWyPH
         0BJ2mXhuyjBEEYj8JWoZJxEOs/o53a2oCU3g34tYU9W5KIHWvKJC0zhSHKXhkL3ODw5w
         atGQ==
X-Gm-Message-State: APjAAAX4MmCTLO83rELE5hox2GJXs//SZYmixe9Ttmj/yurThNSuU/ln
        +DGKZZ8HyUGNabjlJqARGoyQQC8x5F2ZFor4hOo=
X-Google-Smtp-Source: APXvYqw2JNQYGNHkepIqgrJc+ZG0BpYfBmv4aRUldKYDfhnP6Ox+aODObyTymTKJE4u4qeFa8w5UyeFHYMkghun0L4Y=
X-Received: by 2002:a67:c11b:: with SMTP id d27mr2426194vsj.175.1568735333729;
 Tue, 17 Sep 2019 08:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190916214707.190171-1-jonathantanmy@google.com>
In-Reply-To: <20190916214707.190171-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Sep 2019 08:48:40 -0700
Message-ID: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
Subject: Re: merge-recursive thinks symlink's child dirs are "real"
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 4:09 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This was raised by a coworker at $DAYJOB. I run the following script:
>
>   $GIT init test && cd test
>   ln -s . foo
>   mkdir bar && touch bar/file
>   $GIT add foo bar/file
>   $GIT commit -m "foo symlink"
>
>   $GIT checkout -b branch1
>   $GIT commit --allow-empty -m "empty commit"
>
>   $GIT checkout master
>   $GIT rm foo
>   mkdir foo
>   (cd foo; ln -s ../bar bar)
>   $GIT add foo/bar
>   $GIT commit -m "replace foo symlink with real foo dir and foo/bar symlink"
>
>   $GIT checkout branch1
>   $GIT cherry-pick master
>
> The cherry-pick must be manually resolved, when I would expect it to
> happen without needing user intervention.
>
> You can see that at the point of the cherry-pick, in the working
> directory, ./foo is a symlink and ./foo/bar is a directory. I traced the
> code that ran during the cherry-pick to process_entry() in
> merge-recursive.c. When processing "foo/bar", control flow correctly
> reaches "Case B: Added in one", but the dir_in_way() invocation returns
> true, since lstat() indeed reveals that "foo/bar" is a directory. If I
> hardcode dir_in_way() to return false, then the cherry-pick happens
> without needing user intervention. I checked with "ls-tree -r" and the
> resulting tree is as I expect (foo is a real dir, foo/bar is a symlink).

Nice catch, and good digging.

> Is this use case something that Git should be able to handle, and if
> yes, is the correct solution to teach dir_in_way() that dirs reachable
> from symlinks are not really in the way

Yes, and mostly yes.  I'd phrase it instead as "if any leading path
within the repository of the given filename is a symlink, then it is
not in the way".  More on that below.

> (presumably the implementation
> would climb directories until we reach the root or we reach a filesystem
> boundary, similar to what we do when we search for the .git directory)?

The .git directory handling is a bit different because you don't have
a repository toplevel yet.  Here you are trying to add a path
"foo/bar"; it could just as well have been named "a/b/c/d/e/f", but
regardless, in all cases it's not an absolute path but a path relative
to the toplevel of the repository.  We'll have to check all paths up
to the repository toplevel and if any of the leading directories are a
symlink (just "foo/" in the first case, five checks for "a/" and
"a/b/" and ... "a/b/c/d/e" in the second case), then have dir_in_way()
return false.

It might be interesting to test out the performance afterward; we may
need to cache the check-paths-for-symlink status to avoid re-stating
the same leading directories repeatedly.  (But then again, we only
need to do this for files that unpack_trees() couldn't resolve and
marked as conflicted, so maybe it's not that big of an issue.)

> Also, my proposed solution would work in the specific use case outlined
> in the script above, but can anyone think offhand of a case that it
> would make worse?

Well, merge-recursive is hairy and slightly brittle based on its
update-as-you-go-and-do-a-four-way-merge design, so there's a small
chance this could introduce problems.  I've tried to come up with some
and haven't been able to.  It is the right idea implementationally,
though.  Let me explain:

In merge_trees() we loop over the index entries (from entries->nr-1
down to 0) calling process_entry(), and process_entry() updates the
index and working copy as it goes.  The thing about this reverse order
is that in the case of directory/file conflicts, directories will be
handled before the corresponding file, giving us a chance to check if
the directory has been removed (i.e. the resolution of the merge
removes that directory and there were no untracked files left in it)
before we handle the file. Let's walk through how this works:

After unpack_trees, we end up with a result that looks like:

Index:
  * bar/file (not conflicted; same in all three commits)
  * foo (deleted on one side -- conflict (could be part of rename),
also, part of D/F conflict)
  * foo/bar (added on one side -- conflict (could be part of rename),
also, leading path part of D/F conflict)

Then we check for renames.  There are none.  Then we process all the
index entries in reverse lexicographic order, skipping the ones that
have already been processed (i.e. which weren't marked as conflicted
by unpack_trees).

foo/bar is first; it was added on one side, so we should keep it.  Is
there a foo/bar/ directory in the way in the index?  No.  Is there a
foo/bar/ directory in the way in the working copy?  The current code
got tricked, but as you point out the answer should be no because foo
is a symlink.  Note that the code is already smart enough to say "no"
if "foo" is present as a regular file.  In particular, we don't care
that there is a file in the way of a leading path at all.
dir_in_way() simply says there is nothing _critical_ in the way (which
is defined to only be subdirectories), and then make_room_for_path()
will nuke any leading files in the way of creating directories.

Once we've processed foo/bar, the next entry we process is "foo".  In
the case, it was unmodifed on one side and deleted on the other so we
can just delete it.  We delete it from the index, note it was already
nuked from the working copy, and we're happy.  (By way of comparison,
if you changed your empty commit to modify the location of the foo
symlink, then we would instead have a modify/delete conflict for foo.
While foo will have been removed from the working directory, we can
re-instate it at an alternate location.  For D/F conflicts, we make
the assumption that it's always better to move the file of the D/F
conflict aside to a different path than to move the whole directory
aside.)

So, in short, all your idea does is treat symlinks like regular files
in terms of removability, which is exactly what we want.
