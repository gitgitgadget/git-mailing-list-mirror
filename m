Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E0C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiIVMfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiIVMfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 08:35:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B5DF3B4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 05:35:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d8so7525350iof.11
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=or5p3aIqBpX1JQbEl11xMgwS/W972RGeW94SJorCdTw=;
        b=NXebWtw3dRvuFNp3aLhA16O/fnpwwJWy/0MfvAtlJ/+LuBkMyyOPZoWkUq/S41IPVc
         6AWBUArVKo35qF1fQpnE4JcH6UO4tFq9MTBhiMdWIg3V1lp0eibJt+C444h8aW6tG+j7
         KQzoU+AiYExOFKvK+U1hCBLCNwsma3mtk2IaXy5cPf9oMiEvSlqw0HB/Ow3rdbEzI1vQ
         NC1uwcsByPB+dLdWMYrm8FjkJaKzy45dkqOsmf+nWv0wYPFxdsaATr3NUT4VHw0kgAe1
         DYnBOOTxkL9JAVVzHuTFTSZpVZd5uYWJ6DZHwE3TokLKNOhvjWYM3a5ABQ+jchPkxLcZ
         8zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=or5p3aIqBpX1JQbEl11xMgwS/W972RGeW94SJorCdTw=;
        b=X0pPopYYKCCPuTVriKDb+x2jkmE2JWeR4dXFIQQAMgnFtRh/4/GhuVLcnVWs+M1v6X
         foBOw0EzKDB7PbIhS++TetaeNkcV7jjZBByP4Hkk8oAjSAzrIbaAxIXFJmWc9gAZ4i7k
         0SrFjizaeuxb098XehkbUwPPiQ+QoPsqfqbx867RVXZP9DxO+NI+Wuz0l9knNnjoS4kl
         3tzbqHxxwJ9pajwi/0ph0HYO4486qJEG3xUGaeZYi8aDJtLzN09jRF32TYCQpdD91Jxi
         q9baLojAFgdhltq3wUluQrhNTnsYTzlCMF/lybiwq2Rtm6M/25Ogat1o8db5yG98DQQ0
         cuUg==
X-Gm-Message-State: ACrzQf2U+KDI6bDyGPTcI83BvzkiFVtPdUpJX91KV6/y8GcwdGAGi1cx
        X6uVGXTdkKCyPQl9R9Bj2puEz8gLoCQ1
X-Google-Smtp-Source: AMsMyM6RtaFlYxE31rzI5nUKY8Xywr+Uwb5YWvlBxr/D2wLt85gfzvMZAmp/JyCKgRfH2R2fSMOjKw==
X-Received: by 2002:a5d:8a13:0:b0:69e:2133:4b38 with SMTP id w19-20020a5d8a13000000b0069e21334b38mr1408227iod.106.1663850123784;
        Thu, 22 Sep 2022 05:35:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id r10-20020a02b10a000000b003583d27d258sm2151085jah.105.2022.09.22.05.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:35:23 -0700 (PDT)
Message-ID: <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
Date:   Thu, 22 Sep 2022 08:35:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: t9210-scalar.sh fails with SANITIZE=undefined
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2022 6:04 AM, Jeff King wrote:
> Running t9210 with the tip of master triggers a problem with UBSan:
> 
>   $ make SANITIZE=undefined
>   [...]
>   $ cd t
>   $ ./t9210-scalar.sh -v -i
>   [...]
>   read-cache.c:1886:46: runtime error: member access within misaligned address 0x7f7c09bf7055 for type 'struct ondisk_cache_entry', which requires 4 byte alignment
>   0x7f7c09bf7055: note: pointer points here
>   33 2e 74 00 63 2c 31  42 17 3f 49 72 63 2c 31  42 17 3f 49 72 00 00 fe  01 02 60 06 4d 00 00 81  a4
>               ^
> 
> Now here's the interesting part. We do carefully read most of the data
> out of the struct with get_be16(), which should handle alignment (we
> have to do so because that on_disk_cache_entry is literally just a cast
> from an mmap'd buffer). But the line in question is just:
> 
>   const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
> 
> It's not even reading anything, but just computing an offset within the
> struct. I don't think that line in particular is to blame. If I use an
> older version of Git that predates it on the same repo generated by
> t9210, I get a similar error for a different line.
> 
> Another thing to note is that the command which fails isn't scalar
> itself! It's just vanilla "git add -- loose.t". But it's curious that we
> never saw this alignment problem before. I wonder if the scalar-cloned
> repository has some index options turned on that trigger the issue.
> 
> I didn't dig further. It's obviously new in v2.38.0-rc1, but I'm not
> sure it's a show-stopper. It _might_ have been there all along, and is
> just now surfacing. Or it might be in an existing experimental feature
> that just wasn't exercised enough in the tests. Or if it really is new
> in scalar, then it will only hurt people using scalar, which didn't
> exist before. So I don't think it's a regression in the strictest sense,
> but it might be nice to get a more accurate understanding of the problem
> before the release.

Interesting find!

Here are the index-related settings that Scalar sets as of -rc1:

* core.preloadIndex=true
* index.threads=true
* index.version=4

My gut feeling is that index.version=4 might be the culprit. I thought
we tested GIT_TEST_INDEX_VERSION=4 in some CI modes, but apparently we
do not. Do you get the same error in other tests with that environment
variable?

Thanks,
-Stolee
