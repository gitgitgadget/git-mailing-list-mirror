Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78ED42022D
	for <e@80x24.org>; Thu, 23 Feb 2017 21:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdBWVdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 16:33:16 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36481 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWVdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 16:33:15 -0500
Received: by mail-it0-f66.google.com with SMTP id w185so90044ita.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7oa7atUuNck9V9DvwkVq8RITNseIV5QjjFIN7/XB6bc=;
        b=OmCzp0OXJVo8LvNVi8Io1Sp5Chm+ppnRBqKUq6nRyg2Dg8ceK604mXdHiJuOX23HJ0
         LyaTcSLWaHocHTCGcL2SJXhiU+QDoHFQMlrwcd1e9CtAcLLWLxbtwnwRimsmQptc+ATW
         eed8uDBz/m9nlQ41awcXRCtqsQFMZS2ubsOIFTDdL0iqncnZ3+AQCOeDxNRiK6a8TvjI
         dSEx8FLCKZdDJc7sZd+ieTHLwNiO6JHbG3e5sKjvY6rVg+VMfci176f69rBNYO7+bYvD
         1LZl8E5l+l6awPqCkPy3prziRFLtyrLqE+aRQ5Io8gVXPkgwJN9YxH4ZquQtJDAGzLDE
         tCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7oa7atUuNck9V9DvwkVq8RITNseIV5QjjFIN7/XB6bc=;
        b=XdE1GnmnaQDZUHnoi9QRNjvkQdDfSqdc14uYUUyqOlRFOIn0PSn34VyatRkl8POcDf
         9An2mTQgzSCxFIJu6qpgsotdZmEzwCVVxeJnMmV6hu3xjIPeSYKfJs1yLp/mUWIJiuI5
         ktiVMV35zjepPwaX2byvf3ikqB686CMXlCMd2TTJI4yDzto5hmpPBgLSzIpZHtyXm/0j
         Ohas+40sxdp6wzF5veanfLDlBGYIfEMSNhUhhj3HqrJb/YUBHl66e/cnWO9hKKGVJb6W
         t/flJmsTc/ZrKioYTcj3JR+3PJN23VVOKhF0liD4vDxt+ufWX7CM/K4cY40uqsoS5REK
         5A1A==
X-Gm-Message-State: AMke39nl2uINqBbCZfVxNnLXKSqPhbmoJqlMudoyIXNuqLj7AcgCbSIcLaLPDpzb5wAXwA==
X-Received: by 10.36.17.9 with SMTP id 9mr7395857itf.84.1487885594300;
        Thu, 23 Feb 2017 13:33:14 -0800 (PST)
Received: from prospect.localdomain (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id d10sm2282905itd.9.2017.02.23.13.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 13:33:13 -0800 (PST)
Date:   Thu, 23 Feb 2017 15:33:33 -0600
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>,
        Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless
 commits
Message-ID: <20170223213333.GA3490@prospect.localdomain>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, Jeff King <peff@peff.net>,
        Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-3-djpohly@gmail.com>
 <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 01:17:49PM -0800, Junio C Hamano wrote:
> "Devin J. Pohly" <djpohly@gmail.com> writes:
> 
> > Previously, the git_commit_non_empty_tree function would always pass any
> > commit with no parents to git-commit-tree, regardless of whether the
> > tree was nonempty.  The new commit would then be recorded in the
> > filter-branch revision map, and subsequent commits which leave the tree
> > untouched would be correctly filtered.
> >
> > With this change, parentless commits with an empty tree are correctly
> > pruned, and an empty file is recorded in the revision map, signifying
> > that it was rewritten to "no commits."  This works naturally with the
> > parent mapping for subsequent commits.
> >
> > Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
> > ---
> 
> I am not sure if a root that records an empty tree should be pruned
> with --prune-empty to begin with.
> 
> When we are pruning consecutive commits in the other parts of the
> history because they have identical (presumably non-empty) trees,
> should an empty root that the original history wanted to create be
> pruned because before the commit it was void, after the commit it is
> empty?  Should "void" (lack of any tree) and "empty" (the tree is
> there, but it does not have anything in it) be treated the same?
> Shouldn't root be treated as a bit more special thing?
>

The case I had in mind was a filter which happened to remove all changes
from any parentless commit (see the testcase added to t7003).  It would
not necessarily have been an empty commit in the original history.

Use case/motivation: I am splitting my dotfiles repo to migrate to vcsh,
and the original first commit (which only touches a few files) appears
in every branch.  In the branches which do not include those files, the
commit is empty but still present.

I think your point is interesting too, though.  If a commit is also
TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
reasonable that someone might want to leave it in the filtered branch as
an empty commit while pruning empt*ied* commits.  I would imagine that
as another option (--prune-newly-empty?).

> 
> I myself do not have a good answer to the above questions.
> 
> I think the updated code makes sense, provided if we decide that
> void to empty is just like transitioning between two identical
> (presumably non-empty) trees.  The updated documentation is a lot
> more readable as well.
> 
> Comments from those who have been involved in filter-branch?
> 
> >  Documentation/git-filter-branch.txt | 14 ++++++--------
> >  git-filter-branch.sh                |  2 ++
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> > index 0a09698c0..6e4bb0220 100644
> > --- a/Documentation/git-filter-branch.txt
> > +++ b/Documentation/git-filter-branch.txt
> > @@ -167,14 +167,12 @@ to other tags will be rewritten to point to the underlying commit.
> >  	project root. Implies <<Remap_to_ancestor>>.
> >  
> >  --prune-empty::
> > -	Some kind of filters will generate empty commits, that left the tree
> > -	untouched.  This switch allow git-filter-branch to ignore such
> > -	commits.  Though, this switch only applies for commits that have one
> > -	and only one parent, it will hence keep merges points. Also, this
> > -	option is not compatible with the use of `--commit-filter`. Though you
> > -	just need to use the function 'git_commit_non_empty_tree "$@"' instead
> > -	of the `git commit-tree "$@"` idiom in your commit filter to make that
> > -	happen.
> > +	Some filters will generate empty commits that leave the tree untouched.
> > +	This option instructs git-filter-branch to remove such commits if they
> > +	have exactly one or zero non-pruned parents; merge commits will
> > +	therefore remain intact.  This option cannot be used together with
> > +	`--commit-filter`, though the same effect can be achieved by using the
> > +	provided `git_commit_non_empty_tree` function in a commit filter.
> >  
> >  --original <namespace>::
> >  	Use this option to set the namespace where the original commits
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 86b2ff1e0..2b8cdba15 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -46,6 +46,8 @@ git_commit_non_empty_tree()
> >  {
> >  	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
> >  		map "$3"
> > +	elif test $# = 1 && test "$1" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904; then
> > +		:
> >  	else
> >  		git commit-tree "$@"
> >  	fi

-- 
<><
