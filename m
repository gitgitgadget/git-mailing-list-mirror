Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB0C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE041619B6
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCZCkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCZCkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 22:40:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1467C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:40:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so4185092wro.7
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lc/JyTXJJMLuGgKILtCQRGF+CRBcOASMgVsIm7HwuJc=;
        b=Jkee+rx2lePv+kAsMPwLRdyM2Vg8OE/G5DX3MJBwg2oD4QGeNVSwaHxabexDgIZ1Cj
         gDIKS2B1+DSJzmE8CzWVK8Cr5BEuJlRd3w5/5BFG6nfdFgPJY95C0VRaIYWz7MjA1GQt
         l9sQoj14p1qQ/JKRqBWFd1mtiAbsHFUKzdZLYIV62Wh2cpEucCFo8yFnqbELyl2daL9Z
         k/wffsb0S4v8CKnRGRmkv9/L6gvy7mSDfNb/ka7QUXUA7sTyh6txNFamwPc3QfA9Z7xv
         S4PBlIiRhvE0BrbMQ7YHUGGpi1Rvh+NGQcHGhfMpiW8ZIpDAcV9o0AqK61RsT6O9DJCV
         MyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lc/JyTXJJMLuGgKILtCQRGF+CRBcOASMgVsIm7HwuJc=;
        b=Wg9t/2Wi9fY8CzT7JwH1UqFlM1yUsp/HuaY6L2Toa/L80TfrDwtHOsTXraiG6QlB8N
         xs0MEJUT4dR2Eg6kaC0tvej3VIOAFYJ1/LfiqrEV5paenH5p8xa/A9VelmnkmWmF2xsQ
         5cjg6tPqHBD8r2j8rkqoFZKejdD1CciuYAuaWkcuSpB90f/AQWO+6UggByFkHPopiGCG
         i1u+oZ3/IoMyW8wlN0st8u3gRu9vUItNFWSUijMBzN5TKPMYQGQsLD3buKSw3l3fqR5p
         bI9eh2cO9+i61z2eo+HqcWAbESifGXW7lEX5B1n3ctWP4bAAhz2Y3TEzuH+ABuCpJXwE
         3c4w==
X-Gm-Message-State: AOAM531XNwS+PGTZn/k1Mz7YVglJNuOO5EqF19kBzsROlthDVpekS08Y
        mcO/TeTZnBusL3KmBe/3guK1T96u2P9xjO1frHM=
X-Google-Smtp-Source: ABdhPJxZMcgqYOWW819h3r2o9wN0sPPO1c9rHXGr7qIBrpLSW1Hwf1wWOj29eyB6PLC62Op16DdkCg==
X-Received: by 2002:adf:e391:: with SMTP id e17mr11922034wrm.285.1616726444122;
        Thu, 25 Mar 2021 19:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id i10sm10020226wrs.11.2021.03.25.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:40:43 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [RFC PATCH v1 0/1] pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 04:40:03 +0200
Message-Id: <20210326024005.26962-1-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

The second of the two issues identified in this thread.

Both patches work as expected.

There is a short solution, which is mostly okay.
It does not compile with -Werror, but:
It avoids malloc/free, and keeps the logic/sloc low.

All of this could be my lack of C experience.

Stavros Ntentos (1):
  pathspec: warn: long and short forms are incompatible

 pathspec.c                  | 30 ++++++++++++++++++++++++++++++
 pathspec.h                  |  1 +
 t/t6132-pathspec-exclude.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

--
2.31.0

