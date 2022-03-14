Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95943C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiCNQb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbiCNQb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650313CC6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:30:18 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id eq14so12936781qvb.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G68g9q738W7UNkCNBIdVN3vN+2YSuyySnIFxSA4FDrQ=;
        b=b7KLUUkWNalIh83H10VawGvmi60uML5Juyp51S5CTx+S331KjTGmkO/UxkHoMbRM/2
         qBytm/ebyMc2YqBOKhbZniWvcegXkBaLZO8DsEACZW37pLA/+zj23IQGOgrldGPEFB7t
         k5IF1Hz4UwLQw2GBC9256/WBsu3eOtl8fSs/I/PDYEK7Fz1P5/tSZUzCRDUs/zzC8GE2
         Aw5VBkA7YWk6qiAz4CDaEBtbwYKEpAyQef5up1p0UxrRd5X9Khj+pDHt4IRwum5J1yOA
         Z4MEsWyf/1GpmgZYgfDnjjwt4rBv9axY39KVb+BVQPIQWKmKaKIvY0k6/T1ZPbC4qEpc
         k/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G68g9q738W7UNkCNBIdVN3vN+2YSuyySnIFxSA4FDrQ=;
        b=ZTZmbeqVd9TZGFgLCtsVOJa3yrhgfAdp7h7LX+Km1je6ZkkJgMCojXB7nG0KOb4LIA
         8hfMbcy6mZIw8ZtYOxZFT0DZQH81HLCia4W+KKTUVKW9/7Bmerdg5U6VyP4Y7WTVwodN
         Y47bi29bmhl+hEEeytuTS2MiZRDpewbiT8dKPXX9VuLXN37nmJsTuyfKE0ndmhmlaycq
         It9eJJjr/TZG+HEWvaRktNPJzCnIWWtsFY3B0/DNBRHqjx7QA3qY2SaYOZcKWpzapt44
         cyuRKzZTTFBC9pMewNUw5a/iYxdJ/dCkcXvxtX7hOMs2kxbbOqa8EynpxRYoQimRLizi
         gZgQ==
X-Gm-Message-State: AOAM533JqJMFVK9/VeTLPVIim6aabtk8SM2ojVejdG8Iwi096eiAZm4s
        kVjhcrmKR0QTayFIWRYUzz83
X-Google-Smtp-Source: ABdhPJwYPtcln3HBmuZPJ85tOG4oJD6LfD4YAIcTJpBrT5+HYrkGDKS/sBIa0dlFQ2mqKEzib+NfUw==
X-Received: by 2002:ad4:53c5:0:b0:42c:c4d4:65d with SMTP id k5-20020ad453c5000000b0042cc4d4065dmr18036145qvv.98.1647275417565;
        Mon, 14 Mar 2022 09:30:17 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p6-20020a05622a00c600b002e1cb5b9b82sm4812471qtw.43.2022.03.14.09.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 09:30:17 -0700 (PDT)
Message-ID: <c041cf9d-729d-73bd-1ca8-e15c570eb031@github.com>
Date:   Mon, 14 Mar 2022 12:30:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/5] Allow 'reset --quiet' to refresh the index, use
 'reset --quiet' in 'stash'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 12:10 PM, Victoria Dye via GitGitGadget wrote:
 
> Changes since V1
> ================
> 
>  * Update cover letter title
>  * Squash 't7102' test fixes from patch 5 into patch 2
>  * Refactor 't7102' tests to properly use inline config settings

Thanks. This version answers all of my concerns and looks ready
to go from my perspective.

Thanks,
-Stolee
