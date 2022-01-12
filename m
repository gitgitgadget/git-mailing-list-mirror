Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F0C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbiALSIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356048AbiALSIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:08:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFEC06175B
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso2114831wmd.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vwJx8iRTPLmFeX12/wh6IKg6If3i52naEEkxm1fRYVQ=;
        b=W2s2lFpChYedcLchYIpoLUd/u6Ev/12tlecwEFAgY4IuHfhzYhpjZC9XxCnoevPie4
         H1cZto/G4+GHaKBau8fYFHukp6xVEaLyZm6tETqFyNMBg8seBq5iiOHrFstGQNW7X/qb
         zS9b935ubWxzU7fr3SoWMOubhkIDO4hVfWA/VPgqR/bkPmmWPVYUx8cOqlJJJVkztZ/A
         y6Vp2FUPQuWJ9u1WUBTqAHBkimF8YBqv5UXpTkhYwzY1OaVKBcWGc0g9CDz3aMD5gWIw
         yTb5Z/KNP4x2sYQOV2cmeLHIJyYehTiK8ll1STxJeTIQP6nKeQaUOrMbqYndSTkEPaq4
         n1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vwJx8iRTPLmFeX12/wh6IKg6If3i52naEEkxm1fRYVQ=;
        b=CgbJNu3SoKqKwF7URDfUXDhUdd890ZzD+3Yu9oqCugL3+UhyGm1mYdKxKH9e/PRMR7
         wwQ6VhUzuaZaHXIVe4FLleCYpyAR2abLHFKRp2PWatZh0vgB3q4y4qriH7rTjJ44XRBN
         26NPAJCQNkRTeYx9jwT2XngYxmUERgKCL61cESTbf4fPGC7A7so8CLLb6HlLZ7A/ntQs
         hrQP9zxempAYCMi8OLm/tUNtN12Bejqv1/p8LqZD7wZ1YtDKNUMdY8z2oqO9fzFyUhU3
         /yXwkYsMs9W2549QqlRw6olSMV6UkNRxjzeXR4F3wBCsVmqztdGJol2xJlV1jmBVwj1k
         visA==
X-Gm-Message-State: AOAM532fWRddA6C5qW0OKQRmUX8qKKLizHSc3Z4ou0jaimT6iDTLhwyt
        dGqgV7rhzAP0Nvw+Xs0PIXyLSSK3EyY=
X-Google-Smtp-Source: ABdhPJz3sCnCgntyzeS7GCwot2xwUhVbqvgLMErgqzvm2VaeIF9RYiRltEzWL4Xs7pMJLGSlS5ZRKQ==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr7806568wmc.58.1642010883080;
        Wed, 12 Jan 2022 10:08:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm470555wrs.61.2022.01.12.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:08:01 -0800 (PST)
Message-Id: <a5dfa04888493801037daa8fc27f4e9c6a5fd346.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:47 +0000
Subject: [PATCH 6/7] reftable: add test for length of disambiguating prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The ID => ref map is trimming object IDs to a disambiguating prefix.
Check that we are computing their length correctly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index b4371b75724..5f45cee39d6 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -638,6 +638,43 @@ static void test_write_object_id_min_length(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_object_id_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = hash,
+	};
+	int err;
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		ref.value.val1[15] = i;
+		err = reftable_writer_add_ref(w, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	EXPECT(writer_stats(w)->object_id_len == 16);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -743,6 +780,7 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
+	RUN_TEST(test_write_object_id_length);
 	RUN_TEST(test_write_object_id_min_length);
 	return 0;
 }
-- 
gitgitgadget

