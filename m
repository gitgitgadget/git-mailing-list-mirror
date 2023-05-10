Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDDC7EE2D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjEJHfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjEJHen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 03:34:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0337DA4
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:34:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so2692014a12.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683704052; x=1686296052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRMHGpOLtcfquUhkHj9dT9Q95pdmMkbnW0KzekZFSnA=;
        b=lhrxe2SkZCrKZ3ItI6PuDaidK/TRZ89NwF0bVdVig2ZJ81CG9VDHaX71bfaKBlongB
         +re6+s/lFxhsaWUuK/0XrApSv+W+7SSuEHUwzbw974gvr2SPnGw2B8O9ADp0gUaSn1o6
         +y629Yxu9FL7zbFaHtpQWMVKH3DcPcS2O+zVbydjAjrctIJFhKogorv2lMilHvKXmhYd
         2JItMhYIe3h3DQi7vLw/CLXmSBf8SD0hyit/fE0FZRWXa4tCQRHuddRXmUZKnTHiN0SD
         5Zdar0MqUDIVIJ0QRC5qx5nb1d8m9U0Af9AoDyNlj3QnjwO8fsCEGqJT93rrY2QIFUqh
         NhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704052; x=1686296052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRMHGpOLtcfquUhkHj9dT9Q95pdmMkbnW0KzekZFSnA=;
        b=SHopPDY5kAm3MsB3xhi2wrq8kJ1aSkRSY54wzG5GG/WVgh3RYb7S2bGe8vWP0eRQu7
         wBypuzrtLPGQRDfhRnQKIl+eXMicXmKJyTUPQrgmJFD0FX96Ur8Dj8qx/1zOE96ANrWN
         xWb3MLKpJM9r2mC/JD/Kn1/NM75u3XYusFrB7ZYesig1+8Dam9PNWOT2eNytNNQ6VhuL
         OCZyg7oKXXKpX/T6yF0BB0+NfG8ZPKSYpUiHDDgo+kWbg3WDBr/Lm0QL/QBGTzPHf/aH
         etljDGF8F6PMH6iyTx8T4mUAqoNc8Ur7/jSibeDz8ZLbWF8kbG4Endjh9CXyvYK6g734
         dGGg==
X-Gm-Message-State: AC+VfDwuONAHvtl+nbqOrIGjN45eVovUsZsHoUsfNX4Bc2ul3SEOACjg
        GCbQT3bIUxJpT96h7Vg4NtapFq8EuIG1UmkY6IA=
X-Google-Smtp-Source: ACHHUZ57m25+HeipaPIg+nOjHDry/HmtDYGK0JAiM2wOSu31JcQJtcbEMe64eRyH4IJWfWFDp4is0L9v3zsLM+wsrK4=
X-Received: by 2002:a50:ed0b:0:b0:50b:cae1:d4b2 with SMTP id
 j11-20020a50ed0b000000b0050bcae1d4b2mr12362435eds.38.1683704051718; Wed, 10
 May 2023 00:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com> <xmqq8rdxuokg.fsf@gitster.g>
In-Reply-To: <xmqq8rdxuokg.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 10 May 2023 09:33:59 +0200
Message-ID: <CAP8UFD0pTrWZzvVCx5X+KbFuLHCH7YVryXCQ+P1GZ3BGfZfX=g@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Introduce new `git replay` command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 12:28=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> It would help to include the following in future updated rounds, as
> Elijah is shuffling the header files around agressively and these
> patches do not build when merged into 'seen'.  When these two new
> includes are added, the series would compile both standalone
> (i.e. applied on top of 'master') and in 'seen' (i.e. with shuffled
> headers).

I have just added the two new includes in my current version.

Thanks!
