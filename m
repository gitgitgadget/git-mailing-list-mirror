Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB49C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 16:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiL0Qkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiL0Qk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 11:40:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEDABE21
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:40:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o15so9658196wmr.4
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MT3l4k/SYmbWavQMHOD/PE6MF6wcDi9z3tBmoSh7vz8=;
        b=KThE0KUHlhY9diSW57vneDclg4bFTkV/8d5h3ZUHqUWFhpcegjDi8HrWANDdqDA/ml
         Cie4hIhos36okPVYQNOcPtyghNrt92e1jeIjEBgdhqSaUfnT8zG2Vzx68SsE5s7k/tqL
         xh63f0fToKybJgHryAPj1VpQpQj4eKlYmu0YaN0IT7SqxYoMF31nbRQz7NC4v+fNJrsK
         LakIJQ0br3HahDxSxZHgpxDBwX3ExnVht5/5eBSLeu1jSsAFjqnzn+j0OMvhj8LMKXjI
         69BBPm9sTk2JxQoRiPgqwpIl3GgIAQMIKZYBN9CYyvPXT3cjL5qOvfc4cUqwX9dJ62ki
         TEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MT3l4k/SYmbWavQMHOD/PE6MF6wcDi9z3tBmoSh7vz8=;
        b=AUZLL/063GL0IxA5Iau+3XS+7ixSLTLhBLY1x1WkxULX10Oe+JduLmWcnuJALkb3Vk
         iWe/Z+paW/LRconS7EJDsOvxgMaQT+3DDRK192yOftKnLMmAbM98hCMb0lGnIiZnkXfZ
         +VNrqbbUgWzFQWnxedwHX4JmbD5ag8YwRD+cNUwg6XYfNcHcnVFsvmoyhMZz4Yixs3E9
         8sLbW/uw3YSMslSlnK41ervH/B4tNoOm1pUT8TOR0/57cieCieYN/SLovzED85raoC10
         oEm4F0N3NAPCXb6IE/OSTjn/g+9o2pnUQYtHY11B0drLsqRRrCJ7YqC8tkWz/zltoY5n
         fdLg==
X-Gm-Message-State: AFqh2krXNE1suuKQiky1wEQX5BjDH0dGCmQsjXDMKOP4EYrOByjXooqB
        jsYck8zeqK98KW4IpjPwK2EVeUp/ohc=
X-Google-Smtp-Source: AMrXdXt9ksLBSoVTe8e9XNGEVqcktNnjex2AJwkhRkS9XW9oMFA84M9Le1waJ4/7ze8c8yi8I2EykA==
X-Received: by 2002:a05:600c:1c27:b0:3cf:a83c:184a with SMTP id j39-20020a05600c1c2700b003cfa83c184amr15897965wms.24.1672159227347;
        Tue, 27 Dec 2022 08:40:27 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b003d6b71c0c92sm30500386wmq.45.2022.12.27.08.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:40:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d9053dbe-a9b4-3d85-626d-0f1633058646@dunelm.org.uk>
Date:   Tue, 27 Dec 2022 16:40:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/6] t/lib-patch-mode.sh: fix ignored exit codes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
Content-Language: en-US
In-Reply-To: <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/12/2022 10:19, Ævar Arnfjörð Bjarmason wrote:
> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
> 2009-08-13) to use &&-chaining.
> 
> This avoids losing both the exit code of a "git" and the "cat"
> processes.
> 
> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
> discovered it while looking at leaks in related code.
> [...] 
>   # verify_saved_state <path>
> @@ -46,5 +50,6 @@ save_head () {
>   }
>   
>   verify_saved_head () {
> -	test "$(cat _head)" = "$(git rev-parse HEAD)"
> +	git rev-parse HEAD >actual &&
> +	test_cmp _head actual

Aren't these two lines are re-implementing test_cmp_rev()?

Best Wishes

Phillip

