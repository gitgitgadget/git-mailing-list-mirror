Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF75A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 09:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfCYJxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 05:53:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40592 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfCYJx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 05:53:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so6158139pgo.7
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/JKU75yArVyLl3Hw62QSfLJ6JOi0bM7hZmXtg5/F1dk=;
        b=R8V++B/uhdIAlTmYreuSeitHuXiP7rxKbFdqVMlZqCcSsx5hwViAw1zuir8hjXttiF
         6foZJGTWp2tGnJ6XgfQYKBTTTAyqXRaQNW3QypPO4K2KEjyQhSoeJY04bWojEipaBru2
         X1+saWzSFxetb6R8BTILQvBD33b1/RDWzoW7Rl5jEoqge89PG8XB/e+1mjAtJTYPzTM5
         p8m/2FN7vWMR/a9RoIOfVbi6gwkW+t/YnaNRWYGirBTVoIC+nmX1ALYgy8rmYCHKKGPx
         rE0Dg8iYgGs+NjpXbmx3uoU5sWPu5nyhYMn8Pb057Mt2s0nSfLBVV3m0FL4vfjY0JuUu
         WtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/JKU75yArVyLl3Hw62QSfLJ6JOi0bM7hZmXtg5/F1dk=;
        b=bSjbCjVW4GWn+m9pQMERDNZvFV2vRtXMOdcos62doxUr8L9UIlFxMCmIubZSntuon4
         EISZCQgNN0MnZUPqcGB8C53ME/sO7Xwdd5bmf/mlOVEwgi9smf834mxBgxyljBdoe0Ym
         LW44XWTInSzHPZS4Ad3QCuqvcQZ2QhCznf/E7ckTBMbeegJZdx5/outxGnEgVtxncbfC
         bzZq6WWkkTAhmT9FV/1awG9r/bsLcZS5o6szYSkkaPf0dO653x31BOoIXQNOROor+TZ7
         OYa2U3VK0Z1mUgz5L8vdBTr+9PY9w/9th1SSMoe1+tMfv3971A7XgJXwRfRyggR5lWC4
         geZA==
X-Gm-Message-State: APjAAAVqkckKraXZmA5ewJDs7m3uaeeF0I/A30hosFhTj1QzzB8aj/5r
        s8rnzA0nPld7aZgYEG5+/QE=
X-Google-Smtp-Source: APXvYqyczbsJPnihAZdLBtxBKJeDXDjbPc+9mO47yNNtsucsUCkJGbN8UleASxHPmTUxq8bUe9qWsA==
X-Received: by 2002:a63:b52:: with SMTP id a18mr22528039pgl.393.1553507608628;
        Mon, 25 Mar 2019 02:53:28 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id l187sm18949662pgl.75.2019.03.25.02.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 02:53:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 25 Mar 2019 16:53:22 +0700
Date:   Mon, 25 Mar 2019 16:53:22 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command
 'restore'
Message-ID: <20190325095322.GA1617@ash>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190308101655.9767-2-pclouds@gmail.com>
 <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Including Stefan, in case he's still interested in git and planned
something for the "submodule" restore part I mention below)

On Fri, Mar 08, 2019 at 10:01:25AM -0800, Elijah Newren wrote:
> Thanks for working on this; overall looks really good.  I've got a few
> comments here and there on the wording and combinations of options...

OK now that the 'git switch' part is mostly settled, I could go back
to 'git restore'. I have a lot more homework to do before sending v2,
but how about this?

Most of this is minor rephrasing and clarification (thanks!). The big
change is `--force` is split into `--keep-unmerged` and
`--force-submodules`, the same direction I took in 'git switch'.

Submodules actually pose another problem because there are different
things in a submodule to restore:

 - restore HEAD only, leave submodule's worktree alone. This is
   `--no-recurse-submodules` (default)
 
 - restoring `HEAD`, which is basically "git switch --detach
   <something>" inside the submodule. This is `--recurse-submodules`.

 - restoring the paths inside the submodules, i.e. the actual "git
   restore <some paths>" inside the submodule.

 - a combinarion of two. Basically you want "git reset --hard" in
   every selected submodule.

I wonder if we ever need to cover the third and forth case (and if so,
what will the UI be like).  I suppose we could eventually make
--recurse-submodules take an argument to specify what to restore,
maybe...

PS. I just found https://asciidoclive.com/. Could be useful to paste
this text and render without going through git's build system.

-- 8< --
git-restore(1)
==============

NAME
----
git-restore - Restore working tree files

SYNOPSIS
--------
[verse]
'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]

DESCRIPTION
-----------
Restore specified paths in the working tree with some contents from a
restore source. If a path is tracked but does not exist in the restore
source, it will be removed to match the source.

The command can also be used to restore the content in the index with
`--staged`, or restore both the working tree and the index with
`--staged --worktree`.

