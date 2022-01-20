Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE075C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376526AbiATPM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376512AbiATPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA55C061751
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso21195966wma.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFxgNN28edqdOZ+Gb6YENsO0axQWrnuWxBbtDVaOk9s=;
        b=HZ4Qa7Lrji45Xlmaq70NEery4vKKRRFPiYCkEINxFPMutnaWCNReMhMoMkFarFuH5M
         ijHb63O9vECwVqN1uoe4JSJCHQpS1owvgdLdh8kICSezT5607YJ95hrqfrfZ7gmXdHGO
         Ebriomb4YYnmlV3eR14TDrsNuKJUE4RntDy125wKr2Ra/ehzYh7nhknuvalkYdmHmjEV
         YI9bBa9639+sad9oEVcZKFY4cWHnJ/ByPZ+eKkSNgKXs+1KBr14YBmn088Q7/9Su/SSK
         oSLC30cJg7AedutNUUvi+1a3RfIEvPYjYVNiF56JF/Y7vS3CiTbu25q+Tpu4hNKAHs2R
         oMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFxgNN28edqdOZ+Gb6YENsO0axQWrnuWxBbtDVaOk9s=;
        b=or5gVuM6uOAB/TixbyOme+dp252iLJLKlq2qBgRE3WSaIgKjMp1yW81SWE8dcf6hyE
         CdckBTPgTORgMIrwquEoiqkfQdRbUavUNUPQz9iO1Rktji6W6eObFVUVm+iTiD2A2v9w
         +3/fhvdVVG05K5/AJtE9BgwNl64fwzonN6tlID/7QTr05KUaPhq54rF3dnWb36TfuonL
         yMSoV1CrogelhssVkSCihff+dpSHTUlNBCf5pejWzfzUNaWgNutpKr/XKzEpAfZTCDhs
         Mwq5vpnTw7pY1s4HGD3yBaql6pSKE745cvclE5dxVDRY5sgllvmIBLaTjNhYmxQO63AJ
         VBhA==
X-Gm-Message-State: AOAM531kBHI7dJigosOqTSFYWDLkkxP6LFHOGnGocghsirpdTuMVRJio
        BnjvELzl8oafYmGBKvJtywlgeAKfvQc=
X-Google-Smtp-Source: ABdhPJzWJR1W1EKD2Y75Z2OjIk+5CKwwZGcIXUe3zaxlyW8O9Wbn7gipL+6qlI5psBizJy3zjOSHHw==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr9356460wmd.121.1642691541225;
        Thu, 20 Jan 2022 07:12:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm2782230wmq.3.2022.01.20.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:20 -0800 (PST)
Message-Id: <afee67fb60d28a1672601bf5c5dafef01f4ee1b8.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:06 +0000
Subject: [PATCH v6 07/15] reftable: all xxx_free() functions accept NULL
 arguments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This fixes NULL derefs in error paths. Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 2 ++
 reftable/writer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 35781593a29..272378ed1d5 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -646,6 +646,8 @@ int reftable_new_reader(struct reftable_reader **p,
 
 void reftable_reader_free(struct reftable_reader *r)
 {
+	if (!r)
+		return;
 	reader_close(r);
 	reftable_free(r);
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 35c8649c9b7..83a23daf60b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -150,6 +150,8 @@ void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 
 void reftable_writer_free(struct reftable_writer *w)
 {
+	if (!w)
+		return;
 	reftable_free(w->block);
 	reftable_free(w);
 }
-- 
gitgitgadget

