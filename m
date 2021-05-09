Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFCC433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CB96135A
	for <git@archiver.kernel.org>; Sun,  9 May 2021 20:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEIUxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIUxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 16:53:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748FC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 13:52:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so14498984wrx.3
        for <git@vger.kernel.org>; Sun, 09 May 2021 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+qr5quXeBIPMuiJduolBZCb5hEMdQ8aM+9oCJ2c1mVs=;
        b=bGxEXkiHymoO6SycxKJWiUozrS2zSyw5x1uN/fv5iac6rG92s2zry6y2Y06otwqlPy
         9fdNOJLjx6w+0xlCQu3bHRQ+/7NXJ+Mhu8T/GcLmG9iaXhd5DHHyctP966Upqb+9QnQA
         7pP6qExxX7r1z+/2HGJ0Nw/XT3NGpAAA3PZmnkvW9hX6KlQ6eECEK18LiN41BM6m0M4g
         leeS8BCTkZ0wt5IYSpjVpEB2OrGoTdlFCu7vZc8+rBFj01BU753Y8+zhl1kb0MdHr9F3
         wye4371x7CrAQstTmZefzAsDxdGez3R3SiniqJ8hBtzdAbLaIiRgFs/bK9M9MtiI6uOA
         3UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+qr5quXeBIPMuiJduolBZCb5hEMdQ8aM+9oCJ2c1mVs=;
        b=GWMWaJJQpurwqM4QASZBFZcPnah5omKp5WF4u8QWffySIKVbVp6HzyHX3eDxGCl0yR
         4V7OylWG3JIVXEaINmAJkyCwywTG0QDemi71RUr/mTSfw0pQnHcLeDO60P0Zi0QaWztI
         Kg5ZfWdHJDh2trK9aTXxIg9QJrOOAAPcb1Fdb07hWLlc4XV7oarqxTbpMxMgDMK2hNj0
         qXmtp3PJZQJc6wGZeEUlYuBhu9T8lEYWYvwQZnPbOLJmal09ygUwlgLLcuDPEHnQ1adP
         pqto7OKgADFtGjqCoI5kyzeDuO7fwVVTDad02dv3JUSG4zsiLqFMygxd3wv7SbLyELeU
         uNtg==
X-Gm-Message-State: AOAM532BT7IWAZ47gSo+l+Eczm0khZW28toFsziBha/bpNOnno66DxSY
        5Zdc0SuqTuURTbsUsQYJg+lQb6gPyQOnHvkNkKbPt1dmhycOvA==
X-Google-Smtp-Source: ABdhPJxYjaqcDqk2CuzZPYnSq1Sx9GPvy0VN4+mo9soGUoGGuhHgMMhlY87L1j/pBGW0lcege54v99aDznikGp12Cso=
X-Received: by 2002:a5d:698f:: with SMTP id g15mr26380622wru.316.1620593550944;
 Sun, 09 May 2021 13:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1M8pepgrnZWhx+CeMH85J-5oWx+w6r0w3KCcsG8dWgCT9K9Q@mail.gmail.com>
In-Reply-To: <CAF1M8pepgrnZWhx+CeMH85J-5oWx+w6r0w3KCcsG8dWgCT9K9Q@mail.gmail.com>
From:   Craig de Stigter <craig.destigter@koordinates.com>
Date:   Mon, 10 May 2021 08:52:19 +1200
Message-ID: <CAF1M8pcRuYXXORdZ7gdKHN2mxBi6feYppB31bULpZUif6e7APw@mail.gmail.com>
Subject: `git index-pack --strict` is *very* slow during pushes to large repos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks

(apologies if repost; my first post seemed to disappear entirely)

We're hosting a service with some fairly large repos (created by
Kart[1] ), and I've been looking into some poor
performance of `git push` on our service.

Background: We host repositories with a specific layout. I'll try and avoid
most of the technical details but a brief description of the repo layout
might be helpful:

- At each revision we have 256 trees
      - each containing 256 trees (so 65536 trees at this level)
      - each subtree contains a number of objects (distributed via a hash
      scheme, evenly across the subtrees)
- Some repos have up to 100 million blobs active in a given revision.
In that case each of the 65536 subtrees would contain ~1500 blobs.
- Blobs are usually a few bytes to a few KB in size.
- For various reasons we have disabled deltas entirely.
- Most repos have a few hundred commits, and a typical commit might
modify 100,000 features (again spread evenly across the 65536 trees),
thus modifying most of the trees also.
- Our largest repos are currently a few hundred GB on disk.

We've come across a curious performance issue with `git index-pack` when
invoked by `receive-pack` during a push operation. We have
`transfer.fsckObjects=true` in the server config, so the index-pack
invocation looks like:

