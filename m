Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C0C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA320756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwpzV2cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHKMoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHKMoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 08:44:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5968DC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:44:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so12013862oie.12
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RpfBYhqkzAc95khig3CSmWRSHENSe5n2Pri+IMvF6GY=;
        b=BwpzV2cjKh0mxJhwSVFjFFE5cENbMHzTyZKo5dOSx/04vaTY1TQ8tPe7OtCvT9RNgK
         SW6gk0IpDcg7s8CUgPANY8aVN/Pm4dBgzrNYOdiDYfWbSWybeaz6ahsAG8T+mVd5vFZ6
         /vLP5cOeB6pAYyKtmkSitWjgMRv2MVtvfjCUUAmo+a2ZP2MIJRrgjSkB1gKULHRKTuON
         nxVdvJhfTwae9jBVQIitAwdHfaIqmOKlXLO+bvKICmovzgdnF1OYuV+Ob8l/wJXb5lX7
         20xDAnQ01ibAyWcccFqLx5QaPHCHiHWHYBZo3hg1GTlSes1Dk00AvrCvcVqK3u3o2Dkk
         VjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpfBYhqkzAc95khig3CSmWRSHENSe5n2Pri+IMvF6GY=;
        b=iYuk9+Oqh3QgJKG/Xzj7Y6937r1jiy+9I0pUbzqqYNaDUwXzviJSlVkAgjrjNbAzW5
         +RwUV5qreGZ0vrEQ/4Bit3nRHSIce6iY51XgY6lPETv4abZUrMc3auljZxcjRzZiXOUW
         s1tWr4wnPmGjLjzUb7H4SVO/tj9Z1pPX8Es/RaprufNILK7x7ST0TiQfUqtVOOOlkZUt
         FXmNR+n2Nbcm0C/E/tPx+ga6gBPeMLYtiFynic66ehPdRjGrPhXfxvAmjX28qHAPxazl
         3DmP2gjHJhwoApdbIu5Phlco72VVtdmxszZ4X8p6hizTVRqJAcamF+dmC0rAPJWhbCeP
         rqCw==
X-Gm-Message-State: AOAM533ftqrxxXK/nWJwzuNsnNJQFgHkpss2uOXFCCVDuvAD/cGpJwLU
        Kmk5Z/LUXbTTflnoBikCCeA=
X-Google-Smtp-Source: ABdhPJyLRaMD3TxY2rMZLUPIQCdj0Y/Lork448zShw4J3rBBTSVOZO/SZdnm88gkyklsonCp8oYc9w==
X-Received: by 2002:aca:b106:: with SMTP id a6mr3115147oif.46.1597149840973;
        Tue, 11 Aug 2020 05:44:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id y10sm4419817ooh.9.2020.08.11.05.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 05:44:00 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] commit-graph: handle mixed generation commit
 chains
To:     0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        jnareb@gmail.com, gitgitgadget@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <833779ad53eb4f57ae514f4e8964e397845f1ddd.1596941625.git.gitgitgadget@gmail.com>
 <0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com>
 <20200811113621.GB3220@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4043ffbc-84df-0cd6-5c75-af80383a56cf@gmail.com>
Date:   Tue, 11 Aug 2020 08:43:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200811113621.GB3220@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 7:36 AM, Abhishek Kumar wrote:
> On Mon, Aug 10, 2020 at 12:42:29PM -0400, Derrick Stolee wrote:
>> On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
>>
>> ...
>>
>> Hm. So this scenario actually disables generation numbers completely
>> in the event that anything in the chain disagrees. I think this is
>> not the right way to approach the situation, as it will significantly
>> punish users in this state with slow performance.
>>
>> The patch I sent [1] is probably better: it uses generation number
>> v1 if the tip of the chain does not have a GDAT chunk.
>>
>> [1] https://lore.kernel.org/git/a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com/
>>
> 
> Yes, the patch is an clear improvement over my (convoluted and incorrect)
> logic. Will add.
> 
>>
>> ...
>>
>> Please make a point to move the line that checks GIT_TEST_COMMIT_GRAPH_NO_GDAT
>> from its current location to after this line. We want to make sure that the
>> environment variable is checked _last_. The best location is likely the start
>> of the implementation of compute_generation_numbers(), or immediately before
>> the call to the method.
>>
> 
> Sure, will do.
> 
>>
>> ...
>>
>> It would be valuable to double-check here that the values in the GDAT chunk
>> are correct. I'm concerned about the possibility that the 'generation'
>> member of struct commit_graph_data gets filled with topological level during
>> parsing and then that is written as an offset into the CDAT chunk.
>>
>> Perhaps this is best left for a follow-up series that updates the 'verify'
>> subcommand to check the GDAT chunk.
> 
> If I can understand it correctly, one of ways to update 'verify'
> subcommand to check the GDAT chunk as well would to be make use of the
> flag variable introduced in your patch. We can isolate generation number
> related checks and run checks once with flag = 1 (checking corrected
> commit dates) and once with flag = 0 (checking topological levels).
> 
> This has the unfortunate effect of filling all commits twice, but as we
> cannot change the commit_graph_data->generation any other way, I see no
> alternatives without changing how commit_graph_generation() works.
> 
> Would it make more sense if we add the flag to struct commit_graph
> instead of making it depend solely on g->chunk_generation_data and set
> it within parse_commit_graph()?
> 
> We would be able to control the behavior of fill_commit_graph_info() and
> we will not need to check g->chunk_generation_data before filling every
> commit.

