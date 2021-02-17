Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25288C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E490864E42
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhBQRCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhBQRCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 12:02:17 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF95C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:01:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v16so4267626ote.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX4g5y/MluPvD8UiRbuhyzNB6HpC0mId+TA+mNnIlaI=;
        b=SngWJ5hbXk5gcoNHdbcUyLRn+Xkzz1h42SimGOQFwl36Kd1fCI5aS8THvTO+deu8K3
         LO2VgEg4j9khcoqVSoiT8OtZykjOc8g1JeDN6PyqPY530knPxL7t3Gocc9N0kod8V/ZQ
         gWatAVHuLo0dmhl7E/HteS0P8fYg/Fxm9UwP7fB2g/pMSYnTJAOVRuHYvUwAW3S6lgXz
         FgUwo/94Bo5TEcYB+NMgAty/jKOVz2CUVoNoZyCHt0g53CJ7t0qYGu3oAZSkIgRyFZHq
         uKwbIRiv8S2JwUjRn0jLpAs5VJTk+DdLlFdTtgOt8mgbe3ETPKS/643a2Ri0AZuTkyda
         KfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX4g5y/MluPvD8UiRbuhyzNB6HpC0mId+TA+mNnIlaI=;
        b=DZXgCPUuu0/SPeDrvZMDRakq5YLE6qh7mbx6pZ3eEiS8ZpOZnjuMOTW7hcQeIKTwwP
         YVVcpDXYmCXWCRzI73Tk8It0cz3L01fKGRR6Mxp4VJ+xkeMDcumIs1KhwsdmgR9VqYFx
         oZiSmAUlCKwiGZ9MzOqAoR/7Ke1r2ECNHmx4gHdzJ8qXIa8vHB5kmzRw+X/kHkx9J93W
         yVbZS9i/TNGVRurMIQ2oSiHs2V/thp+8BamjZO3RE6mETNwwtKD3Bvpf23zPaGpktDsY
         A17SuEZZWrbQ6Li4KMmAkjROmic6D8B2XElSG0CEiMMyCmhaYUdH3w5PtWPPNkbw6pUO
         6AFg==
X-Gm-Message-State: AOAM532P/+SrNBvYmh86iaih+KAdp9Ju512rf0sU8vL7GmbiuFM/YlXU
        4ucLFCyaqwkKuQ0DTU+06p4Y4GQR+qp9EoVZ/qw=
X-Google-Smtp-Source: ABdhPJxhO4UHafh+LwA9hCP0t1fwAhepNoaF0gmmLrjhVY/05ZS3azeTQ+SWS1QvXYFtxNqO1BZgBFLXCcRPU400gTs=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr93063otk.160.1613581296252;
 Wed, 17 Feb 2021 09:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
In-Reply-To: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 Feb 2021 01:01:24 +0800
Message-ID: <CAOLTT8QomB6y-o9BuxO=1WpYz0TpcmX8bjDhOajUKk7egEiPZg@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
I am a Sophomore student, I am also very concerned about this issue.
Has git applied for GSOC this year?
I love open source and hope to have the opportunity to participate in
git GSOC this year.

--
ZheNing Hu
