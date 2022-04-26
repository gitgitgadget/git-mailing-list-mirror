Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ECCC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiDZNMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350660AbiDZNMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 09:12:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435852B2B
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:09:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 125so19550019iov.10
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=e6dQOAWhDSTKWjv2/tmI27W/CCqEZBmRUdeh02x0mVs=;
        b=EP4/ZrxyigbG4PCDGH5Sc2VP4XGoSwtFUA6s1JWCs4GhxGzFAQlMSj02O1u5WIddTh
         H4ybXJAW476YqFv1PRgXtI7N1PwUoaqFXCY/icN+58PXP6nDGS/v5L/xKOVbYDYQw6bR
         LNEhEgZypGGPE4KgmlS8G4B4x/uuccP4ODZ/P+K+SYEzmtjX4mz3J9gkri1s3aQh95U3
         B3j7N7kvcW6wsGYjbX7nx4ctJiNvSZVsQCfP5p9YG18sYGUcWmSWvOjGr5+9e0ZYv1+t
         5OsK87L9jDZ6X0sBaH84EPlYikpf04mI64tj06SQIte3oaG8uTCly5Bz2EDCOCUh33Db
         x/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=e6dQOAWhDSTKWjv2/tmI27W/CCqEZBmRUdeh02x0mVs=;
        b=whIswOmW3m5/7S07ESTdQBmtkRqWKIbqCqBaHnx8cLq2Jh+C49+LtfjBul2jXYBbYU
         Dz9W7xA0ZlJhgm0rVFpnk5nvZOsCGSY1UnXhEWYNZyFhBRt95XGeRGmwj7WOPe9heG2o
         3WPWCdc2otimrfDHEGaNibymWYgKjjj+Se9Kqnw2La6J9iUpZ3PoXBHgC+W31HkLRwop
         usGSuc2BEH5ppIR8/g6bI/yLkqqtCq8mEx805p/fLHPWQMDIxsVw4gDKZMfbUEBm235f
         tU70VV2DbIn+HaQIEkaO+vNiVnqZ9UM6+NlVN0FJdS2fGvKJkjVFL+owTh2/m8sEOTkE
         hYsA==
X-Gm-Message-State: AOAM532rUYKip2fkkQjLDrquvA0Bq8mB9a5Kp0i5rZeooO8+OQXHKyn9
        9pUwQf5ioi4WN/sPn28h08kl
X-Google-Smtp-Source: ABdhPJwFXYuEYR3GNNYJbTuHWBspddezVnqaJugyvkPU418gfTy0Bo2/nxUNsw5D7mE2mRGklSj6hg==
X-Received: by 2002:a05:6638:d87:b0:32a:c87e:eea6 with SMTP id l7-20020a0566380d8700b0032ac87eeea6mr6652704jaj.194.1650978563608;
        Tue, 26 Apr 2022 06:09:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a3:141e:f20d:6edf? ([2600:1700:e72:80a0:a3:141e:f20d:6edf])
        by smtp.gmail.com with ESMTPSA id v24-20020a6b6118000000b006548e251e72sm9421896iob.16.2022.04.26.06.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 06:09:23 -0700 (PDT)
Message-ID: <b7752094-1f70-20a4-3217-502803817264@github.com>
Date:   Tue, 26 Apr 2022 09:09:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/7] Sparse index: integrate with 'git stash'
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <9ff9f199-baec-80f5-41c2-17034744e527@github.com>
In-Reply-To: <9ff9f199-baec-80f5-41c2-17034744e527@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2022 8:49 AM, Derrick Stolee wrote:
> On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
>> This series, in combination with the sparse index integrations of reset [1],
>> update-index [2], checkout-index [2], clean [2], and read-tree [3], allows
>> most subcommands of 'git stash' to use the sparse index end-to-end without
>> index expansion.
> 
> I'm really excited to see this culmination of your work in this area!

After taking a careful read of this series, I'm really pleased with how
simple the actual code changes are at this point. This is a testament
to the hard work you've done on the child processes and also some luck
in how we've added protections to different portions of the lower-level
APIs.

The biggest interesting points from my review and Junio's comments are:

1. The merge_recursive_generic() change could maybe be done by modifying
   the options struct instead of changing the prototype.

2. Using merge ORT for applying stashes could maybe be changed by config,
   allowing users to select recursive if they want. This change could
   also use some testing to show the merits of ORT even without a sparse
   index.

And then I had some nitpicks:

* A script variable could use quoting, probably.

* You moved the checkout-index tests to be next to the stash tests, but
  I don't see the value of that. (Perhaps I just need to be enlightened.)

Thanks!
-Stolee
