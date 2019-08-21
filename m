Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01161F461
	for <e@80x24.org>; Wed, 21 Aug 2019 17:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfHURfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 13:35:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40415 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHURfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 13:35:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id c5so2772646wmb.5
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ySsgHYgh2EXdCh0R4SvnzSa4QfU0iN/jLJn1HyaLYNs=;
        b=WIFehBBw79DS8GHRGQWN6AmISCO7a1QoLg3mI8VpeW8GneGWgpsQLnlpiUWnkwp6tA
         aCvFBe7OPydjLN64qm7TS37j5fu3Ghdi6/hXsruTFrSKup5PipScai65VLLGY7Y2qdMj
         ovcxSElJR6hKyFA9qW5RA74vftfA1xKBSWnAK9dLR9rJN9wMFmuAXMZhEuYC3G9fPrhn
         b+pyZ5pWvnebTjnhzs7F37Q26+YRvncHDEVwKqf8UWkoEL8pD6QyQNAtHZjSyu4K3IiG
         cVK/esaEH/zsD75MOMhu24j2508PAaEVb7XyasQkgpLQcpx7/hNW315IbN9lTmykEX4J
         DaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ySsgHYgh2EXdCh0R4SvnzSa4QfU0iN/jLJn1HyaLYNs=;
        b=l6RqOFFuv4aFK6xTwfwy4y7EiPdI+E9e2vesEv/6Dr6V1UnVFK4iDdpW49bd131Uwa
         9Xi4z5MbtECmLjyfUi5wwB7cgEBl7EzPHdP2TE5wTCS0pLKebWuaTpdNUggY56kwAo87
         X7Jjzd5QpPSS76FG9FEpBXI35/4NjdZgSuwXKm+x7n6BSPSFNcVq5wU7xBYxSlfsnJqD
         XNswMGbb3tlFKvFCSlapGSZq+jG4imiBMC0MV2I9aIF+g9dnfCcz0mNecw1xeNuli72l
         PrSdSW0PKUmDPur8Zsy1jkb2gvtz1d+kKyskcdMT/AlSusyvCMTSfPPytHirAPYSS0++
         rZFw==
X-Gm-Message-State: APjAAAVZRtcR34BrLSn4Chga6Gz+jr9js3Dt4kFabIPDEgRWHkmmia+1
        hkkSvAPnD6YX3RcP/LJFIJE=
X-Google-Smtp-Source: APXvYqzNYXH8aujGXlOxyuMyru1wYs1q+a72LB/xeMoBBDIuDQx/XKwrKgySaRzZmyBxxno2nZezvw==
X-Received: by 2002:a1c:a7c9:: with SMTP id q192mr1287125wme.144.1566408918406;
        Wed, 21 Aug 2019 10:35:18 -0700 (PDT)
Received: from szeder.dev (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id p7sm351132wmh.38.2019.08.21.10.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 10:35:17 -0700 (PDT)
Date:   Wed, 21 Aug 2019 19:35:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
Message-ID: <20190821173515.GY20404@szeder.dev>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 11:53:28AM -0400, Derrick Stolee wrote:
> On 8/21/2019 7:04 AM, SZEDER Gábor wrote:
> > With rename detection enabled the line-level log is able to trace the
> > evolution of line ranges across whole-file renames [1].  Alas, to
> > achieve that it uses the diff machinery very inefficiently, making the
> > operation very slow [2].  And since rename detection is enabled by
> > default, the line-level log is very slow by default.
> > 
> > When the line-level log processes a commit with rename detection
> > enabled, it currently does the following (see queue_diffs()):
> > 
> >   1. Computes a full tree diff between the commit and (one of) its
> >      parent(s), i.e. invokes diff_tree_oid() with an empty
> >      'diffopt->pathspec'.
> >   2. Checks whether any paths in the line ranges were modified.
> >   3. Checks whether any modified paths in the line ranges are missing
> >      in the parent commit's tree.
> >   4. If there is such a missing path, then calls diffcore_std() to
> >      figure out whether the path was indeed renamed based on the
> >      previously computed full tree diff.
> >   5. Continues doing stuff that are unrelated to the slowness.
> > 
> > So basically the line-level log computes a full tree diff for each
> > commit-parent pair in step (1) to be used for rename detection in step
> > (4) in the off chance that an interesting path is missing from the
> > parent.
> > 
> > Avoid these expensive and mostly unnecessary full tree diffs by
> > limiting the diffs to paths in the line ranges.  This is much cheaper,
> > and makes step (2) unnecessary.  If it turns out that an interesting
> > path is missing from the parent, then fall back and compute a full
> > tree diff, so the rename detection will still work.
> 
> I applied your patches and tried them on our VFS-enabled version of Git
> (see [1]). Unfortunately, the new logic is still triggering rename
> detection, as measured by the number of objects being downloaded.

Well, the goal of this patch was to avoid full tree diffs if possible,
not to avoid rename detection :)

