Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FBC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLNXuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLNXuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:50:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFD43854
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:50:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 79so3057889pgf.11
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ojgsOtoRkMmVbZHVK7nLyj5h6pKsvzZ6DXHI812MW10=;
        b=gWNMtDJpcunYQMUlDmqoNQn3B4wWEmiFx2SkiO84d339PGc/13h53zMa9KzQdRrTUE
         q9hObAWO1JYDHVeBUeRa+Z0BVKBX1D0mFtW9suuq4mNMCo1mJqehUShc4sQgO8vihiR1
         OaoJ6x3pAjvHSVzsQG6dAifLeKVuevZ6PPqYxIBjqR0UfGy6+JIuHGlR+73RrdcTioGX
         I/EPBKasW4NOf/3Y3466/3qV89OqXyxbtJHNFw0U0MHEJRC5VhcV1lD6xbjFKZvRD9Cx
         zS1jyxNVvjS/Wnwih/4qXoNGxlcnv0qV/CVpRC3YTFtfpYX4DutfOfMxNfA1duvFaxM0
         tkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojgsOtoRkMmVbZHVK7nLyj5h6pKsvzZ6DXHI812MW10=;
        b=Jwp8PmYWdsB2hDluLqwdKBsi2faPmDedKyh9bmT5g8vu0AdoxKLHvsNnm5T7ztj9c3
         tzPVQRU3CgqZDsjz0khB6LjV3fizOBEc8Z2lt8ms3PL/KqjUBAJ+jPMvzCUOM/oGjtLm
         Te6fgQtziws8QiY8xvcl4oZR+D11E3oJujg3CJQI7c7xWngWJ6QgLixrll7UiM5m2hJv
         0kyuV1z82z7BHcVlnXf93EovLOYXlLlmKqeseSYmvlfN6hRUU2p7P8zYRs8c9yKH5bdL
         XcB9fA92AzzBL+xUiVbl94qdNuyBSRszcWnmkGIxmL8TqlCUqHfcqm0WvA62Ns37lLjB
         GDmA==
X-Gm-Message-State: ANoB5pmTnSLclkr1jId1Ksy0AbIAv3EawljDfNh8z8mlJuCkKRy0LdB5
        Lhm+pnepesRsE4xiutTZnM1J/WBNWNMwSQ==
X-Google-Smtp-Source: AA0mqf4OnzizKfFuwTuTOiC1fGNOFeCkhDZG9mszFOslU+9abjzMSS4H4EYW7XgcVtBCfvV9LHbobA==
X-Received: by 2002:a62:18c4:0:b0:576:a455:6bde with SMTP id 187-20020a6218c4000000b00576a4556bdemr24562812pfy.15.1671061801618;
        Wed, 14 Dec 2022 15:50:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v5-20020a626105000000b0056bd1bf4243sm409352pfb.53.2022.12.14.15.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:50:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
        <b712fa19-96b8-80db-5aa7-f823bed687e4@github.com>
Date:   Thu, 15 Dec 2022 08:50:00 +0900
Message-ID: <xmqqa63pv93r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 12/14/2022 4:59 AM, Junio C Hamano wrote:
>
>> * ds/omit-trailing-hash-in-index (2022-12-13) 4 commits
>>  - features: feature.manyFiles implies fast index writes
>>  - test-lib-functions: add helper for trailing hash
>>  - read-cache: add index.skipHash config option
>>  - hashfile: allow skipping the hash function
>> 
>>  Introduce an optional configuration to allow the trailing hash that
>>  protects the index file from bit flipping.
>> 
>>  Will merge to 'next'.
>>  source: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
>
> There are some outstanding comments on expanding the documentation
> and commit messages, so I'm intending to send a v3 later this week.
> Please hold off from merging to 'next' until then.

Thanks, will comply.

