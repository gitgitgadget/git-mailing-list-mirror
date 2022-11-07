Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B848C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiKGShG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKGSg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692326AF8
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so2721605wmc.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlC5bNjUxauJsYY1g9pQ/U+SebV6B9lRzVTbrUZDHzs=;
        b=IanYpiwCxJxeNHYnL6ebHK9YUseXcnAurV4gzxIBGzl2QrQKhAKtRtG41Jio4fMOiV
         VGilBEOOrLRUGs3gJGGAB9UurhyPLEL5ixdSyuJsvxxVpop64nUw53LqErQ1DbTBaYSj
         goyYVw992EKXGTwR85eJcyKhaQ02Y6LAhs7KaN/CTFFh9GTvT8Wt2NH9K4ufbSsN2fUc
         mzNz+b6tKDy65LwI4loFTS+EcAcCb5ITBsaqqvwILGfykuGTrkVTDO71saRNP1fZhhcD
         iB3Lm57sQs0Yae8/XOsMBXUF3okve2XpJEJ/YFWU7wQT7cBHV4qP4UB+MzrZw3TjY3VP
         lC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlC5bNjUxauJsYY1g9pQ/U+SebV6B9lRzVTbrUZDHzs=;
        b=DwOdmOfIMVhB+73eruh8uzkVlNITsW5sXpJuwf848BQszgIpbH0ZRfBMbtCey8LZbn
         5fYk5e2cisku2FKl2WEDcniOYWlKBozGcq74YzSYSFpwXHNBhupsI0u/NRZob4WHoaZr
         aRejWffcojHJKXnA2b8bv6sZL8OsMybKbIrybYUWlhrRZDtgBPLiK0uMOR9FLkSrFhYI
         7OdYnLl6ARaYw6znd/gQ5mojYLh1HmOzRcn6JnlmKInzw355B705QmHn3qa9XH0/Q89S
         QyjwTuOlJvf5YI8Fk0Ym0IzEK4AatAxobQ6rB8IPd+0mOPqwhG8vpLC0lKp7WVOQxOcd
         UtSA==
X-Gm-Message-State: ACrzQf0f7yYBPXIlPRU4yBGz1rcRnNEQZWriGUVBXxpkDJASXKB3HCdJ
        uDX4cnXYZDZSSUg+zUBaTmdFKgQaEow=
X-Google-Smtp-Source: AMsMyM6T6322swOAm+KD9FtpwDg596PZFAuYjmNQ2OtDUoDKFSj+6mlyb4X+g2mS2sFSOmmgOn8oyQ==
X-Received: by 2002:a05:600c:4586:b0:3c6:fbb0:bf2d with SMTP id r6-20020a05600c458600b003c6fbb0bf2dmr33746676wmo.13.1667846179110;
        Mon, 07 Nov 2022 10:36:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003cfa3a12660sm13782344wms.1.2022.11.07.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:18 -0800 (PST)
Message-Id: <f141d8561ab850df36da0a4efb80315e34e7261a.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:47 +0000
Subject: [PATCH 13/30] packed-backend: extract add_write_error()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The write_with_updates() method uses a write_error label to jump to code
that adds an error message before exiting with an error. This appears
both when the packed-refs file header is written, but also when a ref
line is written to the packed-refs file.

A future change will abstract the loop that writes the refs out of
write_with_updates(), making the goto an inconvenient pattern. For now,
remove the distinction between "goto write_error" and "goto error" by
adding the message in-line using the new static method
add_write_error(). This is functionally equivalent, but will make the
next step easier.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index afaf6f53233..ef8060f2e08 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -529,6 +529,12 @@ static int packed_init_db(struct ref_store *ref_store UNUSED,
 	return 0;
 }
 
+static void add_write_error(struct packed_ref_store *refs, struct strbuf *err)
+{
+	strbuf_addf(err, "error writing to %s: %s",
+		    get_tempfile_path(refs->tempfile), strerror(errno));
+}
+
 /*
  * Write the packed refs from the current snapshot to the packed-refs
  * tempfile, incorporating any changes from `updates`. `updates` must
@@ -577,8 +583,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 		goto error;
 	}
 
-	if (write_packed_file_header_v1(out) < 0)
-		goto write_error;
+	if (write_packed_file_header_v1(out) < 0) {
+		add_write_error(refs, err);
+		goto error;
+	}
 
 	/*
 	 * We iterate in parallel through the current list of refs and
@@ -673,8 +681,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 
 			if (write_packed_entry_v1(out, iter->refname,
 						  iter->oid,
-						  peel_error ? NULL : &peeled))
-				goto write_error;
+						  peel_error ? NULL : &peeled)) {
+				add_write_error(refs, err);
+				goto error;
+			}
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 				iter = NULL;
@@ -694,8 +704,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 
 			if (write_packed_entry_v1(out, update->refname,
 						  &update->new_oid,
-						  peel_error ? NULL : &peeled))
-				goto write_error;
+						  peel_error ? NULL : &peeled)) {
+				add_write_error(refs, err);
+				goto error;
+			}
 
 			i++;
 		}
@@ -719,10 +731,6 @@ static int write_with_updates(struct packed_ref_store *refs,
 
 	return 0;
 
-write_error:
-	strbuf_addf(err, "error writing to %s: %s",
-		    get_tempfile_path(refs->tempfile), strerror(errno));
-
 error:
 	if (iter)
 		ref_iterator_abort(iter);
-- 
gitgitgadget

