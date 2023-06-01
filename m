Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF308C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjFATws (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFATwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 15:52:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA807184
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 12:52:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561b7729a12so38941427b3.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685649165; x=1688241165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caTrZsFN/GXepPJNLy+aSyZj37ZML2YWwyjXhCKQhmE=;
        b=ijM3ddxJgbd5GlrHM7CJq8XqXEFR9MqRMj2TfSDUvnOW2KWG+juR9SaR7dtJAZNnuP
         igMXJ09GrebfM9iM6k4UpnbQS3r0ZCQpFu7b0ghlhhqaIyhKWpoOlBRb3SnxnrQNAdJV
         +z5XvA/0CKNuUWV1vgqWdefRzQVFzmrPzZsBfyTgtAp7vixe2jbnfwS89cesFPqynrgo
         H9JtLxmHUKya0zedabk/puarcTOWWvWjrAbRZula05o2YPEShoxryNiDG8+vVh+6jGVv
         2Pce7Gm2hMgCFQATW+B1MXOxqeIJM2usM0igatvIQXnq2y5eHzQHwFhWY1bNokmFwqki
         JHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649165; x=1688241165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caTrZsFN/GXepPJNLy+aSyZj37ZML2YWwyjXhCKQhmE=;
        b=GF9DdjG9JX0cB9uZgurXyK3XHu4tEph0Map6WXGl+nqUT1KJgcs7AIaJjwaxHE4mas
         IPZCmKCDYTLGRUi8dpbFzxLNVU16zU4U7cSelyu3MjSsPETVJ77x00dO80da9+pnksds
         dqKkEt0r2hyPcb5GtXvElfC2Wk1VO0xLd/VwTM6PsdXvwACTlYl+gbS7fmKxCtnTyfkC
         DKNDxWdi/n7jP7b42bYUl/t5dNsZ1WgqUQPx5KguErEvZ2XoKb5cpCoj2jfAMeCpihm1
         RGnq9r7gjS1SjJuN+FoO+wDrmJMqMiBN0DVeO8bCaRvMtjrNitc/1q3Esvo5p0sMQmJr
         d3Zg==
X-Gm-Message-State: AC+VfDzhhCTfMbgvOM6eil4tOpekQ88w6Jr2CDyLLySauKB6cFw2ay/h
        Z7En9G0fYk8+S8PjhQEgqVfa
X-Google-Smtp-Source: ACHHUZ4Wm1WXlPbbsy6dDyAbH6i8YxQ/P4L460hmHF/PATeti/kmSgw7noXf/JrX/DIQPEYhPeRNLg==
X-Received: by 2002:a25:328c:0:b0:b9d:766d:f72b with SMTP id y134-20020a25328c000000b00b9d766df72bmr1151927yby.31.1685649164936;
        Thu, 01 Jun 2023 12:52:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c920:7fe5:ab49:f151? ([2600:1700:e72:80a0:c920:7fe5:ab49:f151])
        by smtp.gmail.com with ESMTPSA id 23-20020a250317000000b00bb0cb0fe17csm2328518ybd.41.2023.06.01.12.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 12:52:44 -0700 (PDT)
Message-ID: <31962d5e-b14f-86b1-8428-de29650d89ee@github.com>
Date:   Thu, 1 Jun 2023 15:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] repository: create read_replace_refs setting
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <481a81a515efb29bc4eb0b1a09b7d1df3f3c074b.1685126618.git.gitgitgadget@gmail.com>
 <68fd5ca2-a6c2-d742-5d74-ba93c1497169@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <68fd5ca2-a6c2-d742-5d74-ba93c1497169@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2023 12:36 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> Unfortunately, the existing processes that recurse into submodules do
>> not appear to follow object IDs to their contents, so this behavior
>> change is not visible in the current implementation. It is something
>> valuable for future behavior changes.
> 
> AFAIK, the only '--recurse-submodules' commands that recurse in-process are
> 'ls-files' and 'grep'. However, 'grep' does call 'parse_object_or_die()',
> which (further down in the call stack) calls 'lookup_replace_object()'.
> Maybe I'm misreading and the replaced object isn't actually used, but could
> 'git grep --recurse-submodules' be used to test this?

You're right. I was laser-focused on 'ls-files', but it shouldn't be hard
to construct an example where 'git grep --recurse-submodules' would show
different behavior when this config is toggled.

>> +	/*
>> +	 * Do replace refs need to be checked this run?  This variable is
>> +	 * initialized to true unless --no-replace-object is used or
>> +	 * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
>> +	 * commands that do not want replace references to be active.
>> +	 */
>> +	int read_replace_refs;
> 
> I don't think this comment is accurate anymore, since the repo-scoped
> 'read_replace_refs' value is determined *only* by the 'core.usereplacerefs'
> config. It's 'replace_refs_enabled()' that makes the overall determination
> (taking into account 'GIT_NO_REPLACE_OBJECTS'/'--no-replace-object').

Thank you for catching my mistake here. I'll be sure to update it in v2.

Thanks,
-Stolee

