Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02665C4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 16:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiLKQbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 11:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKQbC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 11:31:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806CC746
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 08:31:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h10so9699575wrx.3
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+LKh1hv1hZrDXElwVEJnAqH0ASS1XwqKhuH4ESCHgI=;
        b=Y458TvuNXRkB81Y7z3VnU2nHJnKPCU0f/yXTWbAze7oDYO1G6oTXPX1qrdQMwzbLDy
         biucF8U3XcZ0DGZHeqSkG6QWSXJq6H0Ywrdeffwn9PPbJPV1yrqND2m3fDhl6p949GYN
         rukn/sm+18dR4ZrX1c4y46PaRXND1vfbhcQTxv1wsAUiBkTVT9RMONMkSltrdTnaMRxt
         vnDGWD7Kjr1G8A0Ilk3kABq9g94RhYVZ4w/VT2KJ6N2Q2HmlioNc0GnbcYPjJ4ZcQjsV
         IKpg1SGtFTEdVXWN/MxL+GGLB1u5dyLxueDaCJ/S7lRk4NbATEDVGr6AcRDzFEYAOb3L
         KaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+LKh1hv1hZrDXElwVEJnAqH0ASS1XwqKhuH4ESCHgI=;
        b=WsKTLegqUd9A0gHErS2dfXFp6ukwtzTowQGOzvvm6IVJdui7Myq6QDNtmrzu9U1XKX
         oQgMxSdoqWtsT5gEQkIZaBaAKvq5ADnGW2jfL6XRI5Su3o69m6Bx155pVGd03h9K4yRE
         iRT6BTtilMIWU5PK5usJa4mB7iKN2ufwIzhXU/L5NEzfriD1zjxXSiEIcVsVdbt4MVXc
         wsoDgwwVzu9a3VP2EShInAdttpYp0eOOjP8X6T3b5da4B9UnEHES1USpe64MShCcOmGB
         YBas32oR0ZPItQAFu07IqxtaRiP+OLlrCijaE42iLhEb6gO2mCEbFUUNgbeZdJHF1jGs
         +wZA==
X-Gm-Message-State: ANoB5pmKedMlK8VRz9vQsp+AxKSjy/o1YpxJBThTCkBJfl2jzO7hk8uG
        Y76k2fjQhSHZUYZccCMQg0YHQ4Ycec4=
X-Google-Smtp-Source: AA0mqf67CQmhFAuHMbVF/yCEWJQnxvQD99UKQd/3L8oYB3MvIRUmDHnEgrF1a9cNrxYdKRjiVsfuVQ==
X-Received: by 2002:a5d:6f1d:0:b0:242:5083:abea with SMTP id ay29-20020a5d6f1d000000b002425083abeamr11386153wrb.69.1670776258808;
        Sun, 11 Dec 2022 08:30:58 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d58c5000000b00241da0e018dsm6520899wrf.29.2022.12.11.08.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 08:30:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
Date:   Sun, 11 Dec 2022 16:30:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
 <xmqq5yekyvrh.fsf@gitster.g>
In-Reply-To: <xmqq5yekyvrh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2022 23:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Toon
>>
>> On 09/12/2022 15:00, Toon Claes wrote:
>>> Since it's supported to have NUL-delimited input, introduced in
>>> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
>>> 2022-07-22), it's possible to pass paths that contain newlines. This
>>> works great when the object is found, but when it's not, the input path
>>> is returned in the error message. Because this can contain newlines, the
>>> error message might get spread over multiple lines, making it harder to
>>> machine-parse this error message.
>>> With this change, the input is quote-formatted in the error message,
>>> if
>>> needed. This ensures the error message is always on a single line and
>>> makes parsing the error more straightforward.
>>
>> Thanks for working on this. I'd previously suggested NUL terminating
>> the output of "git cat-file -z" to avoid this problem [1] but quoting
>> the object name is a better solution.
> 
> Hmph.  My knee-jerk reaction was that it is utterly disgusting if we
> quote when we do NUL-terminated.  Is your "quoting is OK over NUL
> terminating" because "-z" applies only to the input?

Yes, if the object exists then delimiting the output with newlines is 
fine, it is only if the object is missing and its name contains a 
newline that there is a problem. It also makes adopting "-z" in existing 
scripts easier as there is no change required when parsing the output.

As "-z" was added in 2.38 there is also a pragmatic reason to prefer 
quoting over NUL terminated output as it allows us to fix this issue 
without changing the output delimiter of an existing option.

> If so, then I
> would agree that is OK, but shouldn't the quoting apply regardless
> of how the input is formulated?  Why do we call the cquote helper
> only under "-z"?

Without "-z" you cannot pass object names that contain newlines so not 
quoting the output does not cause a problem. We could start quoting the 
object name without "-z" but we'd be changing the output without a huge 
benefit.

Best Wishes

Phillip
