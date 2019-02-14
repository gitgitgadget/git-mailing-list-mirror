Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957A01F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438220AbfBNTHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:07:11 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:40218 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfBNTHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:07:11 -0500
Received: by mail-ot1-f74.google.com with SMTP id b21so1870223otl.7
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6+Bfk3C6XbeXT1AotsedWAG1SQZrjw91JVTA3jGExHs=;
        b=E/OYj8HXxfbua+NuY72yNaAwFcT8iSe7lqCaDh2SGPrSi05ACHEdhKYnNbfpUUipbU
         Hl36Dm/G/jfH1E2B1wwndXA9NkGy0AzMAaIS8rUHt23plZfGGP7WkmpHPm5cQ36/YSDN
         XfiwxeS4SDZwzvuSSPnZiNpBfs6EIj4FrpzUbCxK5sql7n9m4lVNW9VqvSertuvDKwDn
         8b78a7VWe5X6MyhvIeX+Xdj2X8ypr2fnHqkyt6mhzpLW3dkQCwsDDR7McpJlOwKW8Sfz
         +xlvy3qAVlGHS6T+jfpWfEugy3JTtdmrORp/8bJODOLxkJfT9Ocb3xotPROQIjTw5JAV
         UxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6+Bfk3C6XbeXT1AotsedWAG1SQZrjw91JVTA3jGExHs=;
        b=MH1p0SG9FMAKkrh9RUJl+28rTskxMWkzYbiwCzmHZM8YP8uUIoVGmW3FtSUVMHBwF1
         no38EYfuda+gI3Qm8FMFY9XvLCmZFp6uZCu/Wi/UuXXJeWjQ7Ce1UCBUA0TXmVSOcJma
         vFV0Ytag1OOYOxTXZYVnCxyJHGVBx2VwL0Zdso5MjDZZyxIp1gIR/MboHx1pVo0za5IT
         mndlt+goTlvqBym+dUYPx3+L42NhPqORpfLKCGRLqezTc7xxKcUADesxn99bS+QM0fid
         YnWlRs5mWK4fhwWbU2BWqv7K7bJQTSlnpJ1ad4zqzN5dlpWstKLujuSupccCr//AkIxR
         XyXw==
X-Gm-Message-State: AHQUAuZDL0FqnJoRtWo3s7FnecIQoQ85gjBj5eLwIBFUQBQOe+aC4H6L
        WlzTm6X3yx2uVa7b8dZ0EvLtmwU4p0sjvGdAaZJeCb2UrUwYD5UwbsphdMdM87Vo3qBedwK1I4O
        n6k3NIF1VO7Zk+OBzSRw7ShsZq43PICQ0y381n88Zst9OQ/ybmoei5pZf5GUaB6Y2O5hdwziWdU
        b2
X-Google-Smtp-Source: AHgI3Iaq575SNw9Jw/k6NrXWaz8SXu8dphpqH+8X40qANXvKAqZ8D588UwMl6tOAifTAqVcF4u693kVG710topyhgYO0
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr3049210oiy.15.1550171229658;
 Thu, 14 Feb 2019 11:07:09 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:39 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <25ea75eb435ed8fed759b30a4c362a68818a8905.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 5/5] remote-curl: use post_rpc() for protocol v2 also
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When transmitting and receiving POSTs for protocol v0 and v1,
remote-curl uses post_rpc() (and associated functions), but when doing
the same for protocol v2, it uses a separate set of functions
(proxy_rpc() and others). Besides duplication of code, this has caused
at least one bug: the auth retry mechanism that was implemented in v0/v1
was not implemented in v2.

To fix this issue and avoid it in the future, make remote-curl also use
post_rpc() when handling protocol v2. Because line lengths are written
to the HTTP request in protocol v2 (unlike in protocol v0/v1), this
necessitates changes in post_rpc() and some of the functions it uses;
perform these changes too.

A test has been included to ensure that the code for both the unchunked
and chunked variants of the HTTP request is exercised.

Note: stateless_connect() has been updated to use the lower-level packet
reading functions instead of struct packet_reader. The low-level control
is necessary here because we cannot change the destination buffer of
struct packet_reader while it is being used; struct packet_buffer has a
peeking mechanism which relies on the destination buffer being present
in between a peek and a read.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pkt-line.c             |   2 +-
 pkt-line.h             |   1 +
 remote-curl.c          | 298 +++++++++++++++++------------------------
 t/t5702-protocol-v2.sh |  26 +++-
 4 files changed, 150 insertions(+), 177 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index d4b71d3e82..60329b301b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -117,7 +117,7 @@ void packet_buf_delim(struct strbuf *buf)
 	strbuf_add(buf, "0001", 4);
 }
 
