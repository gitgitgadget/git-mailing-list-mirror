Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D52B1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeAZMtF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:49:05 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:44779 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeAZMtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:49:04 -0500
Received: by mail-qt0-f182.google.com with SMTP id l20so904711qtj.11
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fd7sls5CSSawN6qXXuZTgTEgpcrKoe74anlfA8sjrtM=;
        b=aqrVh5Rt5Me8Ii/s6+kFlvrk2Owwm1De78w2JqK7g86jOGEOACdhiYi7Wsn3gOSVYu
         0aPdiznb7p2hS0sybdi4m2TylV921MhhYYbIX2PUEuFdGfYyJp11mRLn5RabUiGIlWHz
         LQExnaCpkofkFNLTRyq3ZGYKW4OtyYTAPZ4TGx9drbnw5p9sVJ8LWw54d7TiDuIgPf/B
         EFbiZsnNAcNTWgnJHKRRtSsR1vyXkOduWiSyEzLS/Irjfm1TQyJbitqJuV89h/sBSPxP
         J2Vx06mRQETrsBP/JRtDeWxm6cTxMXiyRtxkWJTozKCr2fmWtJbgXjDYiwUBabIMA7ld
         WC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fd7sls5CSSawN6qXXuZTgTEgpcrKoe74anlfA8sjrtM=;
        b=Tp4OeZ7ZVx9GqMDQ9AC9+Dgcaszq8onqDGElNaY1FgnCxKg48LrneLX33QsUcnPlP4
         BzyN3KWfWMy2sgnsi1Id90kgz4gD+kRFbMm5kcW87M55DfcEhZmYdvs5ZthFPme8vpm2
         rUlfO9ndIEeQVrc+/ordtUCwFX9Juo5iX/KLKibVinwQPIyLOXEp97oy0m9Kihz1rlR/
         O91Qjxwnn5TxIiB2/t95+49+Q+AQZAu1V4TX/YXf3rmHuQBYR729AgX2wOJGxWmKnLsn
         Mr9F59RIVsiLbkN/mNrFHG+V3lrWjNQ5yanHLQ9e3qPjuT+vJwgjIL5c+crb0LwcZDbV
         KVfg==
X-Gm-Message-State: AKwxyte9oA+j2PGaxiQpJzUQQlNoK6jgd4Qk5Pr2wJAuJw880r/0jhTg
        9SeCOvudIdehNgEnD6iqcdQ=
X-Google-Smtp-Source: AH8x226orRpTm4+WUjTrJl7WcYCKAuFnxx3ewgLbzhl3UXFe/e85YbvACGfEpSNtPcROtZG8A/Tyuw==
X-Received: by 10.55.186.130 with SMTP id k124mr20414947qkf.226.1516970943145;
        Fri, 26 Jan 2018 04:49:03 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k21sm5650539qta.12.2018.01.26.04.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 04:49:02 -0800 (PST)
Subject: Re: [PATCH 01/14] graph: add packed graph design document
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-2-dstolee@microsoft.com>
 <CAGZ79kbVoJpP3d_jgJ9Ekn=9NBMaKVNoapjygz7BxABxP2dCBg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b72406f-90cd-194e-1f5f-02a43b7b60a5@gmail.com>
Date:   Fri, 26 Jan 2018 07:49:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbVoJpP3d_jgJ9Ekn=9NBMaKVNoapjygz7BxABxP2dCBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 3:04 PM, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> Add Documentation/technical/packed-graph.txt with details of the planned
>> packed graph feature, including future plans.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/packed-graph.txt | 185 +++++++++++++++++++++++++++++++
>>   1 file changed, 185 insertions(+)
>>   create mode 100644 Documentation/technical/packed-graph.txt
>>
>> diff --git a/Documentation/technical/packed-graph.txt b/Documentation/technical/packed-graph.txt
>> new file mode 100644
>> index 0000000000..fcc0c83874
>> --- /dev/null
>> +++ b/Documentation/technical/packed-graph.txt
>> @@ -0,0 +1,185 @@
>> +Git Packed Graph Design Notes
>> +=============================
>> +
>> +Git walks the commit graph for many reasons, including:
>> +
>> +1. Listing and filtering commit history.
>> +2. Computing merge bases.
>> +
>> +These operations can become slow as the commit count grows above 100K.
> How did you come up with that specific number? (Is it platform dependent?)
> I'd avoid a specific number to not derail the reader here into wondering
> how this got measured.

