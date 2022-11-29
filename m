Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100BC433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiK2VQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiK2VQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 16:16:11 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AA2BB28
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:16:09 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso9974568otq.11
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viPDrmZIc8W8dUgqD/BPbQQifZNQz4q0Owhe6c3d1mQ=;
        b=GUXgv6C3KDmy7iRS6XOFYHePqfB9HN5QDtYf59unxhcBPdrrsELmNdF+drUcv8uzf3
         yItg3/UrkcF9tWdRpkTE/KyN5Ij+CotbVdx/sPhNzdchvDFtE5g3oISJv4eQNtcCmEGc
         TzdFjcfwER7I4r/ScXQOIjPx96Olie2uEhSWvuP8Nh165SdgKQrD+QozAXIeWa1mIEmG
         IQNWgp2nT0H73j9MdonKWUAGDGy6RZbYFC2EZ5sNuwpyXvRjtegU+n+Dp8LDeQ8823+t
         VEIlqwuyA9EvZCsMB072I9yCjEAv7Nf4DliDWufgxf4ZFMJzEKO+JEeIP1uNvBDIQvxY
         G/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viPDrmZIc8W8dUgqD/BPbQQifZNQz4q0Owhe6c3d1mQ=;
        b=iZ13/fAbF87vM1zbIfouTbpg5COEkMWtAZDjWp+tQXW9dEYLETfHvjmvYr6JVu7+21
         +lzRqJwGCbV5OMvAPP3RCVWQnqfoEEUwvj4G3q0pLlBvrzcVaKwdjAviH092ehSYaM/W
         Fn/rQYxs6m3s4hmcgzS6XkSHWKWAbuR6uv5sPEYGuIlrrHgJ/n//F3RkdI4o/blTs/4A
         xFHjiLJQmdG9uUC+4mDTM0ro6gtfPg2ygSm4Tdwqqxi9t0c0zFwwCuFEX553pJ5JsXop
         tuPvJ7vf1rOdLxb6GyNLb03XDELXzKIGW9mPb0Baqi7+fj/LxMV48EDm9nNLSbHMtXnS
         Cumw==
X-Gm-Message-State: ANoB5pn1hQ6SzAP7plmoTQEYlLTmnANcBcIWlrO1fcVyPaJSny1QikMS
        fAvdRA4R5ZVlYmmSpSyK7wIIbBpPqtal
X-Google-Smtp-Source: AA0mqf5O+WXnoaEzqResPnJ8k0yppVsemV4yxSs4ttIvVqUBoVKYbBmckjG897r/lRsL2g7bpOMb9w==
X-Received: by 2002:a9d:7a83:0:b0:66e:63f3:b26c with SMTP id l3-20020a9d7a83000000b0066e63f3b26cmr1367818otn.339.1669756568276;
        Tue, 29 Nov 2022 13:16:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6124:8b5c:d98f:d063? ([2600:1700:e72:80a0:6124:8b5c:d98f:d063])
        by smtp.gmail.com with ESMTPSA id y36-20020a05687045a400b0013b1301ce42sm8061444oao.47.2022.11.29.13.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 13:16:08 -0800 (PST)
Message-ID: <b223202b-0ae2-bdb5-e9d6-21a6321a9e31@github.com>
Date:   Tue, 29 Nov 2022 16:16:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: ds/bundle-uri-4 (was Re: What's cooking in git.git (Nov 2022, #07;
 Tue, 29))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfi22j67.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfi22j67.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2022 4:40 AM, Junio C Hamano wrote:

> * ds/bundle-uri-4 (2022-11-16) 9 commits
>  - clone: unbundle the advertised bundles
>  - bundle-uri: download bundles from an advertised list
>  - bundle-uri: allow relative URLs in bundle lists
>  - strbuf: introduce strbuf_strip_file_from_path()
>  - bundle-uri client: add boolean transfer.bundleURI setting
>  - bundle-uri: serve bundle.* keys from config
>  - bundle-uri client: add helper for testing server
>  - bundle-uri client: add minimal NOOP client
>  - protocol v2: add server-side "bundle-uri" skeleton
> 
>  Bundle URIs part 4.
> 
>  Waiting for review.
>  Seems to break CI.
>  cf. https://github.com/git/git/actions/runs/3560918726
>  source: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>

Thanks for pointing this out. I'll be sure to fix the relevant
failures in linux-TEST-vars [1] before the next version.

[1] https://github.com/git/git/actions/runs/3560918726/jobs/5981349269#step:4:1854

Thanks,
-Stolee
