Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90271F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBUUYx (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:24:53 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48645 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBUUYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:24:53 -0500
Received: by mail-qt1-f201.google.com with SMTP id d49so2052050qtd.15
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gzKXV/Ezcy/d680BCNoPVAbD431nng+K/jc23V8OOig=;
        b=aaIySczIhxKCTw2UMkhs6pwRy/e+o+Ts/WS29hjsSOUDo8UJGWuRk6P8V1Zc2OVNSk
         dv6k81/8zyrEx5lGph9ftk3WISrxPjkpHc9izAk5zQjYyyz4eizk3ooaweoODwgokQg0
         YKVyYAMaWlNdZ9qIxlD5xIAUsvEDSk9KW0EQpGKXbOOcM7kpiJYu6zU99HPtFtmq1OXH
         l6MY9k/I7+5NANA6T3GSUgFEwaYl3rTwW2SPt061uh+hQOMLlUgd1cQpl2vl0HOJ0Jcr
         uxyGbunpJppw6IBGCr35vF1Z+s/Wi5836JXp39QXnqtB8HT8SopQJGXbwfyVKgvZA994
         OuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gzKXV/Ezcy/d680BCNoPVAbD431nng+K/jc23V8OOig=;
        b=fSSfYcksI5/zc3e+5Zow3gA1nzc0SQVOzAEKGbNI+u7u8axGoXP7CZWHGSwbL7Hb0d
         FwO+ZCAjQoC5x25RMjDhGdOKy/tLHQkQVZADV7/0qjCMZeATN2fbXlz36qhItfa3214h
         NM8qbGqAOFaMWYL9nQUcSgGtazx5Y3RukruTL7nziRAQ2ebKaiJzQj9wPcV3qs3hbmi6
         QEhoT0FeeoofZ2S9R7x74sgY9jjWfxoZ+xWzepQtL2/gXyZ/qWQXL0Irs7M303ziRZod
         +7gm0jNA7rVv39qXb7aQjqTE24qMalXyh7PgdPzi4lM92LHfVzP0DHorCnYVsN7ar2R0
         v91w==
X-Gm-Message-State: AHQUAua1Fg1NKl+hosSNjUWVjGKniz56uTGmkoxpicuuu0f0Gcy3OjEV
        b+nxljyae4q5u2mDhnCCg5Gt6RqObhs5Yr8TsE+ys8DWUE3k6PD2+LKwoSStHn65hU2TFuhFtuO
        PtGxOkz3rrvVUE/XqnlT6OPXIF6SIRp4GZJmp0jPNQi9gRDMF0vTaHOOKQqa3EblaoXoxD8a8XV
        Tc
X-Google-Smtp-Source: AHgI3IZEBmoijaqrEjee63H5jh3XLy7f1zLl48tBSq5HcaEbgSGs089E/PQs7AMSv7gt+eanDnte2EhsqH5VGE5UT+OS
X-Received: by 2002:ac8:32aa:: with SMTP id z39mr229995qta.35.1550780692243;
 Thu, 21 Feb 2019 12:24:52 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:24:39 -0800
In-Reply-To: <cover.1550780213.git.jonathantanmy@google.com>
Message-Id: <19ccc0324803f07f3ceee2f47a998779fe656c0c.1550780213.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com> <cover.1550780213.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 3/5] remote-curl: reduce scope of rpc_state.result
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The result field in struct rpc_state is only used in rpc_service(), and
not in any functions it directly or indirectly calls. Refactor it to
become an argument of rpc_service() instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d33d5bbfa8..8e0e37ed3d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -516,7 +516,6 @@ struct rpc_state {
 	int in;
 	int out;
 	int any_written;
-	struct strbuf result;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
 };
@@ -828,7 +827,8 @@ static int post_rpc(struct rpc_state *rpc)
 }
 
 static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
-		       const char **client_argv, const struct strbuf *preamble)
+		       const char **client_argv, const struct strbuf *preamble,
+		       struct strbuf *rpc_result)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
@@ -849,7 +849,6 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	rpc->buf = xmalloc(rpc->alloc);
 	rpc->in = client.in;
 	rpc->out = client.out;
-	strbuf_init(&rpc->result, 0);
 
 	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
@@ -877,7 +876,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	close(client.in);
 	client.in = -1;
 	if (!err) {
-		strbuf_read(&rpc->result, client.out, 0);
+		strbuf_read(rpc_result, client.out, 0);
 	} else {
 		char buf[4096];
 		for (;;)
@@ -930,6 +929,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf preamble = STRBUF_INIT;
 	int i, err;
 	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strbuf rpc_result = STRBUF_INIT;
 
 	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
 			 "--stdin", "--lock-pack", NULL);
@@ -977,10 +977,10 @@ static int fetch_git(struct discovery *heads,
 	rpc.service_name = "git-upload-pack",
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads, args.argv, &preamble);
-	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
-	strbuf_release(&rpc.result);
+	err = rpc_service(&rpc, heads, args.argv, &preamble, &rpc_result);
+	if (rpc_result.len)
+		write_or_die(1, rpc_result.buf, rpc_result.len);
+	strbuf_release(&rpc_result);
 	strbuf_release(&preamble);
 	argv_array_clear(&args);
 	return err;
@@ -1075,6 +1075,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	struct argv_array args;
 	struct string_list_item *cas_option;
 	struct strbuf preamble = STRBUF_INIT;
+	struct strbuf rpc_result = STRBUF_INIT;
 
 	argv_array_init(&args);
 	argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
@@ -1108,10 +1109,10 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
 
-	err = rpc_service(&rpc, heads, args.argv, &preamble);
-	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
-	strbuf_release(&rpc.result);
+	err = rpc_service(&rpc, heads, args.argv, &preamble, &rpc_result);
+	if (rpc_result.len)
+		write_or_die(1, rpc_result.buf, rpc_result.len);
+	strbuf_release(&rpc_result);
 	strbuf_release(&preamble);
 	argv_array_clear(&args);
 	return err;
-- 
2.19.0.271.gfe8321ec05.dirty

