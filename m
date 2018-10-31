Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4000E1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeJaVC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:02:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44873 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJaVC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:02:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id b22-v6so17267890qtr.11
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/wQ9Vjx4mcXPq9UvHU4UiVD0ucfKs+UoZxAe83iDGU=;
        b=pVTXGumZnjSfFF9LP2TwO9Z5GABCXImn+TRsNXR6tAAzseoJ0eSMaGTyVkBqRq4lye
         t7Ab89wbRLPsfAo5SNMdLhCIKBT7ouQzhNN0MY3XziDiOAULvFy2f/MhihaebKFCpfeR
         Vyugy+upKxRD/Vb9MTZYxQb9x3X1w8/n29aEkpEYgzGt9ylKbzMoj0N3HPwC3FTuBJB5
         pYp/TazRFBwtrkjlAsHN5nqA1cKoTYFvrpS3Eao76Wwcv7ulAuAHbmzYrhlR11VPWU6A
         c83/oVtZN3GvXdEq64D31M6GXycDu0zcGSPLRZXpWRVt3/goQwBggt2w+a1eaVHviGyC
         SLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/wQ9Vjx4mcXPq9UvHU4UiVD0ucfKs+UoZxAe83iDGU=;
        b=dnhGe1dym8nBK17uFrqWJ/UMRuGFG/toOSaDMY5nGIpZSL13D6buUZGSj4UjIJ3WSt
         PPhtPvt+WgJdWrPH0wb/pl2BUlLjihg9Xu85u6rmYMjkESuCtXoPNb6ohE6cKUFOgQm9
         9r6ipTdcbok/H5spp1EZ9isJVja/tyEUNF/8DgpjwAXgsSD65afkRHXqGrQ+c6nEYQIG
         IRieE+QE6rmKcI6O1vCB/oThjeIBIigxNfU7UxSMFJks7sSfSsrxFyZcMAoKUFJsh0q9
         Pye0K03KHNPsXjB4cT17n+VqnxP/TWmbEoGCzKuxW+s+SyNGCNMqP5gfl/8fUKRPKapN
         rQng==
X-Gm-Message-State: AGRZ1gJXaEf2KCAvLkad6K0f4PGSvraUMYEjUXKcOD4sK6wJm5i/743+
        D18KcAdkkP362sHkwYXUeGmQYCWn
X-Google-Smtp-Source: AJdET5cFIO3Qs00R23Th0TjzONtN/SReCpgpo5SgILmUvYuR2ime4d6aQ8KpM9PO0HcuXpu4daF1CA==
X-Received: by 2002:a0c:ae30:: with SMTP id y45mr2241021qvc.145.1540987511786;
        Wed, 31 Oct 2018 05:05:11 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id y144-v6sm13211843qka.7.2018.10.31.05.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:05:11 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
Date:   Wed, 31 Oct 2018 12:05:05 +0000
Message-Id: <20181031120505.237235-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/31/2018 2:04 AM, Elijah Newren wrote:
> On Tue, Oct 30, 2018 at 7:16 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> As reported earlier [1], the add_missing_tags() method in remote.c has
>> quadratic performance. Some of that performance is curbed due to the
>> generation-number cutoff in in_merge_bases_many(). However, that fix doesn't
>> help users without a commit-graph, and it can still be painful if that
>> cutoff is sufficiently low compared to the tags we are using for
>> reachability testing.
>>
>> Add a new method in commit-reach.c called get_reachable_subset() which does
>> a many-to-many reachability test. Starting at the 'from' commits, walk until
>> the generation is below the smallest generation in the 'to' commits, or all
>> 'to' commits have been discovered. This performs only one commit walk for
>> the entire add_missing_tags() method, giving linear performance in the worst
>> case.
>>
>> Tests are added in t6600-test-reach.sh to ensure get_reachable_subset()
>> works independently of its application in add_missing_tags().
>
> On the original repo where the topic was brought up, with commit-graph
> NOT turned on and using origin/master, I see:
>
> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> To /home/newren/repo-mirror
>  * [new branch]       test5 -> test5
>
> real 1m20.081s
> user 1m19.688s
> sys 0m0.292s
>
> Merging this series in, I now get:
>
> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> To /home/newren/repo-mirror
>  * [new branch]       test5 -> test5
>
> real 0m2.857s
> user 0m2.580s
> sys 0m0.328s
>
> which provides a very nice speedup.
>
> Oddly enough, if I _also_ do the following:
> $ git config core.commitgraph true
> $ git config gc.writecommitgraph true
> $ git gc
>
> then my timing actually slows down just slightly:
> $ time git push --follow-tags --dry-run /home/newren/repo-mirror
> To /home/newren/repo-mirror
>  * [new branch]          test5 -> test5
>
> real 0m3.027s
> user 0m2.696s
> sys 0m0.400s

So you say that the commit-graph is off in the 2.8s case, but not here
in the 3.1s case? I would expect _at minimum_ that the cost of parsing
commits would have a speedup in the commit-graph case.  There may be
something else going on here, since you are timing a `push` event that
is doing more than the current walk.

> (run-to-run variation seems pretty consistent, < .1s variation, so
> this difference is just enough to notice.)  I wouldn't be that
> surprised if that means there's some really old tags with very small
> generation numbers, meaning it's not gaining anything in this special
> case from the commit-graph, but it does pay the cost of loading the
> commit-graph.

While you have this test environment, do you mind applying the diff
below and re-running the tests? It will output a count for how many
commits are walked by the algorithm. This should help us determine if
this is another case where generation numbers are worse than commit-date,
or if there is something else going on. Thanks!

-->8--

From 2115e7dcafb2770455b7b4793f90edc2254bad97 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Wed, 31 Oct 2018 11:40:50 +0000
Subject: [PATCH] DO-NOT-MERGE: count commits in get_reachable_subset

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index a98532ecc8..b512461cf7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -700,6 +700,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	struct commit **from_last = from + nr_from;
 	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
 	int num_to_find = 0;
+	int count = 0;
 
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
@@ -729,6 +730,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	while (num_to_find && (current = prio_queue_get(&queue)) != NULL) {
 		struct commit_list *parents;
 
+		count++;
+
 		if (current->object.flags & PARENT1) {
 			current->object.flags &= ~PARENT1;
 			current->object.flags |= reachable_flag;
@@ -755,6 +758,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	clear_commit_marks_many(nr_to, to, PARENT1);
 	clear_commit_marks_many(nr_from, from, PARENT2);
 
+	fprintf(stderr, "count: %d\n", count);
+
 	return found_commits;
 }
 
-- 
2.19.1.542.gc4df23f792

