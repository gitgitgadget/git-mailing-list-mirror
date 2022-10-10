Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39BC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJJQEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJJQE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26E71BCA
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l8so7115029wmi.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=RVm3aELTgqLmZOYjPoXKc1Jmlvfzluer4jVy+WFicHqahck/a07XxVOCr6XUi1WE9u
         tIrHYobSzYWcUg6tKcMo6wiCtefjLJebpS05o3XJhz37KG+pBkmUbbcdcuyJyXJboia7
         MrPUF+Nc2mXBoHhwX3Rt7LQ9/An4Q+VtwLxLJ0JZBzeZuz3rLSP34uUtq85juItwNm7C
         2xMo27CBlpKnWJKPopHZ7otARh6jDNaJ5QVroJoCfmYuoGqyPQFedynDhdu82Zg5SVuH
         MpEBXWGyHAmG3BYo6SkB/yKU5L4KVScYXcbN0FEs5XBssFYzZrX0AA/HVJGw/lEPyrK+
         jUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=g/lRN6Ov8ZjqvG+tVm1UppnaommOwo0gvEVHp7oBayoJ23CnGGckXgrfu5z6YEe7mf
         kR6rCY20aqfwnSk2yqJC3tKNerJCsJM827c+BrJ+fDUJhJBSiStl00STJV/HTCa5u9AW
         01jgZSUe2p1+a6/SlQsekDc/ZUdMEh+J//FU2VYYOe+dty11X+/238omGoYlSWw7TY03
         ResLQRy5C5bd8FhBrcuekw5fN2SwZ8h1Y443+5seWWkhFYpCxbBgc61jN7VQo15C2WAi
         ph4DgXngUSojfsT+bU9p+4bgfHR2o3vdG/XNqPf3PXfl/WNdsipLGzWMBrGzG8ieF3C2
         S68Q==
X-Gm-Message-State: ACrzQf3M9zA4UXaaejbOJHc39jlXVjndtuMebFEDvVujaG4Tdj8Wp/kW
        SNolqXPgW8XZkXGt8rDtJfhKle6vr5g=
X-Google-Smtp-Source: AMsMyM47Wjuakd38tdoPEj1Wd3Wd72JeEMtUPi4fHxskqCN7aczlAaBnXNYij/9OLH9nxq6riO9CPQ==
X-Received: by 2002:a05:600c:3848:b0:3c4:50b6:30cc with SMTP id s8-20020a05600c384800b003c450b630ccmr9296913wmr.28.1665417862309;
        Mon, 10 Oct 2022 09:04:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003c6b7f5567csm3807098wmq.0.2022.10.10.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:21 -0700 (PDT)
Message-Id: <48beccb0f5efe6f9247968cd0d4c455c23a24c53.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:09 +0000
Subject: [PATCH v4 01/11] bundle-uri: use plain string in find_temp_filename()
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
index 4a8cc74ed05..8b2f4e08c9c 100644
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
@@ -141,28 +142,31 @@ static int unbundle_from_file(struct repository *r, const char *file)
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

