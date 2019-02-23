Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB8820248
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfBWXjU (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:20 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:44420 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfBWXjT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:19 -0500
Received: by mail-io1-f74.google.com with SMTP id k24so4857893ioh.11
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eCfWlNGgENC7TS3N4CqpCf2JRmWLTT4o89UL+ZncUtQ=;
        b=aIiBhTjqH0u7gWb6hB+ywFxefDggVVW+gdWciUxLnDacolply4cICXqsWkEGfNhjOG
         r/t4xuI48B1M+4oV0lG3NzINveR0E8rYhYxD7PenYobeFjSb51ZNsuYbBzmODAt+LobL
         g1xo46Bc9Ki7HWXQ1hNJODqmA2V6mxW+KGsSax6fqYOzJ1k863f9ngbUcZMt+0RU07FV
         WBqzUspmplTNvCjC9noBP9MVdO4QEXB7hKTOr9ZJXUrVn3MjrAlYN6FCufauOMGxxYpp
         V3MhrDWHO3Sme6VSXVAqvLlh+adQRDWW+zWbCVvG+ewKQPh5wgmIlLFelo0bGAHPbYEP
         XVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eCfWlNGgENC7TS3N4CqpCf2JRmWLTT4o89UL+ZncUtQ=;
        b=lvNvm/PYjUmPe7AK9sjBRWYzUScWq+m8LS+wZfYKlToAsfllT25k861xC1rN5kWQYr
         GwcEpFVUy+W2TXLpxzwcy4Y7OEYHTVVlkP/alzIBx+RsWosfftHdjqwuCsdG49a+Hb7E
         L0X1L3H24KVowFgrklZMY+9b8y1Vt6D31Bv6Z4eoNAWUpo6AhKnEMhlEiqINLuKRGKNG
         zEUDMCyBhwM3PQpHz1+dO8hD6y43yYPzfRp832ZACzMeuO5Y0ObPmI6Mkhs2V9pJWf3M
         JDiF2cHwTHXJs9DJnJjHbCpsN5u92UrxMMaOsVx3oyrtkAMvuqkOjvZzOjU7sy2tbw4T
         TafA==
X-Gm-Message-State: AHQUAuZxbuxr0KwR9E7CeuDsPCfcr+RuILk7M+u/DjoV4zWYVTZJZWkq
        BnL+oPUZxW5BBCpd4BXadsxR2xzGYFn1t97ZKprr85x4ls7mstJ2Jp1VBamODEvKAarwgtSJMz7
        JIp1DMNKdKLLIuvyJoVlYayv7P+tlI8+4qJmFBiH9Xtpz+7rfeorwS0CspwMb/0Br45XjfYWuKX
        Wz
X-Google-Smtp-Source: AHgI3IYTBf4H+vSzBZH8g0reQa2sisOXlA7nRkzXdvNiMTlb96Qzp5iRjE3/Sz0ZtdTMhcEe4Fo8oHbIwUDtRwfB+O8j
X-Received: by 2002:a24:1303:: with SMTP id 3mr3647357itz.40.1550965158748;
 Sat, 23 Feb 2019 15:39:18 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:39:00 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <2d00fd79a7c861d0bda61782630843ec4054f248.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 6/7] upload-pack: refactor reading of pack-objects out
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent patches will change how the output of pack-objects is
processed, so extract that processing into its own function.

Currently, at most 1 character can be buffered (in the "buffered" local
variable). One of those patches will require a larger buffer, so replace
that "buffered" local variable with a buffer array.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 81 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..987d2e139b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -102,14 +102,52 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
+struct output_state {
+	char buffer[8193];
+	int used;
+};
+
+static int relay_pack_data(int pack_objects_out, struct output_state *os)
+{
+	/*
+	 * We keep the last byte to ourselves
+	 * in case we detect broken rev-list, so that we
+	 * can leave the stream corrupted.  This is
+	 * unfortunate -- unpack-objects would happily
+	 * accept a valid packdata with trailing garbage,
+	 * so appending garbage after we pass all the
+	 * pack data is not good enough to signal
+	 * breakage to downstream.
+	 */
+	ssize_t readsz;
+
+	readsz = xread(pack_objects_out, os->buffer + os->used,
+		       sizeof(os->buffer) - os->used);
+	if (readsz < 0) {
+		return readsz;
+	}
+	os->used += readsz;
+
+	if (os->used > 1) {
+		send_client_data(1, os->buffer, os->used - 1);
+		os->buffer[0] = os->buffer[os->used - 1];
+		os->used = 1;
+	} else {
+		send_client_data(1, os->buffer, os->used);
+		os->used = 0;
+	}
+
+	return readsz;
+}
+
 static void create_pack_file(const struct object_array *have_obj,
 			     const struct object_array *want_obj)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	char data[8193], progress[128];
+	struct output_state output_state = {0};
+	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
-	int buffered = -1;
 	ssize_t sz;
 	int i;
 	FILE *pipe_fd;
@@ -239,39 +277,15 @@ static void create_pack_file(const struct object_array *have_obj,
 			continue;
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
-			/* Data ready; we keep the last byte to ourselves
-			 * in case we detect broken rev-list, so that we
-			 * can leave the stream corrupted.  This is
-			 * unfortunate -- unpack-objects would happily
-			 * accept a valid packdata with trailing garbage,
-			 * so appending garbage after we pass all the
-			 * pack data is not good enough to signal
-			 * breakage to downstream.
-			 */
-			char *cp = data;
-			ssize_t outsz = 0;
-			if (0 <= buffered) {
-				*cp++ = buffered;
-				outsz++;
-			}
-			sz = xread(pack_objects.out, cp,
-				  sizeof(data) - outsz);
-			if (0 < sz)
-				;
-			else if (sz == 0) {
+			int result = relay_pack_data(pack_objects.out,
+						     &output_state);
+
+			if (result == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
-			}
-			else
+			} else if (result < 0) {
 				goto fail;
-			sz += outsz;
-			if (1 < sz) {
-				buffered = data[sz-1] & 0xFF;
-				sz--;
 			}
-			else
-				buffered = -1;
-			send_client_data(1, data, sz);
 		}
 
 		/*
@@ -296,9 +310,8 @@ static void create_pack_file(const struct object_array *have_obj,
 	}
 
 	/* flush the data */
-	if (0 <= buffered) {
-		data[0] = buffered;
-		send_client_data(1, data, 1);
+	if (output_state.used > 0) {
+		send_client_data(1, output_state.buffer, output_state.used);
 		fprintf(stderr, "flushed.\n");
 	}
 	if (use_sideband)
-- 
2.19.0.271.gfe8321ec05.dirty

