Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A19C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466162076E
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyC9WbTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgFZGDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZGDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 02:03:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DFC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:03:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ga4so8173105ejb.11
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OL3IaOVoR3qmjFPkBDzK4BttRnr0golk7RkdJbtHpU4=;
        b=ZyC9WbTVR5R2KkdAMYehrm7HhQJm7pAhJIS24U/Iq55pCONebUxMbewD33QAQfdkhI
         E6/jNKZDRPOMABhrOvwxSWSh7YDF+qhfnoATT+D7DR5Q8QF6ARCMLZnzt9627LP6j4yk
         XRrH3zOKESKsrzwhi928+NALxUBfWXv/1lT3b5G4TvRl+Q1SZzUMakD/Aon6gQ1Lg8pz
         4s+ALK+AoOuSwC7/9b+oDIgICprOMxdxKeZJNq6URn80X9RjdpQipYH3KupqhB5swylV
         nUx3crkoH2bmBtoSFZIZ1KURzfSMCHsTsmTRAxki6fteb5GEJp1qtoJJdZxzoccORA35
         nIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OL3IaOVoR3qmjFPkBDzK4BttRnr0golk7RkdJbtHpU4=;
        b=Vo4Z3oRgFeZEvM1lniGIDJoVEUhZ7zATmRCkabrAwSK2b0oNJ3lV6IW7c8Hf8quA+L
         2VJkfvM1AWfEKjwoRmBCvIfnFuktdfPU1GBMNPypTtNE+NyNjZmm9u8YM56jOKHYC8v0
         1TD8C5hHxljNFTV9uXu18jYStxEmlAmEIGwBVR+M4HfIt40oS2x/7hVRFG+3wCjzgjBL
         CFYifNfKkyYwgLOFDcKwvMqcxft11qVYeZ/f6FO6wP6eyQ42cgdbWADhX8NnaPxC1Jmp
         Q25okcDPjQSg9JyfXCIeKcoB4NXbj/HekCZFZfdDA4dOte2tUI/Wnvg0ZMUXqzk3WvKn
         gMag==
X-Gm-Message-State: AOAM531edEXmw7mppFPuGu//LhIExX2ZB6VSa7FtIrvNtOgyGnct26qj
        dzl2jK0M7a/p/wKEZMf61eS4cz+vln9k+xzvetk=
X-Google-Smtp-Source: ABdhPJxNPIqWIWfH4MTROsImECPCLw/TXOwYFUYKeER48RnVp4Sn3eKGCfsFdwf6yzxIAPuRK/f/ut30NiseEosNbZk=
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr1186560ejf.197.1593151388391;
 Thu, 25 Jun 2020 23:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593115455.git.matheus.bernardino@usp.br> <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
In-Reply-To: <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 26 Jun 2020 08:02:57 +0200
Message-ID: <CAP8UFD1yE8HRxEdw72T70Jw0Eb4RWDze0pD6sNUfF4SKMYuyWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hex: make hash_to_hex_algop() and friends thread-safe
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 1:35 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

[...]

> Although these functions don't seem to be causing problems out there for
> now (at least not reported), making them thread-safe makes the codebase
> more robust against race conditions. We can easily do that replicating

Maybe s/that replicating/that by replicating/.

> the static buffer in each thread's local storage.
>
> Original-patch-by: Fredrik Kuivinen <frekui@gmail.com>

If Fredrik gave his "Signed-off-by:", maybe it's better to keep it too.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
