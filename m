Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280BCC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EF6611C0
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhGMNAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhGMNAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 09:00:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC2C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 05:57:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x24so16474828qts.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnxiRrjCLHGoTeLgD/AArn50squSwxdFNa24p7eQM64=;
        b=hU+s9in0MmMOdocYu/9m6U5fWyo85mPeLvs9hm3F13l++2lTSwqIRdf3U3be3WFO3d
         M+cQpkMkEceIR95Q7ReQzuiB9hpdGMxrYcVSNdpCI2nItRZ1SHGCcGQHpnEWCXrGXRtc
         FtOh7wSq8FmBx8WiFXEbFo7QjAnfa+GHTXOYj+BZtu9tvvtxWc8lYqFlEnWZ9h2XQtof
         F1OZgkhMoGrcCT4OambhHA9fQizg5OsKNOovwZUeNZmolLJkL1jQMOXVW9AVyX08HPa0
         CpfXGJwe99/fyNuSsChFUz4giXOgkC+LvLU+7sPNbOMRKDo/zq9cKonyog8oGTWZ/AIq
         7skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnxiRrjCLHGoTeLgD/AArn50squSwxdFNa24p7eQM64=;
        b=NCA/Ck7PGGLl4Y7zWX+pZjKFdxyuFLl3ho1GbBk2Un7jl6tlxXv1rfv2nhrHjlmWxr
         LNL9jB6/PHsnZ2K0mcumoJXLGhYB5FHyLvyVLGanCxtiY3/B7+2x8Gzky5pN1JSYzbee
         2PyvE6lK9g1fTywzU8nutWBGal2PJVGxX0I2tkBWmnb/jQNIdyW2kSyyA46dftV6YJIV
         DiEI6S1+T1iQbLwUqQZvmzqk6B5VD36YWZIwPg6CgkR17UW4gjtiuVOKuI/TaIpi3TLC
         6Q9J1qClpDUVIg8NfAC0rQdsCC7ZcGqUU9fxRPSYQnBq2oHkifcUQnpzdjr4YT8hftF7
         fJfg==
X-Gm-Message-State: AOAM532r7/IZsZHt0zdOz9171DjNMS+GGPjgEw1euF5ftZL5Gfq+tiiI
        4JUWuTPLGYw8S4JDtAj+t1Q=
X-Google-Smtp-Source: ABdhPJxeSxTWsQX2x5lmxI0x2nMlTXj1pvbEO1DRot3cWpSm83vLeWYbpmD7ZaR9IpfbkfFbc+wB+g==
X-Received: by 2002:a05:622a:34a:: with SMTP id r10mr3980869qtw.94.1626181067013;
        Tue, 13 Jul 2021 05:57:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8192:e3b9:51d:c6df? ([2600:1700:e72:80a0:8192:e3b9:51d:c6df])
        by smtp.gmail.com with ESMTPSA id g76sm7962491qke.127.2021.07.13.05.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 05:57:46 -0700 (PDT)
Subject: Re: [PATCH v8 00/15] Sparse-index: integrate with status
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
 <CABPp-BGZ0VNkAcScXLKAX0M3FwmXuZ5ei0o7Nu31L=rpSt6iQA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7199fc6-bc7b-f556-c10c-12dee04af287@gmail.com>
Date:   Tue, 13 Jul 2021 08:57:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGZ0VNkAcScXLKAX0M3FwmXuZ5ei0o7Nu31L=rpSt6iQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2021 3:38 PM, Elijah Newren wrote:
> On Mon, Jul 12, 2021 at 10:55 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>   9:  237ccf4e43d !  9:  c0b0b58584c unpack-trees: unpack sparse directory entries
>>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
>>       +  * Check for a sparse-directory entry named "path/".
>>       +  * Due to the input p->path not having a trailing
>>       +  * slash, the negative 'pos' value overshoots the
>>      -+  * expected position by at least one, hence "-2" here.
>>      ++  * expected position, hence "-2" instead of "-1".
>>       +  */
>>       + pos = -pos - 2;
>>       +
>>      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
>>                 return NULL;
>>       +
>>       + /*
>>      -+  * We might have multiple entries between 'pos' and
>>      -+  * the actual sparse-directory entry, so start walking
>>      -+  * back until finding it or passing where it would be.
>>      ++  * Due to lexicographic sorting and sparse directory
>>      ++  * entried ending with a trailing slash, our path as a
> 
> s/entried/entries/ ?

Oops! Yes, that would be a valuable fixup. Thanks for catching it.

> 
>>      ++  * sparse directory (e.g "subdir/") and our path as a
>>      ++  * file (e.g. "subdir") might be separated by other
>>      ++  * paths (e.g. "subdir-").
>>       +  */
>>       + while (pos >= 0) {
>>       +         ce = o->src_index->cache[pos];
> ...
>>  15:  717a3f49f97 = 14:  dada1b91bdc wt-status: expand added sparse directory entries
> 
> As I commented over at [1], I would appreciate if we could at least
> add a comment in the testcase that we know this testcase triggers a
> bug for both sparse-index and sparse-checkout...and that fixing it
> might affect the other comments and commands within that testcase in
> the future...but for now, we're just testing as best we can that the
> two give the same behavior.
> 
> [1] https://lore.kernel.org/git/CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com/

How do you feel about a new patch that focuses on adding these
comments, including an older test that had a similar documentation
of the behavior change? A patch that could be queued on top of
this series is pasted below the cutline.

Thanks,
-Stolee


-- >8 --

From 8e69def90f5844c117cc1e9efd673c92b85c9238 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 13 Jul 2021 08:50:24 -0400
Subject: [PATCH 16/15] t1092: document bad sparse-checkout behavior

There are several situations where a repository with sparse-checkout
enabled will act differently than a normal repository, and in ways that
are not intentional. The test t1092-sparse-checkout-compatibility.sh
documents some of these deviations, but a casual reader might think
these are intentional behavior changes.

Add comments on these tests that make it clear that these behaviors
should be updated. Using 'NEEDSWORK' helps contributors find that these
are potential areas for improvement.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2394c36d881..cabbd42e339 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -392,8 +392,8 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# TODO: reset currently does not behave as expected when in a
-# sparse-checkout.
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_failure 'checkout and reset (mixed)' '
 	init_repos &&
 
@@ -403,8 +403,8 @@ test_expect_failure 'checkout and reset (mixed)' '
 	test_all_match git reset update-folder2
 '
 
-# Ensure that sparse-index behaves identically to
-# sparse-checkout with a full index.
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_success 'checkout and reset (mixed) [sparse]' '
 	init_repos &&
 
@@ -524,6 +524,8 @@ test_expect_success 'sparse-index is not expanded' '
 	test_region ! index ensure_full_index trace2.txt
 '
 
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
 	init_repos &&
 
-- 
2.32.0.15.g108d1b86e21



