Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58BC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8995860F3A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhI0C3T convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Sep 2021 22:29:19 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33391 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhI0C3T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 22:29:19 -0400
Received: by mail-ed1-f50.google.com with SMTP id b26so14436115edt.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 19:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yXc1Y+eRWg3JTnJM+hZzveV7uf8nnxMU6y/0fH4fY/g=;
        b=VZhcAhLWHLlvTsfPIZyPaSTHmgCNOjcBUMzXz7fKL4//iFoR1H6v0vMNbCxFVzy0Wo
         N0kGCuh5+gzaF/xqVtnYWmioH3t43mXvTrfyCG1NFbUlqiU6FXlTLJ4jA7Q1ZUTMxVb6
         EB2YkcKw1fRcHS9SXMEfOenDWjPL/ERkMwNa88k9LdNfyato1Uai8bj+lmhzIGFZhNsw
         tSGj1rkpYcWVUICSHF4I6EcGsnlzlZC22XiJwA/Sw9FJS/mFO+oavotC3XtEOma2Vfiu
         cD0VPG/dXYuUi+p2ERMEEMSqHyHZ+SHaSbvsSd8Z4NrGOtcyeGslHd8/IhPWo59JVYjI
         YaaQ==
X-Gm-Message-State: AOAM530lfqQdJYwvfl29E4XUB0POX71BQ2WkAU1z8NA06lPNHMGbWMMT
        dDhePvYF8fwa9j0WqS1XJM6ENn7ruqbl6z4mIaY=
X-Google-Smtp-Source: ABdhPJwObb3uMOWzdkcOGw39NkMBBylvYt0rCKAYUgsNh34jUgA6AX37aA/OQVlw/s1kLsh9VRLZiNGDL6tg/ESo4nU=
X-Received: by 2002:a50:e0c8:: with SMTP id j8mr20292553edl.283.1632709661018;
 Sun, 26 Sep 2021 19:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com> <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
In-Reply-To: <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Sep 2021 22:27:30 -0400
Message-ID: <CAPig+cRBPVpa4+2jm0X-u0Ki8bmihS4dycj9RLwf0Mwx+zjOKQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 26, 2021 at 8:40 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In C it isn't required to specify that all members of a struct are
> zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
> accomplish that.
>
> Let's also change change code that provided N zero'd fields to just

s/change change/change/

> provide one, and change e.g. "{ NULL }" to "{ 0 }" for
> consistency. I.e. even if the first member is a pointer let's use "0"
> instead of "NULL". The point of using "0" consistently is to pick one,
> and to not have the reader wonder why we're not using the same pattern
> everywhere.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
