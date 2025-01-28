Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDE1F561B
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052913; cv=none; b=hKnI8/uD6GVS8PGgm3Y8pH8B6i3vi6WnpPxob+e74GZmtC39ZvnA37aJUWgvpPjcpGhiX+ZjnoHhixSfFgiZ4k5e5afxL/1y1kW3niIHLwe88Y7pGgbjL7hgwdDrHp8CyYKxpcMBlaVzB6yWnwDYuDsXzBQh0xh5PejaXMnI8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052913; c=relaxed/simple;
	bh=70Mp+joP5kQLNuCBWXfvVCD+d3H3NZpoiLuhM9do/iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AT1fnDUAyWkcHKNrWrunKE84NtuFvczjcgD+yCcSHm8P66fufvYvT30unykti17HrWnNZiVf/sKG8uSWH0yD4P5URgKtpLsFcovZPMZjBxC1SaoJPRqF/dvJMnIYXJ0VHhMRfs34iJgUH6soaFAqh108zl/dp5jRKbsIby8BGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sl/8XJP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rDrcIafX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sl/8XJP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDrcIafX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA0CA254024D;
	Tue, 28 Jan 2025 03:28:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jan 2025 03:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052910;
	 x=1738139310; bh=f8s5hyTbcDNFMR3NRN1dgbiVGyS3L2MppUnT97gP8is=; b=
	Sl/8XJP23G+IMyW3pKN19JH2Xe80C0Zh10v9l5GaBH8QN8czuAq24UJdnNTw2vB3
	RPrgOV383UHN6CdWdM37U3OS7BCHjYlQZ7NgjkYSxhnksHDwFMpdtoMtjPv7cFQQ
	wguSgJUgRzoHHYTtMAu5eQZf5NDEQg48WZf9Q8sR3baojD/0B+Nr8iZg4nJXJctV
	YRAvnTWTFjc9P/kUo4oH/zKq5ttDzJoTdRDckeRZY8gQ+cAZDfO3YP6m7cx5A3xr
	4qHaAm/A4v99RvPE4nt2U4QMSflwfC5ilDNeqok7e11VR3/JTF+ZIsV87sNa9bnl
	pFhizzoOkt8jqeprRxZJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052910; x=
	1738139310; bh=f8s5hyTbcDNFMR3NRN1dgbiVGyS3L2MppUnT97gP8is=; b=r
	DrcIafXCd9aVDb8dEWe5QDQ5yiihK8kEBR+WpIhnVvLmt4wRb14i4qhVn/NfemUb
	0MvsxOIXfos1RCLBpUBivNiQp+sswd2o2sSxjqkHp1POKQx7MzrP9gzswvV1N7zr
	UHGbt/7VARgi9hRrBH5tCWXwPxNPAwTy1WwKrP41hdUL1zThi89VxwHc/bpWi7mw
	dWwprjVBjSTfIOUX6DWobbcDVdcminT7NNTSg1hYDWvAESVcbaeOHy+i2M9IBd6K
	i+UQE5PrWeumI9OFmzmg1DBssCs77tyosFTc4bKBgpwU5AVeq6JSqPRpLHE3rl2e
	Lk6Vfnwt+oWcsJvAcn6sg==
X-ME-Sender: <xms:LpWYZ39fiN8jiO6lJiu4R3De2_bKqKLv1TJDQxww6WX8OAGj015lsg>
    <xme:LpWYZzvf5iWjwOVUq4tehd06TuT1Bx-tJhSv_eZNf2isxvsIQygsW_mi7SYZ_XAAB
    TRbE-tG2BIldZ6KnA>
