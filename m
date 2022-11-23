Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE0C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiKWPDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiKWPCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 10:02:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4664A072
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2087060pjb.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFwl63rjvoOJW0d1e0eP1H6pKScq6rF3wgMEGSlhIbs=;
        b=IRO93NNKlP0Fu1noS7xkIyJ89+jMpJEcM7Wmi2zfrkUuKUfs0NBuE6wsEy0H5YisBy
         nqXII8WD+Mwi0A67caCZEelo8vJ0d0XDgTaP5h4TyOkee5gcsiT8Jh9Yj8U+yRMqsyUl
         o4sCgKuT6D15CXTDI8jv473RmWcFqVISqOrO/erJZRBa2gWG6rKHEsbAab+AiB94G3vi
         xWLGPiaMTVAs5CbCustDQcPXilGpyPVwHIoUtJx9w8WS+26q/PeyAsfh/ohXtruKFnpW
         6MY5Enve5WLAT9MiluHzxYR62cesMySA82GtSAYHVZFyYpfP77+gL4pjrR0Sx9FT4TOk
         AWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFwl63rjvoOJW0d1e0eP1H6pKScq6rF3wgMEGSlhIbs=;
        b=M3Zd2qFIIjWuMeSA4inGMGSpQbAeKHY5ba2JKU9dX9h/QVpwzwQKiA9Uu3t9KtYQG/
         CkrUUrf0Qsr8bCNiIZea5CT9VAS9AuDqIBaXtLcv3niNxdcfI6G1tbZgRYmowSQzqNKT
         G4isAVFgodjjqQiRdvsze4nJ3ffl5ekwcqllWtAbDNFZcNsVquSCLR3jsFcbPJLyAr5Q
         odWexeTl9TpyEoFskB0O6GBTkepmNGhejFhsuBEPMkiYM39b6QcaWPiTNxaacJlp577o
         +pzXvq1pGAID5OtWfxiIxVx1JdnjvpF5wSoGGx6l/ZHRw6Dl/S2lnJ0ffeSyw7+lvnoY
         FDPA==
X-Gm-Message-State: ANoB5pnsiOpsRB8nHIxNytsaIShyVlNaUpcs/7M9lFWZDWJnfrucdk8E
        TVIg6FZPj8HQQJTSKuaEr+yVGCbDqvM=
X-Google-Smtp-Source: AA0mqf5ShP3GMZIpGH4wXVqjn10ARiqqdft136JpH1d8GQvDJ7WWCy8AwmOaDmmsPxF3zlLIxuw7fA==
X-Received: by 2002:a17:90a:4894:b0:218:a96f:9eec with SMTP id b20-20020a17090a489400b00218a96f9eecmr17651954pjh.159.1669215756856;
        Wed, 23 Nov 2022 07:02:36 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y185-20020a6232c2000000b0056ddd2b5e9bsm12783263pfy.41.2022.11.23.07.02.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:02:36 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 0/2] Use fixed github-actions runner image
Date:   Wed, 23 Nov 2022 23:02:31 +0800
Message-Id: <20221123150233.13039-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Today I found lots of CI errors of my private host git repository
on GitHub. It is because the runner image "ubuntu-latest" of the
CI jobs is ubuntu 22.04 (jammy) instead of ubuntu 20.04 (focal).

The upgrade of runner images is in progress, and my public forked
repository still use 20.04 (focal) as "ubuntu-latest".

Two patches in this series try to protect our CI in advance.

New CI instance see below:

 * https://github.com/jiangxin/git/actions/runs/3532978329

--

Jiang Xin (2):
  github-actions: run gcc-8 on ubuntu-20.04 image
  ci: upgrade version of p4

 .github/workflows/main.yml | 16 ++++++++++++----
 ci/install-dependencies.sh | 10 +++++-----
 ci/lib.sh                  |  8 ++++----
 3 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.39.0.rc0

