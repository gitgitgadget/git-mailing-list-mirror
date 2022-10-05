Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9868C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 16:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJEQtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJEQtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 12:49:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AD7EFC6
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 09:49:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f193so15750116pgc.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rhb/MpodENnDbtDIse6EOm3EfttMkW+JLUd/P6PjuWM=;
        b=QX3sqG/PuEYIKDDJF/Xe1emxr03kYEEVHi0dDRGJCv6c4ZaMqJseNJYetUYYw0ufWw
         ythFTkkTegWbs3IMrvLz3PIWWxwbJzeXxAMuIdoaUmXVJW+U4NJOQifLb7pnH9MC4hF2
         Ct5WPl0n5/4YhJVAJ2T858p1bc09SQJ+jrNSg9ja0lnvZevcqZvlVipWcKFcdazHUTRX
         2eHSA9+1BTugNCny/n7HjqdkyFqNKDugcCqV1wQ2/CQUmuytPEPdt+UgnHSPy6/C1KIF
         1MBeoeFjJTg7M3Xt+9tXde07YUDUBkZRXNEiN7eIbE87zm/CCFnGhMNnaEjBW/Uac5sD
         uJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rhb/MpodENnDbtDIse6EOm3EfttMkW+JLUd/P6PjuWM=;
        b=ZaaSH6rSpJpEGU5AdXlG7W8bP32oVahJa3vfw6xntcDXb1pMev16AhaAmU8KtK6lG3
         2ca7crOKum2j4+T+Y8zcpOxQlXVT/PCiEGLyFmZsO4FiXsXA/KRVmCEec1QecHdittWA
         Cih5bmAAIuLH5xxCn55iqaxqU2KwnuYphSLEMWk/Px7P+Kk7gW+8aXzYOJj8zH2qVY4l
         iNF6kdvc0iuiUfryWjA0gdEGoZfU/VpECodHM1MW2/u80NxFQAvVa9JRShSAIhaDbS7w
         +RWSCmDik5bMPYSGRMxKgKeqXxyLvd+V15xGQe2UVcGn2LxRgnUV2Yf5yFt/a7hPN6aY
         iOcw==
X-Gm-Message-State: ACrzQf2CbogQdqQO5xNd9Q0SZlG6hZ7jI6LC/HolL+W6pz3/ucYvk7t4
        I3zE/Pslw9xp0hvYL9OBgNY=
X-Google-Smtp-Source: AMsMyM4iktjfPrj/nkYzAYoyQudjXu6vH3L52VMAa9818oJ20ClVuQjnQe3Bs2c7U7sv2LgtXdAzWg==
X-Received: by 2002:a05:6a02:30e:b0:451:c1e1:375a with SMTP id bn14-20020a056a02030e00b00451c1e1375amr626146pgb.474.1664988556934;
        Wed, 05 Oct 2022 09:49:16 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b0017b5e1f486asm10657714pld.211.2022.10.05.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:49:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/6] sequencer: avoid empty lines after 'update-ref'
 instructions
References: <20220930140948.80367-1-szeder.dev@gmail.com>
        <20220930140948.80367-5-szeder.dev@gmail.com>
        <fc887b02-191e-912a-bd15-1dc882ddf9dc@github.com>
Date:   Wed, 05 Oct 2022 09:49:16 -0700
In-Reply-To: <fc887b02-191e-912a-bd15-1dc882ddf9dc@github.com> (Derrick
        Stolee's message of "Fri, 30 Sep 2022 13:18:30 -0400")
Message-ID: <xmqqsfk2qkqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>   pick 29a79f8 two
>>   pick 74bf293 three
>>   # Ref refs/heads/branch3 checked out at '/tmp/test/WT'
>> 
>>   update-ref refs/heads/branch2
>> 
>>   update-ref refs/heads/branch1
>> 
>>   pick 5f59b82 four
>> 
>> Eliminate those empty lines.
>
> After this change, I think the end result is this:
>
>   pick 29a79f8 two
>   pick 74bf293 three
>   # Ref refs/heads/branch3 checked out at '/tmp/test/WT'
>   update-ref refs/heads/branch2
>   update-ref refs/heads/branch1
>   pick 5f59b82 four
>
> Specifically, there is no whitespace break between the last
> 'update-ref' command and the next 'pick' command. Since the
> 'update-ref' commands likely correspond to chunks of changes,
> it would be nice to still have that whitespace remain. I
> agree that the whitespace between the comments and previous
> 'update-ref' commands is wasteful, but I'd rather leave the
> wasteful (and usually rare) whitespace than lose the helpful
> whitespace.
>
> There is precedent for this kind of whitespace when using
> '--rebase-merges'.
>
> If you can find a nice way to add a line of whitespace between
> these lines and the next instruction type, then I fully
> support this change.

Sounds like it is sensible to omit this step for now from this
series.  Thanks.
