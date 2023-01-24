Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03021C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 17:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjAXRaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjAXRaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 12:30:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39546149
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:30:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so19323031pjg.4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1N4Nbvf/imrbbsUoyEPO7tSeE+GlugG9Gzd82w0ilFE=;
        b=hQNEVZWvJ+Dzv9w4KhwI4g+cQkp+jJRb0xHT343bUX55tSvZn+UgRKTKA+2owxxenQ
         4WpAStN1yYiaBmhERV6QrVn2Ci7EYNBIOzmoA8gQPhR7xzGUIhgbVf74rmegIejQ+pNA
         17BzzIDzF3pO3CP1TJLSSZi1HqKc/6cVv6VQHxPCqpwXd8CtEu8FuZo2SYLHwTQbIk55
         oPeJXLYlwYc6qebM7DE+YVutt4Rew9r8tdvisz/v50dmKguhfgyZZO4pKwQ2us9JSbMF
         ooV2c/5W51XZlDmrjCRp6e9ovnoIavM4W5aH452gNwnqg8zY0oxwvKrnHifKVnFL+yG+
         SmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N4Nbvf/imrbbsUoyEPO7tSeE+GlugG9Gzd82w0ilFE=;
        b=dqI2dRqGhVieFi0+uztQmBdi5ZSVMc6XIESXE1pEO/mfYgSGwTttQsTd4sbaZrrK7D
         41VPFXm0JNyFrFJhQxGYYDS0vDzaL9hGU+B4j0a3Y/NGoD6Z/9XUQfqmpxjTVg9x4zz9
         y1oDiS/N23dcn1vIP4GHlG5v7JCO6hu/CiUeP/MTu/u0XdYdW4L/xFs/H4IGpgZvhtNK
         hY1optt/m6R+a9cafTfx/L3EETJHcAmtke47iLJ/nUwE7RQJXdR1V2aj9Ru9PTseNi7D
         EfwrW80sdSEzubk8WY9a6q6kZytNBsk4UFtYBFjd3AQmb9uF6o3Hi4ZC8tgvGWCTcyii
         UIoA==
X-Gm-Message-State: AFqh2kpshuMkiffexQ1dEpUWQr/kfKCzluFAI5d0B/26H1p6G+1cnhm6
        E5wLq742UvUh2F4MROct6fYJSfOocVIxMD0=
X-Google-Smtp-Source: AMrXdXsh7bN8QBPpSf6AGT+V/By6aImUfcSZeD7MrYzfLvP7OTwUVu1M0Rac/oL7NCnRsRkWenzrfg==
X-Received: by 2002:a17:903:2291:b0:194:ab28:3282 with SMTP id b17-20020a170903229100b00194ab283282mr40472771plh.5.1674581406198;
        Tue, 24 Jan 2023 09:30:06 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b00186acb14c4asm1938041pll.67.2023.01.24.09.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:30:05 -0800 (PST)
Message-ID: <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
Date:   Tue, 24 Jan 2023 09:30:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> Updates in v6
> =============
> 
>  * Clarify the change to make logging optional in the check_dead_children()
>    function during libification of daemon.c.
> 
>  * Fix missing pointer dereference bugs identified in libification of child
>    process handling functions for daemon.c.
> 
>  * Add doc comments to child process handling function declarations in the
>    daemon-utils.h header.
> 
>  * Align function parameter names with variable names at callsites for
>    libified daemon functions.
> 
>  * Re-split out the test-http-server test helper commits in to smaller
>    patches: error response handling, request parsing, http-backend
>    pass-through, simple authentication, arbitrary header support.
> 
>  * Call out auth configuration file format for test-http-server test helper
>    and supported options in commit messages, as well as a test to exercise
>    and demonstrate these options.
> 
>  * Permit auth.token and auth.challenge to appear in any order; create the
>    struct auth_module just-in-time as options for that scheme are read. This
>    simplifies the configuration authoring of the test-http-server test
>    helper.
> 
>  * Update tests to use auth.allowAnoymous in the patch that introduces the
>    new test helper option.
> 
>  * Drop the strvec_push_nodup() commit and update the implementation of HTTP
>    request header line folding to use xstrdup and strvec_pop and _pushf.
> 
>  * Use size_t instead of int in credential.c when iterating over the struct
>    strvec credential members. Also drop the not required const and cast from
>    the full_key definition and free.
> 
>  * Replace in-tree test-credential-helper-reply.sh test cred helper script
>    with the lib-credential-helper.sh reusable 'lib' test script and shell
>    functions to configure the helper behaviour.
> 
>  * Leverage sed over the while read $line loop in the test credential helper
>    script.
> 
> 
> Updates in v7
> =============
> 
>  * Address several whitespace and arg/param list alignment issues.
> 
>  * Rethink the test-http-helper worker-mode error and result enum to be more
>    simple and more informative to the nature of the error.
> 
>  * Use uintmax_t to store the Content-Length of a request in the helper
>    test-http-server. Maintain a bit flag to store if we received such a
>    header.
> 
>  * Return a "400 Bad Request" HTTP response if we fail to parse the request
>    in the test-http-server.
> 
>  * Add test case to cover request message parsing in test-http-server.
> 
>  * Use size_t and ALLOC_ARRAY over int and CALLOC_ARRAY respectively in
>    get_auth_module.
> 
>  * Correctly free the split strbufs created in the header parsing loop in
>    test-http-server.
> 
>  * Avoid needless comparison > 0 for unsigned types.
> 
>  * Always set optional outputs to NULL if not present in test helper config
>    value handling.
> 
>  * Remove an accidentally commented-out test cleanup line for one test case
>    in t5556.
I've re-read the patches in this version; all of my comments from v5 have
been addressed, and the additional updates w.r.t. other reviewer feedback
all look good as well. At this point, I think the series is ready for
'next'.

Thanks!

