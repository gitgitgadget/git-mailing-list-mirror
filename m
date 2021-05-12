Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45256C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179F261370
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhELJbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhELJa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 05:30:59 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1AC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:29:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i81so21706584oif.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aKID2UeTSiLFw6ntVQsWwkNV48XIghQmCt9xyOWeKLc=;
        b=NQSJ7sUFbzol0fK/3N+ZMUnUcGTOzPRWvq2jalKyx0xhcNeKitcpkEyVdiL3jJdBGD
         o84cHUXXWqJl2QxlucHSwlImdJjVYl3oB0o6J6S5HmW+saNvrWf9lr+qRfSWQeVQcgsS
         74o+2NBk04AUd/tAlkJeP6zmhVeGrR8xlJhdcInOOMPJtVdbokw+myt90XGyW2n0loGs
         lVn0WHnkLmSigs3ZEIijIxhAJvfaSCYbMRWQKIZvgnjgAmaL21CXAt7NkTxXCTiuJBFC
         ORxC7ntgzAs2+QiOQlslREPA6D8d87JABTxdq/GAGV/gkZ9mRTI6vkmLlLgVQkxzenOG
         HpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aKID2UeTSiLFw6ntVQsWwkNV48XIghQmCt9xyOWeKLc=;
        b=kDY4WQry1yEbVErXjcLKKtoclBhTtePId1fuSWRfP2jHB/uZfk+X6b8+L9SRoY6d7P
         HytdUxzp4Cro3HAfHEboGmx0rGatU1NRtfs+tsuLjdf6116r7z7Q+IywHAQfB7obb7aa
         VE0OKg5lBKAr+vaNV+z1QNc0SLqByTzv/C5tmPsSeb1Nm4PEhzrH+2l4QD7xs8FXBXdg
         QOqvHq02rGSuUpqfXbWS3RGosnay91HNBt6rErZih7FDNYV9QufjUBIO0p5fJAGt6eZQ
         Y7+SRTgqF1+OLXar8D1QXPE0tHZihTbR5A35qNQfzeYcga8h730SEjwiFHEVFznFM/pE
         mPpA==
X-Gm-Message-State: AOAM531G+CdKPooazU26U7P9OhY01TTbnjcMKd0jcL4fL2RD82OR77NV
        RSJ4Jvv9wcLmXjFek9S4qThK7xnudFt/yA==
X-Google-Smtp-Source: ABdhPJy3igJaLBxqbA3EKH+kMEl1ncsKT1ng18aw7eIWHuq3eV8baP/HGsnTKNi64SoWMgokTpSDmw==
X-Received: by 2002:aca:1a06:: with SMTP id a6mr18908473oia.95.1620811790626;
        Wed, 12 May 2021 02:29:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k20sm4461687otb.15.2021.05.12.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:29:50 -0700 (PDT)
Date:   Wed, 12 May 2021 04:29:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609ba00a1c03b_6e87020886@natae.notmuch>
In-Reply-To: <patch-1.3-d18a3caa07-20210512T084137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-1.3-d18a3caa07-20210512T084137Z-avarab@gmail.com>
Subject: RE: [PATCH 1/3] SubmittingPatches: move discussion of Signed-off-by
 above "send"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> +=3D=3D=3D Certify your work by adding your `Signed-off-by` trailer
> +
> +To improve tracking of who did what, we ask you to certify that you
> +wrote the patch or have the right to pass it on under the same license=

> +as ours, by "signing off" your patch.  Without sign-off, we cannot
> +accept your patches.

This may be me, but I would expect the phrase to make sense without the
comma:

> we ask you to certify that you wrote the patch ... by "signing off"
> your patch.

Whatever you put inside the ... is additional information that doesn't
negate the origina sentence.

So:

> To improve tracking of who did what, we ask you to certify that you
> wrote the patch--or have the right to pass it on under the same
> license as ours--by "signing off" your patch.

Cheers.

-- =

Felipe Contreras=
