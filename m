Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1ACF211B3
	for <e@80x24.org>; Sat, 15 Dec 2018 22:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeLOWEC (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 17:04:02 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:43970 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOWEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 17:04:02 -0500
Received: by mail-pl1-f182.google.com with SMTP id gn14so4347022plb.10
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fKVOnXegIjw68JfUsdaMeFl+edM31zOk6gVbzTxYh/Q=;
        b=nsWAvKhPwLW5OLT2mkftUxbvV2zIweL67mCAE55wfWDid6HzxsVQbcNR6ElXHbA8+j
         S/3gjTUlYo0Mj2kcn/Py9/y9nkI7Kyo1EyeFIZQnJKi0/cyEUV3zoGlAF+4wMigWHUEk
         3J09NG90VVziOhqdqH+IyCpYj/DHnN0s3PK/vKTAEgPDOlZVULwsvn+QGfJlb7q5Xqbw
         LfmTDz3OVXn5ToWPIbTBhXynQHty4X/2utUC/5hxhPlBMWFtde+C0mW/VhmeB6X2Qw0J
         LfKka7pZ/9hAOZG7QPe2LhWMaYrqdQJ4tUTP6HOYjOYuX7cxYTl2PuIH4LuKS1c03zcc
         k2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fKVOnXegIjw68JfUsdaMeFl+edM31zOk6gVbzTxYh/Q=;
        b=AyyXVTRkB+NFcIOZeitbyV7W8MkVgZ7FaipMiJ0/rkWfikTMlOxDYmSbc4PYEuCqJa
         Jlh0X6RhuV/IvPqrFKJmDrSGCnCCUbe1N2oU4tHi/le2T4+J+IQSR87ztRFjvjTONS5o
         IseurB0q6Gv7iIjtTNaPehQgmE9WaibBn43kd/pemFhLXhIUVlUyr66Bz0WWpcJiTs8v
         URBmWC/dDhxxKkRyhWF8766u0AjNVHHvo8EbdevkSs9gkWvdy5oIm6ieWrjIRhxinpcW
         nIGnEIrSjEr4xvGlFUFG5/ARZ8TsO9I1PmHrjsnOwu4Wf94PDfDUvUlI6p1sv+FFBp54
         rHxw==
X-Gm-Message-State: AA+aEWZjbPwxOtCkPHH9Xd9vTThuNJKI5FxlG68EL4bg7MnISo76Up0c
        1ElUWWVQRbVd9JlJuQ5xNcAJzVEj
X-Google-Smtp-Source: AFSGD/V60z+dat0iH4xdXeb15DthZAvQscIa7N4squ1FlRibmszwB5mdFRmDpCduHYAjhqcr7AH5CA==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr7709610plq.77.1544911440739;
        Sat, 15 Dec 2018 14:04:00 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id g2sm10799156pfi.95.2018.12.15.14.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 14:04:00 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:04:00 -0800 (PST)
X-Google-Original-Date: Sat, 15 Dec 2018 22:03:56 GMT
Message-Id: <pull.95.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] gc/repack: release packs when needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes more "can't delete files while they are still open" issues on
Windows.

Johannes Schindelin (1):
  gc/repack: release packs when needed

 builtin/gc.c     | 4 +++-
 builtin/repack.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-95%2Fdscho%2Frelease-gc-repack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-95/dscho/release-gc-repack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/95
-- 
gitgitgadget
