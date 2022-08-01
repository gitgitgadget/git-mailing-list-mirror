Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC6C19F2A
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 13:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiHAN6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiHAN6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 09:58:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A422517
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 06:58:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c3so8401818qko.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=cD6jn+zY7Nfn4R8SIuStxJZVitnl7jxHlczZvrLJq88=;
        b=WPEzLNghY4mu2Nygs9/sVy5FIJAsE9/4CTtav2Y2z7F2SPhhXL0+WmAa4NH8jVFuz8
         N6Z/GnRg7sk6yxZKqeOQx+nu8ofKYm5CVeBA94XuUtRp9CcflXLfsgVIkOrk9rUBiYeG
         YeLtJnFhNIY/fx9Qi0WpmW3QFqgXEfDXVCOj7e+kxDg0u3mYrF3KUBCUBa9K0YDmZYxe
         pzbeVWY3J2tEx1gmUKs+UUmBQGz2sjxk7euLB6zBbzDWOWiGOkZ2E7g+HUm0c8iRu7/B
         Gip0qYNjI1WZaLQFuWckSBKUdL2ZLx6yiWgSnOpaGSUhOTPKZ9LTFnvRVTHrxJ73Yu2P
         3QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cD6jn+zY7Nfn4R8SIuStxJZVitnl7jxHlczZvrLJq88=;
        b=lrJcslBa3HVyAqZyynI8603akTtAqZnprTUPpNRO6HSiEydiKJZgfz4h7xbeTVXzek
         9Y6UaZGTRV/eOp/S3yD4/kigjTgT8994YXaedRJA6sp7zer09JU1UthyBB5wvkx1eFcC
         zX58YSOFGJna+RpsAgwtNd5SAQ86IF8ndZ9gZzPCDuUmphPFn4Ecn8YtZJyt1LxpZ1AZ
         SygQE4RTdBVrdqOiqkXoSZCTcUMtkhfgQMGEzVeIQ0FCT1+q5atXzvHEtzFEjcPoUAcO
         n+Dj3HyeliV5rDS3KXLApq9pDZO2Tzsp4r2NJXkmnFNeGZ3T/8YRJSxnwGBssx1zMYiE
         ZrIw==
X-Gm-Message-State: AJIora/7E3nfdasP/mKaUL2wH2brOVU6Qb9w0MwNyt3kTOaUC+5fYNIl
        i0Br8ZwMq+K0x2JudF/pEd1N
X-Google-Smtp-Source: AGRyM1vuhlWpnjau2RtuLYRp5/BdQXIWy7gnyIXvRzEEhu2ZXXngImWeYUi76IM67PMY/Hv/X/lOkw==
X-Received: by 2002:ae9:eb08:0:b0:6b5:cc8a:a041 with SMTP id b8-20020ae9eb08000000b006b5cc8aa041mr11774986qkg.413.1659362286893;
        Mon, 01 Aug 2022 06:58:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8ca1:1a2:b034:1f7e? ([2600:1700:e72:80a0:8ca1:1a2:b034:1f7e])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a414500b006af08c26774sm9045995qko.47.2022.08.01.06.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:58:06 -0700 (PDT)
Message-ID: <3d5aa1ff-3629-b5d9-28a0-a0e204a6cab0@github.com>
Date:   Mon, 1 Aug 2022 09:58:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] bundle-uri: create basic file-copy logic
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <7d3159f0d9a29a04b5856982f787f4eddfb91b53.1658781277.git.gitgitgadget@gmail.com>
 <YuG3h4AcZjyILvdK@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YuG3h4AcZjyILvdK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 6:09 PM, Josh Steadmon wrote:
> On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> Before implementing a way to fetch bundles into a repository, create the
>> basic logic. Assume that the URI is actually a file path. Future logic
>> will make this more careful to other protocols.
>>
>> For now, we also only succeed if the content at the URI is a bundle
>> file, not a bundle list. Bundle lists will be implemented in a future
>> change.
>>
>> Note that the discovery of a temporary filename is slightly racy because
>> the odb_mkstemp() relies on the temporary file not existing. With the
>> current implementation being limited to file copies, we could replace
>> the copy_file() with copy_fd(). The tricky part comes in future changes
>> that send the filename to 'git remote-https' and its 'get' capability.
> 
>> At that point, we need the file descriptor closed _and_ the file
>> unlinked.
> 
> Ahh, it looks like this was the point I missed in my previous review.
> IIUC, we need the file unlinked because http_get_file() will eventually
> call finalize_object_file() to move a tempfile to the final object name,
> and that will fail if we have an empty file already in place.

Yes, and I also was not sure what would happen if the empty file existed.
I tested it and thought allowing overwriting an existing file would be a
bigger problem than this choice of a filename.

We also discussed options about how it would be nice to have a predictable
filename so we could resume downloads _across Git process failures_
instead of just a network failure within a single Git process. This is
something to explore when creating that functionality.

Thanks,
-Stolee
