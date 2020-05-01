Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F5C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B29206D6
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOWbHl0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgEAONt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728886AbgEAONs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 10:13:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFBC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:13:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so5002702ion.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65v6OkH6IrH3x72NxzZV0wTdQ+Ya4eO/Q6zLc/kagiA=;
        b=EOWbHl0rhWHaZWWM4eakXZjMvNOsrDVoK1OLyKH6XIll0pftrcQlBtCTfT6LFCBZwc
         7a877edl50i1/xEAtPILk0a9ivu3NZ14aV40dONuTlJbrvxwNr/YQ8vlNDQzqXvAGKJi
         oqecnVwnihpsO0PZB0KmluSNEJcyj4nq6OLKWXjN2t894v3shucpS1y5e/FPTBERBQ4B
         k3GXtX2p+BzSoIlOZSPpU7N4Cotx9sGnoPvrXmZVBJqrIydEdqt2OKBJ9d5rtTrb11J9
         5cKgcF83bX9cIECra7hBIPJ+1qZCTN7YB2jqfl2i6gG5IrJf9bKBFkyilnO5ERZw2233
         nLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65v6OkH6IrH3x72NxzZV0wTdQ+Ya4eO/Q6zLc/kagiA=;
        b=rTz9pPTxEegENqpyhfgCKF/M8hEKVPMGsWzbUknVHJPo409XBEbnKdsJgzSr92rTrf
         Korpi4zVt8rzPj3l85X3VUwpzWLRxmGIxWMiwyHxMZ0dlEusMNqLHBZIlKau1xRO1dkn
         AGdmq8oRt05aK9Ocf/UwWonlVK6ikxuWnOPY0y6WJjC5GM5E3QNYal/YHOP5bPWHUohH
         n10E614ZJ3LL2bg1YKbJaxRVCX6q0feM9Lp/bdhDllvw27bmr/6/oOC0y246RmPJODhL
         RyQmsfRdn+dKIZPAfxNF+NGXCtpDqcQ+ofRES98QOt1FiVGZQ4bq0DZj5Co+DLDulfjX
         pIHA==
X-Gm-Message-State: AGi0Pub2Fo1jTgBdk+GIKOwjBu9mGoktLDfgE4emXkaDNZ9xyiiqkI7X
        Fle0Bs3JvL3Iw9uIoVklJxI=
X-Google-Smtp-Source: APiQypKEh1pfht4KDOj8QizZOEgE3T4Y1yyodJ7/lqxX9oO3RtDbghmPk61NnL+GDvWMPh0mcit8WA==
X-Received: by 2002:a5d:8889:: with SMTP id d9mr4051813ioo.50.1588342427064;
        Fri, 01 May 2020 07:13:47 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:e01d:d556:c354:b051? ([2601:8c0:37f:6012:e01d:d556:c354:b051])
        by smtp.gmail.com with ESMTPSA id y3sm1275089ila.70.2020.05.01.07.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:13:46 -0700 (PDT)
Subject: Re: [PATCH v2] Teach git-rev-list --simplify-forks
To:     Derrick Stolee <stolee@gmail.com>, git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <08d5460b-d80b-28a3-19dd-d438afbdfba9@gmail.com>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Message-ID: <2a668dd2-35c0-7510-fc4d-6c44e8407a07@gmail.com>
Date:   Fri, 1 May 2020 08:13:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <08d5460b-d80b-28a3-19dd-d438afbdfba9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/20 7:12 AM, Derrick Stolee wrote:
> On 4/29/2020 4:01 AM, Antonio Russo wrote:
>> When used with --graph, instead of displaying the full graph, display a
>> spanning subgraph produced by a depth-first search of the graph visiting
>> parents from left to right.  Edges to already visited commits are
>> discarded.  This process is repeated for every commit to be displayed.
>>
>> This is valuable to reduce visual clutter when there are many merges
>> that were not rebased onto each other and the user is primarily
>> interested in the state of the branch being merged into.
>
> My earlier comment to recommend how to fix the test failures intended
> to demonstrate that this area of code requires a bit of precision. I
> took some time to review this patch, but I find it needs some significant
> updates.
>
> tl;dr: The way you manipulate the commit parents seems incorrect to me,
> but perhaps there is enough prior art in the way we simplify parents to
> make that acceptable. Someone else will need to chime in on that part.