```
git --shallow-file shallow_filename index-pack \
   --stdin --keep='receive-pack 1234 on <servername>' \
   --show-resolving-progress --report-end-of-input --fix-thin \
   --strict
```

For our largest repos, when pushing ~100K blobs and associated trees, this
takes a *long* time - sometimes over 12 hours. The process uses enormous
amounts of disk IO (all reads; I haven't measured how much per process, but
the server was doing many terabytes of IO in total)

Here is one that "only" took 45 minutes with a few tracing environment vars
enabled:

```
$ cat craig.pack | /opt/sno/libexec/git-core/git --shallow-file
myfilename index-pack --stdin --keep='receive-pack 159567 on
servername' --show-resolving-progress --report-end-of-input --fix-thin
--strict
07:48:20.781099 common-main.c:48                  version 2.29.2
07:48:20.781111 common-main.c:48             | d0 | main
      | version      |     |           |           |              |
2.29.2
07:48:20.781127 common-main.c:49                  start
/opt/sno/libexec/git-core/git --shallow-file indexed.pack index-pack
--stdin '--keep=receive-pack 159567 on cave-7dc7798cc9-qcvxd'
--show-resolving-progress --report-end-of-input --fix-thin --strict
07:48:20.781133 common-main.c:49             | d0 | main
      | start        |     |  0.000264 |           |              |
/opt/sno/libexec/git-core/git --shallow-file indexed.pack index-pack
--stdin '--keep=receive-pack 159567 on cave-7dc7798cc9-qcvxd'
--show-resolving-progress --report-end-of-input --fix-thin --strict
07:48:20.781296 git.c:444               trace: built-in: git
index-pack --stdin '--keep=receive-pack 159567 on
cave-7dc7798cc9-qcvxd' --show-resolving-progress --report-end-of-input
--fix-thin --strict
07:48:20.781306 git.c:445                         cmd_name index-pack
(index-pack)
07:48:20.781312 git.c:445                    | d0 | main
      | cmd_name     |     |           |           |              |
index-pack (index-pack)
07:48:20.781530 midx.c:184                   | d0 | main
      | data         | r0  |  0.000670 |  0.000670 | midx         |
load/num_packs:1
07:48:20.781542 midx.c:185                   | d0 | main
      | data         | r0  |  0.000683 |  0.000683 | midx         |
load/num_objects:42658742
pack    5aa14bbb43187b7dfd5f996514854c3dcdc66d71
08:27:33.724306 git.c:700                         exit
elapsed:2352.943441 code:0
08:27:33.724321 git.c:700                    | d0 | main
      | exit         |     | 2352.943441 |           |              |
code:0
08:27:33.724336 trace2/tr2_tgt_normal.c:123       atexit
elapsed:2352.943475 code:0
08:27:33.724341 trace2/tr2_tgt_perf.c:213    | d0 | main
      | atexit       |     | 2352.943475 |           |              |
code:0
```

Removing the `--strict` from the invocation by disabling
`transfer.fsckObjects` solves the problem - the process completes in less
than a minute, and uses less than a GB of read IO.

I can theorise why this operation is slightly expensive:

   - `--strict` causes `index-pack` to call `fsck_object()` on each object
   pushed
   - these large pushes that push 100K+ blobs actually touch almost every
   *tree* as well - so most/all of the 65K trees are pushed too.
   - calling `fsck_object` on a tree looks up all its children (blobs and
   trees) to ensure they're reachable [2]

What I can't understand is why that makes it take quite *so* much longer
and use so much IO. I think it *should* probably not be checking much about
objects that are already in the repo, other than that they exist. We
have multi-pack indexes enabled, so my assumption is that a "does
object xyz exist?" check should be very inexpensive.
What could I be missing here?

As a start of a possible theory, we found when using libgit2 that our
peculiar repo structure with so many trees requires that we expand the size
of the tree cache[3] - otherwise repeated operations on blobs would
cause tree cache misses
every time their path was traversed. I wonder if there is a similar tree
cache structure in git itself, and if so could it be relevant here?

Many thanks and sorry about the long winded post :)

Craig de Stigter
Platform Engineer
Koordinates


references:
[1]: https://kartproject.org
[2]: fsck_walk_tree:
https://github.com/git/git/blob/a0dda6023ed82b927fa205c474654699a5b07a82/fsck.c#L300
[3] GIT_OPT_SET_CACHE_OBJECT_LIMIT:
https://github.com/libgit2/libgit2/blob/508361401fbb5d87118045eaeae3356a729131aa/include/git2/common.h#L266-L272
