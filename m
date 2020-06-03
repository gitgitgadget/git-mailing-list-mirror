Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B35C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 04:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A0A2053B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 04:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHwMJ1Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgFCEhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCEhR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 00:37:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF934C05BD43
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 21:37:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v17so877911ote.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 21:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QxX0TMDy+dbSVQSntkh2lxUDuGWAg7S1LhLw+esVt4=;
        b=dHwMJ1Gw4kZYUx894MXELU9ZTJpTsTTkex5W/tCoRLrvYXkuR1Wlckw2yDKbCdZfeD
         oyChKga2NQnjEDo49hhvYSb8N/hPxA775rWy0q6yuzImAMkLOFZbx1FkZ249RuLQ9wpk
         ipgt6/t3YVFnaceBOdpkeKzcOFJUfx+m/FH6/zCw+9J1HOyEYG41hivmqTRjR5hXxmTY
         uvtyl/7vKRsZMcIhvaKrDGCBIS0upEGCYqIVBt7TUasOM0DW1ij+cHLESOpY8aKBtoGt
         7+tvSErZ5tfEX3b5KEC+jE3QMOA511yrL/gf9UBFNcEISIc3Mpx7UjgXOYVRPFq6VKYV
         ozIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QxX0TMDy+dbSVQSntkh2lxUDuGWAg7S1LhLw+esVt4=;
        b=XHgiYn0ZU9JBfgt1V1m85dAPW/2Y0YO+vXhPteN4j10uGm4nisZfjAkslhVjRxDktg
         19XfWfblliouu80EM6D0O3A2VEzM0Ek9ZdnHjY/YA36wE7dDUDu9QUTOqLVPUG2Md4rG
         ji4D3PTqKH0H6CnG3dZAZMHh+XC+ek8iapG8TeH4Rv21gxu+Mv39mZeUzW0RynZYgbUb
         oVkk+LAtYfzmltlHzduwfEQSEI4+Tw0clT5NkX28PePwvGSK6hxRVjpo6NUJMAXsNph3
         VibShqtnSbEdkYi9mhB/h0ATnUDawDJOjr/7uCUShKdK63FGzMP0wa+nrdTS2tFW9RPq
         V91Q==
X-Gm-Message-State: AOAM533c6bHd40vjee593gIU76TQGLz8SgvwATcyrQdvzMIvUunK+wdo
        nPgYJUo1wt4gOPFYtPk2R9FN1Gj9Ezi9SmKGMqg=
X-Google-Smtp-Source: ABdhPJzhrZImKOTEDDiSAnT8vmiqfjHUKQ7yLWl6xQjbsnRgm76jcbINeDZPqiaZdNZ1e2MvCmbnTdPCnRU8vrhDXdw=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr1868886otq.345.1591159036570;
 Tue, 02 Jun 2020 21:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
In-Reply-To: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 21:37:05 -0700
Message-ID: <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
To:     Shaun Case <warmsocks@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 2, 2020 at 6:12 PM Shaun Case <warmsocks@gmail.com> wrote:
>
> I'm seeing an unexpected change in behavior of git sparse-checkout
> between 2.26.2 and 2.27.0 on CentOS 7.8.  Problem manifests with both
> github and multiple recent versions of gitlab.
>
> Sources came from
> https://mirrors.edge.kernel.org/pub/software/scm/git/, I verified the
> sha256 hashes for both 2.26.2 and 2.27.0 matched.
>
> Built with
> gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
>
> By doing:
>
> ./configure \
>     --prefix=/usr/local \
>     --with-python=python3
> make -j 10
> sudo make -j 10 install install-doc install-html
>
> Problem detail:
>
> In 2.26.2, git sparse-checkout commands...
>
>   init --cone
>   set
>   add
>
> ... all bring in files.  In 2.27.0, no files appear except the .git subdir
> until I do:
>
> git read-tree -mu HEAD
>
> However, according to my reading of this, git read-tree should not be
> necessary in 2.27.0:
> https://stackoverflow.com/questions/28760940/why-does-one-call-git-read-tree-after-a-sparse-checkout/
>
> When I do export GIT_TRACE_PACKET=1, I see that the init --cone, set
> and add sparse-checkout commands all talk to the server.  In 2.27.0,
> these commands do not result in any packets sent to the server.  It
> sounds like they should be calling update_sparsity() themselves, but
> aren't.  Is that wrong?  I couldn't find a git CLI client command to
> invoke it directly except for read-tree.
>
> Below is a small bash script and its output that shows the problem
> with a small random public repo on github.
>
> Best regards,
> Shaun
>
> Script:
> ==============================================
> #!/bin/bash -x
>
> export GIT_TRACE_PACKET=0
> git --version
> git clone --filter=blob:none --no-checkout
> https://github.com/r-spacex/launch-timeline.git
> cd launch-timeline
>
> # Note no server traffic at from here...
> export GIT_TRACE_PACKET=1
> git sparse-checkout init --cone
> git sparse-checkout set README.md
> git sparse-checkout add css
> # ... to here.
>
> # There is nothing here yet except .git/
> ls -las
>
> # This brings in the files as expected, uncomment to verify.
> # git read-tree -mu HEAD
> ==============================================
>
>
> Output:
> ==============================================
> 3sc3396:/tmp>demo-git-sparse-checkout-bug.sh
> + export GIT_TRACE_PACKET=0
> + GIT_TRACE_PACKET=0
> + git --version
> git version 2.27.0
> + git clone --filter=blob:none --no-checkout
> https://github.com/r-spacex/launch-timeline.git
> Cloning into 'launch-timeline'...
> remote: Enumerating objects: 529, done.
> remote: Total 529 (delta 0), reused 0 (delta 0), pack-reused 529
> Receiving objects: 100% (529/529), 67.49 KiB | 987.00 KiB/s, done.
> Resolving deltas: 100% (168/168), done.
> + cd launch-timeline
> + export GIT_TRACE_PACKET=1
> + GIT_TRACE_PACKET=1
> + git sparse-checkout init --cone
> + git sparse-checkout set README.md
> + git sparse-checkout add css
> + ls -las
> total 68
>  4 drwxrwxr-x   3 scase scase  4096 Jun  2 17:46 .
> 60 drwxrwxrwt. 34 root  root  57344 Jun  2 17:46 ..
>  4 drwxrwxr-x   8 scase scase  4096 Jun  2 17:46 .git
> ==============================================

