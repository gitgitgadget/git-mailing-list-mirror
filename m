Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B48C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiD3ERo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiD3ERn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827C3AA56
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so18689330ejc.7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLFVZeLJHoGwXA28YkRVvihsRVj2aEx4AmNOkIxkYIs=;
        b=YyYsdcOmPx0fGlIANk1hCxTHKAInoEGkYwMfh6QSXFZmhy9Xqs1DGe3US9CAY0QUxr
         c4et07zZ6NHt56O/pHd3TXLkEh0hq0IEjMXxe6NnfM9gVTYFAZKYyTfpGTUvcNRCWnOe
         5xBUxFqavmThN5r/KTlrTTAyc/en7Y26vyB6Mp926xInHU4oON91sgKRodR5cC/IjfgI
         tjfcb9oDeKn+XuG/ljME1F0T4BNciPQjB/hvLLvY/yahAe4gqervOXHCAM4DLzHYnlbs
         pmAKHTOfb7/o47SCR7GZ6VNHvE1m744FRC1hjTXuReX/VCeoKMBCb1TnF6oJ5w+KAeVk
         o42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLFVZeLJHoGwXA28YkRVvihsRVj2aEx4AmNOkIxkYIs=;
        b=gdwDR2l2xmKy9RlIeZxXlOIxhKR0mY63wHmjbo4Hr/MpP8D3uoUiSkyK/VBgZ1qtUJ
         Y9ZFYe7V5gpFdIad5h2idCy9WZfvd30ipMFfrHGDMnrYDdQE6chKgmdz06cgCF8RxHnR
         d0FiF56e0fQAGSS78Aoti5pyadCl3RTm5hFqKcMc5tljX8Lsfdpq0pFoUm7HCEL+K1kv
         yuimIrX4pZylh9XypmLNIRJ5A9gXGl0xtZgh7oclMPYAWEPfdnpla+6ktL/6hFb0oLNP
         pxM3Kaq0/osGWzRRQhoFx4NWZEZWUR3AF3HW5a9B43GnZapBO0IgpO7/4WiLWBrOe+v9
         iLkQ==
X-Gm-Message-State: AOAM532wO/azAWDmqUq4q5gWp2Mb+t2X9qnOyQxa1BpUYsCw6GuA2TTg
        ZJzQeORhmh5vvZRILKBCLxJ0OE2Uve4=
X-Google-Smtp-Source: ABdhPJwwJDFJP4lgh0vsSw8SJXtV0zVUwCNjzYoe+osYlbWPCA2HaqtgvAJDHD5vEwsOAG2Wj6mPIw==
X-Received: by 2002:a17:907:eaa:b0:6f3:883c:ef4f with SMTP id ho42-20020a1709070eaa00b006f3883cef4fmr2259410ejc.208.1651292060825;
        Fri, 29 Apr 2022 21:14:20 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:20 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Date:   Sat, 30 Apr 2022 04:13:44 +0000
Message-Id: <20220430041406.164719-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle semantic patch necessary to reinforce the git coding style
guideline:

"Do not explicitly compute an integral value with constant 0 or '\ 0', or a
pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/coccinelle/equals-null.cocci | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 contrib/coccinelle/equals-null.cocci

diff --git a/contrib/coccinelle/equals-null.cocci b/contrib/coccinelle/equals-null.cocci
new file mode 100644
index 0000000000..92c7054013
--- /dev/null
+++ b/contrib/coccinelle/equals-null.cocci
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+@@
+expression e;
+statement s;
+@@
+if (
+(
+!e
+|
+- e == NULL
++ !e
+)
+   )
+   {...}
+else s
+
+@@
+expression e;
+statement s;
+@@
+if (
+(
+e
+|
+- e != NULL
++ e
+)
+   )
+   {...}
+else s
-- 
2.35.1

