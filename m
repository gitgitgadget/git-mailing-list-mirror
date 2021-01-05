Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10057C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 11:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DAB2250E
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 11:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbhAELkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 06:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbhAELki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 06:40:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC74C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 03:39:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v14so2742333wml.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 03:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guestpostingfirm.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=66VBKWVRN0zlIsA1qFA4XZQ1IO/NFBpe/zzPOjr6dr4=;
        b=Jdd5A0gjvjZ4jWlhksoNNAJLZMLvPogVQeKWyVTRnEniAQqqQ7oDIk1KsX67mKfpje
         l51zDWRIeFp+ilgM4gpP6l2qr2DOxb3oojz6qkIVfdeLnK7q4sX1j+s2E2AXswg759DR
         4673zwVb3IO70qeYFPUDQ4hoQRLJ99Rvi9nv8Il6/n8SxheHiyBEzdJEBCFAMrX6fcHE
         E0yt0V44BvXLjFuqT/rfu3LUrXxlYyij0TJ7oUDzOuqYQmOTNFG/sREaDWCgQkaD9IBa
         2+v0lzsY1KcCHvXhJ33LxauQry1Mm1/esxJNYjrzqSYQXTwgfMayBZKaKMh0Bf2clFJ5
         rcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=66VBKWVRN0zlIsA1qFA4XZQ1IO/NFBpe/zzPOjr6dr4=;
        b=q5JF635PfkPo2M6VwSobht12bLxuhKmjOzdIOsjsREial0WpUWXNqMFdOKikaBYYPE
         I5CHnij8/iDGckVLUfDkXK2Ml+9trCm5soIKssGhZ7EZxCilmmroHHFFrl3Hp+ChUihQ
         YJf8HyErKa8z4td4P18NiLCYP/zua1S8WZ1AGdCIsJUeCn1X8j0LxLSf5gtZm+wB7l1a
         MY1brazz8kVIMql4x5Tx37tGKDNYbnzwb3GUOVrjgM86dkoFrUmt1+jsMA8oDEn47p1E
         kL7hPL1hg1U0kir68cxxqqZSLXbII7ZeDfohJsI3oNphdRITwXoXqnn+LqfV0Wa8azKi
         oINw==
X-Gm-Message-State: AOAM532CJLvgYUNVpYB83qRHsNZeguKj6nI6y17xLX9O2n4MyLTbUlbK
        NZA2fRcMBAqB6fbUXIJs5V0wlx/p0hkr0rUE
X-Google-Smtp-Source: ABdhPJx5u7BYjog50WrTtIam57or72r3Z6TukWVVwERmZtHVAg5BLHwwZk38YUrAAaE8L7CsGt6g7Q==
X-Received: by 2002:a1c:2483:: with SMTP id k125mr3102751wmk.67.1609846796354;
        Tue, 05 Jan 2021 03:39:56 -0800 (PST)
Received: from DESKTOP9F9T06U ([72.255.54.232])
        by smtp.gmail.com with ESMTPSA id u205sm3991761wme.42.2021.01.05.03.39.54
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 03:39:55 -0800 (PST)
MIME-Version: 1.0
From:   "Max Micklem" <max@guestpostingfirm.com>
Reply-To: max@guestpostingfirm.com
To:     git@vger.kernel.org
Subject: Paid Guest Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Tue, 5 Jan 2021 16:39:55 +0500
Message-ID: <71003861495442495121466@DESKTOP-9F9T06U>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I hope you're enjoying good health.
I'm reaching out to make a partnership with you for Publishing article on y=
our website.
I can provide you with multiple unique articles for you to host on your web=
site.
Kindly let me know the cost for including Do-Follow Links in the Live Post.
I can pay you through PayPal or Payoneer.
Thanking you for your time and looking forward to our future correspondence.
Kind Regards.
