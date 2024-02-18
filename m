Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A5CA78
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241618; cv=none; b=GE95Syp+CTLrEBjWE39JGvqMbmPtES16wRrqjJ8os9eMqV3Au+oU2lmY/POdcgfgIWRPNBmq7pnloFyZVx3UVicJGTsx5IwqtUumKWSGDu7XPFCBHikfQkHDmwggRE6TuQnA6oz0KgTaaHV7xFL2tmz3EFMu8m4L8/aECPMaFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241618; c=relaxed/simple;
	bh=WmRXm0pyTve36e6rjfLfHzYUICBZ2BLp7os0+yR3V/M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eBJLWk86DlK4U2mRfkK9Qotv7PkvrYjPO1I2JGdhL0Z7kn9RgrW/YHc5o1fhL853bPiYMDEHR6yIV4AYNR55AyVcfqHFfjXNCNdz5iALIIWjhJw1oHqJC0Ybn/DJbYhLzA2gadSQl3PfuuKPPmKqhF99dRnxHNUbOgfipk03BFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZXwRi8/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZXwRi8/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4125df90568so5642765e9.3
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241614; x=1708846414; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2NJS1iYua1VoPGj2sUOPIRhK5uD2Oq+lB71D0E+IZg=;
        b=BZXwRi8/PuihmVrkoFMyNhvGrA8h4/taZWUsoqoyjJLicPuGpTPiHdD2FZgZx33sw+
         nysqk2aSqWk/cMwWd3sXE5xh3IU36O5TPpj3MpEN7kjhUtsvTSphJXKBN39jyD4vw3bt
         BNmCPwaY8uoBriJkuezewzYwd1DVZsSuQOgEafFTOnrl2u7W9HkYWNDNDhcuurzOnirN
         FEl9oaztsyZ8lUY1jX+HndOA8adbk9MG9JcktVgiBzYBl/AR6xiphHbVYcDmNojXhhjG
         a2bVI9wifIvIW8uJZRnrjA2l3f6fxdm0/vSdCK8qBVNmicHrawbCaIb7ZjXYdEI1WjgI
         arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241614; x=1708846414;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2NJS1iYua1VoPGj2sUOPIRhK5uD2Oq+lB71D0E+IZg=;
        b=aTJxbiEvGJbV2S/pMBh9zQxs3zaCGFNU5SzqLcpCq2s+fi8iorm/FawPSXyy9hXp7l
         gb9EWi0ZIh66v0a6Ze+NtlcMLmbyPXAyI812PMZJTsP8GdTgyUozsLu+scM6OEck+lnE
         ev+EIehdHZVXPYzeDbjyzICMdD8i56Hkh54Y91Hdw23U+M0bGwNdgNyM2c2xaBo6/Miq
         3qLftu/4VG1r+kqwF2NAVnBmImRL9g+y1hecWJzHzS7SQwZRAGHfZAcqH69UXKh5qhvw
         IEPIwr+m+LzfKw5asV7p/ICagMMZDOGOEZriAXxtu4oL1sd197qXz3GqqokvxuAApHKP
         pxTA==
X-Gm-Message-State: AOJu0Yy++/mT8mvNuCpp+nxnnCNOJPU88c0bdnfWQOsCw2p1POxVB5yr
	pQN28yOzZwWvY1eU+G1jeVbCWlsH9ptDN8pY3c/u5/oT9jpfkyC0YncV9FQ8
X-Google-Smtp-Source: AGHT+IFiwzg89qEFTqGGarvnsTXZYhvY+A4DS0i4BMeXWT9tp2aGRSb90i2Fs+W4AiGtbdtIHNafmA==
X-Received: by 2002:a5d:49cc:0:b0:33d:827:145d with SMTP id t12-20020a5d49cc000000b0033d0827145dmr5346009wrs.42.1708241614530;
        Sat, 17 Feb 2024 23:33:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm6789072wrn.75.2024.02.17.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:34 -0800 (PST)
Message-ID: <be270db2ff5c63612356c4ef2fafdbe1724b5b71.1708241613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:28 +0000
Subject: [PATCH 1/5] promise: add promise pattern to track success/error from
 operations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

Introduce a promise paradigm. A promise starts off in the pending state,
and represents an asynchronous (or synchronous) action that will
eventually end in either a successful result or a failure result. If a
failure result, an error message may be provided.

This allows us to represent tasks which may fail, while deferring any
control flow actions or error printing that may occur in relation to
said task.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 Makefile  |  1 +
 promise.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 promise.h | 71 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 promise.c
 create mode 100644 promise.h

diff --git a/Makefile b/Makefile
index 78e874099d9..4851eb2d822 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,6 +1109,7 @@ LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
+LIB_OBJS += promise.o
 LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
