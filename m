Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC89C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDAA6120C
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbhI1PMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbhI1PMC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51DC061749
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so58529042wra.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=hdqHh/pIZmbKJFU3V6h19PMh6Ff8ax4cbNcauzqaE2EgtGtqrqBWvN0MC5Vg2oUrgH
         RQL6Do+P8e18nn9XXZflH2XHuhUsGw4AoPvwGJHYH6jlUL2GVuOAFEh0eel8aGmzQLns
         4wQnJ6AEPkOGeaalSpPIlp/xsV6ZwvZayKYcY9wpL9xq3DJEgac+Z6jtPgbGS8mBglHv
         0SwmQgMFNqKB5DXmgNG6MIhRKL3RjxUglhbiAzb+Ih+SbSZAiXfK/lTCMgPsExS8V1+J
         YPKdoTa+AQuh9tWWt2gKanYc0hOjN5skkkq4m4NMyjFpLqqbhRyrvjx5UhWian5jhyr7
         +GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Izbl9wexLtHbO918dhEysjpUsFaAvsDqZEji3I0p88=;
        b=56bufaQm1DIUhRVRpl/OyyHohpuAYq5hmGXh3Kjyb4OE6smsOcBQKiAQ0Ot/Cq8I9r
         LK5xzyitJe8B8zhrWSvhgGYInTR/wOHGSXoLgxSip97ff7mm4Wbexq1w34+CaUAajEqH
         6hRRYM11Up9Ur8x1AUELCg4EJyrnLYL9a/BImBh66/Dv5AjBrleVy5+c7lSQ8JO6//6i
         3uUe9M/udoVGaFnMk9wighCb6sObyFxatSJPVVuAjRE4e269dwNDIZsRVFLSERkASFXR
         rwd0RTYxkK4MqkrDr/mGR1RbW3Ql8lG0ibxvfnGDlCvth2zCHP6tI0vYLCGi5XWJ9cso
         3pzQ==
X-Gm-Message-State: AOAM531ImlIulFKy1r/TMTLOEOJpNSp5IVYe86mB5miZgOyaioPpCFX6
        goVdUX92ZaigpwtAWdcKUOAY8Q6qV+M=
X-Google-Smtp-Source: ABdhPJzHc+qj814TgP3Z3AueyIAhUWVjzMuW+aHB7I/Vxdl06e/WK827AGCf/loFh24EvwEjc1oZiA==
X-Received: by 2002:a5d:564e:: with SMTP id j14mr609068wrw.345.1632841820914;
        Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm20510819wra.38.2021.09.28.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
Message-Id: <41b1ff1293fee7b2ddfe694ca535265eb2f918b2.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:10:00 +0000
Subject: [PATCH v3 03/19] reftable: add error related functionality
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable/ directory is structured as a library, so it cannot
crash on misuse. Instead, it returns an error codes.

In addition, the error code can be used to signal conditions from lower levels
of the library to be handled by higher levels of the library. For example, a
transaction might legitimately write an empty reftable file, but in that case,
we'd want to shortcut the transaction overhead.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/error.c          | 41 ++++++++++++++++++++++++++
 reftable/reftable-error.h | 62 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 reftable/error.c
 create mode 100644 reftable/reftable-error.h

diff --git a/reftable/error.c b/reftable/error.c
new file mode 100644
index 00000000000..f6f16def921
--- /dev/null
+++ b/reftable/error.c
@@ -0,0 +1,41 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable-error.h"
+
+#include <stdio.h>
+
+const char *reftable_error_str(int err)
+{
+	static char buf[250];
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return "I/O error";
+	case REFTABLE_FORMAT_ERROR:
+		return "corrupt reftable file";
+	case REFTABLE_NOT_EXIST_ERROR:
+		return "file does not exist";
+	case REFTABLE_LOCK_ERROR:
+		return "data is outdated";
+	case REFTABLE_API_ERROR:
+		return "misuse of the reftable API";
+	case REFTABLE_ZLIB_ERROR:
+		return "zlib failure";
+	case REFTABLE_NAME_CONFLICT:
+		return "file/directory conflict";
+	case REFTABLE_EMPTY_TABLE_ERROR:
+		return "wrote empty table";
+	case REFTABLE_REFNAME_ERROR:
+		return "invalid refname";
+	case -1:
+		return "general error";
+	default:
+		snprintf(buf, sizeof(buf), "unknown error code %d", err);
+		return buf;
+	}
+}
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
new file mode 100644
index 00000000000..6f89bedf1a5
--- /dev/null
+++ b/reftable/reftable-error.h
@@ -0,0 +1,62 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_ERROR_H
+#define REFTABLE_ERROR_H
+
+/*
+ * Errors in reftable calls are signaled with negative integer return values. 0
+ * means success.
+ */
+enum reftable_error {
+	/* Unexpected file system behavior */
+	REFTABLE_IO_ERROR = -2,
+
+	/* Format inconsistency on reading data */
+	REFTABLE_FORMAT_ERROR = -3,
+
+	/* File does not exist. Returned from block_source_from_file(), because
+	 * it needs special handling in stack.
+	 */
+	REFTABLE_NOT_EXIST_ERROR = -4,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_LOCK_ERROR = -5,
+
+	/* Misuse of the API:
+	 *  - on writing a record with NULL refname.
+	 *  - on writing a reftable_ref_record outside the table limits
+	 *  - on writing a ref or log record before the stack's
+	 * next_update_inde*x
+	 *  - on writing a log record with multiline message with
+	 *  exact_log_message unset
+	 *  - on reading a reftable_ref_record from log iterator, or vice versa.
+	 *
+	 * When a call misuses the API, the internal state of the library is
+	 * kept unchanged.
+	 */
+	REFTABLE_API_ERROR = -6,
+
+	/* Decompression error */
+	REFTABLE_ZLIB_ERROR = -7,
+
+	/* Wrote a table without blocks. */
+	REFTABLE_EMPTY_TABLE_ERROR = -8,
+
+	/* Dir/file conflict. */
+	REFTABLE_NAME_CONFLICT = -9,
+
+	/* Invalid ref name. */
+	REFTABLE_REFNAME_ERROR = -10,
+};
+
+/* convert the numeric error code to a string. The string should not be
+ * deallocated. */
+const char *reftable_error_str(int err);
+
+#endif
-- 
gitgitgadget

