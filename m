Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700AA1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfBUUYv (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:24:51 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53777 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUUYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:24:50 -0500
Received: by mail-qt1-f201.google.com with SMTP id k37so27779113qtb.20
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g2OctTVip+vhQfZMynnuLwKCHVgBzQWnQ+tuo7kQZa4=;
        b=Ykqp0WLJfYs+qab22KaaG9gwuOas2iFuyaTQuT+VJkI18hZljsyVE12CQIXz2+/deF
         EvaR9nvYRprj6m0Uk1+sO/wlQxw1QCgkrBAZcQ+FLNTxEqLmy/nA+01OWus8cNp3YAr9
         VE8GeUwvrgh1z77XDmzVWcu1c4E9IvXQ4r45YRbItmRMNYpjo50nugTJkxgGJukF1lrb
         zpcnBHbtgvXRJNo3lT4/rG9O+WoD4fmSfBrhukGiGR537yH4AcLlzSrfQdWUBxxX5Dm9
         Av1p22SOBA4TyWbumUzugY1D43V8v2JwvZWrEU/EThe6Kuu2QxHaivw0VjwiJUeAzUJ3
         qsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g2OctTVip+vhQfZMynnuLwKCHVgBzQWnQ+tuo7kQZa4=;
        b=beCds89GkUJhfUjCFUyv2d2aEVN50Ee7tvl+uilNkn0vC/jfWbqcqrSOybj7amxTK8
         xx6NhapFnqZh8as5/T1sW70jIS4afifSoOgQfw4OAyqwVuDeh9Xao7XE2aXNYpCFIrmy
         Usv+QPTVxS0JoOOk6YdwxxcsykTO6zr4BK5QtiDe91/ytAkkLHPlaNED4Sc2n2xMlYy4
         BgKJ8Qh2NTx2L8nIO23129010YCIcJ7ECBkPEA5N5tfHOdj675MGuQklPZTbM+8cc36a
         NfAxg+tXCFf0/EIB52FwIAvAQMizh/aZBdrCCmWnq03OzJDRa4wCjtfpV9mVyKNzZ2oh
         OgPA==
X-Gm-Message-State: AHQUAuYLi0OACbaEesQN89IvwsyHwhF6rJ6Ry2IIDbJP6UpljLJ+J7A7
        JsSSlhhJL3i1qh3/2K2ljizUqPzQr1ogN4f6l+Me7HPYf69r6kwD66C8EgrbP3uoDSN1lL3Bw4B
        NCU63TXUxKsuVZ7iNg6fzGNI+CnYgmD3Y9byBI6+tiQJ6tPXc9lwETEWsfFqNAXXlhY4KhawU8x
        bi
X-Google-Smtp-Source: AHgI3IZZukR3tGWRy0IXU8SrzzsYudRINXRdBy+uWdkZof+vUUjrozV7LcVTKT47dU4QZLNnyKN7AFT7X8axL0FYRCSk
X-Received: by 2002:a0c:95cd:: with SMTP id t13mr280024qvt.14.1550780689687;
 Thu, 21 Feb 2019 12:24:49 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:24:38 -0800
In-Reply-To: <cover.1550780213.git.jonathantanmy@google.com>
Message-Id: <23d2414994e8ca2559940ccd43df0e2b2ceb712b.1550780213.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com> <cover.1550780213.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 2/5] remote-curl: reduce scope of rpc_state.stdin_preamble
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
index 8b7baf6298..d33d5bbfa8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -505,7 +505,6 @@ static void output_refs(struct ref *refs)
 
 struct rpc_state {
 	const char *service_name;
-	struct strbuf *stdin_preamble;
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
@@ -829,11 +828,10 @@ static int post_rpc(struct rpc_state *rpc)
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
 
@@ -843,8 +841,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.argv = client_argv;
 	if (start_command(&client))
 		exit(1);
-	if (preamble)
-		write_or_die(client.in, preamble->buf, preamble->len);
+	write_or_die(client.in, preamble->buf, preamble->len);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -978,10 +975,9 @@ static int fetch_git(struct discovery *heads,
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-upload-pack",
-	rpc.stdin_preamble = &preamble;
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads, args.argv);
+	err = rpc_service(&rpc, heads, args.argv, &preamble);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
@@ -1111,9 +1107,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
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

