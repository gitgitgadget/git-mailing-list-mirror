Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C32C433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 07:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350025AbiFAH2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiFAH2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 03:28:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6638AD
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 00:28:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f21so1857643ejh.11
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5WQx3V91W7K5IUckKJPuG/jQddpXKygQCSNOf2uiVW8=;
        b=hvV36jMYNDiKCnoggrYVeCJRvaOnCWlJUYXaP5dtArXEjqUdM5xotsVovZRz/jElEV
         36Ika1/p90TEI2CM2JCFSDMVBCmVgtqhdLw9KVQBl1Hx6G6TJ+vKwiTgRkJNJHsaTYTQ
         DkCEEHvQ1lpTjs4CuGd/c0XB2zg0vINFRWR8Z+AEHILsfScKN0mmrMlaDwjEn88OKzbq
         gAn1ymBdrpvS3v+CumZITzfaVH7v1JhSqgDPIJmBvgn8YOXp4UkqNk2wQEP4xGW5/bWT
         txOsvK3oGSeHMlvtocZ+hRTx9TklFnOCk1cOXiGsgFDn8+RD6uBrx00QcexSQCHa9mxp
         lmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5WQx3V91W7K5IUckKJPuG/jQddpXKygQCSNOf2uiVW8=;
        b=SD9qZmG41q8sByI1Km20pUsipSOMZ+fxMgioPnBN8CPbDLzPtUQaoxTErMn57iYah7
         MQNgSrhQQn2rN0X3kMSxDLOp78zMofEvkY7Lxh3Z5peGHbMVGyVHapS0LCNaSDAS7ScI
         mH+z/83E7ap3PeWXx3h0WZvYScFEnyktLol8vwmQbxvcb4Dr1ElUcnpHvbidLjUgrgEI
         px1I1w/tV0FAjVGHdCt5tVeVY7ZeAB7kn3ZftNaZXc/kb/XVLfVTE3OwQVQxo0JkPlfB
         p2oR4R8fIOnrlCyJKRkXhgrmLjdad5HJrtoo7ittEAulwiblBwTvvu0Bhjrao9Qzdchn
         un5g==
X-Gm-Message-State: AOAM530z7V9mqgAQSbCtTjS8n/GuJj26ZhEQ/HPmoWCAEOF2RRX6MLak
        9NlfoyV55tDw9u5BEmJKyyoZVTzcCBraVQ==
X-Google-Smtp-Source: ABdhPJzYTPkmq4bk9wbNZFSv7dVxnIxgxo7Yujqa44oqDs7pRAqXvUj4KA5vn9x2k1sHZJF+i3r6OQ==
X-Received: by 2002:a17:907:a42c:b0:704:b3eb:8812 with SMTP id sg44-20020a170907a42c00b00704b3eb8812mr3949803ejc.205.1654068507696;
        Wed, 01 Jun 2022 00:28:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r23-20020a170906365700b006fef51aa566sm368606ejb.2.2022.06.01.00.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:28:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwImI-0012sm-78;
        Wed, 01 Jun 2022 09:28:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re* jc/http-clear-finished-pointer
Date:   Wed, 01 Jun 2022 09:26:14 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
 <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com>
 <xmqq7d68ytj8.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d68ytj8.fsf_-_@gitster.g>
Message-ID: <220601.86pmjs2679.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, May 26 2022, Junio C Hamano wrote:
>>
>>> * jc/http-clear-finished-pointer (2022-05-24) 1 commit
>>>  - http.c: clear the 'finished' member once we are done with it
>>>
>>>  Meant to go with js/ci-gcc-12-fixes
>>>
>>>  Will merge to 'next'?
>>>  source: <xmqqczgqjr8y.fsf_-_@gitster.g>
>>
>> The end of the proposed commit message says:
>>
>>     [...]Clear the finished member before the control leaves the
>>     function, which has a side effect of unconfusing compilers like
>>     recent GCC 12 that is over-eager to warn against such an assignment.
>>
>> I cannot reproduce this suppressing the warning as noted in past
>> exchanges, it's not affected by this "clear if we set it" pattern. It
>> needs to be unconditionally cleared.
>
> Interesting.  I still have conditional clearing in the tree, though
> I was reasonably sure I got rid of the conditional and made it
> always clear, when I rewrote that part of the log message.  After
> all, I ran "commit --amend" so that I do not forget the issue after
> sending https://lore.kernel.org/git/xmqqleurlt31.fsf@gitster.g/ X-<.
>
> Thanks for catching.  What is queued is not what I intended to
> queue.
>
> But there is one thing that is puzzling.  Ever since this, together
> with the three patches from Dscho for gcc12, got included in 'seen',
> the branch started passing the Windows build that used to complain
> and did not work, so at least with the version of gcc12 used over
> there, it apparently is sufficient to clear only when we are
> responsible for placing an address that is about to become invalid,
> while leaving the pointer we didn't stuff in unmodified.

I didn't find what specific build(s) you were referring to, but perhaps
this is due to an interaction with 9c539d1027d (config.mak.dev:
alternative workaround to gcc 12 warning in http.c, 2022-04-15)?
I.e. with DEVELOPER=3D1 we'd already get past the warning with
gcc+Windows, presumably (but I haven't confirmed whether the
detect-compiler etc. works the same there).

> As far as I understand, with the most recent analysis by Dscho on
> the http-push codepath, we can return to the loop while the slot is
> holding a different request that is unrelated to ours that has
> already finished without recursively calling run_active_slot(), and
> with the current *(slot->finished)=3D1 trick, it will successfully
> notify our loop that our request is done, even though slot->in_use
> is set to true back again when it happens.  But by definition, at
> that point, slot->finished is not used by anybody (obviously not by
> us, but also not by the request that is currently using the slot,
> because it hasn't used run_active_slot() and slot->finished is not
> touched by it), so it is safe to unconditionally clear the member.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH v3] http.c: clear the 'finished' member once we are done =
with it

I see this is in "next" already, as a follow-up we should have a revert
of 9c539d1027d (config.mak.dev: alternative workaround to gcc 12 warning
in http.c, 2022-04-15) which this patch makes redundant.
