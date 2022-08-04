Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D1FC19F2B
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiHDIkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHDIkV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143597652
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 01:40:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so10504509pfk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/1Hv9Xyoj1YpMhezxDfHks6up+vbrfaKW/eXmYkI6oo=;
        b=JmOoP/7KBk6vLNuJpOr2098un2DEp7nwv9qJS/0Sb4IwSYYDBSN2ByCYY6M/jHA05l
         THDtk/a2pNQT57Owdct9vpizwUx8jANV/aBDnthCbI+ueqw0VqZlGUE7TIZoNuJPydRm
         j3u9/g3oXLPTrfAodxls06MOqZmAKIG7zkFY7igAuzLq6j3rB2pk2tR8mECbNebNaYZG
         rOAsqQetp2zSX16YG9D/6QBkYyPfBvAAbZXsEHUc/poDJHk0Chx34CJ7zLlz3IfmPl/K
         vY7b/cF3iKZqy23osPHuUpj6p/IYfgZ496INyNwhe8+plSqYh3fscRPBn8TTb2TbWcS5
         hKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/1Hv9Xyoj1YpMhezxDfHks6up+vbrfaKW/eXmYkI6oo=;
        b=UeTY94ZuUJtzKHZw19myxj6Y7qXVtFQt3crqEHpEUj+FqvZIfR+hJEnUz+iRFesq+5
         vARMz3H+hAQy4vhl8VjVGmwheGHlqriQspvSAd3guVqfWD+UZx3sqIkw2QnIxxqQfHe8
         AvAtwSObdjn7UhCJkd1fNCuMFDUWuLcLozhghp8YSv/aal6EfRi1bTHx2oRO7lxmN51K
         +HTIrYfszVlQ1BfgkKtgsEcMVqvSB7ga1wfHDyBX3J6BXySKnp1M8LgravoG6eeTYz2U
         n0uGgWp1jkyr+Tm1Wvxjcg5dNU2JcADChnAgnbrvQlrwXf/HhhrA7thl44q+rtE4hkJO
         1t3A==
X-Gm-Message-State: ACgBeo3C3MjM6joNi9x0tbXXdkKSo1Lp2sZir9evcmhF+1bLvRbijYJz
        vH1pj9EWg5qp5AfIwMFstJwnR14ZDyI=
X-Google-Smtp-Source: AA6agR6UDJfRV6/PhbiA+YjbrEvO/NscALa8Tc+OvECF3GTwmYv8aPT4lMA2v9TSzOcz3eOqAUQ9oA==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr783386pgw.599.1659602419111;
        Thu, 04 Aug 2022 01:40:19 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0016be14a776asm236653ple.286.2022.08.04.01.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:18 -0700 (PDT)
Message-ID: <1fb0b736-280f-01bf-bb7c-48e8c9b060cb@gmail.com>
Date:   Thu, 4 Aug 2022 16:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 6/7] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
 <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2022 2:14 AM, Derrick Stolee wrote:
 >> +                if ((mode & INDEX) && is_empty_dir(src_dir))
 >> +                    rmdir_or_warn(src_dir);
 >
 > This is an interesting cleanup of the first-level directory. Should it be
 > recursive and clean up an entire chain of paths?

Indeed. I'm planning to use an array to record the possible `src_dir`,
i.e. WORKING_DIRECTORYs in `git-mv`, and use a loop to cleanup the
empty directories recursively.

--
Thanks,
Shaoxuan
