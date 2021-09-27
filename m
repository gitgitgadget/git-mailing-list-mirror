Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1232C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8B760E09
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhI0Swd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhI0SwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 14:52:23 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89657C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:50:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id f73so7395255vkf.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lqR39hBZl3lnf0y7Z/onIDslPxlBa3Q+hsulPbdR7ZQ=;
        b=ByfS/78VeBr+PoQdoZd8xMWIcTH7Gt8xM6MHzf6jfOriG+NMB3OLmiJmNLbvzszst1
         W5eGCg2Zwji48jO/uXjZs91nMSt+L8jXkdKlQZUOsKs0AmuBPV5Kgo54VYoXhRMc0eP7
         x5iBn42pB2vQu9REaxKgBdIyL6RHV5vsQAF/UjxoLGZnDF2mVdgiAzvOq8J4zOWxOZvx
         nqc04HLGnGnAwTs0MFR00PYUqMQ24NMBfvlwryDAXOGTkkaNbBI0RW/klYm+7MOYMRHR
         Z8ew2bIdnvXcCpM8AoiU504AMi2rYbVNnzbtueZkqR5gX71c3vJCHJJ0wILlRKgRMPGU
         h6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lqR39hBZl3lnf0y7Z/onIDslPxlBa3Q+hsulPbdR7ZQ=;
        b=jrUL2HVlrRMheN/aOqjY709gcCnJ1gXB4GGjZdI2lvPMjK3o9BulktS4eE5Qum1T1O
         HqCzLJf9tDsR/4UsViaKK9bXd7wJHKRQBY9A5v/GOEdj4T2CKsgf3NoKo9fldBeEiMCo
         0PGe4R9UABBRGmMmdA5iRxSbev5ymmMKXIDLRQKOb/mbe8FT4UWuvYugpPF/+bE8K9KE
         wQ/ScRNkUOZzhMJC0v/FpFcmhmxWJ07CmLuIH3w8nmpRAchagNqKBX+7fTZ3iVZtzDUf
         hyfiazCITj/L02qMAa13PwMC+po7IkU2B9p9GXS3cuiLm19acEkNbOX055m4sE6HH0Vi
         +F1A==
X-Gm-Message-State: AOAM533BPM8UFGl6BFvJLs/UbNiPw/5queyY//UTlz0e1g8IpTpsh+ey
        zkZQNum3mCcX8RZWdm0vCiU0kfN+jK320d8u1kQyaFnd4/C0Ew==
X-Google-Smtp-Source: ABdhPJz/ivCesht/TRIRWA0XVlGl2P02jtydjZgdL3WenIcbxvFanCHeWwlMEAxJVgUGKobdFkoBQH9VSA8ZyogfAdI=
X-Received: by 2002:a05:6122:a24:: with SMTP id 36mr1677275vkn.25.1632768644463;
 Mon, 27 Sep 2021 11:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210923065251.21363-1-carenas@gmail.com> <20210926100512.58924-1-carenas@gmail.com>
 <20210926100512.58924-3-carenas@gmail.com> <xmqqk0j2q8m3.fsf@gitster.g>
In-Reply-To: <xmqqk0j2q8m3.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 27 Sep 2021 11:50:33 -0700
Message-ID: <CAPUEspif_MAg1==aNWT4q1spOFbsp0cUfr+JjPdc2RLy4F4L1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lazyload.h: use an even more generic function
 pointer than FARPROC
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 9:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > Because of the way the function declaration was done in the previous
> > patch the order of variables that use it had to be adjusted so that
> > it is the last variable declared, as well.
>
> Is it clear to everybody what this paragraph is referring to?  It is
> not, at least to me.

It is not, and it is no longer needed after the fixup was applied to
the previous
patch.  Do you want me to send another series removing it or can be done
while applying?

It was slightly better explained in the fixup[1] commit message.

Because of the double ';', When the macro was used to declare a
function variable
and it was not the last variable declared, then it will trigger
-Wdeclaration-after-statement.

Carlo

[1] https://lore.kernel.org/git/3f963bba-3197-8c52-9828-6d78ef1d25b1@kdbg.o=
rg/
