Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA009C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9364F61357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhHXWtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:49:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55491 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhHXWtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:49:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D72741525D2;
        Tue, 24 Aug 2021 18:48:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QboxzvNvD5ZZR5qkcbeq2opGLkB4x4s140BPLnC8vQA=; b=YMZE
        aL/NyMCT1GfwuI2Ik6X+zcPgkjVDSgvqZv7tdVO1w+5hPjPegjAP863G90EyNjNm
        LEy8i6iKTjHKVnPvQrmM6cAc6xeIi3dyNOJqdknsu3njl7qDXD9y52w/kxnv6YUc
        Cj74R712Pz2MJKaa4mfLis6grnlUbyPvywqw4IQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF5661525D0;
        Tue, 24 Aug 2021 18:48:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E85F91525CE;
        Tue, 24 Aug 2021 18:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/7] Speed up mirror-fetches with many refs
References: <cover.1629452412.git.ps@pks.im> <cover.1629800774.git.ps@pks.im>
Date:   Tue, 24 Aug 2021 15:48:19 -0700
Message-ID: <xmqqfsuylarw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6188BAAE-052D-11EC-9589-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series to speed up mirror-fetches
> with many refs. This topic applies on top of Junio's 9d5700f60b (Merge
> branch 'ps/connectivity-optim' into jch, 2021-08-23).

It is a horrible commit to base anything on.  You are taking your
patches hostage to all of these other topics.

    9d5700f60b Merge branch 'ps/connectivity-optim' into jch
    7ad315de2f Merge branch 'js/log-protocol-version' into jch
    1726f748f5 Merge branch 'en/ort-becomes-the-default' into jch
    23aeecb099 Merge branch 'en/merge-strategy-docs' into jch
    568277d458 Merge branch 'en/pull-conflicting-options' into jch
    2b316bb006 ### match next
    4efa9ea0b6 Merge branch 'ps/fetch-pack-load-refs-optim' into jch
    b305842ee8 Merge branch 'jt/push-negotiation-fixes' into jch
    83b45616f1 Merge branch 'es/trace2-log-parent-process-name' into jch
    be89aa8c38 Merge branch 'hn/refs-test-cleanup' into jch
    256d56ed32 Merge branch 'en/ort-perf-batch-15' into jch
    7477fbf53a Merge branch 'js/expand-runtime-prefix' into jch
    b1453dfd30 Merge branch 'ab/bundle-doc' into jch
    1b66e8e89d Merge branch 'zh/ref-filter-raw-data' into jch
    1fbf27ddcd Merge branch 'ab/pack-stdin-packs-fix' into jch
    dcf57bfebb Merge branch 'ab/http-drop-old-curl' into jch
    93041f7c57 Merge branch 'ds/add-with-sparse-index' into jch
    814a016195 Merge branch 'jc/bisect-sans-show-branch' into jch

A better way to handle a situation like this is to limit your
dependencies more explicitly.  If you look at what I did to the last
round of this topic, you'll see that there is a merge of the
'ps/connectivity-optim' topic into v2.33 followed by application of
the patches, like this:

    1d576ca7b2 fetch: avoid second connectivity check if we already have all objects
    6768595f10 fetch: refactor fetch refs to be more extendable
    a615d7cf87 fetch-pack: optimize loading of refs via commit graph
    bfd04fc24c connected: refactor iterator to return next object ID directly
    1a387c9f3a fetch: avoid unpacking headers in object existence check
    f1a4367ec4 fetch: speed up lookup of want refs via commit-graph
    3628199d4d Merge branch 'ps/connectivity-optim' into ps/fetch-optim

What I did to your last round was to merge 'ps/connectivity-optim'
on top of v2.33 and then queue them.  You can do the same for this
round (you can tell people "apply these on top of the result of
merging topic X, Y and Z on tag V").

    df52ef2c3a fetch: avoid second connectivity check if we already have all objects
    c1721680e4 fetch: merge fetching and consuming refs
    5470cbe1be fetch: refactor fetch refs to be more extendable
    016a510428 fetch-pack: optimize loading of refs via commit graph
    f6c7e63cc7 connected: refactor iterator to return next object ID directly
    17c8e90df3 fetch: avoid unpacking headers in object existence check
    a54c245004 fetch: speed up lookup of want refs via commit-graph
    3628199d4d Merge branch 'ps/connectivity-optim' into ps/fetch-optim

I had to adjust [4/7] while applying them on top of the same
3628199d4d I created for queuing the previous round, and it would be
appreciated if you can double-check the result.

Thanks.
