Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADEC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297A161445
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 06:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhDWGpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhDWGpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 02:45:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05CC061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 23:45:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r20so22578490ejo.11
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 23:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TIBCMmSILlu1zKCxMDfYKwDZy/QBosikoE5szJHiBjA=;
        b=pbVyxtHZwpI6/5iosGr30xH9JrMJ/ICCJUIuMLtcdqmsHNFowvdmYQmyGMVbZR9c+X
         1s9LztursVhIMYDcDqP9rgfUbDHzpn8FouXNF35ef+50Mi34A+ddQKEPE+nsi8BaGguI
         r5+SNDv23ABZxPrd6MKbNGWUp9BrakLEljZKIn5uFL3QU43ZsTZ8XmGBeZpQX5ad5QqK
         6Oi1sqZX0mL2rdpCrc3nPOH+XGL2ANl6b6/V6phMtBs/CviinUXxorUKXyGKm2CAWyiK
         BRXsda6EmvgFyD2pI62fiuGe/NVVyOgZB+unlIpesU4x7IIqgi9AKXU1BVmc7AbqcV+C
         EFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TIBCMmSILlu1zKCxMDfYKwDZy/QBosikoE5szJHiBjA=;
        b=l2o3bmxG3wZ7PIuw6DTLLe7DAbcYvulgoR764F8YcFPjJwG5Kf9VdqJWQzukvp4k9r
         Rcl5QjttVur3KKZQ8fY99dVhGmiN2N+KcT1knywm+VZsjBZjqnPK/cDPTPPpqjK9erc8
         mvV1n9T99tQ2H0EtLB7g8XlF0ASVAUptjBQ8wfH7OEzjjEmzsFYpDoBdR354UjJ4uLq8
         AKJkuUYNi2+vKcYB4O8ESnWBUacc5z7gwglcfGLW1ZPIAECbyPSdWe+xLjAh4bgDzI9G
         bctZx8KOBRV+/QhQB4DOgrZ5XnPuOs0VCsB7jVOJ1FcTYK06nHLRzXPSCiH+ORthxKKx
         ONFA==
X-Gm-Message-State: AOAM530hzmtJYvpr1TbD42eyIHnS9JwmW5SLwAPo5DRAftf3lGjKJqfh
        eOxmx6NzuXRBm3ZA1E0yfrERTrlSr1VZ2sVZNrQ=
X-Google-Smtp-Source: ABdhPJy9mxJFlzCK1c3MTRPOBYTsAPnOPKlFIGDYey4qjOMDKtGN308v/jA/bfib1dJhhEJGqYt5SKVsVN1GlwvTM14=
X-Received: by 2002:a17:906:c348:: with SMTP id ci8mr2566350ejb.303.1619160302410;
 Thu, 22 Apr 2021 23:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
 <20210423063632.1973-1-tzadik.vanderhoof@gmail.com>
In-Reply-To: <20210423063632.1973-1-tzadik.vanderhoof@gmail.com>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Thu, 22 Apr 2021 23:44:51 -0700
Message-ID: <CAKu1iLVwfQ7Y-bOSO1tyxyFaNWum8sKW4b00i1nJCef98_2=UQ@mail.gmail.com>
Subject: Re: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(last patch should be labeled as v4... sorry)