By default, the restore sources for working tree and the index are the
index and `HEAD` respectively. `--source` could be used to specify a
commit as the restore source.

A note about the differences between this command and linkgit:git-reset[1].
`git restore` modifies the working tree (and maybe the index) to
change file content to match some other, usually older, version, but
does not update your branch. `git reset` is mainly about moving the
tip of your branch in order to either add or remove commits from the
branch.

OPTIONS
-------
-s <tree>::
--source=<tree>::
	Restore the working tree files with the content from the given
	tree. It is common to specify the source tree by naming a
	commit, branch or tag associated with it.
+
If not specified, the default restore source for the working tree is
the index, and index `HEAD`. When both `--staged` and `--worktree`
are specified, `--source` must also be specified.

-p::
--patch::
	Interactively select hunks in the difference between the
	restore source and the restore location. See the ``Interactive
	Mode'' section of linkgit:git-add[1] to learn how to operate
	the `--patch` mode.
+
Note that `--patch` can accept no pathspec and will restore all
modified paths.

-W::
--worktree::
-S::
--staged::
	Specify the restore location. If neither option is specified,
	by default the working tree is restored. Specifying `--staged`
	will only restore the index. Specifying both restores both.

-q::
--quiet::
	Quiet, suppress feedback messages.

--progress::
--no-progress::
	Progress status is reported on the standard error stream
	by default when it is attached to a terminal, unless `--quiet`
	is specified. This flag enables progress reporting even if not
	attached to a terminal, regardless of `--quiet`.

-f::
--force::
	An alias of `--keep-unmerged` and `--force-submodules`.

--keep-unmerged::
	If `--source` is not specified, unmerged entries are left
	alone and will not fail the operation.

--force-submodules::
	Continue even if restoring `HEAD` of a submodule leads to loss
	of local changes in that submodule with `--recurse-submodules`.

--ours::
--theirs::
	Restore from stage #2 ('ours') or #3 ('theirs') for unmerged
	paths.
+
Note that during `git rebase` and `git pull --rebase`, 'ours' and
'theirs' may appear swapped. See the explanation of the same options
in linkgit:git-checkout[1] for details.

-m::
--merge::
	Recreate the conflicted merge in the specified paths.

--conflict=<style>::
	The same as `--merge` option above, but changes the way the
	conflicting hunks are presented, overriding the merge.conflictStyle
	configuration variable.  Possible values are "merge" (default)
	and "diff3" (in addition to what is shown by "merge" style,
	shows the original contents).

--ignore-skip-worktree-bits::
	In sparse checkout mode, by default is to only update entries
	matched by `<pathspec>` and sparse patterns in
	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
	patterns and unconditionally restores any files in
	`<pathspec>`.

--recurse-submodules::
--no-recurse-submodules::
	Using `--recurse-submodules` will update the content of all
	initialized submodules according to the commit recorded in the
	superproject. If nothing (or `--no-recurse-submodules`) is
	used, the work trees of submodules will not be updated.  Just
	like linkgit:git-submodule[1], this will detach `HEAD` of the
	submodules.

--overlay::
--no-overlay::
	In overlay mode, the command never removes files when
	restoring. In no-overlay mode, tracked files that appear in
	the index and working tree, but not in `--source` tree are
	removed, to make them match `<tree>` exactly. The default is
	no-overlay mode.

EXAMPLES
--------

The following sequence switches to the `master` branch, reverts the
`Makefile` to two revisions back, deletes hello.c by mistake, and gets
it back from the index.

------------
$ git switch master
$ git restore --source master~2 Makefile  <1>
$ rm -f hello.c
$ git restore hello.c                     <2>
------------

<1> take a file out of another commit
<2> restore hello.c from the index

If you want to restore _all_ C source files to match the version in
the index, you can say

------------
$ git restore '*.c'
------------

Note the quotes around `*.c`.  The file `hello.c` will also be
restored, even though it is no longer in the working tree, because the
file globbing is used to match entries in the index (not in the
working tree by the shell).

To restore all files in the current directory

------------
$ git restore .
------------

or to restore all working tree files with 'top' pathspec magic (see
linkgit:gitglossary[7])

------------
$ git restore :/
------------

To restore a file in the index to match the version in `HEAD` (this is
the same as using linkgit:git-reset[1])

------------
$ git restore --staged hello.c
------------

or you can restore both the index and the working tree (this the same
as using linkgit:git-checkout[1])

------------
$ git restore --source=HEAD --staged --worktree hello.c
------------

or the short form which is more practical but less readable:

------------
$ git restore -s@ -SW hello.c
------------

SEE ALSO
--------
linkgit:git-checkout[1],
linkgit:git-reset[1]

GIT
---
Part of the linkgit:git[1] suite
-- 8< --
