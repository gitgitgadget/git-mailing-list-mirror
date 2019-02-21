Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3966A1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfBUUYt (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:24:49 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:35028 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUUYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:24:48 -0500
Received: by mail-io1-f73.google.com with SMTP id s9so2746889ioj.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M/vmNLYOylHU5sLtsUVnH3J1gmi7Ht+utm7HKHC32rM=;
        b=CL21NoTQbjoJ1qvmNezkIvOeMwV1qCFBGvqZRs4+X0VPu3VUyqqchgbuGAl0u/iW0Y
         i95SoGbp8E0gJP/EU/wd0WuOGwC8EsUjzapAeCW7gvOYNzefgFtphTYH8aGSUnV9FZBB
         boukW5x9fD5HX2pYlmZf0oVSq7qy6HV7vYzydJxmifQwRsLOl1+FEcddnoiduCppIogg
         HNozr5no0sfFCBndCBbHoPQpjtqx6NiiuFrWBA6r8cBRJVYhpAe3nolxQmD93M+m+xuG
         PxQ3Mjl+DH8ghhVwzQ/pY+fLfTZA56gZcGKa5GP3GGIEBNUBR29GMUFgKXPDBEcUEZEG
         uSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/vmNLYOylHU5sLtsUVnH3J1gmi7Ht+utm7HKHC32rM=;
        b=tlp7KypUjLjHkRhrzA/9IWvMRv89Os2+nXhC2mhHuSYeuh+BSnLyKdhoZ9aTDpz3VA
         vlNUxOWfCYYQ5SyU0Yu/SYdnqtvla3QFdgYwpiSa9kvjQQKZw2OEiVwzLVO4KBFMccoG
         8kiUDwX57p1PEfqbdYdp9tJp91FGlvI1aHoW/u3Q1aDU6saZ2ThAKgSa1IuPmmjB3/Eg
         qbQQHNtSocC5euYTJTgd3c0xJGvtDRjdALkijSOxaaIxLTG+uoQS0q2204tBOHHc0BZO
         n4ks68beOwbU2g8GZbJtb44WelYUHfeHbUe1pIWAK+M2fbmZVQKSXEZTh2+2peG7JL6G
         /fuA==
X-Gm-Message-State: AHQUAuYqPOIUAFsBgAU478zslehYz5S3ClRSAJRCLMoVKlK6l3o58Dor
        TyKDkoRDTYMIB81Fz1JcBsK0mzHFy1axxkh3xw2ZXkizYiR3JixEL+10SonlqNxoQishwe+H+RI
        Tq8Zw8z3vL+AlSAIOalGw8SfB3w3OZdApSTwQlz1cJJREPowYcVvxMYcuhAF2IjYmjsns9VmzbG
        Y2
X-Google-Smtp-Source: AHgI3IbSybUHpIFX4lRoRO+/XdNIXkMez5butSBdtK+8wjYkcBlfQuup0HgBgBnuAMcvIbssDdgDlCNJlcuqOGGLPK5v
X-Received: by 2002:a24:2c53:: with SMTP id i80mr266954iti.2.1550780687187;
 Thu, 21 Feb 2019 12:24:47 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:24:37 -0800
In-Reply-To: <cover.1550780213.git.jonathantanmy@google.com>
Message-Id: <8062cf9ce3d35bab974e745ef85ee4149619773d.1550780213.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com> <cover.1550780213.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 1/5] remote-curl: reduce scope of rpc_state.argv
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
index bb7421023b..8b7baf6298 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -505,7 +505,6 @@ static void output_refs(struct ref *refs)
 
 struct rpc_state {
 	const char *service_name;
-	const char **argv;
 	struct strbuf *stdin_preamble;
 	char *service_url;
 	char *hdr_content_type;
@@ -829,7 +828,8 @@ static int post_rpc(struct rpc_state *rpc)
 	return err;
 }
 
-static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
+static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
+		       const char **client_argv)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
@@ -840,7 +840,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	client.in = -1;
 	client.out = -1;
 	client.git_cmd = 1;
-	client.argv = rpc->argv;
+	client.argv = client_argv;
 	if (start_command(&client))
 		exit(1);
 	if (preamble)
@@ -978,11 +978,10 @@ static int fetch_git(struct discovery *heads,
 
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
@@ -1112,10 +1111,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
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