First, thank you for taking the time look at this.  I understand your
hesitation about the "amputation" of the history, but in some sense
that's the point of this option.  I really want to be ignorant of the
details of when the fork branched off.  I would like the reported
history to be appear nearly equivalent to a rebase-and-fastforward only
merge style, which results in a much simpler git log --graph.

> It may be possible to do this "drop edges" entirely inside of graph.c
> (the graph rendering code) instead of revision.c, which would automatically
> work with the performance gains from the newer topo-walk algorithm.

Non-local information about the commit graph needs to be used to do this
amputation of the history.  We cannot know how many parents we want to
display until we've completely explored all the parents of that node.
Unfortunately, that means that the whole graph needs to be loaded, and I
cannot really see how there would be any gain by doing this in graph.c.

Caveat: there are semi-streaming DFS implementations (i.e., O(n log n)
space) that we might be able to use to get the first line out the door
quicker. I would, however, like to leave that to another patch.

I will also add that, for the tests I've done, all performance penalties
have been insignificant (less than ~5% for showing the first commit),
while there are significant performance _improvements_, e.g., ~40% for
displaying the full tree.

A notable exception is --all, which can be ~50x faster for the full
output, but is often dramatically slower to show anything (i.e., the
first line).

> There are enough deviations from code and test style that this will
> need a significant revision regardless.

(Please see forthcoming revision 3).

>> This second revision of the patch sets revs->limited.  This forces the
>> graph of commits to be loaded, and simplfiy_forks() therefore reliably
>> traverses it.  This addresses the test failures mentioned before (see [1]).
>
> This will have a significant performance impact on the option, as you will
> not see even the first result until the DFS has completed.

First of all, short of using some other, more sophisticated streaming
version of this algorithm, the full DFS must finish before the first
commit having two (or more) parents can be shown.

That said, the performance is not significantly affected:

I ran the following test (2.26.2, with my patch on top of it):
(git lg = git log --graph --pretty=oneline)

 % time git lg -n1 --ignore-merge-bases e896a286df > /dev/null
 0.73s user 0.02s system 99% cpu 0.746 total

 % time git lg -n1 e896a286df > /dev/null
 0.72s user 0.01s system 99% cpu 0.731 total

 For the linux git repo:

 % time git lg -n1 --ignore-merge-bases v5.7-rc3 >/dev/null
 9.25s user 0.39s system 99% cpu 9.646 total

 % time git lg -n1 v5.7-rc3 >/dev/null
 9.02s user 0.35s system 99% cpu 9.378 total

So the performance seems basically unaffected for very limited graphs.
It's also about 40% faster for complicated ones (as mentioned in my
first email):

 % time git lg --ignore-merge-bases e870325ee8 > /dev/null
 0.83s user 0.06s system 99% cpu 0.886 total

 % time git lg e870325ee8 > /dev/null
 1.41s user 0.03s system 99% cpu 1.443 total

 For the linux git repo:

 % time git lg --ignore-merge-bases v5.7-rc3 >/dev/null
 11.86s user 0.62s system 99% cpu 12.489 total

 % time git lg v5.7-rc3 >/dev/null
 21.56s user 0.55s system 99% cpu 22.108 total

This is because the amputated graph is much simpler, and the rest of the
code needs to do much less work.

Passing --all is another beast, and does indeed suffer:

 % time git lg --ignore-merge-bases --all >/dev/null
 4.06s user 0.04s system 99% cpu 4.105 total

 % time git lg --all >/dev/null
 189.59s user 0.04s system 99% cpu 3:09.65 total

 (and for the first line)

 % time git lg -n1 --ignore-merge-bases --all >/dev/null
 3.86s user 0.02s system 99% cpu 3.874 total

 % time git lg -n1 --all >/dev/null
 0.83s user 0.02s system 99% cpu 0.848 total