X-ME-Received: <xmr:LpWYZ1BmoHss0SsyeW9VAa2M9VZdOM3nxos3jJvTzesHrOQubsTJMK0_MoiaKGON_NjK9-NXi50Vgr6Wlbeqp8VzXN_021IR4q2bPlXeOJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:LpWYZzfc2rWlcFsuI-RlRdxh6kTKpqtnmAVQWKjcWMCvWMCPlDG0iA>
    <xmx:LpWYZ8PxAAFQpijR0XALLAH777iHl7AH1D8x5tKJBS9AXoz4GJYVjw>
    <xmx:LpWYZ1m-RsHV2MRn4g0PbtdlOtNu6L-7zWMs6mTAHfKPoSPB-Dvt5A>
    <xmx:LpWYZ2uTzPSXmJPS0y-kAWct66Teua0jvh8Ht7fr5tWLdUK4BY7Ntw>
    <xmx:LpWYZ5oEV7ZTxhKMYTI-7FXrqjszZ4tE7TuQKZtY5EpnYX_5ePow35vb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30de9f10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:17 +0100
Subject: [PATCH v2 16/20] compat/mingw: split out POSIX-related bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-16-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Split out the POSIX-related bits from "compat/mingw.h". This is in
preparation for splitting up "git-compat-utils.h" into a header that
provides POSIX-compatibility and a header that provides common wrappers
used by the Git project.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/{mingw.c => mingw/compat-util.c} |   0
 compat/mingw/compat-util.h              | 220 ++++++++++++++++++++++++++++++++
 compat/{mingw.h => mingw/posix.h}       | 216 +------------------------------
 compat/msvc.c                           |   2 +-
 compat/msvc.h                           |   2 +-
 config.mak.uname                        |   4 +-
 contrib/buildsystems/CMakeLists.txt     |   2 +-
 git-compat-util.h                       |   4 +-
 meson.build                             |   6 +-
 9 files changed, 234 insertions(+), 222 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw/compat-util.c
