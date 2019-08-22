Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346A51F461
	for <e@80x24.org>; Thu, 22 Aug 2019 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfHVImE (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 04:42:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39558 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfHVImE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 04:42:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so4583677wra.6
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iikSBuifVkFQsxAITnrQx1natvqpjbdvah4tGRt8YRY=;
        b=jAU4/mhOfrQd8MLsJZKXa2Mi9rBZzLcFpJfAcDAVKPZiq3dXvHMF3bzHDZCnHW+wiC
         RdEpkbnX3lmXwQfa5opwDR9AN8JdMjukBAAFrTZvY6fVv10HV75IC+h59k3wjyqJuwlt
         LSO49W+qrtp4QhZfSLHiPgeF2Dnt4Ua5O0ODA24nYcpkqH0uITeLmS0WCum5Lary8B4k
         6tC3yIH25anE2vZfxblwqLfSMR0Ng04L8Q571IWMolrW8gEkkuU6jtsSk1DExUvbsY8Q
         i2pR1Smi0aJGZe4iFQIdBF3ID5/LaswaQiznVo3BM1N7LVw0+abaSmkyaC5PPkndwqH/
         gHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iikSBuifVkFQsxAITnrQx1natvqpjbdvah4tGRt8YRY=;
        b=ADG4CqJStx2G/io6KS0ER0+nbe8U+tf1Qp4HfmgoMLFgevhHPUXGBT0tlTJXSeOpeo
         Mi3yMFeJM8gkvK73hDQHDY5WQgVqpfik4FEg4/oz31Jhdm7oxXgILJa16Ly6RrpGBNpe
         cvbmXeaOnweOIZUGC//xfMbDiUuEhb74Az4Kwo6NZ4O1+eN/5COBYfjj4/wuHbhs0lxP
         LAGn1Z01AuSp462i8KpifBEPl45ZZwkKMKlpk6l8sL6594mCPQb7Xgz7ycYc3wwe0kH4
         mbZP9jiVEe9BeilXRTnUqSr7XWrqtxIzeN4MBrCerqPMLJ9FzT5S7WatglbB1ZtT9qTQ
         aOUg==
X-Gm-Message-State: APjAAAUHu6sszjTHhLjWyPwID+niLGYQyOClTIiiG0/FXJ6fbNoSR0Jo
        vZWcV5UbNcjgyzYDbLh1ojA=
X-Google-Smtp-Source: APXvYqx6kLxqkMWnipKkW0GddcONQiTTCIzAsKoJ2z3EIa5UAeOpFQFwcxdV7cQZifDzzAS1TSe4NA==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr8155521wrv.237.1566463322288;
        Thu, 22 Aug 2019 01:42:02 -0700 (PDT)
Received: from szeder.dev (x4d0c08c4.dyn.telefonica.de. [77.12.8.196])
        by smtp.gmail.com with ESMTPSA id g65sm8443777wma.21.2019.08.22.01.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:42:01 -0700 (PDT)
Date:   Thu, 22 Aug 2019 10:41:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
Message-ID: <20190822084158.GC20404@szeder.dev>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821173515.GY20404@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 07:35:15PM +0200, SZEDER Gábor wrote:
> So line-level log clearly computes a lot less diffs than
> '--full-history', though still about 50% more than a regular
> pathspec-limited history traversal.  Looking at the commit-parent
> pairs in the output, it appears that the difference comes mostly from
> merge commits, because line-level log compares a merge commit with all
> of its parents.

> It seems there is still more room for improvements by avoiding
> commit-non_first_parent diffs when the first parent is TREESAME, and
> doing so could hopefully avoid triggering rename detection in those
> subtree merges or in case of your evil path.

Well, that fruit hung much lower than I though, just look at the size
of the WIP patch below.  I just hope that there are no unexpected
surprises, but FWIW it produces the exact same output for all files up
to 't/t5515' in v2.23.0 as the previous patch.

Can't wait to see how it fares with that evil Windows path :)

  --- >8 ---

Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME merge parent

  # git.git, ~25% of all commits are merges
  $ time git --no-pager log -L:read_alternate_refs:sha1-file.c v2.23.0

  Before:

    real    0m2.516s
    user    0m2.456s
    sys     0m0.060s

  After:

    real    0m1.132s
    user    0m1.096s
    sys     0m0.036s

  # linux.git, ~7% of all commits are merges
  $ time ~/src/git/git --no-pager log \
    -L:build_restore_work_registers:arch/mips/mm/tlbex.c v5.2

  Before:

    real    0m2.599s
    user    0m2.466s
    sys     0m0.157s

  After:

    real    0m1.976s
    user    0m1.856s
    sys     0m0.121s

[TODO: get rid of unnecessary arrays, tests?, write commit message...]
---
 line-log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 9010e00950..a4b032f83a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1184,13 +1184,11 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 
 	p = commit->parents;
 	for (i = 0; i < nparents; i++) {
+		int changed;
 		parents[i] = p->item;
 		p = p->next;
 		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
-	}
 
-	for (i = 0; i < nparents; i++) {
-		int changed;
 		cand[i] = NULL;
 		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
 		if (!changed) {
@@ -1203,7 +1201,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			commit_list_append(parents[i], &commit->parents);
 			free(parents);
 			free(cand);
-			free_diffqueues(nparents, diffqueues);
+			free_diffqueues(i, diffqueues);
 			/* NEEDSWORK leaking like a sieve */
 			return 0;
 		}
-- 
2.23.0.352.gebb2b55eae

