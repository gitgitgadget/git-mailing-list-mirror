Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092BC433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CAD207AE
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 10:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhAQKO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbhAQKLj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 05:11:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94965C0613CF
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 02:10:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so10164330wrt.5
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marketingstrend.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=9NV6nqppQ+hm+uhdwh/TaJGX3eAy6b2AeEnKyySUoj8=;
        b=JVnhcst6KJdM0HH5sOp2kmYmdGqSLfrnmUtZdy3YrV8xb/N0NuLonxoPA17iW4Y3TP
         XOW5HRdXFYuqip5Vz3w3PYdgezfzVSH4Rs0Y0pWa5onkCbjWyRBX8xwdy5tzTyZtN7ED
         q9r4sM+pdv0A84RzX5m3DfF6e/fZy9uedF7dqZSBW0uRDCvwsH+I4K+ijM8xVwXRs1bm
         OvFSSPa2IoX+oHPX/loiH6Dzbu5uR2QeDJRasW1WpB3Ns2N/HNTsjJHwOVPD9U2N8ZLx
         avN6JH0kIzQsABNx7h9f3OP6pSzvR462gdKwv1/UccRSTT29k9zdaWzOg7WZm+C35FPA
         v0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=9NV6nqppQ+hm+uhdwh/TaJGX3eAy6b2AeEnKyySUoj8=;
        b=Aurt9cNPUq7FcjrSuyU4fiweJ81nFI1TnxXjAzEMjTQOJTComS7jG1/hd+FA/I6kxR
         UW6OJQVD7lCXYcVC2KE5A+SkWGEUZbt9WGz2b0WJkeP3RsRKKa0sLvVmhxNsWxNKKg2s
         koZY18jKestGOW7uD6KwDQ2WzAWT9763SnqILFOjUeCv7LVOpP1LCgMjCnJmXkcs0qTy
         qssgdo7wv4fNP9w0FSfhttGA2c00FTrq52G7ed/NP+GSXZAd6B6rM+YOKGS/KCstLYAu
         aQEHGN0WlVviLcaCyycDYekcVF3CM6AVKtNdWbgT4SelkeuneqM8BNqyP8BrEJnNKrPH
         KQ6w==
X-Gm-Message-State: AOAM530hJ5MZopbBBF13Db2l356sv+1C2vZSlUcmYkpebWdbxjDI2xsk
        RWtxwVSoUIDuOxPPi2en5iZV5lQdY6SKjQ==
X-Google-Smtp-Source: ABdhPJzKN4EVYbAEk2vNetW66xEwYcwtL/sSC9Ux/fGAwqBxFuygYJy/xUi0gtOGjAIgJV3jfl/rpg==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr21208093wro.388.1610878257118;
        Sun, 17 Jan 2021 02:10:57 -0800 (PST)
Received: from WimaxUser38169-226.wateen.net (host-3-net-99-160-119.mobilinkinfinity.net.pk. [119.160.99.3])
        by smtp.gmail.com with ESMTPSA id o20sm9588948wmm.24.2021.01.17.02.10.55
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 17 Jan 2021 02:10:56 -0800 (PST)
MIME-Version: 1.0
From:   "Jacob Grose" <jacob@marketingstrend.com>
Reply-To: jacob@marketingstrend.com
To:     git@vger.kernel.org
Subject: Paid Guest Posting
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Sun, 17 Jan 2021 15:10:52 +0500
Message-ID: <257922566980325555589@DESKTOP-VFC0561>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I hope you're enjoying good health.

We're professional Blogger Outreach and content marketing agency. We provid=
e long term relationships with our clients.

We provide articles and non-promotional content to blogger relevant to thei=
r website niche.

You can help us by placing an article with a do-follow link on your site. I=
f you're interested, then tell me the price to publish my article.

We make payments through PayPal or Payoneer (Totally Your Choice).

We=92ll be happy to hear from you soon.