Using a specific number was a mistake. Git can walk ~100K commits per 
second by parsing commits, in my tests on my machine. I'll instead say 
"commit count grows."

>> +The merge base calculation shows up in many user-facing commands, such
>> +as 'status' and 'fetch' and can take minutes to compute depending on
>> +data shape. There are two main costs here:
> status needs the walk for the ahead/behind computation which is (1)?
> (I forget how status would need to compute a merge-base)

'status' computes the ahead/behind counts using paint_down_to_common(). 
This is a more robust method than simply computing merge bases, but the 
possible merge bases are found as a result.

> fetch is a networked command, which traditionally in Git is understood as
> "can be slow" because you might be in Australia, or the connection is slow
> otherwise. So giving this as an example it is not obvious that the DAG walking
> is the bottleneck. Maybe git-merge or "git show --remerge-diff" [1] are better
> examples for walk-intensive commands?
>
> [1] https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/
>      never landed, so maybe that is a bad example. But for me that command
>      is more obviously dependent on cheap walking the DAG compared to fetch.
>      So, take my comments with a grain of salt!

Actually, a 'fetch' command does the same ahead/behind calculation as 
'status', and in GVFS repos we have seen that walk take 30s per branch 
when comparing local and remote copies a fast-moving branch. Yes, there 
are other (usually) more expensive things in 'fetch' so I'll drop that 
reference..

>> +1. Decompressing and parsing commits.
>> +2. Walking the entire graph to avoid topological order mistakes.
>> +
>> +The packed graph is a file that stores the commit graph structure along
>> +with some extra metadata to speed up graph walks. This format allows a
>> +consumer to load the following info for a commit:
>> +
>> +1. The commit OID.
>> +2. The list of parents.
>> +3. The commit date.
>> +4. The root tree OID.
>> +5. An integer ID for fast lookups in the graph.
>> +6. The generation number (see definition below).
>> +
>> +Values 1-4 satisfy the requirements of parse_commit_gently().
>
> This new format is specifically removing the cost of decompression and parsing
> (1) completely, whereas (2) we still have to walk the entire graph for now as
> the generation numbers are not fully used as of yet, but provided.

A major goal of this work is to provide a place to store computed 
generation numbers so we can not walk the entire graph. I mention this 
here because 'git log -<n>' is O(n) (due to commit-date heuristics that 
prevent walking the entire graph) while 'git log --topo-order -<n>' is 
O(T) where T is the total number of reachable commits.

>> +By providing an integer ID we can avoid lookups in the graph as we walk
>> +commits. Specifically, we need to provide the integer ID of the parent
>> +commits so we navigate directly to their information on request.
> Does this mean we decrease the pressure on fast lookups in
> packfiles/loose objects?

Yes, we do. In fact, when profiling 'git log --topo-order -1000', I 
noticed that 30-50% of the time (after this patch) is spent in 
lookup_tree(). If we can prevent checking the ODB for the existence of 
these trees until they are needed, we can get additional speedups. It is 
a bit wasteful that we are loading these trees even when we will never 
use them (such as computing merge bases).

>
>> +Define the "generation number" of a commit recursively as follows:
>> + * A commit with no parents (a root commit) has generation number 1.
>> + * A commit with at least one parent has generation number 1 more than
>> +   the largest generation number among its parents.
>> +Equivalently, the generation number is one more than the length of a
>> +longest path from the commit to a root commit. The recursive definition
>> +is easier to use for computation and the following property:
>> +
>> +    If A and B are commits with generation numbers N and M, respectively,
>> +    and N <= M, then A cannot reach B. That is, we know without searching
>> +    that B is not an ancestor of A because it is further from a root commit
>> +    than A.
>> +
>> +    Conversely, when checking if A is an ancestor of B, then we only need
>> +    to walk commits until all commits on the walk boundary have generation
>> +    number at most N. If we walk commits using a priority queue seeded by
>> +    generation numbers, then we always expand the boundary commit with highest
>> +    generation number and can easily detect the stopping condition.
> Thanks for including the definition and potential benefits!
>
>> +
>> +This property can be used to significantly reduce the time it takes to
>> +walk commits and determine topological relationships. Without generation
>> +numbers, the general heuristic is the following:
>> +
>> +    If A and B are commits with commit time X and Y, respectively, and
>> +    X < Y, then A _probably_ cannot reach B.
>> +
>> +This heuristic is currently used whenever the computation can make
>> +mistakes with topological orders (such as "git log" with default order),
>> +but is not used when the topological order is required (such as merge
>> +base calculations, "git log --graph").
>> +
>> +Design Details
>> +--------------
>> +
>> +- A graph file is stored in a file named 'graph-<oid>.graph' in the pack
>> +  directory.
> (guessing)
> where every commit up to <oid> is included in the file.

