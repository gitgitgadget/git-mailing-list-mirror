Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C85DC4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOWHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOWHH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 18:07:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359793AB01
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 15:07:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k2so17467075ejr.2
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ku3oiVaQc3NsSdz/+CucuxDB1mpL2MJoP07F//EEIk=;
        b=fU7tOQ1LF9Z+V9o+nC4j/zNE/E1PXI1XOlca+t4pyzKazSO2jBAaPyC69MqvOKRRqG
         zrjjpMDPpPB4KTFlkCGiFhMa77VUY9ySa629S1Iu+tBLlGj3olouGlaqTctCyp7Dlbm8
         Z7fIs8KmrY/xCksXwRugS4+UIxVPJgB57uwhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ku3oiVaQc3NsSdz/+CucuxDB1mpL2MJoP07F//EEIk=;
        b=5G0OVtfiXp5bxQs7eSMzvzrWXbjH6m8DFwW0sEKx6ZrZCp2cXqyOvgS+w/WrO500v2
         9tJlUD2QcknOVLWPuuW9KiYXvHFqZ4hZ1YzXaFPoUZdsed7BYAF1EnGNUkHE3/P1c0bi
         OBGagwsLfQTPv+vNLPqdg3h4K0u4Tq8J8DcJYHKLJKQgckNDeDVqkZTRG327vJIfX2FC
         RcSmvX5GSfNDIhgE8W3vnLMVtyixI/lxVuit9CT+y7E8eaG/HstMZVA+eWHg0zq6wl1k
         RXqcdhrNkuG2esPdH+RpJwav41FJqMxF2EKsgNkxvJNzM73gknKVL7Da4jaLEEmYV+lJ
         oLnQ==
X-Gm-Message-State: ACrzQf3O47cVPu27TrSp+skyNqiSHCxSpUC8YDVS3IBx7VNhxWDKj+k8
        OTkPHfKXKA11+oCcg0gTN2RfqKwTeU47x6hy+nIiERkChTsLpQ==
X-Google-Smtp-Source: AMsMyM4y2Xb7HgOpMyLzH5oh7XAstU1wg1JMcKedd2XuIJdKFLAbJpHmEiosV71bCPXjtFTTWcazzOVXMjIrTAhk20A=
X-Received: by 2002:a17:906:9b8b:b0:78d:8276:ff47 with SMTP id
 dd11-20020a1709069b8b00b0078d8276ff47mr3388859ejc.430.1665871623653; Sat, 15
 Oct 2022 15:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
 <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com> <CABPp-BEFoco4wg4BVE_aPz95cfMwAmbwU19eFyUOJTKj3q6wJA@mail.gmail.com>
In-Reply-To: <CABPp-BEFoco4wg4BVE_aPz95cfMwAmbwU19eFyUOJTKj3q6wJA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 16 Oct 2022 00:06:50 +0200
Message-ID: <CAPMMpoictABXUhVCASZOiYZ4nydGtqiDYRpAELEBvbPn_5jRWA@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to be working, thank you!!!

Two updates I had to make, in case this is useful to anyone else:

1: I'm getting some weird behavior I can't explain yet, where some
paths are returned from the ls-tree call twice: The input to ls-tree
is all unique paths, but the output somehow includes a relatively
small subset of paths twice.
This mysterious issue is easily addressed by adding an extra "uniq"
call to remove the "trivial dupes" before hunting for the
"case-insensitive dupes" we're interested in:

git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
-t HEAD | sort | uniq | uniq -i -d

2: The xargs call has issues with paths with spaces in them. Adding
-d"\n" seems to be a clean way to fix this

git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
all-leading-dirs.py | xargs -d"\n" --no-run-if-empty git ls-tree --name-only
-t HEAD | sort | uniq | uniq -i -d


Not only does this approach seem to work well, but it also has far
better performance characteristics than I was expecting!

Simple small commit (10 files): 20ms
Reasonably large commit (10,000 files): 250ms
Diff from empty on a smaller branch (100,000 files): 2,800ms
Diff from empty on a larger branch (200,000 files): 5,400ms


It still makes sense to check the number of files/lines after doing
the diff, and do a "simple" 800ms full-tree (no-pathspec) dupe check
instead of this when your diff size goes past some file count
threshold, but it looks like that threshold would be quite high in my
environment - 30k files maybe?

