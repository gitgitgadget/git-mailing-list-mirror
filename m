Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DCC3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6FD20787
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVFd6X6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406339AbgDOTHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416833AbgDOSho (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 14:37:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDAC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:37:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i27so882165ota.7
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pNy1lelUFSPsiosuwfDq0KdyBkczri27tmLkpqAeB5M=;
        b=OVFd6X6o6oGQwmr43T4l6nK+v0jEZch1AiuTZKhV8IF9m8xMY3TgtN3TsBdDa5FND2
         TFyk04cnx1+BDT8/6nB+Qlaf3ygVRxMq+xmnqCXvoPjnR/W1N1bbuqS+vHx99K5jVmhA
         VCkkLId8mQWw4XI2w28teRXTaduO1LjWgAO9AGQhoAh7jcDk7avETOUgfetF+XYEYnw0
         5HaZsBptCTUTsthAw38Be8Iu8iubr7eqcSgIqCg5zYr6Kypxljsb0Zo4Dub4uLVtgQGp
         IlfabYceuZIKwpm60qA5tbRgu9sq5ixwaODAR/tLIH1TyJTi7j1sOjxe7YvD0hzc2TW7
         jMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNy1lelUFSPsiosuwfDq0KdyBkczri27tmLkpqAeB5M=;
        b=fByQgAeEDKAORsbMg2h2pj1UbZ4d6NLDd1R5C+6h0VQVqg0aL3o2oonmyf2KOjOuUy
         T1UvlwF+2vXLb/B6PMw38Oo+78NF6Ybj+lPe3mAZjdm83WFQhqpnUM9YVvbUp0lfh7YD
         dloO60X7HPAi/A2yf7mfiu8UwurlMUHwstsGoECvoen70H4TEq6uB9wJJZ28umww2UZt
         wEIKmM3bNkwFW/P/HHUQT4Rtt++GiMgTel/MhnwzMUhrCUGshwCRJsvZ3MmI6WLXErfw
         PIotiAJvp2CKnJj4Sy5klc8eR7rverHP9rFYkEMw1NT2+dgRNFdVyj4DXDPLXsSPK8GQ
         lpnQ==
X-Gm-Message-State: AGi0Pua40oauN42CONh340zGNLQLuAGJ42ZE3NNA+tq15WBOHrqWm5Gm
        54DmKxPeGEHRP13rTzhiwEA=
X-Google-Smtp-Source: APiQypLM2oeXj1ToUX6xwjEqxJxbaU7OFsbpvUfyqw6lylL5MAr5fRJwopBJd6xYGJJD/GFDEI80rg==
X-Received: by 2002:a05:6830:1d51:: with SMTP id p17mr23003046oth.211.1586975863363;
        Wed, 15 Apr 2020 11:37:43 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 33sm6468644otn.50.2020.04.15.11.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 11:37:42 -0700 (PDT)
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
 <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
Message-ID: <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
Date:   Wed, 15 Apr 2020 14:37:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2020 9:27 AM, Derrick Stolee wrote:
>
> I'm not against the idea. Logically, collapsing case before hashing
> the Bloom keys should not increase the probabilities of false
> positives except in the situations where we have case conflicts.
> There is a small cost in the pre-hashing step to change the case of
> the paths, but that should be much lower than the cost of the hash
> itself and the tree parsing to find the changed paths.
> 
>> It all depends on how often people want :(icase) pathspec matches in
>> the history, I suspect.  My point was that we need to declare that
>> :(icase) won't matter in real life (hence we won't optimize our data
>> to support that use case), before the way in which the data stored
>> in the graph file is computed is cast in stone.
> 
> My earlier statement can be summarized as "we could make this happen"
> and you ask here "is it worth doing?"
> 
> I will play around with how complicated the change would be while
> the community considers the "is it worth doing?" question.

I played a bit, and it wasn't terrible to cover everything by
adjusting fill_bloom_key(). I also added a test that we will want
anyways.

