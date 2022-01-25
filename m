Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A4C4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiAYOgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiAYObU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 09:31:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF8C0613DE
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 06:30:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z14so15552433ljc.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 06:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TPIa5JXml+bmTKa4SlL22HXF4gWTa7F9AzyifcEFrjo=;
        b=Ot+vYFqeVpwLCtBjvJDe1UptEHj1hbFgElygWOAiLkm1UHL9pQmB5lAg6uL9/gM2HO
         +7VugIPlSymIwGlc/qHYg91Otlma8jquCAGd6Pn5MxgidjeFs7nNu8Ds4ac9iYr+SQ0M
         fSYW8z552ZJYlNf9N27uV+gBUDHPlC35gQr8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TPIa5JXml+bmTKa4SlL22HXF4gWTa7F9AzyifcEFrjo=;
        b=CHhjiJFgJOJGtUl8u19MDbi+wJ8RGAA6dhtD75iQZ+q2RZZ12e5qRsqmYteyq55EHk
         BbL5aoTpKsUO+AT5YUDpAH6/Yqsusee9ta3Qak3S/tnk8lZJtih72ixeCuGWpqnt+F4V
         bUfNdbu3k4Ih/TAb9fRJsseT/tYiTXmg+x4aWq6licpnvsDyAPu+0F07Opo24ppAqssU
         dO/PPfs1+TrgxT7/9k+uSAVgy9C+0dZ3nZvoJPsmPuucOgnFRjDuoOBAxeiUW/N+VNXE
         ObZezz5/v2/Knmj7213TjJ//aMF+YordauWZnC8yCNwEUBuE73JTuX8qIpkX4wz5cvkb
         U+/g==
X-Gm-Message-State: AOAM533mKk5A+f4LUE08y9fj30V4MGO+/3fRKh00KGxPfhcDVCaTIwbF
        1dSTbhR0C2uLmxDTBYvjzVPkD5AhScrayFqqIpVoH54xIQnIDf5m
X-Google-Smtp-Source: ABdhPJwtC1qrNX5UATGemoqZpv39LB3/PTG9Y8fS8RTo8ZdtKvJrMXiG09EJ8z3SeczlaqZTvNgJ8rSgcno1BdHQrIs=
X-Received: by 2002:a2e:a588:: with SMTP id m8mr4843195ljp.504.1643121027190;
 Tue, 25 Jan 2022 06:30:27 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
 <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net> <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
 <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
 <xmqqk0ep57ou.fsf@gitster.g> <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
 <xmqqfspc3k8k.fsf@gitster.g> <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
 <220125.865yq8ghae.gmgdl@evledraar.gmail.com> <87pmog2bbf.fsf@igel.home>
In-Reply-To: <87pmog2bbf.fsf@igel.home>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Tue, 25 Jan 2022 11:30:11 -0300
Message-ID: <CABrKpmAcNsexcmHK5kZvZr_NBm7TWWU=wVQExHwWSPpprptdQw@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab wrote:

> See the core.trustctime config.

This sounds very promising. It also fixes the problem in my
preliminary tests. Are there known drawbacks to changing this setting
to false? I haven't yet noticed a performance impact.

Randall wrote:

> I think there are more use cases here than are apparent

The use case is Chromium's build process. It creates hard links from a
src/... to a gen/... directory. Some actions do `git reset --hard` in
src/. This updates the modification time because of the hard links -
even when there are no changes. That in turn leads to unnecessary
rebuilds. I have little control over the creation of the hard links.

=C3=86var, everything you wrote is very interesting and helpful. Thank you!
