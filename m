Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3076DC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEJWvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEJWvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:51:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C91BFB
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:51:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab032d9266so73559485ad.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759110; x=1686351110;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adD+DQVHpk/7+4NTd6NGQfOn+z4tqDJmK3QXFIpk8f0=;
        b=lPGkqMo963y7dC2lJQtX7RpnZpV9vQorUWtbI7g5Z2YBcBnStQNZv18MiLMedwyJ5R
         kksyWFW7P9Rhn3z1rjCBrxN2c5dDKYCRVWw2diXTq853Hwp4mpEvaVy+j4EFJwhfYMEE
         6CMGenxbH6kFkfuLxcMfHIXoGzq50KZt+ugvNu6JY8CC+Mjdq0xZOkmXdXiI2MlYqxvP
         cqa4wR7EoT4w7faV+PNKAN/6MYYJynG2Y+qLBwa3v8DYsgeRKGgEnQwuw2AyJZbnLfrs
         B6ia4wvJ62VrKhQ14iCCSTYhG5PajeeNncz07fzi/lNVi/c511cb/9fguUg4nmyRmBYc
         LD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759110; x=1686351110;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=adD+DQVHpk/7+4NTd6NGQfOn+z4tqDJmK3QXFIpk8f0=;
        b=Gmx776hSwt1tT9XvPBjRT7E8oVyr4ayyNOXUGeRImBdi+Hw7928IigTxW9NbyXhJJH
         qQHrSIq2Mh2R/UQ6qxt2Ye8Yj43snz18dbwK51e6YlkZ4p/HU5uqdSMFVUOt/YGX8Zsg
         /+Z6PEyYZ0Dxdn4qI55R2L8CF/6T1Y9ZCuwtPUKqim+C2EHAwyLcPxW+1DMcXsCErfuV
         qXZljCA+tB//901MGD/vEkKWUsHbjH3nH+tW1FuF45JTJbYnJ2EstExHBwVupiojKKCE
         tTWU0TiQ+M+lquj+MGaYgOl9we8jgnqpKnTPZVHvlkT1DiAKpnAdcTeesfUINkeKEy7E
         Vi0A==
X-Gm-Message-State: AC+VfDxJ38JUXGBmRPxAr55tQRzTapHI1iZTLePf+loqMNqq5D3GSqKw
        j/NFwaIflJKDGcbSCAkm5W8=
X-Google-Smtp-Source: ACHHUZ5Gs0PC0UsjwBbd0wtu4pP9YOiPIRnEg+p+XUuc7i/Jbg4XmQ7NGf15ZN9nF35hRpnI9vwKoQ==
X-Received: by 2002:a17:902:d34b:b0:19f:188c:3e34 with SMTP id l11-20020a170902d34b00b0019f188c3e34mr19877473plk.53.1683759110023;
        Wed, 10 May 2023 15:51:50 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902be0100b001a24cded097sm4311862pls.236.2023.05.10.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:51:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH v4 1/7] strbuf: clarify API boundary
References: <20230508165728.525603-1-calvinwan@google.com>
        <20230508165908.526247-1-calvinwan@google.com>
        <CAPig+cTQg7XzORPHeD79aHEi1ggOjTPw9X02VPgxcV9uoBOBxg@mail.gmail.com>
Date:   Wed, 10 May 2023 15:51:49 -0700
In-Reply-To: <CAPig+cTQg7XzORPHeD79aHEi1ggOjTPw9X02VPgxcV9uoBOBxg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 8 May 2023 13:22:15 -0400")
Message-ID: <xmqqr0rn241m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 8, 2023 at 1:05 PM Calvin Wan <calvinwan@google.com> wrote:
>> strbuf, as a generic and widely used structure across the codebase,
>> should be limited as a libary to only interact with primitives. Add
>
> s/libary/library/
>
>> documentation so future functions can be appropriately be placed. Older
>
> Too many "be"'s.
>
>> functions that do not follow this boundary should eventually be moved or
>> refactored.
>>
>> Signed-off-by: Calvin Wan <calvinwan@google.com>
>> ---
>> diff --git a/strbuf.h b/strbuf.h
>> @@ -5,7 +5,11 @@ struct string_list;
>>  /**
>>   * strbuf's are meant to be used with all the usual C string and memory
>> - * APIs. Given that the length of the buffer is known, it's often better to
>> + * APIs. The objects that this API interacts with in this file should be
>> + * limited to other primitives, however, there are older functions in here
>> + * that should eventually be moved out or refactored.
>> + *
>> + * Given that the length of the buffer is known, it's often better to
>>   * use the mem* functions than a str* one (memchr vs. strchr e.g.).
>>   * Though, one has to be careful about the fact that str* functions often
>>   * stop on NULs and that strbufs may have embedded NULs.
>
> The new text is administrative in nature, aimed at people who will be
> modifying strbuf itself. As such, it is unclear why it is being
> inserted into documentation aimed at _consumers_ of the strbuf API.
> Moreover, with it buried in existing API documentation like this, I
> fear that those at whom it is aimed will almost certainly overlook it.
>
> To increase the likelihood that the target audience will indeed read
> the new text, I'd suggest placing it in its own comment block very
> near the top of the file, possibly prefixed with a loud "NOTE FOR
> STRBUF DEVELOPERS" or some such. Further, as the new text is aimed at
> strbuf developers, not strbuf consumers, it would make more sense to
> use a plain /*...*/ comment block rather than a /**...*/ block.

All look good suggestions to make.

If there is nothing else outstanding, let's see a small and
hopefully final reroll so that the topic can be merged to 'next'
soonish.

Thanks.
