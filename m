Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C942C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLMws (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJLMwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:52:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82810B40DF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l32so2732584wms.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=BmiRWCB35F0DIO1tA34bIm4hldA0Tk2ex76YA2SXH3zvcCqlIYzmdz+nVabGiHSyqm
         JCaO0p7Jd8Xyj/g/JALYgqdYyO8Ox4j95iXoVZBQtkC7KYPyDI6ZZEBHwWwgO1DXa3Jy
         HmWpItmT9az/z2FMxERRFXYv74GX79ZtbUmP8jGQa6JpWPkJ4udY8f9Ah1m3n5GRrjhz
         2Yr6+WN6Q06ykVxx/+WxujIs/14hKX3k33D3BN45jJKG9vgAm0/p0ojObGMkAR6TUJph
         LJjv4fqEp8DvlO2prrYfBD2UNiKYLioKMZMmofCDkjpa48SUm09ehnRZXBC7S3ZKPQuC
         bsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0RWbkNTtXe3sf2lfCXZhtBtwN32JnfhLRZybJP7Qo8=;
        b=hDui7UBWO0v0gPREhDCIbROr4Ia1mpvoWL0w28xwDJh5GCFet87kiLlpkZOZ2glDdN
         AIAbX6Ri++0ZLv/nBV18YsMFRbpLOBPmE3I2GC+RsrFuapym/+jAqIOBCZQroHvh4UTp
         slOyTnB29QxQwXqMY+Bo3Lju5pyvVLpTDm4KjCbtVHevMEg7ze2s2FFj/lxaSPq7OBk+
         iSmQd0CanMCKwtN1KVWgPCPhcBpLEdHYdp//+CjjElRMpsBQjcYUSQEL8w29ian5pEAL
         /PXDfz/NbrYHdsE+dxytsa6qmdo8YmFT51G5bbG3QGlw5oDq+NrX7/aoc8A5T85wOyPt
         b/mA==
X-Gm-Message-State: ACrzQf1HWglYC+PXNfsIPQHQIf8m60Bf0MbdOkiJcm4atXcdsOZdB9yc
        UO7qqB6q+zPGhbTR7g6L3jzjZec0whI=
X-Google-Smtp-Source: AMsMyM6q4ux5gruz/NoANUVABGzwDK5MIDPqiMAqcqP6M1LebFOOhx1uAlxdl51iZ+uZGSW38Fi57w==
X-Received: by 2002:a05:600c:288:b0:3c6:c44a:1d30 with SMTP id 8-20020a05600c028800b003c6c44a1d30mr2752467wmk.46.1665579163622;
        Wed, 12 Oct 2022 05:52:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020adfed46000000b0022e04bfa661sm13711849wro.59.2022.10.12.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:42 -0700 (PDT)
Message-Id: <48beccb0f5efe6f9247968cd0d4c455c23a24c53.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:28 +0000
Subject: [PATCH v5 01/12] bundle-uri: use plain string in find_temp_filename()
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

