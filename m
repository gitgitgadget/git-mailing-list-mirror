Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60D2C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47D32245C
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQyANups"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHEHKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHEHKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 03:10:02 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C4C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 00:10:01 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 125so8156472vsg.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QigT6w88X4k0klwPEWauNSctEzVgMLup4AEQ0kJz5II=;
        b=qQyANupsPHXvFiy8T3DKxs3S24cQb3Pg3krfhTG2ex0ys0IoZVADRAZTQV0XCOZ6yi
         RW/0EiKrFxJsyKrMUTID4MKnKprselecqxF8RWR5EW7S/UH6ntzEG7TURA5i7APWTaBq
         evB6fGmOZXRmjygrV9ZveipeO4wO3yOqK5oXzhhOvIPZoEv5oNrxjcVlrmk+Etwiz7pf
         MvIuTgcDUuzPjcABTb0Yxjylle36U8eMhOzsDJKrW7eAgyuNUfoOiliiRPAws/FFysdR
         cgC8Y/4rpfN7VriM7C9rk4CJZ94nljx12/z69L61CRZhT4JLCq45oUqKs+6h/R0TLEEm
         jvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QigT6w88X4k0klwPEWauNSctEzVgMLup4AEQ0kJz5II=;
        b=rVPVpDoZeYpQxcG4NHNaREyR6QmMhfNJ42iyADgAfoA/rO/caJ0XMhP3BD6a/f1Xjv
         CLNvQq/2OBii8B4xjhOxTUTqKbQSJr7N/NcoLOaDO/e1MAnMp9xqjqf1c5CsrBy0KyWe
         JkYqNtjKSjIKRwvAQs8rghHw2V7yzzlX0TlI+LgPURUteSZ5brhLKDRX4zliYSWuQZ0M
         WUM5xCQTbGDMxglfaj40yQFiG444yJZV8f8wE56OJeJCTG0utfu9P1GUSacNIW6az/8Z
         GFBTUULtGiGcR/aRn55DtAmZfALc4ps7SqWhc4hMXZ6rETl/bIyRaPVloBzUbUJ9ZHEt
         ZlFg==
X-Gm-Message-State: AOAM533xdsiEgR/RwR94V1NaiSKBvSJ1RrOz+FqfFE5CEDc8w/DLuYcP
        gbV4RklJnnFcA2hJjkOdKTO2etPaMs88rbcluXU=
X-Google-Smtp-Source: ABdhPJwxW7QmzcL3XSkIL5QgXpjX4CENi/xd0yz5bl0cSHmgu2FA4oaqYd4YLZBQsiqrIwie5XdlyIANW5OMgKdykhg=
X-Received: by 2002:a67:2d16:: with SMTP id t22mr965460vst.46.1596611400986;
 Wed, 05 Aug 2020 00:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2muqddg.fsf@gitster.c.googlers.com> <20200805065408.1242617-1-martin.agren@gmail.com>
 <87eeolo9v9.fsf@linux-m68k.org>
In-Reply-To: <87eeolo9v9.fsf@linux-m68k.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Aug 2020 09:09:48 +0200
Message-ID: <CAN0heSoa=Y1HMaZD=eQYD8uphrm+VRZe9yD+8voNuWPetHm83w@mail.gmail.com>
Subject: Re: [PATCH RESEND] Update .mailmap
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Ed Maste <emaste@freebsd.org>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Dropping Jiang Xin's huawei address. It bounces.)

On Wed, 5 Aug 2020 at 09:00, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Aug 05 2020, Martin =C3=85gren wrote:
>
> > --- a/.mailmap
> > +++ b/.mailmap
> > +Andreas Schwab <schwab@linux-m68k.org> <schwab@suse.de>
>
> Neither of them are more recent.

Thanks, I'll take that as a Nak and drop your entry from the patch.

Martin
