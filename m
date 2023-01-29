Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7DC61D97
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 13:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjA2NhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 08:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjA2NhM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 08:37:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D471C5B1
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 05:37:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m2so24569551ejb.8
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6R2YdXdaeF0vnEKXsql9LxrHByy+DxfeDi0t4Wrrz8=;
        b=A3RDtgQvm6QESauspkOESqfrXvfCT8vVTnfF1gdUZaui70/0u68Hs2TWDrOoH4lCbF
         CMTsAJfSVgv/3NY0bfBt8rb1llqVgMOfc4EcyFUJVJ70FuJ8xDip4Rf39z1JzlViY1rk
         tGTb7Rm+DovxdY03iVF/N9uqiKyc98qU8aLZdJZ+FdZc9h4h6r8EGoklaJEMtkHjUq24
         g/zUTxg7ZAwrC6Z55450XjEHx40NF/pInS1iS4Pe970bf/ldiXey1bau6HsS3INIZ1d4
         roBCtsi1fgRXFNMx+CaiaxPCZiPtVqdvvYp279bU0i+GfDo1hXoTWH4SKHcyYhW/YU73
         lILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6R2YdXdaeF0vnEKXsql9LxrHByy+DxfeDi0t4Wrrz8=;
        b=UKCXKxwlrgjYMl4Bbrv/V/aof13geaFj1TYg+poy8+ESReKxcna2O+d7Ao3EdTMQwW
         BI+9A1VF0hIFv/6zwZqT5f6NT72qRPjVO91EKLSqU3hPbmOJPLBqKTasN5VTTbf6dLGt
         zGAYkyjlOVTO0ZXc0/TMNqpUGjrUW74SOPHSLVpQZP1ekVNiC9q5YBtnbwE/ZOsKts6d
         I7u4dZ92MC5WobKInq21/f9MyrB4iMCGZ76nbyG8dCGzKGZNcbL8KKPsEYlulpQiekIe
         S855cNwENqMyYbi7nyzPbuLRJOoXK9sZibRe3/3LF6TXmQljFpjVk4ir1yfpBMY7RbTO
         iYjw==
X-Gm-Message-State: AFqh2kpVg2ILnUEgKhBbV99ExVOh08pgYmPpB3lcMoL9U/KitfpxP8r/
        EL4fLvR5Qxak8d2S3+qnI6NclA==
X-Google-Smtp-Source: AMrXdXvNeNXSpg4y4RCbaGwgdM+EwzSlWrfsBxeh4l20omUzG0p2PNKKaspsAIsNmp7Zw5PHtjrJ6g==
X-Received: by 2002:a17:906:4351:b0:84d:141f:6784 with SMTP id z17-20020a170906435100b0084d141f6784mr43003778ejm.29.1674999430149;
        Sun, 29 Jan 2023 05:37:10 -0800 (PST)
Received: from ?IPV6:2003:f6:af40:8200:19e:ccc3:be2a:f498? (p200300f6af408200019eccc3be2af498.dip0.t-ipconnect.de. [2003:f6:af40:8200:19e:ccc3:be2a:f498])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b00877df3eea5fsm5344768ejc.163.2023.01.29.05.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 05:37:09 -0800 (PST)
Message-ID: <da549056-f6ab-aa71-a0fd-bf55ef6fd6b9@grsecurity.net>
Date:   Sun, 29 Jan 2023 14:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g> <xmqqtu0b95oy.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqtu0b95oy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.01.23 19:46, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> What am I missing?
>>
>> Note that I've seen and recently re-read the discussion that leads to
>> https://lore.kernel.org/git/f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net/
>>
>> I suspect that this auto-probe is related to solving "the user
>> thinks JIT is in use but because of failing JIT the user's pattern
>> is getting horrible performance" somehow.  But I do not think a hard
>> failure is a good approach to help users in such a situation.
> 
> I guess what I am saying is that the previous one that has been
> queued on 'seen' may be better.  It should cover your original
> "SELinux and other mechanisms can render JIT unusable because they
> do not allow dynamic generation of code" use case.

It clearly does cover my use case but it has a bad impact on the runtime
of pathological patterns. But if you think that's not an issue, I'll
update the changelog of v1 accordingly and resent it.

Thanks,
Mathias
