Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F86C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJNRGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNRGj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 13:06:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD673CAE59
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 10:06:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by36so6762826ljb.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tiXTQS1Wr+jIEV2fm06HrSeQbh0u8UOfal64asB7gG0=;
        b=UnxyKVyWpG94N8TqBtkRCArNIUkfFM+w06rd5yqc47iZXKnUTO0U+62Fbq+0yabV3g
         nLVDlfX58Pu7v/FVjZV5qv8UFQWEWAvTTFqPfMst/xdLBBWusv5Wb4NiDzflaOMo7FX7
         eDkjp+dkSA3rQtbGZb6ziOj95TcyOAlqN1CY8umJHMeM5NdpLNsqRv82DZ5WCDUsshXV
         ZSb165WzyvhBGgNBqNUoi8w56YZIZQK6VroQxUtB0Kyx4H0NXAdIoA+z6SDkK8xosU1Y
         NdwYCbGqpTGqbg7o1vsbKioIFg01g7VocQXzI1ja/R1BA6JQeR0Kuyy1XIJ2nkhGIf+N
         o6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiXTQS1Wr+jIEV2fm06HrSeQbh0u8UOfal64asB7gG0=;
        b=EaL3DGMqUWPDIi64JFcADwbpDEd1cIJkF67f3jkqLYXho1X+BvaqYnW7ISM3rcnB8z
         R6+n0OGa18NTi2+z0AKkhLkMuqRrL/fQOVOj2NJlJrW2TXJqBRheQIr2jiDbQr//8OB/
         pd9Kn39D4itjlJ7mzjpVoO/AGW8VPujSqmmj0rUY5mzHVwEXANhBW4AGB+JZuw+vL/N1
         gDdqOc0abj6fddKf+SBHqlccCKLIFkdxFmhPqkvzUKnoKvEuVvV8nnbKGhqf3WEQrhtR
         YMLG0ppuAzAjHnXe/S0yMAPW9cdj2GhERJbS0VOpMSFvvS5311Aifw4nSlQmHJCfrRRg
         tHXw==
X-Gm-Message-State: ACrzQf0sdNxW4g40B195Ytm43PTzGdGWqJxLBR5/XcFk7r6PnyS9nmAi
        MV/RXBXlZH1JR2rw7YDELxRTr5Tc24Rik36pP5Q=
X-Google-Smtp-Source: AMsMyM6Sx/x9V3I3kkwem3XmjaagqZk9R888iNx0eQPaMEFXRGplNKcoREFYikx0+ZO+EOWxKyTKxdtPaQSydARC7sk=
X-Received: by 2002:a05:651c:a04:b0:26f:ca24:20da with SMTP id
 k4-20020a05651c0a0400b0026fca2420damr2311085ljq.73.1665767195783; Fri, 14 Oct
 2022 10:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com> <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
In-Reply-To: <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Oct 2022 10:06:23 -0700
Message-ID: <CABPp-BEFoco4wg4BVE_aPz95cfMwAmbwU19eFyUOJTKj3q6wJA@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Tao Klerks <tao@klerks.biz>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 1:48 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Fri, Oct 14, 2022 at 9:41 AM Elijah Newren <newren@gmail.com> wrote:
> >
[...]
> > I don't see why you need to do full-tree with existing options, nor
> > why the ls-tree option you want would somehow make it easier to avoid.
> > I think you can avoid the full-tree search with something like:
> >
> > git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
> > sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
> > \
> >    sort | uniq -i -d
> >
> > The final "sort | uniq -i -d" is taken from Torsten's suggestion.
> >
> > The git diff ... xargs git ls-tree section on the first line will
> > provide a list of all files (& subdirs) in the same directory as any
> > added file.  (Although, it has a blind spot for paths in the toplevel
> > directory.)
>
> The theoretical problem with this approach is that it only addresses
> case-insensitive-duplicate files, not directories.

It'll catch some case-insensitive-duplicate directories too -- note
that I did call out that it'd print subdirs.  But to be more cautious,
you would need to carefully grab all leading directories of any added
path, not just the immediate leading directory.

> Directories have been the problem, in "my" repo, around one-third of
> the time - typically someone does a directory rename, and someone else
> does a bad merge and reintroduces the old directory.
>
> That said, what "icase pathspec magic" actually *does*, is break down
> the pathspec into iteratively more complete paths, level by level,
> looking for case-duplicates at each level. That's something I could
> presumably do in shell scripting, collecting all the interesting
> sub-paths first, and then getting ls-tree to tell me about the
> immediate children for each sub-path, doing case-insensitive dupe
> searches across children for each of these sub-paths.
>
> ls-tree supporting icase pathspec magic would clearly be more
> efficient (I wouldn't need N ls-tree git processes, where N is the
> number of sub-paths in the diff), but this should be plenty efficient
> for normal commits, with a fallback to the full search
>
> This seems like a sensible direction, I'll have a play.

If you create a script that gives you all leading directories of any
listed path (plus replacing the toplevel dir with ':/'), such as this
(which I'm calling 'all-leading-dirs.py'):

"""
#!/usr/bin/env python3

import os
import sys

paths = sys.stdin.read().splitlines()
dirs_seen = set()
for path in paths:
  dir = path
  while dir:
    dir = os.path.dirname(dir)
    if dir in dirs_seen:
      continue
    dirs_seen.add(dir)
if dirs_seen:
  # Replace top-level dir of "" with ":"; we'll add the trailing '/'
below when adding it to all other dirs
  dirs_seen.remove("")
  dirs_seen.add(':')
  for dir in dirs_seen:
    print(dir+'/')  # ls-tree wants the trailing '/' if we are going
to list contents within that tree rather than just the tree itself
"""

Then the following will catch duplicates files and directories for you:

git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
-t HEAD | sort | uniq -i -d

and it no longer has problems catching duplicates in the toplevel
directory either.  It does have (at most) two git invocations, but
only one invocation of ls-tree.  Here's a test script to prove it
works:

"""
#!/bin/bash

git init -b main nukeme
cd nukeme
mkdir -p dir1/subdir/whatever
mkdir -p dir2/subdir/whatever
>dir1/subdir/whatever/foo
>dir2/subdir/whatever/foo
git add .
git commit -m initial

mkdir -p dir1/SubDir/whatever
>dir1/SubDir/whatever/foo
git add .
git commit -m stuff

git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
-t HEAD | sort | uniq -i -d
"""

The output of this script is
"""
dir1/subdir
"""
which correctly notifies on the duplicate (dir1/SubDir being the
other; uniq is the one that picks which of the two duplicate names to
print)
