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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4931F461
	for <e@80x24.org>; Fri, 23 Aug 2019 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbfHWKEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 06:04:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37061 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbfHWKEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 06:04:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so8097955wrt.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=44TIIMI1nU2wJhRI3C5EVHhg47bxuXbr5VaOLyUPsag=;
        b=r26tJnuSCXlxwDam4bWanGHe0W3GLI0rKsrAFu9ifu/eguyZEvEuRvuSrmfB6pljUt
         pf4HXi2ezPp7hebPu4tbE9ey672KOiYVHi5mJc++5kJVS7WL9BfSk1Wp77hWWtdiKD2S
         60AXtcSvlUMyJYOusrQ2siIA5BEH0M4GUWkYqqDKXksPblZN5vVtAEVepMhcyDZyU/oi
         W3q3HyJ6pibLQeA5K1HQsS4fCYaXMI2xqTTS3iesnkRY0BIbQl31GFxdgU0rEUSzAWyZ
         fkZygBMIHvlFPD/suyLR6kDGABnOQcYIearVcGkybkNVLWk9aDzBoumnBlYyDn+SuSe9
         nYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=44TIIMI1nU2wJhRI3C5EVHhg47bxuXbr5VaOLyUPsag=;
        b=T6+sTc8kE+8tyLh3WJrF7UgZXX55QNCyzU4yfMcen0+cZgVZhuqwPL1Y55ws8qCliE
         8K8hQI+D5YfWXz3xv2vvdwpnG8HPRTk7dZRY0ZNdAJgdzl1x47YnKCo412ou/vjDhq0Q
         wyfKiHjgQYjLsF2IDSEQ9N/7yOS37vaiJF86z1kfliMSmJdAHA3nerXQvx1EHo4FfPsY
         lzhB+e5GSJ/iAXgzfQf6g+/oVglrlgN10/lezPJ+pjd96u3WmJaoi7Un39TEqc2pMaLE
         pAmRuPvXZ8tewZM1REqYbh4HZOilllTBtraR7fwoa50EwtutvMLr314sWJ8D6eXMKwIr
         11vg==
X-Gm-Message-State: APjAAAUl4hM3nj96s43JPVTSrz/R2EPJhdCSY8VcSMLgesInthAehxnS
        ZgyBVSSbjWb+iraY0Zh2hXmtpV1x
X-Google-Smtp-Source: APXvYqzz1OONBpfolD8v+s8QbMGmG65HYcUAd0F2ImNVgxaOrblHc4ZRas2q7ediUAdhQAf+mCEmNg==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr3934926wrv.73.1566554689172;
        Fri, 23 Aug 2019 03:04:49 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id r16sm3094698wrc.81.2019.08.23.03.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 03:04:48 -0700 (PDT)
Date:   Fri, 23 Aug 2019 12:04:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
Message-ID: <20190823100446.GI20404@szeder.dev>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev>
 <20190822084158.GC20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822084158.GC20404@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 10:41:58AM +0200, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 07:35:15PM +0200, SZEDER Gábor wrote:
> Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME merge parent

>   # linux.git, ~7% of all commits are merges
>   $ time ~/src/git/git --no-pager log \
>     -L:build_restore_work_registers:arch/mips/mm/tlbex.c v5.2
> 
>   Before:
> 
>     real    0m2.599s
>     user    0m2.466s
>     sys     0m0.157s
> 
>   After:
> 
>     real    0m1.976s
>     user    0m1.856s
>     sys     0m0.121s

So, to recap, the above command follows the given line range through
the whole history, and the timings were done with these three patches
on top of v2.23.0 and with a commit-graph file present and used.

When merged with my more responsive line-level log series, the same
command takes about 12% longer:

  real    0m2.216s
  user    0m2.108s
  sys     0m0.109s

Looking at the flame graphs generated from the perf profiles I notice
the following:

  - (line_log_)process_ranges_arbitrary_commit(), i.e. the function
    responsible for processing all commits for the line-level log,
    shows up in 2408 samples before the merge and in 2387 samples
    after the merge.  I'm inclined to write it off as noise.

  - Before the merge limit_list() and sort_in_topological_order(), the
    two functions responsible for topo-ordering without generation
    numbers, show up in 2484 and 707 samples, respectively, which is
    3191 samples combined.

  - After the merge expand_topo_walk() alone shows up in 4341 samples,
    with next_topo_commit() in 72 samples.
    
So it appears that the generation numbers-based topo-ordering is
almost 40% slower than "traditional" topo-ordering.  It came as a
surprise to me, but perhaps to you it's expected?

Anyway, the time to show the first commit is still much better with
generarion numbers, so overall I think it more than offsets this ~10%
difference.