Sorry, the <oid> is the hash of the graph contents (up to its trailing 
bytes that contain <oid> in binary).

>> This could be stored in an alternate.
> So I can 'borrow' not just the objects itself, but also the file about object
> properties from an alternate. Makes sense, though I wonder if it is
> worth stating
> this as the first bullet point in the design detail section?

I could bring it up earlier. For GVFS, we plan to place the graph next 
to the packfiles in the "gitObjectCache" which is an alternate for all 
enlistements in the same drive.

>
>> +- The most-recent graph file OID is stored in a 'graph-head' file for
>> +  immediate access and storing backup graphs. This could be stored in an
>> +  alternate, and refers to a 'graph-<oid>.graph' file in the same pack
>> +  directory.
> So we have two copies of the latest in both 'graph-head.graph'
> as well as 'graph-<oid>.graph'? Would a link be ok? So instead
> we might have a 'graph-head.link' file that just contains 'oid: <oid>' ?
>
> But then again, we can get the oid from HEAD, and these graph files
> can contain all information up to multiple tips (i.e. there is just one graph
> file needed, even if you have 2 branches, neither of them to be
> fast-forwardable to the other).
>
> So maybe I do not understand the <oid> after all, yet.

Perhaps I should instead use <hash> instead of <oid>, since it is not an 
actual Git object but instead the hash of the graph contents. The 
'graph_head' file simply stores the <oid> as plain-text hex characters.

When updating the graph using 'git graph --write --update-head 
--delete-expired', we follow this pattern:

1. write new graph-<hash2>.graph file
2. write graph_head to contain <hash2>
3. delete old graph-<hash1>.graph file.

>> +- The core.graph config setting must be on to create or consume graph files.
> We already have other local files that speed up things, such as idx files.
> Searching our config options for "idx" I find 'pack.indexVersion', which
> only controls the write side of idx. Reading idx seems automatic if they are
> there, otherwise we fallback to non-idx.
>
> By having the setting a boolean we cannot control the version yet, but we can
> later upgrade the config to a boolean-or-int that specifies which graph
> version is written out.
>
> Why do we need this config option to control the reading side as well?
> AFAICT the user can just delete all graphs if the graphs make problems and
> then regenerate them if git is too slow?
>
> As these files need to be manually generated as of this series, I'd further
> argue that the reading should be unguarded by the config option.

I see this config option as temporary as the feature is hardened. In the 
(hopefully unlikely) case of a bug, I'd rather unblock a user by giving 
them a config setting to disable instead of telling them to downgrade. 
As the feature is more robust and covered by other test cases (such as 
when the graph is automatically generated during repack or after a 
fetch) then we can afford to drop this "kill switch".

>> +- The graph file is only a supplemental structure. If a user downgrades
>> +  or disables the 'core.graph' config setting, then the existing ODB is
>> +  sufficient.
> (Maybe mention idx files as a comparable design?)

I was actually thinking this is more comparable to the reachability 
bitmaps. The only difference is that the graph is not paired to a 
packfile. While dropping an IDX file is recoverable through 'git 
index-pack', the contents of that packfile are not available until you 
do so. If you run 'git graph --clear' and delete your graph file, all 
git commands will work as before.

>> +- The file format includes parameters for the object id length
>> +  and hash algorithm, so a future change of hash algorithm does
>> +  not require a change in format.
> Cool.
>
>> +
>> +Current Limitations
>> +-------------------
>> +
>> +- Only one graph file is used at one time. This allows the integer ID to
>> +  seek into the single graph file. It is possible to extend the model
>> +  for multiple graph files, but that is currently not part of the design.
>> +
>> +- .graph files are managed only by the 'graph' builtin. These are not
>> +  updated automatically during clone or fetch.
>> +
>> +- There is no '--verify' option for the 'graph' builtin to verify the
>> +  contents of the graph file.
> c.f. git index-pack --verify (which is not documented :/)
>
>> +- The graph only considers commits existing in packfiles and does not
>> +  walk to fill in reachable commits. [Small]
> small?

