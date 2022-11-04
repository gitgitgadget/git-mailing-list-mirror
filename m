Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD5C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKDLk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiKDLkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:40:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44E2CDD2
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:40:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l2so4595884pld.13
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83kCSkaM4cqjhobLN43rZtEt8nrQe6LKAkm6RrAOVe0=;
        b=YHhFd45yoM2lFcguUi6yiDAUXrIj4fC/fFivF1htII8lkfxGS5Z7HHjBoG0caFkZM0
         ceOCAEyh6oCPxoWB6F+gnfdlindEeak4B6REyfZLLVyl5wHmb1DAjXEjWA9f/kt7SJqX
         5yB4RDFemOqN7ohwwwONWk6FcrPLppOYHT2EeQrJ4qofZ5WbjwqFzjJn+UPsmrN+OF9o
         NEOP6cl7QpPxl0pG/gSUaiSvRwjRhpwq99fbB0bq0NHOP5NQe0mtMUJleQYQO9BIPIwm
         +0bAYuRtvrMQREPDQ0FpV1HwjeCCBkVFPisfg3//0X8xFBQUgPMhYnbPDPxlJIChMgvz
         snnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83kCSkaM4cqjhobLN43rZtEt8nrQe6LKAkm6RrAOVe0=;
        b=ZAjwxJMXcwS+MIGWA22ecA9sxg0RDudjxISlwNdioIlwJ/O21keTCPJM3uue3N1DkJ
         GePa4ndU/UijCBwPWHHD+KaGyjKaAZwTy/ONXb8B3FuoyNaKDUYSdnThTJmcOH+irTJm
         K+zuGTdAC42mrTZ3vCndMtAXGXhCF/N1FoZZj0+ZLYBQm0SrcxrtQfRH2Xtr+kZDPGRr
         kwHqnSt/vUGHIK0geb2qQkd2N9IxtFHmUttGi5RZ2koOp58kU02aEdwKiVdPh/TXsmZE
         jn4y4icRZFHVA7So+vjdDo9X6qfTAOws0vUd5nIu3Vm4Q2gOnI48P54V3KlJUNQ6jK7K
         VA/w==
X-Gm-Message-State: ACrzQf28XIthL9aEviZEdKtFv/6yDoTQKvG7yNQf2nesrbTF01pp+C+m
        32rSvpRRfZmoKLuNzKMzUMgtVZap4DU=
X-Google-Smtp-Source: AMsMyM48JwyNrMVVa9OSUL39WbMuphnKOOEdcGtyRbo/zwndNEDfwZ/9sFcrgCyRt4B7158GvsCAcQ==
X-Received: by 2002:a17:90a:5289:b0:213:cb7d:5fe8 with SMTP id w9-20020a17090a528900b00213cb7d5fe8mr30918705pjh.8.1667562023467;
        Fri, 04 Nov 2022 04:40:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id l24-20020a63ea58000000b0043c22e926f8sm2203133pgk.84.2022.11.04.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:40:22 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Date:   Fri,  4 Nov 2022 18:40:09 +0700
Message-Id: <cover.1667561761.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This series aims to fix the problem that bisect--helper incorrectly consumes
"--log" when running:

	git bisect run cmd --log

This also clears a way for turning git-bisect into a built-in in a later day.

Đoàn Trần Công Danh (3):
  bisect--helper: remove unused options
  bisect--helper: move all subcommands into their own functions
  bisect--helper: parse subcommand with OPT_SUBCOMMAND

 builtin/bisect--helper.c    | 228 ++++++++++++++++++++----------------
 git-bisect.sh               |  20 ++--
 t/t6030-bisect-porcelain.sh |  10 ++
 3 files changed, 148 insertions(+), 110 deletions(-)

-- 
2.38.1.157.gedabe22e0a

