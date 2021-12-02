Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbhLBN4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 08:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358376AbhLBN4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 08:56:37 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9FC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 05:53:15 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso8886992ood.13
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 05:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9myPECyG97iOdOHqqSOgfn6xCYOcmYtaxd1iPKaNczE=;
        b=i0utxcCcFYa3VfP59o4HTmvFmlkBuzTwKfvuT11Qq7AG6M+DqyhB0eDr8/n+NctSOW
         87ersCC9DfFeZmzMBiZFCRWb5f19U0hKDIO13TpyeyKFtulhchbCaFzri8UmUoORZ2RK
         bTUtiRG5VDIA7mUYL3IiRixPDXr3sRhMNvOgUkiL6zl2IVH6z0SX6+34JED7X3VfNX8o
         dea7s4Lm7Qtc2FEkw7xEKWqlyluaE8e45PatecmQpKwXPpxM39rfxXNBRsf7/jUNAsuc
         HHfWN/gdnQTWX7mtd76h6qok9f1X6ACHhLK0bUaiWVt1TjxxduD2faFLgluX1qiXlmlS
         5MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9myPECyG97iOdOHqqSOgfn6xCYOcmYtaxd1iPKaNczE=;
        b=lEY1yNQtI+wwg3nRhXiANiv97zK1WejJxZ1vX7fX1BjNZZB4A26FBNhRry4JTRLp06
         Q1XmBrHVUU1WfdJbxz6adRp6AjwEZF4XNMn631QcupC6vkWV9w6QwRgS7nSyIen8HTm/
         yYSp9hNqzB4C6SAxAMDXa1qB4IKRpxGJC52HcmFYaaM3v+pSAdqUOHFl2ROb0HFhklMa
         01NXfm4NqfYTNneA/iF1Dc36aD1xW8YgtP5C4/eQv4eBiDN0cVlp7YFrWuCnBSvPI8ub
         1d6I3pKBfqGBqNjT99LKPoKs7J82ROREco2+PkP1oxSMGwxFsA6c6mCQCr3qnk9ffXf4
         4DYQ==
X-Gm-Message-State: AOAM530JrJ8zuKiOpwh/cQZwCAzmrBTX1XgX3fbSJv8/sbNfyXCBR/Jy
        4zrjvBjFCE/DkdjY3F8fVwjoLOfr9/4=
X-Google-Smtp-Source: ABdhPJwM0bjIPcZnnQIY/r+wHDRMAO/wKxOyrTxIrWLJ9jx9Auslt86KHWm7ebZVPirAUgLdWDM7aQ==
X-Received: by 2002:a4a:88cc:: with SMTP id q12mr8874525ooh.29.1638453194305;
        Thu, 02 Dec 2021 05:53:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id bk41sm1452436oib.31.2021.12.02.05.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 05:53:13 -0800 (PST)
Message-ID: <993f83e8-cb53-cad2-8457-e8e94ac56ca2@gmail.com>
Date:   Thu, 2 Dec 2021 08:53:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-6-chiyutianyi@gmail.com>
 <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
 <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
 <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
 <CAO0brD2bGXwAJVrPSybbVNeSmQ1S85a_ykmceVKrg=pE3MfsnA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAO0brD2bGXwAJVrPSybbVNeSmQ1S85a_ykmceVKrg=pE3MfsnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/2021 2:33 AM, Han Xin wrote:
> On Wed, Dec 1, 2021 at 2:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>> These pack-files contain (mostly) small objects, no large blobs.
>> I know that's not the target of your efforts, but it would be
>> good to avoid a regression here.
>>
>> Thanks,
>> -Stolee
> 
> With your help, I did catch this performance problem, which was
> introduced in this patch:
> https://lore.kernel.org/git/20211122033220.32883-4-chiyutianyi@gmail.com/
> 
> This patch changes the original data reading ino to stream reading, but
> its problem is that even for the original reading of the whole object data,
> it still generates an additional git_deflate() and subsequent transfer.

I'm glad you found it!

> I will fix it in a follow-up patch.

Looking forward to it.

Thanks,
-Stolee