Sorry for this in two ways: I left this "small" note to myself, and then 
forgot to remove it from the limitations after I implemented it (see 
patch 13/14).

>> +- When rewriting the graph, we do not check for a commit still existing
>> +  in the ODB, so garbage collection may remove commits
>> +
>> +- Generation numbers are not computed in the current version. The file
>> +  format supports storing them, along with a mechanism to upgrade from
>> +  a file without generation numbers to one that uses them.
> Maybe move the definition and explanation of the generation numbers above to
> the "Future Work" section?

I'm hesitant to move them to "Future Work" because generation numbers 
are so important to the design of the feature. If this design could not 
provide generation numbers as an easy second patch, then the design is 
bad and should not be used.

>> +
>> +Future Work
>> +-----------
>> +
>> +- The file format includes room for precomputed generation numbers. These
>> +  are not currently computed, so all generation numbers will be marked as
>> +  0 (or "uncomputed"). A later patch will include this calculation.
>> +
>> +- The current implementation of the 'graph' builtin walks all packed objects
>> +  to find a complete list of commits in packfiles. If some commits are
>> +  stored as loose objects, then these do not appear in the graph. This is
>> +  handled gracefully by the file format, but it would cause incorrect
>> +  generation number calculations. We should implement the construct_graph()
>> +  method in a way that walks all commits reachable from some starting set
>> +  and then can use complete information for generation numbers. (Some
>> +  care must be taken around shallow clones.)
>> +
>> +- The graph is not currently integrated with grafts.
> not integrated? Does that mean we error out on grafts, or gracefully fallback
> to a sane thing?

I have no idea what would happen if you tried to use this commit graph 
feature with grafts enabled. I'm not familiar enough with the feature to 
know how it works and to plan for it.

The issue right now is that there is graft code in parse_commit_buffer() 
that I did not duplicate in parse_packed_commit() [see patch 11/14]. 
Since currently grafts and packed-grafts are opt-in features that need 
to be set by a user (i.e. you do not get them automatically by cloning) 
I thought it sufficient to say these features are incompatible.

>> +- After computing and storing generation numbers, we must make graph
>> +  walks aware of generation numbers to gain performance benefits. This
>> +  will mostly be accomplished by swapping a commit-date-ordered priority
>> +  queue with one ordered by generation number. The following operations
>> +  are important candidates:
>> +
>> +    - paint_down_to_common()
>> +    - 'log --topo-order'
>> +
>> +- The graph currently only adds commits to a previously existing graph.
>> +  When writing a new graph, we could check that the ODB still contains
>> +  the commits and choose to remove the commits that are deleted from the
>> +  ODB. For performance reasons, this check should remain optional.
>> +
>> +- Currently, parse_commit_gently() requires filling in the root tree
>> +  object for a commit. This passes through lookup_tree() and consequently
>> +  lookup_object(). Also, it calls lookup_commit() when loading the parents.
>> +  These method calls check the ODB for object existence, even if the
>> +  consumer does not need the content. For example, we do not need the
>> +  tree contents when computing merge bases. Now that commit parsing is
>> +  removed from the computation time, these lookup operations are the
>> +  slowest operations keeping graph walks from being fast. Consider
>> +  loading these objects without verifying their existence in the ODB and
>> +  only loading them fully when consumers need them. Consider a method
>> +  such as "ensure_tree_loaded(commit)" that fully loads a tree before
>> +  using commit->tree.
>> +
>> +- The current design uses the 'graph' builtin to generate the graph. When
>> +  this feature stabilizes enough to recommend to most users, we should
>> +  add automatic graph writes to common operations that create many commits.
>> +  For example, one coulde compute a graph on 'clone' and 'fetch' commands.
> typo "could"
>
> Once we have incrementally-update-able graphs, we certainly want commit/merge
> to also write out updates? (or batch them after a long rebase).

I think batching will always be a good idea. It is feasible to have some 
threshold where there are enough reachable commits that are not in the 
graph to trigger a write (incremental or not). My gut feel is that 
number is at least 100.

Thanks,
-Stolee
