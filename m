Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163DC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9649B61107
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFGLF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhFGLF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:05:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8258CC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 04:03:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w21so19716261edv.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7wm6G18cocFYZZbzOAi0xz1T9xVhf48PS3Sc2KdgGrU=;
        b=vSBrGOYj7ne3hB82FjKWB7ZWAhv73NgSKgb3qBtvwNxbqwI6JH8M9OZcw+lsJGx54O
         k0R4XtTONvytYv3PfuiaZp7Ag+h5fYBextOfJ/yGZQdsJqtWgc2iVKVfaFAwoCqU+CG6
         eJR8mOFn/P3TLJWnxxXYJMgA1VFlGLKKzX+zlO7ERGvyS59Hm7J8U0j/GA/bVT/DYKBF
         JLORqNjTg9FBgS5FcQ4jkUNFMOjAPSHm3WMJMie3we9dhWjL6jT4rDpSkViNfDVp8ny9
         uj3Bt0zdRiVriLUBJQCw3BhcS6s30BjcuBdUPnVNsvxOuOVwi+dhg4cI/z+Uskdyb9GJ
         FAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7wm6G18cocFYZZbzOAi0xz1T9xVhf48PS3Sc2KdgGrU=;
        b=tvNF2vdRGlddQoHm5y1jgPkzhapfI/vbupbIr9hFz4AQQOqFsS0Nmi6pqKqLlh5yrN
         No3tE2hQ0HMljhV7mFvkerY60YMurAN8s+66zurp6zzgNcXRfsbB9wUnqOgpzbK1VNXF
         3mOeyEwteY2/DHDIzbvKs/JQNbk4wMbLFvz5vm37pYtfiEbwLzDpN6REf9fTUkVHWBb6
         fkHC0ntWYrGgbTiaRhLpI97tPSZHljEqykJNC4+jgH/msGCSZMPzA1WWvXTt6HGUEBQH
         a9OxL7VXcrGfpZEYy2hG7ZYS1sv/GbbUX6n5NqAtBAL5ydCTJzya7B+aNOHBUOzeoLwZ
         KiqQ==
X-Gm-Message-State: AOAM532x5h1+xqkkgE72WNpDsgsQCVnxD3FkA7e/ORH7hjtdBet6mMpe
        ITqrCriixWXu7hp1OrdMV26Kg7O1TVw=
X-Google-Smtp-Source: ABdhPJybcPNIbLpeYWTr7JyomNCK/GeviPDaec8lFHKd/YvVbs2S4Bo6sb3rjVdhakxS0RBdNtZfeA==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr19138648edt.106.1623063812781;
        Mon, 07 Jun 2021 04:03:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n23sm4833196edr.46.2021.06.07.04.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:03:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 1/3] SubmittingPatches: move discussion of Signed-off-by
 above "send"
Date:   Mon, 07 Jun 2021 13:02:08 +0200
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-1.3-d18a3caa07-20210512T084137Z-avarab@gmail.com>
 <609ba00a1c03b_6e87020886@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609ba00a1c03b_6e87020886@natae.notmuch>
Message-ID: <874kea543g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 12 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> +=3D=3D=3D Certify your work by adding your `Signed-off-by` trailer
>> +
>> +To improve tracking of who did what, we ask you to certify that you
>> +wrote the patch or have the right to pass it on under the same license
>> +as ours, by "signing off" your patch.  Without sign-off, we cannot
>> +accept your patches.
>
> This may be me, but I would expect the phrase to make sense without the
> comma:
>
>> we ask you to certify that you wrote the patch ... by "signing off"
>> your patch.
>
> Whatever you put inside the ... is additional information that doesn't
> negate the origina sentence.
>
> So:
>
>> To improve tracking of who did what, we ask you to certify that you
>> wrote the patch--or have the right to pass it on under the same
>> license as ours--by "signing off" your patch.
>
> Cheers.

I think these are good notes, but in this commit I'm merely moving
existing lines around in the file so that 2/3 and 3/3 make sense, so
I've left any change to the existing text out of v2 of this series.

I welcome an effort to improve the existing wording, but I think it's
better if you submit your own patch-on-top for that, I'd rather not get
bogged down in that any more than I already am :)
