Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D9C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiBAOxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiBAOxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94CC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r7so12921019wmq.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AcYF0+j1hmE5qBBW921HkVedgxOdja8BA5zu4q8/PU=;
        b=HiUcpf9YR58qMBl5fD17S0IRPJOCB7EYxc5iZd2lGz4UI1GQbigHAQPzVz1kiWoE9j
         v6wJ6R4qP/myqUPuQtOqonH43S33kgXhJw4WTj1peT2+A1xHjjCDnD+KI9IXi4xZh/WZ
         W7rykujvwugiJYRbUA5azILK9TwQMdJS3cATsyueB9gYNPkq/diwuwhN4gPgGyB5vIq+
         kcqaDY9uoVreJ0zVYZTlMmxqlyKtjXHGozOboEWrYii6PwOS3IsNqbOmMQLwSCEqLj1U
         xag8DQHebviBYw29U1at+nbOXuzikC1tSaHUGFns8pMQdVjxW/4Cx/4Uu1Z4EK+qEoK4
         OrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AcYF0+j1hmE5qBBW921HkVedgxOdja8BA5zu4q8/PU=;
        b=q/HR3OUpMP4lC4XFaxdZiNBgLmPIU/livT9yrHEJpZ3OOFnm2m/02seWA2TFhlu6SG
         fFquWTqiLctlEs260++2DwXIXXgyho0MGsYq5eCRM58U8I6Nz6BBVN1o4y5Jye/lzRKC
         J4RCEFHZw86Mz+BDMwLKgpEC8kG+oCxzI5jx35cyJ9NMkONsUghDnXcoTIpDDmBOUhf5
         1CJPF+i5QL/0QMjUVgnHRBTwNyZS/jIWBdnO7cY/cB1/PcZ+Ko5AIlqvo0vY9mdpn9nN
         hB31qlQIIafRAIF0GwYcIrFdc8R3D64Q9ZMATgcaiZF8kQbFOhWw/V0jXH7NV7C4EIhE
         cMnw==
X-Gm-Message-State: AOAM531dgDWivPjD4ixNm5Gr42iTvsJ/kGEr+HQzIaHxwTzCwSpa/9O7
        KkuMZkgIZ1RgdUMYyDrNbRNZlkEvdMgLgQ==
X-Google-Smtp-Source: ABdhPJxgC5ofyh48G4KSHKJmKK+jYdA6A7z43cM0utF3nCrj50nroVFJt1YnxnIo32iMMExi9QZmLA==
X-Received: by 2002:a1c:a754:: with SMTP id q81mr2163773wme.180.1643727197239;
        Tue, 01 Feb 2022 06:53:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] object-file.c: split up declaration of unrelated variables
Date:   Tue,  1 Feb 2022 15:53:03 +0100
Message-Id: <patch-01.10-53334bc970a-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the declaration of the "ret" and "re_allocated"
variables. It's not our usual style to group variable declarations
simply because they share a type, we'd only prefer to do so when the
two are closely related (e.g. "int i, j"). This change makes a
subsequent and meaningful change's diff smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 8be57f48de7..ecc77973292 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2118,7 +2118,8 @@ static int index_mem(struct index_state *istate,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
-	int ret, re_allocated = 0;
+	int ret;
+	int re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;
 
 	if (!type)
-- 
2.35.0.913.g12b4baa2536