There is more work to be done if this is the direction we want to
go, including double-checking that this doesn't cause significant
performance degradation.

The point of me sending this patch is to make the proposed
direction very clear how it would work. I'm still not sure how I
feel about it.

Thanks,
-Stolee

-->8--
From 89beb9598daabb19e3c896bbceeb0fc1b9ccc6ca Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Wed, 15 Apr 2020 18:04:25 +0000
Subject: [PATCH] bloom: compute all Bloom hashes from lowercase

The changed-path Bloom filters currently hash path strings using
the exact string for the path. This makes it difficult* to use the
filters when restricting to case-insensitive pathspecs.

* I say "difficult" because it is possible to generate all 2^n
  options for the case of a path and test them all, but this is
  a bad idea and should not be done. "Impossible" is an appropriate
  alternative.

THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
Bloom filters computed by a previous commit will not be compatible
with the filters computed in this commit, nor will we get correct
results when testing across these incompatible versions. Normally,
this would be a completely unacceptable change, but the filters
have not been released and hence are still possible to update
before release.

TODO: If we decide to move in this direction, then the following
steps should be done (and some of them should be done anyway):

* We need to document the Bloom filter format to specify exactly
  how we compute the filter data. The details should be careful
  enough that someone can reproduce the exact file format without
  looking at the C code.

* That document would include the tolower() transformation that is
  being done here.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c                   | 16 ++++++++++++++--
 revision.c                |  5 +++--
 t/t6131-pathspec-icase.sh | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/bloom.c b/bloom.c
index dd9bab9bbd..c919c60f12 100644
--- a/bloom.c
+++ b/bloom.c
@@ -130,8 +130,20 @@ void fill_bloom_key(const char *data,
 	int i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
-	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
-	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
+	uint32_t hash0, hash1;
+	static struct strbuf icase_data = STRBUF_INIT;
+	char *cur;
+
+	strbuf_setlen(&icase_data, 0);
+	strbuf_addstr(&icase_data, data);
+
+	for (cur = icase_data.buf; cur && *cur; cur++) {
+		if (isupper(*cur))
+			*cur = tolower(*cur);
+	}
+
+	hash0 = murmur3_seeded(seed0, icase_data.buf, len);
+	hash1 = murmur3_seeded(seed1, icase_data.buf, len);
 
 	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
 	for (i = 0; i < settings->num_hashes; i++)
diff --git a/revision.c b/revision.c
index f78c636e4d..a02be25feb 100644
--- a/revision.c
+++ b/revision.c
@@ -652,13 +652,14 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 static int forbid_bloom_filters(struct pathspec *spec)
 {
+	int allowed_flags = PATHSPEC_LITERAL | PATHSPEC_ICASE;
 	if (spec->has_wildcard)
 		return 1;
 	if (spec->nr > 1)
 		return 1;
-	if (spec->magic & ~PATHSPEC_LITERAL)
+	if (spec->magic & ~allowed_flags)
 		return 1;
-	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
+	if (spec->nr && (spec->items[0].magic & ~allowed_flags))
 		return 1;
 
 	return 0;
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 39fc3f6769..ee0766bd91 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -106,4 +106,22 @@ test_expect_success '"git diff" can take magic :(icase) pathspec' '
 	test_cmp expect actual
 '
 
+test_expect_success '"git log" takes the magic :(icase) pathspec' '
+	cat >expect <<-\EOF &&
+	FOO/BAR
+	FOO/bAr
+	FOO/bar
+	fOo/BAR
+	fOo/bAr
+	fOo/bar
+	foo/BAR
+	foo/bAr
+	foo/bar
+	EOF
+	git log --pretty=%s HEAD -- ":(icase)foo/bar" >actual &&
+	test_cmp expect actual &&
+	git log --pretty=%s HEAD -- ":(icase)foo" >actual &&
+	test_cmp expect actual
+'
+
 test_done


