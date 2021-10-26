Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B1C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 23:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215F560F91
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 23:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhJ0AB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbhJ0AB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 20:01:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53FC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 16:59:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k26so986813pfi.5
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gro6rhp8xGG0+W9Zx9ZsSvHhlIYz2bL8RIDsDuYpQk0=;
        b=iXsZYTBg1Juyj2IKYe9/RhDw9uf6RW/0TLyvo2zf+vsOvrgVq4EjnNY9zAqTSsg9ip
         XuB+s+jQ6E/GbkiL9H41RVSHRqarPwuPpjTj9Ldfmrg6tzzNDp7mCbLtRcDwjYN/DaNm
         sR8ZReR367pWyDIAHCVtDjWqogF05hZahT0QG2m5I8uW7yE3AplL+FuXFU9GntwJIlZ7
         vv2M116P69kUv9d8sxdDsrbTA9cF0tAjmZwRKFJqqCTmg9rVUIxgYIFcu3Wozn/NiA2R
         57z/edp0CJUUjZ4wbTl7ZuMx+U/69ELvYgq6690tAtVVEtoQCbq0hS/MO1KSJUatctBO
         TJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gro6rhp8xGG0+W9Zx9ZsSvHhlIYz2bL8RIDsDuYpQk0=;
        b=1J1R4Va8eapeQoMMpolGH/aT8+ddh4LwQdIl1GJy6IHZ8UwjmAYWD4O4t20xqLWEbh
         yz4YQqV9OZ7hrcfpfXSvA/36p/1BOah2ivbPooMcG/s6v6OeWSvCVLyrwEcUXYCbqcQq
         V1mZjHsCHxJWn5hNreiljEeJHrI+Gb1+VzxvCfA0aVcQaXVdOX8vUbaif8jx0c0XV8EB
         idRU4NdvQzzhkbPnThV7Nu52wiCqcWE9Ujr7+2rEiPPDckpjwUiXLlXc6tpPzBUEZr74
         va2lLL4eZlqY0Xbb7CdBtCbOUlkd8jU6JUAXNeRLRdq+DatKbyyjQlNjhqTwwvBA4FeU
         Ebkg==
X-Gm-Message-State: AOAM533uWla05LXUU2xSZjqQlA4NgRmcgsKBk7vXXFl7P72Tlmat0cjy
        wWy/slxh7Xrhsy5602w/MOsrs9E8yKk+qeIChrL151RzOifcHA==
X-Google-Smtp-Source: ABdhPJxPrUtcqYba7OUKtuns1Q0WwQBs5yuIaqyPhb+AzRlcCGAuw1xp8rLQJk3kbJ7JbVtoETx9niOztowvmk7oxGE=
X-Received: by 2002:a63:7405:: with SMTP id p5mr21418833pgc.426.1635292741075;
 Tue, 26 Oct 2021 16:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
 <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
In-Reply-To: <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 26 Oct 2021 16:58:49 -0700
Message-ID: <CAGyf7-Gaphb9q=4cyT0BQa7oYGKXQQsU-XfqvoxfDyijehJO3Q@mail.gmail.com>
Subject: Re: Unexpected cat-file --batch-check output
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few quick updates to some of the questions:

On Mon, Oct 25, 2021 at 12:18 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Oct 25, 2021 at 12:02:38PM -0700, Bryan Turner wrote:
>
> > I'm working with some users trying to reconcile an odd mismatch
> > observed in some Git output.
> >
> > Running an ls-tree for a branch and path, limited to a single pattern
> > within, shows this:
> > /usr/bin/git ls-tree -z refs/heads/develop:path/to/parent =E2=80=93 fil=
e
> > 100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file
> >
> > If we then run cat-file --batch-check, though, we see this:
> > echo 'refs/heads/develop
> > refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch=
-check
> > 28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
> > cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330
>
> That's definitely odd. Some things I'd try:
>
>   - do other versions of cat-file behave differently (i.e., is it a
>     regression)?

They're using Git 2.32 built from source on Ubuntu 20.04. I may see if
they can reinstall the 2.25.1 from focal's standard repositories and
see if it reproduces the issue. That said, they may not be
able/willing to do it.

>
>   - what does "git rev-parse refs/heads/develop:path/to/parent/file"
>     say? If it comes up with 4c8d566ed80, then the problem is cat-file
>     specific. If not, then it's a problem in the name resolution
>     routines.

$ /usr/bin/git rev-parse refs/heads/develop
28a05ce2e3079afcb32e4f1777b42971d7933a91
$ /usr/bin/git rev-parse refs/heads/develop:path/to/parent/file
cc10f4b278086325aab2f95df97c807c7c6cd75e

So it looks like rev-parse and cat-file --batch-check both exhibit the
same behavior.

I also had them expand their cat-file --batch-check to include another
file in the same "path/to/parent" directory:
$ echo 'refs/heads/develop
refs/heads/develop:path/to/parent/sibling
refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch-che=
ck
28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
2bfe7b4b7c7cdeb9653801d99b65dfefe5780dda blob 897
cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330

So the "sibling" file in the same directory comes out as a "blob", as expec=
ted.

They also ran an ls-tree for the directory without any globs:
# /usr/bin/git ls-tree refs/heads/develop:path/to/parent
100644 blob 2bfe7b4b7c7cdeb9653801d99b65dfefe5780dda    sibling
100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file

For "sibling" the blob's ID matches what cat-file --batch-check shows,
as I'd expect. There are several other tree entries, one "tree" and
the rest "blob", that I've omitted for brevity. All of their modes
look normal.

I also had them check ls-tree for some parent levels:
$ /usr/bin/git ls-tree refs/heads/develop:path -- to
040000 tree 5244cd18e3d9de9002bdfcd18e173ca55c035084    to
$ /usr/bin/git ls-tree refs/heads/develop:path/to -- parent
040000 tree 2847dc49d79e8d66040047a9dd61376115bf8829    parent

Nothing out of the ordinary to my eye.

>
>   - likewise, what does "git cat-file -t cc10f4b27808" say? I'd expect
>     it to really be a commit (a bug in batch-check's formatting routines
>     could show the wrong object, but I'd expect the oid to at least
>     match what ls-tree showed).

$ /usr/bin/git cat-file -t cc10f4b278086325aab2f95df97c807c7c6cd75e
commit

>
>   - Is there anything odd about the tree? E.g., duplicate entries, out
>     of order entries, etc? Examining "ls-tree" output might help, but
>     "git fsck" should also note any irregularities.

$ /usr/bin/git fsck --no-dangling
Checking object directories: 100% (256/256), done.
Checking object directories: 100% (256/256), done.
Checking objects: 100% (122888/122888), done.

There's one alternate. No warnings, though.

>
> After that, I'd probably start running "cat-file --batch-check" through
> a debugger. I know you said you don't have access to the repository, but
> perhaps whoever does might be willing to run it through "fast-export
> --anonymize" and see if the bug persists?

I've asked them to double-check whether they can provide me with the
repository, or with an anonymized copy. At this point, it feels like
there's not a lot more I can do/check without access to data that
reproduces the issue so I can attach a debugger.

Thanks again,
Bryan
