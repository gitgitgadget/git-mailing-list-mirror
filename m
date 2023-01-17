Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F297CC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjAQPdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjAQPdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 10:33:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589F3FF20
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:33:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so76261158ejc.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCtkzIJkb5UITkJpYqo2aFE22OnGHe6kwDl5aX/XhtA=;
        b=QFOeBkT4xpN9/bzVFhwG+QRV1h54BIAHldGYDIwkNW+WG/sAKbYz+qKBLWbQOZiqzf
         0qKW1aG8MBZg087rCPoXtemHmTLVgj2diwYDUZP34yELhNj375Q0tCGiAgBlkRuGU80w
         thW5kWCeCyUHxaCQQgfwRTQ13B1+5TvBmf4bujJgnJiS1GVkwuvDUTcXLRdHg+PNWXTZ
         IiVkPlDCqs6uFLZrgCTc+0OcK/P/NrjMQDpM5qoPgiRRunQ7wSQiea6NUChBtXKlS4TL
         2CaTWy8ipaDFEW+dKSJwqusNGcNDID3WdmYwFOAB9qToiLCL+3hLjPG3myTdQn5Ft5f8
         4e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCtkzIJkb5UITkJpYqo2aFE22OnGHe6kwDl5aX/XhtA=;
        b=3ZVLHMiGdSQ+6lNL4ygZ3nfBZRm7x6vBlrZ0VQID2YvByrewKsSVdtZQIyeFj1+yBE
         6XJroA999WzbnOc7UGgYmjC9rvdQ3MAJXrLNCrRiPnwo3I1PmOwK/F96RQtz6vzWlM/6
         rjOeLRuRJv0FImOpgFebtZVYt3mzcXn9cA1jgOeQwwSXldGIiJY4U4wmxaVEjp6jmO2v
         Ok9zYQ8OIeFmQc/JP7IGhgoUXcQxJgGZRmXSQ6/WL9k5JdryeD7hDYjuzwZmhL66KySM
         k5+sh7Qo1zI+QHuRX2YhOLyJbdDfQKjLsQUpiXKoQh66xZfn3z3aif93eNwb8YcCwxyN
         fvNw==
X-Gm-Message-State: AFqh2kq2hi2FyYXFpFVklTxPijS2/WCDVg5lfoRO75F8Jenk2jz04+Hf
        9SVNImMTD+lLLlsu6YXhi50=
X-Google-Smtp-Source: AMrXdXv3JxCYFCm8Xs37oBAdzPVfYADICG3dYkVcCtxoYhD66NZzblxt73Jhq8rpy19M28VPU2tkvQ==
X-Received: by 2002:a17:906:7101:b0:870:4f04:7ad0 with SMTP id x1-20020a170906710100b008704f047ad0mr3357737ejj.45.1673969615663;
        Tue, 17 Jan 2023 07:33:35 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709063ca100b007af0f0d2249sm13331431ejh.52.2023.01.17.07.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:33:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6d81f2d5-ed76-9855-04a9-89b6e3040da6@dunelm.org.uk>
Date:   Tue, 17 Jan 2023 15:33:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Sergey Organov <sorganov@gmail.com>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <xmqq358fu4vr.fsf@gitster.g> <Y8A5X0kHE31kSH3z@coredump.intra.peff.net>
 <xmqqilha18yd.fsf@gitster.g>
In-Reply-To: <xmqqilha18yd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2023 20:22, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I had somewhat the opposite thought. The "break" command is special in
>> that it is not doing anything useful except returning control to the
>> user. And hence producing a message is a useful add-on. So I expected
>> the patch to just allow:
>>
>>    break this is a message the user will see
>>
>> without any "#" at all.
> 
> Ah, I am OK with that, too.
> 
>> That does close the door for further arguments, but I have trouble
>> imagining what they would be.
> 
> Making almost everything that the tool does not pay attention to
> (like the patch title of "pick") into comments, floated by Elijah in
> the thread, does sound another reasonable direction to go.  If we
> are not doing "pick 0f2d4b69 # the title of the commit", adding the
> message without "#" to "break" might be a better way to go for
> consistency.

Indeed, it seems the question is whether we want to make the changes 
Elijah suggested - if so then we should use a "#" with the "break" 
command as well but if not then it I agree it would be better not have 
have "#" for comments with "break".

My impression is that there is some support for Elijah's suggestion and 
no one has spoken up to oppose it so maybe we should go for that.

Best Wishes

Phillip
