Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01BCCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiF1Qug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiF1Qpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 12:45:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D915A2AE8
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:43:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e131so17898257oif.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=SERiBxVec5ToMyeN7nf2NRLzDNzC6KT8PsU7ofT8BkU=;
        b=ipP83z3TlppnF4q0mgab6AjUAFhCcGw1zCwEDNuSkeTlsK7m8NfbEDNhrInQRZ6S0w
         ebFVJOyfud9sHnRnQHtvhN8KhnNi5DINmoNQKMnz/KbV5ogxy4d+b5vUXTj7FiJTdy9i
         DGDF0g3MHBxV+lQzuBd66YpmAMvRm5PrC8XkhWbBeKqdxt6l0/2/7tbbqaQzxxkgfsqE
         yJoXqcuS68TV/iRPWeb2Qz0tnokphoRbpT5W234vOct1PPIU4+JbRoy6XciMyZzGc4DV
         pGPMjJsENK6i+wgmVaD0yndxn/BUrC9ZCvg1XlE7DejOw/Ux4uuOs4RsGOAJvKjTNwrN
         CStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=SERiBxVec5ToMyeN7nf2NRLzDNzC6KT8PsU7ofT8BkU=;
        b=hbo70d5+oG4vUeX/lAbmCAaopKuRvIEqOQS28hcfPdIt4fA23bSIT1b9K+VdeLvLvp
         a2090QZ0o4zVFae3Khq+lJ1Ywxcg0xofj9bwEBplDxMY+Wm6RFoQvuGIJ7Q11AGvF3vg
         yfCmX1y1JGZGX7D1J5qQwixfmCnKyO6B5SGs5/1XddxWiCC/nqQe5TunvcTPTKr1ZXih
         KSO4SHrU7sxkH97ZIVOUREfzWClz9QOvVDU9E1H381lqI9qUzbkOEBZyjpzydTCMGkTU
         RUT3jy+LPuAMn2NnnCTdBKwit1NuC4SDA3Pdn+kLINdCoa6NdVWtT2DQ9N6BJo9HnGPh
         pnsQ==
X-Gm-Message-State: AJIora8L46ygJ8XCBvXsvmNmnmtSH7sdgdetK1At4jvHocAEnfAJ9rjX
        MHq9zg9thQ0pBKVFmOwGimKsAAK81I9Jog==
X-Google-Smtp-Source: AGRyM1sf6qG61ORtOAWjOI9HkruXDqXdrYOe8f0Fu3aom906jHaSm89vX7A30/5wBNUMK5YruBY7QA==
X-Received: by 2002:a05:6808:f04:b0:334:379d:ae03 with SMTP id m4-20020a0568080f0400b00334379dae03mr373072oiw.24.1656434627148;
        Tue, 28 Jun 2022 09:43:47 -0700 (PDT)
Received: from ?IPV6:2804:d51:495a:8100:45f7:7064:6998:d39? ([2804:d51:495a:8100:45f7:7064:6998:d39])
        by smtp.gmail.com with ESMTPSA id f26-20020a4ada5a000000b004255ed1b6d9sm7834347oou.27.2022.06.28.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 09:43:46 -0700 (PDT)
Message-ID: <671b375c-66e5-0164-3625-4ccfa57ece95@gmail.com>
Date:   Tue, 28 Jun 2022 13:43:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: Unable to use security key to commit signing using SSH keypair
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
References: <97adcd90-b4d3-1114-205b-3445dd48b497@gmail.com>
 <20220628162342.ootjobbjtxg7b7ay@fs>
Content-Language: en-US
From:   Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <20220628162342.ootjobbjtxg7b7ay@fs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 13:23, Fabian Stelzer wrote:
> On 27.06.2022 21:09, Marcos Alano wrote:
>> Hello fellows!
>>
>> I'm able to sign commits using SSH keypair, but the keypair must be 
>> located in a file. If I try to use a SSH keypair in a security key 
>> (like an YubiKey) I get an error. I used this commands to do the test:
>> ```
>> ssh-keygen -t ed25519-sk -f ~/.ssh/id_ed25519_sk
>> git config --global gpg.format ssh
>> git config --global user.signingkey "$(cat ~/.ssh/id_ed25519_sk.pub)"
> 
> Did you try just putting the public keys path into user.signingkey?
> Literal keys would need to be prefixed with `key::`
> 
Thank you, worked like a charm. Every documentation I read told me to 
use the plain public key, without the path or the prefix you indicated. 
And worked well with a regular keypair.

Using the path and prefixing the public key worked.

You have my gratitude. :)

Stay well,
> git config --global user.signingkey ~/.ssh/id_ed25519_sk.pub
> should be just fine.
> 
> Also, the private key needs to be available in your ssh agent. If in 
> doubt you can check with a `ssh-add -L`.
> 
>> git commit -S --allow-empty --message="Testing"
>> ```
>>
>> Bnd I get this error:
>> ```
>> error: Couldn't load public key sk-ssh-ed25519@openssh.com <my key 
>> id>: No such file or directory?
>>
>> fatal: failed to write commit object
>> ```
>> I did the same thing with a plain ed25519 keypair and worked.
>>
>> Am I doing anything wrong or security keys aren't supported yet?
>>
>> Thank you for any help,
>> -- 
>> Marcos Alano

-- 
Marcos Alano

