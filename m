Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3A81F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405563AbfBNTGu (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:06:50 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40215 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfBNTGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:06:49 -0500
Received: by mail-qk1-f202.google.com with SMTP id 203so5701056qke.7
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v+LnnGkLFfomtr/WYjogM3CLcIYVhaGIczExyQlFBJU=;
        b=hOvZeS9sNre95uHYv08sdllp0Cvbn7au8FhlH6YPzLNC57oSft5LOqUFEA0QcE0+3N
         oLJEBHfF8PvqHYFpYA911wRbfrWx8c+5mRmWkuTNwQknEVoB3FALqJI1pEc2RGtjRFa1
         v1HnUoXzP9WL4BGlr6+Jkxh8a8I7tcQfZ2IVdPDl1WV+BihGI5OqGWCbZ9M3H3j3BE23
         Y7Mw77rZl4VvBATs/A0MmjW82Ua0nkTJC0fZOakJNDZ1ZtPnVHomLJK3by2SiDaKmu/d
         d6wnvTMlqfx0dy2uEzdr6Z7Q6jOvkW+MPOXpmcSWu38iWH/N4wUqxTsLBw8AcPjuDFwe
         uc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v+LnnGkLFfomtr/WYjogM3CLcIYVhaGIczExyQlFBJU=;
        b=TMfop9osaxmv+uSKehA1ZolY9qSorzsJdSajSt88dffqfQcGvS7ZEf/2I87r1ODwpH
         7fyxwsVWNUsqxOb+8H8OLg3KsBnyQ+k+0TFdgBgr7kZBfyKpLIm8TtzDrL5ZZWlD7Shw
         +Gkd1ekl3MYsF3qKI7JoeucR9d53FoVSSK03lIbSu1gyK5jRcVI4g6giyklDgVyv6PbJ
         mnxTvGXge1WR2wVc8hY0tzHS9GcVg+OnxzcUQL7e0QQ5P9BOQZGJWnIKV11a6Bp+l9Zi
         lPbIqH8qsa8ReLDIGSFDtIw0/0UwBhrejSW12k2drRFzuIJLog9bfaP5NxrW6qk5THmm
         9YYw==
X-Gm-Message-State: AHQUAuZLJZZeWzUQXSPsW49QiY1fvUUFNqF9L4vyYu4FwYlgLhcmh08k
        1WMtdTpArsIbXASmOoBJtJK1HC0LsdPt2LSKM2BUOxQSwtYGm8fceE6hICGISSVprBT0te43/at
        8rJ/3BV0oC4NCMMBkNZNxoca2LOO1syT0/8njxD3WKe8uKskqhyZ+6QJ/tsE0wpyv+cVrZB1595
        ss
X-Google-Smtp-Source: AHgI3IZ2mEazeyt0o6LZgad6POw8gyZsC7fliCWOiulwyKESC31Py9+GMRY6zH9oXliv9u3WztlW4hT/ohZDVru7ufWW
X-Received: by 2002:ac8:3f92:: with SMTP id d18mr3176645qtk.34.1550171208767;
 Thu, 14 Feb 2019 11:06:48 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:35 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <a8bc5a256b5f4c4cba02342961d8e787bdf30abe.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/5] remote-curl: reduce scope of rpc_state.argv
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argv field in struct rpc_state is only used in rpc_service(), and
not in any functions it directly or indirectly calls. Refactor it to
become an argument of rpc_service() instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2e04d53ac8..3bc5055da6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -491,7 +491,6 @@ static void output_refs(struct ref *refs)
 
 struct rpc_state {
 	const char *service_name;
-	const char **argv;
 	struct strbuf *stdin_preamble;
 	char *service_url;
 	char *hdr_content_type;
@@ -815,7 +814,8 @@ static int post_rpc(struct rpc_state *rpc)
 	return err;
 }
 
-static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
+static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
+		       const char **client_argv)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
@@ -826,7 +826,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	client.in = -1;
 	client.out = -1;
 	client.git_cmd = 1;
-	client.argv = rpc->argv;
+	client.argv = client_argv;
 	if (start_command(&client))
 		exit(1);
 	if (preamble)
@@ -964,11 +964,10 @@ static int fetch_git(struct discovery *heads,
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-upload-pack",
-	rpc.argv = args.argv;
 	rpc.stdin_preamble = &preamble;
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads);
+	err = rpc_service(&rpc, heads, args.argv);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
@@ -1098,10 +1097,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
-	rpc.argv = args.argv;
 	rpc.stdin_preamble = &preamble;
 
-	err = rpc_service(&rpc, heads);
+	err = rpc_service(&rpc, heads, args.argv);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
-- 
2.19.0.271.gfe8321ec05.dirty

