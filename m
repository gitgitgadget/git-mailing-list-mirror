Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E2EE92FC0
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJEU7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjJEU7W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:59:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A593
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:59:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-505748580ceso1787489e87.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696539559; x=1697144359; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJXhFOYK71X8QlSVtZV7SxYRyOwGfHCDcojUBXoTHBA=;
        b=N3gXJBx1AA9ft/4HU8G2KyaIBnZIrMaqfVewdJCbdtmbkVTxb3deL/qOLP0cl1ylZe
         a66m732Gqqlj8AesjtBm4cBA1Ldz27TATaqTF7XYYHMqfqSLOManFU8Ma7jOdht0iLUL
         vLeKyDfvxsdUXNeNjZVo4+95NJn8mpSK13W5lOJ5IORInP8gaaKX1UdrjcrZa93Cb0WY
         ulgPieM8+96mfJtoebnmbywJVX4JGFgtwWywIpPzsuG6C8Q/zJXI8GCWfMOkC7ly+EzQ
         /SsX2DZ2oPwAHpc2uuY7ycMDynIwRgyJrItHHg9fG9RRyptgZl8Rx1pciUFw0tEByIre
         E+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539559; x=1697144359;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJXhFOYK71X8QlSVtZV7SxYRyOwGfHCDcojUBXoTHBA=;
        b=j5+XwaxRSY/Tj85PIZkuxswepomMFvi9LUEx5DC1Uj12ay4YfuUHSylNi0XEAyulpC
         /XGlts3o5ootNiplObtGgIZlHauYG4AWwd9nviFb4mK+qT/OsUiEd/YFI1zqduy5AoIV
         /+bZRIJttZZku9wZaMa+TuiHiv7PW5VApVM4kgEsbEK1wNSMU3XGHRgW9KX7NiPwCOeF
         gaLD+FcwmiLfuTwKNunrz3k5CNgMoQ/byLRgVtRbujCc/tR/JwjHmOnWR8RsrWe1bJGJ
         ZtyFq3nCHsfKHz8E2751j7pXwSk3TrKtk/G4M7/tmRdDRtm8G6LKVSzS9Xm/HMXnPcQg
         HX1g==
X-Gm-Message-State: AOJu0YwfgOakNPoIiuzAchHrYNhVhUyYRU+n1TpiLSv5zghwJSAVUhBJ
        Chf5I14ckfNtEZ/PqKsHeqLCYuvrZbIueg==
X-Google-Smtp-Source: AGHT+IH+wtbv1DTQ8HDU430GaLx85uMMfUoc3JhfHaekAe4irPr/lEPw8FcvMOVgKf/KXHb+vyRo+A==
X-Received: by 2002:a05:6512:2022:b0:502:a4f4:ced9 with SMTP id s2-20020a056512202200b00502a4f4ced9mr5093242lfs.62.1696539558316;
        Thu, 05 Oct 2023 13:59:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u13-20020ac248ad000000b00504818fcb07sm590lfg.266.2023.10.05.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 13:59:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g> <874jj7lh7x.fsf@osv.gnss.ru>
        <xmqqo7hessro.fsf@gitster.g> <871qeay6tz.fsf@osv.gnss.ru>
        <xmqqjzs1mkma.fsf@gitster.g>
Date:   Thu, 05 Oct 2023 23:59:17 +0300
In-Reply-To: <xmqqjzs1mkma.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 03:25:33 -0700")
Message-ID: <87lecgeqfu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:

[...]

>>> If I have to pick a candidate for "get me diff" that is the most
>>> useful among those currently are available, it is "give patches to
>>> all single-parent commit, and show tricky conflict resolution part
>>> only for merge commits".
>>
>> I'm afraid you need to pick a candidate that will be natural for '-d',
>> not just most useful output for your workflows, whatever it happens to
>> be.
>
> Literal match to word "diff" does not necessarily mean it is useful,

Sure, who argues? I don't.

> and short-and-sweet single-letter option name is primarily about
> letting users reach useful features with minimum typing [*1*], so you
> cannot avoid "most useful" being a large part of the equation.

I don't try to avoid "most useful" either, quite opposite. With whom do
you argue?

I just pointed that a short-cut would better be natural (or mnemonic)
/as well/, so you probably don't actually want:

  -d:
     give patches to all single-parent commits, and show tricky conflict
     resolution part only for merge commits.

, or do you?

Overall, as an example, I'd understand if you had deflected the patch
with "let's rather use -d for '--decorate=short', or '--date=relative'",
or something like that, but you don't, leaving me uncertain about your
actual worries and intentions.

Anyway, I re-submitted the patches avoiding precious, too hard to
deserve single-letter option.

Thanks,
-- Sergey Organov