diff --git a/promise.c b/promise.c
new file mode 100644
index 00000000000..58ed8b67880
--- /dev/null
+++ b/promise.c
@@ -0,0 +1,89 @@
+/*
+ * Generic implementation of callbacks with await checking.
+ */
+#include "promise.h"
+
+void promise_assert_finished(struct promise_t *p) {
+	if (p->state == PROMISE_UNRESOLVED) {
+		BUG("expected promise to have been resolved/rejected");
+	}
+}
+
+void promise_assert_failure(struct promise_t *p) {
+	if (p->state != PROMISE_FAILURE) {
+		BUG("expected promise to have been rejected");
+	}
+}
+
+void promise_resolve(struct promise_t *p, int status) {
+	if (p->state != PROMISE_UNRESOLVED) {
+		BUG("promise was already resolved/rejected");
+		return;
+	}
+	p->result.success_result = status;
+	p->state = PROMISE_SUCCESS;
+}
+
+void promise_reject(struct promise_t *p, int status, const char* fmt, ...) {
+	va_list args;
+	if (p->state != PROMISE_UNRESOLVED) {
+		BUG("promise was already resolved/rejected");
+		return;
+	}
+	p->result.failure_result.status = status;
+
+	strbuf_init(&p->result.failure_result.message, 0);
+
+	va_start(args, fmt);
+	strbuf_vaddf(&p->result.failure_result.message, fmt, args);
+	va_end(args);
+
+	p->state = PROMISE_FAILURE;
+}
+
+struct promise_t *promise_init(void) {
+	// Promises are allocated on the heap, because they represent potentially long-running tasks,
+	// and a stack-allocated value might not live long enough.
+	struct promise_t *new_promise = xmalloc(sizeof(struct promise_t));
+	struct failure_result_t failure_result;
+
+	new_promise->state = PROMISE_UNRESOLVED;
+	failure_result.status = 0;
+	new_promise->result.failure_result = failure_result;
+
+	return new_promise;
+}
+
+/**
+ * Outputs an error message and size from a failed promise. The error message must be
+ * free()'ed by the caller. Calling this function is not allowed if the promise is not
+ * failed.
+ *
+ * Argument `size` may be omitted by passing in NULL.
+ *
+ * Note that although *error_message is null-terminated, its size may be larger
+ * than the terminated string, and its actual size is indicated by *size.
+ */
+void promise_copy_error(struct promise_t *p, char **error_message, size_t *size) {
+	size_t local_size;
+	promise_assert_failure(p);
+
+	*error_message = strbuf_detach(&p->result.failure_result.message, &local_size);
+	if (size) {
+		*size = local_size;
+	}
+
+	// We are only doing a copy, not a consume, so we need to put the error message back
+	// the way we found it.
+	strbuf_add(&p->result.failure_result.message, *error_message, strlen(*error_message));
+}
+
+/**
+ * Fully deallocates the promise as well as the error message, if any.
+ */
+void promise_release(struct promise_t *p) {
+	if (p->state == PROMISE_FAILURE) {
+		strbuf_release(&p->result.failure_result.message);
+	}
+	free(p);
+}
diff --git a/promise.h b/promise.h
new file mode 100644
index 00000000000..c5500eba986
--- /dev/null
+++ b/promise.h
@@ -0,0 +1,71 @@
+#ifndef PROMISE_H
+#define PROMISE_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+enum promise_state {
+	PROMISE_UNRESOLVED = 0,
+	PROMISE_SUCCESS = 1,
+	PROMISE_FAILURE = 2,
+};
+
+typedef int success_result_t;
+
+struct failure_result_t {
+	int status;
+	struct strbuf message;
+};
+
+struct promise_t {
+	enum promise_state state;
+	union {
+		success_result_t success_result;
+		struct failure_result_t failure_result;
+	} result;
+};
+
+// Function to assert that a promise has been resolved
+void promise_assert_finished(struct promise_t *p);
+
+// Function to assert that a promise has been rejected
+void promise_assert_failure(struct promise_t *p);
+
+// Function to resolve a promise with a success result
+void promise_resolve(struct promise_t *p, int status);
+
+// Function to reject a promise with a failure result and an optional formatted error message
+void promise_reject(struct promise_t *p, int status, const char* fmt, ...);
+
+// Function to create a new promise
+struct promise_t *promise_init(void);
+
+// Copies the error out of a failed promise
+void promise_copy_error(struct promise_t *promise, char **error_message, size_t *size);
+
+// Fully deallocates the promise
+void promise_release(struct promise_t *promise);
+
+#define PROMISE_SUCCEED(p, errcode) do { \
+	promise_resolve(p, errcode); \
+	return; \
+} while (0)
+
+#define PROMISE_THROW(p, errcode, ...) do { \
+	promise_reject(p, errcode, __VA_ARGS__); \
+	return; \
+} while (0)
+
+#define PROMISE_BUBBLE_UP(dst, src, ...) do { \
+	if (strlen(src->result.failure_result.message.buf) != 0) { \
+		strbuf_insertf(&src->result.failure_result.message, 0, "\n\t"); \
+		strbuf_insertf(&src->result.failure_result.message, 0, _("caused by:")); \
+		strbuf_insertf(&src->result.failure_result.message, 0, "\n"); \
+		strbuf_insertf(&src->result.failure_result.message, 0, __VA_ARGS__); \
+	} \
+	promise_reject(dst, src->result.failure_result.status, "%s", src->result.failure_result.message.buf); \
+	promise_release(src); \
+	return; \
+} while (0)
+
+#endif
-- 
gitgitgadget

