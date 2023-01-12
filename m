Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7CBC678D5
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjALQak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjALQaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:30:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A89ADEB
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:29:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4345299wml.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHhx290vcSezBo6nZUvuppJMekzKTy3cEd889kkxmmc=;
        b=VM35tTVlHpKcKmWiDKSVhYvqT+cJPgo8ACh7LkJwZjg1ZSHbvPzGA759Jvl5YiMPRh
         t27n5OFRb/zMXMVso0XfCFn+Xr5rFET7OTPQOHPTLKCAi0jRBx7rO/yHeIfeewC2CuwI
         AzGsAhB+dtgRO/LcnwEULuWxE1e17u6HUSm8qwFf3qtZyFNzGdBaaAQmdrDsHxKNdFxZ
         yLOw0A1MnkyFc7sPko9mqHs6tsSLlCldfLRBWD+7WJAXoreQWr//lW1X/6dUOp4IOMU9
         lyhwsin0Os6LgQZnOtZX1++XIkH0pTMF/ks0za25eHWsVPmi3LGNJLn/xFuK+DrvnrXI
         tUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHhx290vcSezBo6nZUvuppJMekzKTy3cEd889kkxmmc=;
        b=A2h0aSHUER7pyjXXRHk8qXiFX0jP1a52hTenw21lYgpDztvU65RJhWGgSWcofokUex
         5/1JJWh9hlr8kvS6fEAnCB6KBrU83fi0XChYiVY1mKibvhvbWI+GvHK+oiCXRjLRKuzP
         MIFJsRSNaHFx+vA5AWYX4GovC/h4I6B7UScyoDZgGNde6yF0674XMoqA0fw4wfaXZG6b
         w57J2g1suCVsT+o9CZCR8yVVAzWz7bVf9stiATgZ25alvgVPDrL2eVwEx8PHUxFFPhKM
         l2UIxSjVJR+0lVboeCHnnYdVXTt1vBcavnCl3gXa9Ytamdqc8GxAwdPkq1Okx95Y2/0q
         NviQ==
X-Gm-Message-State: AFqh2ko6ybqbXvc1osj9wVsGy2ZY/9pBZpyVZPVocjrTaLwrtbCgitot
        QO3IsMSKWNmB/mabpaDGn6s=
X-Google-Smtp-Source: AMrXdXtLiThuvPKJWslvklVYQf7JCryWSthpU7GVJLO9M/y2m6co7qVcfC/nDh6ps8JFU5KgQZ+xtQ==
X-Received: by 2002:a7b:ce06:0:b0:3cf:a483:3100 with SMTP id m6-20020a7bce06000000b003cfa4833100mr55783756wmc.3.1673540943085;
        Thu, 12 Jan 2023 08:29:03 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003c6b7f5567csm10461041wmq.0.2023.01.12.08.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:29:02 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <59bf57cb-fd8b-b814-b45e-c8088e743d5c@dunelm.org.uk>
Date:   Thu, 12 Jan 2023 16:29:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <xmqq358fu4vr.fsf@gitster.g>
In-Reply-To: <xmqq358fu4vr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 12/01/2023 15:52, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When adding a "break" command to a rebase todo list it can be helpful to
>> add a comment as a reminder as to what the user was planning to do when
>> the rebase stopped. Anything following the command is interpreted as an
>> argument to the command and results in an error. Change this so that a
>> "break command may be followed by "# <comment>" in the same way as
>> a "merge" command. Requiring the comment to begin with "# " allows the
>> break command to start taking an argument in the future if that turns
>> out to be useful.
> 
> Why do we special case "break" and not give the same "comment is
> emitted when the control reaches the insn in the todo list" for
> others like "exec" or even "pick"?

I think the break command is a bit different to the others as it stops 
the rebase and so the user may want a reminder of what they were 
planning to do when it stopped. The other commands just pick a commit or 
run a command so I'm not sure what the comment would be for.

> Another comment with devil's advocate hat on is if we are better off
> not adding "# this comment is emitted" at all, and instead do
> 
>      pick ...
>      pick ...
>      exec echo this comment is emitted
>      break
>      pick ...

That's a neat idea, maybe we should just add some documentation 
suggesting users do that?

Best Wishes

Phillip

> 
