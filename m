Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35444C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3434207B2
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgL3BaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgL3BaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 20:30:15 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0EC061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:29:35 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h4so12948011qkk.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S4Uwa4XR7rINpOUyVVJPWZk19gKMQDMn8uJ71+CiuKw=;
        b=tgljqcFQkPhzRIcckzddD3xwvUJ3GuwgCkWMnrjC/qve2LhWUriafQDYeaeYg56VcG
         LbWtGRXB/RrJ6uYtEABrDEcJ3CCdfE+DiMMpoKgJaY6TI4JXI0x8w2ezi+6XbEs7+h0F
         RMvRsZnWRRQA4R4ItBmNnhe1T8HYymhh+mc4NIOeoVbQS4AMdrX/zfszRx9ZTpNNncea
         j3bLYE69GO0aAGnARknchZOHzqrO1IUve+EU3QOSFK0tvpxbpjhzGap6Iby3ZZiCLlMW
         3f/Xy2LxBCDe88MwyQNwh25BTPnjsQeyn4OhlktgKsf1uUjdT/TAY6IjIWTyAv49gYmT
         QxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S4Uwa4XR7rINpOUyVVJPWZk19gKMQDMn8uJ71+CiuKw=;
        b=kdc6ljTM+Mm+u09RgtYkxORWHcEkKSQsp0E+jagjVUVeMsynMk8hRpQIDRKdITiD5A
         cIYdhw0G7/kW4bE0GHTkUg5RqIDEON4Mvee/KWJKAokTmzYMzn26QhxxSKoA7+SdlhIi
         zIRms/c/g6XWjM2h9PzrgZwD6X0tvpXugDuXKXqGLwSK+iB8qYyq2jwxQJz52rIKAKod
         xIExF1dBlHcjtUTmcvR2EBPaYoQFqiEMgoMaQCYem3qsLkmcyDV7OZsCFe6v2VgnrXun
         v5Ya0sKvO6udy6fdn2lGW1EFs/7BcA3NSEslkHVywndHOF+j1fdRyUPWZJ8TM39iLeDP
         eamg==
X-Gm-Message-State: AOAM5302/BrXieu6ZMcV+slV3nAkrx2y7LCHYNlpVgjgiO2M4AdFx/Ce
        r8zPOV0ggCWGGSZG8WdjAAp8QCj8VcFeYQ==
X-Google-Smtp-Source: ABdhPJyLgGhTRfFPktGC3yHEL8a0s85Gq1+vRCZM/c1EfiZ0COpeL6kadU5kDDtjHHguJLMXh3OLRQ==
X-Received: by 2002:a37:4709:: with SMTP id u9mr42612490qka.70.1609291774320;
        Tue, 29 Dec 2020 17:29:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id u26sm27557591qke.57.2020.12.29.17.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:29:33 -0800 (PST)
Subject: Re: [PATCH 0/4] rename "sha1-foo" files
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1609282997.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d1f5c59-db2c-3c88-f3ca-1edcdfb2f99e@gmail.com>
Date:   Tue, 29 Dec 2020 20:29:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2020 6:52 PM, Martin Ågren wrote:
> We have some source files with filenames such as sha1-lookup.c and
> sha1-name.c containing a few variable names, comments and the like
> referencing "sha1". But they are able to handle SHA-256 as well. Here's
> my attempt at removing "sha1" from the contents and names of these
> files.

I think this is a good effort. Timing is good after the v2.30.0
release. As long as this doesn't conflict drastically with things in
flight, I think this change should "jump the line" and merge with
priority to avoid future conflicts.

It _has_ been bothering me that it was still sha1-file.c.

Oh, and I remembered the one semi-legitimate case to try for exact
renames whenever possible: "git log --follow" will download fewer
blobs in a blobless partial clone (--filter=blob:none). Of course,
this only works if the rule is always followed and is not really a
justification for doubling the number of your patches.

It does make me think that it is worth checking if "git log --follow"
short-circuits the full rename detection if the path it cares about
was found to be an exact rename (so doing a full content-rename check
on the other adds and deletes is worthless). Making a note [1] to
investigate.

[1] https://github.com/gitgitgadget/git/issues/827

Thanks,
-Stolee
