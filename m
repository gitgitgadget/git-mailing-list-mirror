Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2651F404
	for <e@80x24.org>; Thu,  1 Mar 2018 12:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030348AbeCAMfe (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 07:35:34 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44622 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030328AbeCAMfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 07:35:32 -0500
Received: by mail-qt0-f193.google.com with SMTP id g60so7234265qtd.11
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 04:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fLzKb0F+niTwIJZslXpWg4zasPGi7hhZ9foLiGteW/Q=;
        b=HIyMKkt2uQaOQyW4L5682LUeJSMHBTLYRjF3NNwqfn2IbCh7E0DSLlMD61d8tC93fd
         6KY6bFFyodsCLGeWUtPy/A0TF+3RPI0F22sXMvXLOcy0OIhCy37nFOwaew1pEKhI5QdR
         +CGYJ+xK4SXoaPQrpmZJzQSHI7N+yJhn6p/rhNQDgbWbeKSUUXNdjxYMAH5rLKH/9gyF
         y1PT33HINPP0eheqcmMMEfprVVrzlw30MQ6c0WCmpOvZeDn7DCFSg0enLefBI9d+MnRZ
         XSNbK6eWKfIBA8TKU0gA7L/7nQBXQsXQiY2O1G5LLoEJEKc3sDSup6/0CfxsFsy0md2C
         GT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fLzKb0F+niTwIJZslXpWg4zasPGi7hhZ9foLiGteW/Q=;
        b=JoXwy9HtDoupMz5tpy2PLOp9Z0FRIZZnY+GYdB/4kP+OprX1U7QXAYuRTN1TTUlL7I
         VUiBwBuNNjZVdVsWi6Q2a3pVgJ2QilRf9kRMYOsx1yAwyCSCvQPyCl5NNa7+YK6ZFpT4
         uPYYVr5128p5HBnjzVB4fNLEr4XiS2CvwKohlN901pR3UVHN+hjRQUiRq4x7lmIxcRb7
         4qUQAqYSw4d8keJjQzFJWW//AJWwEeNQvZ0s4ThlQ1AJ0SGM18l2o26SFo+uPp55LNdi
         FCa2UwxZVHHCySjq/FwTK5r5M+FWqM2Z29j0OIlMa5dS0it8ACPyfd+sss3VdNUv3aH3
         TrZg==
X-Gm-Message-State: AElRT7FMVAArI2PJuyaMApolph2yxqcp2OCpU54WmoqHmisc/uiFEbAD
        swJS36pXavjt2ru/8+y+cv8=
X-Google-Smtp-Source: AG47ELsZ7ZZsmoVn7tn07TXCCCPDsEpCEor4aOJvpzE7PkVuTavjqDxpVN8LaRSXZMHxh0hNI+JlDQ==
X-Received: by 10.200.18.67 with SMTP id g3mr2754031qtj.82.1519907732049;
        Thu, 01 Mar 2018 04:35:32 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e3sm2514380qkm.41.2018.03.01.04.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 04:35:30 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, bmwill@google.com, avarab@gmail.com
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180208103356.GA30524@sigill.intra.peff.net>
 <xmqqk1uwkdp4.fsf@gitster-ct.c.googlers.com>
 <20180301074245.GF31079@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a43a4408-6889-772a-58bf-c1b2feb7cf51@gmail.com>
Date:   Thu, 1 Mar 2018 07:35:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301074245.GF31079@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/1/2018 2:42 AM, Jeff King wrote:
> On Wed, Feb 28, 2018 at 01:27:03PM -0800, Junio C Hamano wrote:
> 
>> Somehow this topic has been hanging without getting further
>> attention for too long.  It's time to wrap it up and moving it
>> forward.  How about this?
>>
>> -- >8 --
>> From: Junio C Hamano <gitster@pobox.com>
>> Date: Wed, 28 Feb 2018 13:21:09 -0800
>> Subject: [PATCH] untracked cache: use git_env_bool() not getenv() for customization
>> [...]
> 
> This looks good to me. Thanks for tying up the loose end.
> 
> -Peff
> 

Looks good to me as well.  Thanks for fixing the environment variables.

I'm having send-email issues so hope this one gets through.  Please 
ignore my [PATCH V2] if it ever makes it through.

Ben
