Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B06EC77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjFANqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFANqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:46:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A47138
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:46:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565ba53f434so8465877b3.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685627192; x=1688219192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPpfuo3NocQ+18mmkdZvkipUm3zgba1vN3Hrc4thx58=;
        b=DOvuWZJb2Pt88Bn4d6q9/QgmaUCxN7s+UVm2mPgb/kerpLHRnJ2alIwymcNg6NdOc5
         AF7gyNBJCxQWxRksLia4leKhX7N5TVskDbrYXfv8HczHN7pys9+OAE9iQGn9eZX2fXWV
         I+msdCA/rFolWN7CztihmZ7aY+3LZaZbtTN8lgfJTyvQkoupffqUZH3fOHNZcN3hRtyl
         rsjosI2aFobg+GtQTMwTicmXNU1YoewHwpN14q+VeugOj1q/6DJT3iacqbAkke8A7nxm
         1WGG3tVIPbKB/mpBZgbMI3z4dy/cH7NdoKZD9SkawX3IUtCv9ZzziKSPf6sc4F6RO2Nl
         Tm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627192; x=1688219192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPpfuo3NocQ+18mmkdZvkipUm3zgba1vN3Hrc4thx58=;
        b=kb+BVrD5Rg2OnvhWe59SaE3wBN21d9dfhtn0F+SGjjjtiQqwddHzsCwwb07nHcIIJu
         rzGMCTykrV1CFgecAI9LVUQTGeVRjYSskVs6iD2ofjixc9GVWFP6eoXcnf5cCb8gBdL9
         M4dL6TARlSLq1FKeuwxACm6YBnb4A3s9bvOHYB7PQO3S20ibeQCRJY3HOqyyZ1Vmjs74
         XBoWdpUskPApmTjtFP7+V1DnmnsD5aC0eoTsvSMdbgrzfA/PWLytUr9daCk3iz2ZjJC+
         Eix9Q263LeMwZK0POf1uddCHCddBQ+wZf82yRKDKHtwH74sZkr2CQXuFCvMmUSfq2Wpl
         B0JQ==
X-Gm-Message-State: AC+VfDyHdlJ6+MAFjJXOCQe+uVhfht4Y9g1rKJeB4NkKuPrqZ5GRuXzS
        6Z8i8aacyy7Y8wjxJPLcYUnU4yDA6HAXc0zLBw==
X-Google-Smtp-Source: ACHHUZ58OKDCRn+aYIZ5QwSl9jfYGWgs1LQIrjufYm8ZQemgYOlWqR1v0TB79xZknSUeZUpkDhTsSg==
X-Received: by 2002:a0d:d58d:0:b0:561:90b3:e712 with SMTP id x135-20020a0dd58d000000b0056190b3e712mr10420282ywd.28.1685627192044;
        Thu, 01 Jun 2023 06:46:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c920:7fe5:ab49:f151? ([2600:1700:e72:80a0:c920:7fe5:ab49:f151])
        by smtp.gmail.com with ESMTPSA id u185-20020a8184c2000000b0055d7fc2b704sm5677483ywf.16.2023.06.01.06.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:46:31 -0700 (PDT)
Message-ID: <56359570-65f0-0916-310e-2d8a1d8e6b1f@github.com>
Date:   Thu, 1 Jun 2023 09:46:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: What's cooking in git.git (Jun 2023, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <xmqqedmva3wa.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedmva3wa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2023 6:11 AM, Junio C Hamano wrote:

> * ds/disable-replace-refs (2023-06-01) 3 commits
>  - repository: create read_replace_refs setting
>  - replace-objects: create wrapper around setting
>  - repository: create disable_replace_refs()
>  (this branch uses tb/pack-bitmap-traversal-with-boundary.)
> 
>  Introduce a mechanism to disable replace refs globally and per
>  repository.
> 
>  Will merge to 'next'???
>  source: <pull.1537.git.1685126617.gitgitgadget@gmail.com>

Please wait at least for a v2. Patch 1 could use some cleanup, and
I have the changes staged locally while giving time for more review.

I'll get a v2 out by tomorrow.

>  What's the doneness of the base topic?

I'm happy with Taylor's v3 of tb/pack-bitmap-traversal-with-boundary.

Thanks,
-Stolee
