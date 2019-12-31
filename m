Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A41C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB288205ED
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 13:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idJKb8Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaNRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:17:51 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44337 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfLaNRv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 08:17:51 -0500
Received: by mail-ed1-f50.google.com with SMTP id bx28so35219905edb.11
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WZ9+gKv/OtXjQHg1WUHAx0dZvgNG6X+nRSWcnOPYOMU=;
        b=idJKb8Qgns0JLeauf3SV7ka0k9t4X/OUm1fIirABTYh+c38gEwNoSHjqQgRrO5vq/m
         fbRhomJNyxDv192/zqHKlX4m3TKFUJfQ/iipZJKE2Posc0l/UuVOex4j7bTu7kMKRBdF
         9PGSuihFFGd2PiIPpok+Z1y5u+4pxeDFz/si6QL+wWKGj86FfJ4t8snCQbycL9bq+ZrK
         +uDbkTdJInfQCAw4w30GBvql8Fe3fGs9eGX5sdDGHG6YC8pkTKU9PLaRfU+Wpvp/zHI0
         xIq86SUY7IYTRSRJTWjvpIjd7D/oKUoHsAjh44XTCYDv1+GXYjWuRiQmb8TTuUkYRU/F
         qGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WZ9+gKv/OtXjQHg1WUHAx0dZvgNG6X+nRSWcnOPYOMU=;
        b=Ktvbnl0CzPaqhdW5+XjZPwW6V7DkIAzVSGIUA+6S1X22NJBXdmP7hXcXldMaKyZtpj
         etPpUeZ3Ym1Abd1ot/y8cEUWnnDXgyCGMCSThr6pj/jM1UDiKEeHvyIygMNLdczy3hch
         pRqdt61JDg/kfxM9ai65eVWZXqGJ2nU5Iy8q4f2/ji1lakwWwWpbspPi+MoeQT5EgAeU
         EcKUgdWvrGDWuAqQbYvCIAQUIl+bn+aSJjm/CtXTZ/hYlJY+pa/dvn9gOcEII49vDZMC
         odMGJkHb/0KWoJpZK0IqgnoZJ4ztfJe1St8isuQnmeTmdY+SGtMVpq6NiJjUuILJO3Hj
         gIDw==
X-Gm-Message-State: APjAAAX6jkWaXRPAaBv+5omgj4v/Y4OYI39LGKGzssfnLie/UepHHaLR
        DV6bA2AhcA2JcnK3MZjNy08piix2
X-Google-Smtp-Source: APXvYqxQ+fOGBNKs9BkrNi+9aq1zyX3ER5aAc1R9ErSc3gjxkFoS6Fkk6k1PWCNNvqZmTqbOuTHL4w==
X-Received: by 2002:aa7:c80b:: with SMTP id a11mr78212960edt.240.1577798270106;
        Tue, 31 Dec 2019 05:17:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o88sm5710089eda.41.2019.12.31.05.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 05:17:49 -0800 (PST)
Message-Id: <pull.506.git.1577798268.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 13:17:47 +0000
Subject: [PATCH 0/1] sparse-checkout: use extern for global variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed this issue when resolving conflicts with our VFS for Git-enabled
branch in microsoft/git.

When I moved the global for core.sparseCheckout along with creating the
global for core.sparseCheckoutCone, I dropped the "extern" by habit. (We are
dropping these from function declarations, usually.) However, this means
something different for variables, and could lead to bugs. I haven't found
any, but it's better to be safe, right?

Thanks, -Stolee

Derrick Stolee (1):
  sparse-checkout: use extern for global variables

 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 99c33bed562b41de6ce9bd3fd561303d39645048
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-506%2Fderrickstolee%2Fsparse-extern-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-506/derrickstolee/sparse-extern-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/506
-- 
gitgitgadget
