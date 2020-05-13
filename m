Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E1C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B01220659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/BRjWOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbgEMSFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:18 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB00C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a136so170836qkg.6
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sv+JB8nSV1OKpS92HJl6Z+1itiAJ4oONZNBTcd1fzXk=;
        b=b/BRjWOyFXccIHcd2Az1JKCUHPjB7rZ0BmZYLfuIO5XULNgRD8kGyKwmWV1lDrTTh/
         52aQbWvyFNxwGufB6ym9tWa8uIWRXSUXc7PykiA/Y8TJptjG6HDdafvyv6LwY8atnhoo
         R1qUh0aIa5m3Bz0/IInib/kh6+/wnzvaGzF5W4UomLO9tC76ojckZDGNsN07Ikh2ibys
         xkNPRTpXzoi0kPRjThj+VSbKIpT8mH+3o4mjD7PHVqxD1zgO57xYTDYWbftsIPWzF7fe
         SvBlgDv+9T43vvxP7ZW4rCseP4Q0rMoq/Yh7p1Wh68REPHmYy3+rt3Y1nZCgmH8CZKyA
         bEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sv+JB8nSV1OKpS92HJl6Z+1itiAJ4oONZNBTcd1fzXk=;
        b=ArBGtB2HNMdpOStWvka+AqIx7XZLwhUzousgCnQ02rEICv8HbBUcd5GG7+vIFI11xl
         gjIqXn2OT8snDO6BCasiqLqrZoI/iNQxgqyW7c12I5Akh+vX6vp0rKe456O+inCOVA57
         D8DGamPNmcysJbuBerfHXVpjeDWuHak3szNI9UC3BQqMvCNcwM4fGrWfLv7asz06gTaI
         PSJDbQA591PWn96eFBB+GylwQZZ+BYnUHTqcXlp+hM0UgfxheBU9R6auWFU59g3dQpJi
         Y3n79yFIzRA2ZPSolhNfqeNmleI2Gtad6qneDzkZqMvUhw48Qr1uMgo6jsr4J5hx1qYw
         HyvQ==
X-Gm-Message-State: AOAM531TYDEr1cINz+x4XJ0EMm0kf54xAxL9iqMWbUlseOZY9hByMG1v
        yBN4/nTgGuZhEMLBIB9V8zrHZx3X
X-Google-Smtp-Source: ABdhPJxD4b1Yu9sCyrRSckEIqL/Y/TK/K5m8Ij4YE1HPwS4bX8DFH2Ll+UTzrvXRMT7sWZ8G4rDHBA==
X-Received: by 2002:a37:bc7:: with SMTP id 190mr948104qkl.286.1589393117596;
        Wed, 13 May 2020 11:05:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Force Charlie <charlieio@outlook.com>
Subject: [PATCH 6/6] remote-curl: ensure last packet is a flush
Date:   Wed, 13 May 2020 14:04:58 -0400
Message-Id: <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, remote-curl acts as a proxy and blindly forwards packets
between an HTTP server and fetch-pack. In the case of a stateless RPC
connection where the connection is terminated before the transaction is
complete, remote-curl will blindly forward the packets before waiting on
more input from fetch-pack. Meanwhile, fetch-pack will read the
transaction and continue reading, expecting more input to continue the
transaction. This results in a deadlock between the two processes.

This can be seen in the following command which does not terminate:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

whereas the v1 version does terminate as expected:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...
	fatal: the remote end hung up unexpectedly

Instead of blindly forwarding packets, raise a flag when a flush packet
is encountered. Ensure that the last packet sent is a flush packet
otherwise error out, breaking the deadlock.

This is not a complete solution to the problem, however. It is possible
that a flush packet could be sent in the middle of a message and the
connection could die immediately after. Then, remote-curl would not
error out and fetch-pack would still be in the middle of a transaction
and they would enter deadlock. A complete solution would involve
reframing the stateless-connect protocol, possibly by introducing
another control packet ("0002"?) as a stateless request separator
packet which is always sent at the end of post_rpc().

Although this is not a complete solution, it is better than nothing and
it resolves the reported issue for now.

Reported-by: Force Charlie <charlieio@outlook.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    I wish there were some way to insert a timeout on the test case so that
    we don't block forever in case we regress.

 remote-curl.c          |  9 +++++++++
 t/t5702-protocol-v2.sh | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 8b740354e5..aab17851be 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -684,6 +684,7 @@ struct rpc_in_data {
 	struct active_request_slot *slot;
 	struct strbuf len_buf;
 	int remaining;
+	int last_flush;
 };
 
 /*
@@ -707,6 +708,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 		data->rpc->any_written = 1;
 
 	while (unwritten) {
+		data->last_flush = 0;
+
 		if (!data->remaining) {
 			int digits_remaining = 4 - data->len_buf.len;
 			if (digits_remaining > unwritten)
@@ -720,6 +723,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 				if (data->remaining < 0) {
 					die(_("remote-curl: bad line length character: %.4s"), data->len_buf.buf);
 				} else if (data->remaining <= 1) {
+					if (!data->remaining)
+						data->last_flush = 1;
 					data->remaining = 0;
 				} else if (data->remaining < 4) {
 					die(_("remote-curl: bad line length %d"), data->remaining);
@@ -960,6 +965,7 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	rpc_in_data.slot = slot;
 	strbuf_init(&rpc_in_data.len_buf, 4);
 	rpc_in_data.remaining = 0;
+	rpc_in_data.last_flush = 0;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
@@ -979,6 +985,9 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	if (rpc_in_data.remaining)
 		err = error(_("%d bytes are still expected"), rpc_in_data.remaining);
 
+	if (!rpc_in_data.last_flush)
+		err = error(_("last packet was not a flush"));
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..4570d0746c 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -586,6 +586,23 @@ test_expect_success 'clone with http:// using protocol v2' '
 	! grep "Send header: Transfer-Encoding: chunked" log
 '
 
+test_expect_success 'clone with http:// using protocol v2 and invalid parameters' '
+	test_when_finished "rm -f log" &&
+
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" \
+		git -c protocol.version=2 \
+		clone --shallow-since=20151012 "$HTTPD_URL/smart/http_parent" http_child_invalid 2>err &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+	# Verify that we errored out in the expected way
+	test_i18ngrep "last packet was not a flush" err &&
+	# Verify that the chunked encoding sending codepath is NOT exercised
+	! grep "Send header: Transfer-Encoding: chunked" log
+'
+
 test_expect_success 'clone big repository with http:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.26.2.706.g87896c9627

