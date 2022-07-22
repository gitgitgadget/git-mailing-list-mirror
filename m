Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48989C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiGVTnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiGVTnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 15:43:13 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4947822C
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:08 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id p5-20020a4a4805000000b0043548dba757so1016298ooa.8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irjGQ5YkZaU4IT7CgQADlwEpZyQEiOKj2SrpYotObBA=;
        b=TLG2kqf5phRGaQDarDCBOq8VPvKpacrivlcl04Zs12H+aX0tT2yo8VwoDEqoX0C2/h
         Sk89wU4gq9R/cFxcnhwhzoc0E0VGPF5WAaX50WfHifeID0bpKX3KPHV1mleiyWUVhNX0
         bdztK8YcFN2I7JPaaSDms2skN6oqijhevhNNWtjy41teB77FV7ODuepki10/jyaBcg//
         60PkiQOB/WImqsvb9Se3UvqDLftzR5oGUsFsN+Xa/vvlGgHZByG/XjUerY4IocJvQ/1h
         qu6H3HPXHw2ztjsI9R/6yuuEvQ/WekkwEx56wJrorEmH2D/EWBB0pzQMJhuCyTsN4uNb
         ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irjGQ5YkZaU4IT7CgQADlwEpZyQEiOKj2SrpYotObBA=;
        b=yWMCTi5+4LQpJMald43eJTwfZgHgGUGi9sx3gEqggK5gmnykMxMj00vUTio03YhC1O
         lJ+JHX2zatsdVlPajqtXI1auMsTxo3AO27IOfgbr3g6Jym6r1nJl5RDcsMUXoLchuuIh
         iDE4TPcB+dduUhgjCpAyb9o8PFoeLY4Hmpa1zziNMwyAwwWsBiAVbZEiznTT+d6r35mN
         fG34NXtsXcXzJi4jZ2iMH/MWlPrhUYWMO1yOwC98YHAoRwKjT7kgsJKgxIRShEo6zx6k
         5sIB3/K5Rp4yWm0RKdEdG4/ToNLU8dNbnr3AsX+R7kq9hTlSx5N9NgxF2hnK9JCIMnOo
         InJA==
X-Gm-Message-State: AJIora9erhSRSYDbHrk/l7xzcmKyriQvrd9Pc4u2p5EbESL456Bq4KOL
        IofPSMnV99WBb50PrI0gZIlAePIhEyGj+w==
X-Google-Smtp-Source: AGRyM1s+QU9LidvYC73bVGaE8TgZp2bkSMpUnRxis1WPmiY2dhMVa0NzjJpM6J/kMqckXPfpMXgd5g==
X-Received: by 2002:a4a:b10a:0:b0:435:476c:ad98 with SMTP id a10-20020a4ab10a000000b00435476cad98mr561852ooo.33.1658518986255;
        Fri, 22 Jul 2022 12:43:06 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id w4-20020a4aa444000000b0041ba884d42csm2162093ool.42.2022.07.22.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:43:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 0/2] t0021: convert perl script to C test-tool helper
Date:   Fri, 22 Jul 2022 16:42:48 -0300
Message-Id: <cover.1658518769.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses the "left over bits" comment from [1], converting the
t0021/rot13-filter.pl script to a C test-tool helper in order to drop
the PERL dependency from tests using this script.

This series builds on top of mt/checkout-count-fix, also adjusting the
script invocations from that patchset.

[1]: https://lore.kernel.org/git/xmqqfsj4dhfi.fsf@gitster.g/

Matheus Tavares (2):
  t/t0021: convert the rot13-filter.pl script to C
  t/t0021: replace old rot13-filter.pl uses with new test-tool cmd

 Makefile                                |   1 +
 pkt-line.c                              |  13 +-
 pkt-line.h                              |   2 +
 t/helper/test-rot13-filter.c            | 396 ++++++++++++++++++++++++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t0021-conversion.sh                   |  71 ++---
 t/t0021/rot13-filter.pl                 | 247 ---------------
 t/t2080-parallel-checkout-basics.sh     |   7 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 10 files changed, 450 insertions(+), 296 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c
 delete mode 100644 t/t0021/rot13-filter.pl

-- 
2.37.1

