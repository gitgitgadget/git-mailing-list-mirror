Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4001F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeFDMwC (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:52:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40030 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeFDMwB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:52:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so6423139qtn.7
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xg4nxw583iHuHef5AOFtKABleR5WbvnmZxtX2BZviTE=;
        b=P+NPN0RxldLA9yta/++YpxmdokQO0dcxDJ4mvnY1q2bY5Oh1FlnuHPXjRRg0Pj6B5H
         dmIb/RxDEV08scrFjy5Ti2hK7bXnw1AdXA5hgFx3DqB77S5gW6hqQk/hjSE+VNszODZK
         xMtCf+4SpBCU+B08Au3JqTa0Y4BvWv0EWtSbdjrEdc4nO64W/htKXl9a1T0U/D24QW1s
         3xK7Z95nJEcIsRGP0ft7c1ml9Fe0tF4g/hly5DeyI5JP/uvNreNbJIwvFeGG+GlkKaoM
         yuRHuXI0lNkYel9AJZJDwyv+wejfulzgQv76W8okO3JlObNzJPRLqqF9CgneV5aIz0Xh
         3lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xg4nxw583iHuHef5AOFtKABleR5WbvnmZxtX2BZviTE=;
        b=OHGDePVwGHK9DLGg1O+x5WK6HkJ/18VtbvF/MWZdmvuGW0tcBlGbi0CcNX8keNvmPw
         YDDVBf9//UINd6TBAgT20BPdVm2oWFj1yGO+f+NTG9zs1ZWdE4/tB7SqKn6wHqk9h4Gp
         UFsgumXq4DkpKMx1z/q1fKz0IvCwqvfUIdIYByEVPs5vjXwDMlZN5FCEebwa5al6CpAi
         7DmyJfEhInfdaH5QhXnChIFrsR13ipSu3H14d3dXr5S+2Nivov3UDKQVOQ5HKHl59lEx
         5IAaD4Mchvtn6JIGC0IeuA8JVn5GgVjZUtjfp5j/OnMzzsS7Des3Vz57b6baoBvX7G2/
         T7SA==
X-Gm-Message-State: APt69E2IjEY+Q9kDHFd+uBZ34dufn3hoaSdzOBwyavXY8McC3HMfFGlJ
        Ni7xz6R49CvvN5lnhSQfjgQ=
X-Google-Smtp-Source: ADUXVKI7G4pEV/Xxt/RAKnZAVZVaFRibN715cbJRo4fLN1DBeN3Atr/tZbofz5Fi4UULdSRklQXAbg==
X-Received: by 2002:a0c:88e1:: with SMTP id 30-v6mr19626541qvo.73.1528116720314;
        Mon, 04 Jun 2018 05:52:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6990:e1e1:697d:a15? ([2001:4898:8010:0:52c6:e1e1:697d:a15])
        by smtp.gmail.com with ESMTPSA id 3-v6sm22590820qtx.16.2018.06.04.05.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 05:51:59 -0700 (PDT)
Subject: Re: [PATCH v3 19/20] gc: automatically write commit-graph files
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-20-dstolee@microsoft.com> <866031rrq1.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fc21c512-e6af-58c6-97e9-17e147b946bc@gmail.com>
Date:   Mon, 4 Jun 2018 08:51:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <866031rrq1.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 2:03 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The commit-graph file is a very helpful feature for speeding up git
>> operations. In order to make it more useful, write the commit-graph file
>> by default during standard garbage collection operations.
> I think you meant here "make it possible to write the commit-graph file
> during standard garbage collection operations." (i.e. add "make it
> possible" because it hides behind new config option, and remove "by
> default" because currently it is not turned on by default).
>
>> Add a 'gc.commitGraph' config setting that triggers writing a
>> commit-graph file after any non-trivial 'git gc' command. Defaults to
>> false while the commit-graph feature matures. We specifically do not
>> want to turn this on by default until the commit-graph feature is fully
> s/turn this on/have this on/  I think.
>
>> integrated with history-modifying features like shallow clones.
> Two things.
>
> First, shallow clones, replacement mechanims (git-replace) and grafts
> are not "history-modifying" features; this name is in my opinion
> reserved for history-rewriting features such as interactive rebase, the
> `git filter-branch` feature or out-of-tree BFG Repo Cleaner or
> reposurgeon tools.  They alter the _view_ of history; they should be
> IMVHO named "history-view-altering" features -- though I agree this is
> mouthful.
>
> Second, shouldn't we, as Martin Ågren said, warn about the issue in the
> manpage for git-commit-graph?
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/config.txt |  6 ++++++
>>   Documentation/git-gc.txt |  4 ++++
>>   builtin/gc.c             |  6 ++++++
>>   t/t5318-commit-graph.sh  | 14 ++++++++++++++
>>   4 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 11f027194e..9a3abd87e7 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1553,6 +1553,12 @@ gc.autoDetach::
>>   	Make `git gc --auto` return immediately and run in background
>>   	if the system supports it. Default is true.
>>   
>> +gc.commitGraph::
>> +	If true, then gc will rewrite the commit-graph file after any
>> +	change to the object database. If '--auto' is used, then the
>> +	commit-graph will not be updated unless the threshold is met.
> What threshold?  Ah, thresholds defined for `git gc --auto` (gc.auto,
> gc.autoPackLimit, gc.logExpiry,...).
>
>> +	See linkgit:git-commit-graph[1] for details.
> You missed declaring the default value for this config option.
>
>> +
>>   gc.logExpiry::
>>   	If the file gc.log exists, then `git gc --auto` won't run
>>   	unless that file is more than 'gc.logExpiry' old.  Default is
>> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
>> index 571b5a7e3c..17dd654a59 100644
>> --- a/Documentation/git-gc.txt
>> +++ b/Documentation/git-gc.txt
>> @@ -119,6 +119,10 @@ The optional configuration variable `gc.packRefs` determines if
>>   it within all non-bare repos or it can be set to a boolean value.
>>   This defaults to true.
>>   
>> +The optional configuration variable 'gc.commitGraph' determines if
>> +'git gc' runs 'git commit-graph write'. This can be set to a boolean
> Should it be "runs" or "should run"?
>
>> +value. This defaults to false.
> Should it be '...' or `...`?  Below we have `gc.aggresiveWindow`, above
> we have 'gc.commitGraph', for example.
>
>> +
>>   The optional configuration variable `gc.aggressiveWindow` controls how
>>   much time is spent optimizing the delta compression of the objects in
>>   the repository when the --aggressive option is specified.  The larger
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 77fa720bd0..efd214a59f 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -20,6 +20,7 @@
>>   #include "argv-array.h"
>>   #include "commit.h"
>>   #include "packfile.h"
>> +#include "commit-graph.h"
>>   
>>   #define FAILED_RUN "failed to run %s"
>>   
>> @@ -34,6 +35,7 @@ static int aggressive_depth = 50;
>>   static int aggressive_window = 250;
>>   static int gc_auto_threshold = 6700;
>>   static int gc_auto_pack_limit = 50;
>> +static int gc_commit_graph = 0;
>>   static int detach_auto = 1;
>>   static timestamp_t gc_log_expire_time;
>>   static const char *gc_log_expire = "1.day.ago";
>> @@ -121,6 +123,7 @@ static void gc_config(void)
>>   	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
>>   	git_config_get_int("gc.auto", &gc_auto_threshold);
>>   	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
>> +	git_config_get_bool("gc.commitgraph", &gc_commit_graph);
>>   	git_config_get_bool("gc.autodetach", &detach_auto);
>>   	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>>   	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
>> @@ -480,6 +483,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>   	if (pack_garbage.nr > 0)
>>   		clean_pack_garbage();
>>   
>> +	if (gc_commit_graph)
>> +		write_commit_graph_reachable(get_object_directory(), 0);
>> +
> Nice.
>
> Though now I wonder when appending should be used...

Appending is probably useless in the 'reachable' case, but is valuable 
in the '--stdin-packs' case (which is what we use in GVFS to maintain 
the commit-graph).

>
>>   	if (auto_gc && too_many_loose_objects())
>>   		warning(_("There are too many unreachable loose objects; "
>>   			"run 'git prune' to remove them."));
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index a659620332..d20b17586f 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -245,6 +245,20 @@ test_expect_success 'perform fast-forward merge in full repo' '
>>   	test_cmp expect output
>>   '
>>   
>> +test_expect_success 'check that gc clears commit-graph' '
> I wouldn't use the word "clears" here...
>
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git commit --allow-empty -m "blank" &&
>> +	git commit-graph write --reachable &&
>> +	cp $objdir/info/commit-graph commit-graph-before-gc &&
>> +	git reset --hard HEAD~1 &&
>> +	git config gc.commitGraph true &&
>> +	git gc &&
>> +	cp $objdir/info/commit-graph commit-graph-after-gc &&
>> +	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
>> +	git commit-graph write --reachable &&
>> +	test_cmp commit-graph-after-gc $objdir/info/commit-graph
>> +'
> ...but otherwise, nice test: it checks that git-gc after rewriting
> history changes commit-graph file, and that the changed file is what we
> expect it to be (note: here we compare commit-graph files directly, and
> not just check the features via 'git commit-graph read').
>
>> +
>>   # the verify tests below expect the commit-graph to contain
>>   # exactly the commits reachable from the commits/8 branch.
>>   # If the file changes the set of commits in the list, then the

