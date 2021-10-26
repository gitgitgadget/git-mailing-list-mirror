Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA0DC433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5E6610A4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhJZWw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhJZWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:52:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E2C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so834698wrg.5
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RMIs5zvgWAEeSufOGx418hI51kyM4qrHx5eLsJiEL3U=;
        b=QggR00AHCOMBoyNrkzPiLbR5oGNWnD5Icichh/UMdXWQeOZDon26wZolamU6qCH8OC
         1AXPChtzWj9nmkgXwiGtDvINvFHZuQvbz2IBZGgKDQlk1k41VEb0p7pc+GqgX9gJzfa/
         mIYsUHy0q0XROoaTn/p1O4adalgp40qB04NYYccJCkMr21C5b5MejyMRiKAf+L8GzKVI
         272cjf2ScB6vwxLt23cp9bM/5/7PYuiBkfxZKmqzXz5NSk/cJjCXm2cjv7ckoz0Kiwco
         rLGgDEbzgkG59McYthvDfce9kpPgiPP0teUGJIpaAg3Nq7V+OyBuNpoba3s5BnAvotEx
         /tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RMIs5zvgWAEeSufOGx418hI51kyM4qrHx5eLsJiEL3U=;
        b=CBkouMmWkPmGcjWAl6J8e5bv5XtyB3YFAjCtkKn/A1LOTjykuQJRqQBPxOjkD+HGBb
         S7osVOF10QxVhxrXJe5ejrc07uQkT8ndfotHu+y/Qhm7hw84BIX3EYAXMIqIA3BBCuqs
         kRwsq++emMmGDCOEnm2FSIFF+DwImDb8tl4oSQdbTeO/4LCPzrUHkzjz87sLoxh0oYQw
         SoF25Gtf/6YjY+e7qrtTpNOJPo5Ix5HOh1b40El/Whz/QpGW4f6JJA651Zkk3RVhRCZx
         e/+DaHF5imtl/Ht3IfzP+19txQsQqcTnotIX1/ZAELyRQpayOpPGFq2Qf/QU3FGrjdWW
         675g==
X-Gm-Message-State: AOAM533dJsgnfoz7peKPEmddF2t4OxWqJxNPQGDuJ+TaOdpyZb3Jdgw6
        M2cVBMk2TETe9hrX7YBP6Y9tagJNxgM=
X-Google-Smtp-Source: ABdhPJyAS5l9J5QXFWk4Ii62hOheVYxfZWENu9g5DSApV544lWDhLMSaZ7wtv+CUXQpUlMtB7SzMFA==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr26838262wry.343.1635288600641;
        Tue, 26 Oct 2021 15:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm15257979wrq.88.2021.10.26.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:50:00 -0700 (PDT)
Message-Id: <973a250752c39c3fe835d69f3fbe8f009fc4fa74.1635288599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
        <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:49:58 +0000
Subject: [PATCH v4 1/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
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
 fetch-pack.c           |  3 +++
 pkt-line.c             | 40 ++++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d63c65e67d8..f64c8ce5183 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -832,8 +832,9 @@ for full details.
 
 `GIT_TRACE_REDACT`::
 	By default, when tracing is activated, Git redacts the values of
-	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
-	header. Set this variable to `0` to prevent this redaction.
+	cookies, the "Authorization:" header, the "Proxy-Authorization:"
+	header and packfile URLs. Set this variable to `0` to prevent this
+	redaction.
 
 `GIT_LITERAL_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..ad8ac49ca50 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1581,6 +1581,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	if (git_env_bool("GIT_TRACE_REDACT", 1))
+		reader.options |= PACKET_READ_REDACT_URL_PATH;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/pkt-line.c b/pkt-line.c
index 2dc8ac274bd..ba0a2d65f0c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
 }
 
+static char *find_url_path(const char* buffer, int *path_len)
+{
+	const char *URL_MARK = "://";
+	char *path = strstr(buffer, URL_MARK);
+	if (!path)
+		return NULL;
+
+	path += strlen(URL_MARK);
+	while (*path && *path != '/')
+		path++;
+
+	if (!*path || !*(path + 1))
+		return NULL;
+
+	// position after '/'
+	path++;
+
+	if (path_len) {
+		char *url_end = strchrnul(path, ' ');
+		*path_len = url_end - path;
+	}
+
+	return path;
+}
+
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
 						unsigned size, int *pktlen,
@@ -377,6 +402,8 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 {
 	int len;
 	char linelen[4];
+	char *url_path_start;
+	int url_path_len;
 
 	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
 		*pktlen = -1;
@@ -427,7 +454,18 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		len--;
 
 	buffer[len] = 0;
-	packet_trace(buffer, len, 0);
+	if (options & PACKET_READ_REDACT_URL_PATH &&
+	    (url_path_start = find_url_path(buffer, &url_path_len))) {
+		const char *redacted = "<redacted>";
+		struct strbuf tracebuf = STRBUF_INIT;
+		strbuf_insert(&tracebuf, 0, buffer, len);
+		strbuf_splice(&tracebuf, url_path_start - buffer,
+			      url_path_len, redacted, strlen(redacted));
+		packet_trace(tracebuf.buf, tracebuf.len, 0);
+		strbuf_release(&tracebuf);
+	} else {
+		packet_trace(buffer, len, 0);
+	}
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
diff --git a/pkt-line.h b/pkt-line.h
index 467ae013573..a610ecb88e8 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -87,6 +87,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
+#define PACKET_READ_REDACT_URL_PATH      (1u<<4)
 int packet_read(int fd, char *buffer, unsigned size, int options);
 
 /*
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49f..f01af2f2ed3 100755
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
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
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
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
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

