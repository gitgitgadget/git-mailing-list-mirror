Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B285EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJLJDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJLJCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F2BBF1A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a10so25199968wrm.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glP9ttcAeVzVnqaJnd5Y05AI21fF9VTEm3TmGDMARtQ=;
        b=BbO6TVp/nhXn8BIzvcAgBBoyhOJ0755zfOofnHde0x6MbBJGTnL7YXOhp9q1On6FVE
         gDFRKi+ut+iN9wBL6ouLlDguAl+IOYfNqUETBCNmE10avQqqyuQPFFfhW3E8NtLlVgCx
         ql69KoM+0x3wp237LFU0p5T96OGoVdmFUoEsIvSpmD+5XcVoc/kNyCuU9FQdGOi5VvWi
         mn7b9y4GLWCee9pomwT4hW3WNXP95eruj06nhZO3IGpJ/MKEXIMXZnnP6nwisMawWLcJ
         6xjkpBzf2HZEjfFhcQDylgxn5/Dsib6RTHfAU8bB4SniC9Tz6TPesposgIBj3AgE7YU9
         JCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glP9ttcAeVzVnqaJnd5Y05AI21fF9VTEm3TmGDMARtQ=;
        b=4z53N5+xnTdhegv02ak3mdCIC9W/3hzHNh3xI9v9FoP2y/sLo7iUDnC5mvOo+IGrPk
         edQUsTgKVggggN0H1Hfpu1cFcQq9c+3ZlQFM5BLiJ0gIK60i4MVCvwGsYboN6jXKOOOE
         Cov8t2K21wTWXHY4lF1Rp8TtNw1Btse5YTpF+ZKKdk4PvYPPLccJnr1gr4wFaUW2WHQv
         mkHk79Zk0P0t02bGJ9uz6zEx7gRZaPwJloA8VFid89IdMf9ajvfKlpmiyJGDW6IQwAm+
         YOtx6NdR+s4Gwulhxkw+kNxIdSJKGq/nuKnbtAFS2ME6ma9dw0nC+OofNs3JzReTsbhQ
         ZIsw==
X-Gm-Message-State: ACrzQf2gnzVGMEyeVnS0JUqYvkMDtGUPzZnPFRrw3jhJ5ORLFo/SdTPW
        pfLadvXKY0Ap/9dDKl2qgvST4bndVaabtg==
X-Google-Smtp-Source: AMsMyM6wLR6pt8+mM7QOUj0zhBqYjnHHWFoKURchWHTpta8W4FbpQEELoz+id3h0EJXxl+hkPxNSTg==
X-Received: by 2002:adf:efc5:0:b0:22e:4a6:2d5b with SMTP id i5-20020adfefc5000000b0022e04a62d5bmr17880339wrp.293.1665565323857;
        Wed, 12 Oct 2022 02:02:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/22] run-command.c: don't copy "ungroup" to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 11:01:26 +0200
Message-Id: <patch-v2-18.22-17f34d81ecd-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the *_fn members removed in the preceding commit, let's not
copy the "ungroup" member of the "struct run_process_parallel_opts"
over to the "struct parallel_processes". Now that we're passing the
"opts" down there's no reason to do so.

This makes the code easier to follow, as we have a "const" attribute
on the "struct run_process_parallel_opts", but not "struct
parallel_processes". We do not alter the "ungroup" argument, so
storing it in the non-const structure would make this control flow
less obvious.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index 4fce1193b66..2b1cfbc996f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1513,7 +1513,6 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	const unsigned ungroup : 1;
 
 	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1550,7 +1549,7 @@ static void pp_init(struct parallel_processes *pp,
 		BUG("you need to specify a get_next_task function");
 
 	CALLOC_ARRAY(pp->children, n);
-	if (!pp->ungroup)
+	if (!opts->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
 
 	for (size_t i = 0; i < n; i++) {
@@ -1607,17 +1606,17 @@ static int pp_start_one(struct parallel_processes *pp,
 		BUG("bookkeeping is hard");
 
 	code = opts->get_next_task(&pp->children[i].process,
-				   pp->ungroup ? NULL : &pp->children[i].err,
+				   opts->ungroup ? NULL : &pp->children[i].err,
 				   pp->data,
 				   &pp->children[i].data);
 	if (!code) {
-		if (!pp->ungroup) {
+		if (!opts->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		}
 		return 1;
 	}
-	if (!pp->ungroup) {
+	if (!opts->ungroup) {
 		pp->children[i].process.err = -1;
 		pp->children[i].process.stdout_to_stderr = 1;
 	}
@@ -1625,14 +1624,14 @@ static int pp_start_one(struct parallel_processes *pp,
 
 	if (start_command(&pp->children[i].process)) {
 		if (opts->start_failure)
-			code = opts->start_failure(pp->ungroup ? NULL :
+			code = opts->start_failure(opts->ungroup ? NULL :
 						   &pp->children[i].err,
 						   pp->data,
 						   pp->children[i].data);
 		else
 			code = 0;
 
-		if (!pp->ungroup) {
+		if (!opts->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		}
@@ -1701,7 +1700,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		code = finish_command(&pp->children[i].process);
 
 		if (opts->task_finished)
-			code = opts->task_finished(code, pp->ungroup ? NULL :
+			code = opts->task_finished(code, opts->ungroup ? NULL :
 						   &pp->children[i].err, pp->data,
 						   pp->children[i].data);
 		else
@@ -1718,7 +1717,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		if (pp->ungroup) {
+		if (opts->ungroup) {
 			; /* no strbuf_*() work to do here */
 		} else if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1757,7 +1756,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		.max_processes = opts->processes,
 		.data = opts->data,
 		.buffered_output = STRBUF_INIT,
-		.ungroup = opts->ungroup,
 	};
 	/* options */
 	const char *tr2_category = opts->tr2_category;
-- 
2.38.0.971.ge79ff6d20e7

