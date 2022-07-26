Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB3C3F6B0
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 17:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiGZRwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbiGZRwS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 13:52:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CE33363
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:51:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so11346072otk.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M1f42V3JAJOAVqD3u/ce6MPv5vsPg1Ygwzo8FVStI/w=;
        b=Xj0Uz2RBJcsi3hkB5nNU1tECf/OxSDeoqQQYvqPGrcW7I3aN+yCcBYHW40h6i5t9ge
         ZXRjwPOSzsCw0RxLQvm8DSBMQNlbidZIAHZKUSV3XWYlT+2uPitfF8jQO8clkboIBzcn
         IXLiTKUHXOrjnOLN8GS1dwO2KslYZxLKfk4OjdN0duMhPipX+Ifumwekm/2zt8Ugun0i
         wvFTRVJsdfL7yqC8feroqdkCmO7bnAhBYfzD293Iub/ZycJtbE0a4ckxM8vWt0MTfIVo
         VvzC45+OxT8nyQqhPyXBTassrL1DEhn3CT8A5HOrH9PZXujM0usoe3YSwp7jQr1gR/GJ
         5ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M1f42V3JAJOAVqD3u/ce6MPv5vsPg1Ygwzo8FVStI/w=;
        b=Zij+PEvHclabGwJ4MuPfMs3nYhyAEaoZ4zVQfVpmzlD7zbSzjM1nBJP44OryNtJ4St
         LJ/NeVeH23hUxFj/53i5YAaEU4Qeg6LHN7aHZHeFOMA+YG+AYaew7dgUX4CQW7w1Ix5g
         9J+b8i/jk5dzppYKMzJ3eVeQznS4smjTr5Ybs0ya5pqCH0D1ZiIPllFzmQ5YrqmWjtYu
         UlwQPetzj+AzH7cFd8d2v+SRmzOBXOwD6FW3PMbMaXSrpoQBGwoo9BbHYCHVSq5Q8y5n
         W1nkM2AaRJQ4PcWfMbfUT7dr9Ng5J4gftZX3eHRu21L4TzP7EuoohTG4Y0v6SHNvjhdy
         abHA==
X-Gm-Message-State: AJIora/4Qv3NWc8VumcT/dEGK6eWmyRvQN6yoIxPtBSc0Sjv3R9YQtgi
        F/vctPioQXEjKwM7W83JXZe0WPHE4Aru
X-Google-Smtp-Source: AGRyM1vTiCPcWn3xQ9QY9P3vl8VVQr1ljtpa/qbEs693ngyR+3MuWPxx0N1ACOebtUVfGVh31YcVig==
X-Received: by 2002:a05:6830:2707:b0:61c:c565:d72f with SMTP id j7-20020a056830270700b0061cc565d72fmr6743386otu.101.1658857879757;
        Tue, 26 Jul 2022 10:51:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:70fc:586a:b1e2:eef? ([2600:1700:e72:80a0:70fc:586a:b1e2:eef])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d63d5000000b0061ca70905absm6584281otl.49.2022.07.26.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:51:19 -0700 (PDT)
Message-ID: <47c0803c-bd98-0460-1e9f-c37dc3deeb8d@github.com>
Date:   Tue, 26 Jul 2022 13:51:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] config.c: NULL check when reading protected config
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <YuAj+eBajf6jkJPc@nand.local>
 <kl6llesfsrgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YuAn171BhecC1w+O@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YuAn171BhecC1w+O@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 1:43 PM, Taylor Blau wrote:
> On Tue, Jul 26, 2022 at 10:40:18AM -0700, Glen Choo wrote:
>>> I wonder: should it become a BUG() to call git_configset_add_file() with
>>> a NULL filename? That would have elevated the test failure outside of
>>> just the ASAn builds, I'd think.
>>>
>>> There's certainty a risk of being too defensive, but elevating this
>>> error beyond just the ASan builds indicates that this would be an
>>> appropriate layer of defense IMHO.
>>
>> Hm, if we're going in this direction, what if we made it a BUG() to call
>> fopen_or_warn() with a NULL filename? Then we wouldn't have to
>> reimplement this BUG() check in all of its callers.
> 
> That may be too low-level of a place to put this check, but I don't have
> a strong opinion about it either way (including whether we should have
> such a BUG() *anywhere* in this series, including
> git_configset_add_file()).

Since git_configset_add_file() returns an 'int', could we return -1
if the supplied 'filename' was null? (The correct place to check would
be down in git_config_from_file_with_options().)

It would save all these checks here.

(Also: do we care that we are ignoring the return values in
read_protected_config()?

Thanks,
-Stolee
