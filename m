Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5BC77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjEDPN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjEDPNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 11:13:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92202E1
        for <git@vger.kernel.org>; Thu,  4 May 2023 08:13:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f6461af24so388326a12.2
        for <git@vger.kernel.org>; Thu, 04 May 2023 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683213203; x=1685805203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwOVnDCIF22yIuT0Ly6f76beKK4US8FJnsY/uzIJOtg=;
        b=FvK95xou/byxGudAWvkwFdutqn3S1fNtwWVklKejGuE5tg5v6ix0dh9M4qOJM2/ACd
         zcEVVcHbz9wd1pWXh6CSNqwMNwUJ2C7NU2TZ57+MjPr0PR/BIIj4HyOGQ5aZvBFLGvJ3
         LpR1LT073oOOg/jNelN14fIxPEWEOTyYzhAOtrEa8URf94qMyGudNBoW7xWDSNAID33O
         G0rdY0/zICWPEcniXE6yoMYDxVyLM9qkb24YZSDTHXRReDUdtPtshxSFBvzAN9e1GkG8
         ygP/JF3+tnBX2aoMiicOoUgkfcbhC7NFB4MY6W9sDBBmk6JWVJ1F8uJDtRpqSoZoXHfm
         u6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213203; x=1685805203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PwOVnDCIF22yIuT0Ly6f76beKK4US8FJnsY/uzIJOtg=;
        b=bphIqUH0D7leoVHa1orI9kMTUnDS0dv7L1DM/TH6iiwk23PdP54L/Xp/dWQyY55YVm
         7s86SEPDhhVvA3qek6n3g6Ncy38CdTxJXqyTT9WMjIBR4I5kbDlfZL7gh95PF49IbcAR
         QyAvOJXMsWAO7nWZ8R+t7AT3s5PaOEo3UdkE9mrntjFhEFcqfB7NbWRFCpfHeXZ4J+tC
         mdOoWaaTF3h4HJG0AO8qOiZdy8SbBX9UefN2Edbzs+aYnAlVwI0TuolWTZz5t77OnWDn
         wA8KTUuSxQzxdwGQKkxkDLPHpFYmspd/05rlJ2HW/HGFNqdkLDOqPISu1lp2PYYwiASR
         8cdw==
X-Gm-Message-State: AC+VfDyTYZJ3MqsNl7dZFJp0pniypwNl/gEnK8zL4/QR9qEiof1GtC6P
        GIBYPDzTZyI3LGxDJUaXr20=
X-Google-Smtp-Source: ACHHUZ6uVi4D2VsnwslyeD74Zt3vbFISOlmmfJ9xKZIQT4P54itz3PC3JMMZZUJHGAZZCuSIYfPAkw==
X-Received: by 2002:a17:90a:3d02:b0:24e:4231:ec6b with SMTP id h2-20020a17090a3d0200b0024e4231ec6bmr2588176pjc.21.1683213202868;
        Thu, 04 May 2023 08:13:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i22-20020a635856000000b00502f4c62fd3sm21514464pgm.33.2023.05.04.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:13:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
References: <xmqqcz3ixsas.fsf@gitster.g>
        <20230504105526.1287-1-mirth.hickford@gmail.com>
Date:   Thu, 04 May 2023 08:13:22 -0700
In-Reply-To: <20230504105526.1287-1-mirth.hickford@gmail.com> (M. Hickford's
        message of "Thu, 4 May 2023 11:55:26 +0100")
Message-ID: <xmqqfs8cm8od.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

>> * mh/credential-oauth-refresh-token (2023-04-21) 1 commit
>>  - credential: new attribute oauth_refresh_token
>> 
>>  The credential subsystem learns to help OAuth framework.
>> 
>>  Needs Review.
>>  source: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
>
> Hi. Is Jeff's positive review [1] "correctly implements the intent
> ... sounds reasonable to me" sufficient to advance this patch to
> or towards 'next'?

Yeah, sure, I missed that thread, it seems.

Thanks.
