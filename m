Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF5C43219
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiCIT3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiCIT24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:28:56 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093339BAD
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:27:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso4119470ooe.6
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kP+UFq4wN0K8yektdSFJuxW+CaspIf0IbUarvmy7/bA=;
        b=NAIw+uUswmrzieJfFXB6fCrmrbgqnS29wI0IGKpb8znnJ124xr8JiiddkyWC9MJloC
         OIrCqOgDWvL40JtNERdOfOhhbj4fZdb2L2/MXR02hBemNQOpJFbo9UuFSzhK9qxZi44y
         +llDa1odCKfTPc0uZWRSHVjgcMN6gnq7Mb4g7bUqsQX0//BFHTFbyJ8IuqggDAGf+Yqn
         nax3DRZiWlIIohVuwCGjDqrAy26R5qrzUFsfWN5Hr6BfqXyK/KlPuDkXMXQH/cDHsHK/
         WzXKhf1mMHOXJM0vAX66oLY0NHT9bIqmIsyu+jpUhuXIvVqESoLZBzvrYO8GOyZJNexs
         ekBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kP+UFq4wN0K8yektdSFJuxW+CaspIf0IbUarvmy7/bA=;
        b=cJONBySm9rrpY8cUUG5QqHbg4gem38wYq3tXkHmEO0SKmGFD1hXEpsmCqUAOo3n2kC
         Ov+0s9t9UMCH+oWjuYoZ3g9YVwSrl7PbLuCBALfNFIzi//jeBOOm3TBOtm90OwElTUMN
         ffo6l1LHKoNzrXWmaqMJKjZiRU3YsR9S2i9nSrudduYm3G4SyEOiHBYWNuuw2Di3hpSZ
         1F+3t5TES1icagD2ix+jYvwvwtGxtI1wHIVmazawjzPsO78Wr/qnHMI2GGExiwGayOwk
         0e76g7kbMu2NbfigmEdWOxw0FfTlN68BuzqLOBdsrgRI3WD6iNr0NaX3hHewQN6rNHH6
         GRdw==
X-Gm-Message-State: AOAM533pytxvqWunE37/7SiPFMgkrXnikO1friVIKXwk5JvGhHfiQqKi
        Mh0APt5UkYypwe7lWnLLuM+f
X-Google-Smtp-Source: ABdhPJwflhrDtXGskalgzyquISn1qXHGS3Oos0P3vktioCYNFTqXhO4N31cCGN7JzNh9Br/BCk3F4A==
X-Received: by 2002:a05:6870:64a8:b0:d9:aa23:8ef8 with SMTP id cz40-20020a05687064a800b000d9aa238ef8mr6177628oab.49.1646854076514;
        Wed, 09 Mar 2022 11:27:56 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z192-20020a4a49c9000000b003213bf4bf0csm1394481ooa.31.2022.03.09.11.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:27:56 -0800 (PST)
Message-ID: <ea05408a-bf77-e03d-c367-54d4c6c3c3c6@github.com>
Date:   Wed, 9 Mar 2022 14:27:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 24/24] revisions API: have release_revisions() release
 "topo_walk_info"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-24.24-e02a097b884-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-24.24-e02a097b884-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> Refactor the existing reset_topo_walk() into a thin wrapper for a
> release_revisions_topo_walk_info() + resetting the member to "NULL",
> and call release_revisions_topo_walk_info() from release_revisions().
> 
> This fixes memory leaks that have been with us ever since
> "topo_walk_info" was added to revision.[ch] in
> f0d9cc4196a (revision.c: begin refactoring --topo-order logic,
> 2018-11-01).

Excellent.

> +static void reset_topo_walk(struct rev_info *revs)
> +{
> +	struct topo_walk_info *info = revs->topo_walk_info;

Why add this variable?
  
> -	FREE_AND_NULL(revs->topo_walk_info);
> +	release_revisions_topo_walk_info(info);

For only this use?

	release_revisions_topo_walk_info(revs->topo_walk_info);

seems to work just fine. Is the line too long?

Thanks,
-Stolee
