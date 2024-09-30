Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E2185B68
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733843; cv=none; b=AO/JiTXNp0S5F4I0INqTtdxy6mr59AbaG+ItHAiT+i2XYjGJ3V6g7zNMdMCHP2HZMK3uimOxxXxcHjj3w/DrGFcqYGkKddjVzv27KxTq1bE3k6tr2G9rzFJkXAto+piRgcEhS09d2MtTFHXVo7sMxuUpWNlFSabmYvMD8sP+5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733843; c=relaxed/simple;
	bh=jQbksLr9MvH5awXzhXU0oVH4VetB78b/xzVkil0lxKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXRvPKnmkhRH+Sqbsjkb0hyFLRxrYQclA076Vn7xNgG7BdBMreduboCNU3aAmzet9Z+z5kEw1/728lbTIhZgFEti/IbAbFKuYq6GWRFAGv/eSgbnoR8Jd6yWaENqlo81klQ4osqbCB6lYG7tzjGCzA6djqkSNXlipsUWDf4S85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hq3XG1Kv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hq3XG1Kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727733840;
	bh=jQbksLr9MvH5awXzhXU0oVH4VetB78b/xzVkil0lxKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=hq3XG1KvI8ESqWHQ6hkYaidx1m//kruD9CkFLJ5o/gxmw+/xa+GimPOPw+ISsB6u9
	 BH9yGIhV4Ydy5qNphMc1so233rVPy8JAB049rvh9+sFPE+/Zlkgo/LtzR6rfeeRFXU
	 H9f1XTSp3vE6NMSZpyNZ6sSY+HRx5Ex0SBqbaPMuTAdDLAjVg0xD9C6Xes+3TeFnXe
	 NUL1iy4Ft5dM4IYXSF4Ue9L4AmFC+gX5KYxepXQP5Dl2zTJtZz5iLYXxR6JPUEUh4Y
	 u6MqdyWOI1sumq9BH7CihwJ11mKgDWiicnv+iFnApnQ97sOkAEcfcAKHyoqpxIw4I+
	 ZOZsp/ZJAwWoz70Xtv66PLcwAa5bB3Yj+ytacSYeq7h0Q27gTHUCrAm5mLwXyJB1wJ
	 mpfxY1+9sd2csxpKcV6SjlAbi1EUDwel6GgkujWGaaAb4zwdPuMgsbA1or+FXPgMWd
	 zsHgGxHS7O4cuFXbZKkhuXXxujoZCgKdhlOmIFAghXri6TkXwiF
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 68B2E20082;
	Mon, 30 Sep 2024 22:04:00 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Emily Shaffer <nasamuffin@google.com>
Subject: [RFC PATCH 1/1] Add a type for errors
Date: Mon, 30 Sep 2024 22:03:52 +0000
Message-ID: <20240930220352.2461975-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is work underway to move some of the Git code out into a reusable
library.  In such a case, it's not very desirable to have the library
code write random errors to standard error, since this is an antipattern
which annoys terminal users.

Instead, we will expect callers of our library function to return
errors.  The reusability of our library will be substantially improved
if we return typed errors so that users can easily determine what kind
of error might have occurred and react differently based on different
contexts.  For example, if we are looking up an object in a partial
clone and it's not found, we might decide to download it, but we might
return an error to the user if the problem is instead that the revision
specified is not syntactically valid.

To help the libification process and make our code more generally
maintainable, add an error type.  This consists of on 64-bit integer,
which contains bit flags and a 32-bit code, and a pointer, which depends
on the code.  It is designed to be passed and returned by value, not
pointer, and it is possible to do so in two registers on 64-bit systems.
Similar functionality works well for error types in Rust and for the
standard library's lldiv_t, so this should not pose a problem.

Provide the ability to specify either an errno value or a git error code
as the code.  This allows us to use this type generically when handling
errno values such as processing files, as well as express a rich set of
possible error codes specific to Git.  We pick an unsigned 32-bit code
because Windows can use the full set of 32 bits in its error values,
even though most Unix systems use only a small set of codes which
traditionally start at 1.  32 bits for Git errors also allows us plenty
of space to expand as we see fit.

Allow multiple errors to be provided and wrapped in a single object,
which is useful in many situations, and add helpers to determine if any
error in the set matches a particular code.

