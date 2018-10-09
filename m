Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D9C1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJIWGp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 18:06:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44350 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIWGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 18:06:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id c56-v6so1868749qtd.11
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JWqRNXkS+YoYsXPR7H7ZIxhqMI+TKvdbqStqD4ZAvo=;
        b=QrVtyyYmapufaDTUpueTLdFTZWYJzBPnIRpr8rnT8bsSJKMGCigvw3UhoGNQvFH4OI
         5B43Lr7dexLIwDOUdz28hR4iyQWX/M6IxEfPn+dnoVXWhqmwXVqLjLIgSJ1mtjuCcgBu
         jFS5kH3wqfPpgg08NVXt7FnMfULgZmZcDaNPc4Zpdw1koWxfnYH8OanK5B0BZP7IjkKV
         97J/hRXPKi5/JIrYab7aJFooF62f1+e6wJwCd5UT5lp9x2zwqxCaXr/C/a6FrAm95pvT
         V2yCjBG3oV56gkrzYkYON1OF3hCvAVyECfQtttq2o6OtLaZC9SSCh2DLzPyDHhD5ekoP
         nL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JWqRNXkS+YoYsXPR7H7ZIxhqMI+TKvdbqStqD4ZAvo=;
        b=Bbza8T4Tx/uuNxHyhw6rO79uhW7w9P73FnIk92/VYsWuY3P1njZRi5IbGyjMFnKnKO
         Vropg0/o17Ld4aoEsgCNO2qgrl5waG3bT9XmKV9Q13Q9vfmZkDdYh900doI2MT+3SwHV
         herGfMqH/v7HJsetJ4kCopD15dIKZitFw5Mzn9FSRepyUX9Ou+TeA4fh05Y6CO3+6xni
         cqt1mXg7OP1qL7AUyM33MOkdOL7II83uNtj9FAtv2f9hg5wUn7+y1lUd+Gv4DvITnDZK
         RJYkY2vgAd32HYD4P3WnEEqdAlwcrjirEsV3vyvMHyMibQ5pFPPM9No1q8wSas8FvHoF
         5CBg==
X-Gm-Message-State: ABuFfogCEIiJpDoa/G1i3vRrLudAPvjItoNuGM9CF9Oy8RpitFx+1QZK
        JUQm7euK3CCmhwe1dBZx4pR4gt3rM3c=
X-Google-Smtp-Source: ACcGV62CKhwXfNhLutnUDU0OSpkY6uLi+EztcCIt0ZPTFrRJYF/FihuR5iI0+1dPkjYtqH3bl9MRdA==
X-Received: by 2002:ac8:71d4:: with SMTP id i20-v6mr12647261qtp.129.1539096566937;
        Tue, 09 Oct 2018 07:49:26 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id v31-v6sm11252911qtg.92.2018.10.09.07.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:49:26 -0700 (PDT)
Subject: Re: [PATCH] unpack-trees: allow missing CE_SKIP_WORKTREE objs
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <20181008214816.42856-1-jonathantanmy@google.com>
 <xmqqpnwjpivb.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <56cc6e57-d1e3-1182-4290-c8b6fa796534@gmail.com>
Date:   Tue, 9 Oct 2018 10:49:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqpnwjpivb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/9/2018 5:30 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> @@ -1635,6 +1635,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>   				o->result.cache_tree = cache_tree();
>>   			if (!cache_tree_fully_valid(o->result.cache_tree))
>>   				cache_tree_update(&o->result,
>> +						  WRITE_TREE_SKIP_WORKTREE_MISSING_OK |
>>   						  WRITE_TREE_SILENT |
>>   						  WRITE_TREE_REPAIR);
>>   		}
> 
> Hmmmm.  Should this be passing the bit unconditionally?  Shouldn't
> it be set only when we are doing lazy clone?  A non-lazy clone that
> merely uses sparse checkout has nowhere else to turn to if it loses
> a blob object that currently is not necessary to complete a checkout,
> unlike a repository with promisor.
> 

I agree.  I believe this logic should only be triggered when running in 
a partial clone repo. Otherwise, we're potentially changing the behavior 
of 'normal' repos unnecessarily.

