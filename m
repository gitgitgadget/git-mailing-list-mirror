From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 2/3] git over TLS (gits://) support (part 2)
Date: Sat,  1 May 2010 20:09:50 +0300
Message-ID: <1272733791-11341-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 19:13:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GG5-0006XN-7L
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0EARMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:12:53 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59868 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0EARMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:12:31 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id B9E6118CF00
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:28 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00F20B6F15; Sat, 01 May 2010 20:12:28 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id B31FB2BD47
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:26 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146093>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 git-over-tls/.gitignore                      |    5 +
 git-over-tls/base64.c                        |  171 +++++++
 git-over-tls/base64.h                        |   21 +
 git-over-tls/certificate.c                   |  306 ++++++++++++
 git-over-tls/certificate.h                   |   28 +
 git-over-tls/connect.c                       |  275 +++++++++++
 git-over-tls/connect.h                       |   17 +
 git-over-tls/genkeypair.c                    |   38 ++
 git-over-tls/gensrpverifier.c                |  377 ++++++++++++++
 git-over-tls/getkeyid.c                      |  179 +++++++
 git-over-tls/gits-send-special-command       |   22 +
 git-over-tls/gits-send-special-command-nourl |   23 +
 git-over-tls/home.c                          |  229 +++++++++
 git-over-tls/home.h                          |   71 +++
 git-over-tls/hostkey.c                       |   81 +++
 git-over-tls/hostkey.h                       |   15 +
 git-over-tls/keypairs.c                      |   60 +++
 git-over-tls/keypairs.h                      |   16 +
 git-over-tls/main.c                          |  684 ++++++++++++++++++++++++++
 git-over-tls/misc.c                          |   15 +
 git-over-tls/misc.h                          |   27 +
 git-over-tls/mkcert.c                        |  474 ++++++++++++++++++
 git-over-tls/prompt.c                        |  100 ++++
 git-over-tls/prompt.h                        |   18 +
 git-over-tls/srp_askpass.c                   |  110 ++++
 git-over-tls/srp_askpass.h                   |   16 +
 26 files changed, 3378 insertions(+), 0 deletions(-)
 create mode 100644 git-over-tls/.gitignore
 create mode 100644 git-over-tls/base64.c
 create mode 100644 git-over-tls/base64.h
 create mode 100644 git-over-tls/certificate.c
 create mode 100644 git-over-tls/certificate.h
 create mode 100644 git-over-tls/connect.c
 create mode 100644 git-over-tls/connect.h
 create mode 100644 git-over-tls/genkeypair.c
 create mode 100644 git-over-tls/gensrpverifier.c
 create mode 100644 git-over-tls/getkeyid.c
 create mode 100755 git-over-tls/gits-send-special-command
 create mode 100755 git-over-tls/gits-send-special-command-nourl
 create mode 100644 git-over-tls/home.c
 create mode 100644 git-over-tls/home.h
 create mode 100644 git-over-tls/hostkey.c
 create mode 100644 git-over-tls/hostkey.h
 create mode 100644 git-over-tls/keypairs.c
 create mode 100644 git-over-tls/keypairs.h
 create mode 100644 git-over-tls/main.c
 create mode 100644 git-over-tls/misc.c
 create mode 100644 git-over-tls/misc.h
 create mode 100644 git-over-tls/mkcert.c
 create mode 100644 git-over-tls/prompt.c
 create mode 100644 git-over-tls/prompt.h
 create mode 100644 git-over-tls/srp_askpass.c
 create mode 100644 git-over-tls/srp_askpass.h

diff --git a/git-over-tls/.gitignore b/git-over-tls/.gitignore
new file mode 100644
index 0000000..546e49c
--- /dev/null
+++ b/git-over-tls/.gitignore
@@ -0,0 +1,5 @@
+/git-remote-gits
+/gits-get-key-id
+/gits-generate-keypair
+/gits-generate-srp-verifier
+/gits-hostkey
diff --git a/git-over-tls/base64.c b/git-over-tls/base64.c
new file mode 100644
index 0000000..dbf5334
--- /dev/null
+++ b/git-over-tls/base64.c
@@ -0,0 +1,171 @@
+#include "base64.h"
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+void encode_uint32(unsigned char *ptr, unsigned long value)
+{
+	ptr[0] = (unsigned char)(value >> 24);
+	ptr[1] = (unsigned char)(value >> 16);
+	ptr[2] = (unsigned char)(value >> 8);
+	ptr[3] = (unsigned char)(value);
+}
+
+/* Base64 character value */
+static int char_value(unsigned char ch)
+{
+	if (ch >= 'A' && ch <= 'Z')
+		return ch - 'A';
+	if (ch >= 'a' && ch <= 'z')
+		return ch - 'a' + 26;
+	if (ch >= '0' && ch <= '9')
+		return ch - '0' + 52;
+	if (ch == '+')
+		return 62;
+	if (ch == '/')
+		return 63;
+	return -1;
+}
+
+/* Decode Base64 chunk. */
+unsigned char *decode_base64_chunk(const unsigned char *chunk,
+	size_t chunk_len, size_t *key_len)
+{
+	unsigned char *ret;
+	unsigned blockmod = 0;
+	int buf[4];
+	size_t i;
+
+	ret = xmalloc((chunk_len + 3) / 4 * 3);
+	*key_len = 0;
+
+	for(i = 0; i < chunk_len; i++) {
+		buf[blockmod] = char_value(chunk[i]);
+		if (buf[blockmod] >= 0)
+			blockmod++;
+		else
+			buf[blockmod] = 0;
+		if(blockmod == 4) {
+			int v = (buf[0] << 18) | (buf[1] << 12) |
+				(buf[2] << 6) | buf[3];
+			ret[(*key_len)++] = (unsigned char)(v >> 16);
+			ret[(*key_len)++] = (unsigned char)(v >> 8);
+			ret[(*key_len)++] = (unsigned char)(v);
+			blockmod = 0;
+			buf[0] = buf[1] = buf[2] = buf[3] = 0;
+		}
+	}
+	if(blockmod > 0) {
+		int v = (buf[0] << 18) | (buf[1] << 12) |
+			(buf[2] << 6) | buf[3];
+		if (blockmod > 1)
+			ret[(*key_len)++] = (unsigned char)(v >> 16);
+		if (blockmod > 2)
+			ret[(*key_len)++] = (unsigned char)(v >> 8);
+	}
+	return ret;
+}
+
+/* Return address of next (nonempty) line, or NULL if none. */
+const unsigned char *next_line(const unsigned char *blob,
+	size_t *remaining)
+{
+	while (*blob != '\r' && *blob != '\n') {
+		blob++;
+		(*remaining)--;
+		if (!*remaining)
+			return NULL;
+	}
+	while (*blob == '\r' || *blob == '\n') {
+		blob++;
+		(*remaining)--;
+		if (!*remaining)
+			return NULL;
+	}
+	return blob;
+}
+
+#define STATUS_INIT 0
+#define STATUS_HEADER 1
+#define STATUS_CONTINUE 2
+#define STATUS_EOL 3
+#define STATUS_EOL_CONTINUE 4
+
+/* Find start of base64 blob. */
+const unsigned char *base64_blob_start(const unsigned char *blob,
+	size_t *remaining)
+{
+	int status = STATUS_INIT;
+	const unsigned char *line_start;
+	size_t size_start;
+
+	line_start = blob;
+	size_start = *remaining;
+
+	while(1) {
+		switch(status) {
+		case STATUS_INIT:
+			if (!*remaining || *blob == '\r' || *blob == '\n') {
+				/* Back off to start of line. */
+				blob = line_start;
+				*remaining = size_start;
+				return blob;
+			}
+			if (*blob == ':')
+				status = STATUS_HEADER;
+			break;
+		case STATUS_HEADER:
+			if (!*remaining) {
+				*remaining = 0;
+				return NULL;
+			}
+			if (*blob == '\r' || *blob == '\n')
+				status = STATUS_EOL;
+			if (*blob == '\\')
+				status = STATUS_CONTINUE;
+			break;
+		case STATUS_CONTINUE:
+			if (!*remaining) {
+				*remaining = 0;
+				return NULL;
+			}
+			if (*blob == '\r' || *blob == '\n')
+				status = STATUS_EOL_CONTINUE;
+			else
+				status = STATUS_HEADER;
+			break;
+		case STATUS_EOL:
+			if (!*remaining) {
+				*remaining = 0;
+				return NULL;
+			}
+			if (*blob != '\r' && *blob != '\n') {
+				/* Mark line start and back off by one. */
+				line_start = blob;
+				size_start = *remaining;
+				blob--;
+				(*remaining)++;
+				status = STATUS_INIT;
+			}
+			break;
+		case STATUS_EOL_CONTINUE:
+			if (!*remaining) {
+				*remaining = 0;
+				return NULL;
+			}
+			if (*blob != '\r' && *blob != '\n') {
+				/* Mark line start and back off by one. */
+				line_start = blob;
+				size_start = *remaining;
+				blob--;
+				(*remaining)++;
+				status = STATUS_HEADER;
+			}
+			break;
+		}
+		blob++;
+		(*remaining)--;
+	}
+}
diff --git a/git-over-tls/base64.h b/git-over-tls/base64.h
new file mode 100644
index 0000000..b4352b1
--- /dev/null
+++ b/git-over-tls/base64.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _base64__h__included__
+#define _base64__h__included__
+
+#include <stdlib.h>
+
+unsigned char *decode_base64_chunk(const unsigned char *chunk,
+	size_t chunk_len, size_t *key_len);
+const unsigned char *base64_blob_start(const unsigned char *blob,
+	size_t *remaining);
+const unsigned char *next_line(const unsigned char *blob,
+	size_t *remaining);
+void encode_uint32(unsigned char *ptr, unsigned long value);
+
+#endif
diff --git a/git-over-tls/certificate.c b/git-over-tls/certificate.c
new file mode 100644
index 0000000..adeb776
--- /dev/null
+++ b/git-over-tls/certificate.c
@@ -0,0 +1,306 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "certificate.h"
+#include "cbuffer.h"
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#include "run-command.h"
+#endif
+
+#define CERT_MAX 65536
+
+static long read_short(struct cbuffer *buffer)
+{
+	unsigned char x[2];
+	if (cbuffer_read(buffer, x, 2) < 0)
+		return -1;
+
+	return ((long)x[0] << 8) | ((long)x[1]);
+}
+
+
+static int unseal_cert(struct cbuffer *sealed, struct cbuffer *unsealed,
+	const char *unsealer)
+{
+	struct child_process child;
+	char **argv;
+	char *unsealer_copy;
+	int splits = 0;
+	int escape = 0;
+	int ridx, widx, tidx;
+	const char *i;
+
+	signal(SIGPIPE, SIG_IGN);
+
+	for (i = unsealer; *i; i++) {
+		if (escape)
+			escape = 0;
+		else if (*i == '\\')
+			escape = 1;
+		else if (*i == ' ')
+			splits++;
+	}
+
+	argv = xmalloc((splits + 2) * sizeof(char*));
+	argv[splits + 1] = NULL;
+
+	unsealer_copy = xstrdup(unsealer);
+	argv[0] = unsealer_copy;
+
+	ridx = 0;
+	widx = 0;
+	tidx = 1;
+	escape = 0;
+	while (unsealer_copy[ridx]) {
+		if (escape) {
+			escape = 0;
+			unsealer_copy[widx++] = unsealer_copy[ridx++];
+		} else if (unsealer_copy[ridx] == '\\') {
+			ridx++;
+			escape = 1;
+		} else if (unsealer_copy[ridx] == ' ') {
+			unsealer_copy[widx++] = '\0';
+			argv[tidx++] = unsealer_copy + widx;
+			ridx++;
+		} else
+			unsealer_copy[widx++] = unsealer_copy[ridx++];
+	}
+	unsealer_copy[widx] = '\0';
+
+	memset(&child, 0, sizeof(child));
+	child.argv = (const char**)argv;
+	child.in = -1;
+	child.out = -1;
+	child.err = 0;
+	if (start_command(&child))
+		die("Running keypair unsealer command failed");
+
+	while (1) {
+		int bound;
+		fd_set rf;
+		fd_set wf;
+		int r;
+
+		FD_ZERO(&rf);
+		FD_ZERO(&wf);
+		FD_SET(child.out, &rf);
+		if (cbuffer_used(sealed))
+			FD_SET(child.in, &wf);
+		else
+			close(child.in);
+
+		if (cbuffer_used(sealed))
+			bound = ((child.out > child.in) ? child.out :
+				child.in) + 1;
+		else
+			bound = child.out + 1;
+
+		r = select(bound, &rf, &wf, NULL, NULL);
+		if (r < 0 && r != EINTR)
+			die_errno("Select failed");
+		if (r < 0) {
+			FD_ZERO(&rf);
+			FD_ZERO(&wf);
+			perror("select");
+		}
+
+		if (FD_ISSET(child.out, &rf)) {
+			r = cbuffer_read_fd(unsealed, child.out);
+			if (r < 0 && errno != EINTR && errno != EAGAIN)
+				die_errno("Read from unsealer failed");
+			if (r < 0 && errno == EAGAIN)
+				if (!cbuffer_free(unsealed))
+					die("Keypair too big");
+			if (r < 0)
+				perror("read");
+			if (r == 0)
+				break;
+		}
+
+		if (FD_ISSET(child.in, &wf)) {
+			r = cbuffer_write_fd(sealed, child.in);
+			if (r < 0 && errno == EPIPE)
+				die("Unsealer exited unexpectedly");
+			if (r < 0 && errno != EINTR && errno != EAGAIN)
+				die_errno("Write to unsealer failed");
+			if (r < 0)
+				perror("write");
+		}
+	}
+
+	if (finish_command(&child))
+		die("Keypair unsealer command failed");
+
+	return 0;
+}
+
+
+struct certificate parse_certificate(const char *name, int *errorcode)
+{
+	struct cbuffer *sealed = NULL;
+	struct cbuffer *unsealed = NULL;
+	unsigned char sealed_buf[CERT_MAX];
+	unsigned char unsealed_buf[CERT_MAX];
+	struct certificate cert;
+	int fd;
+	unsigned char head[10];
+	long tmp;
+
+	*errorcode = CERTERR_OK;
+	cert.public_key.data = NULL;
+	cert.public_key.size = 0;
+	cert.private_key.data = NULL;
+	cert.private_key.size = 0;
+
+	sealed = cbuffer_create(sealed_buf, CERT_MAX);
+	if (!sealed)
+		die("Ran out of memory");
+
+	unsealed = cbuffer_create(unsealed_buf, CERT_MAX);
+	if (!unsealed)
+		die("Ran out of memory");
+
+	fd = open(name, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			*errorcode = CERTERR_NOCERT;
+		else
+			*errorcode = CERTERR_CANTREAD;
+		goto out_unsealed;
+	}
+
+	while (1) {
+		ssize_t r = cbuffer_read_fd(sealed, fd);
+		if (r == 0)
+			break;
+		if (r < 0 && errno == EAGAIN) {
+			if (!cbuffer_free(sealed)) {
+				*errorcode = CERTERR_TOOBIG;
+				goto out_close;
+			}
+		} else if (r < 0 && errno != EINTR) {
+			*errorcode = CERTERR_CANTREAD;
+			goto out_close;
+		}
+	}
+
+	head[9] = 0;
+	if (cbuffer_read(sealed, head, 9) < 0) {
+		*errorcode = CERTERR_INVALID;
+		goto out_close;
+	}
+	if (strcmp((char*)head, "GITSSCERT") &&
+		strcmp((char*)head, "GITSUCERT")) {
+		*errorcode = CERTERR_INVALID;
+		goto out_close;
+	}
+
+	if (!strcmp((char*)head, "GITSSCERT")) {
+		/* Sealed certificate. */
+		char *unsealer;
+		int s;
+		tmp = read_short(sealed);
+		if (tmp <= 0) {
+			*errorcode = CERTERR_INVALID;
+			goto out_close;
+		}
+		unsealer = xmalloc(tmp + 1);
+		unsealer[tmp] = '\0';
+		if (cbuffer_read(sealed, (unsigned char*)unsealer, tmp) < 0) {
+			free(unsealer);
+			*errorcode = CERTERR_INVALID;
+			goto out_close;
+		}
+		s = unseal_cert(sealed, unsealed, unsealer);
+		free(unsealer);
+		if (s < 0) {
+			*errorcode = s;
+			goto out_close;
+		}
+	} else {
+		/* Unsealed certificate. */
+		cbuffer_move_nolimit(unsealed, sealed);
+	}
+
+	cert.private_key.data = NULL;
+	cert.public_key.data = NULL;
+
+	tmp = read_short(unsealed);
+	if (tmp < 0) {
+		*errorcode = CERTERR_INVALID;
+		goto out_close;
+	}
+	cert.private_key.size = tmp;
+	cert.private_key.data = (unsigned char*)gnutls_malloc(tmp);
+	if (!cert.private_key.data)
+		die("Ran out of memory");
+
+	if (cbuffer_read(unsealed, cert.private_key.data,
+		cert.private_key.size) < 0) {
+		*errorcode = CERTERR_INVALID;
+		goto out_private;
+	}
+
+	tmp = read_short(unsealed);
+	if (tmp < 0) {
+		*errorcode = CERTERR_INVALID;
+		goto out_close;
+	}
+	cert.public_key.size = tmp;
+	cert.public_key.data = (unsigned char*)gnutls_malloc(tmp);
+	if (!cert.public_key.data)
+		die("Ran out of memory");
+
+	if (cbuffer_read(unsealed, cert.public_key.data,
+		cert.public_key.size) < 0) {
+		*errorcode = CERTERR_INVALID;
+		goto out_public;
+	}
+
+	if (cbuffer_used(unsealed)) {
+		*errorcode = CERTERR_INVALID;
+		goto out_public;
+	}
+
+	goto out_close;
+
+out_public:
+	gnutls_free(cert.private_key.data);
+out_private:
+	gnutls_free(cert.private_key.data);
+out_close:
+	close(fd);
+out_unsealed:
+	cbuffer_destroy(unsealed);
+	cbuffer_destroy(sealed);
+	return cert;
+}
+
+const char *cert_parse_strerr(int errcode)
+{
+	switch(errcode) {
+	case CERTERR_OK:
+		return "Success";
+	case CERTERR_NOCERT:
+		return "No such keypair";
+	case CERTERR_INVALID:
+		return "Keypair file corrupt";
+	case CERTERR_CANTREAD:
+		return "Can't read keypair file";
+	case CERTERR_TOOBIG:
+		return "Keypair too big";
+	}
+	return "<Unknown error>";
+}
diff --git a/git-over-tls/certificate.h b/git-over-tls/certificate.h
new file mode 100644
index 0000000..5ee355a
--- /dev/null
+++ b/git-over-tls/certificate.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _certificate__h__included__
+#define _certificate__h__included__
+
+#include <gnutls/gnutls.h>
+
+#define CERTERR_OK		0
+#define CERTERR_NOCERT		-2
+#define CERTERR_INVALID		-3
+#define CERTERR_CANTREAD	-4
+#define CERTERR_TOOBIG		-5
+
+struct certificate
+{
+	gnutls_datum_t public_key;
+	gnutls_datum_t private_key;
+};
+
+struct certificate parse_certificate(const char *name, int *errorcode);
+const char *cert_parse_strerr(int errcode);
+
+#endif
diff --git a/git-over-tls/connect.c b/git-over-tls/connect.c
new file mode 100644
index 0000000..f16c7b6
--- /dev/null
+++ b/git-over-tls/connect.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "connect.h"
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#ifndef WIN32
+#include <sys/un.h>
+#endif
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+#ifndef UNIX_PATH_MAX
+#define UNIX_PATH_MAX 108
+#endif
+
+#define BUFFERLEN 256
+
+extern int verbose;
+
+static int connect_unix(const char *path)
+{
+#ifndef WIN32
+	struct sockaddr_un saddru;
+	int fd, ret, plen;
+
+	if (strlen(path) > UNIX_PATH_MAX - 1)
+		die("Unix socket path too long");
+
+	saddru.sun_family = AF_UNIX;
+	strcpy(saddru.sun_path, path);
+	if (*saddru.sun_path == '@')
+		*saddru.sun_path = '\0';
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		die_errno("Can't create socket");
+	if (*path == '@')
+		plen = (int)((char*)saddru.sun_path - (char*)&saddru) +
+			strlen(path);
+	else
+		plen = (int)sizeof(saddru);
+	if (verbose) {
+		fprintf(stderr, "Connecting to unix socket '%s'...",
+			path);
+		fflush(stderr);
+	}
+	ret = connect(fd, (struct sockaddr*)&saddru, plen);
+	if (ret < 0) {
+		if (verbose)
+			fprintf(stderr, "%s\n", strerror(errno));
+		die_errno("Can't connect to '%s'", path);
+	}
+	if (verbose)
+		fprintf(stderr, "Success.\n");
+	return fd;
+#else
+	die("Unix domain sockets not supported by this build");
+#endif
+}
+
+static int connect_address(const char *host, const char *port,
+	int protocol, struct sockaddr *addr, int size)
+{
+	char address[1024];
+	char nport[256];
+	int fd, ret;
+
+	fd = socket(addr->sa_family, SOCK_STREAM, protocol);
+	if (fd < 0) {
+		error("Can't create socket: %s", strerror(errno));
+		return -1;
+	}
+
+#ifndef NO_IPV6
+	int r = getnameinfo(addr, size, address, 1024, nport, 256,
+		NI_NUMERICSERV | NI_NUMERICHOST);
+	if (r)
+		strcpy(address, "<parse error>");
+#else
+	strcpy(address, inet_ntoa(((struct sockaddr_in*)addr)->sin_addr));
+	sprintf(nport, "%u", (unsigned)ntohs(((struct sockaddr_in*)addr)->
+		sin_port));
+#endif
+	if (verbose) {
+		fprintf(stderr, "Connecting to address '%s', port %s...",
+			address, nport);
+		fflush(stderr);
+	}
+	ret = connect(fd, addr, size);
+	if (ret < 0) {
+		fprintf(stderr, "%s\n", strerror(errno));
+		return -1;
+	}
+	if (verbose)
+		fprintf(stderr, "Success\n");
+	return fd;
+}
+
+int connect_gethostbyname(const char *_host,
+	const char *port, const char *_protocol, const char *_family)
+{
+	int protocol = 0;
+	int family = 0;
+	struct protoent* proto;
+
+	if (!_family)
+		family = 0;
+	else if (!strcmp(_family, "ipv4"))
+		family = AF_INET;
+#ifndef NO_IPV6
+	else if (!strcmp(_family, "ipv6"))
+		family = AF_INET6;
+#endif
+	else
+		die("Unknown address type '%s'", _family);
+
+	if (verbose) {
+		fprintf(stderr, "Resolving protocol '%s'...", _protocol);
+		fflush(stderr);
+	}
+
+	proto = getprotobyname(_protocol);
+	if (!proto) {
+		if (verbose)
+			fprintf(stderr, "Failed\n");
+		die("Unknown protocol '%s'", _protocol);
+	}
+	protocol = proto->p_proto;
+
+	if (verbose)
+		fprintf(stderr, "Protocol #%i\n", protocol);
+
+#ifndef NO_IPV6
+	struct addrinfo hints;
+	struct addrinfo *returned;
+	int fd, ret;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_family = family;
+	hints.ai_protocol = protocol;
+
+	if (verbose) {
+		fprintf(stderr, "Resolving host '%s', port '%s'...",
+			_host, port);
+		fflush(stderr);
+	}
+
+	ret = getaddrinfo(_host, port, &hints, &returned);
+	if (ret) {
+		if (verbose)
+			fprintf(stderr, "%s\n", gai_strerror(ret));
+		die("Can't resolve address: %s", gai_strerror(ret));
+	}
+
+	if (verbose) {
+		fprintf(stderr, "Success\n");
+	}
+
+	while (returned) {
+		fd = connect_address(_host, port, returned->ai_protocol,
+			returned->ai_addr, returned->ai_addrlen);
+
+		if (fd >= 0)
+			goto out;
+		returned = returned->ai_next;
+	}
+
+	die("Can't connect to host %s", _host);
+
+out:
+	freeaddrinfo(returned);
+	return fd;
+#else
+	struct hostent *host;
+	int fd;
+	static struct sockaddr_in saddr4;
+	int _port;
+	unsigned long _port2;
+	struct servent* serv;
+	char* end;
+
+	if (verbose) {
+		fprintf(stderr, "Resolving service '%s/%s'...", port,
+			_protocol);
+		fflush(stderr);
+	}
+
+	_port2 = strtoul(port, &end, 10);
+	serv = getservbyname(port, _protocol);
+	if (!serv && (_port2 < 1 || _port2 > 65535 || *end)) {
+		if (verbose)
+			fprintf(stderr, "Not found\n");
+		die("No such port or service '%s/%s'", port,
+			_protocol);
+	} else if (serv)
+		_port = serv->s_port;
+	else
+		_port = (int)_port2;
+
+	if (verbose)
+		fprintf(stderr, "Port %u\n", (unsigned)_port);
+
+	if (verbose) {
+		fprintf(stderr, "Resolving host '%s'...", _host);
+		fflush(stderr);
+	}
+
+	host = gethostbyname(_host);
+	if (!host || !host->h_addr) {
+		if (verbose)
+			fprintf(stderr, "Failed\n");
+		die("Can't find host");
+	}
+
+	if (verbose)
+		fprintf(stderr, "Success\n");
+
+	if (host->h_addrtype != AF_INET)
+		die("Can't handle address type in result");
+
+next_address:
+	memset(&saddr4, 0, sizeof(saddr4));
+	saddr4.sin_family = AF_INET;
+	memcpy(&saddr4.sin_addr, host->h_addr_list[0], 4);
+	saddr4.sin_port = htons(_port);
+	fd = connect_address(_host, port, 0,
+		(struct sockaddr*)&saddr4,
+		sizeof(struct sockaddr_in));
+
+	if (fd >= 0)
+		goto out;
+
+	host->h_addr_list++;
+	if (host->h_addr_list[0])
+		goto next_address;
+
+	die("Can't connect to host %s", _host);
+out:
+	return fd;
+#endif
+}
+
+int connect_host(const char *_host, const char *port, const char *tproto,
+	const char *addrspace)
+{
+	char *hostcopy;
+
+	if (_host[0] == '/' || (_host[0] == '@' && _host[1] == '/') ||
+		(addrspace && !strcmp(addrspace, "unix")))
+		return connect_unix(_host);
+
+	hostcopy = xmalloc(strlen(_host) + 1);
+	strcpy(hostcopy, _host);
+
+	return connect_gethostbyname(hostcopy, port, tproto, addrspace);
+}
diff --git a/git-over-tls/connect.h b/git-over-tls/connect.h
new file mode 100644
index 0000000..bc861be
--- /dev/null
+++ b/git-over-tls/connect.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _connect__h__included__
+#define _connect__h__included__
+
+#include <stdlib.h>
+
+//Returns connected fd or dies.
+int connect_host(const char *host, const char *port,
+	const char *tproto, const char *addrspace);
+
+#endif
diff --git a/git-over-tls/genkeypair.c b/git-over-tls/genkeypair.c
new file mode 100644
index 0000000..4f2142c
--- /dev/null
+++ b/git-over-tls/genkeypair.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+void write_cert(int server_mode);
+
+static void do_help()
+{
+	printf("gits-generate-keypair: User keypair generator.\n");
+	printf("Command line options:\n");
+	printf("--help\n");
+	printf("\tThis help\n");
+	printf("\n");
+	printf("Note: Keep generated keypair files private!\n");
+	printf("Use gits-get-key-name to get public short\n");
+	printf("representation of keypair for authorization.\n");
+	printf("\n");
+	printf("WARNING: Don't let keypairs to be tampered with!\n");
+	printf("WARNING: Tampered keypairs may do very nasty things\n");
+	printf("WARNING: if used.\n");
+	exit(0);
+}
+
+
+int main(int argc, char **argv)
+{
+	if (argc > 1 && !strcmp(argv[1], "--help"))
+		do_help();
+	write_cert(0);
+	return 0;
+}
diff --git a/git-over-tls/gensrpverifier.c b/git-over-tls/gensrpverifier.c
new file mode 100644
index 0000000..3d1decb
--- /dev/null
+++ b/git-over-tls/gensrpverifier.c
@@ -0,0 +1,377 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "prompt.h"
+#include <stdio.h>
+#include <string.h>
+#include <gnutls/gnutls.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include "home.h"
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+static void do_help()
+{
+	printf("gits-generate-srp-verifier: Generate SRP verifiers for\n");
+	printf("password authentication\n");
+	printf("Command line:\n");
+	printf("--help\n");
+	printf("\tThis help\n");
+	printf("\n");
+	printf("Note: Server needs SRP verifier in order to do password\n");
+	printf("authentication. Usernames are assigned by repostiory\n");
+	printf("hosting admin, just using arbitrary names doesn't work.\n");
+	exit(0);
+}
+
+
+struct field
+{
+	const char *f_name;
+	const char *f_generator;
+	const char *f_prime;
+};
+
+struct field fields[] = {
+	{
+	"standard 1024 bit field", "2",
+	"Ewl2hcjiutMd3Fu2lgFnUXWSc67TVyy2vwYCKoS9MLsrdJVT9RgWTCuEqWJrfB6uE"
+	"3LsE9GkOlaZabS7M29sj5TnzUqOLJMjiwEzArfiLr9WbMRANlF68N5AVLcPWvNx6Z"
+	"jl3m5Scp0BzJBz9TkgfhzKJZ.WtP3Mv/67I/0wmRZ"
+	},
+	{
+	"standard 1536 bit field", "2",
+	"dUyyhxav9tgnyIg65wHxkzkb7VIPh4o0lkwfOKiPp4rVJrzLRYVBtb76gKlaO7ef5"
+	"LYGEw3G.4E0jbMxcYBetDy2YdpiP/3GWJInoBbvYHIRO9uBuxgsFKTKWu7RnR7yTa"
+	"u/IrFTdQ4LY/q.AvoCzMxV0PKvD9Odso/LFIItn8PbTov3VMn/ZEH2SqhtpBUkWtm"
+	"cIkEflhX/YY/fkBKfBbe27/zUaKUUZEUYZ2H2nlCL60.JIPeZJSzsu/xHDVcx"
+	},
+	{
+	"standard 2048 bit field", "2",
+	"2iQzj1CagQc/5ctbuJYLWlhtAsPHc7xWVyCPAKFRLWKADpASkqe9djWPFWTNTdeJt"
+	"L8nAhImCn3Sr/IAdQ1FrGw0WvQUstPx3FO9KNcXOwisOQ1VlL.gheAHYfbYyBaxXL"
+	".NcJx9TUwgWDT0hRzFzqSrdGGTN3FgSTA1v4QnHtEygNj3eZ.u0MThqWUaDiP87nq"
+	"ha7XnT66bkTCkQ8.7T8L4KZjIImrNrUftedTTBi.WCi.zlrBxDuOM0da0JbUkQlXq"
+	"vp0yvJAPpC11nxmmZOAbQOywZGmu9nhZNuwTlxjfIro0FOdthaDTuZRL9VL7MRPUD"
+	"o/DQEyW.d4H.UIlzp"
+	},
+	{NULL, NULL, NULL}
+};
+
+
+unsigned char xfact[16] = {
+0x9D, 0x0F, 0x49, 0xD4,
+0x73, 0x88, 0xC7, 0xFF,
+0xFD, 0x24, 0x6A, 0x0F,
+0x94, 0x78, 0x0C, 0x14
+};
+
+unsigned char rnd[16] = {
+0x00, 0x00, 0x00, 0x00,
+0x00, 0x00, 0x00, 0x00,
+0x00, 0x00, 0x00, 0x00,
+0x00, 0x00, 0x00, 0x00
+};
+
+static void add(unsigned char *res, unsigned char *a, unsigned char *b)
+{
+	unsigned char carry = 0;
+	unsigned i;
+
+	for (i = 0; i < 16; i++) {
+		unsigned char newcarry = 0;
+
+		if ((unsigned char)(a[i] + b[i]) < a[i])
+			newcarry++;
+		res[i] = a[i] + b[i];
+		if (res[i] + carry < res[i])
+			newcarry++;
+		res[i] += carry;
+		carry = newcarry;
+	}
+	while (carry) {
+		carry = 159;
+
+		for (i = 0; i < 16; i++) {
+			int newcarry = 0;
+
+			if ((unsigned char)(res[i] + carry) < res[i])
+				newcarry++;
+			res[i] += carry;
+			carry = newcarry;
+		}
+	}
+	for (i = 1; i < 16; i++)
+		if (res[i] < 255)
+			goto skip;
+
+	if (res[0] > 0x60) {
+		for (i = 1; i < 16; i++)
+			res[i] = 0;
+		res[0] -= 0x61;
+	}
+skip:
+	;
+}
+
+void update_xfact()
+{
+	unsigned char xfact2[16];
+	unsigned char xfact4[16];
+	unsigned char xfact5[16];
+	add(xfact2, xfact, xfact);
+	add(xfact4, xfact2, xfact2);
+	add(xfact5, xfact4, xfact);
+	memcpy(xfact, xfact5, 16);
+}
+
+void update_rnd(unsigned char ch)
+{
+	unsigned char rndt[16];
+	unsigned i;
+	for (i = 0; i < 8; i++) {
+		if ((ch >> i) % 2) {
+			add(rndt, rnd, xfact);
+			memcpy(rnd, rndt, 16);
+		}
+		update_xfact();
+	}
+}
+
+void update_rnd_str(const char *ch)
+{
+	while (ch && *ch)
+		update_rnd((unsigned char)*(ch++));
+}
+
+
+void decode_element(gnutls_datum_t *decode, const char *encoded)
+{
+	int s;
+	gnutls_datum_t _base64;
+	size_t base64len, reslen, reslen2;
+
+	base64len = strlen(encoded);
+	reslen2 = reslen = (3 * base64len + 1) / 4;
+
+	_base64.data = (unsigned char*)encoded;
+	_base64.size = base64len;
+
+	decode->size = reslen;
+	decode->data = xmalloc(reslen);
+	s = gnutls_srp_base64_decode(&_base64, (char*)decode->data, &reslen2);
+	if (s < 0)
+		die("Unable to decode base64 data");
+	else if (reslen != reslen2)
+		die("Base64 dlength calculation incorrect. Calculated %lu, "
+			"got %lu", (unsigned long)reslen, (unsigned long)reslen2);
+}
+
+unsigned char *encode_element(gnutls_datum_t *data)
+{
+	int s;
+	size_t reslen2;
+	unsigned char *res;
+
+	reslen2 = (4 * data->size + 2) / 3;
+
+	res = xmalloc(reslen2 + 1);
+	s = gnutls_srp_base64_encode(data, (char*)res, &reslen2);
+	if (s < 0)
+		die("Unable to encode base64 data");
+	res[reslen2] = '\0';
+	return res;
+}
+
+char *generate_srp_line(const char *username,
+	const char *password, const char *junk, struct field *field)
+{
+	gnutls_datum_t salt;
+	gnutls_datum_t g;
+	gnutls_datum_t n;
+	gnutls_datum_t res;
+	int s;
+	char *retline = NULL;
+	unsigned char *encoded_salt;
+	unsigned char *encoded_verifier;
+	update_rnd_str(username);
+	update_rnd_str(":::::");
+	update_rnd_str(junk);
+
+	salt.data = rnd;
+	salt.size = 16;
+	decode_element(&g, field->f_generator);
+	decode_element(&n, field->f_prime);
+
+	s = gnutls_srp_verifier(username, password, &salt, &g, &n, &res);
+	if (s < 0)
+		die("Unable to generate SRP verifier: %s",
+			gnutls_strerror(s));
+
+	encoded_verifier = encode_element(&res);
+	encoded_salt = encode_element(&salt);
+
+	retline = xmalloc(5 + strlen(username) +
+		strlen((char*)encoded_salt) +
+		strlen((char*)encoded_verifier) +
+		strlen(field->f_generator) +
+		strlen(field->f_prime));
+	retline[0] = '\0';
+	strcat(retline, username);
+	strcat(retline, ":");
+	strcat(retline, (char*)encoded_salt);
+	strcat(retline, ":");
+	strcat(retline, (char*)encoded_verifier);
+	strcat(retline, ":");
+	strcat(retline, field->f_generator);
+	strcat(retline, ":");
+	strcat(retline, field->f_prime);
+
+	free(encoded_verifier);
+	free(encoded_salt);
+	free(res.data);
+	free(g.data);
+	free(n.data);
+
+	return retline;
+}
+
+#define LINELEN 69
+
+static void flush_to_file(FILE *out, const char *srpline)
+{
+	char linebuffer[LINELEN + 2];
+
+	linebuffer[LINELEN] = '\\';
+	linebuffer[LINELEN + 1] = '\0';
+
+	while (*srpline) {
+		size_t r;
+		strncpy(linebuffer, srpline, LINELEN);
+		r = strlen(srpline);
+		if (r == LINELEN)
+			linebuffer[LINELEN] = '\0';
+		if (r <= LINELEN)
+			srpline += r;
+		else
+			srpline += LINELEN;
+		fprintf(out, "%s\n", linebuffer);
+	}
+}
+
+int fill_rnd()
+{
+	int fd;
+	int fill = 0;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	while (fill < 16) {
+		ssize_t r;
+		r = read(fd, rnd + fill, 16 - fill);
+		if (r < 0 && errno != EINTR && errno != EAGAIN) {
+			close(fd);
+			return 0;
+		} else if (r == 0) {
+			close(fd);
+			return 0;
+		} else {
+			fill += r;
+		}
+	}
+	close(fd);
+	return 1;
+}
+
+int main(int argc, char **argv)
+{
+	int idx, midx = 0;
+	char *username = NULL;
+	char *password = NULL;
+	char *password2 = NULL;
+	char *junk = NULL;
+	char *field = NULL;
+	char *file = NULL;
+	char *ans = NULL;
+	char *end = NULL;
+	FILE *filp = stdout;
+
+	if (argc > 1 && !strcmp(argv[1], "--help"))
+		do_help();
+
+username_again:
+	free(username);
+	username = prompt_string("Enter username", 0);
+	if (!*username) {
+		fprintf(stderr, "Error: Bad username\n");
+		goto username_again;
+	}
+
+	if (fill_rnd())
+		goto no_junk_prompt;
+junk_again:
+	free(junk);
+	junk = prompt_string("Enter some garbage from keyboard (min 32 "
+		"chars)", 1);
+	if (strlen(junk) < 32) {
+		fprintf(stderr, "Error: Garbage needs to be at least "
+			"32 characters\n");
+		goto junk_again;
+	}
+no_junk_prompt:
+
+passwords_again:
+	free(password);
+	free(password2);
+	password = prompt_string("Enter password", 1);
+	password2 = prompt_string("Enter password again", 1);
+	if (strcmp(password, password2)) {
+		fprintf(stderr, "Error: Passwords don't match\n");
+		goto passwords_again;
+	}
+
+field_again:
+	free(field);
+	for (midx = 0; fields[midx].f_name; midx++) {
+		printf("%i) %s\n", midx + 1, fields[midx].f_name);
+	}
+	field = prompt_string("Pick field", 0);
+	idx = (int)strtoul(field, &end, 10) - 1;
+	if (idx < 0 || idx >= midx || !*field || *end) {
+		printf("%i %i %i %i\n", idx, midx, *field, *end);
+		fprintf(stderr, "Error: Invalid choice\n");
+		goto field_again;
+	}
+
+file_again:
+	file = prompt_string("Filename to save as (enter for dump to "
+		"terminal)", 0);
+	if (*file) {
+		int fd;
+		fd = open_create_dirs(file, O_CREAT | O_EXCL | O_WRONLY, 0600);
+		if (fd < 0) {
+			fprintf(stderr, "Can't open '%s': %s\n", file,
+				strerror(errno));
+			goto file_again;
+		}
+		filp = xfdopen(fd, "w");
+	}
+
+	ans = generate_srp_line(username, password, junk, fields + idx);
+	flush_to_file(filp, ans);
+	if (filp != stdout)
+		fclose(filp);
+	return 0;
+}
diff --git a/git-over-tls/getkeyid.c b/git-over-tls/getkeyid.c
new file mode 100644
index 0000000..baf394f
--- /dev/null
+++ b/git-over-tls/getkeyid.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "certificate.h"
+#include "home.h"
+#include "ssh.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <string.h>
+#include <gnutls/openpgp.h>
+#include <gcrypt.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static void do_help()
+{
+	printf("gits-get-key-name: Get name for keypair or hostkey.\n");
+	printf("Command line options:\n");
+	printf("--help\n");
+	printf("\tThis help\n");
+	printf("--ssh\n");
+	printf("\tRead SSH keys\n");
+	printf("<keyfile>\n");
+	printf("\tRead key file <keyfile>. Name must contain at least\n");
+	printf("\tone '/'\n");
+	printf("<keyname>\n");
+	printf("\tRead key named <keyname>. Name must not contain\n");
+	printf("\t'/'\n");
+	printf("\n");
+	printf("Note: These key names are used in hostkey database and\n");
+	printf("as user names seen by authorization program.\n");
+	exit(0);
+}
+
+#define MAXKEY 65536
+#define HASHBUFFERSIZE 28
+#define HASHFUNCTION GCRY_MD_SHA224
+
+void dump_blob(const char *name, const unsigned char *x, size_t i);
+
+int do_ssh_key(const char *name)
+{
+	FILE* filp;
+	int s;
+	char filename[PATH_MAX + 1];
+	unsigned char key[MAXKEY];
+	size_t keysize;
+	char *path;
+	unsigned char *x;
+	size_t i;
+	unsigned char hbuffer[HASHBUFFERSIZE];
+
+	if (strchr(name, '/'))
+		s = snprintf(filename, PATH_MAX + 1, "%s", name);
+	else
+		s = snprintf(filename, PATH_MAX + 1, "~/.ssh/%s.pub",
+			name);
+	if (s < 0 || s > PATH_MAX)
+		die("Insanely long keyname");
+
+	path = expand_path(filename);
+
+	/* Read the pubkey file. */
+	filp = fopen(path, "r");
+	if (!filp)
+		die("Can't open '%s'", path);
+	keysize = fread(key, 1, MAXKEY, filp);
+	if (ferror(filp))
+		die("Can't read '%s'", path);
+	if (!feof(filp))
+		die("Keyfile '%s' too large", path);
+	fclose(filp);
+
+	x = extract_key_from_file(key, keysize, &i);
+
+	gcry_md_hash_buffer(HASHFUNCTION, hbuffer, x, i);
+
+	printf("ssh-");
+	for (s = 0; s < HASHBUFFERSIZE; s++)
+		printf("%02x", hbuffer[s]);
+	printf("\n");
+	return 0;
+}
+
+/* Be ready in case some joker decides to use 1024 bit hash as fingerprint. */
+#define KEYBUF 128
+
+int main(int argc, char **argv)
+{
+	struct certificate certificate;
+	gnutls_openpgp_crt_t cert;
+	char filename[PATH_MAX + 1];
+	char *filename2;
+	unsigned char key[KEYBUF];
+	int s;
+	unsigned vout;
+	size_t vout2;
+
+	if (argc < 2 || argc > 3) {
+		fprintf(stderr, "syntax: %s <keyname>\n", argv[0]);
+		fprintf(stderr, "syntax: %s <keyfile>\n", argv[0]);
+		fprintf(stderr, "syntax: %s --ssh <keyname>\n", argv[0]);
+		fprintf(stderr, "syntax: %s --ssh <keyfile>\n", argv[0]);
+		return 1;
+	}
+
+	if (!strcmp(argv[1], "--help"))
+		do_help();
+
+	s = gnutls_global_init();
+	if (s < 0)
+		die("Can't initialize GnuTLS: %s",
+			gnutls_strerror(s));
+
+	if (!strcmp(argv[1], "--ssh"))
+		return do_ssh_key(argv[2]);
+
+	if (strchr(argv[1], '/'))
+		s = snprintf(filename, PATH_MAX + 1, "%s", argv[1]);
+	else
+		s = snprintf(filename, PATH_MAX + 1, "$XDG_CONFIG_HOME/.gits/keys/%s",
+			argv[1]);
+	if (s < 0 || s > PATH_MAX)
+		die("Insanely long keyname");
+
+
+	filename2 = expand_path(filename);
+	certificate = parse_certificate(filename2, &s);
+	if (s) {
+		if (s == CERTERR_NOCERT)
+			die("Can't find key %s", filename);
+		else if (s == CERTERR_CANTREAD)
+			die_errno("Can't read key");
+		else
+			die("Can't parse key: %s",
+				cert_parse_strerr(s));
+	}
+
+	s = gnutls_openpgp_crt_init(&cert);
+	if (s < 0)
+		die("Can't allocate space for key: %s",
+			gnutls_strerror(s));
+
+	s = gnutls_openpgp_crt_import(cert, &certificate.public_key,
+		GNUTLS_OPENPGP_FMT_RAW);
+	if (s < 0)
+		die("Bad key: %s", gnutls_strerror(s));
+
+	s = gnutls_openpgp_crt_verify_self(cert, 0, &vout);
+	if (s < 0)
+		die("Bad key: %s", gnutls_strerror(s));
+	if (vout)
+		die("Bad key: Validation failed");
+
+	vout2 = KEYBUF;
+	s = gnutls_openpgp_crt_get_fingerprint(cert, key, &vout2);
+	if (s < 0)
+		die("Bad key: %s", gnutls_strerror(s));
+
+	gnutls_openpgp_crt_deinit(cert);
+
+	printf("openpgp-");
+	for (s = 0; s < (int)vout2; s++)
+		printf("%02x", key[s]);
+	printf("\n");
+	return 0;
+}
diff --git a/git-over-tls/gits-send-special-command b/git-over-tls/gits-send-special-command
new file mode 100755
index 0000000..ade530d
--- /dev/null
+++ b/git-over-tls/gits-send-special-command
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# Copyright (C) Ilari Liusvaara 2009
+#
+# This code is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+if test "x${1}" == "x--help"
+then
+	echo "gits-send-special-command: Send special command to "
+	echo "server"
+	echo "command line:"
+	echo "--help"
+	echo -e "\x09This help"
+	echo "<service> <URL>"
+	echo -e "\x09Send request for <service> to specified <URL>."
+	exit 0
+fi
+
+git-remote-gits --service=$1 $2
diff --git a/git-over-tls/gits-send-special-command-nourl b/git-over-tls/gits-send-special-command-nourl
new file mode 100755
index 0000000..e9de10a
--- /dev/null
+++ b/git-over-tls/gits-send-special-command-nourl
@@ -0,0 +1,23 @@
+#!/bin/bash
+#
+# Copyright (C) Ilari Liusvaara 2009
+#
+# This code is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+if test "x${1}" == "x--help"
+then
+	echo "gits-send-special-command-nourl: Send special command to "
+	echo "server with no explicit path"
+	echo "command line:"
+	echo "--help"
+	echo -e "\x09This help"
+	echo "<service> <URL>"
+	echo -e "\x09Send request for <service> to specified <URL> the "
+	echo -e "\x09path part of URL is ignored."
+	exit 0
+fi
+
+git-remote-gits --nourl-service=$1 $2
diff --git a/git-over-tls/home.c b/git-over-tls/home.c
new file mode 100644
index 0000000..1d2b954
--- /dev/null
+++ b/git-over-tls/home.c
@@ -0,0 +1,229 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "home.h"
+#include <string.h>
+#include <stdlib.h>
+#include <pwd.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+static const char *get_home()
+{
+	static char *home = NULL;
+	const char *tmpans;
+#ifndef WIN32
+	struct passwd *user;
+#endif
+
+	if (home)
+		return home;
+
+	if (getenv("HOME")) {
+		tmpans = getenv("HOME");
+		goto got_it;
+	}
+
+#ifndef WIN32
+	user = getpwuid(getuid());
+	if (user && user->pw_dir) {
+		tmpans = user->pw_dir;
+		goto got_it;
+	}
+#endif
+
+	die("Can't obtain home directory of current user");
+got_it:
+	home = xstrdup(tmpans);
+	return home;
+}
+
+static char *replace_variable(char *path, const char *value)
+{
+	char *slash;
+	char *oldpath = path;
+
+	slash = strchr(path, '/');
+	if (slash) {
+		size_t len;
+		len = strlen(path) - (slash - path) +
+			strlen(value);
+		path = xmalloc(len + 1);
+		if (value[strlen(value) - 1] == '/')
+			sprintf(path, "%s%s", value, slash + 1);
+		else
+			sprintf(path, "%s%s", value, slash);
+	} else {
+		size_t len;
+		len = strlen(value);
+		path = xstrdup(value);
+		if (path[len - 1] == '/')
+			path[len - 1] = '\0';
+	}
+	free(oldpath);
+	return path;
+}
+
+int check_component(const char *path, size_t len)
+{
+	struct stat s;
+	int r;
+	char *tmp;
+	tmp = xstrndup(path, len);
+
+	r = stat(tmp, &s);
+	if (r < 0 && errno != ENOENT) {
+		error("Creating '%s', unable to stat '%s': %s",
+			path, tmp, strerror(errno));
+		return -1;
+	} else if (r < 0) {
+		/* Attempt to create. */
+		int r;
+		r = mkdir(tmp, 0700);
+		if (r >= 0)
+			goto end;
+		error("Creating '%s', unable to create '%s': %s",
+			path, tmp, strerror(errno));
+		return -1;
+	} else if (S_ISDIR(s.st_mode)) {
+		/* Exists and directory, OK. */
+	} else {
+		error("Creating '%s', '%s' exists but is not a directory",
+			path, tmp);
+		return -1;
+	}
+end:
+	free(tmp);
+	return 0;
+}
+
+static int ensure_directory_real(const char *path)
+{
+	size_t index;
+	size_t last_index = 0;
+
+	/* CWD always exists. */
+	if (!*path)
+		return 0;
+
+	for (index = 0; path[index]; index++) {
+		/* In middle of name? */
+		if (path[index] != '/')
+			continue;
+		/* Root always exists. */
+		if (index == 0)
+			continue;
+		if (check_component(path, index) < 0)
+			return -1;
+		last_index = index;
+	}
+	if (index > last_index + 1)
+		if (check_component(path, index) < 0)
+			return -1;
+	return 0;
+}
+
+char *expand_path(const char *path)
+{
+	char *path2;
+	path2 = xstrdup(path);
+
+	/*
+	 * Handle $XDG_CONFIG_HOME and $XDG_DATA_HOME first, as
+	 * these may use $HOME.
+	 */
+	if (!strcmp(path2, "$XDG_CONFIG_HOME") ||
+		!strncmp(path2, "$XDG_CONFIG_HOME/", 17)) {
+		const char* var;
+
+		var = getenv("XDG_CONFIG_HOME");
+		if (!var || !*var)
+			var = "$HOME/.config/";
+		path2 = replace_variable(path2, var);
+	}
+	if (!strcmp(path2, "$XDG_DATA_HOME") ||
+		!strncmp(path2, "$XDG_DATA_HOME/", 15)) {
+		const char* var;
+
+		var = getenv("XDG_DATA_HOME");
+		if (!var || !*var)
+			var = "$HOME/.local/share";
+		path2 = replace_variable(path2, var);
+	}
+	if (!strcmp(path2, "$HOME") ||
+		!strncmp(path2, "$HOME/", 6)) {
+		const char* var;
+
+		var = get_home();
+		path2 = replace_variable(path2, var);
+	}
+	if (!strcmp(path2, "~") ||
+		!strncmp(path2, "~/", 2)) {
+		const char* var;
+
+		var = get_home();
+		path2 = replace_variable(path2, var);
+	}
+	return path2;
+}
+
+int ensure_directory(const char *path)
+{
+	char *path2;
+	int r;
+
+	path2 = expand_path(path);
+	r = ensure_directory_real(path2);
+	free(path2);
+	return r;
+}
+
+int open_create_dirs(const char *path, int flags, mode_t mode)
+{
+	int r;
+	struct stat s;
+	char *path2;
+	char *path3 = NULL;
+	char *slash;
+
+	path2 = expand_path(path);
+
+	r = stat(path2, &s);
+	if (r < 0 && errno != ENOENT) {
+		error("Can't open/create '%s': stat failed: %s",
+			path2, strerror(errno));
+		return -1;
+	} else if (r < 0 && (flags & O_CREAT) == 0) {
+		errno = ENOENT;
+		return -1;
+	} else if (r >= 0 && !S_ISREG(s.st_mode)) {
+		error("Can't open/create '%s': It isn't regular file", path2);
+		errno = EEXIST;
+		return -1;
+	}
+
+	slash = strrchr(path2, '/');
+	if(slash) {
+		path3 = xstrndup(path2, slash - path2);
+		if (ensure_directory_real(path3) < 0)
+			return -1;
+	}
+
+	r = open(path2, flags, mode);
+
+	free(path2);
+	free(path3);
+
+	return r;
+}
diff --git a/git-over-tls/home.h b/git-over-tls/home.h
new file mode 100644
index 0000000..842cd8c
--- /dev/null
+++ b/git-over-tls/home.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _home__h__included__
+#define _home__h__included__
+
+#include <sys/types.h>
+
+/*
+ * Ensure that directory specified exists. If it does not, attempt
+ * to create it.
+ *
+ *Input:
+ *	path		The directory to ensure.
+ *
+ *Output:
+ *	Return value	0 on success, -1 on failure.
+ *
+ *Notes:
+ *	- Path starting with $HOME is special, it is
+ *	  relative to user home directory.
+ *	- Paths starting with $XDG_CONFIG_HOME and $XDG_DATA_HOME
+ *	  are special. Those are interpretted as relative to XDG
+ *	  base dir spec directories.
+ */
+int ensure_directory(const char *path);
+
+/*
+ * Open the specified regular file. Leading path components are
+ * automatically created if file needs to be created.
+ *
+ *Input:
+ *	path		The file to open.
+ *	flags		Flags to pass to open.
+ *	mode		Mode to pass to open.
+ *
+ *Output:
+ *	Return value	File descriptor. -1 on failure.
+ *
+ *Notes:
+ *	- Path starting with $HOME is special, it is
+ *	  relative to user home directory.
+ *	- Paths starting with $XDG_CONFIG_HOME and $XDG_DATA_HOME
+ *	  are special. Those are interpretted as relative to XDG
+ *	  base dir spec directories.
+ */
+int open_create_dirs(const char *path, int flags, mode_t mode);
+
+/*
+ * Expand the specified path.
+ *
+ *Input:
+ *	path		The path to expand.
+ *
+ *Output:
+ *	Return value	Mallocced copy of expanded path.
+ *
+ *Notes:
+ *	- Path starting with $HOME is special, it is
+ *	  relative to user home directory.
+ *	- Paths starting with $XDG_CONFIG_HOME and $XDG_DATA_HOME
+ *	  are special. Those are interpretted as relative to XDG
+ *	  base dir spec directories.
+ */
+char *expand_path(const char *path);
+
+#endif
diff --git a/git-over-tls/hostkey.c b/git-over-tls/hostkey.c
new file mode 100644
index 0000000..715bd8a
--- /dev/null
+++ b/git-over-tls/hostkey.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "hostkey.h"
+#include "home.h"
+#include <stdio.h>
+#include <limits.h>
+#include <string.h>
+#include <gnutls/openpgp.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+/* Be ready in case some joker decides to use 1024 bit hash as fingerprint. */
+#define KEYBUF 129
+
+void check_hostkey(gnutls_session_t session, const char *hostname)
+{
+	const gnutls_datum_t *certificate = NULL;
+	unsigned int cert_size = 0;
+	gnutls_openpgp_crt_t cert;
+	int s;
+	unsigned int vout;
+	size_t vout2;
+	unsigned char key[KEYBUF] = {0};
+	char keydec[2 * KEYBUF + 1] = {0};
+
+	certificate = gnutls_certificate_get_peers(session, &cert_size);
+	if (!certificate)
+		die("Server didn't send a hostkey");
+
+	s = gnutls_openpgp_crt_init(&cert);
+	if (s < 0)
+		die("Can't allocate space for hostkey: %s",
+			gnutls_strerror(s));
+
+	s = gnutls_openpgp_crt_import(cert, certificate,
+		GNUTLS_OPENPGP_FMT_RAW);
+	if (s < 0)
+		die("Server sent bad hostkey: %s", gnutls_strerror(s));
+
+	/* Defend against subkey attack. */
+	s = gnutls_openpgp_crt_get_subkey_count(cert);
+	if (s != 0)
+		die("Server sent bad hostkey: Subkeys are not allowed");
+
+	s = gnutls_openpgp_crt_verify_self(cert, 0, &vout);
+	if (s < 0)
+		die("Server sent bad hostkey: %s", gnutls_strerror(s));
+	if (vout)
+		die("Server sent bad hostkey: Validation failed");
+
+	vout2 = KEYBUF;
+	s = gnutls_openpgp_crt_get_fingerprint(cert, key, &vout2);
+	if (s < 0)
+		die("Server sent bad hostkey: %s", gnutls_strerror(s));
+
+	gnutls_openpgp_crt_deinit(cert);
+
+	/*
+	 * Be nice to users and strip this in case it gets
+	 * retained from key id calculator.
+	 */
+	if (!strncmp(hostname, "openpgp-", 8))
+		hostname += 8;
+
+
+	for (s = 0; s < vout2; s++)
+		sprintf(keydec + 2 * s, "%02x", (int)key[s]);
+	if (strcmp(hostname, keydec))
+		goto mismatch;
+	return;
+mismatch:
+	die("HOST KEY MISMATCH FOR HOST ('%s' vs '%s')!", hostname, keydec);
+}
diff --git a/git-over-tls/hostkey.h b/git-over-tls/hostkey.h
new file mode 100644
index 0000000..c0e7dfe
--- /dev/null
+++ b/git-over-tls/hostkey.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _hostkey__h__included__
+#define _hostkey__h__included__
+
+#include <gnutls/gnutls.h>
+
+void check_hostkey(gnutls_session_t session, const char *hostname);
+
+#endif
diff --git a/git-over-tls/keypairs.c b/git-over-tls/keypairs.c
new file mode 100644
index 0000000..20f94dc
--- /dev/null
+++ b/git-over-tls/keypairs.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "keypairs.h"
+#include "home.h"
+#include "certificate.h"
+#include <stdio.h>
+#include <limits.h>
+#include <gnutls/openpgp.h>
+#include <errno.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+int select_keypair_int(gnutls_certificate_credentials_t creds,
+	const char *username)
+{
+	char keypath[PATH_MAX + 1];
+	char *keypath2;
+	struct certificate cert;
+	int r;
+
+	r = snprintf(keypath, PATH_MAX + 1, "$XDG_CONFIG_HOME/gits/keys/%s",
+		username);
+	if (r < 0 || r > PATH_MAX) {
+		die("Username too long");
+	}
+
+	keypath2 = expand_path(keypath);
+	cert = parse_certificate(keypath2, &r);
+	if (r) {
+		if (r == CERTERR_NOCERT)
+			return -1;
+		if (r == CERTERR_CANTREAD)
+			die_errno("Can't read keypair");
+		else
+			die("Can't read keypair: %s",
+				cert_parse_strerr(r));
+	}
+
+	r = gnutls_certificate_set_openpgp_keyring_mem(creds,
+		cert.public_key.data, cert.public_key.size,
+		GNUTLS_OPENPGP_FMT_RAW);
+	if (r < 0)
+		die("Can't load public key: %s", gnutls_strerror(r));
+
+	r = gnutls_certificate_set_openpgp_key_mem(creds, &cert.public_key,
+		&cert.private_key, GNUTLS_OPENPGP_FMT_RAW);
+	if (r < 0)
+		die("Can't load keypair: %s", gnutls_strerror(r));
+
+	free(keypath2);
+	return 0;
+}
diff --git a/git-over-tls/keypairs.h b/git-over-tls/keypairs.h
new file mode 100644
index 0000000..11f4ef7
--- /dev/null
+++ b/git-over-tls/keypairs.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _keypairs__h__included__
+#define _keypairs__h__included__
+
+#include <gnutls/openpgp.h>
+
+int select_keypair_int(gnutls_certificate_credentials_t creds,
+	const char *username);
+
+#endif
diff --git a/git-over-tls/main.c b/git-over-tls/main.c
new file mode 100644
index 0000000..9bc76b2
--- /dev/null
+++ b/git-over-tls/main.c
@@ -0,0 +1,684 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "user.h"
+#include "srp_askpass.h"
+#include "keypairs.h"
+#include "hostkey.h"
+#include "connect.h"
+#include "ssh.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <gnutls/gnutls.h>
+#include <signal.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+volatile sig_atomic_t in_handler = 0;
+volatile sig_atomic_t sigusr1_flag = 0;
+struct user *debug_for = NULL;
+int verbose = 0;
+static int socket_fd;
+
+static void sigusr1_handler(int x)
+{
+	x = 0;
+	if (in_handler)
+		sigusr1_flag = 1;
+	else
+		user_debug(debug_for, stderr);
+}
+
+struct parsed_addr
+{
+	char *protocol;		/* Protocol part */
+	char *user;		/* User part, NULL if no user */
+	char *host;		/* Hostname */
+	char *uservid;		/* Unique server ID */
+	char *port;		/* Port as string, NULL if no port */
+	char *path;		/* Path part. */
+	char *vhost_header;	/* vhost header to send */
+	char *transport_proto;	/* Transport protocol. */
+	char *address_space;	/* Address space to use. May be NULL */
+};
+
+void append_uniq_address(char *buffer, struct parsed_addr *_addr,
+	int default_flag)
+{
+	char *ptr;
+	ptr = strchr(_addr->host, '~');
+	if (!ptr)
+		ptr = _addr->host;
+	else
+		ptr++;
+	if (strchr(ptr, ':'))
+		strcat(buffer, "[");
+	strcat(buffer, ptr);
+	if (strchr(_addr->host, ':'))
+		strcat(buffer, "]");
+	if(!default_flag) {
+		strcat(buffer, ":");
+		strcat(buffer, _addr->port);
+	}
+}
+
+struct parsed_addr parse_address(const char *addr)
+{
+	struct parsed_addr _addr;
+	const char *proto_end;
+	const char *path_start;
+	const char *uhp_start;
+	const char *uhp_delim;
+	const char *orig_addr = addr;
+	const char *proto_sep;
+	size_t addrlen;
+	int nondefault_port = 0;
+	size_t vhost_len;
+
+	_addr.transport_proto = xstrdup("tcp");
+	_addr.address_space = NULL;
+
+	addrlen = strlen(addr);
+
+	proto_end = strchr(addr, ':');
+	if (!proto_end)
+		die("URL '%s': No ':' to end protocol.", orig_addr);
+
+	_addr.protocol = xstrndup(addr, proto_end - addr);
+	if (strncmp(proto_end, "://", 3))
+		die("URL '%s': No '://' to end protocol.", orig_addr);
+
+	uhp_start = proto_end + 3;
+
+	/* Figure out the user if any. */
+	uhp_delim = strpbrk(uhp_start, "@[:/");
+
+	if (*uhp_delim == '@') {
+		_addr.user = xstrndup(uhp_start,
+			uhp_delim - uhp_start);
+		uhp_start = uhp_delim + 1;
+	} else {
+		_addr.user = NULL;
+	}
+
+	/* Figure out host. */
+	if (*uhp_start == '[') {
+		uhp_delim = strpbrk(uhp_start, "]");
+		if (uhp_delim) {
+			_addr.host = xstrndup(uhp_start + 1,
+				uhp_delim - uhp_start - 1);
+			if (uhp_delim[1] != ':' && uhp_delim[1] != '/')
+				die("URL '%s': Expected port or path after hostname",
+					orig_addr);
+			uhp_start = uhp_delim + 1;
+		} else
+			die("URL '%s': Hostname has '[' without matching ']'",
+				orig_addr);
+	} else {
+		uhp_delim = strpbrk(uhp_start, "[:/");
+		if (*uhp_delim == '[')
+			die("URL '%s': Unexpected '['", orig_addr);
+		_addr.host = xstrndup(uhp_start, uhp_delim - uhp_start);
+		uhp_start = uhp_delim;
+	}
+
+	_addr.uservid = NULL;
+	proto_sep = strchr(_addr.host, '@');
+	if (proto_sep && proto_sep != _addr.host)
+	{
+		char *old_host;
+		old_host = _addr.host;
+		_addr.uservid = xstrndup(_addr.host, proto_sep - _addr.host);
+		_addr.host = xstrdup(proto_sep + 1);
+		free(old_host);
+	}
+
+
+	proto_sep = strchr(_addr.host, '~');
+	if (proto_sep)
+	{
+		free(_addr.transport_proto);
+		free(_addr.address_space);
+
+		const char *ptr2;
+		char *old_host;
+		old_host = _addr.host;
+		ptr2 = strchr(old_host, '/');
+		if (ptr2 >= proto_sep)
+			ptr2 = NULL;
+
+		if (ptr2) {
+			_addr.transport_proto = xstrndup(_addr.host,
+				ptr2 - old_host);
+			_addr.address_space = xstrndup(ptr2 + 1,
+				proto_sep - ptr2 - 1);
+		} else if (proto_sep == old_host + 4 &&
+			!strncmp(old_host, "unix", 4)) {
+			_addr.transport_proto = xstrdup("<N/A>");
+			_addr.address_space = xstrdup("unix");
+		} else {
+			char suffix = '\0';
+			if(proto_sep > old_host)
+				suffix = proto_sep[-1];
+			if(suffix == '4') {
+				_addr.transport_proto = xstrndup(
+					old_host, proto_sep - old_host - 1);
+				_addr.address_space = xstrdup("ipv4");
+			} else if(suffix == '6') {
+				_addr.transport_proto = xstrndup(
+					old_host, proto_sep - old_host - 1);
+				_addr.address_space = xstrdup("ipv6");
+			} else if(suffix == '_') {
+				_addr.transport_proto = xstrndup(
+					old_host, proto_sep - old_host - 1);
+				_addr.address_space = NULL;
+			} else {
+				_addr.transport_proto = xstrndup(
+					old_host, proto_sep - old_host);
+				_addr.address_space = NULL;
+			}
+		}
+		_addr.host = xstrdup(proto_sep + 1);
+		free(old_host);
+	}
+
+	path_start = strchr(uhp_start, '/');
+	if (!path_start)
+		die("URL '%s': No '/' to start path", orig_addr);
+
+	_addr.path = xstrndup(path_start, addrlen - (path_start - addr));
+
+	if (*uhp_start == ':')
+		_addr.port = xstrndup(uhp_start + 1,
+			path_start - uhp_start - 1);
+	else
+		_addr.port = NULL;
+
+	if (!*_addr.host)
+		die("URL '%s': Empty hostname not allowed", orig_addr);
+
+	if (strcmp(_addr.protocol, "gits") && strcmp(_addr.protocol, "tls") &&
+		strcmp(_addr.protocol, "git")) {
+		die("Unknown protocol %s://", _addr.protocol);
+	}
+
+	if (!strcmp(_addr.protocol, "git") && _addr.user) {
+		die("git:// does not support users");
+	}
+
+	if (!strcmp(_addr.protocol, "git") && _addr.uservid) {
+		die("git:// does not support unique server identitifier");
+	}
+
+	if (_addr.port) {
+		nondefault_port = 1;
+	} else if (!strcmp(_addr.protocol, "gits")) {
+		_addr.port = xstrndup("git", 3);
+	} else if (!strcmp(_addr.protocol, "git")) {
+		_addr.port = xstrndup("git", 3);
+	} else if (!strcmp(_addr.protocol, "tls")) {
+		_addr.port = xstrndup("gits", 4);
+	}
+
+	/* 8 is for host=[]:\0 */
+	vhost_len = 9 + strlen(_addr.host) + strlen(_addr.port);
+	_addr.vhost_header = xmalloc(vhost_len);
+
+	strcpy(_addr.vhost_header, "host=");
+	append_uniq_address(_addr.vhost_header, &_addr, !nondefault_port);
+
+	if (verbose) {
+		fprintf(stderr, "Protocol:           %s\n", _addr.protocol);
+		fprintf(stderr, "User:               %s\n", _addr.user ?
+			_addr.user :  "<not set>");
+		fprintf(stderr, "Host:               %s\n", _addr.host);
+		fprintf(stderr, "Unique server ID:   %s\n", _addr.uservid ?
+			_addr.uservid : "<any>");
+		fprintf(stderr, "Port:               %s\n", _addr.port);
+		fprintf(stderr, "Path:               %s\n", _addr.path);
+		fprintf(stderr, "Vhost header:       %s\n",
+			_addr.vhost_header);
+		fprintf(stderr, "Transport protocol: %s\n",
+			_addr.transport_proto);
+		fprintf(stderr, "Address space:      %s\n",
+			_addr.address_space ? _addr.address_space :
+			"<unspecified>");
+		fprintf(stderr, "\n");
+	}
+
+	return _addr;
+}
+
+#define MODE_ALLOW_EOF 0
+#define MODE_HANDSHAKE 1
+#define MAXFDS 128
+
+static void disconnect_outgoing(struct user *user)
+{
+	if(user_get_red_out(user))
+		user_set_red_io(user, -1, -1, -1);
+	else
+		user_set_red_io(user, -1, 1, -1);
+	user_send_red_in_eof(user);
+}
+
+static void traffic_loop(struct user *user, int mode)
+{
+	fd_set rfds;
+	fd_set wfds;
+	struct pollfd polled[MAXFDS];
+	int fdcount = 0;
+	int failcode = 0;
+	struct timeval deadline;
+	int bound = 0;
+	int r;
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+	user_add_to_sets(user, &bound, &rfds, &wfds, &deadline);
+	if (bound == 0) {
+		failcode = user_get_failure(user);
+		if (failcode)
+			goto failed;
+		return;
+	}
+	for(r = 0; r < bound || r <= socket_fd; r++) {
+		int added = 0;
+		polled[fdcount].fd = r;
+		polled[fdcount].events = 0;
+		polled[fdcount].revents = 0;
+		if(FD_ISSET(r, &rfds)) {
+			polled[fdcount].events |= (POLLIN | POLLHUP);
+			added = 1;
+		}
+		if(FD_ISSET(r, &wfds)) {
+			polled[fdcount].events |= (POLLOUT | POLLHUP);
+			added = 1;
+		}
+		if(r == socket_fd) {
+			polled[fdcount].events |= POLLHUP;
+			added = 1;
+		}
+		if(added)
+			fdcount++;
+	}
+
+	r = poll(polled, fdcount, -1);
+	if (r < 0 && errno != EINTR) {
+		die_errno("poll() failed");
+	} else if (r <= 0) {
+		FD_ZERO(&rfds);
+		FD_ZERO(&wfds);
+	} else {
+		FD_ZERO(&rfds);
+		FD_ZERO(&wfds);
+		for(r = 0; r < fdcount; r++) {
+			if(polled[r].revents & POLLHUP) {
+				/* Write stream hangup. Disconnect. */
+				if(polled[r].fd == 0)
+					FD_SET(0, &rfds);
+				if(polled[r].fd == 1)
+					FD_SET(1, &wfds);
+				if(polled[r].fd > 1)
+					disconnect_outgoing(user);
+			}
+			if(polled[r].revents & POLLIN)
+				FD_SET(polled[r].fd, &rfds);
+			if(polled[r].revents & POLLOUT)
+				FD_SET(polled[r].fd, &wfds);
+		}
+	}
+	in_handler = 1;
+	user_service(user, &rfds, &wfds);
+	in_handler = 0;
+	if (sigusr1_flag) {
+		sigusr1_flag = 0;
+		user_debug(debug_for, stderr);
+	}
+	failcode = user_get_failure(user);
+	if (failcode)
+		goto failed;
+	if (user_red_out_eofd(user) && !cbuffer_used(
+		user_get_red_out_force(user))) {
+		failcode = 1;
+		goto failed;
+	}
+
+	return;
+failed:
+	if (failcode > 0 && mode == MODE_ALLOW_EOF)
+		return;
+	else if (failcode > 0) {
+		error("Expected more data, got connection closed");
+		fprintf(stderr, "Debug dump:\n");
+		user_debug(user, stderr);
+		die("Expected more data, got connection closed");
+	} else if (failcode < 0) {
+		const char *major;
+		const char *minor;
+
+		major = user_explain_failure(failcode);
+		minor = user_get_error(user);
+
+		if (minor)
+			die("Connection lost: %s (%s)", major, minor);
+		else
+			die("Connection lost: %s", major);
+	}
+}
+
+static int select_keypair(gnutls_certificate_credentials_t creds,
+	const char *username, int must_succeed)
+{
+	int ret;
+	ret = select_keypair_int(creds, username);
+	if (ret < 0 && must_succeed)
+		die("No keypair identity %s found", username);
+	return ret;
+}
+
+static gnutls_session_t session;
+
+static void preconfigure_tls(const char *username)
+{
+	int s;
+	gnutls_certificate_credentials_t creds;
+	int keypair_ok = 0;
+#ifndef DISABLE_SRP
+	const char *srp_password;
+	gnutls_srp_client_credentials_t srp_cred;
+#endif
+	int kx[3];
+
+	s = gnutls_global_init();
+	if (s < 0)
+		die("Can't initialize GnuTLS: %s", gnutls_strerror(s));
+
+	s = gnutls_certificate_allocate_credentials(&creds);
+	if (s < 0)
+		die("Can't allocate cert creds: %s", gnutls_strerror(s));
+
+	s = gnutls_init(&session, GNUTLS_CLIENT);
+	if (s < 0)
+		die("Can't allocate session: %s", gnutls_strerror(s));
+
+#ifndef DISABLE_SRP
+	s = gnutls_priority_set_direct (session, "NORMAL:+SRP-DSS:+SRP-RSA",
+		NULL);
+#else
+	s = gnutls_priority_set_direct (session, "NORMAL", NULL);
+#endif
+	if (s < 0)
+		die("Can't set priority: %s", gnutls_strerror(s));
+
+	if (username) {
+		if (!prefixcmp(username, "ssh-")) {
+			do_ssh_preauth(username + 4);
+			keypair_ok = 1;
+			goto skip_ksel;
+		}
+		if (!prefixcmp(username, "key-")) {
+			select_keypair(creds, username + 4, 1);
+			keypair_ok = 1;
+		} else
+			keypair_ok = (select_keypair(creds, username, 0)
+				>= 0);
+	}
+
+skip_ksel:
+	s = gnutls_credentials_set (session, GNUTLS_CRD_CERTIFICATE, creds);
+	if (s < 0)
+		die("Can't set creds: %s", gnutls_strerror(s));
+
+	if (keypair_ok)
+		goto no_srp;
+#ifndef DISABLE_SRP
+	if (username && !prefixcmp(username, "srp-"))
+		username = username + 4;
+	if (!username || !*username)
+		goto no_srp;
+
+	s = gnutls_srp_allocate_client_credentials(&srp_cred);
+	if (s < 0)
+		die("Can't allocate SRP creds: %s", gnutls_strerror(s));
+
+	s = 0;
+	srp_password = get_srp_password(username);
+	s = gnutls_srp_set_client_credentials(srp_cred, username, srp_password);
+	if (s < 0)
+		die("Can't set SRP creds: %s", gnutls_strerror(s));
+
+	s = gnutls_credentials_set(session, GNUTLS_CRD_SRP, srp_cred);
+	if (s < 0)
+		die("Can't use SRP creds: %s", gnutls_strerror(s));
+
+	/* GnuTLS doesn't seem to like to use SRP. Force it. */
+	kx[0] = GNUTLS_KX_SRP_DSS;
+	kx[1] = GNUTLS_KX_SRP_RSA;
+	kx[2] = 0;
+	s = gnutls_kx_set_priority(session, kx);
+	if (s < 0)
+		die("Can't force SRP: %s", gnutls_strerror(s));
+#endif
+	goto skip_force;
+no_srp:
+	kx[0] = GNUTLS_KX_DHE_DSS;
+	kx[1] = GNUTLS_KX_DHE_RSA;
+	kx[2] = 0;
+	s = gnutls_kx_set_priority(session, kx);
+	if (s < 0)
+		die("Can't force Diffie-Hellman: %s", gnutls_strerror(s));
+skip_force:
+	;
+}
+
+static void configure_tls(struct user *user, const char *hostname)
+{
+	user_configure_tls(user, session);
+
+	/* Wait for TLS connection to establish. */
+	while (!user_get_tls(user))
+		traffic_loop(user, MODE_HANDSHAKE);
+
+	if(hostname)
+		check_hostkey(session, hostname);
+}
+
+#define MAX_REQUEST 8192
+const char *hexes = "0123456789abcdef";
+
+static void do_request(const char *arg, struct parsed_addr *addr,
+	int suppress_ok, int no_repo)
+{
+	int fd;
+	struct user *dispatcher;
+	struct cbuffer *inbuf;
+	struct cbuffer *outbuf;
+	const char *major;
+	const char *minor;
+	char reqbuf[MAX_REQUEST + 4];
+	size_t reqsize;
+	int do_tls = 0;
+
+#ifdef SIGPIPE
+	signal(SIGPIPE, SIG_IGN);
+#endif
+
+	preconfigure_tls(addr->user);
+
+	fd = connect_host(addr->host, addr->port,
+		addr->transport_proto, addr->address_space);
+
+	/* Create dispatcher with no time limit. */
+	debug_for = dispatcher = user_create(fd, 65535);
+	if (!dispatcher)
+		die("Can't create connection context");
+	socket_fd = fd;
+	user_clear_deadline(dispatcher);
+
+	inbuf = user_get_red_in(dispatcher);
+	outbuf = user_get_red_out(dispatcher);
+	if (!strcmp(addr->protocol, "git")) {
+		; /* Not protected. */
+	} else if (!strcmp(addr->protocol, "tls")) {
+		if (verbose)
+			fprintf(stderr, "Configuring TLS...\n");
+		configure_tls(dispatcher, addr->uservid);
+		do_tls = 1;
+	} else {
+		if (verbose)
+			fprintf(stderr, "Requesting TLS...\n");
+		cbuffer_write(inbuf, (unsigned char*)"000cstarttls", 12);
+		while (1) {
+			char tmpbuf[9];
+			int s;
+			traffic_loop(dispatcher, MODE_HANDSHAKE);
+			s = cbuffer_peek(outbuf, (unsigned char*)tmpbuf, 8);
+			tmpbuf[8] = '\0';
+			if (s >= 0 && !strcmp(tmpbuf, "proceed\n"))
+				break;
+			if (s >= 0 && !strcmp(tmpbuf, "notsupp\n"))
+				die("Server does not support gits://");
+			if (user_red_out_eofd(dispatcher))
+				goto wait_eofd;
+			if (user_get_failure(dispatcher))
+				goto wait_failed;
+		}
+		if (verbose)
+			fprintf(stderr, "Server ready for TLS. Configuring TLS...\n");
+		configure_tls(dispatcher, addr->uservid);
+		do_tls = 1;
+	}
+
+	if (do_tls) {
+		if (verbose)
+			fprintf(stderr, "Waiting for TLS link to establish...\n");
+
+		while (!user_get_tls(dispatcher))
+			traffic_loop(dispatcher, MODE_HANDSHAKE);
+
+		if (verbose)
+			fprintf(stderr, "Secure link established.\n");
+	}
+
+	if (addr->user && !prefixcmp(addr->user, "ssh-")) {
+		if (verbose)
+			fprintf(stderr, "Sending SSH auth request...\n");
+		send_ssh_authentication(dispatcher, addr->user + 4);
+		while (cbuffer_used(inbuf))
+			traffic_loop(dispatcher, MODE_HANDSHAKE);
+		if (verbose)
+			fprintf(stderr, "Sent SSH auth request.\n");
+	}
+
+	if (!no_repo)
+		reqsize = strlen(arg) + strlen(addr->path) +  3 +
+			strlen(addr->vhost_header);
+	else
+		reqsize = strlen(arg);
+
+	if (reqsize > MAX_REQUEST)
+		die("Request too big to send");
+
+	memcpy(reqbuf + 4, arg, strlen(arg));
+	if (!no_repo) {
+		reqbuf[strlen(arg) + 4] = ' ';
+		memcpy(reqbuf + strlen(arg) + 5, addr->path, strlen(addr->path) + 1);
+		memcpy(reqbuf + strlen(arg) + 6 + strlen(addr->path),
+			addr->vhost_header, strlen(addr->vhost_header) + 1);
+	}
+
+	reqbuf[0] = hexes[((reqsize + 4) >> 12) & 0xF];
+	reqbuf[1] = hexes[((reqsize + 4) >> 8) & 0xF];
+	reqbuf[2] = hexes[((reqsize + 4) >> 4) & 0xF];
+	reqbuf[3] = hexes[(reqsize + 4) & 0xF];
+
+	if (verbose)
+		fprintf(stderr, "Sending request...\n");
+	cbuffer_write(inbuf, (unsigned char*)reqbuf, reqsize + 4);
+	if (verbose)
+		fprintf(stderr, "Request sent, waiting for reply...\n");
+	while (!cbuffer_used(outbuf) && !suppress_ok)
+		traffic_loop(dispatcher, MODE_HANDSHAKE);
+	if (verbose)
+		fprintf(stderr, "Server replied.\n");
+	/* Ok, remote end has replied. */
+	if(!suppress_ok)
+		printf("\n");
+	fflush(stdout);
+	user_set_red_io(dispatcher, 0, 1, -1);
+
+	while (!user_get_failure(dispatcher))
+		traffic_loop(dispatcher, MODE_ALLOW_EOF);
+	exit(0);
+
+wait_failed:
+	major = user_explain_failure(user_get_failure(dispatcher));
+	minor = user_get_error(dispatcher);
+
+	if (minor)
+		die("Connection lost: %s (%s)", major, minor);
+	else
+		die("Connection lost: %s", major);
+	exit(128);
+wait_eofd:
+	die("Expected response to starttls, server closed connection.");
+	exit(128);
+}
+
+int main(int argc, char **argv)
+{
+	struct parsed_addr paddr;
+	char buffer[8192];
+
+	if (getenv("GITS_VERBOSE"))
+		verbose = 1;
+
+	if (argc < 3) {
+		die("Need two arguments");
+	}
+
+	signal(SIGUSR1, sigusr1_handler);
+
+	paddr = parse_address(argv[2]);
+
+	if (!prefixcmp(argv[1], "--service=")) {
+		do_request(argv[1] + 10, &paddr, 1, 0);
+		return 0;
+	}
+	if (!prefixcmp(argv[1], "--nourl-service=")) {
+		do_request(argv[1] + 16, &paddr, 1, 1);
+		return 0;
+	}
+
+	while (1) {
+		char *cmd;
+
+		cmd = fgets(buffer, 8190, stdin);
+		if (cmd[strlen(cmd) - 1] == '\n')
+			cmd[strlen(cmd) - 1] = '\0';
+
+		if (!strcmp(cmd, "capabilities")) {
+			printf("*connect\n\n");
+			fflush(stdout);
+		} else if (!*cmd) {
+			exit(0);
+		} else if (!prefixcmp(cmd, "connect ")) {
+			do_request(cmd + 8, &paddr, 0, 0);
+			return 0;
+		} else
+			die("Unknown command %s", cmd);
+	}
+	return 0;
+}
diff --git a/git-over-tls/misc.c b/git-over-tls/misc.c
new file mode 100644
index 0000000..3d3e0b3
--- /dev/null
+++ b/git-over-tls/misc.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "misc.h"
+#include <unistd.h>
+#include <errno.h>
+
+void force_close(int fd)
+{
+	while (close(fd) < 0 && errno != EBADF);
+}
diff --git a/git-over-tls/misc.h b/git-over-tls/misc.h
new file mode 100644
index 0000000..b482f2c
--- /dev/null
+++ b/git-over-tls/misc.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _misc__h__included__
+#define _misc__h__included__
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Forcibly close the file descriptor.
+ *
+ *Input:
+ *	fd		The file descriptor.
+ */
+void force_close(int fd);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/git-over-tls/mkcert.c b/git-over-tls/mkcert.c
new file mode 100644
index 0000000..b8eaacb
--- /dev/null
+++ b/git-over-tls/mkcert.c
@@ -0,0 +1,474 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "cbuffer.h"
+#include "home.h"
+#include "prompt.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/stat.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#include "run-command.h"
+#endif
+
+#define CERT_MAX 65536
+#define BUFSIZE 8192
+
+static int seal_cert(struct cbuffer *sealed, struct cbuffer *unsealed,
+	const char *sealer)
+{
+	struct child_process child;
+	char **argv;
+	char *sealer_copy;
+	int splits = 0;
+	int escape = 0;
+	int ridx, widx, tidx;
+	int cleanup = 0;
+	const char *i;
+
+	signal(SIGPIPE, SIG_IGN);
+
+	for (i = sealer; *i; i++) {
+		if (escape)
+			escape = 0;
+		else if (*i == '\\')
+			escape = 1;
+		else if (*i == ' ')
+			splits++;
+	}
+
+	argv = xmalloc((splits + 2) * sizeof(char*));
+	argv[splits + 1] = NULL;
+
+	sealer_copy = xstrdup(sealer);
+	argv[0] = sealer_copy;
+
+	ridx = 0;
+	widx = 0;
+	tidx = 1;
+	escape = 0;
+	while (sealer_copy[ridx]) {
+		if (escape) {
+			escape = 0;
+			sealer_copy[widx++] = sealer_copy[ridx++];
+		} else if (sealer_copy[ridx] == '\\') {
+			ridx++;
+			escape = 1;
+		} else if (sealer_copy[ridx] == ' ') {
+			sealer_copy[widx++] = '\0';
+			argv[tidx++] = sealer_copy + widx;
+			ridx++;
+		} else
+			sealer_copy[widx++] = sealer_copy[ridx++];
+	}
+	sealer_copy[widx] = '\0';
+
+	memset(&child, 0, sizeof(child));
+	child.argv = (const char**)argv;
+	child.in = -1;
+	child.out = -1;
+	child.err = 0;
+	if (start_command(&child))
+		return -1;
+	cleanup = 1;
+
+	while (1) {
+		int bound;
+		fd_set rf;
+		fd_set wf;
+		int r;
+
+		FD_ZERO(&rf);
+		FD_ZERO(&wf);
+		FD_SET(child.out, &rf);
+		if (cbuffer_used(unsealed))
+			FD_SET(child.in, &wf);
+		else
+			close(child.in);
+
+		if (cbuffer_used(sealed))
+			bound = ((child.out > child.in) ? child.out :
+				child.in) + 1;
+		else
+			bound = child.out + 1;
+
+		r = select(bound, &rf, &wf, NULL, NULL);
+		if (r < 0 && r != EINTR) {
+			perror("Select");
+			goto exit_error;
+		}
+		if (r < 0) {
+			FD_ZERO(&rf);
+			FD_ZERO(&wf);
+			perror("select");
+		}
+
+		if (FD_ISSET(child.out, &rf)) {
+			r = cbuffer_read_fd(sealed, child.out);
+			if (r < 0 && errno != EINTR && errno != EAGAIN) {
+				fprintf(stderr, "Read from sealer "
+					"failed: %s", strerror(errno));
+				goto exit_error;
+			}
+			if (r < 0 && errno == EAGAIN)
+				if (!cbuffer_free(sealed)) {
+					fprintf(stderr, "Keypair too big\n");
+					goto exit_error;
+			}
+			if (r < 0)
+				perror("read");
+			if (r == 0)
+				break;
+			}
+
+			if (FD_ISSET(child.in, &wf)) {
+			r = cbuffer_write_fd(unsealed, child.in);
+			if (r < 0 && errno == EPIPE) {
+				fprintf(stderr, "Sealer exited "
+					"unexpectedly\n");
+				goto exit_error;
+			}
+			if (r < 0 && errno != EINTR && errno != EAGAIN) {
+				fprintf(stderr, "Write to sealer "
+					"failed: %s", strerror(errno));
+				goto exit_error;
+			}
+			if (r < 0)
+				perror("write");
+		}
+	}
+
+	if (finish_command(&child)) {
+		cleanup = 0;
+		goto exit_error;
+	}
+
+	close(child.in);
+	close(child.out);
+
+	return 0;
+exit_error:
+	close(child.in);
+	close(child.out);
+	return -1;
+}
+
+static void append_member(struct cbuffer *cbuf, const char *filename)
+{
+	unsigned char backing[CERT_MAX];
+	struct cbuffer *content;
+	int fd;
+	size_t size = 0;
+	unsigned char buf[2];
+
+	content = cbuffer_create(backing, CERT_MAX);
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+	while (1) {
+		ssize_t r = cbuffer_read_fd(content, fd);
+		if (r < 0) {
+			if (errno == EAGAIN) {
+				if (!cbuffer_free(content)) {
+					fprintf(stderr, "Member too big.\n");
+					unlink("key.private.tmp");
+					unlink("key.public.tmp");
+					exit(1);
+				}
+			} else if (errno != EINTR) {
+				perror("read");
+				exit(1);
+			}
+		} else if (r == 0) {
+			break;
+		} else
+			size += r;
+	}
+	close(fd);
+
+	buf[0] = (unsigned char)((size >> 8) & 0xFF);
+	buf[1] = (unsigned char)((size) & 0xFF);
+	if (cbuffer_write(cbuf, buf, 2) < 0) {
+		fprintf(stderr, "Certificate too big (can't write member header).\n");
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		exit(1);
+	}
+	if (cbuffer_move(cbuf, content, size) < 0) {
+		fprintf(stderr, "Certificate too big (can't write member of %lu "
+			"bytes).\n", (unsigned long)size);
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		exit(1);
+	}
+
+	cbuffer_destroy(content);
+}
+
+
+static char *escape(char *s)
+{
+	char *ans;
+	int ridx = 0, widx = 0;
+
+	ans = xmalloc(2 * strlen(s) + 1);
+	while (s[ridx]) {
+		if (s[ridx] == '\\') {
+			ans[widx++] = '\\';
+			ans[widx++] = '\\';
+			ridx++;
+		} else if (s[ridx] == ' ') {
+			ans[widx++] = '\\';
+			ans[widx++] = ' ';
+			ridx++;
+		} else {
+			ans[widx++] = s[ridx++];
+		}
+	}
+	ans[widx] = '\0';
+	free(s);
+	return ans;
+}
+
+static int check_name(char *s)
+{
+	size_t x;
+	x = strspn(s, " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (!x || s[x]) {
+		return -1;
+	}
+	return 0;
+}
+
+static int check_comment(char *s)
+{
+	char *at;
+	at = strchr(s, '(');
+	if (at)
+		return -1;
+	at = strchr(s, '\\');
+	if (at)
+		return -1;
+	at = strchr(s, ')');
+	if (at)
+		return -1;
+	at = s;
+	while (*at >= 32 && *at <= 126)
+		at++;
+	if (*at)
+		return -1;
+	return 0;
+}
+
+static int check_email(char *s)
+{
+	size_t x;
+	char *at;
+	at = strchr(s, '@');
+	if (!at)
+		return -1;
+	x = strspn(s, ".0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (s[x] != '@')
+		return -1;
+	if (!at[1])
+		return -1;
+	x = strspn(at + 1, ".0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (at[x + 1])
+		return -1;
+	return 0;
+}
+
+#define BUFSIZE 8192
+
+void write_cert(int server_mode)
+{
+	unsigned char backing1[CERT_MAX];
+	unsigned char backing2[CERT_MAX];
+	unsigned char keytemp[CERT_MAX];
+	struct cbuffer *unsealed;
+	struct cbuffer *sealed;
+	unsigned char *buf = (unsigned char*)"GITSUCERT";
+	unsigned char *buf2 = (unsigned char*)"GITSSCERT\x00\x03gpg";
+	char *name;
+	char fbuffer[BUFSIZE];
+	int fd;
+	int do_seal = 0;
+	int keylen = 1024;
+	char *realname;
+	char *comment;
+	char *email;
+	FILE *script;
+
+	if (!ensure_directory("$HOME") < 0)
+		die("Hey, you don't have a home directory!");
+
+	unsealed = cbuffer_create(backing1, CERT_MAX);
+	sealed = cbuffer_create(backing2, CERT_MAX);
+
+reask_length:
+	printf("1) 1024 bit key\n");
+	printf("2) 2048 bit key\n");
+	printf("3) 3072 bit key\n");
+	name = prompt_string("Pick key length", 0);
+	if (!strcmp(name, "1"))
+		keylen = 1024;
+	else if (!strcmp(name, "2"))
+		keylen = 2048;
+	else if (!strcmp(name, "3"))
+		keylen = 3072;
+	else {
+		fprintf(stderr, "Bad choice\n");
+		goto reask_length;
+	}
+
+ask_name:
+	realname = prompt_string("Enter name to put into key", 0);
+	if (check_name(realname) < 0) {
+		fprintf(stderr, "Bad name\n");
+		goto ask_name;
+	}
+ask_comment:
+	comment = prompt_string("Enter comment to put into key", 0);
+	if (check_comment(comment) < 0) {
+		fprintf(stderr, "Bad comment\n");
+		goto ask_comment;
+	}
+ask_email:
+	email = prompt_string("Enter E-mail address to put into key", 0);
+	if (check_email(email) < 0) {
+		fprintf(stderr, "Bad E-mail address\n");
+		goto ask_email;
+	}
+
+	script = fopen("key.script.tmp", "w");
+	if (!script)
+		die("Can't create key script");
+	fprintf(script, "Key-Type: DSA\n");
+	fprintf(script, "Key-Length: %i\n", keylen);
+	fprintf(script, "Name-Real: %s\n", realname);
+	if (*comment)
+		fprintf(script, "Name-Comment: %s\n", comment);
+	fprintf(script, "Name-Email: %s\n", email);
+	fprintf(script, "Expire-Date: 0\n");
+	fprintf(script, "%%pubring key.public.tmp\n");
+	fprintf(script, "%%secring key.private.tmp\n");
+	fprintf(script, "%%commit\n");
+	fprintf(script, "%%echo done\n");
+	fclose(script);
+
+	if (system("gpg --batch --gen-key key.script.tmp")) {
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		unlink("key.script.tmp");
+		die("Can't generate key");
+	}
+	unlink("key.script.tmp");
+
+	append_member(unsealed, "key.private.tmp");
+	unlink("key.private.tmp");
+	append_member(unsealed, "key.public.tmp");
+	unlink("key.public.tmp");
+
+reask_seal:
+	if (server_mode)
+		goto no_seal;
+	printf("1) Don't seal key\n");
+	printf("2) Seal using password (gpg)\n");
+	printf("3) Seal using keypair (gpg)\n");
+	name = prompt_string("Pick sealing method", 0);
+	if (!strcmp(name, "1"))
+		do_seal = 0;
+	else if (!strcmp(name, "2"))
+		do_seal = 1;
+	else if (!strcmp(name, "3"))
+		do_seal = 2;
+	else {
+		fprintf(stderr, "Bad choice");
+		goto reask_seal;
+	}
+no_seal:
+	keylen = cbuffer_read_max(unsealed, keytemp, CERT_MAX);
+	cbuffer_write(unsealed, keytemp, keylen);
+
+	if (do_seal == 1) {
+		cbuffer_write(sealed, (unsigned char*)buf2, 14);
+		if (seal_cert(sealed, unsealed, "gpg --symmetric "
+			"--force-mdc") < 0) {
+			cbuffer_clear(sealed);
+			cbuffer_clear(unsealed);
+			cbuffer_write(unsealed, keytemp, keylen);
+			fprintf(stderr, "Sealing failed.\n");
+			goto reask_seal;
+		}
+	} else if (do_seal == 2) {
+		char *hint;
+		cbuffer_write(sealed, (unsigned char*)buf2, 14);
+
+		hint = prompt_string("Seal using whose key", 0);
+		hint = escape(hint);
+		sprintf(fbuffer, "gpg --encrypt --recipient %s "
+			"--force-mdc", hint);
+		free(hint);
+
+		if (seal_cert(sealed, unsealed, fbuffer) < 0) {
+			cbuffer_clear(sealed);
+			cbuffer_clear(unsealed);
+			cbuffer_write(unsealed, keytemp, keylen);
+			fprintf(stderr, "Sealing failed.\n");
+			goto reask_seal;
+		}
+	} else {
+		cbuffer_write(sealed, (unsigned char*)buf, 9);
+		cbuffer_move_nolimit(sealed, unsealed);
+		if (!cbuffer_free(sealed))
+			die("Key too large");
+	}
+
+retry_name:
+	if (server_mode) {
+		name = prompt_string("Enter filename to save key as", 0);
+		strcpy(fbuffer, name);
+	} else {
+		name = prompt_string("Enter name for key", 0);
+		if (strcspn(name, "@:/[") < strlen(name)) {
+			fprintf(stderr, "Bad name\n");
+			goto retry_name;
+		}
+		sprintf(fbuffer, "$XDG_CONFIG_HOME/gits/keys/%s", name);
+	}
+	if (!strcmp(name, "")) {
+		fprintf(stderr, "Bad name\n");
+		goto retry_name;
+	}
+
+	fd = open_create_dirs(fbuffer, O_WRONLY | O_CREAT | O_EXCL, 0600);
+	if (fd < 0) {
+		error("Can't open '%s': %s", fbuffer, strerror(errno));
+		goto retry_name;
+	}
+	while (cbuffer_used(sealed)) {
+		ssize_t r = cbuffer_write_fd(sealed, fd);
+		if (r < 0 && errno != EINTR) {
+			perror("write");
+			exit(1);
+		}
+	}
+	close(fd);
+}
diff --git a/git-over-tls/prompt.c b/git-over-tls/prompt.c
new file mode 100644
index 0000000..380156a
--- /dev/null
+++ b/git-over-tls/prompt.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "prompt.h"
+#include <termios.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+static int tmpfd;
+
+static void sigint(int x);
+
+void echo_off(int fd)
+{
+	struct termios t;
+
+	if (tcgetattr(fd, &t) < 0)
+		die_errno("Can't read terminal settings");
+
+	t.c_lflag &= ~ECHO;
+
+	tmpfd = fd;
+	signal(SIGINT, sigint);
+
+	if (tcsetattr(fd, TCSANOW, &t) < 0)
+		die_errno("Can't write terminal settings");
+}
+
+void echo_on(int fd)
+{
+	struct termios t;
+
+	if (tcgetattr(fd, &t) < 0)
+		die_errno("Can't read terminal settings");
+
+	t.c_lflag |= ECHO;
+
+	if (tcsetattr(fd, TCSANOW, &t) < 0)
+		die_errno("Can't write terminal settings");
+
+	signal(SIGINT, SIG_DFL);
+}
+
+static void sigint(int x)
+{
+	echo_on(tmpfd);
+	exit(1);
+}
+
+#define PROMPTBUF 8192
+
+char *prompt_string(const char *prompt, int without_echo)
+{
+	char ansbuf[8192];
+	char *ans;
+	int fd;
+	FILE* tty;
+
+	fd = open("/dev/tty", O_RDWR);
+	if (fd < 0)
+		die_errno("Can't open /dev/tty for password prompt");
+
+	tty = xfdopen(fd, "r+");
+
+	fprintf(tty, "%s: ", prompt);
+	fflush(tty);
+	if (without_echo)
+		echo_off(fd);
+
+	if (!fgets(ansbuf, 8190, tty)) {
+		if (without_echo)
+			echo_on(fd);
+		die("Can't read answer");
+	}
+
+	if (without_echo) {
+		fprintf(tty, "\n");
+		echo_on(fd);
+	}
+
+	if (*ansbuf && ansbuf[strlen(ansbuf) - 1] == '\n')
+		ansbuf[strlen(ansbuf) - 1] = '\0';
+
+	fclose(tty);
+
+	ans = xstrdup(ansbuf);
+	return ans;
+}
diff --git a/git-over-tls/prompt.h b/git-over-tls/prompt.h
new file mode 100644
index 0000000..34fc13a
--- /dev/null
+++ b/git-over-tls/prompt.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _prompt__h__included__
+#define _prompt__h__included__
+
+/* Turn terminal echo on specified fd off. */
+void echo_off(int fd);
+/* Turn terminal echo on specified fd on. */
+void echo_on(int fd);
+/* Prompt string from user and return mallocced copy of it. */
+char *prompt_string(const char *prompt, int without_echo);
+
+#endif
diff --git a/git-over-tls/srp_askpass.c b/git-over-tls/srp_askpass.c
new file mode 100644
index 0000000..13b9f5e
--- /dev/null
+++ b/git-over-tls/srp_askpass.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "srp_askpass.h"
+#include "prompt.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+#define PROMPTBUF 8192
+#define CMDBUFSIZE 16384
+
+/* Use GITS_ASKPASS to ask for password. */
+static char *get_password_via_external(const char *prompt,
+	const char *prog)
+{
+	static char buffer[PROMPTBUF + 1];
+	static char cmdbuffer[CMDBUFSIZE + 1];
+	char *ans;
+	int escape = 0;
+	int idx;
+	int widx = 0;
+	FILE *out;
+
+	if (strchr(prompt, '\"'))
+		die("Can't prompt for names containing '\"'");
+
+	for (idx = 0; prog[idx]; idx++) {
+		if (!escape && prog[idx] == '%')
+			escape = 1;
+		else if (escape && prog[idx] == 'p') {
+			if (widx + strlen(prompt) + 2 >= CMDBUFSIZE)
+				die("Command line too long");
+			cmdbuffer[widx++] = '\"';
+			strcpy(cmdbuffer + widx, prompt);
+			widx += strlen(prompt);
+			cmdbuffer[widx++] = '\"';
+		} else {
+			if (widx + 1 >= CMDBUFSIZE)
+				die("Command line too long");
+			cmdbuffer[widx++] = prog[idx];
+			escape = 0;
+		}
+	}
+	cmdbuffer[widx++] = '\0';
+
+	out = popen(cmdbuffer, "r");
+	if (!out)
+		die_errno("Can't invoke $GITS_ASKPASS");
+
+	if (!fgets(buffer, PROMPTBUF - 2, out)) {
+		if (ferror(out))
+			die("Can't read password");
+	}
+
+	if (strlen(buffer) > 0 && buffer[strlen(buffer) - 1] == '\n')
+		buffer[strlen(buffer) - 1] = '\0';
+
+	if (pclose(out))
+		die("Authentication canceled");
+
+	ans = xstrdup(buffer);
+	return ans;
+}
+
+char *get_password(const char *prompt)
+{
+	if (getenv("GITS_ASKPASS"))
+		return get_password_via_external(prompt,
+			getenv("GITS_ASKPASS"));
+
+	return prompt_string(prompt, 1);
+}
+
+char *get_srp_password(const char *username)
+{
+	static char buffer[PROMPTBUF + 1];
+	int len;
+
+	len = snprintf(buffer, PROMPTBUF + 1, "Enter SRP password for %s",
+		username);
+	if (len < 0 || len > PROMPTBUF)
+		die("SRP Username is insanely long");
+
+	return get_password(buffer);
+}
+
+char *get_ssh_password(const char *keyname)
+{
+	static char buffer[PROMPTBUF + 1];
+	int len;
+
+	len = snprintf(buffer, PROMPTBUF + 1, "Enter passphrase to unlock %s",
+		keyname);
+	if (len < 0 || len > PROMPTBUF)
+		die("Key name is insanely long");
+
+	return get_password(buffer);
+}
diff --git a/git-over-tls/srp_askpass.h b/git-over-tls/srp_askpass.h
new file mode 100644
index 0000000..cb79d34
--- /dev/null
+++ b/git-over-tls/srp_askpass.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _srp_askpass__h__included__
+#define _srp_askpass__h__included__
+
+/* Get password. Return is malloced */
+char *get_password(const char *prompt);
+char *get_srp_password(const char *username);
+char *get_ssh_password(const char *keyname);
+
+#endif
-- 
1.7.1.rc2.10.g714149
