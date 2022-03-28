Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E04C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbiC1TNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC1TNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:13:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A419766AFD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x186-20020a627cc3000000b004fa939658c5so8921455pfc.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RRRNOeWCzRnmh+kYHqpNKr2pf5a0v9m/RNnrhzP1c0o=;
        b=nnk2rE8dc9OgTB0VQ2OMtwvjfSorAmKB/jXU7lrFnLVI77XsdPoaAIbrJdu/adFuGP
         NJ3bGYDWRpeQHVXOTMD5PcvLsU66pmgwp1wuSJ2HZUFrDKSDpZcuiXlqi/2GysURylca
         28l6tmQ02TiMhX4CsaI6MAm6aZljKGVSNStIsnZXUxIoqw5r5IkiV6hudDZptry7TNHh
         jKxqFy+QyuE4IBM8qZ06w4Du/twGeD2ApzLHiZBr5AzM7hi/zt33qzu943RL8AWefgO8
         OCDEiybKHN/gisX7F1h5f8HzDDCqPgw3n1AwIgg4zvLyFjXu6r46UDZ2ALh7Oe9XvP0p
         4sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RRRNOeWCzRnmh+kYHqpNKr2pf5a0v9m/RNnrhzP1c0o=;
        b=j6dukliUJ8q38QD/fmhGNbAlZ4zCyAIm9T7kIJl9rXx4cqjiVTSLgHxh6tKqyud9HT
         4xn19h54SUh7gXZYzZ/MbTZGVMY7rDkgF+cHckfz4RXhPUkFnXRdoJ0I4uy5CcRHJB2X
         V6VbzwV2g4FCc5ApgIRm0uDCRlgaGIARD8dU6odbJf0TMfGMBhmRNUp3XZDWQCG2t42i
         K36kCnJ7bIaLQ4ztU5nKqs3P4JV8dzGuXwBQ3RK4yiZ9WHHqFA6P6i63rDj7AAxERCvK
         +sNRlqUFlYarF/OtxZXwBXSGvJjjNYXGX+jYn4NRtu+ZTJIysMM7oAST12SpfE5bq5lj
         Sm4A==
X-Gm-Message-State: AOAM5322/9EoMRgqNNCO0dTlLyE5syGN7rmF6mHHB3x3Ufg7fye/Rwkh
        K67IUVqw6Q8TES8ggdCFsLLcGdnFwt4ShzCEOnqe83g1He/A2KUtJbXoYS4tIKCLU7YRr16Cqrg
        sbkDa+1JD1KMHApli4H6+98UqyXusoWZ3ZF470SYyNFWtn/yxoOi7d7/paR7L6z8OFA==
X-Google-Smtp-Source: ABdhPJygirnw9uvjoq1EOImfyZp3CDzcTqV2XA5iCC57gJU9Vgq2bhjCWbW3m457rTIqy43xv3X9EAtoVB4g+Qw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:a56:b0:1c7:327d:9ac with SMTP id
 gw22-20020a17090b0a5600b001c7327d09acmr661237pjb.108.1648494707064; Mon, 28
 Mar 2022 12:11:47 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:11:10 +0000
In-Reply-To: <20220328191112.3092139-1-calvinwan@google.com>
Message-Id: <20220328191112.3092139-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [PATCH v3 1/3] fetch-pack: refactor packet writing and fetch options
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need to write capabilities for another
command, so refactor write_fetch_command_and_capabilities() to be able
to used by both fetch and future command.

Move fetch options set in `FETCH_CHECK_LOCAL` from the fetch state
machine to above the state machine so it is set by default. The
initial state of the state machine is always `FETCH_CHECK_LOCAL` so
this does not affect any current functionality. This change prepares
for a subsequent commit that doesn't need to check the local state, but
still requires those options to be set before sending the fetch request.

---
 fetch-pack.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 87657907e7..b709a61baf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1237,13 +1237,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
+static void write_command_and_capabilities(struct strbuf *req_buf,
+						 const struct string_list *server_options, const char* command)
 {
 	const char *hash_name;
 
-	if (server_supports_v2("fetch", 1))
-		packet_buf_write(req_buf, "command=fetch");
+	if (server_supports_v2(command, 1))
+		packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id", 0))
@@ -1279,7 +1279,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -1598,18 +1598,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
@@ -2060,7 +2060,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 		int received_ready = 0;
 
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, server_options, "fetch");
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.33.0.664.g0785eb7698

