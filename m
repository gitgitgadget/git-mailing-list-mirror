Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A7C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3806261175
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhJGU1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbhJGU1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A5C061762
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i12so10137466wrb.7
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7xlN60GC0R7hvPRvPSqKS5geQsLs0YGurdc/9/8+Gbs=;
        b=k2vZ6ZQz2/cC8oRbfcgeJhTcOzaVCbXrNEm5b8BF52+hknY4idJgVLVRsSAqWvGhkA
         tzNpmn0yWm//fuJLMo2eiQcYuokyuUFgJ2LdjfwMuzr7xHfZOuhNa9Ult4vjN4s1HD84
         Zq0KFMQLof5zEtLIIjPa3/8h/Lq014zV8PW44a6kLX3xDYPKimPiusNy/X6nhGrE7Xwq
         Ltu7mWWnqFtae0FagODYlgL4FlC5N4EPtIe5PSaPkUdpafdth8h47BlzFLlGzmwFfNhK
         NoQLIAPvnbzqIGQqA7Sko/EoaSiGnAoqKZNG5ut4fv19FtPN0GMO1YXjcy092qK8bYkI
         KjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7xlN60GC0R7hvPRvPSqKS5geQsLs0YGurdc/9/8+Gbs=;
        b=ZqwHcWSYA+0TM+rKq+2DJstZllRnlhtGSmnC+Fl3iHIUCW7wqZW0NuTiqpiW7fGLdX
         LjOwey0RkKD21e+YfC/DnYU0zA33JXjZoC3Q4nzVkcDEQCEThVLQxzdWQqoKqOVL1Ap2
         sv7RTaAM08eAINNGyyQmw2XmRCGnjvikkLPa6XfmcwRuBHnSGFN7OJKHJU4Rxl2uTOcj
         74yTnHjDuQhwnzxHxZRTw3Q5cNpDUH53lRMPZ8jpkRxSYyzEFgeuPGwS+pkCuNPYNboZ
         zxrwqRCxplaqiXDRH4PE4YDWhmkgoxkqgraT2FSeRIoC2lh4ZZphRa4c6g0kIrSnVBZl
         AyNw==
X-Gm-Message-State: AOAM5301qTUCNKS0oyJm+vdRtT70LD9E59gAUXyDjHp/VcidfkKKWnpc
        2ulirx0zxpb8xoXVcJJhP4eP99/8oBs=
X-Google-Smtp-Source: ABdhPJx0tw6bRysCaphxTSsXWxl1WevGyo5XR9zNVsqtqdV7sF6FpqnZ+ijWmLop02JWEZeBWAxDgg==
X-Received: by 2002:a7b:cc0d:: with SMTP id f13mr6445078wmh.85.1633638321405;
        Thu, 07 Oct 2021 13:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm360894wra.37.2021.10.07.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:21 -0700 (PDT)
Message-Id: <80036f93e2e9b7823e49ee2764344f2db55ed768.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:01 +0000
Subject: [PATCH v4 05/19] reftable: add blocksource, an abstraction for random
 access reads
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

The reftable format is usually used with files for storage. However, we abstract
away this using the blocksource data structure. This has two advantages:

* log blocks are zlib compressed, and handling them is simplified if we can
  discard byte segments from within the block layer.

* for unittests, it is useful to read and write in-memory. The blocksource
  allows us to abstract the data away from on-disk files.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                        |   1 +
 reftable/blocksource.c          | 148 ++++++++++++++++++++++++++++++++
 reftable/blocksource.h          |  22 +++++
 reftable/reftable-blocksource.h |  49 +++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/reftable-blocksource.h

