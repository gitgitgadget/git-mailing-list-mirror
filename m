Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD5A1F45B
	for <e@80x24.org>; Tue, 14 Nov 2017 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756004AbdKNRRb (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 12:17:31 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:57132 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755955AbdKNRRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 12:17:23 -0500
Received: by mail-vk0-f41.google.com with SMTP id g11so12659497vkd.13
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ph4rnU6Dllf3XmRD3LbDMu3PfvKvsgfRc/hEtuMeAOM=;
        b=VTAvqSJQmmQYoT11E1XIar3XkuTzWl6wKDkjGcIDl+bY2h5+GYcYida1c9+9jHH+fc
         AJRq6byHJu80XcwHt812Kv+aL3BzRv5qfCzubCzDjnAPI2j4//ZdZknOjrvlaT9Oyk8e
         4S4mm8mC1g6mY1T8P53wj92mcqY3VlWwtAXyCr0BRLpqd2GnGAP+yCoHTgzhA1Repctd
         40brQ2xfuqnVZEuiE506mvnGOI1/0k2s8A+nW5zLipjZkxbX75HXWFeX9maCewpUc9un
         wr0/UXVWg3vlcJGU6mAC3ywQsSWC/Q2+qOrbxhsmLqUXQ51NW25t+p0OoHFDtoE0owNU
         OaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ph4rnU6Dllf3XmRD3LbDMu3PfvKvsgfRc/hEtuMeAOM=;
        b=ZbH+XZsNMj718eptrjim8VrsaQACgdaLwtsLjIHx1oS5AfbVctEJGzFqM4QWupbJno
         3W3z+uMcKrdogjQP6tvTNcqaZX7D3rAsrGW2bwdlpXdXd7PexU4davkusXmX2TyQ4RKG
         A9RuTg94N+ur6vo/4JPBv6G8+Ti9oDObij4xLP+TZNdhLq7K7LymFAnpQ2xulUAAtrV9
         gwAXemRWkCAusxBEcj9Uk2eJkav8CEitUTXSTVNPAF5vzZZRo2cilJamWc+3wTF/BoGA
         AvmOEoFAV9afGPFVNlV2dC8kzcyH0UwJ6ykjeA+Lyw99pSFEAeDUZAePwgbTleNNtyic
         jIGQ==
X-Gm-Message-State: AJaThX7RKgD87DayMyEVHA2lTbIW+XQUKFDVGicukXK5VPH+NyGon2uv
        N6nxc0uKoDSTbI0XcmLIKCRUvUotA7fs6mqloAk=
X-Google-Smtp-Source: AGs4zMYBL0+R34A9BcNgja8Yj+F2CZSlmrpCoQd+/ZloK+na6u7FB7j3A89mPE5uIEV4oiHMY7no4liVQwMdX9xnDjg=
X-Received: by 10.31.92.8 with SMTP id q8mr9055466vkb.29.1510679841918; Tue,
 14 Nov 2017 09:17:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 09:17:21 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 09:17:21 -0800
Message-ID: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
Subject: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive: Fix
 logic ordering issue)
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 3:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 13, 2017 at 3:39 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Mon, Nov 13, 2017 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>> I wanted to debug a very similar issue today just after reviewing this
>>> series, see
>>> https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/
>>
>> Oh, bleh.  That's not a D/F conflict at all, it's the code assuming
>> there's a D/F conflict because the entry it is processing ("sub") is a
>> submodule rather than a file, and it panics when it sees "a directory
>> in the way" -- a directory that just so happens to be named "sub" and
>> which is in fact the desired submodule, meaning that the working
>> directory is already good and needs no changes.
>
> yup, I came to find the same snippet of code to be the offender,
> I just haven't figured out how to fix this bug.
>
> Thanks for taking a look!
>
> As you have a lot of fresh knowledge in the merge-recursive case
> currently, how would we approach the fix here?

