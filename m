Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC901F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436486AbfBNTHC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:07:02 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:52675 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfBNTHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:07:01 -0500
Received: by mail-it1-f202.google.com with SMTP id z3so11887132itj.2
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hn2DGlvOL7yGgJk8OzmpXGtx2sIXocLuWyMzm+tphbI=;
        b=I1m/58JlyXmFN689n+7ureMfNdwiSdvBUKtdpNxUriWRPx64+otSiR6HZhIHjuFNls
         JDRHKrn+WxdWAtlhf2KZb7rNLnoz4cQBE9XkarAcSDl58tyDPSZNlS3G8wVfit47apOH
         DPXzTzgMPnmfr4kGN6cTqnZo8RJa3hXs1Ceak5LKFAC37Ec9288xxNXq7xzWYm+N6Pos
         4yMz1fUG4BN4+Dg/WD0/M4q0ZyG4Ft2Lk1DOPPYf+bDWPZrHdNs1NwlzdVKPd4Ls+5L+
         hyuxiT9y4Dfb6A4SXFsYMj42NAt4rgS14VCpfHOXE/oGHpAW/iGywuyyK4fQ4qDpw5VK
         eAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hn2DGlvOL7yGgJk8OzmpXGtx2sIXocLuWyMzm+tphbI=;
        b=ELVMcOCZv0CXUjsCx195XOX3oGsC/D7onYGPs6oQCcEqKk/+MWeT/ylobeOBNoQ3bD
         XuX4Lc19+4lEs9DKv5uqBmTKXaAjJz56q+0svCgdcskEnXuccvoOACPscYWLT4owrmh9
         5MwLYJVCbnp79m/n/c7RNfjlJM2BXguQ/Na9JWj/1MO4Oc3vceqLJ5uNul3mVhsDm2M+
         5BnfKPaLDUNcO3EjAixQOyQTNjhB4BwDERatf52nBUfV8oS8kmbhjKH/VTQBYpJRzaD6
         FLqQtCmNArj2ZcJCV3uhfL+4F1/7vRza74f9zLa0Y8gMo+9YVCH7XM4jQpYzudl8LGnB
         a6uQ==
X-Gm-Message-State: AHQUAuZCr5H/EPc5sHoljYhgPGmDB6h/lOQVVmF2XPukS1cGep274r8X
        V+GF+pHNQmblbUyzrG1/+B9iOcZpCDXSPhXigMZTKOt8Jaaf/UxtNHLuXxHTME0e6K2h5xpRy/W
        Ymx7gDUmU4u1z5MHpvc9Pj1PpS6DnrWDv8+OXcANc8QhZe7Bjd9qsE5MWasVAhazbXXd8liAnw9
        lr
X-Google-Smtp-Source: AHgI3IbSvn68pSsLfwsak4ZqOQB/aoHPjjB3aVMnc9hu3ppGyCu6V2MwhAaQd2lJQBeJLp08xOD3EJvDdMICzJGwlzh3
X-Received: by 2002:a24:5c8f:: with SMTP id q137mr3280505itb.20.1550171220757;
 Thu, 14 Feb 2019 11:07:00 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:37 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <db10ed20ff11eda56b14ca0667a0b42ab651b0b5.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 3/5] remote-curl: reduce scope of rpc_state.result
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
index bff0bb9af6..2eb39774d0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -502,7 +502,6 @@ struct rpc_state {
 	int in;
 	int out;
 	int any_written;
-	struct strbuf result;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
 };
@@ -814,7 +813,8 @@ static int post_rpc(struct rpc_state *rpc)
 }
 
 static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
-		       const char **client_argv, const struct strbuf *preamble)
+		       const char **client_argv, const struct strbuf *preamble,
+		       struct strbuf *rpc_result)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
@@ -835,7 +835,6 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	rpc->buf = xmalloc(rpc->alloc);
 	rpc->in = client.in;
 	rpc->out = client.out;
-	strbuf_init(&rpc->result, 0);
 
 	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
@@ -863,7 +862,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	close(client.in);
 	client.in = -1;
 	if (!err) {
-		strbuf_read(&rpc->result, client.out, 0);
+		strbuf_read(rpc_result, client.out, 0);
 	} else {
 		char buf[4096];
 		for (;;)
@@ -916,6 +915,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf preamble = STRBUF_INIT;
 	int i, err;
 	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strbuf rpc_result = STRBUF_INIT;
 
 	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
 			 "--stdin", "--lock-pack", NULL);
@@ -963,10 +963,10 @@ static int fetch_git(struct discovery *heads,
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
@@ -1061,6 +1061,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	struct argv_array args;
 	struct string_list_item *cas_option;
 	struct strbuf preamble = STRBUF_INIT;
+	struct strbuf rpc_result = STRBUF_INIT;
 
 	argv_array_init(&args);
 	argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
@@ -1094,10 +1095,10 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
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

