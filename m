Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E89C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0060A61100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJ2OBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJ2OBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119DC061766
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p14so16254285wrd.10
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C7FXMXvdgKpKIQ79mjqFgY4VI91Yh5GAcfct/8ErWpk=;
        b=EeaJ/jWACC6I6Zmib6cKYOzYuDZS21RkGYkRPtzIwLvXtzBBkvJzrbJ71aOeyR8a+K
         x03GgbCZ9snyrO5fSxVETqyM/3m5VxSW8IzSQlT4BcBvnwxQSuuaZizaUmQYV4ns8dg7
         FQlGpNCC0Za5DIQ/3QRFQPmoh+/4cb0txCCKE0Rx/9JGUVMWuI/1BpOivbROvmNYptTQ
         9KdWbjBtX9dzc2ajjdmnY4cF+cs/RmLnci9+vcLfrvtIJHsfQxLbjeVJ/wwZnAkdY8V9
         g9vo1zEL+H77D5j7AbjHZpOcJ56jpamvVoDEZ96Gvxs1+rrj3YpisSv3xEcM9N3MQd0H
         wTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C7FXMXvdgKpKIQ79mjqFgY4VI91Yh5GAcfct/8ErWpk=;
        b=BVV/7+XHCF+9JcrEKwr3wgQMNSaDvHlKTx77XV9OkVSjmbXKnaJK1wNaLazbYo4lmw
         mDxcXieYaggLl3mO63dzdVKq0Nk2vo9L6jVuUkGy6zJt4oX0A+ATpivHRdEdjvifPQSU
         r5kwtbVec0HW4i/jo3jkcAefYbWeMLowFxKKsFJGpo2IjxVgtUNP5Xskx10h6lvWWyoV
         gw3W0OjmbxrJNq4q4W3ghXKtnvG1QrvE5AdI/Bh/UhhLiwIiPGYsix88Yi+GgvFAdNck
         WP0D2mytgGVCAS/f0pEKdEM0FNmTA1qVFbpmAHpPxW+hP2EWe7NgGu/BX7DIx+DNdgjz
         Y1Ew==
X-Gm-Message-State: AOAM532nvU1uXNpiSyocJaYlQHznwwdKcpliygtBbGP8Vk4w6OjkA+mv
        AjQRu/5AD+2wXrc7AUkxh2PnphLiWaw=
X-Google-Smtp-Source: ABdhPJxkOKuriJCe7VCh3rWe55fPGsX3A3KT7uUTa+PcY5Rcy3XE1LD/FeCLedPOdFe/8b1/r+uapQ==
X-Received: by 2002:a5d:63cd:: with SMTP id c13mr13916571wrw.224.1635515962054;
        Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm96066wre.46.2021.10.29.06.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:21 -0700 (PDT)
Message-Id: <052197200141c321118b7766f5615a61f951e59f.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:13 +0000
Subject: [PATCH v3 2/8] test-tool genzeros: generate large amounts of data
 more efficiently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In this developer's tests, producing one gigabyte worth of NULs in a
busy loop that writes out individual bytes, unbuffered, took ~27sec.
Writing chunked 256kB buffers instead only took ~0.6sec

This matters because we are about to introduce a pair of test cases that
want to be able to produce 5GB of NULs, and we cannot use `/dev/zero`
because of the HP NonStop platform's lack of support for that device.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-genzeros.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index b1197e91a89..8ca988d6216 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,7 +3,10 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
+	/* static, so that it is NUL-initialized */
+	static const char zeros[256 * 1024];
 	intmax_t count;
+	ssize_t n;
 
 	if (argc > 2) {
 		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
@@ -12,9 +15,19 @@ int cmd__genzeros(int argc, const char **argv)
 
 	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
 
-	while (count < 0 || count--) {
-		if (putchar(0) == EOF)
+	/* Writing out individual NUL bytes is slow... */
+	while (count < 0)
+		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
 			return -1;
+
+	while (count > 0) {
+		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
+			  count : ARRAY_SIZE(zeros));
+
+		if (n < 0)
+			return -1;
+
+		count -= n;
 	}
 
 	return 0;
-- 
gitgitgadget