I will have a go at writing a full update hook, and (without knowing
whether it will make sense from a performance perspective) I'd like to
try to implement the "all-leading-dirs" logic in bash 4 using
associative arrays, to remove the python dependency. If I make it work
I'll post back here.

This seems to cover what I needed icase pathspec magic for in ls-tree,
without having to implement it - so thanks again!

Tao

On Fri, Oct 14, 2022 at 7:06 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Oct 14, 2022 at 1:48 AM Tao Klerks <tao@klerks.biz> wrote:
> >
> > On Fri, Oct 14, 2022 at 9:41 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> [...]
> > > I don't see why you need to do full-tree with existing options, nor
> > > why the ls-tree option you want would somehow make it easier to avoid.
> > > I think you can avoid the full-tree search with something like:
> > >
> > > git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
> > > sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
> > > \
> > >    sort | uniq -i -d
> > >
> > > The final "sort | uniq -i -d" is taken from Torsten's suggestion.
> > >
> > > The git diff ... xargs git ls-tree section on the first line will
> > > provide a list of all files (& subdirs) in the same directory as any
> > > added file.  (Although, it has a blind spot for paths in the toplevel
> > > directory.)
> >
> > The theoretical problem with this approach is that it only addresses
> > case-insensitive-duplicate files, not directories.
>
> It'll catch some case-insensitive-duplicate directories too -- note
> that I did call out that it'd print subdirs.  But to be more cautious,
> you would need to carefully grab all leading directories of any added
> path, not just the immediate leading directory.
>
> > Directories have been the problem, in "my" repo, around one-third of
> > the time - typically someone does a directory rename, and someone else
> > does a bad merge and reintroduces the old directory.
> >
> > That said, what "icase pathspec magic" actually *does*, is break down
> > the pathspec into iteratively more complete paths, level by level,
> > looking for case-duplicates at each level. That's something I could
> > presumably do in shell scripting, collecting all the interesting
> > sub-paths first, and then getting ls-tree to tell me about the
> > immediate children for each sub-path, doing case-insensitive dupe
> > searches across children for each of these sub-paths.
> >
> > ls-tree supporting icase pathspec magic would clearly be more
> > efficient (I wouldn't need N ls-tree git processes, where N is the
> > number of sub-paths in the diff), but this should be plenty efficient
> > for normal commits, with a fallback to the full search
> >
> > This seems like a sensible direction, I'll have a play.
>
> If you create a script that gives you all leading directories of any
> listed path (plus replacing the toplevel dir with ':/'), such as this
> (which I'm calling 'all-leading-dirs.py'):
>
> """
> #!/usr/bin/env python3
>
> import os
> import sys
>
> paths = sys.stdin.read().splitlines()
> dirs_seen = set()
> for path in paths:
>   dir = path
>   while dir:
>     dir = os.path.dirname(dir)
>     if dir in dirs_seen:
>       continue
>     dirs_seen.add(dir)
> if dirs_seen:
>   # Replace top-level dir of "" with ":"; we'll add the trailing '/'
> below when adding it to all other dirs
>   dirs_seen.remove("")
>   dirs_seen.add(':')
>   for dir in dirs_seen:
>     print(dir+'/')  # ls-tree wants the trailing '/' if we are going
> to list contents within that tree rather than just the tree itself
> """
>
> Then the following will catch duplicates files and directories for you:
>
> git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
> -t HEAD | sort | uniq -i -d
>
> and it no longer has problems catching duplicates in the toplevel
> directory either.  It does have (at most) two git invocations, but
> only one invocation of ls-tree.  Here's a test script to prove it
> works:
>
> """
> #!/bin/bash
>
> git init -b main nukeme
> cd nukeme
> mkdir -p dir1/subdir/whatever
> mkdir -p dir2/subdir/whatever
> >dir1/subdir/whatever/foo
> >dir2/subdir/whatever/foo
> git add .
> git commit -m initial
>
> mkdir -p dir1/SubDir/whatever
> >dir1/SubDir/whatever/foo
> git add .
> git commit -m stuff
>
> git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
> -t HEAD | sort | uniq -i -d
> """
>
> The output of this script is
> """
> dir1/subdir
> """
> which correctly notifies on the duplicate (dir1/SubDir being the
> other; uniq is the one that picks which of the two duplicate names to
> print)
