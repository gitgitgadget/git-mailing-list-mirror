Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B77C4321E
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 00:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiLCAxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiLCAxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 19:53:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FC1FA
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 16:46:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so6125360plw.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3up2WS8nOk3q0+s9W1Yv+4Hr0Swajy0G5r149Zg7h0=;
        b=NHu/UM9QftrEL7WvelCMpve11IMwE5ywLhg31znXylvJE4QFhbpCOOCh1gXOnpXdWu
         PTv+vg8hCzi+kiBG/A1bYYSfeFPq7oqPwgd0JQGbm+MmL12wi6hgIB3+hIrCq3VjvGFp
         Xq88622uni3YkC6Hgf2KPAVIF126JR+ZCy9tsma7evifv+0ZWDij/K0EdqBmlm23Xth5
         TlWBMq2Cy7b68kww+V9uMFHnyodsWBjB4lt1TH1z4/47S51iZ60n54qojlEwlEVIIo8w
         HOOoJRVejhe+rZQFWfjOxDBU6AWVl0lwxzCVAXy1DQxn53vMJGd2D7vBj+OkoOPYXw4I
         d9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3up2WS8nOk3q0+s9W1Yv+4Hr0Swajy0G5r149Zg7h0=;
        b=Rf62ZH9puUdsHo1qJeXBhBjuCojDiNrNXQKcsQm9lAONlhY/dP4MrOh7p5qZ7MQE6X
         /6UG9/2Jr127RlMfrajMqcrdyobg7q3deC10x4GTq/OzxRx0EsdXlinEkr6lvdFJz4xT
         D4Ngl7OeMN+5B0uy5ueXIEEBF9bYeYXUY3Qo9T9Kqv7pgyPKTbKJnsluY2J2Wf93UpPj
         yU62nTTeQ0px4ytmHMqnhBNBsLnQlPr1tFgTzru7OV2leFmVO0eGNgmfExObXdeCP7Xp
         GNssAvmn5GbAeEFO1cdt5jCFQcuEIAwcCwNosVybGivIa9NLCxyAk7x2yK1ts7Y2bWuD
         xXxw==
X-Gm-Message-State: ANoB5pk06fgFnXLAHGvrGMNmdZMtA81mwYwWbFn4NOHyamG02rRYeWfU
        ZD6WoknBTAchIQmnK1j83M8=
X-Google-Smtp-Source: AA0mqf54/s+h869S9Z0j9jlYTBEM1I5Jp8wvwKhzmT6RJhe/89ZN/LIfSJkhgG6kKPJBSYAi+DazSw==
X-Received: by 2002:a17:902:6904:b0:185:3f7a:50cc with SMTP id j4-20020a170902690400b001853f7a50ccmr54075593plk.99.1670028388329;
        Fri, 02 Dec 2022 16:46:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f14-20020aa7968e000000b0056bee23a80bsm5658235pfk.137.2022.12.02.16.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:46:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4205: don't exit test script on failure
References: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
        <221202.86edtihgga.gmgdl@evledraar.gmail.com>
        <xmqqr0xir9lk.fsf@gitster.g>
        <221202.86a646hdb6.gmgdl@evledraar.gmail.com>
        <xmqq5yeur32x.fsf@gitster.g>
Date:   Sat, 03 Dec 2022 09:46:27 +0900
In-Reply-To: <xmqq5yeur32x.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        02 Dec 2022 10:45:10 +0900")
Message-ID: <xmqq5yetuxek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> In my mind that's better than a "LGTM" or "Reviewed-by". Those are both
>> versions of "I looked over your work", but if you independently come up
>> with the same thing that's usually a stronger sign that the proposed
>> solution is a good one.
>
> Not necessarily.
>
> Past effort that did not fare well needs to be re-examined to make
> sure it was not picked up because it was crappy, because two people
> independently coming up with the same crappiness does not help us
> build more confidence.  Instead of forcing other reviewers waste
> their time looking at older threads, it would help to explain what
> you find good in the patch you are reviewing.

Related to this, another thing you often do is very helpful: to say
that the patch being proposed solves the same problem another patch
that is already in our tree solved in a different part of the code
base.  If it was good for another part of the system, it is likely
that the same solution may be a good fit for the part being touched
as well.

Compared to that, referring to an earlier patch that failed to hit
our code base is not all that helpful.

Thanks.

