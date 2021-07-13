Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D7611C1
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhGMIbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:31:40 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E5DC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:28:50 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u7so3363880vst.9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=02+8GDjzG1j7TwfeT+SqVpk6FOUbndnkSqIvu55Yyrk=;
        b=kapuieir35hjCcyp1wflBld/rodRt/DRKwWUaRLnErti9YTjDvNJzxwHTAoV4iku7b
         PPwYEGjChrD5mj7LBubWaTROL6mkall0DWj6bDrTnaH9uef53HiJ5KpJ3OsXP2iM6pAU
         FVx7e8DSdNvFdCFrGHjbky6Dgk+6YY3+3qqQC/Dj4a+/x60/1U+Fs54RLoG1uOiyeVxO
         J9yc2hAThJGjnqgAIW4E9mkxf1KXdk69gbWZ5EY7Br9/jFpj68QoqlMiqSPlgZzis5E8
         I5n0qwEqpdC0TBf/A7ZlKe2vGh/kBOAQSO6I56hjPN7aR0MbL43Y0c1AbFJjP/gyFTJa
         nEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=02+8GDjzG1j7TwfeT+SqVpk6FOUbndnkSqIvu55Yyrk=;
        b=Hl/cH7YIG6qKV37d2qI+Ih8uyrYFagnOv2quQwxAAgmtxtFbFJbSV7mtA22zlTY8YY
         8sb6asD4E3jNNofsAp5WZeKDjBNHHa80JR+pK2Caca2rLVF9SlhrN/XySouKNAVdhbCH
         5fOXxvtYO5c8+o4c8fmfZXjgX8cDaqUFLort9Y8eDZraHsJd2g5xHuRygeGWmVk4gpig
         Lw/HVdZFolqrvVEomZz4/CD1zfNAHZdRbdtnbhbIrGHCQIq/R1LuVDqjvRGNV6GSxlEt
         dbd8DhJINvQVwK+Bi7o3bppQP+wZbNSnQ29tBr08NgUx4Ob3MtRUhBfCtddSGPmQkCyM
         Dezg==
X-Gm-Message-State: AOAM530F8DgAD9dWb0P31fzpv3V57LinK/Mwwlef7djegNz/jh1Xlm/Q
        IS/w5M/Yl6/D6y9g6aIOiVErYTqnoNnM+xLp3pFUGQ==
X-Google-Smtp-Source: ABdhPJwfUYqdbpVpbZt5dGpIX3CCsEy90zX36QgbG+tEK8jZw1ot3d6HthbjwQef/L5JX1r9qmzMIA57aALnLO1Lzgo=
X-Received: by 2002:a05:6102:31a9:: with SMTP id d9mr4628334vsh.42.1626164929472;
 Tue, 13 Jul 2021 01:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Jul 2021 10:28:38 +0200
Message-ID: <CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
Subject: Re: [PATCH v6? 00/17] refs API: get rid of errno setting entirely
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> After starting a review of v5 of Han-Wen's where I was coming up with
> squashes-on-top I continued with it and saw if I could get rid of
> errno setting entirely in refs.

thanks for taking this further! Is there a place where I can pull this
code (applying patches is bothersome).

It adds resolve_refs_unsafe_with_errno() to the  public API in refs.h,
and I think it has an ugly signature, but I suppose it's better than
having the output be implicit through the global errno variable.

I read over your patches, and they seem OK to me, modulo small
comments I posted.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
