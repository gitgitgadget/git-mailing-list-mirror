Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhLNLsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhLNLsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DCC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so31906778wrr.8
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S929WtbLycx8tthlebgwee0eZnsSzF55QNgcBtMV46g=;
        b=EoDThHChSYvPMgX79SPENeAkflTOVNi5l7NBiGxXem6P+WCcSt8G0VrEVII0O+RDs0
         iGSHoKCxfNCLATRwUJf58786cPFPT9MF83A/zZaPX5bug3UNKi+aIumguWI2PZLklUe6
         1uXKMBAcRx1TT92vKsLoKW+i0etN5EpEiGcY6I/FWB42Qdipakcq7yWmFpJzdfKfYcbV
         b/vmyoTokjJEe3puadQrt4wGAeZwKY38araH6vfzOacAYIRkJgiOLesAGAd/Kv2QGaBi
         xmfY2bzW6LYa9KXwRJrFTMnUW3MYbpyfYphzD/Jqy+I2IoGoZvQ2H7o23J2V0u909Os3
         7vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S929WtbLycx8tthlebgwee0eZnsSzF55QNgcBtMV46g=;
        b=vsmDcjYKolTbCkWD+ioI+vNJiE2MNq5FYYfciL588UiIzIrHpJvquYfbmkg6mcwNVo
         AkEWBMEvjvPszPHTQR9u+Hpy3bRyiyQbzcBOpXrewR9mpEAetRlI6V6jAifKSf8v8coV
         xg67NI6SC6kDxr/m0d6Yc5ZL9UHzvrntCuMjMeIpQ9p/zp8cB4nHgA2hh5vBc1eFKkQJ
         fwskOXWD+yg2c6xNacvGyB8bl8eY66J2qzOBWHNtqYuih2mH5Bbe+uJFoALtc7gpAWRo
         Kr00KYdGUYukLZwVlPi4QAxQn4bHqA0hwOWytlk6wC3V3YoflwHZm5C8FnNKxc1FF/GY
         sNFg==
X-Gm-Message-State: AOAM533XQbcRrkEemxNObl5YOSMvc7WunowtsKRN5dKHbA8QGs2qOd5c
        lFE1Ta5/35HFbMVdz+PdXsbYyI6mg+M=
X-Google-Smtp-Source: ABdhPJxmp9OrgTQZyNZAgMB0K/rq5qhOZAC3rdtA6YNtxvviHOy6Pjgcy0Y3ai1gIdVYGcObJGRBYA==
X-Received: by 2002:a5d:5251:: with SMTP id k17mr5499773wrc.482.1639482484356;
        Tue, 14 Dec 2021 03:48:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm14037345wrp.79.2021.12.14.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:04 -0800 (PST)
Message-Id: <f2af404d7f16a9c6691beabe29113cc5f1c3770c.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:54 +0000
Subject: [PATCH v4 09/11] reftable: drop stray printf in readwrite_test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 6e88182a83a..9b89a5da103 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -662,7 +662,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