-static void set_packet_header(char *buf, const int size)
+void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
 
diff --git a/pkt-line.h b/pkt-line.h
index ad9a4a2cd7..c36cb788ed 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_delim(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
+void set_packet_header(char *buf, int size);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
diff --git a/remote-curl.c b/remote-curl.c
index 32c133f636..13836e4c28 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -504,6 +504,18 @@ struct rpc_state {
 	int any_written;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
+
+	/*
+	 * Whenever a pkt-line is read into buf, append the 4 characters
+	 * denoting its length before appending the payload.
+	 */
+	unsigned write_line_lengths : 1;
+
+	/*
+	 * rpc_out uses this to keep track of whether it should continue
+	 * reading to populate the current request. Initialize to 0.
+	 */
+	unsigned stop_reading : 1;
 };
 
 /*
@@ -511,17 +523,54 @@ struct rpc_state {
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
  * enough space, 0 otherwise.
  *
- * Writes the number of bytes appended into appended.
+ * If rpc->write_line_lengths is true, appends the line length as a 4-byte
+ * hexadecimal string before appending the result described above.
+ *
+ * Writes the total number of bytes appended into appended.
  */
-static int rpc_read_from_out(struct rpc_state *rpc, size_t *appended) {
-	size_t left = rpc->alloc - rpc->len;
-	char *buf = rpc->buf + rpc->len;
+static int rpc_read_from_out(struct rpc_state *rpc, int options,
+			     size_t *appended,
+			     enum packet_read_status *status) {
+	size_t left;
+	char *buf;
+	int pktlen_raw;
+
+	if (rpc->write_line_lengths) {
+		left = rpc->alloc - rpc->len - 4;
+		buf = rpc->buf + rpc->len + 4;
+	} else {
+		left = rpc->alloc - rpc->len;
+		buf = rpc->buf + rpc->len;
+	}
 
 	if (left < LARGE_PACKET_MAX)
 		return 0;
 
-	*appended = packet_read(rpc->out, NULL, NULL, buf, left, 0);
-	rpc->len += *appended;
+	*status = packet_read_with_status(rpc->out, NULL, NULL, buf,
+			left, &pktlen_raw, options);
+	if (*status != PACKET_READ_EOF) {
+		*appended = pktlen_raw + (rpc->write_line_lengths ? 4 : 0);
+		rpc->len += *appended;
+	}
+
+	if (rpc->write_line_lengths) {
+		switch (*status) {
+		case PACKET_READ_EOF:
+			if (!(options & PACKET_READ_GENTLE_ON_EOF))
+				die("shouldn't have EOF when not gentle on EOF");
+			break;
+		case PACKET_READ_NORMAL:
+			set_packet_header(buf - 4, *appended);
+			break;
+		case PACKET_READ_DELIM:
+			memcpy(buf - 4, "0001", 4);
+			break;
+		case PACKET_READ_FLUSH:
+			memcpy(buf - 4, "0000", 4);
+			break;
+		}
+	}
+
 	return 1;
 }
 
@@ -531,15 +580,32 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	size_t max = eltsize * nmemb;
 	struct rpc_state *rpc = buffer_;
 	size_t avail = rpc->len - rpc->pos;
+	enum packet_read_status status;
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
 		rpc->len = 0;
-		if (!rpc_read_from_out(rpc, &avail))
-			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
-		if (!avail)
-			return 0;
 		rpc->pos = 0;
+		if (!rpc->stop_reading) {
+			if (!rpc_read_from_out(rpc, 0, &avail, &status))
+				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
+			if (status == PACKET_READ_FLUSH)
+				/*
+				 * We are done reading for this request, but we
+				 * still need to send this line out (if
+				 * rpc->write_line_lengths is true) so do not
+				 * return yet.
+				 */
+				rpc->stop_reading = 1;
+		}
+	}
+	if (!avail && rpc->stop_reading) {
+		/*
+		 * "return 0" will notify Curl that this RPC request is done,
+		 * so reset stop_reading back to 0 for the next request.
+		 */
+		rpc->stop_reading = 0;
+		return 0;
 	}
 
 	if (max < avail)
@@ -684,13 +750,14 @@ static int post_rpc(struct rpc_state *rpc)
 	 */
 	while (1) {
 		size_t n;
+		enum packet_read_status status;
 
-		if (!rpc_read_from_out(rpc, &n)) {
+		if (!rpc_read_from_out(rpc, 0, &n, &status)) {
 			large_request = 1;
 			use_gzip = 0;
 			break;
 		}
-		if (!n)
+		if (status == PACKET_READ_FLUSH)
 			break;
 	}
 
@@ -1165,165 +1232,11 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
-/*
- * Used to represent the state of a connection to an HTTP server when
- * communicating using git's wire-protocol version 2.
- */
-struct proxy_state {
-	char *service_name;
-	char *service_url;
-	struct curl_slist *headers;
-	struct strbuf request_buffer;
-	int in;
-	int out;
-	struct packet_reader reader;
-	size_t pos;
-	int seen_flush;
-};
-
-static void proxy_state_init(struct proxy_state *p, const char *service_name,
-			     enum protocol_version version)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	memset(p, 0, sizeof(*p));
-	p->service_name = xstrdup(service_name);
-
-	p->in = 0;
-	p->out = 1;
-	strbuf_init(&p->request_buffer, 0);
-
-	strbuf_addf(&buf, "%s%s", url.buf, p->service_name);
-	p->service_url = strbuf_detach(&buf, NULL);
-
-	p->headers = http_copy_default_headers();
-
-	strbuf_addf(&buf, "Content-Type: application/x-%s-request", p->service_name);
-	p->headers = curl_slist_append(p->headers, buf.buf);
-	strbuf_reset(&buf);
-
-	strbuf_addf(&buf, "Accept: application/x-%s-result", p->service_name);
-	p->headers = curl_slist_append(p->headers, buf.buf);
-	strbuf_reset(&buf);
-
-	p->headers = curl_slist_append(p->headers, "Transfer-Encoding: chunked");
-
-	/* Add the Git-Protocol header */
-	if (get_protocol_http_header(version, &buf))
-		p->headers = curl_slist_append(p->headers, buf.buf);
-
-	packet_reader_init(&p->reader, p->in, NULL, 0,
-			   PACKET_READ_GENTLE_ON_EOF |
-			   PACKET_READ_DIE_ON_ERR_PACKET);
-
-	strbuf_release(&buf);
-}
-
-static void proxy_state_clear(struct proxy_state *p)
-{
-	free(p->service_name);
-	free(p->service_url);
-	curl_slist_free_all(p->headers);
-	strbuf_release(&p->request_buffer);
-}
-
-/*
- * CURLOPT_READFUNCTION callback function.
- * Attempts to copy over a single packet-line at a time into the
- * curl provided buffer.
- */
-static size_t proxy_in(char *buffer, size_t eltsize,
-		       size_t nmemb, void *userdata)
-{
-	size_t max;
-	struct proxy_state *p = userdata;
-	size_t avail = p->request_buffer.len - p->pos;
-
-
-	if (eltsize != 1)
-		BUG("curl read callback called with size = %"PRIuMAX" != 1",
-		    (uintmax_t)eltsize);
-	max = nmemb;
-
-	if (!avail) {
-		if (p->seen_flush) {
-			p->seen_flush = 0;
-			return 0;
-		}
-
-		strbuf_reset(&p->request_buffer);
-		switch (packet_reader_read(&p->reader)) {
-		case PACKET_READ_EOF:
-			die("unexpected EOF when reading from parent process");
-		case PACKET_READ_NORMAL:
-			packet_buf_write_len(&p->request_buffer, p->reader.line,
-					     p->reader.pktlen);
-			break;
-		case PACKET_READ_DELIM:
-			packet_buf_delim(&p->request_buffer);
-			break;
-		case PACKET_READ_FLUSH:
-			packet_buf_flush(&p->request_buffer);
-			p->seen_flush = 1;
-			break;
-		}
-		p->pos = 0;
-		avail = p->request_buffer.len;
-	}
-
-	if (max < avail)
-		avail = max;
-	memcpy(buffer, p->request_buffer.buf + p->pos, avail);
-	p->pos += avail;
-	return avail;
-}
-
-static size_t proxy_out(char *buffer, size_t eltsize,
-			size_t nmemb, void *userdata)
-{
-	size_t size;
-	struct proxy_state *p = userdata;
-
-	if (eltsize != 1)
-		BUG("curl read callback called with size = %"PRIuMAX" != 1",
-		    (uintmax_t)eltsize);
-	size = nmemb;
-
-	write_or_die(p->out, buffer, size);
-	return size;
-}
-
-/* Issues a request to the HTTP server configured in `p` */
-static int proxy_request(struct proxy_state *p)
-{
-	struct active_request_slot *slot;
-
-	slot = get_active_slot();
-
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, p->headers);
-
-	/* Setup function to read request from client */
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
-	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
-
-	/* Setup function to write server response to client */
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
-
-	if (run_slot(slot, NULL) != HTTP_OK)
-		return -1;
-
-	return 0;
-}
-
 static int stateless_connect(const char *service_name)
 {
 	struct discovery *discover;
-	struct proxy_state p;
+	struct rpc_state rpc;
+	struct strbuf buf = STRBUF_INIT;
 
 	/*
 	 * Run the info/refs request and see if the server supports protocol
@@ -1343,23 +1256,58 @@ static int stateless_connect(const char *service_name)
 		fflush(stdout);
 	}
 
-	proxy_state_init(&p, service_name, discover->version);
+	rpc.service_name = service_name;
+	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
+	rpc.hdr_content_type = xstrfmt("Content-Type: application/x-%s-request", rpc.service_name);
+	rpc.hdr_accept = xstrfmt("Accept: application/x-%s-result", rpc.service_name);
+	if (get_protocol_http_header(discover->version, &buf)) {
+		rpc.protocol_header = strbuf_detach(&buf, NULL);
+	} else {
+		rpc.protocol_header = NULL;
+		strbuf_release(&buf);
+	}
+	rpc.buf = xmalloc(http_post_buffer);
+	rpc.alloc = http_post_buffer;
+	rpc.len = 0;
+	rpc.pos = 0;
+	rpc.in = 1;
+	rpc.out = 0;
+	rpc.any_written = 0;
+	rpc.gzip_request = 1;
+	rpc.initial_buffer = 0;
+	rpc.write_line_lengths = 1;
+	rpc.stop_reading = 0;
 
 	/*
 	 * Dump the capability listing that we got from the server earlier
 	 * during the info/refs request.
 	 */
-	write_or_die(p.out, discover->buf, discover->len);
+	write_or_die(rpc.in, discover->buf, discover->len);
 
-	/* Peek the next packet line.  Until we see EOF keep sending POSTs */
-	while (packet_reader_peek(&p.reader) != PACKET_READ_EOF) {
-		if (proxy_request(&p)) {
+	/* Until we see EOF keep sending POSTs */
+	while (1) {
+		size_t avail;
+		enum packet_read_status status;
+
+		if (!rpc_read_from_out(&rpc, PACKET_READ_GENTLE_ON_EOF, &avail,
+				       &status))
+			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
+		if (status == PACKET_READ_EOF)
+			break;
+		if (post_rpc(&rpc))
 			/* We would have an err here */
 			break;
-		}
+		/* Reset the buffer for next request */
+		rpc.len = 0;
 	}
 
-	proxy_state_clear(&p);
+	free(rpc.service_url);
+	free(rpc.hdr_content_type);
+	free(rpc.hdr_accept);
+	free(rpc.protocol_header);
+	free(rpc.buf);
+	strbuf_release(&buf);
+
 	return 0;
 }
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..61acf99d80 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -542,7 +542,31 @@ test_expect_success 'clone with http:// using protocol v2' '
 	# Client requested to use protocol v2
 	grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log
+	grep "git< version 2" log &&
+	# Verify that the chunked encoding sending codepath is NOT exercised
+	! grep "Send header: Transfer-Encoding: chunked" log
+'
+
+test_expect_success 'clone big repository with http:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/big" &&
+	# Ensure that the list of wants is greater than http.postbuffer below
+	for i in $(seq 1 1500)
+	do
+		test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/big" "commit$i"
+	done &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git \
+		-c protocol.version=2 -c http.postbuffer=65536 \
+		clone "$HTTPD_URL/smart/big" big_child &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+	# Verify that the chunked encoding sending codepath is exercised
+	grep "Send header: Transfer-Encoding: chunked" log
 '
 
 test_expect_success 'fetch with http:// using protocol v2' '
-- 
2.19.0.271.gfe8321ec05.dirty

