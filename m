Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8811F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbfBNTGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:06:53 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:33104 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfBNTGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:06:53 -0500
Received: by mail-ot1-f73.google.com with SMTP id e25so6175956otp.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bGdZO5l2Ykth3yA6ajCvug0qnl+RdNELTArhf/Kz0gw=;
        b=hjkCiKhACNGtg2R8mJ4uslqY9U6yh0G/QW4C/M3kNzdd/8tpDIshb0aKoRJz4q4l0R
         M3ynODmN8Ih0QrGZNGrSiX/3Al4UNaWAZHg4ica2dPTIv1n8Sh0hSv9YiVI+d41s3oWo
         s8V1NofzT2j1DAUhNEp5OdCJzaIIbkt7/dne+P/0dQR5cBpZEr7mWyA7ihESEK3KkNP9
         LUN7atBREZO2ZypB+wwVe9wG28QJAl3j3YTRm4KqzkUh1A5zJN5vdzdRP+ryoERpm9XU
         duhCBqLPNyv7q5dAFFs0wC8nAllxV9zntmKa1HNQLPQhMpqaDG9XqO4qo2QTQKS0zkBR
         W3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bGdZO5l2Ykth3yA6ajCvug0qnl+RdNELTArhf/Kz0gw=;
        b=m8Nwb8l8oO0Csj80wXBmHVd3Z+gDv2sIub9WgKDxs2YPJTuNVnvfAvQxCKqxjaav94
         YnOnIc1vJRROW9hBe7Y9AUnhEdbNMmp2CDO78ezYzpX2TNz8gGAQzEAhfqAcatQAUyEs
         6T0rGGMkqOOibMqnFReaIR4wevrgSf/fOZ0SAh2/xgVkO9f6Jmb1MhXpipr3WbyelRqr
         DirWKZbKkoPenHA87baUYJBNunYKBiwO2LBSlJ40RY7ivF4f9pQ7I8nqWJeJrI0GHpw4
         RPHZLscSzfBCPavsym+GnQ8G/ZAELeW7+/7Laugeh3WY8nA1c8HnSPOlG48mAbanXPHb
         SLoQ==
X-Gm-Message-State: AHQUAubfm0F4K+V56CTqfJTfLfJDieh+FtukZblUPCGrQSchcuy6FCtE
        Pi9nwNwUqVOP4Grv/wGJ2RYyb/4fqEc6hwaNMp6NLJIzgofFwUXbzBYUJ8MkFwzRDgL8tJR3Cfe
        YKBgyJlkV5M8tuNJtx3BmZPnGIeeGIIB9YIaCo+Rf+WYuBLILvyySP6mAdnu2yzTKjmBtFSFSU7
        s8
X-Google-Smtp-Source: AHgI3IYW+F4UiDubXiowT385CfF0CFGlQDRsdAWJUJkNrYWiXRBefOeGVeaQEr93+gPp2R3d56QsyHZp8p70EHTgIyd3
X-Received: by 2002:a54:400e:: with SMTP id x14mr2316532oie.42.1550171212084;
 Thu, 14 Feb 2019 11:06:52 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:36 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <0a7cc5f6aa531a3bcee571b08d2eee4715773510.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/5] remote-curl: reduce scope of rpc_state.stdin_preamble
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The stdin_preamble field in struct rpc_state is only used in
rpc_service(), and not in any functions it directly or indirectly calls.
Refactor it to become an argument of rpc_service() instead.

An observation of all callers of rpc_service() shows that the preamble
is always set, so we no longer need the "if (preamble)" check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3bc5055da6..bff0bb9af6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -491,7 +491,6 @@ static void output_refs(struct ref *refs)
 
 struct rpc_state {
 	const char *service_name;
-	struct strbuf *stdin_preamble;
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
@@ -815,11 +814,10 @@ static int post_rpc(struct rpc_state *rpc)
 }
 
 static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
-		       const char **client_argv)
+		       const char **client_argv, const struct strbuf *preamble)
 {
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf *preamble = rpc->stdin_preamble;
 	struct child_process client = CHILD_PROCESS_INIT;
 	int err = 0;
 
@@ -829,8 +827,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.argv = client_argv;
 	if (start_command(&client))
 		exit(1);
-	if (preamble)
-		write_or_die(client.in, preamble->buf, preamble->len);
+	write_or_die(client.in, preamble->buf, preamble->len);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -964,10 +961,9 @@ static int fetch_git(struct discovery *heads,
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-upload-pack",
-	rpc.stdin_preamble = &preamble;
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads, args.argv);
+	err = rpc_service(&rpc, heads, args.argv, &preamble);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
@@ -1097,9 +1093,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
-	rpc.stdin_preamble = &preamble;
 
-	err = rpc_service(&rpc, heads, args.argv);
+	err = rpc_service(&rpc, heads, args.argv, &preamble);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
-- 
2.19.0.271.gfe8321ec05.dirty

