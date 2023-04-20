Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C88C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDTTy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjDTTyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:54:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B559CF
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:54:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2471efb3f71so816516a91.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682020487; x=1684612487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUFNP3fSWZRA8EJr9OyOfQil2WYzILKhrmxLqBdm5nM=;
        b=JqM3mHY/LOjBZ2kd7MG1YxHLB8yAGSO9yOidjWy+tiWEhINiqwrjXac813gM2oiLjM
         7QLFUjybqXE7CA+kx7lctca39GXSJg3wXF6AlCEB008jkmj6+jEGrHg1BdMboCDvmTrz
         eKOJEtpcwRkHcm0zn6C6lqk7XIVHpccK6TSpYIfElE6mxBO9OhFSik0A4YbbVpseK2gi
         ewdFxRICjJK6iPzwU/vB/0LR8nC6Qq55eiX4ZVsp8bAA6UmKiGAg/EQ/eadj61dUZKKM
         WD7UPTQkjG120djsKKfUNsUKBHpBzOEmHnVlhGfVxAPa+PPsAcLBm/VAxpZgdq1wojgT
         vekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020487; x=1684612487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUFNP3fSWZRA8EJr9OyOfQil2WYzILKhrmxLqBdm5nM=;
        b=IdIFD9MipTcNHjPxF9Sd3eilDf9T4EzjyD0PfaloeRjndQTH6BPv42Vu3cUTsO3nTt
         iqbABTnM3o5C4n8Rb4JjECh5ckDxRgytCYMQ38x77DlbJKBw0a5feNpH5yxeb8vuCPgB
         x7VGAh9tHvY+xw9GxaxUZf1jN5iv4tvXrBOOguR/+htp/GtCE+R6TPVXdIuIIijAXBEj
         4zN65/21bVYWy9ps9AelpQUeGnwOqw1s7Yv7o9qsN420aFlSV2sAc48HqINSxRHFruBS
         ab431UifyDkygbkHdUr+F3DXe2gHJRhFy7GOoqGyA+UScVhAlLUNOUgaZvfhi6Exgy6S
         hBjQ==
X-Gm-Message-State: AAQBX9dwz32hR8nOnIH+OJ6pCX/p4yjdBfhIQ/6GHGWWJi6Ms/y8VE/t
        imdiFpwTz3kkbem2ngrsBrRaCyqHkcVvUg==
X-Google-Smtp-Source: AKy350ZlW0s8l7QM3B6vEFx0Cd329mZ0qjP9obJGOadi2MWQyz9diPCnNtz69KQXGGnlYf46ppg4iOZXUSI7tA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:6743:b0:247:e46:2c76 with SMTP id
 c3-20020a17090a674300b002470e462c76mr734549pjm.3.1682020486892; Thu, 20 Apr
 2023 12:54:46 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:54:39 -0700
In-Reply-To: <xmqqpm7y4kht.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
 <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com> <xmqqedogbwh3.fsf@gitster.g>
 <CABPp-BELApT-6YrYJ5qwme9uwP_2gqERdiLiE7mJu_b0bXmCbg@mail.gmail.com>
 <947db4da-13d9-d81a-1c0c-d8fe62a9279f@github.com> <xmqqpm7y4kht.fsf@gitster.g>
Message-ID: <kl6lsfcu1g8w.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these dependencies
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <nasamuffin@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>> This is mostly because most consumers in the Git codebase will want
>> these methods, and only the most fundamental hashing code will care
>> about hashing separate from the_hash_algo. So, the most-natural name
>> for "the header file that lets me hash stuff" would be "hash.h" and
>> "hash-basics.h" is for "I'm doing very simple, low-level hashing".
>
> I do agree with the reasoning for "most people want 'hash.h'"; what
> is called the "basics" sounds more like for advanced users of the
> low-level machinery, but somehow I expect "basic" would the one to
> be used in sample programs in tutorials or something.  "ll-hash.h"
> for low-level hash features?  I dunno.
>
> But whatever the name for the header file meant to be used by
> "advanced callers to low-level machinery" would be, I like your
> choice of the latter variant between the ones Elijah presented.

FWIW, I also think this is a good idea. I suspect that a lot of the
libification effort will need a similar distinction between "a subsystem
supporting the needs of the git binary" (aka high-level) and "basic,
reusable functionality that can be its own library" (aka low-level).