I missed that you _already_ updated the logic in verify_commit_graph()
based on the generation. That logic should catch the problem, so it
might be enough to just add some "git commit-graph verify" commands into
your multi-level tests.

Specifically, the end result is this check:

	corrected_commit_date = commit_graph_generation(graph_commit);
	if (corrected_commit_date < max_parent_corrected_commit_date + 1)
		graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
			     oid_to_hex(&cur_oid),
			     corrected_commit_date,
			     max_parent_corrected_commit_date + 1);

This will catch the order violations I was proposing could happen. It
doesn't go the extra mile to ensure that the commit-graph stores the
exact correct value or that the two bits of data are correct (both
topo-level and corrected commit date). That is fine for now, and we
can revisit if necessary.

The diff below makes some tweaks to your split-level test to show the
logic _was_ incorrect without my patch. Please incorporate the test
changes into your series. Note in particular that I added a base
layer that includes the GDAT chunk and _then_ adds a layer without
the GDAT chunk. That is an important case!

Thanks,
-Stolee

--- >8 ---

diff --git a/commit-graph.c b/commit-graph.c
index 17623274d9..d891a8ba3a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -674,14 +674,6 @@ int generation_numbers_enabled(struct repository *r)
 	if (!g->num_commits)
 		return 0;
 
-	/* We cannot compare topological levels and corrected commit dates */
-	while (g->base_graph) {
-		warning(_("commit-graph-chain contains mixed generation versions"));
-		if ((g->chunk_generation_data == NULL) ^ (g->base_graph->chunk_generation_data == NULL))
-			return 0;
-		g = g->base_graph;
-	}
-
 	first_generation = get_be32(g->chunk_commit_data +
 				    g->hash_len + 8) >> 2;
 
@@ -787,7 +779,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data && (flags & COMMIT_GRAPH_GENERATION_V2))
+	if (g->chunk_generation_data)
 		graph_data->generation = item->date +
 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 	else
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 1a9be5e656..721515cc23 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -443,6 +443,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 		test_commit $i &&
 		git branch commits/$i || return 1
 	done &&
+	git commit-graph write --reachable --split &&
 	git reset --hard commits/2 &&
 	for i in $(test_seq 6 10)
 	do
@@ -455,14 +456,15 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 	git reset --hard commits/4 &&
 	git merge commits/6 &&
 	git branch merge/2 &&
-	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
 	test-tool read-graph >output &&
 	cat >expect <<-EOF &&
-	header: 43475048 1 1 3 0
-	num_commits: 12
+	header: 43475048 1 1 4 1
+	num_commits: 7
 	chunks: oid_fanout oid_lookup commit_metadata
 	EOF
-	test_cmp expect output
+	test_cmp expect output &&
+	git commit-graph verify
 '
 
 test_expect_success 'does not write generation data chunk if not present on existing tip' '
@@ -472,23 +474,25 @@ test_expect_success 'does not write generation data chunk if not present on exis
 	git merge commits/5 &&
 	git merge merge/2 &&
 	git branch merge/3 &&
-	git commit-graph write --reachable --split &&
+	git commit-graph write --reachable --split=no-merge &&
 	test-tool read-graph >output &&
 	cat >expect <<-EOF &&
 	header: 43475048 1 1 4 1
 	num_commits: 3
 	chunks: oid_fanout oid_lookup commit_metadata
 	EOF
-	test_cmp expect output
+	test_cmp expect output &&
+	git commit-graph verify
 '
 
 test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
 	cd "$TRASH_DIRECTORY/mixed" &&
-	git commit-graph write --reachable --split='replace' &&
+	git commit-graph write --reachable --split=replace &&
 	test_path_is_file $graphdir/commit-graph-chain &&
 	test_line_count = 1 $graphdir/commit-graph-chain &&
 	verify_chain_files_exist $graphdir &&
-	graph_read_expect 15
+	graph_read_expect 15 &&
+	git commit-graph verify
 '
 
 test_done