Anyway, I wonder how does 'git log -L1:your-evil-path --no-renames'
fare as a baseline?

> My *guess* is that the repo has a lot of merge commits, and for many
> of those, the file does not exist in the first parent.

Yeah, actual renames are only one of the possible causes that trigger
rename detection.  Surprisingly (well, to me, at least), in git.git
rename detection in line-level log is most often triggered by the
subtree merges of gitk and git-gui, not by actual renames.

> Since we are
> essentially doing a --full-history, this means that edge tries a
> rename detection. If we used the file-history simplification route of
> traveling along a treesame edge instead of caring about both parents,
> then maybe this would be avoided.
> 
> I could also be completely wrong about how this line-log code works
> with regards to --full-history.

Line-level log doesn't do '--full-history', though it does seem to
compute more diffs than a simple 'git log -- path'.

I applied the following diff on current master to add a bit of ad-hoc
tracing to see how many and which commit-parent diffs are computed:

diff --git a/line-log.c b/line-log.c
index 9010e00950..64f2c4d216 100644
--- a/line-log.c
+++ b/line-log.c
@@ -839,6 +839,8 @@ static void queue_diffs(struct line_log_data *range,
 	struct object_id *tree_oid, *parent_tree_oid;
 
 	assert(commit);
+	fprintf(stderr, "%s %s\n", oid_to_hex(&commit->object.oid),
+		parent ? oid_to_hex(&parent->object.oid) : "-");
 
 	tree_oid = get_commit_tree_oid(commit);
 	parent_tree_oid = parent ? get_commit_tree_oid(parent) : NULL;
diff --git a/revision.c b/revision.c
index 07412297f0..3f2182e32a 100644
--- a/revision.c
+++ b/revision.c
@@ -627,6 +627,8 @@ static int rev_compare_tree(struct rev_info *revs,
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
 
+	fprintf(stderr, "%s %s\n", oid_to_hex(&commit->object.oid),
+		parent ? oid_to_hex(&parent->object.oid) : "-");
 	if (!t1)
 		return REV_TREE_NEW;
 	if (!t2)


  $ ./git log v2.23.0 -- builtin/rev-list.c >/dev/null 2>P
  $ ./git log --full-history v2.23.0 -- builtin/rev-list.c >/dev/null 2>FH
  $ ./git log -L1:builtin/rev-list.c v2.23.0 >/dev/null 2>LL
  $ wc -l P FH LL
    17230 P
    70842 FH
    25995 LL
   114067 total

So line-level log clearly computes a lot less diffs than
'--full-history', though still about 50% more than a regular
pathspec-limited history traversal.  Looking at the commit-parent
pairs in the output, it appears that the difference comes mostly from
merge commits, because line-level log compares a merge commit with all
of its parents.

The number of processed commits is close enough, though:

  $ cut -d' ' -f1 P |sort -u |wc -l
  17164
  $ cut -d' ' -f1 LL |sort -u |wc -l
  17894

It seems there is still more room for improvements by avoiding
commit-non_first_parent diffs when the first parent is TREESAME, and
doing so could hopefully avoid triggering rename detection in those
subtree merges or in case of your evil path.


> > @@ -762,8 +778,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
> >  	range = parse_lines(rev->diffopt.repo, commit, prefix, args);
> >  	add_line_range(rev, commit, range);
> >  
> > -	if (!rev->diffopt.detect_rename)
> > -		parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
> > +	parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
> >  }
> 
> So we always parse the pathspec, even if we don't do detect renames.

Erm, no: we always parse the pathspec, even if we DO detect renames.

This condition made 'git log -L... --no-renames' fast.

> > @@ -821,15 +836,29 @@ static void queue_diffs(struct line_log_data *range,
> >  			struct diff_queue_struct *queue,
> >  			struct commit *commit, struct commit *parent)
> >  {
> > +	struct object_id *tree_oid, *parent_tree_oid;
> > +
> >  	assert(commit);
> >  
> > +	tree_oid = get_commit_tree_oid(commit);
> > +	parent_tree_oid = parent ? get_commit_tree_oid(parent) : NULL;
> > +
> > +	if (opt->detect_rename &&
> > +	    !same_paths_in_pathspec_and_range(&opt->pathspec, range)) {
> > +		clear_pathspec(&opt->pathspec);
> > +		parse_pathspec_from_ranges(&opt->pathspec, range);
> > +	}
> 
> If we are detecting renames and our pathspec is not up-to-date with the
> range, then clear the pathspec and reparse. Makes sense.

Renames (and subtree merges, etc.) are rare, so the paths rarely
change, and clearing and parsing pathspecs involves 2-3 memory
allocations and frees per path, so it's worth checking first.  It had
a slight but measurable performance impact, about 2% in the Linux
repository.

