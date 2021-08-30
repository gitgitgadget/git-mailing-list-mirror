Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB10C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840FD60F5E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhH3QvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:51:08 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:41674 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhH3QvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:51:07 -0400
Received: by mail-ej1-f50.google.com with SMTP id t19so32500338ejr.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXrg/mP0FWofGN+MIM915KM0s5UgKjoUktcmIE80X8c=;
        b=Lgri4MjzudaEwzXnngcQnC8KPsC3iXQK1UlTCLuPx/2wPRLZj53LW0vA6nIoAgxnCi
         NXT1LXKkNi7e35nTK/Gcs9oYD8P/B3AnZbi1JmEaPVAY2Z/LWVMI6l31lqBdw1dnY5FR
         AJlcwkt2qX/cWtXh19+3/IHdzb4C9qEVvjw/iKKAwUhbLZx974HYXepZKhRXqwHArf4L
         JRiIpT8wD69fsPo8MxrwtlqoGbgb6ZOSbn8u8dDUcts7cgPc3uXi1vXJ7Yf7ZBiRf1O4
         YuNm3zoQdaS9tJAQ2uR9zVbLJJ7kClSEC+l0oVwVYE8zWy3jurDqabUN3uRn2N2nY08K
         5YBA==
X-Gm-Message-State: AOAM532CqADLipStf70L6WsqDwi5UnykkBG2MWC1qBoS9opdeBeFJO6t
        lHCGxhAEoR8Jde9TynDeLi/mOV4e/Oi1TVHTSN9Y3A3N
X-Google-Smtp-Source: ABdhPJy9BCjW3iWd8s73fWHltbg/fHy97IQ9ar6Gr2nM3N7GJM/+uQkCZaYybES6Tq+pMy4cwqoDI12+poGlLS9Zqr4=
X-Received: by 2002:a17:907:923:: with SMTP id au3mr23945496ejc.482.1630342213009;
 Mon, 30 Aug 2021 09:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com> <CAPig+cRFCtVPoBfMswiO1i6bMw_BUess9q2pto_v4dzHp9X2RA@mail.gmail.com>
In-Reply-To: <CAPig+cRFCtVPoBfMswiO1i6bMw_BUess9q2pto_v4dzHp9X2RA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 12:50:01 -0400
Message-ID: <CAPig+cSZbi78MUzyd_S8J1X7wpH_KWXWLSn5Obott7ZW30q8kg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] suppress trailing whitespace on empty "notes" lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 12:45 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> It probably won't surprise you that this fix to `notes` started out as
> a single patch which made the change to `notes.c` and adjusted the
> existing tests to account for it. In particular, my original changes
> to t3301 were exactly the same changes you made (i.e. merely dropping
> the empty-line `${indent}` from the few necessary places). I wasn't
> happy about the additional complexity I had to add to t3303 and t9301
> to continue plucking the notes out of the default git-log output, thus
> simplified by making those tests less brittle. That, of course,
> deserved its own patch. I wavered quite a bit about whether to make
> t3301 less brittle too, or to simply apply the minimal changes which I
> had already made (and which you made independently). Eventually, I
> decided to split that out as a brittle-fixing patch, as well, to
> better future-proof it, but perhaps that's terribly important.

...that's NOT terribly important.

(last-second editing mistake strikes again)

> I don't have strong feelings between my v1 and your v2 of this series,
> and would be happy to see Junio pick up either version.