similarity index 100%
rename from compat/mingw.c
rename to compat/mingw/compat-util.c
diff --git a/compat/mingw/compat-util.h b/compat/mingw/compat-util.h
new file mode 100644
index 0000000000..b433762526
--- /dev/null
+++ b/compat/mingw/compat-util.h
@@ -0,0 +1,220 @@
+#ifndef COMPAT_MINGW_COMPAT_UTIL_H
+#define COMPAT_MINGW_COMPAT_UTIL_H
+
+#include "compat/mingw/posix.h"
+
+struct config_context;
+int mingw_core_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb);
+#define platform_core_config mingw_core_config
+
+#ifndef NO_OPENSSL
+#include <openssl/ssl.h>
+static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
+{
+	return SSL_set_fd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_fd mingw_SSL_set_fd
+
+static inline int mingw_SSL_set_rfd(SSL *ssl, int fd)
+{
+	return SSL_set_rfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_rfd mingw_SSL_set_rfd
+
+static inline int mingw_SSL_set_wfd(SSL *ssl, int fd)
+{
+	return SSL_set_wfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_wfd mingw_SSL_set_wfd
+#endif
+
+/*
+ * git specific compatibility
+ */
+
+static inline void convert_slashes(char *path)
+{
+	for (; *path; path++)
+		if (*path == '\\')
+			*path = '/';
+}
+#define PATH_SEP ';'
+char *mingw_query_user_email(void);
+#define query_user_email mingw_query_user_email
+
+/**
+ * Verifies that the specified path is owned by the user running the
+ * current process.
+ */
+int is_path_owned_by_current_sid(const char *path, struct strbuf *report);
+#define is_path_owned_by_current_user is_path_owned_by_current_sid
+
+/**
+ * Verifies that the given path is a valid one on Windows.
+ *
+ * In particular, path segments are disallowed which
+ *
+ * - end in a period or a space (except the special directories `.` and `..`).
+ *
+ * - contain any of the reserved characters, e.g. `:`, `;`, `*`, etc
+ *
+ * - correspond to reserved names (such as `AUX`, `PRN`, etc)
+ *
+ * The `allow_literal_nul` parameter controls whether the path `NUL` should
+ * be considered valid (this makes sense e.g. before opening files, as it is
+ * perfectly legitimate to open `NUL` on Windows, just as it is to open
+ * `/dev/null` on Unix/Linux).
+ *
+ * Returns 1 upon success, otherwise 0.
+ */
+int is_valid_win32_path(const char *path, int allow_literal_nul);
+#define is_valid_path(path) is_valid_win32_path(path, 0)
+
+/**
+ * Converts UTF-8 encoded string to UTF-16LE.
+ *
+ * To support repositories with legacy-encoded file names, invalid UTF-8 bytes
+ * 0xa0 - 0xff are converted to corresponding printable Unicode chars \u00a0 -
+ * \u00ff, and invalid UTF-8 bytes 0x80 - 0x9f (which would make non-printable
+ * Unicode) are converted to hex-code.
+ *
+ * Lead-bytes not followed by an appropriate number of trail-bytes, over-long
+ * encodings and 4-byte encodings > \u10ffff are detected as invalid UTF-8.
+ *
+ * Maximum space requirement for the target buffer is two wide chars per UTF-8
+ * char (((strlen(utf) * 2) + 1) [* sizeof(wchar_t)]).
+ *
+ * The maximum space is needed only if the entire input string consists of
+ * invalid UTF-8 bytes in range 0x80-0x9f, as per the following table:
+ *
+ *               |                   | UTF-8 | UTF-16 |
+ *   Code point  |  UTF-8 sequence   | bytes | words  | ratio
+ * --------------+-------------------+-------+--------+-------
+ * 000000-00007f | 0-7f              |   1   |   1    |  1
+ * 000080-0007ff | c2-df + 80-bf     |   2   |   1    |  0.5
+ * 000800-00ffff | e0-ef + 2 * 80-bf |   3   |   1    |  0.33
+ * 010000-10ffff | f0-f4 + 3 * 80-bf |   4   |  2 (a) |  0.5
+ * invalid       | 80-9f             |   1   |  2 (b) |  2
+ * invalid       | a0-ff             |   1   |   1    |  1
+ *
+ * (a) encoded as UTF-16 surrogate pair
+ * (b) encoded as two hex digits
+ *
+ * Note that, while the UTF-8 encoding scheme can be extended to 5-byte, 6-byte
+ * or even indefinite-byte sequences, the largest valid code point \u10ffff
+ * encodes as only 4 UTF-8 bytes.
+ *
+ * Parameters:
+ * wcs: wide char target buffer
+ * utf: string to convert
+ * wcslen: size of target buffer (in wchar_t's)
+ * utflen: size of string to convert, or -1 if 0-terminated
+ *
+ * Returns:
+ * length of converted string (_wcslen(wcs)), or -1 on failure
+ *
+ * Errors:
+ * EINVAL: one of the input parameters is invalid (e.g. NULL)
+ * ERANGE: the output buffer is too small
+ */
+int xutftowcsn(wchar_t *wcs, const char *utf, size_t wcslen, int utflen);
+
+/**
+ * Simplified variant of xutftowcsn, assumes input string is \0-terminated.
+ */
+static inline int xutftowcs(wchar_t *wcs, const char *utf, size_t wcslen)
+{
+	return xutftowcsn(wcs, utf, wcslen, -1);
+}
+
+/**
+ * Simplified file system specific variant of xutftowcsn, assumes output
+ * buffer size is MAX_PATH wide chars and input string is \0-terminated,
+ * fails with ENAMETOOLONG if input string is too long.
+ */
+static inline int xutftowcs_path(wchar_t *wcs, const char *utf)
+{
+	int result = xutftowcsn(wcs, utf, MAX_PATH, -1);
+	if (result < 0 && errno == ERANGE)
+		errno = ENAMETOOLONG;
+	return result;
+}
+
+/**
+ * Converts UTF-16LE encoded string to UTF-8.
+ *
+ * Maximum space requirement for the target buffer is three UTF-8 chars per
+ * wide char ((_wcslen(wcs) * 3) + 1).
+ *
+ * The maximum space is needed only if the entire input string consists of
+ * UTF-16 words in range 0x0800-0xd7ff or 0xe000-0xffff (i.e. \u0800-\uffff
+ * modulo surrogate pairs), as per the following table:
+ *
+ *               |                       | UTF-16 | UTF-8 |
+ *   Code point  |  UTF-16 sequence      | words  | bytes | ratio
+ * --------------+-----------------------+--------+-------+-------
+ * 000000-00007f | 0000-007f             |   1    |   1   |  1
+ * 000080-0007ff | 0080-07ff             |   1    |   2   |  2
+ * 000800-00ffff | 0800-d7ff / e000-ffff |   1    |   3   |  3
+ * 010000-10ffff | d800-dbff + dc00-dfff |   2    |   4   |  2
+ *
+ * Note that invalid code points > 10ffff cannot be represented in UTF-16.
+ *
+ * Parameters:
+ * utf: target buffer
+ * wcs: wide string to convert
+ * utflen: size of target buffer
+ *
+ * Returns:
+ * length of converted string, or -1 on failure
+ *
+ * Errors:
+ * EINVAL: one of the input parameters is invalid (e.g. NULL)
+ * ERANGE: the output buffer is too small
+ */
+int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen);
+
+/*
+ * A critical section used in the implementation of the spawn
+ * functions (mingw_spawnv[p]e()) and waitpid(). Initialised in
+ * the replacement main() macro below.
+ */
+extern CRITICAL_SECTION pinfo_cs;
+
+/*
+ * Git, like most portable C applications, implements a main() function. On
+ * Windows, this main() function would receive parameters encoded in the
+ * current locale, but Git for Windows would prefer UTF-8 encoded  parameters.
+ *
+ * To make that happen, we still declare main() here, and then declare and
+ * implement wmain() (which is the Unicode variant of main()) and compile with
+ * -municode. This wmain() function reencodes the parameters from UTF-16 to
+ * UTF-8 format, sets up a couple of other things as required on Windows, and
+ * then hands off to the main() function.
+ */
+int wmain(int argc, const wchar_t **w_argv);
+int main(int argc, const char **argv);
+
+/*
+ * For debugging: if a problem occurs, say, in a Git process that is spawned
+ * from another Git process which in turn is spawned from yet another Git
+ * process, it can be quite daunting to figure out what is going on.
+ *
+ * Call this function to open a new MinTTY (this assumes you are in Git for
+ * Windows' SDK) with a GDB that attaches to the current process right away.
+ */
+void open_in_gdb(void);
+
+/*
+ * Used by Pthread API implementation for Windows
+ */
+int err_win_to_posix(DWORD winerr);
+
+#ifndef NO_UNIX_SOCKETS
+int mingw_have_unix_sockets(void);
+#undef have_unix_sockets
+#define have_unix_sockets mingw_have_unix_sockets
+#endif
+
+#endif /* COMPAT_MINGW_COMPAT_UTIL_H */
diff --git a/compat/mingw.h b/compat/mingw/posix.h
similarity index 59%
rename from compat/mingw.h
rename to compat/mingw/posix.h
index ebfb8ba423..8dddfa818d 100644
--- a/compat/mingw.h
+++ b/compat/mingw/posix.h
@@ -1,3 +1,6 @@
+#ifndef COMPAT_MINGW_POSIX_H
+#define COMPAT_MINGW_POSIX_H
+
 #ifdef __MINGW64_VERSION_MAJOR
 #include <stdint.h>
 #include <wchar.h>
@@ -11,11 +14,6 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
-struct config_context;
-int mingw_core_config(const char *var, const char *value,
-		      const struct config_context *ctx, void *cb);
-#define platform_core_config mingw_core_config
-
 /*
  * things that are not available in header files
  */
@@ -180,27 +178,6 @@ int mingw_kill(pid_t pid, int sig);
 #define locate_in_PATH mingw_locate_in_PATH
 char *mingw_locate_in_PATH(const char *cmd);
 
-#ifndef NO_OPENSSL
-#include <openssl/ssl.h>
-static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-{
-	return SSL_set_fd(ssl, _get_osfhandle(fd));
-}
-#define SSL_set_fd mingw_SSL_set_fd
-
-static inline int mingw_SSL_set_rfd(SSL *ssl, int fd)
-{
-	return SSL_set_rfd(ssl, _get_osfhandle(fd));
-}
-#define SSL_set_rfd mingw_SSL_set_rfd
-
-static inline int mingw_SSL_set_wfd(SSL *ssl, int fd)
-{
-	return SSL_set_wfd(ssl, _get_osfhandle(fd));
-}
-#define SSL_set_wfd mingw_SSL_set_wfd
-#endif
-
 /*
  * implementations of missing functions
  */
@@ -444,19 +421,6 @@ int winansi_dup2(int oldfd, int newfd);
 void winansi_init(void);
 HANDLE winansi_get_osfhandle(int fd);
 
-/*
- * git specific compatibility
- */
-
-static inline void convert_slashes(char *path)
-{
-	for (; *path; path++)
-		if (*path == '\\')
-			*path = '/';
-}
-#define PATH_SEP ';'
-char *mingw_query_user_email(void);
-#define query_user_email mingw_query_user_email
 #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
@@ -464,176 +428,4 @@ char *mingw_query_user_email(void);
 #include <inttypes.h>
 #endif
 
-/**
- * Verifies that the specified path is owned by the user running the
- * current process.
- */
-int is_path_owned_by_current_sid(const char *path, struct strbuf *report);
-#define is_path_owned_by_current_user is_path_owned_by_current_sid
-
-/**
- * Verifies that the given path is a valid one on Windows.
- *
- * In particular, path segments are disallowed which
- *
- * - end in a period or a space (except the special directories `.` and `..`).
- *
- * - contain any of the reserved characters, e.g. `:`, `;`, `*`, etc
- *
- * - correspond to reserved names (such as `AUX`, `PRN`, etc)
- *
- * The `allow_literal_nul` parameter controls whether the path `NUL` should
- * be considered valid (this makes sense e.g. before opening files, as it is
- * perfectly legitimate to open `NUL` on Windows, just as it is to open
- * `/dev/null` on Unix/Linux).
- *
- * Returns 1 upon success, otherwise 0.
- */
-int is_valid_win32_path(const char *path, int allow_literal_nul);
-#define is_valid_path(path) is_valid_win32_path(path, 0)
-
-/**
- * Converts UTF-8 encoded string to UTF-16LE.
- *
- * To support repositories with legacy-encoded file names, invalid UTF-8 bytes
- * 0xa0 - 0xff are converted to corresponding printable Unicode chars \u00a0 -
- * \u00ff, and invalid UTF-8 bytes 0x80 - 0x9f (which would make non-printable
- * Unicode) are converted to hex-code.
- *
- * Lead-bytes not followed by an appropriate number of trail-bytes, over-long
- * encodings and 4-byte encodings > \u10ffff are detected as invalid UTF-8.
- *
- * Maximum space requirement for the target buffer is two wide chars per UTF-8
- * char (((strlen(utf) * 2) + 1) [* sizeof(wchar_t)]).
- *
- * The maximum space is needed only if the entire input string consists of
- * invalid UTF-8 bytes in range 0x80-0x9f, as per the following table:
- *
- *               |                   | UTF-8 | UTF-16 |
- *   Code point  |  UTF-8 sequence   | bytes | words  | ratio
- * --------------+-------------------+-------+--------+-------
- * 000000-00007f | 0-7f              |   1   |   1    |  1
- * 000080-0007ff | c2-df + 80-bf     |   2   |   1    |  0.5
- * 000800-00ffff | e0-ef + 2 * 80-bf |   3   |   1    |  0.33
- * 010000-10ffff | f0-f4 + 3 * 80-bf |   4   |  2 (a) |  0.5
- * invalid       | 80-9f             |   1   |  2 (b) |  2
- * invalid       | a0-ff             |   1   |   1    |  1
- *
- * (a) encoded as UTF-16 surrogate pair
- * (b) encoded as two hex digits
- *
- * Note that, while the UTF-8 encoding scheme can be extended to 5-byte, 6-byte
- * or even indefinite-byte sequences, the largest valid code point \u10ffff
- * encodes as only 4 UTF-8 bytes.
- *
- * Parameters:
- * wcs: wide char target buffer
- * utf: string to convert
- * wcslen: size of target buffer (in wchar_t's)
- * utflen: size of string to convert, or -1 if 0-terminated
- *
- * Returns:
- * length of converted string (_wcslen(wcs)), or -1 on failure
- *
- * Errors:
- * EINVAL: one of the input parameters is invalid (e.g. NULL)
- * ERANGE: the output buffer is too small
- */
-int xutftowcsn(wchar_t *wcs, const char *utf, size_t wcslen, int utflen);
-
-/**
- * Simplified variant of xutftowcsn, assumes input string is \0-terminated.
- */
-static inline int xutftowcs(wchar_t *wcs, const char *utf, size_t wcslen)
-{
-	return xutftowcsn(wcs, utf, wcslen, -1);
-}
-
-/**
- * Simplified file system specific variant of xutftowcsn, assumes output
- * buffer size is MAX_PATH wide chars and input string is \0-terminated,
- * fails with ENAMETOOLONG if input string is too long.
- */
-static inline int xutftowcs_path(wchar_t *wcs, const char *utf)
-{
-	int result = xutftowcsn(wcs, utf, MAX_PATH, -1);
-	if (result < 0 && errno == ERANGE)
-		errno = ENAMETOOLONG;
-	return result;
-}
-
-/**
- * Converts UTF-16LE encoded string to UTF-8.
- *
- * Maximum space requirement for the target buffer is three UTF-8 chars per
- * wide char ((_wcslen(wcs) * 3) + 1).
- *
- * The maximum space is needed only if the entire input string consists of
- * UTF-16 words in range 0x0800-0xd7ff or 0xe000-0xffff (i.e. \u0800-\uffff
- * modulo surrogate pairs), as per the following table:
- *
- *               |                       | UTF-16 | UTF-8 |
- *   Code point  |  UTF-16 sequence      | words  | bytes | ratio
- * --------------+-----------------------+--------+-------+-------
- * 000000-00007f | 0000-007f             |   1    |   1   |  1
- * 000080-0007ff | 0080-07ff             |   1    |   2   |  2
- * 000800-00ffff | 0800-d7ff / e000-ffff |   1    |   3   |  3
- * 010000-10ffff | d800-dbff + dc00-dfff |   2    |   4   |  2
- *
- * Note that invalid code points > 10ffff cannot be represented in UTF-16.
- *
- * Parameters:
- * utf: target buffer
- * wcs: wide string to convert
- * utflen: size of target buffer
- *
- * Returns:
- * length of converted string, or -1 on failure
- *
- * Errors:
- * EINVAL: one of the input parameters is invalid (e.g. NULL)
- * ERANGE: the output buffer is too small
- */
-int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen);
-
-/*
- * A critical section used in the implementation of the spawn
- * functions (mingw_spawnv[p]e()) and waitpid(). Initialised in
- * the replacement main() macro below.
- */
-extern CRITICAL_SECTION pinfo_cs;
-
-/*
- * Git, like most portable C applications, implements a main() function. On
- * Windows, this main() function would receive parameters encoded in the
- * current locale, but Git for Windows would prefer UTF-8 encoded  parameters.
- *
- * To make that happen, we still declare main() here, and then declare and
- * implement wmain() (which is the Unicode variant of main()) and compile with
- * -municode. This wmain() function reencodes the parameters from UTF-16 to
- * UTF-8 format, sets up a couple of other things as required on Windows, and
- * then hands off to the main() function.
- */
-int wmain(int argc, const wchar_t **w_argv);
-int main(int argc, const char **argv);
-
-/*
- * For debugging: if a problem occurs, say, in a Git process that is spawned
- * from another Git process which in turn is spawned from yet another Git
- * process, it can be quite daunting to figure out what is going on.
- *
- * Call this function to open a new MinTTY (this assumes you are in Git for
- * Windows' SDK) with a GDB that attaches to the current process right away.
- */
-void open_in_gdb(void);
-
-/*
- * Used by Pthread API implementation for Windows
- */
-int err_win_to_posix(DWORD winerr);
-
-#ifndef NO_UNIX_SOCKETS
-int mingw_have_unix_sockets(void);
-#undef have_unix_sockets
-#define have_unix_sockets mingw_have_unix_sockets
-#endif
+#endif /* COMPAT_MINGW_POSIX_H */
diff --git a/compat/msvc.c b/compat/msvc.c
index 5aacf3af19..7b6b8ddc71 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -3,4 +3,4 @@
 #include <conio.h>
 #include "strbuf.h"
 
-#include "compat/mingw.c"
+#include "compat/mingw/compat-util.c"
diff --git a/compat/msvc.h b/compat/msvc.h
index 1d7a8c6145..df39978f4f 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -28,6 +28,6 @@ typedef int sigset_t;
 /* open for reading, writing, or both (not in fcntl.h) */
 #define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
 
-#include "compat/mingw.h"
+#include "compat/mingw/compat-util.h"
 
 #endif
diff --git a/config.mak.uname b/config.mak.uname
index cd9535a65c..38a774de39 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -541,7 +541,7 @@ endif
 
 	EXTRA_PROGRAMS += headless-git$X
 
-compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
+compat/msvc.o: compat/msvc.c compat/mingw/compat-util.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
@@ -694,7 +694,7 @@ ifeq ($(uname_S),MINGW)
 	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+	COMPAT_OBJS += compat/mingw/compat-util.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/flush.o \
 		compat/win32/path-utils.o \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 10dc54fdcb..65ce8705f0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -258,7 +258,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
 	list(APPEND compat_SOURCES
-		compat/mingw.c
+		compat/mingw/compat-util.c
 		compat/winansi.c
 		compat/win32/flush.c
 		compat/win32/path-utils.c
diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..b96fb98e1e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -304,10 +304,10 @@ static inline int is_xplatform_dir_sep(int c)
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/win32/path-utils.h"
-#include "compat/mingw.h"
+#include "compat/mingw/compat-util.h"
 #elif defined(_MSC_VER)
 #include "compat/win32/path-utils.h"
-#include "compat/msvc.h"
+#include "compat/msvc/compat-util.h"
 #else
 #include <sys/utsname.h>
 #include <sys/wait.h>
diff --git a/meson.build b/meson.build
index 2297f5e9dd..32eb0a86d5 100644
--- a/meson.build
+++ b/meson.build
@@ -1054,7 +1054,7 @@ if host_machine.system() == 'cygwin'
   ]
 elif host_machine.system() == 'windows'
   libgit_sources += [
-    'compat/mingw.c',
+    'compat/mingw/compat-util.c',
     'compat/winansi.c',
     'compat/win32/flush.c',
     'compat/win32/path-utils.c',
@@ -1157,7 +1157,7 @@ else
     error('Native regex support requested but not found')
 endif
 
-# setitimer and friends are provided by compat/mingw.c.
+# setitimer and friends are provided by compat/mingw/compat-util.c.
 if host_machine.system() != 'windows'
   if not compiler.compiles('''
     #include <sys/time.h>
@@ -1237,7 +1237,7 @@ if not compiler.has_function('qsort')
 endif
 libgit_sources += 'compat/qsort_s.c'
 
-# unsetenv is provided by compat/mingw.c.
+# unsetenv is provided by compat/mingw/compat-util.c.
 if host_machine.system() != 'windows' and not compiler.has_function('unsetenv')
   libgit_c_args += '-DNO_UNSETENV'
   libgit_sources += 'compat/unsetenv.c'

-- 
2.48.1.362.g079036d154.dirty

