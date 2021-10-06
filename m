Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1A2C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AD061163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhJFUnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbhJFUnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:43:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F21C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:41:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so4757347otx.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jaSCvWsKqdp6XdE8JVBDw4B2p7YXJ5RdzmYvCJI2W9Q=;
        b=fXgT7rK6RkwwpTyAFiKqWywDgQTBj6ynAyI4cBQ9mP7kSX6DUeXEvnfCypPBiauOVu
         l2XbIGf/TpLgoVdaImvrY9BKcMXH+e7ID+bS108lkDDKGqDaLuglvYU+877rGbI5Nsf7
         deJmEqvldSnfcFJLc7cQCW0zW/JJROOL+fcVWVrUcJW6Gp0g/yZmE74J1pDj8F4o8Yqf
         Ue1/EbPVW/YRmO+mMMUz9pz5zwz9G3gVaZwXstCO8SJhmi2mmI/v4a4eef7ViiB8G8yB
         AQ9875sPm3pf4gOGgIZhH5joc2zw+MHLiXK1Fs/AzRCtDrrzihT0JuU/n7qpnXa+0F6X
         vzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jaSCvWsKqdp6XdE8JVBDw4B2p7YXJ5RdzmYvCJI2W9Q=;
        b=flfXitXKXrE4AHmtAJksqDvOph5r6UfzZ6xQxaxu9Sd/2wQnj4bclDohA+fgqmzzdl
         /+fCC0hvIpz2uGaCGOO+Kc05H8JbVKS0AhQvRNTAf4Wmt8Lu99OffIVi8+pX75W0dJQq
         Aj0O1pAGlhP9AVwxOR53AbEPoLg7Xu86z1O80mMa8eQg5G+Qj1sbeCn7i6Lpeon00Y4m
         rBUeDUFyUgL8dafM+XqP2WShSaPsR+pUX+qV95/jDlhhVAgVnIHe7/v3ezSZqSei2i9a
         O41wfB1+waMXbAop0OWX84DwviA/HtUPAXMaD76JD31zttLJMEMhNIF5PFkN0+zDxOtn
         X2wA==
X-Gm-Message-State: AOAM532VXqmoyMUmFA0uqFNO6rWH2uG2oY6eB3E68Dsq/1IdshsnZS99
        r0KrW3PETDWJKPvzKu8V1u4=
X-Google-Smtp-Source: ABdhPJxaZZQzoFVxgir+UKQIa6GMxILkhCjFOq8ekpg7OilwMr3GwH3GQUVDwzo8YCE6U4GWcXkL5Q==
X-Received: by 2002:a9d:4c8:: with SMTP id 66mr302927otm.113.1633552890822;
        Wed, 06 Oct 2021 13:41:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a5f2:2ad3:7396:8f96? ([2600:1700:e72:80a0:a5f2:2ad3:7396:8f96])
        by smtp.gmail.com with ESMTPSA id z83sm4333581oiz.41.2021.10.06.13.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:41:30 -0700 (PDT)
Message-ID: <1139fb26-5b93-0181-f908-6f9d7449bc62@gmail.com>
Date:   Wed, 6 Oct 2021 16:41:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/5] cat-file replace handling and optimization
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2021 4:29 PM, Jeff King wrote:
> This started as an optimization to have cat-file use the pack/offset
> info it gets during --batch-all-objects to avoid extra object lookups.
> And that does happen in the final patch.
> 
> But there was an interesting interaction with replace refs there, which
> led me to patch 3.
> 
> The other patches are relevant prep/cleanup.
> 
>   [1/5]: t1006: clean up broken objects
>   [2/5]: cat-file: mention --unordered along with --batch-all-objects
>   [3/5]: cat-file: disable refs/replace with --batch-all-objects
>   [4/5]: cat-file: split ordered/unordered batch-all-objects callbacks
>   [5/5]: cat-file: use packed_object_info() for --batch-all-objects

I took a close read through this series and it was easy to understand.

LGTM. Nice ~2x speedup in patch 5.

Thanks,
-Stolee
