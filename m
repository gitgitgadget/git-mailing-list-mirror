Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEC7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BE861AA5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhKOP01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhKOP0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 10:26:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6394C061714
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:23:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so9920757edb.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AKt1CPVbfq2boJjuyp3sqa4SNQoE8GK0lzm0g5oY5RE=;
        b=c5u8nzlq3Gba9g+I/VqkQ/RnBn4I5KzIM3WFa6EOFXGmA6jiUrVyDjaulDaOVEZhub
         XYad02jKjTkxYrnkCLb+VrXyx9ECrkZq5CiBWT8QKc3AvB5NGG2enSdbSXqw3/u3uFPY
         9bN0VCzK5XNdiV3qBcHGLTYX5XbfKz2L9Xdq7imw4fw7ARqb3NSxYyjZcSUZy6vWeJql
         +AHBcmy7r9J8lcB7rTFqDvs+mhJqp9yhG3eQODuSx3pbFOETO2SFbs+eNUDrPaTjlHCg
         Rro2aX/Lf6uk42FTBY/baULtryVDzHJZ1uVd/42FcsBUegYzWTuVBZDOE6AecTdPX4QR
         BTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AKt1CPVbfq2boJjuyp3sqa4SNQoE8GK0lzm0g5oY5RE=;
        b=WrEkLZRypaE1pTQyU3BBtvcea696Z+Ad79AKLa8YCQsKbHfHzRCKY3ULUs4zgi6DYg
         Tv/3s3D6qB5UODMJlIzRD/XuAcG/GrwRdLj5gqpyT1NmnKAaxvuB7uDi6gtB1uQwcyBP
         SiUPKMTMuGR4zaKxX8OU4E8kHfywCI/6n5riuFnNN5CU+MmOju2B0GcJSpSL8r5sWJgV
         jXdCo5A/UDAUHmw0zPrgcQc1K6nRQm+SnlttYLxO+XDP3DGW8C3WcULbRy6oDvMT8oIF
         kawYmohgT3tdfIRIYMbkykXwgAIlfiZ6QYEJ2fjvx3rXdL/ZFQs8T7BgLzC6okwbEdMu
         byhQ==
X-Gm-Message-State: AOAM531HoCHUOaR6y6onLOWXvKiNT5FtqqVt3nzx2YK7xwuvCMHCXGfW
        t+fdJsRjOv/6JaR0T+LwFU3rKYptnHI=
X-Google-Smtp-Source: ABdhPJwAAM5QNl6tEsW4dy5y4bfdN74UlhZ0UIXO5/waxbl4yAw0dCMzKf0M2Rh6BQikyfdrJUXqtg==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr56688680edv.248.1636989797942;
        Mon, 15 Nov 2021 07:23:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b17sm7788257edd.96.2021.11.15.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:23:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmdpF-0018Na-0A;
        Mon, 15 Nov 2021 16:23:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Daniel Santos <hello@brighterdan.com>
Subject: Re: [PATCH] fetch-pack: add TRANSLATORS notice for packfile ready
 messages
Date:   Mon, 15 Nov 2021 16:21:41 +0100
References: <20211114073143.84004-1-bagasdotme@gmail.com>
 <211114.86czn3t676.gmgdl@evledraar.gmail.com>
 <2a4428a5-91d9-a0a5-39cd-eefa1c92024e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <2a4428a5-91d9-a0a5-39cd-eefa1c92024e@gmail.com>
Message-ID: <211115.86ilwtsasb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Bagas Sanjaya wrote:

> On 14/11/21 16.50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> If something isn't meant to be translated do this instead:
>>      die(_("expected no other sections to be sent after no '%s"),
>> "ready");
>> I.e. pass it as a parameter.
>> There can then be a "TRANSLATORS" comment that explains that it's
>> the
>> string "ready", in reference to that protocol keyword. We do it that way
>> in various other places, and it completely avoids the potential problem
>> of a should not be translated string being translated.
>>=20
>
> Something like:
> /* TRANSLATORS: The 'ready' string is the protocol keyword. Leave it
>    as is. */ ?

No, e.g. "TRANSLATORS: The parameter will be 'ready', a protocol
keyword" or something.

I.e. you don't need to instruct them to leave it as-is if there's no way
they can't leave it as-is, since it's being passed as a parameter.

> But I have admitted that I lean to your suggestion.

Yes you could also embed it in the string, but why do that in this case?
Seems like zero benefit, and potential translator confusion.
