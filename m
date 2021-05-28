Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B9C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4A2613AB
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhE1P4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhE1P4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 11:56:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064AC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:55:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so3879664otk.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=prTBUvL5CBcZrZUt8kPcZkRUOhsmPVyG22pKv+ZUCxo=;
        b=Qm1JGj015G5M56vZYiMhK3EEEQYo0Vx6lbJY4+UscPuqaBlNvmP2xpRmpfHBsoEGB7
         huXDU61VSGPysFb6XviMahupKZZHiaO3+ctt8xfYaoFBjF+rc+5icyFDMy+HHGbmoq9M
         yCsdMMOrxUS5iJ1lWwnqISjC3TCajplwVRrJjW7YVxzl/qo7tTqZvDedZqO+1doSIe7l
         9Ky64MrR+mL5XjAddKmc951lmfg2Cdn2Pq83QvUNUToY4rRsBTHPxFMJyn8FkNr+vJah
         w6ltvEk1Zc8hEOAhHwv9fSinnmHHSo0bOv806/mI/NNmf3j/AuzpUlQlb1Sso0Xa/g72
         /juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=prTBUvL5CBcZrZUt8kPcZkRUOhsmPVyG22pKv+ZUCxo=;
        b=WvkZ81MhxmigJCh7llYhnec2k18XJsNfeP1sAq/MkvHx13K32Oaxia0+QLVkNiVzXa
         W15QpbsCFjtoaE0Queg4G0CO8tIMV4trSvfiw3bw5w+JPw9hjPufuuD3EJInGCxIx36L
         0SlIL0Y2M1ERj3A2HeGAJT085d/aOsKItNBq0cPbd/LICkDmLDop9RT3Ym8ncTaC8QCP
         bvl8Q+H0XDmKJRdQ1oHOOaOPMsTPT8IhE9QtTHed33sM2/Pzy5Y1UV9fhvDV957eEDTU
         QvkSE10KcT8YCOVU6nZNDYfYkmjtmNUwmUZ69VceppKYqdFiJb+OIOcO2/bhebue96zb
         AQ7Q==
X-Gm-Message-State: AOAM533MDoh94POY2sK6vNBCkEGlTDqcXAC1zBzGu9Uwv0UvN/eNbAcv
        F3O+THE0VEdfEHLJRFHqAEU=
X-Google-Smtp-Source: ABdhPJxtpGixiFw/ZY1lkZVkOkbGeMz4eitPz5Xgxn6pWRH5JF/vInlkao395E6l4Y6RPFnshDhrow==
X-Received: by 2002:a9d:225:: with SMTP id 34mr7380657otb.330.1622217317248;
        Fri, 28 May 2021 08:55:17 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f21sm1188362oou.24.2021.05.28.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:55:16 -0700 (PDT)
Date:   Fri, 28 May 2021 10:55:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b112638fc47_4b03220885@natae.notmuch>
In-Reply-To: <patch-10.13-9f21bc6e6f2-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-10.13-9f21bc6e6f2-20210528T092228Z-avarab@gmail.com>
Subject: RE: [PATCH v5 10/13] send-email: lazily load modules for a big
 speedup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Optimize the time git-send-email takes to do even the simplest of
> things (such as serving up "-h") from around ~150ms to ~80ms-~90ms by
> lazily loading the modules it requires.
> =

> Before this change Devel::TraceUse would report 99/97 used modules
> under NO_GETTEXT=3D[|Y], respectively. Now it's 52/37. It now takes ~15=
s
> to run t9001-send-email.sh, down from ~20s.
> =

> Changing File::Spec::Functions::{catdir,catfile} to invoking class
> methods on File::Spec itself is idiomatic. See [1] for a more
> elaborate explanation, the resulting code behaves the same way, just
> without the now-pointless function wrapper.

I would reference `man File::Spec` rather than an email.

And while this change makes sense, I think it should be split in two.

Instead of doing:

  -use Term::ANSIColor;
  -print color("reset"), "\n";
  +require Term::ANSIColor;
  +print Term::ANSIColor::color("reset"), "\n";

We could do this in one patch:

  -print color("reset"), "\n";
  +print Term::ANSIColor::color("reset"), "\n";

That is just no-op noise that we can mostly ignore in the review.

Then the actual change to require Term::ANSIColor selectively would be
much simpler to see.

Cheers.

-- =

Felipe Contreras=
