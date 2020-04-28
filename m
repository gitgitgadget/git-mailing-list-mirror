Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21199C83009
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01396206E2
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkUMbu+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgD1OL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgD1OL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 10:11:26 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6EC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:11:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q2so10419910qvd.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1vEbsEslc1SrM/35mpFdBe0YscR2i9ShumuPGCsYiZU=;
        b=hkUMbu+XxqnBYnKkU7uDyQjxAxC26Nztpp9KRw51T+ZX1P6rJ0dim559b5KKB4dqA3
         ro31QmbuEBNJPsjLxAHbIR98f20kZDH4T26tP/uOIVGYocr/eP8eaH8dugNLuOe4tYQS
         2b3QDToFc2xcSsroyAvn07tddqqfcFQojnd/h16sjZ6TKJ8SG09I3kChkGdPbeG61KH1
         UOPObp+PgpCUujF3DGqSJSwrqrNXkgLJy+E9ZNmXJPZFT8n7lGffsxwlJI1GxtUSSKFc
         Ug0pFbP9ApNQpqCU6Iz41Px/MIkaPli3pWdP8OU4DwgQ+4ofPRYf8GdI48Aiw3e2Sstn
         5Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1vEbsEslc1SrM/35mpFdBe0YscR2i9ShumuPGCsYiZU=;
        b=nHQHgPTEUtEvI+OpEzSnN6bmkV4BxqrcyBSEsu9K54f2bABe+Nm5Y6kjvrTUnp6aGw
         jvntsvvOEKwA+VVBvAAmT0xeUY2cFINIr6dnFu2wf7uQgcVQ97kjPsVuhGVh5ahh83Vb
         jkyqhEIqHHTr/U0jLRW5R8Gb8slkae+TawK0OWUrODoR6Xw6aZdMBG+qcoL9Y6dmMInA
         zaFAnQ+SRgprPy4R2tdU94N5Rts0eFzmLGY8PwaYwzZW0HPRmpV6wjpyJ+uePIej9udo
         wgavJjXqLxvrLsIniTS2WoRtMROiZUjU0fhDJQ1rFqFBwSXxyl7Mf9ocQxKHo/yR0GMG
         ehmg==
X-Gm-Message-State: AGi0Pub2AQ6fcS4RqYhNq10utjqWyggHSikmxzlCP2wJTNIkd27/6d4k
        /r0hW+U2nif4li/FMg1pRu8MmzZZQx0=
X-Google-Smtp-Source: APiQypLepVdS+TA8D/97G9FtyyRbWJs7x01U6EijxN/ZooxihuGlMIurt4GLZOlYvEbiLLJAd+dVzw==
X-Received: by 2002:a0c:e9cc:: with SMTP id q12mr28585533qvo.128.1588083084508;
        Tue, 28 Apr 2020 07:11:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j16sm7721095qkl.118.2020.04.28.07.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:11:23 -0700 (PDT)
Subject: Re: [PATCH] Teach git-rev-list --simplify-forks
To:     Antonio Russo <antonio.e.russo@gmail.com>,
        git-ml <git@vger.kernel.org>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <4ee983f6-402f-85bb-25a8-75b39f07cabb@gmail.com>
 <070c07f6-5b36-89e7-a9fe-9bd321fcb97e@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <155e3be2-1852-3590-2cd9-c868fa5a696a@gmail.com>
Date:   Tue, 28 Apr 2020 10:11:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <070c07f6-5b36-89e7-a9fe-9bd321fcb97e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/28/2020 8:49 AM, Antonio Russo wrote:
> On 4/27/20 4:55 AM, Derrick Stolee wrote:
>>
>> This is probably because the tests run a second round with GIT_TEST_COMMIT_GRAPH=1, which enables the commit-graph feature. This triggers a different set of logic for the topo-order, which ignores the logic the way you inserted it here.
>>
> 
> Thank you for pointing me at this.  If I now understand correctly, the commit information
> is not yet necessarily loaded for all commits at this point, and therefore the logic here
> will need to be called later on (and makes it more complicated).
> 
> Am I correct that this loading of parents happens during traverse_commit_list_filtered
> (for the case of rev-list)?  Also, am I correct that there are not yet any hooks to
> filter out edges (of the graph of commits)?

I mean that if you have a commit-graph, then a completely disjoint set of code
is run instead of the code you modified. See [1] for the blocks of code that
are run instead.

[1] https://github.com/git/git/commit/b45424181e9e8b2284a48c6db7b8db635bbfccc8

Thanks,
-Stolee