(If you need to use --all for the Linux git repo, you should not use
--ignore-merge-bases).

There's certainly performance improvements to be desired, but they do
not appear except for very large repositories, and only when combined
with --all.

>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 04ad7dd36e..cbac09028c 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -363,6 +363,14 @@ Default mode::
>>  	merges from the resulting history, as there are no selected
>>  	commits contributing to this merge.
>>
>> +--simplify-forks::
>> +	Convert the commit graph into a spanning subgraph produced by a
>> +	depth-first-search of the history graph, searching the leftmost
>> +	parent first, and discarding edges to commits already visited.
>> +	Useful with `--graph` to visualize repositories with many merges
>> +	when you are interested in was added to master, and not when the
>> +	branch was last rebased.
>
> Describing the option via the algorithm may not be the best way to
> inform the user of what they will see. It also will not be informative
> if the implementation changes to not perform the algorithm described
> here, because that algorithm is not incremental (it is O(N) where N is
> the total number of reachable commits, not ~O(n) where n is the number
> of commits that will actually show up).
>
> An easy test is to time your command with "-n 1".

While this is true, it is not the dominant effect (see above).

> I'm also not crazy about "when the branch was last rebased". You
> probably mean "..when you are not interested in which merge base
> was used for each merge."
>
> Also, this does nothing without "--graph" right? Perhaps it should
> enable it?

Not quite.  The patch interacts very nicely with gitk!

> Here is a suggested alternative:
>
> --simplify-forks::
> 	Show commits that are introduced by each merge before showing
> 	the first parent of the merge, as in `--graph`, but remove
> 	edges from those commits to commits reachable from the first
> 	parent. This helps to visualize repositories with many merges
> 	when you are not interested in which merge base was used for
> 	each merge. It also reduces the width of the graph visualization
> 	compared to `--graph`.
>
> With this description, perhaps it is worth renaming the option? Perhaps
> "--ignore-merge-bases"? The word "simplify" implies something like
> dropping commits from history, but you are instead dropping _edges_ from
> the graph.

(see revision 3).