diff --git a/Makefile b/Makefile
index aa5ac56cde6..bfdac1e04c4 100644
--- a/Makefile
+++ b/Makefile
@@ -2431,6 +2431,7 @@ xdiff-objs: $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
new file mode 100644
index 00000000000..0044eecd9aa
--- /dev/null
+++ b/reftable/blocksource.c
@@ -0,0 +1,148 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "blocksource.h"
+#include "reftable-blocksource.h"
+#include "reftable-error.h"
+
+static void strbuf_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static void strbuf_close(void *b)
+{
+}
+
+static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			     uint32_t size)
+{
+	struct strbuf *b = v;
+	assert(off + size <= b->len);
+	dest->data = reftable_calloc(size);
+	memcpy(dest->data, b->buf + off, size);
+	dest->len = size;
+	return size;
+}
+
+static uint64_t strbuf_size(void *b)
+{
+	return ((struct strbuf *)b)->len;
+}
+
+static struct reftable_block_source_vtable strbuf_vtable = {
+	.size = &strbuf_size,
+	.read_block = &strbuf_read_block,
+	.return_block = &strbuf_return_block,
+	.close = &strbuf_close,
+};
+
+void block_source_from_strbuf(struct reftable_block_source *bs,
+			      struct strbuf *buf)
+{
+	assert(!bs->ops);
+	bs->ops = &strbuf_vtable;
+	bs->arg = buf;
+}
+
+static void malloc_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static struct reftable_block_source_vtable malloc_vtable = {
+	.return_block = &malloc_return_block,
+};
+
+static struct reftable_block_source malloc_block_source_instance = {
+	.ops = &malloc_vtable,
+};
+
+struct reftable_block_source malloc_block_source(void)
+{
+	return malloc_block_source_instance;
+}
+
+struct file_block_source {
+	int fd;
+	uint64_t size;
+};
+
+static uint64_t file_size(void *b)
+{
+	return ((struct file_block_source *)b)->size;
+}
+
+static void file_return_block(void *b, struct reftable_block *dest)
+{
+	memset(dest->data, 0xff, dest->len);
+	reftable_free(dest->data);
+}
+
+static void file_close(void *b)
+{
+	int fd = ((struct file_block_source *)b)->fd;
+	if (fd > 0) {
+		close(fd);
+		((struct file_block_source *)b)->fd = 0;
+	}
+
+	reftable_free(b);
+}
+
+static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			   uint32_t size)
+{
+	struct file_block_source *b = v;
+	assert(off + size <= b->size);
+	dest->data = reftable_malloc(size);
+	if (pread(b->fd, dest->data, size, off) != size)
+		return -1;
+	dest->len = size;
+	return size;
+}
+
+static struct reftable_block_source_vtable file_vtable = {
+	.size = &file_size,
+	.read_block = &file_read_block,
+	.return_block = &file_return_block,
+	.close = &file_close,
+};
+
+int reftable_block_source_from_file(struct reftable_block_source *bs,
+				    const char *name)
+{
+	struct stat st = { 0 };
+	int err = 0;
+	int fd = open(name, O_RDONLY);
+	struct file_block_source *p = NULL;
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			return REFTABLE_NOT_EXIST_ERROR;
+		}
+		return -1;
+	}
+
+	err = fstat(fd, &st);
+	if (err < 0)
+		return -1;
+
+	p = reftable_calloc(sizeof(struct file_block_source));
+	p->size = st.st_size;
+	p->fd = fd;
+
+	assert(!bs->ops);
+	bs->ops = &file_vtable;
+	bs->arg = p;
+	return 0;
+}
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
new file mode 100644
index 00000000000..072e2727ad2
--- /dev/null
+++ b/reftable/blocksource.h
@@ -0,0 +1,22 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCKSOURCE_H
+#define BLOCKSOURCE_H
+
+#include "system.h"
+
+struct reftable_block_source;
+
+/* Create an in-memory block source for reading reftables */
+void block_source_from_strbuf(struct reftable_block_source *bs,
+			      struct strbuf *buf);
+
+struct reftable_block_source malloc_block_source(void);
+
+#endif
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
new file mode 100644
index 00000000000..5aa3990a573
--- /dev/null
+++ b/reftable/reftable-blocksource.h
@@ -0,0 +1,49 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_BLOCKSOURCE_H
+#define REFTABLE_BLOCKSOURCE_H
+
+#include <stdint.h>
+
+/* block_source is a generic wrapper for a seekable readable file.
+ */
+struct reftable_block_source {
+	struct reftable_block_source_vtable *ops;
+	void *arg;
+};
+
+/* a contiguous segment of bytes. It keeps track of its generating block_source
+ * so it can return itself into the pool. */
+struct reftable_block {
+	uint8_t *data;
+	int len;
+	struct reftable_block_source source;
+};
+
+/* block_source_vtable are the operations that make up block_source */
+struct reftable_block_source_vtable {
+	/* returns the size of a block source */
+	uint64_t (*size)(void *source);
+
+	/* reads a segment from the block source. It is an error to read
+	   beyond the end of the block */
+	int (*read_block)(void *source, struct reftable_block *dest,
+			  uint64_t off, uint32_t size);
+	/* mark the block as read; may return the data back to malloc */
+	void (*return_block)(void *source, struct reftable_block *blockp);
+
+	/* release all resources associated with the block source */
+	void (*close)(void *source);
+};
+
+/* opens a file on the file system as a block_source */
+int reftable_block_source_from_file(struct reftable_block_source *block_src,
+				    const char *name);
+
+#endif
-- 
gitgitgadget

