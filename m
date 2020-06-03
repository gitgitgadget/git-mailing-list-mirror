Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA539C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC92220663
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhxwi5nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFCBJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCBJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 21:09:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15AC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 18:09:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a13so830290ilh.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bUIqvo7L9terLsHStZDLwT12y9Cl7YWS+MPk0670fwY=;
        b=Xhxwi5nPWLez88KRGxKDCIDIVUen/2HU95tw39LuK61zcasKoJPR8TX3l0+qvK9ZDv
         CJHKpboT8y7Ycdqj2L3qn9sp5UTxnH0g2uGjfl4PgaePE8lYd95ipajthZLPvW0pxF0P
         8YvCzwTPS6AW2JJmgd6ryB6GQP750OTFczIKSePe0JLkKkHxJvWktXikXPmQI2JA7CMj
         TjcqUNR3Q16gvjW3GWsTNTRx6W3lwDMM44qUrFAed32Uuk0PyBqhykdmskj+5mT9uMnj
         BBPgzqc7QT0aJFl8RW83SD1t9syu02AOHA5b08s6RQPsmcEYU1nLRRcBq4P+r2yWZJga
         t7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bUIqvo7L9terLsHStZDLwT12y9Cl7YWS+MPk0670fwY=;
        b=cg8OEh/XUhj4KcgJS2qpHA3ILZmLCYizUP4I/z5DiMHtbMfswF7L4LRYrAiVYcPijD
         egbSWIm0q/C8tmuNzMCL7MUyjg55hZT9CfLtnX4aMD6p3KNrEl2TAQL/0OwyGRC3mNEv
         MzwnOL2At21jN7LTOoa3HymdLaPqQNRlDg7dgyGloOCbuEBWv7m1ukWS+Zy7kbV94Lpo
         prYcDBIT3qgg4qm+xYfJ47QB6GodV1QK+s6BuPGjQHe6osQomqVte22iCWdgY/jrzGha
         MbhY2gp07KvBZU3fVz/jZbQe4cTOgFzlZu78JwX1riMq5elX6Y+vowWmz0JXTrR8XDLF
         dUNg==
X-Gm-Message-State: AOAM5310CFKkWdXetBwr7q7ORmmE45iS3oMupQCxlCQMuziP5oxL+UHK
        Gvnr55nI5s5kXVm9qjqdhF3t/ZvLHBoSGqJhnN++xalgZ0Q=
X-Google-Smtp-Source: ABdhPJxN9G/vVIShqUx+BcfrmUWm5PiISj2XafMLa5oHwjlgXjWB116zL6GBYI9nqGlZdv0pj2Gv9XPnwyljl4tHtRw=
X-Received: by 2002:a92:8488:: with SMTP id y8mr1832467ilk.262.1591146543433;
 Tue, 02 Jun 2020 18:09:03 -0700 (PDT)
MIME-Version: 1.0
From:   Shaun Case <warmsocks@gmail.com>
Date:   Tue, 2 Jun 2020 18:08:52 -0700
Message-ID: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
Subject: Possible regression for sparse-checkout in git 2.27.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm seeing an unexpected change in behavior of git sparse-checkout
between 2.26.2 and 2.27.0 on CentOS 7.8.  Problem manifests with both
github and multiple recent versions of gitlab.

Sources came from
https://mirrors.edge.kernel.org/pub/software/scm/git/, I verified the
sha256 hashes for both 2.26.2 and 2.27.0 matched.

Built with
gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)

By doing:

./configure \
    --prefix=/usr/local \
    --with-python=python3
make -j 10
sudo make -j 10 install install-doc install-html

Problem detail:

In 2.26.2, git sparse-checkout commands...

  init --cone
  set
  add

... all bring in files.  In 2.27.0, no files appear except the .git subdir
until I do:

git read-tree -mu HEAD

However, according to my reading of this, git read-tree should not be
necessary in 2.27.0:
https://stackoverflow.com/questions/28760940/why-does-one-call-git-read-tree-after-a-sparse-checkout/

When I do export GIT_TRACE_PACKET=1, I see that the init --cone, set
and add sparse-checkout commands all talk to the server.  In 2.27.0,
these commands do not result in any packets sent to the server.  It
sounds like they should be calling update_sparsity() themselves, but
aren't.  Is that wrong?  I couldn't find a git CLI client command to
invoke it directly except for read-tree.

Below is a small bash script and its output that shows the problem
with a small random public repo on github.

Best regards,
Shaun

Script:
==============================================
#!/bin/bash -x

export GIT_TRACE_PACKET=0
git --version
git clone --filter=blob:none --no-checkout
https://github.com/r-spacex/launch-timeline.git
cd launch-timeline

# Note no server traffic at from here...
export GIT_TRACE_PACKET=1
git sparse-checkout init --cone
git sparse-checkout set README.md
git sparse-checkout add css
# ... to here.

# There is nothing here yet except .git/
ls -las

# This brings in the files as expected, uncomment to verify.
# git read-tree -mu HEAD
==============================================


Output:
==============================================
3sc3396:/tmp>demo-git-sparse-checkout-bug.sh
+ export GIT_TRACE_PACKET=0
+ GIT_TRACE_PACKET=0
+ git --version
git version 2.27.0
+ git clone --filter=blob:none --no-checkout
https://github.com/r-spacex/launch-timeline.git
Cloning into 'launch-timeline'...
remote: Enumerating objects: 529, done.
remote: Total 529 (delta 0), reused 0 (delta 0), pack-reused 529
Receiving objects: 100% (529/529), 67.49 KiB | 987.00 KiB/s, done.
Resolving deltas: 100% (168/168), done.
+ cd launch-timeline
+ export GIT_TRACE_PACKET=1
+ GIT_TRACE_PACKET=1
+ git sparse-checkout init --cone
+ git sparse-checkout set README.md
+ git sparse-checkout add css
+ ls -las
total 68
 4 drwxrwxr-x   3 scase scase  4096 Jun  2 17:46 .
60 drwxrwxrwt. 34 root  root  57344 Jun  2 17:46 ..
 4 drwxrwxr-x   8 scase scase  4096 Jun  2 17:46 .git
==============================================