Thanks for the detailed report.  This change came from commit
f56f31af03 ("sparse-checkout: use new update_sparsity() function",
2020-03-27), made by me.  After playing with it for a bit, the
--filter=blob:none turns out to not be relevant to reproducing the
behavior of not getting any files in the working tree, other than
perhaps providing you a way to measure what was or wasn't happening.

I think it'd be more natural to run
  git clone --filter=blob:none --sparse
https://github.com/r-spacex/launch-timeline.git
in place of the combination of
  git clone --filter=blob:none --no-checkout
https://github.com/r-spacex/launch-timeline.git
  git sparse-checkout init --cone
since the --sparse flag was added just for this kind of case -- to do
a clone but start with only a few things checked out.  It's easier, is
the route we're moving towards, and as a bonus also happens to work.
;-)

A bit of a side note, or a few of them, but this command of yours is broken:
  git sparse-checkout set README.md
because --cone mode means you are specifying *directories* that should
be checked out.  Currently, this gives no error, it instead silently
drops you back to non-cone mode, which seems bad to me.
sparse-checkout should provide some kind of error -- or at very least
a warning -- when you make that mistake.

Now let's talk about the commit in question that changed behavior
here.  The point of sparse-checkout is never to switch branches or
checkout new commits; all it does is update which paths are in the
current working directory.  A related point to this is it should never
add or remove entries from the index and shouldn't change any hashes
of files in the index.  It used to violate this, at first via an
implementation that was literally invoking `git read-tree -mu HEAD` in
a subprocess, and then later using internal code equivalent to
invoking that command in a subprocess.  But by violating the
leave-index-entries-alone mandate, it left folks who were in the
middle of a rebase and wanted to update their sparse-checkout to
include some more directories in their working tree in a precarious
spot -- if they didn't update, then they didn't have the files
necessary to build, and if they did forcibly update via `git read-tree
-mu HEAD` then their staged changes would all get wiped out.  I spent
some quality time helping users recover their files and teaching them
about the git storage model.

So that brings us back to your original question.  When you said
--no-checkout, it means that there is no commit checked out and the
index is empty.  update_sparsity() is correctly toggling the
SKIP_WORKTREE bits for the existing index entries that don't match the
sparsity patterns, and it is correctly calling check_updates().
check_updates() is correctly checking for files currently in the index
which have toggled to being needed in the current worktree so that it
can issue downloads related to promisor packs.  The problem is just
that there aren't any index entries to begin with, so there are no
SKIP_WORKTREE bits to update, and thus no files that need to be
downloaded.

It seems a bit risky to make sparse-checkout start doing
checkout/switch behavior and adding entries to the index.  There's a
couple ways forward.  One, we could decide this is a special edge or
corner case where we allow it: if the index is completely empty, then
there's no data to lose and thus we could make `git sparse-checkout
init [--cone]` in that one case use the old 'read-tree -mu HEAD'
logic.  Alternatively, we could just require users to run 'git reset
--hard' at the end of your script.

Stolee: Thoughts?