submodules and merging looks pretty broken, to me.  Backing off from
the current bug and just looking at merging with submodules in
general, makes me a little uneasy with what I see.  I mean, just look
at update_file_flags, when it wants the working directory updated, the
code for a submodule is the following:

    if (update_wd) {
<snip>

        if (S_ISGITLINK(mode)) {
            /*
             * We may later decide to recursively descend into
             * the submodule directory and update its index
             * and/or work tree, but we do not do that now.
             */
            update_wd = 0;
            goto update_index;
        }

So, it just doesn't put anything there, so the working directory is
made out-of-date immediately.  Users are happy with that?  Maybe it is
what makes sense, but it surprised me.

From there, we can start stacking on the weird.  For example let's say
we have this setup:
O (merge base): path/contents containing "whatever\n"
A (ours): path is a submodule
B (theirs): path/contents containing "whatever\nworks\n"

Merging A into B results in

CONFLICT (modify/delete): path/contents deleted in A and modified in
HEAD. Version HEAD of path/contents left in tree.
CONFLICT (directory/file): There is a directory with name path in
HEAD. Adding path as path~A
Automatic merge failed; fix conflicts and then commit the result.

but path~A is never created, because of the update_file_flags code
snippet above.  If the user looks at the path directory, it doesn't
have any submodule info either.  It has just "disappeared", despite
the claim made in the conflict notice.  Maybe okay, but slightly
confusing.

Now let's say the user just wants to back out of this merge.  What if
they run 'git merge --abort'?  Well, they're greeted with:

error: 'path/contents' appears as both a file and as a directory
error: path/contents: cannot drop to stage #0
error: Untracked working tree file 'path/contents' would be
overwritten by merge.
fatal: Could not reset index file to revision 'HEAD'.

"Would be overwritten by merge"?  We're unmerging, and I agree it
shouldn't be overwritten, but the fact that it thinks it needs to try
is worrisome.  And I don't like the fact that it just outright failed.
Okay, what about 'git reset --hard' at this point:

error: 'path/contents' appears as both a file and as a directory
error: path/contents: cannot drop to stage #0
warning: unable to rmdir path: Directory not empty
HEAD is now at 3e098a0 B

Cannot drop to stage #0?  Oh, boy.  Things must be really messed up.
Except they're not; it did drop path/contents to stage #0 despite the
error, and git status is clean again.

Now, let's switch tracks and look at things from the other side.  What
if the user had been on A and tried to merge B into A?

$ git checkout A
Switched to branch 'A'
$ git merge B
CONFLICT (modify/delete): path/contents deleted in HEAD and modified
in B. Version B of path/contents left in tree.
Adding path
Automatic merge failed; fix conflicts and then commit the result.

path/contents is left in the tree?  But there's a submodule in the
way!  Did it really put it there...?  Yep:

$ ls -al path/
total 16
drwxrwxr-x 3 newren newren 4096 Nov 14 08:40 .
drwxrwxr-x 4 newren newren 4096 Nov 14 08:38 ..
-rw-rw-r-- 1 newren newren   15 Nov 14 08:40 contents
-rw-rw-r-- 1 newren newren    0 Nov 14 08:39 foo
drwxrwxr-x 8 newren newren 4096 Nov 14 08:40 .git

At least git add and git rm on that location, from the supermodule, do
the right thing.

$ git add path/contents
fatal: Pathspec 'path/contents' is in submodule 'path'
$ git rm path/contents
path/contents: needs merge
rm 'path/contents'

But the fact that merge-recursive wrote unmerged entries back to the
working tree within the submodule feels pretty weird and dirty to me.
(Luckily, if the locations conflict with something in the submodule,
it'll write things out to an alternate path, such as path/contents~B,
so it merely muddies the submodule rather than destroying stuff within
it).


Also, now I'm worried that instead of just D/F (directory/file)
conflicts, we now have two new classes that need to be checked
everywhere throughout the code: submodule/file and submodule/directory
conflicts.  No idea how pervasive of a problem that is.  Maybe there's
a clever way to handle them all with the current D/F conflict code (it
certainly didn't take submodules into consideration when it was
written), but someone would have to take a careful look.  There are
already many codepaths due to many different conflict types, and folks
already have to keep several things in their head: renames, directory
renames, D/F conflicts, recursive cases, dirty files, untracked
files/directories, and now submodules.  It would be nice if we could
reduce the number of things folks have to focus on all at once while
reading merge-recursive.c.  I'm really starting to think we should at
least change how unpack_trees() and merge-recursive interoperate,
because at least the dirty files & untracked files/directories should
be able to be split off, so folks can focus on just the index for most
the code paths, and everything working tree related could be handled
separately.  But that's a topic for a different thread.

Anyway, circling back the problem you brought up, there is actually a
fairly easy fix if you want _just_ this issue cleaned up.  I'll post a
simple patch, but it doesn't address the above problems so it feels a
bit like a band-aid to me.
