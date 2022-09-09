Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0F8ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiIIOdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIIOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFBF2D65
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3651845wms.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=7F28BWtCZ59vu+NnXKYZCwpYTfT3548e0gBYFM+oqdo=;
        b=JSIbCzlM+n9LlL1LULEC9fCGZj7Gk6RQs28ZXSIA1BDwwbq0gk0IFM9xI7B7KmcQLB
         N7wGLsmBssOYE8CsMfBMwzfUiGIKO/qIANh20ueNE+OXHtXMcZihrpZiTm8HA4a/Oghp
         ogbDiuuD8Wgl8ebtJM93k99ESkZEe0c89AUoqN97TvkREi2NuAqfW6/Mop4f6IuQRx/z
         llFpzKubQsZBiN1+FSne2CIziBkXiYpp254Xmo+ARWcRJbGD/jG6pkqA42g2aYvTdI2v
         zIWD9d4gWuTB3xfgiUl6AuHaS+Nl7hUDck2yFl3mIZ48hkQlgtTTbxCTOAA0jx8Pd5Xz
         85kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7F28BWtCZ59vu+NnXKYZCwpYTfT3548e0gBYFM+oqdo=;
        b=YuN8xH2GFVIw/Vkz1lR2p/9ZzKnA7Qz8UQEqe1DffuQfAW0AuO3GlszlP4R7KJaoY6
         UuJyDdXveyPyxNQWo5GNVPNSrmt27nCwUYNqSBeK1he4s1i4o8XdPZotGfTzXuAyhl/R
         FZ6LgKmB2uVfnOB3M2j43GPodLmPU2FHcApOXEPBbg/G3JNKW8iG9GBRWVaHWt2DlqlO
         /h0wrvsG1Q1PCB6VKnu/N5Qxr7tbs6NPCwLuGNS20yj05Y4pVIxQuxZoV3N4PUv5w7ty
         BykVI9zwpF9wte2N4EJNmPKFvE4+uPcvgPqzqW6EUsO7IxG84tMmXv/tYILXvPZ+IOFJ
         wrDg==
X-Gm-Message-State: ACgBeo3OmevACzHT8vkB0vGcWYccSlSxo/XCIp0qMGpW/sTyjsAJrsSa
        ZSVvNcS5ZyBiXKDCIZvDbjajSoeX+r0=
X-Google-Smtp-Source: AA6agR4b28D5A5DlXzpBDCwKb9YkGnrVebJw52OAtaNPOovp4F4sQExvEe8FVr4Oof4r8bE5/E6+cA==
X-Received: by 2002:a05:600c:4982:b0:3b4:f9b:8fa1 with SMTP id h2-20020a05600c498200b003b40f9b8fa1mr2262527wmp.168.1662734020957;
        Fri, 09 Sep 2022 07:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b002287d99b455sm665832wrw.15.2022.09.09.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:40 -0700 (PDT)
Message-Id: <ee6c4b824c276364b77de0b85b54f428c236de00.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:28 +0000
Subject: [PATCH v2 2/9] bundle-uri: use plain string in find_temp_filename()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The find_temp_filename() method was created in 53a50892be2 (bundle-uri:
create basic file-copy logic, 2022-08-09) and uses odb_mkstemp() to
create a temporary filename. The odb_mkstemp() method uses a strbuf in
its interface, but we do not need to continue carrying a strbuf
throughout the bundle URI code.

Convert the find_temp_filename() method to use a 'char *' and modify its
only caller. This makes sense that we don't actually need to modify this
filename directly later, so using a strbuf is overkill.

This change will simplify the data structure for tracking a bundle list
to use plain strings instead of strbufs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 7173ed065e9..c52b2a2a64a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -5,22 +5,23 @@
 #include "refs.h"
 #include "run-command.h"
 
-static int find_temp_filename(struct strbuf *name)
+static char *find_temp_filename(void)
 {
 	int fd;
+	struct strbuf name = STRBUF_INIT;
 	/*
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	fd = odb_mkstemp(&name, "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
-		return -1;
+		return NULL;
 	}
 
 	close(fd);
-	unlink(name->buf);
-	return 0;
+	unlink(name.buf);
+	return strbuf_detach(&name, NULL);
 }
 
 static int download_https_uri_to_file(const char *file, const char *uri)
@@ -143,28 +144,31 @@ static int unbundle_from_file(struct repository *r, const char *file)
 int fetch_bundle_uri(struct repository *r, const char *uri)
 {
 	int result = 0;
-	struct strbuf filename = STRBUF_INIT;
+	char *filename;
 
-	if ((result = find_temp_filename(&filename)))
+	if (!(filename = find_temp_filename())) {
+		result = -1;
 		goto cleanup;
+	}
 
-	if ((result = copy_uri_to_file(filename.buf, uri))) {
+	if ((result = copy_uri_to_file(filename, uri))) {
 		warning(_("failed to download bundle from URI '%s'"), uri);
 		goto cleanup;
 	}
 
-	if ((result = !is_bundle(filename.buf, 0))) {
+	if ((result = !is_bundle(filename, 0))) {
 		warning(_("file at URI '%s' is not a bundle"), uri);
 		goto cleanup;
 	}
 
-	if ((result = unbundle_from_file(r, filename.buf))) {
+	if ((result = unbundle_from_file(r, filename))) {
 		warning(_("failed to unbundle bundle from URI '%s'"), uri);
 		goto cleanup;
 	}
 
 cleanup:
-	unlink(filename.buf);
-	strbuf_release(&filename);
+	if (filename)
+		unlink(filename);
+	free(filename);
 	return result;
 }
-- 
gitgitgadget

