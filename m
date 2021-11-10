Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D1C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9636761215
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhKJXyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhKJXyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:54:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CCC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v127so3589023wme.5
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TbPNVzbvl9OOFKxBFv7y84z9hv7hPwE0izsPpwf0sLc=;
        b=jHhx+TkCdPu6vwvp35cCn3Nvhj6pPWm3BSei1pZf0IVOsuEbW9N2y0KgxRb4C+BLbP
         O9SFNeCqY8n3Z/x2Zw896c5pRxh6pD/88OvXzPrAe8pHH459eLIYg8KwLh8M7QMpHvEu
         VMv6hyLhog4oqh3edIwrS+Sqe1W9eYbJNGI/+EPCvI6xtIbfYHhtBL4RQaBb+nc4Cezq
         w5RBNUaulUnKmMdsCjRwY+6GmQXBVYtlBUPFH1M2waOFIaRthTxz0L4DPbt+2t6nPaHQ
         i0TXkNSX4DCIfK4ifZuPIVRH2cbgHJPgBFWaK7y7l6wwj4qDCEJkvi83z/Gaqt3dNC/r
         RwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TbPNVzbvl9OOFKxBFv7y84z9hv7hPwE0izsPpwf0sLc=;
        b=AirXA1WrgbJgeB7jjjglbE2+hEyPf+GERp5DXicF706V6Vp4c9caFOlxCczB+mLYTT
         7gPgwprCOODFmE5a0ZJCiDqk5KgyIdeIgUoNbjz1PnH0OlQWXXWflbYgipCqBbz/bg6m
         +7Jn6H9rPxLOnvXZ7hXnZ49Ms/6RCtyph+Yi4+vlMBERYM/c1Go1ive4zCRnTVlRowxk
         UoPuzNeTUCLuTUHZ3xy2ir3E7WUNKeBF4IYDAv0nbojx5zK8UVUXe/R9+TOpfdIRapaz
         bcsbZxrt/lN+tviXPME7L2g0lsVS0rE7FDNFb3DbJx4vePszd2oiqgHrEh44cyJ3Vl7g
         SpbQ==
X-Gm-Message-State: AOAM531QbxTz3/ZVDT5pFQpkRPaBEd3wjihZSe4xWce7GohCganU/7BS
        EbdMyFhdr3YT26oweQQwQ2ilf3nnCTg=
X-Google-Smtp-Source: ABdhPJwivOAiWyyKwEw0khWM7WsaL1ZeYvp9sDCqz/AbQeXdLvN5FzLLUFkQpFMeFuXWmZoetxNX9A==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr20057955wmj.77.1636588291376;
        Wed, 10 Nov 2021 15:51:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm1327686wrr.47.2021.11.10.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:51:31 -0800 (PST)
Message-Id: <bbfdc346ededf1479b5622739be658ee0be2f506.1636588289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
References: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
        <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 23:51:28 +0000
Subject: [PATCH v7 1/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

In some setups, packfile uris act as bearer token. It is not
recommended to expose them plainly in logs, although in special
circunstances (e.g. debug) it makes sense to write them.

Redact the packfile URL paths by default, unless the GIT_TRACE_REDACT
variable is set to false. This mimics the redacting of the Authorization
header in HTTP.

Signed-off-by: Ivan Frade <ifrade@google.com>
---
 Documentation/git.txt  |  5 +++--
 fetch-pack.c           |  5 +++++
 pkt-line.c             | 40 ++++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 281c5f8caef..13f83a2a3a1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -832,8 +832,9 @@ for full details.
 
 `GIT_TRACE_REDACT`::
 	By default, when tracing is activated, Git redacts the values of
-	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
-	header. Set this variable to `0` to prevent this redaction.
+	cookies, the "Authorization:" header, the "Proxy-Authorization:"
+	header and packfile URIs. Set this variable to `0` to prevent this
+	redaction.
 
 `GIT_LITERAL_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..8b8c75f33aa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1653,8 +1653,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_wanted_refs(&reader, sought, nr_sought);
 
 			/* get the pack(s) */
+			if (git_env_bool("GIT_TRACE_REDACT", 1))
+				reader.options |= PACKET_READ_REDACT_URI_PATH;
 			if (process_section_header(&reader, "packfile-uris", 1))
 				receive_packfile_uris(&reader, &packfile_uris);
+			/* We don't expect more URIs. Reset to avoid expensive URI check. */
+			reader.options &= ~PACKET_READ_REDACT_URI_PATH;
+
 			process_section_header(&reader, "packfile", 0);
 
 			/*
diff --git a/pkt-line.c b/pkt-line.c
index 2dc8ac274bd..8e43c2def4c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -370,6 +370,32 @@ int packet_length(const char lenbuf_hex[4])
 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
 }
 
+static char *find_packfile_uri_path(const char *buffer)
+{
+	const char *URI_MARK = "://";
+	char *path;
+	int len;
+
+	/* First char is sideband mark */
+	buffer += 1;
+
+	len = strspn(buffer, "0123456789abcdefABCDEF");
+	/* size of SHA1 and SHA256 hash */
+	if (!(len == 40 || len == 64) || buffer[len] != ' ')
+		return NULL; /* required "<hash>SP" not seen */
+
+	path = strstr(buffer + len + 1, URI_MARK);
+	if (!path)
+		return NULL;
+
+	path = strchr(path + strlen(URI_MARK), '/');
+	if (!path || !*(path + 1))
+		return NULL;
+
+	/* position after '/' */
+	return ++path;
+}
+
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
 						unsigned size, int *pktlen,
@@ -377,6 +403,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 {
 	int len;
 	char linelen[4];
+	char *uri_path_start;
 
 	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
 		*pktlen = -1;
@@ -427,7 +454,18 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		len--;
 
 	buffer[len] = 0;
-	packet_trace(buffer, len, 0);
+	if (options & PACKET_READ_REDACT_URI_PATH &&
+	    (uri_path_start = find_packfile_uri_path(buffer))) {
+		const char *redacted = "<redacted>";
+		struct strbuf tracebuf = STRBUF_INIT;
+		strbuf_insert(&tracebuf, 0, buffer, len);
+		strbuf_splice(&tracebuf, uri_path_start - buffer,
+			      strlen(uri_path_start), redacted, strlen(redacted));
+		packet_trace(tracebuf.buf, tracebuf.len, 0);
+		strbuf_release(&tracebuf);
+	} else {
+		packet_trace(buffer, len, 0);
+	}
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
diff --git a/pkt-line.h b/pkt-line.h
index 467ae013573..6d2a63db238 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -87,6 +87,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
+#define PACKET_READ_REDACT_URI_PATH      (1u<<4)
 int packet_read(int fd, char *buffer, unsigned size, int options);
 
 /*
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49f..78f85b0714a 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1107,6 +1107,57 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	test_i18ngrep "disallowed submodule name" err
 '
 
+test_expect_success 'packfile-uri path redacted in trace' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	git -C "$P" hash-object my-blob >objh &&
+	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$P" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -F "clone< \\1$(cat packh) $HTTPD_URL/<redacted>" log
+'
+
+test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDACT=0' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	git -C "$P" hash-object my-blob >objh &&
+	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$P" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" \
+	GIT_TRACE_REDACT=0 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -F "clone< \\1$(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" log
+'
+
 test_expect_success 'http:// --negotiate-only' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	URI="$HTTPD_URL/smart/server" &&
-- 
gitgitgadget

