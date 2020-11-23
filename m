Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B1C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA41620727
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9xsIOY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgKWThp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgKWThp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:37:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F28C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:37:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d142so306815wmd.4
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esBk131LoEv87ZSu+nPyombOGvaRjVGDPEHwAzPHhsk=;
        b=P9xsIOY4Ccuv1bxtqLMEk8npxO3oDZpNrhIAxmfXN6tFsoI88UasySdVIYpShPFrLf
         RHyCxgvmqlyU4jFUi1N7rxKnIWwMkDG6+uDpd9TG+Vh3Pvjt3bGP+7JaAFBPpbgdICsE
         oad/RjiMCQYrJQ8Q1eWoI3EmQyX0HZoCtRdMFy5gEJBkQg+u4Z/jjPFoh7SjIMOqAS3L
         90C/CHmFtaVms6Uyek0jUIwlcbs87FzM29TxIOTliEztZrfvu/P5+DZXd3OEjvRSvylS
         cMK/LEzwDFFQgVvIvl8acIvvEb6cmXhA37BtZvcw6V2E2TOE+QRmf9CjUzSRBPd2dVgN
         DLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esBk131LoEv87ZSu+nPyombOGvaRjVGDPEHwAzPHhsk=;
        b=J58ejKMkq5FTX6hzoVnGxPmWYNyFX0BoUN4Jp7aIs9wD6V60Ped4qAqn9G0GZVoatd
         AtCgn3HULOeg077tclSM1EAKm2uGv8SMZQ5JGGmqH00TwYEpB0mjoh24WoYGPLs0GPgR
         KJvyw0xZOQYuDiGSZgrdTW7rHDHv+nx3kR7UBV9hGYtMV0Qe8kuz/KjYIUevi0cadzuy
         0oyzOzxEazWXlSjvU+HxUHUEg/731GMgm2pk5np2CkzRwfpfu5W9sFGRyjnrrhDNf3V0
         /50gFyVK+runK4yvVHWDLbUNqLK32C5HQtrTXWTmgMRHDQJBKy3X8Va2MV5t3tQ1BtzY
         rGTQ==
X-Gm-Message-State: AOAM531kZwqSb5YAitS2ThGHWblR0e8CrKd24wxxtLiCA1PoiPraegA6
        dE9wIr2O+vg5KiF1L6TFBj/RJWoPCODs0g4lxkw=
X-Google-Smtp-Source: ABdhPJxOm2jA13Zp6LpgbXGxHjfJ3plFdZmTOquvkr5Fy2tlI/vz+j0GB0nOqZAaLf7i2ztdBnipcSsxGDLSAUEzJOI=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr462142wmc.55.1606160264078;
 Mon, 23 Nov 2020 11:37:44 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com> <xmqqh7pfopki.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7pfopki.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 13:37:33 -0600
Message-ID: <CAMP44s2H6ubW47RCEs4B4qafpU8Z4Z9Ue3BaAMB-T_pEcxkXig@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 1:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> V=C3=ADt Ondruch <vondruch@redhat.com> writes:

> > While I understand that the merge after `git pull` is probably not the
> > best strategy (as explained in [1]), asking people to change their
> > configuration to choose their default strategy with every `git pull`
> > is not any better.
>
> There is no clear "default that would suit everybody".

This is a false dichotomy.

Yes, there's no default that would suit everybody, but there is a
better default than the current one:

fast-forward-only:

https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contre=
ras@gmail.com/

--=20
Felipe Contreras
