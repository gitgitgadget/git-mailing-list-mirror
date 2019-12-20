Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3100C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8AD206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlq82HI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLTRJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40009 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTRJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id b8so8931988edx.7
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbz/M1G+Dovu//rMHWIDkWAtQWzxcUarJfEHZJZENho=;
        b=qlq82HI8CrQCiyW9d/YntpGvANg2/ta82+iyPNJkeJcSzl/86MSZq08P1IkkHfhLCZ
         XmRrp/H8sMN440U2bHhnjCHqL2cbbzTe6OEOjMn/jzsNBEZwhOxkSqzMGIJu0S69NbQE
         uA5KZD8AatAHF5cHtn+2PoeCV57yiUMMMXPWEePpVXra4nZ2BZBen3HUK5j8F0mGS8Rn
         nbJ96BQQjGmVHz6SgUdIzjbacFqaKrowG2+y8Xyf12gV7HITuU1hPZavML5R1FzYJRv6
         f2ScuMBWsWiRZ7fe+gNGQO/yz6MezXc8UBcGj55BiAh/762w32OhUOqcbLc8sJrMfMHo
         E4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbz/M1G+Dovu//rMHWIDkWAtQWzxcUarJfEHZJZENho=;
        b=jZf6z8oAbBbpb0zBlZTz4CXkwht+tWGB60HL+v05/QoGHDtHZFFpbqfPMETZPl/w8s
         Aw2ouZ2Q4MaTZhuZGJ2S6OXLn0xq4HmJeSUW1A9rT8Ppwhmx99MsEPNqfiX+WM62F6aQ
         SxhlZAL53cNr6Bt0WcCKXgFzM6r6B7PWoszuoymOOs/wMllgYz7NNqhdEijyMP5UcnSD
         ecVeRY/n4sU0X2uFLAt1eIS2mbj/xx1ROr2PIdQOB1hp84akxPNmACh8WvIlX6xx0XQp
         KRm0a+svFcYOEtlkvU2iUjP4GFonbrI2eSauFemHvWLjd2dexbOLzod9fAUAppF8WGaZ
         zAig==
X-Gm-Message-State: APjAAAUfdFsC4nZcKsCKuIWV/afy9f0OTEmdiaTOOV/Kk9k8++oy94Ou
        N52RELGvnb0qoBGBQK9BwZI58IkB
X-Google-Smtp-Source: APXvYqwTefvzla67MvY5Jvoee/47TonBUBEJ9xnMSqohRXRSmdVqmQv94sx+zlk19jI24+jmLGiQfw==
X-Received: by 2002:a17:906:86d7:: with SMTP id j23mr17238478ejy.89.1576861791996;
        Fri, 20 Dec 2019 09:09:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm1017682edw.80.2019.12.20.09.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:51 -0800 (PST)
Message-Id: <b99feebae111814be75dd99b5547539f8a764339.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:36 +0000
Subject: [PATCH 03/15] rebase, sequencer: remove the broken GIT_QUIET handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The GIT_QUIET environment variable was used to signal the non-am
backends that the rebase should perform quietly.  The preserve-merges
backend does not make use of the quiet flag anywhere (other than to
write out its state whenever it writes state), and this mechanism was
broken in the conversion from shell to C.  Since this environment
variable was specifically designed for scripts and the only backend that
would still use it is no longer a script, just gut this code.

A subsequent commit will fix --quiet for the interactive/merge backend
in a different way.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 6 ++----
 sequencer.c      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 96db10eaed..c71d169688 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -718,8 +718,8 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
 	write_file(state_dir_path("orig-head", opts), "%s",
 		   oid_to_hex(&opts->orig_head));
-	write_file(state_dir_path("quiet", opts), "%s",
-		   opts->flags & REBASE_NO_QUIET ? "" : "t");
+	if (!(opts->flags & REBASE_NO_QUIET))
+		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
 		write_file(state_dir_path("verbose", opts), "%s", "");
 	if (opts->strategy)
@@ -1178,8 +1178,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	add_var(&script_snippet, "GIT_QUIET",
-		opts->flags & REBASE_NO_QUIET ? "" : "t");
 	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
 	add_var(&script_snippet, "git_am_opt", buf.buf);
 	strbuf_release(&buf);
diff --git a/sequencer.c b/sequencer.c
index d2c11f34b7..71062212a5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2688,8 +2688,6 @@ static void write_strategy_opts(struct replay_opts *opts)
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const char *orig_head)
 {
-	const char *quiet = getenv("GIT_QUIET");
-
 	if (head_name)
 		write_file(rebase_path_head_name(), "%s\n", head_name);
 	if (onto)
@@ -2698,8 +2696,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 	if (orig_head)
 		write_file(rebase_path_orig_head(), "%s\n", orig_head);
 
-	if (quiet)
-		write_file(rebase_path_quiet(), "%s\n", quiet);
+	if (opts->quiet)
+		write_file(rebase_path_quiet(), "%s", "");
 	if (opts->verbose)
 		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
-- 
gitgitgadget

