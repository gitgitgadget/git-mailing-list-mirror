Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76375C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0896720936
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwHK3YV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgKLNw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgKLNw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 08:52:28 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F6C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:52:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j7so6396266oie.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3GEib27PSz6mgI3M5DZ6hmAvXUtwxZScYzoz+LwW5lw=;
        b=bwHK3YV2xiYtxgZnWggNY455CKo6Lw7aCIFjfUOduusODF97oEZu36P+jb85Chnehy
         puKNcRKR77pypR4+njZpPaxIb70949RwMOosCRc69OBpfVzmODkc9/ZAy2YQgXHvesLA
         8J9a/nM+ZwidnnyQygWXMi1YMDoFLdYJfakplWvduBniFKGhyjyPzpJ1X33Lxu0qVRuG
         VJFez8DgSrvsUDCwSeYtiMMQOa8VLsnJzLs7QoA81k7GVZNHmlVIim1E+pPmDCHkrYOf
         MDnlR0h680fq4YYrL4eDfhndV81IKENIFiJ6sufApe4ctQtMebujbg28OHjYKeVfyWRv
         Sygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GEib27PSz6mgI3M5DZ6hmAvXUtwxZScYzoz+LwW5lw=;
        b=gqPPVrJfXwfg9kDhAgambhpv3dzXEinoi6nzyekZ+H4csLPVWp9VeXwyf/Ytn3TYe0
         2fmBHxCyM4Y3MmPpSMa2lJcSGHp2uXjwAn3RqAM1rEOVYPcmdAPGo3Q6V3OtjlMtTMx5
         f47/0QDNuG8OX9fdJTN/BfIh3U1lG0bpabjgwQtVhgPTDtd6lduxJG1DsWz9cNB+q8E9
         CPR78ZMRtE7fKnPM04z3nn9KWp0jPyoCYkzDscj/uwF7hAPMVX5qeLOwHWiSeTc7u/DH
         nX2bEWt0ybplg6u6SSxgg6OG6ONjVCwJWbtQ2J9obM2mMTIYP91coh/XqJdnM77vZSgD
         /jDA==
X-Gm-Message-State: AOAM530fF3LsiHQj928gImYxvPi4kNVUEMW6VnH6opbJR3gv9zQERqW8
        VytGJhBuN77k7TvYXGOcM8APD0aVNuH2Rg==
X-Google-Smtp-Source: ABdhPJwegGBc25mnYUeOqfTUeVv26pLLe/iNU4yeHBDND6ZizUZVD7/vVOnO/03U5UTNZ0rhWWbsng==
X-Received: by 2002:aca:ec97:: with SMTP id k145mr5559471oih.163.1605189147282;
        Thu, 12 Nov 2020 05:52:27 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id t199sm1130770oif.25.2020.11.12.05.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:52:26 -0800 (PST)
Subject: Re: [PATCH 1/3] csum-file: add hashwrite_be64()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcebe67f-f1d7-0069-01de-12844508cae1@gmail.com>
Date:   Thu, 12 Nov 2020 08:52:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2020 7:20 AM, René Scharfe wrote:
> Add a helper function for hashing and writing 64-bit integers in network
> byte order.  It returns the number of written bytes.  This simplifies
> callers that keep track of the file offset, even though this number is a
> constant.
> 
> Suggested-by: Derrick Stolee <dstolee@microsoft.com>
> Original-patch-by: Taylor Blau <me@ttaylorr.com>

These patches are absolutely correct, and I'm glad to see them show up
in a very clear presentation. I had to go look to see why these were
not already present, with [1] being the last instance of these showing
up on-list. They did not get into the new version after a significant
refactor [2].

Thanks,
-Stolee

[1] https://lore.kernel.org/git/20200904202226.GA21837@nand.local/
[2] https://lore.kernel.org/git/cover.1599664389.git.me@ttaylorr.com/