Additionally, provide error formatting functions that produce a suitable
localized string for ease of use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile |   1 +
 error.c  |  43 ++++++++++++++
 error.h  | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 error.c
 create mode 100644 error.h

diff --git a/Makefile b/Makefile
index 7344a7f725..5d9bf992e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1013,6 +1013,7 @@ LIB_OBJS += dir.o
 LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
+LIB_OBJS += error.o
 LIB_OBJS += ewah/bitmap.o
 LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
diff --git a/error.c b/error.c
new file mode 100644
index 0000000000..713bc42187
--- /dev/null
+++ b/error.c
@@ -0,0 +1,43 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "error.h"
+#include "hex.h"
+#include "strbuf.h"
+
+const char *git_error_string(struct git_error err)
+{
+	struct strbuf buf = STRBUF_INIT;
+	if (!git_error_strbuf(&buf, err))
+		return NULL;
+	return strbuf_detach(&buf, NULL);
+}
+
+const char *git_error_strbuf(struct strbuf *buf, struct git_error err)
+{
+	if (GIT_ERROR_SUCCESS(err)) {
+		return NULL;
+	} else if (GIT_ERROR_ERRNO(err) != -1) {
+		return xstrdup(strerror(GIT_ERROR_ERRNO(err)));
+	} else {
+		struct git_error_multiple *me = err.meta;
+		switch (GIT_ERROR_GITERR(err)) {
+		case GIT_ERR_OBJECT_NOT_FOUND:
+			if (err.meta)
+				strbuf_addf(buf, _("object not found: %s"), oid_to_hex(err.meta));
+			else
+				strbuf_addf(buf, _("object not found"));
+		case GIT_ERR_NULL_OID:
+			if (err.meta)
+				strbuf_addf(buf, _("null object ID not allowed in this context: %s"), (char *)err.meta);
+			else
+				strbuf_addf(buf, _("null object ID not allowed"));
+		case GIT_ERR_MULTIPLE:
+			strbuf_addf(buf, _("multiple errors:\n"));
+			for (size_t i = 0; i < me->count; i++) {
+				git_error_strbuf(buf, me->errs[i]);
+				strbuf_addstr(buf, "\n");
+			}
+		}
+		return buf->buf;
+	}
+}
diff --git a/error.h b/error.h
new file mode 100644
index 0000000000..485cca99e0
--- /dev/null
+++ b/error.h
@@ -0,0 +1,168 @@
+#ifndef ERROR_H
+#define ERROR_H
+
+#include "git-compat-util.h"
+
+/* Set if this value is initialized. */
+#define GIT_ERROR_BIT_INIT (1ULL << 63)
+/* Set if the code is an errno code, clear if it's a git error code. */
+#define GIT_ERROR_BIT_ERRNO (1ULL << 62)
+/*
+ * Set if the memory in meta should be freed; otherwise, it's statically
+ * allocated.
+ */
+#define GIT_ERROR_BIT_ALLOC (1ULL << 61)
+/*
+ * Set if the memory in meta is a C string; otherwise, it's a metadata struct.
+ */
+#define GIT_ERROR_BIT_MSG (1ULL << 60)
+
+#define GIT_ERROR_BIT_MASK (0xf << 60)
+
+#define GIT_ERROR_OK (git_error_ok())
+
+#define GIT_ERROR_SUCCESS(e) (((e).code == GIT_ERROR_BIT_INIT))
+#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code == GIT_ERROR_BIT_INIT)
+
+#define GIT_ERROR_ERRNO(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? ((e).code & 0xffffffff) : -1)
+#define GIT_ERROR_GITERR(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? -1 : ((e).code & 0xffffffff))
+
+/*
+ * A value representing an error in Git.
+ */
+struct git_error {
+	uint64_t code;
+	void *meta;
+};
+
+struct git_error_multiple {
+	struct git_error *errs;
+	size_t count;
+};
+
+enum git_error_code {
+	/* The operation was a success. */
+	GIT_ERR_SUCCESS = 0,
+	/* An object ID was provided, but it was not found.
+	 *
+	 * meta will be NULL or a pointer to struct object ID.
+	 */
+	GIT_ERR_OBJECT_NOT_FOUND = 1,
+	/*
+	 * An object ID was provided, but it is all zeros and that is not
+	 * allowed.
+	 *
+	 * meta will be NULL or a message explaining the context.
+	 */
+	GIT_ERR_NULL_OID = 2,
+	/*
+	 * Multiple errors occurred.
+	 *
+	 * meta must be a pointer to struct git_error_multiple.
+	 */
+	GIT_ERR_MULTIPLE = 3,
+};
+
+const char *git_error_string(struct git_error err);
+const char *git_error_strbuf(struct strbuf *buf, struct git_error err);
+
+/*
+ * A successful error status.
+ */
+static inline struct git_error git_error_ok(void) {
+	struct git_error e =  {
+		.code = 0 | GIT_ERROR_BIT_INIT,
+		.meta = NULL,
+	};
+	return e;
+}
+
+static inline struct git_error git_error_new_errno(uint32_t errnoval, const char *msg, int to_free) {
+	struct git_error e =  {
+		.code = errnoval | GIT_ERROR_BIT_INIT | GIT_ERROR_BIT_ERRNO |
+			GIT_ERROR_BIT_MSG | (to_free ? GIT_ERROR_BIT_ALLOC : 0),
+		.meta = (void *)msg,
+	};
+	return e;
+}
+
+static inline struct git_error git_error_new_git(uint32_t gitcode, const char *msg, int to_free) {
+	struct git_error e =  {
+		.code = gitcode | GIT_ERROR_BIT_INIT |
+			GIT_ERROR_BIT_MSG | (to_free ? GIT_ERROR_BIT_ALLOC : 0),
+		.meta = (void *)msg,
+	};
+	return e;
+}
+
+static inline struct git_error git_error_new_simple(uint32_t gitcode) {
+	struct git_error e =  {
+		.code = gitcode | GIT_ERROR_BIT_INIT,
+		.meta = NULL,
+	};
+	return e;
+}
+
+static inline struct git_error git_error_new_multiple(struct git_error *errs, size_t count)
+{
+	struct git_error_multiple *me = xmalloc(sizeof(*me));
+	struct git_error e =  {
+		.code = GIT_ERR_MULTIPLE | GIT_ERROR_BIT_INIT | GIT_ERROR_BIT_ALLOC,
+		.meta = me,
+	};
+	me->errs = errs;
+	me->count = count;
+	return e;
+}
+
+/*
+ * If this is a git error and the code matches the given code, or if this is a
+ * multiple error and any of the contained errors are a git error whose code
+ * matches, returns a pointer to that error.  If there is no match, returns
+ * NULL.
+ */
+static inline struct git_error *git_error_is_git(struct git_error *e, int code) {
+	int64_t giterr = GIT_ERROR_GITERR(*e);
+	if (giterr == code) {
+		return e;
+	} else if (giterr == GIT_ERR_MULTIPLE) {
+		struct git_error_multiple *me = e->meta;
+		for (size_t i = 0; i < me->count; i++)
+			return git_error_is_git(me->errs + i, code);
+		return NULL;
+	} else {
+		return NULL;
+	}
+}
+
+/*
+ * If this is an errno error and the code matches the given code, or if this is
+ * a multiple error and any of the contained errors are an errno error whose
+ * code matches, returns a pointer to that error.  Otherwise, returns NULL.
+ */
+static inline struct git_error *git_error_is_errno(struct git_error *e, int code) {
+	int64_t giterr = GIT_ERROR_GITERR(*e);
+	if (GIT_ERROR_ERRNO(*e) == code) {
+		return e;
+	} else if (giterr == GIT_ERR_MULTIPLE) {
+		struct git_error_multiple *me = e->meta;
+		for (size_t i = 0; i < me->count; i++)
+			return git_error_is_errno(me->errs + i, code);
+		return NULL;
+	} else {
+		return NULL;
+	}
+}
+
+/* Frees and deinitializes this error structure. */
+static inline uint64_t git_error_free(struct git_error *e)
+{
+	uint64_t code = e->code;
+	if (e->code & GIT_ERROR_BIT_ALLOC)
+		free(e->meta);
+	e->code = 0;
+	e->meta = NULL;
+	return code;
+}
+
+#endif
