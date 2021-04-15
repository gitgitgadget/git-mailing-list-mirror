Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FECC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DADF611CD
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhDOLdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOLdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 07:33:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE22C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:33:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g5so29643541ejx.0
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OnbAK1Wxym0SiSXgRpzmBPyUcRj4epap0sI7cnPR1zc=;
        b=CE+8PmNd7i/9QfQrxQT+EURMfi+VwpCnpJ1HNAw8JIaE3QzUsJj8U0Ck8MtE8HDQYR
         Q0psROxQDw2y7wvBAvXlwuRP8W12QbY9IkKhL/mT5lt7q82DOmfNAAnv8RwIzssWL/MG
         FgKoH2PYbSCE/lYVNsQuUJejjbXrfPoRvuHyhN/as8Ebjm7lsk66Fnkqr9yIGHEhjBIJ
         Zuzxz0n2m1FyG/fsFIjebuLOyWtrnkJLZZdg/Ok8BapNICVZ22GVJHi2FwRo0IZTy2Zk
         802bx+1R2218bNStPNO8b3Qy6ibqR6hTXnJrg90ilJXcOYncvSEcEBo73RA8M0IRmdZG
         MS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OnbAK1Wxym0SiSXgRpzmBPyUcRj4epap0sI7cnPR1zc=;
        b=tck2EWqEDffq3DivqZMeGqUsdhY0FlJUhN/8G6nP9Bk+/M7NVdT7GLct1FxDjOdywK
         SVMgxgh7lopnD4o6KADiVxitMCpRDrjySGkjosb+hWQzR7Te1FapaTH1X/7zhE2fFS/A
         P9eBfRqbbyn4/8zTdZAOeNeZpRwlf2csM1utA5ZsvXB3C5qL+14JMEqwU5E64T4ufRrN
         E8udq5y6Rh+iIeQHOSlvhc1IzpjBK17dzgSdTns6gQRqIwNkM9G3e0qDPwqVKr+T9dy8
         spsSCqbR2ooVPodYhKELaKppMnIledkKtIJEcNWG9vsqJtrVlgy4NyI9e7MUEIGfpgOz
         +QEw==
X-Gm-Message-State: AOAM5325nBAxGuPkQjJhOX0nYkDHfxVfc68a7DOj7c4995lovMO9/gjA
        ks+1zqApibNM9fW19SYITNs=
X-Google-Smtp-Source: ABdhPJwaFbdunIRUkjl5m/PVfYWqX1WGFYxSI2AUhr/2//6JWUPEhPZ4sTD9gfel8q5E/qr/JiXT5g==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr2836318ejz.259.1618486386478;
        Thu, 15 Apr 2021 04:33:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p22sm1704464eju.85.2021.04.15.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:33:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "Git List" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to
 test_commit
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
 <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
 <xmqqk0p7b3d5.fsf@gitster.g>
 <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
 <xmqqpmyzm71v.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqpmyzm71v.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 13:33:05 +0200
Message-ID: <878s5jvl3i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I don't care for `--raw` either but couldn't think of anything better
>> at the time. But perhaps a name such as `--allow-escapes` would be
>> clearer, or perhaps not. `--c-style-escapes`?
>
> It's printf(1) style escapes ;-)
>
>> Anyhow, it's pure bikeshedding as I mentioned in my original email, so
>> not a big deal. I brought it up only because the very first thought
>> that popped into my head when reading the commit message saying it was
>> adding `--printf` was "oh, interesting; how do I specify the arguments
>> to interpolate into the `printf` format string?".

So, the conclusion of this thread is let's keep it as --printf?
