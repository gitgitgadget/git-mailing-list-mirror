Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54599C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 17:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGMR55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjGMR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 13:57:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF82722
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 10:57:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so8254505e9.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689271072; x=1691863072;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccrJ2uRDEAc01kbwnQwbwyiDKrIFrjQu4Q6eclR+Epg=;
        b=IHrNFElTXlDiU9zQBFCBD7jdEK8gJBycBid/TmzBzXU9Jz85OyD4car7W9dvj4wYef
         LZZrdapJg5ulxe2hZF1sh+h7yT+yDwuVnYB4PoxIntsb5uKZuKzNxl501w5dVxR8QhVf
         XLLld+Ef+FKTnjDzs4rouisP/ntxmHf2MU59no066PXtwD/nXXjkPT4e1q9jIV9iqBfP
         N1wLwgvgkCEXc+rluQEjQyWN2jiBj1ynJl3UF1Q/Y2j1PRRrlEvPSMNTWHi7NriXATEa
         woVL+4/Mw6hyCMH+GvdEKMgetLgko+G5bAtdnAGM/taK3Py18kWr06uVVH4gL61XntVB
         F1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271072; x=1691863072;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccrJ2uRDEAc01kbwnQwbwyiDKrIFrjQu4Q6eclR+Epg=;
        b=Jzr47XY48VIqHNOsZYwA2IoNXpJvlfX6/UmNHXow0Jk2RcZuKXFdyWTzuUO6WeB5mn
         NOvSUupHqYlYmCUO7I2yrqtoTb7ZrgYufpmUgxjYhYbUHgdRsL6RuAaJx+QLFKXH3NFb
         vuG+sVH2moxoqjRBfCL3+DDEMxb5/3EdESjqi4eRB2QWFh1M/2ueqq4o+9nxYGBM6Y5s
         ZKT1ZXjeMngIzLuK0KeAzNlm1pCjcJoMUDiWdamQwZrzll2EqAp40AdfrVvPUqym2Ehg
         ofmfMGjIXkCAXnFBmLAzQDzGj/JozpSi5mSPS7wimavWd2hF3x7C2GIRk4vzyD375atA
         CE3g==
X-Gm-Message-State: ABy/qLZ744DgxzAfV3C00t++oULKCw5QOn6VEU1hC0Zf+FoAvMYJvgBI
        iMgIJvWShK4p0Rif6xlpMhz8hwGnOZY=
X-Google-Smtp-Source: APBJJlGOplBFZZdVTO7qqr+6Q6nLiaYTnaZu/UlOhn18M5IfzU4B6678hNkVvTYLKHwsKOMfiilVlA==
X-Received: by 2002:a05:600c:da:b0:3f7:f584:5796 with SMTP id u26-20020a05600c00da00b003f7f5845796mr2525326wmm.2.1689271071587;
        Thu, 13 Jul 2023 10:57:51 -0700 (PDT)
Received: from smtpclient.apple ([51.235.13.85])
        by smtp.gmail.com with ESMTPSA id q15-20020adffecf000000b003142439c7bcsm8561453wrs.80.2023.07.13.10.57.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2023 10:57:51 -0700 (PDT)
From:   Fayez Coder <fayez.coder@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: I delete files by mistake not in stage area
Message-Id: <129BE2F7-847E-45E4-8A22-CC76EACF3543@gmail.com>
Date:   Thu, 13 Jul 2023 20:57:39 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I deleted files from my projects those files in change area not add it =
to stage area ,can I restore those files=20
Best wishes , fayez=20=
