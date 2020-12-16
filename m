Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E8C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E90233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLPOup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgLPOup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:50:45 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98BC0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:04 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d14so22012105qkc.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+h+gZ89gRuyIwq3cUyCxuFl7Ngkdu0Q90t8wG32CTvw=;
        b=pzjFX7XEtAV2i/2uRLh/5yJp1hZIIIOi4Ac4JbmHQdwYCobvoj3epScU6tUiHkD1wL
         ZNJN/STifjalucJg2sU6dj4HKXtZ5h0BnabVhTTCixuGu06SVap7ZZo6Hl7PEpa4XwKi
         mz9lnWVpYpYqxXZQXjlnFh5YN803BxJqFa1Knv8MnNOvF81Blf8lSSQBQMLG7b+kdoQg
         uxWezsM21VP4JgOjpOwh3GVxM0OzV8pGMIO552S/000X8+UnIFj6abwokQz9OQlyIfO5
         f9FJn/hT3piwLaaiRKU/OOfzLwLB/367TB+kq6B6Tne0uNgpbQXyL/rMahXO4mBrIamS
         1pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+h+gZ89gRuyIwq3cUyCxuFl7Ngkdu0Q90t8wG32CTvw=;
        b=OwH1oBdVfAVZQ1jdPs45tE7N4lbRq1LflOQwT6nhecameE+TfpQM3CyIcoLB91SVdC
         gkBseA/hGT1xFwoCw1Wep0u4m+U0FiqC3p1kHYJrWYJot5EYuTttU2fpZ085xpAjYMPb
         nG5WL+zGsjamXJ/lRI5WANRa8etF7AMH+k+xlY0w6CGJywE7vxptnj0hhGWm1Sm4LoXb
         S+7f4fSqiR+WTzAPNs9Cr2ZO1mEagvPjxJ+KQNhr4HHBI5+W7/qel8C8DvTKE1AbB7u3
         8LH56XtP8iPKUAPkcf5Kno9/T6RvaG0mT56KCJlQ+t2usss+jPMY2cTXtNGCepT2PsPI
         fiLA==
X-Gm-Message-State: AOAM5300UYzzIcbUyStx9OScheMXORE0MeClmalRQ9kL6MkLvrCJp9zI
        SOjtGYJ62sy0Ry1IPb55YUoQRUfc7YKZZQ==
X-Google-Smtp-Source: ABdhPJwzZ+9LTUK7WzktIQSzkHiEjtNnNl8AMb80unOYAPoYQqF/91I32ZU1s4xoiQLQkLnVQ+gc/A==
X-Received: by 2002:a37:45d4:: with SMTP id s203mr40317488qka.458.1608130202882;
        Wed, 16 Dec 2020 06:50:02 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id x25sm1167033qkx.88.2020.12.16.06.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:50:01 -0800 (PST)
Subject: Re: [PATCH] checkout: send commit provenance during prefetch
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20201215200207.1083655-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad2579d6-c00a-c0a8-ae9b-11b168be1940@gmail.com>
Date:   Wed, 16 Dec 2020 09:50:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201215200207.1083655-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2020 3:02 PM, Jonathan Tan wrote:
> In a partial clone, whenever Git needs a missing object, it will fetch
> it from the repo's promisor remote(s), sometimes as part of a bulk
> prefetch. Currently, if the server handling such fetches does not accept
> requests for objects unless the objects are reachable, it needs to
> compute reachability from all refs.
>
> This can be improved by sending the commit from which the prefetch
> request came - a server that understands this would then only need to
> check that this commit is reachable, and check that the object is
> reachable from that commit.

You're right that there are _two_ important checks here:

1. the commit is reachable.
2. the blob is reachable from that commit.

This does have the potential of greatly reducing the amount of
parsed trees. It would be nice to see how much of a gain that
really provides. I suspect that it only helps for commits that
are far from the ref tips, depending on your tree-walk algorithm.

This additional constraint of "the blob is reachable from the
provided commit" should not be considered a limitation to the
server, since a reachability bitmap from the tip commits might
be able to provide faster responses than walking trees from the
provided commit.

Perhaps it would be worth testing a different mechanism for
using your reachability bitmaps? I'm guessing that your algorithm
uses this pattern:

1. Construct a reachability bitmap containing all objects reachable
   from the allowed refs.
2. Check if the blobs have bits on in that bitmap.

Instead, you could do this slightly-more-complicated thing:

1. Walk commits from the tips until finding reachability bitmaps
   or commits inside those discovered bitmaps. (Take unions as
   you find new bitmaps. Stop walking when a commit is in the
   union.)

2. "approve" blobs that have bits on in those bitmaps.

3. While there are unapproved blobs, walk trees from the walked
   commits, adding found objects to the bitmap. Stop when all blobs
   are approved or when all objects are walked.

Basically, you could probably respond more quickly to some of these
requests without needing a provenance commit, especially in the
cases where the provenance commit would be more helpful (older commits,
by my guess).

Perhaps you've already tried these things and have discovered that
the provenance commit is faster more often. That would definitely be
a helpful justification of the feature.

> Therefore, teach the partial clone fetching mechanism to support a
> "provenance" argument, and plumb the commit provenance from checkout to
> the partial clone fetching mechanism.

In a full patch, it would be good to document that this could be sent
across the wire, even if Git's server implementation ignores it.
 
> In the future, other commands can be similarly upgraded. Other possible
> future improvements include better diagnostic messages when a prefetch
> fails.

So, this is only in the case of 'git checkout'. I know that the batch
request logic for partial clone is also called by things like "git diff"
or "git log --follow" when doing rename detection. Those might require
sending _multiple_ provenance commits, so be sure to make that be a
possible outcome of the option.

> @@ -56,11 +56,14 @@ test_expect_success 'verify that .promisor file contains refs fetched' '
>  
>  # checkout master to force dynamic object fetch of blobs at HEAD.
>  test_expect_success 'verify checkout with dynamic object fetch' '
> +	rm -f trace &&
>  	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
>  	test_line_count = 4 observed &&
> -	git -C pc1 checkout master &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C pc1 checkout master &&
>  	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
> -	test_line_count = 0 observed
> +	test_line_count = 0 observed &&
> +	HEAD_HASH="$(git -C pc1 rev-parse HEAD)" &&
> +	grep "server-option=provenance=$HEAD_HASH" trace
>  '

This is about as good as we can do for testing the option here. I'm
assuming we have some tests already that check the Git server is
still providing good answers over HTTP (and ignoring this option).

tl;dr: I'm not against this idea. Just hopefully the server-side options
have been fully explored to justify the feature is worth it.

Thanks,
-Stolee
