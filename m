Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A41C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbhLAJdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 04:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbhLAJdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 04:33:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD26C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 01:30:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so21694116wmj.5
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yeplaa-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=eRNFgOT3SOey6an9CZlG7Bj/F5LwHraJY0/jEh7tBME=;
        b=zR+2MH9qEpQ17SGWiLGtrnXJinM3Zms2C/qjNkWEtF8po6R35QeAyNhcmqpY+8y1qV
         jtlqjGEBP0KfUvGXrfaT9d4QBn5d2xEVZrRgScEhVNKcEo/T+XfVAMna8QIqVs15eObE
         mN0LYPmtaxdPlo8nI76zFoLUJUjBdLd5uzvM1XFOcYoJvKh0gNrcxDIVMNM1k+jGK1w+
         /9PseElfKFLegDONpYHqMDpZwRhQwInU2PPTRwXv6hQ/y5R+wOXRnMYoIu4k3AImYJP/
         28LH+uEu9mITtgLfOUa2SASLmHmZyn1FLrCzYR6nPI9OIVUSP54btCaRuoLcwx74ST7V
         pfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=eRNFgOT3SOey6an9CZlG7Bj/F5LwHraJY0/jEh7tBME=;
        b=ow1smpgANJoHmE1f84+h9fE/gV1u24bkTX+nniOtpfJXitmkV5ub8maNygHCsGscdn
         DQwVGcWCvLpCLVK39Eco+6yt/Oj/4kqe0yrJ1aTaHZ9hdW17c94E+tXg9qoIsFmVokJv
         KhOALfExfQflAlJAdUPJxErTcrzZ1l+odkcPNA1bma5Oo5F0YeFO66Qy6BkBpnReEP2o
         Gd6mBMGnNUirPd2Y5B/rACQ8lsj4GnAVt/o6/k1HjzKor8U19JV1R6EjyW/cgIbwLMRn
         dbHqapQpzR2KQFi8UaePzecEOjbyeuhAyZVHxvW8VSKsf8ErUZ0zzzaYmeSwrfHELUpS
         bNWA==
X-Gm-Message-State: AOAM530LLMjgmkul7qEMQ5p0BABxDvLrPa2EWAI2k0KCQ2JmJ1RNhHaV
        1oI2d7AhLS/ejlPf6v1uDep3vlWV6UqnnCc8
X-Google-Smtp-Source: ABdhPJwQefYlWTDeBqu70rL1i0/4vTZ9okYILvVipOQWy470WBC5LQFYMR7oo2bCw3Mhu8FfU9ecUA==
X-Received: by 2002:a1c:104:: with SMTP id 4mr5458683wmb.31.1638351017623;
        Wed, 01 Dec 2021 01:30:17 -0800 (PST)
Received: from smtpclient.apple (2a01cb0407624500f0c59230b27bcaa2.ipv6.abo.wanadoo.fr. [2a01:cb04:762:4500:f0c5:9230:b27b:caa2])
        by smtp.gmail.com with ESMTPSA id a22sm431545wme.19.2021.12.01.01.30.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 01:30:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Loic Fouray <loic@yeplaa.net>
Mime-Version: 1.0 (1.0)
Date:   Wed, 1 Dec 2021 10:30:16 +0100
Subject: Merge conflict when lines next to each other are changed
Message-Id: <A5C94370-A9D0-43B2-9B32-0935703BCC94@yeplaa.net>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19B81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In a file, I have this 2 lines one below the other:

Repository: myvalue
Tag: 8.2.10

On my local branch i have updated repository myvalue.
On the upstream repo, they updated often the tag value (not updated of my si=
de).

When i perform a merge from upstream to local branch, i have a conflit.=20
It seems that it=E2=80=99s related to neighboring lines.=20
Could you confirm that it =E2=80=98s a normal git operation?

Also, i need to automate this merge. Is It possible with git tools to avoid t=
his conflict or to resolv this conflict automatically?

Thanks for tour help
Lo=C3=AFc=20


