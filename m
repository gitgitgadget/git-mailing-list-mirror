Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A6C1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbdL0Q7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:59:05 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45840 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbdL0QtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:49:12 -0500
Received: by mail-wr0-f170.google.com with SMTP id o15so4982188wrf.12
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=or7IuMBA33mMeietDF81Sv0d7WCC0XdA3q6SX5kXg/4=;
        b=Vlfac4prla3c54oHSmdqAZz63iJGa3rXCTSNlAYoLsVxrdsIS9SqGuk/W5YgiKcxwJ
         VXHoLYxNs0VPlmaSS+AkrbNBsida+UxqJkoz83KKCqnS+HCBJ4AFfOijbqaDNaXMgmZz
         5LSfEjmbpMHb2ahqd3CPzNan0cbpoLivgFpS2SBZrwjJ/XzKoukmTKXF0G9AXmGaMfrj
         OFHxh3r2/w9/6/2Yow6vhf+AgDA2azTBAnC3H82kwZXLF2Jn5G+1Lv2F0Jqy/M6bwlSV
         2cGtZ3BQ2SCHEh79Y5fFKDd0MxGoWH1HNnupzXFfapYroB0T5ZSURoZ24QGtmrLXc4wQ
         1fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=or7IuMBA33mMeietDF81Sv0d7WCC0XdA3q6SX5kXg/4=;
        b=a+M7d3bSJ2DUtQ4nCDCON56Wgb/aqxzARk3wgdX1aLrWIzf1pBO0rs5hX/BOvsK1RW
         oBCat2gse8QmzjtM4ZKgiVzlSVMGbz33WLbk6QM/ywqiofaCf3ndD5a+HqlhKySYk240
         fw3PJb1UhTckn4SaVunVdS/TT1wJ1FZhRA73AGy1FCncIggyEKcYUsmdai3NaLr2VzXI
         3hnn55cXXS8uez6Rp36B1u/EpeLT/LZQ+/Zfb7yzRJEzxMlroFISrINqXuz5+uHRZ9fJ
         k2VOjb4WZjwSAsCl7gxZ8xawtq/n4fzbyKbPh17/wzlpZJwM9+cGLTjYrRj0lIkLo2sc
         oQdA==
X-Gm-Message-State: AKGB3mKoIfXM+Y6UcRz/+3Zw5WGcBWP3BGeBdWHOEQbkpFELGVmqcpyK
        +uCCx4BZUwT1luy/LtUsxTU=
X-Google-Smtp-Source: ACJfBos8+yjtg+83tPT9Tg7GUVUU5c88XTeFqEopL84o1nWQbanK33ogJ0fgDu7kDXgfb+v3grOiJw==
X-Received: by 10.223.153.233 with SMTP id y96mr28718583wrb.216.1514393350844;
        Wed, 27 Dec 2017 08:49:10 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id f132sm10948305wmf.17.2017.12.27.08.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:49:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Travis CI: skip commits with successfully built and tested trees
Date:   Wed, 27 Dec 2017 17:49:03 +0100
Message-Id: <20171227164905.13872-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI dutifully builds and tests each new branch tip, even if its
tree has previously been successfully built and tested.  This happens
often enough in contributors' workflows, when a work-in-progress
branch is rebased changing e.g. only commit messages or the order or
number of commits while leaving the resulting code intact, and is then
pushed to a Travis CI-enabled GitHub fork.

This is wasting Travis CI's resources and is sometimes scary-annoying
when the new tip commit with a tree identical to the previous,
successfully tested one is suddenly reported in red, because one of
the OSX build jobs happened to exceed the time limit yet again.

These two patches extend our Travis CI build scripts to skip building
commits whose trees have previously been successfully built and tested.


These patches should go on top of the "Rest of the Travis CI fixes" patch
series, just posted at:

  https://public-inbox.org/git/20171227163603.13313-1-szeder.dev@gmail.com/


SZEDER Gábor (2):
  travis-ci: don't try to create the cache directory unnecessarily
  travis-ci: record and skip successfully built trees

 ci/lib-travisci.sh        | 43 +++++++++++++++++++++++++++++++++++++++++++
 ci/run-linux32-docker.sh  |  2 ++
 ci/run-static-analysis.sh |  2 ++
 ci/run-tests.sh           |  3 ++-
 ci/run-windows-build.sh   |  2 ++
 ci/test-documentation.sh  |  2 ++
 6 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.15.1.500.g54ea76cc4