>>  --ancestry-path::
>>  	When given a range of commits to display (e.g. 'commit1..commit2'
>>  	or 'commit2 {caret}commit1'), only display commits that exist
>> diff --git a/revision.c b/revision.c
>> index 5bc96444b6..51dbe21847 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2082,6 +2082,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>  		revs->simplify_by_decoration = 1;
>>  		revs->limited = 1;
>>  		revs->prune = 1;
>> +	} else if (!strcmp(arg, "--simplify-forks")) {
>> +		revs->limited = 1;
>> +		revs->simplify_forks = 1;
>
> I recommend dropping the revs->limited setting here and instead fixing the
> performance instead. But maybe that should be a second patch on top of this
> one.

(See above.)

>>  	} else if (!strcmp(arg, "--date-order")) {
>>  		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
>>  		revs->topo_order = 1;
>> @@ -3095,6 +3098,63 @@ static void simplify_merges(struct rev_info *revs)
>>  	}
>>  }
>>
>> +static void simplify_forks(struct rev_info *revs)
>> +{
>> +	struct commit_list *stack, *list_lr, *iter_list;
>> +	struct commit_list **parents;
>
> You want "struct commit_list *parents" here for simpler use.

Using a pointer to the pointer makes the amputation of the parents much
more uniform: we can just pop_commit(parents), and it handles the cases
of the first parent (which is addressed by commit->parents) and later
parents (which are addressed by list_element->next).

Of course, I'm insistent here that we should still be amputating the
graph.

>> +	struct commit *commit, *parent;
>> +
>> +	stack = NULL;
>> +	list_lr = NULL;
>> +
>> +	clear_object_flags(SIMP_FORK_VISITED);
>> +
>> +	for(iter_list = revs->commits; iter_list; iter_list = iter_list->next) {
>
> This method could use a split into at least two. I count three levels of nested
> loops here, so please break them up into smaller methods.

(see revision 3).

>> +		/* process every commit to be displayed exactly once */
>> +		if(iter_list->item->object.flags & SIMP_FORK_VISITED)
>> +			continue;
>> +		clear_object_flags(SIMP_FORK_VISITING);
>
> This drops the flag from all commits. This will cause quadratic performance
> if combined with "--all". Drop this and instead clear the flag yourself as you
> visit commits.

See revision 3.  I now re-walk the tree as needed.  Performance under
--all is now extremely good (but does not stream).

>> +		commit_list_insert(iter_list->item, &stack);
>> +		iter_list->item->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
>> +		while(stack) {
>> +			commit = pop_commit(&stack);
>> +			/* process the parent nodes: removing links to
>> +			 * commits already visited (creating a spanning tree)
>> +			 */
>> +			parents = &(commit->parents);
>> +			while(*parents) {
>
> You have some whitespace issues. Put a space between "while" and "(". Same with "if"s below.

(See revision 3).  I think I got them all.

>> +				parent = (*parents)->item;
>> +				if(parent->object.flags & SIMP_FORK_VISITING) {
>> +					/* We have already visited this commit, from the same root.
>> +					 * We do not explore it at all.
>> +					 */
>> +					pop_commit(parents);
>
> I don't think you want pop_commit() here. You want to have "parents = parents->next" at the end.
>
> Now, if this is how you are "simplifying" the edges in the final output, then I think this is
> destructive and unsafe! You are literally modifying "commit->parents" so if another operation in
> Git tries to read those parents it will see the wrong data.
>
> Think about a different way to achieve your goal here, perhaps in the rendering portion of
> graph.c instead of here.

I would really like to be blissfully ignorant of branches' merge bases.

I understand that this feature interacts nontrivially with things like
--boundary (and in fact does retain significant information in the
ordering---see the last test case in t6016).  That said, it's not clear
to me the use case for this when combined with other sophisticated graph
manipulations.

At the end of the day, I'm trying to make a feature that aids in
visualizing the repository.  Do you had an example case where someone
would like to use this feature, but removing these parents makes these
other options less useful?

>> +				} else if(parent->object.flags & SIMP_FORK_VISITED) {
>> +					/* We visited this commit before, but from a different root.
>> +					 * Leave it attached, but do not explore it further.
>> +					 */
>> +					parents = &((*parents)->next);
>> +				} else {
>> +					/* We have not visited this commit yet. Explore it, as usual.
>> +					 */
>> +					parent->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
>> +					commit_list_insert(parent, &list_lr);
>> +					parents = &((*parents)->next);
>> +				}
>
> It is very unclear that your loop terminates. Instead, use
> "parents = parents->next" at the end of the loop block to
> make is extremely clear that the loop behaves as expected.
>
> Of course, this assumes that you are not being destructive
> to the commit parents as you explore.

(*parents) is a commit_list.  If, at the start of an iteration of the
loop, it has n items in it, by the end of that iteration, we will have
either removed the head commit (via pop_commit) or advanced one item
down the list.  In either case, there are n-1 items in the list at the
end of the iteration.  Therefore, the loop must terminate.

I've slightly adjusted the layout to make this more clear.

>> +			}
>> +
>> +			/* feed the parents, right to left (reversed) onto the
>> +			 * stack to do a depth-first traversal of the commit graph
>> +			 */
>
> nit: multi-line comment style [1]
>
> [1] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/Documentation/CodingGuidelines#L285-L291
>
>> +			while(list_lr) {
>> +				commit_list_insert(pop_commit(&list_lr), &stack);
>> +			}
>
> nit: No curly braces around single-line blocks. [2]
>
> [2] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/Documentation/CodingGuidelines#L239-L243

Thank you (and see revision 3).

>> +		}
>> +	}
>> +
>> +	clear_object_flags(SIMP_FORK_VISITED | SIMP_FORK_VISITING);
>> +}
>> +
>>  static void set_children(struct rev_info *revs)
>>  {
>>  	struct commit_list *l;
>> @@ -3392,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
>>  	if (revs->limited) {
>>  		if (limit_list(revs) < 0)
>>  			return -1;
>> +		if (revs->simplify_forks)
>> +			simplify_forks(revs);
>>  		if (revs->topo_order)
>>  			sort_in_topological_order(&revs->commits, revs->sort_order);
>>  	} else if (revs->topo_order)
>> diff --git a/revision.h b/revision.h
>> index c1af164b30..f1abdb26b0 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -51,6 +51,11 @@
>>  #define TOPO_WALK_EXPLORED	(1u<<27)
>>  #define TOPO_WALK_INDEGREE	(1u<<28)
>>
>> +/* Re-use the TOPO_WALK flagspace for simplify_forks
>> + */
>> +#define SIMP_FORK_VISITED	(1u<<27)
>> +#define SIMP_FORK_VISITING	(1u<<28)
>
> I don't like that you are re-using these, as it is dangerous for later
> collisions. At the moment, these flags are not used in the same code paths
> because you specify "limited = 1" and that code path does not use TOPO_WALK_*
> macros.

I'm happy to use a different bit, and it would make me sleep easier
knowing that this code is portable without worrying about this flag.
I'm now using bits 23 and 24.

>>  #define DECORATE_SHORT_REFS	1
>>  #define DECORATE_FULL_REFS	2
>>
>> @@ -132,6 +137,7 @@ struct rev_info {
>>  			no_walk:2,
>>  			remove_empty_trees:1,
>>  			simplify_history:1,
>> +			simplify_forks:1,
>>  			show_pulls:1,
>>  			topo_order:1,
>>  			simplify_merges:1,
>> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
>> index f5e6e92f5b..d99214b6df 100755
>> --- a/t/t6016-rev-list-graph-simplify-history.sh
>> +++ b/t/t6016-rev-list-graph-simplify-history.sh
>> @@ -85,6 +85,28 @@ test_expect_success '--graph --all' '
>>  	test_cmp expected actual
>>  	'
>>
>> +# Make sure that simplify_histpry_forks produces a spanning tree
>> +test_expect_success '--graph --simplify-forks --all' '
>> +	rm -f expected &&
>> +	echo "* $A7" >> expected &&
>> +	echo "*   $A6" >> expected &&
>> +	echo "|\  " >> expected &&
>> +	echo "| * $C4" >> expected &&
>> +	echo "| * $C3" >> expected &&
>> +	echo "* $A5" >> expected &&
>> +	echo "*-.   $A4" >> expected &&
>> +	echo "|\ \  " >> expected &&
>> +	echo "| | * $C2" >> expected &&
>> +	echo "| | * $C1" >> expected &&
>> +	echo "| * $B2" >> expected &&
>> +	echo "| * $B1" >> expected &&
>> +	echo "* $A3" >> expected &&
>> +	echo "* $A2" >> expected &&
>> +	echo "* $A1" >> expected &&
>
> Do not use too many echos like this. Instead use t4215-log-skewed-merges.sh
> as an example [3].
>
> [3] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/t/t4215-log-skewed-merges.sh#L24-L37
>
> I also hope that you can find more complicated cases to
> test, including:
>
>  1. A merge that brings in a merge (think a feature branch)
>  2. A merge that brings in a twisted merge (think a user using "git pull").
>
> Here are some example --graph and --simplify-forks outputs to try. I
> have not tested these myself, but I believe they are interesting test
> cases that can trip up other algorithms.
>
> Merge bringing a merge (non-twisted):
>
>  --graph	--simplify-forks
>  *		*
>  |\		|\
>  | *		| *
>  | |\		| |\
>  | | *		| | *
>  | * |		| *
>  * | |		*
>  |/ /		*
>  * /		*
>  |/
>  *
>
> Twisted merge:
>
>  --graph	--simplify-forks
>  *		*
>  |\		|\
>  | *		| *
>  | |\		| *
>  | * |		*
>  | | |		*
>  * |/		*
>  |/|
>  * |
>  |/
>  *

That is much nicer.  I've cleaned up t6106 in a similar way, and test
--ignore-merge-bases there, t4215, and in the new t4216.

Thanks,
Antonio
