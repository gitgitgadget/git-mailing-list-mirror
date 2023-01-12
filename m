Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E1C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjALROK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjALRNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:13:35 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57187DE35
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:49:13 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id l185so5812876vke.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsXCpg3TvUq6oLGbYbRSf9axWkeLdu5WuemGgdCVPcc=;
        b=E8TJjWrmxzkqfuzJaXdpNiAmzHsl7hMXbPMvuF4Gy+XyYABBmp4+kFDgrPQ5NGdhyZ
         C4d2CMcg7VwUibz2WK+bDB0VpTBudns+iJGAWOPG3Fly+3frnP/hfyTvMC4GoWoUdSon
         laojqv7HvNCO4oTxr3n+a3w4QJjlGO6vwtXYGOo13QHL71wBI9Ixo1W018Z+inLw3wxC
         +oGJo/8Zr1L3v/96hx0noiWhjkwmWJapb8gZL3r9FMywQn1u9rHghL5VtDHrIuQKsXmt
         Ov5Wgwhfl40lplofa90dwVwlH0lI/PTpWxjvY0Q7amgREtF7Kxm1r7KDXe4PT8ee68iG
         xWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsXCpg3TvUq6oLGbYbRSf9axWkeLdu5WuemGgdCVPcc=;
        b=OZN+FghGPtFrNfGT9ZME1/AAH1paFvEVGwqBhCH6hjGzly4VjDOIRAwocAj2Z6bwkw
         7z2q8MtT//8tN5nQd6hW7Z5W7njIuo8bCrisSltz9IEPoISOlq8XrDYYATWlhTjl+uU6
         +2R3gBZ1KXOv8CuhWI5fm6idFWywqhMiDOUXp6wBsFUcKl38ckHGWJkEGYZNBNlxiRZ8
         2nVpMVHIhOx2Y8Q+jcNWE1SgdmYEaD1yQh27crvn2qaLVFx7P4lA/uQvf80oYxyKa7zZ
         TUIbYcFW/A/OtvWEBkCZAHuMYCmZjKEqc7KESbWLCCAzS7hYE3xm4NX4c3nikXxx7GrQ
         mFVw==
X-Gm-Message-State: AFqh2koLSSrLSzaW2ndDJxkkBf3/0IoJpRmAYHy08EaSjkUANM01XppO
        ReDM5Pyr5+xWDhlKGyuWMnP7EBGHSTzZpig=
X-Google-Smtp-Source: AMrXdXuO/ouRBqmMkgkDSppKMfWYFSjl2WVVdf7l7xGX6o4VGyQloSHzhOW/VaSSR0DQ04TQqBgKUQ==
X-Received: by 2002:a1f:a90e:0:b0:3d5:475f:94c with SMTP id s14-20020a1fa90e000000b003d5475f094cmr34642295vke.14.1673542059050;
        Thu, 12 Jan 2023 08:47:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm11227174qki.32.2023.01.12.08.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:47:38 -0800 (PST)
Message-ID: <ee711878-87d7-dc94-9913-681cbd6b67a5@github.com>
Date:   Thu, 12 Jan 2023 11:47:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/6] cache API: add a "INDEX_STATE_INIT"
 macro/function, add release_index()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <patch-v2-5.6-ae256efe94a-20230112T124842Z-avarab@gmail.com>
 <270ef93c-cfdc-d119-5740-f704d7f2a029@github.com>
 <230112.86zganzpwk.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230112.86zganzpwk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2023 11:19 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jan 12 2023, Derrick Stolee wrote:
>> It's interesting that 'struct index_state' has an 'initialized'
>> member that we aren't setting in index_state_init(). Perhaps it's
>> only being used in special cases like this, and means something
>> more specific than "index_state_init() was run"? Or maybe we
>> could add it to INDEX_STATE_INIT and drop this line?
> 
> It's unrelated, and doing that would be a bug. It's a bit unfortunately
> named, a better name might be "read_index_data" or something.
> 
> It was added in 913e0e99b6a (unpack_trees(): protect the handcrafted
> in-core index from read_cache(), 2008-08-23), which shows the use-case,
> i.e. it's for avoiding re-reading the index file itself (or in that
> case, to trust our hand-crafted faked-up version of it).
> 
> I opted not to mention it in the commit message, after being
> sufficiently convinced that it was unrelated, which was probably a
> mistake :)
> 
> Just as a sanity check, we do have really good test coverage of the
> difference, at least 1/2 of the tests I bothered to wait for failed when
> I tried this on top:
> 
> diff --git a/cache.h b/cache.h
> index 4bf14e0bd94..1f8e5f4e823 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -371,6 +371,7 @@ struct index_state {
>   * "r" argument to index_state_init() in that case.
>   */
>  #define INDEX_STATE_INIT(r) { \
> +	.initialized = 1, \
>  	.repo = (r), \

Thanks for the extra info. The patch is clearly correct with that
information.

Thanks,
-Stolee
