Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE2C19F2D
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 00:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiHJAbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 20:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJAbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 20:31:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2067170C
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 17:31:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so2207518pjz.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 17:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1cWbBMnYGvTu/poKXn8Ks0WaaikGVryt1dnpwH5crrA=;
        b=DTSMBit3zVGa4QGpHaccYxJwgrEYjU0yITcrV2zUidFCMT5W5zX1pwe+/njCfr75AW
         7L4pbc39HjkBML2ZCDcT79/B9XeLx2cae3ZfLWvau/+6mqeHmDCJqgYXrNP/jn3ktt6d
         G1hlVFcXWyPiD9LQeAbfMl19yOX4ldLWqMp/bnBTf2+flJHdV2j8liz7saMJgI+0i5RK
         p+tH2MZMmCWZWPAtonhBUNf0+SoBadXODYkI4S+ct+XdR+SWZabPdKP9RgkgHwUjVL69
         2G826hVNc+9erX0J+9qWkJyNUOsjEoUh3bIoeI/N84f2zvsZ4Q5L7nE7SoL6Msv660PF
         6IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1cWbBMnYGvTu/poKXn8Ks0WaaikGVryt1dnpwH5crrA=;
        b=6CExwXlfirvj/cm/GbAyzAVeM5yByZEt2wdEjL+Zp/4JR+a6LsoSsF2fJgRAWRehnY
         XLcYI8+6oWKkhKtG7LsdwGNs/eWiqVs5N43jv5W52ycz1rUW92dcqgfxIJfCemVWuuZC
         +F7LpQ63QVhxNlDqngtbMf7gx7QxIMkv+WJutZGFIGbjvcugOQQaG28MtTePDEDEeQyc
         ygCVgUu7kJPtqW6ABG2juvkNs11oCeAnyc/MD1jgcTPjR26UME91VvyhUV7DVQqcDj0Z
         xXtDO03Yk/IL+uqnn0mvQwZgkacvty0IeLQEYSbrZkPd4k9gp9NPQc3R5V1YHSHe4tMj
         o/ug==
X-Gm-Message-State: ACgBeo0O2liFYc5iY70kmEozVr986nl8Yb9T3NlBxC81okFfMOT6eQ5t
        kSzI6j9Z31nvQXe4MWmMZKo=
X-Google-Smtp-Source: AA6agR4FZXTtOwx+gJrQ+RX4xubnqPePNH2MjWRFeGoB2mm+R3nD51p8wdgRkFeUhmetZUUzMlc0Uw==
X-Received: by 2002:a17:902:db0f:b0:16f:24e4:15ff with SMTP id m15-20020a170902db0f00b0016f24e415ffmr25677342plx.10.1660091476506;
        Tue, 09 Aug 2022 17:31:16 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id k17-20020a634b51000000b0041dd4ea6242sm1257086pgl.63.2022.08.09.17.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 17:31:16 -0700 (PDT)
Message-ID: <5b093198-8dc0-6dcc-8a3b-6762b6dc11bf@gmail.com>
Date:   Wed, 10 Aug 2022 08:31:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
 <8a76428d-e236-88bc-ec67-356b4c6f67fa@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <8a76428d-e236-88bc-ec67-356b4c6f67fa@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2022 8:27 AM, Victoria Dye wrote:
 > Shaoxuan Yuan wrote:
 >> ## Changes since PATCH v1 ##
 >>
 >> 1. Move `ensure_not_expanded` test from the first patch to the last one.
 >>
 >> 2. Mention the parameter of `pathspec_needs_expanded_index()` is
 >>    changed to use `struct index_state`.
 >>
 >> 3. Modify `ensure_not_expanded` method to record Git commands' stderr
 >>    and stdout.
 >>
 >> 4. Add a test 'rm pathspec expands index when necessary' to test
 >>    the expected index expansion when different pathspec is supplied.
 >>
 >> 5. Modify p2000 test by resetting the index in each test loop, so the
 >>    index modification is properly tested. Update the perf stats using
 >>    the results from the modified test.
 >>
 >> ## PATCH v1 info ##
 >>
 >> Turn on sparse-index feature within `git-rm` command.
 >> Add necessary modifications and test them.
 >
 > Other than a completely optional recommendation on commit ordering 
[1], I didn't have any comments on any individual patches. This series 
looks good to me!
 >
 > [1] 
https://lore.kernel.org/git/2c0cb658-cd5a-420a-d313-6839149b9b40@github.com/

Thanks for reviewing! :)
I think I'll just leave the commit ordering as-is.

--
Thanks,
Shaoxuan



