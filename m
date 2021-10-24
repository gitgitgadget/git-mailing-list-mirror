Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1FFC433FE
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF15A60EDF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhJXRc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhJXRc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:32:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161EC061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:30:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o12so15852053ybk.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZeuagJFE0ulUe3gpNpQCHPx22cgsnKhNXS/31DOtMjA=;
        b=fPlYL4YeN4e+4VPvuaobXz5pI9vXeqVWAjf6wylfZpiRjSGby2jgDiKoxQuHihx0CB
         i9NaIikceAHcOXJK8VMUjVuFm6vEeHl6vmn1Tz5Is5FbQ4ElbqNyt6kcfEEm+xew4asc
         vrcAynPew9c9JXD1dE39+AxnjLxqXAkaGPVCOeH8+xRFp+a7SkJ34bZFD1tcPwU8B5Pq
         eUg2oR8jP4F/zpu01V79KITOIVpHbdTAmqzuA0J6ZwINV931rqcat4hhkCVl6f7p7jG9
         b+xEQVQ6P2l502NeQcBCmHtftGnnknInoOLxl4Qw3GCLLTvLWlFMUjMHI7BL0TQ9Pf6s
         NdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZeuagJFE0ulUe3gpNpQCHPx22cgsnKhNXS/31DOtMjA=;
        b=mLxcqsrltpek74xgrgRGI/4VevXQnk9FNQ3JUk8XJ31xFSObptg2Emg1hOje9lD246
         VjP6mcLr3gr2Q9erF6ntdvZp4W+fz8VyL8Mpc2cs2U7Pskdhojvle7ocNvmaivkT9VAi
         bGTbcnr7GFtEyb6xVf+ueEtetmBwixoI0Y9rlOUtIDOqvCOmaJ+mIJrENADyBfeZfUm+
         tW4j6L1IJN8dGgOU2m4ZEXRaUDlS8Ta5sxUrNK9MvyHpAw2e/cE0jUWcrGti33Vcs2d7
         9bGWXYkeb7xRpzCu89rTU1HGC/ckxGjuWUrT1byVqbk44XTexS8yTnnFmaC9x6oZyg4b
         V6Iw==
X-Gm-Message-State: AOAM530FFIus2YDitYni6FJxMkH31ijlMZ8J8gQ3hrDr+pmt4GWMjSpl
        nougfV1RVtL5Gv5v+OeCK3bRDyFdo+IYfSYEjX053jTc3oA=
X-Google-Smtp-Source: ABdhPJywTEjDDsAJ3e2i9lq67sW5yG7cGn52ORrsxqRySJERYhamjdPpPNV2M9OfBpBdjxFfKfBZZTVk+dj86uuQDrw=
X-Received: by 2002:a25:3142:: with SMTP id x63mr11661377ybx.99.1635096605465;
 Sun, 24 Oct 2021 10:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <CF7T869H4UYO.3GYODDJ6QKL27@MacBook-Pro-de-Robin-3.local>
In-Reply-To: <CF7T869H4UYO.3GYODDJ6QKL27@MacBook-Pro-de-Robin-3.local>
From:   Robin Dupret <robin.dupret@gmail.com>
Date:   Sun, 24 Oct 2021 19:29:54 +0200
Message-ID: <CA+G124W0UnQ_qBUwL6UAEu81ugpo=EYR-QS=xX63afbYvAEBoQ@mail.gmail.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
To:     git@vger.kernel.org
Cc:     peff@peff.net, junio@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Sorry for the late reply, I'm not really familiar with mailing lists.
I resent the patch with an ammended commit message.

Actually, the goal is not to add any maintainance burden. I just thought
the original prose was not really intentional. Feel free to discard this
patch if you doubt it brings any improvement to the code.

I'd be happy to send a more substantial patch later if the opportunity
arrises. :-)

(Thanks for your comments and again for all your work on this great
tool !)


Le dim. 24 oct. 2021 =C3=A0 19:25, Robin Dupret <robin.dupret@gmail.com> a =
=C3=A9crit :
>
> In-Reply-To: xmqqbl3u5fhy.fsf@gitster.g
> Cc: Jeff King <peff@peff.net>, Robin Dupret <robin.dupret@gmail.com>, git=
@vger.kernel.org, Robin Dupret <robin.dupret@hey.com>, junio@pobox.com
>
> Hello,
>
> Sorry for the late reply, I'm not really familiar with mailing lists.
> I resent the patch with an ammended commit message.
>
> Actually, the goal is not to add any maintainance burden. I just thought
> the original prose was not really intentional. Feel free to discard this
> patch if you doubt it brings any improvement to the code.
>
> I'd be happy to send a more substantial patch later if the opportunity
> arrises. :-)
>
> (Thanks for your comments and again for all your work on this great
> tool !)
