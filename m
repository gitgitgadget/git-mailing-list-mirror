Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A6C63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLGOes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLGOep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A144874A
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:34:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg10so13776174wmb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=urrhOFqUNXjR+YBCa4PNKuz5vbb3q8dNYR9qrOvvdWs=;
        b=VrovSoQeNwYg/fQGGOdqr1Vd/t3BShKLHKXxHU8S3MkYG8QjX9Tk3S4uXCfl9p0D8q
         HCtd2+Bh24gd4zhL/uM1OorP8MjYufeZ2fUJ1zf8fcu4hF3qckkgZS4gJPGxsZG68sK1
         d6UVDIVw8auaAQq7CSsgUFjZqGpdOZoAeye+36KlElTROGNxOiLyOU2nNM4iQ4dTyezi
         tG3oCtNtr+vnRFSMRQcr4eNGg9TwQkMmsraQ59qfnCaryU0/UNxVwgYM/42bVq+zF0lu
         kLQVY/0aVIBWKUWN/t5q8Db/lwGiR3Sen+I+DdkpRX6PsSEOAKLDjulzUczboLefZUzs
         9+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urrhOFqUNXjR+YBCa4PNKuz5vbb3q8dNYR9qrOvvdWs=;
        b=XZEx0kiO4cwk0wodp2UR/DXp2pTEzmaph6C2Dy6GzcPYmbFNMehNLb1TCHHsPaHtXu
         cWEe/gRpf6NknjdTaOG0xtw/09MLjv1ErF3themOQpauv9soXhDGE09k1rxYweF6UM5T
         oyj9oehHmV0J5WC2RXKkmDLSlGyEkL0vI+Z1uc8xYoClhXh7yrwnygSsExcc+bP1dmgW
         U1+jlyvSeR004ZunOiJ1NzKdo/xr5tZaGl/dXtwiXhDQgUsE4iQ72O4AfJwvoGfcGs4o
         FYTh3wXUXLS8hdEquf9GG4PPifyPKFphSpnMIKMVpmIuAS9bixC6gftqHKe8SJ47V1t/
         Yx0Q==
X-Gm-Message-State: ANoB5pnMup7Rrk74ANVk3pSLuIurch6C+mBQHv1UDFu16P8Qw4Me2UQs
        8CEn+Vw9dD+ccs8IpBY+Io5JNbDxmLE=
X-Google-Smtp-Source: AA0mqf4eKDWwMWpkPH1hFXBkEpe9K3mU3UIj8OH69jG1/z0ZU8LP0hHNW9NT+dOejSe7ci6OL8N2ZA==
X-Received: by 2002:a05:600c:3590:b0:3d0:1489:78c4 with SMTP id p16-20020a05600c359000b003d0148978c4mr56241370wmq.167.1670423681945;
        Wed, 07 Dec 2022 06:34:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0022cdeba3f83sm19382897wrw.84.2022.12.07.06.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:34:41 -0800 (PST)
Message-Id: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:34:36 +0000
Subject: [PATCH 0/4] Avoid using deprecated features in Git's GitHub workflows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are using a couple of GitHub Actions features that have been deprecated
since we started using them. One of these features is addressed in Oscar's
contribution over at
https://lore.kernel.org/git/pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com/,
on which this here patch series is based.

I waited for quite a while with submitting this because I did not want to
interfere with patch series that are in flight, but it seems that this was
unwise, as there is now a patch floating about (ab/ci-retire-set-output)
that partially fulfills this here patch series' purpose. However, these
patches are more complete, so I proposed to supersede that patch with this
more comprehensive solution.

This patch series is based on od/ci-use-checkout-v3-when-applicable.

Johannes Schindelin (4):
  ci: use a newer `github-script` version
  ci: avoid deprecated `set-output` workflow command
  ci: avoid using deprecated {up,down}load-artifacts Action
  ci(l10n): avoid using the deprecated `set-output` workflow command

 .github/workflows/l10n.yml |  4 ++--
 .github/workflows/main.yml | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 14 deletions(-)


base-commit: 6cf4d908a92296654f891d440fe09d9fd34b2272
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1440%2Fdscho%2Fci-set-output-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1440/dscho/ci-set-output-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1440
-- 
gitgitgadget
