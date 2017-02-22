Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B519B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbdBVOHH (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35059 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbdBVOHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so543113pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMrbxh1qJubp3lE5QuV0g8Q7j1QkFqlaDd6tm6ayLwo=;
        b=jpi3xadfWiMN88eNV+ZeJojzJIsVBDf5I25Z/Vmx9CoDD9epdZ5UmJ/kt8412NOaFb
         E2xW/GIx3NpJO+GAx7p86lYB1+k1L5VBZsrkCTTcgEaH/Sbi6wCUrMMGa5UL5CSgBt7a
         emjSl7f/yf1ujTbZ9Ng5YrHzYdzBNNXntLxdxKZBl8uUtlfPWAhqxvW3zcouersPsNh5
         xOYZfPZZWirKYt7Qm+/CXa2+qE/FKA9bJhwTUhcC2HsUN7ObfNAhJ8UsNBCduyKuncOH
         AdV7S/5c22GJ4cuolt9Tdevgl3EPjWeEKWAMgh0O2aNoYKK4g7pSrcvGWw0skM9EjNDH
         JrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMrbxh1qJubp3lE5QuV0g8Q7j1QkFqlaDd6tm6ayLwo=;
        b=pwxE7w5pgXiP6D+TYrXX+ow3zcD7Wv3BVTYyihgJq3D80/8iKU8LzczdN32EwPnaSR
         3UjpI+VKfWLjaDnNvmt6CvOvVs5HDsQmsMSK0l9dRWII/CfTbIt3JoW+SdEJPXjg+Ohm
         4hgqMGbJIYZNxLjktdNfLQX+3VfSjYB0qPIwj8OSNTssQTf8leUGtG2cFnHoy7OBQpDm
         Zd2aRb7vK63MhrLlbzvyiLShPfpav2YDwooivuDyqSzLH4eI3NvClIcAshdLUS581xZo
         YP8mIckQYWWPPr5FZ1rgy+TGS1Jwv4a4cfT7VgVZc6KwH6qpfL9K1baXYUDiOjVdRdHZ
         /NHg==
X-Gm-Message-State: AMke39lwuc7YJlLavWSs7AR/uotq3TFtRUaCYSWhssYh8TeCt/Sv+UzOazu+hIdoTqr8Ow==
X-Received: by 10.99.202.73 with SMTP id o9mr42416680pgi.173.1487772414566;
        Wed, 22 Feb 2017 06:06:54 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id o125sm4054571pfb.109.2017.02.22.06.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 11/24] refs.c: flatten get_ref_store() a bit
Date:   Wed, 22 Feb 2017 21:04:37 +0700
Message-Id: <20170222140450.30886-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps the future changes in this code. And because get_ref_store()
is destined to become get_submodule_ref_store(), the "get main store"
code path will be removed eventually. After this the patch to delete
that code will be cleaner.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 8b36d97c0..c284cb4f4 100644
--- a/refs.c
+++ b/refs.c
@@ -1465,22 +1465,21 @@ static struct ref_store *get_main_ref_store(void)
 
 struct ref_store *get_ref_store(const char *submodule)
 {
+	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
-	} else {
-		refs = lookup_submodule_ref_store(submodule);
+	}
 
-		if (!refs) {
-			struct strbuf submodule_sb = STRBUF_INIT;
+	refs = lookup_submodule_ref_store(submodule);
+	if (refs)
+		return refs;
 
-			strbuf_addstr(&submodule_sb, submodule);
-			if (is_nonbare_repository_dir(&submodule_sb))
-				refs = ref_store_init(submodule);
-			strbuf_release(&submodule_sb);
-		}
-	}
+	strbuf_addstr(&submodule_sb, submodule);
+	if (is_nonbare_repository_dir(&submodule_sb))
+		refs = ref_store_init(submodule);
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

