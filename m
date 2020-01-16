Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF1C35242
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E4A20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL8xAQHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgAPGOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38744 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgAPGOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so2453332wmc.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uhvq/tRiZUZZT7d8LySc39EPQy3kuTme2ovgjshC0Bs=;
        b=AL8xAQHKm4ZFUCvbJLhPF0PUd+vNwqg51gmGObnC1E8VxFE2Jv6yneRRA9oAf665yL
         vWcszCJrXFEy5RSw0NW6dnjersTFSyaPhZWH05ThUZvdg9hsqCbt5Er0Jdc9ixkiICWU
         ttAKlyaRPkjvCpziBmqmn9H4mjCJxb9WlodATmnDgbSQtiJ1kPz2vYOujvDInlzH6YgC
         kSGlSmY00WcnzjA4fftqeXtK2TFbt3RgCOKaFvvqk2uacZ7Pd1dnHzwJ+sPpgiAolnZY
         6Epnj9TzlF1vEXwI+k3BWyl7qT/1FiQ89MoWnwbjEgBVkhd+2+wbxF+3iUFfSehVPAmn
         OyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uhvq/tRiZUZZT7d8LySc39EPQy3kuTme2ovgjshC0Bs=;
        b=ENs6JrubyBhru+hl0DOvoPbOkM/x9RtdIo7caCNf+WJl7puKv415jUltwYqN7lKs2L
         granJy9KWcvOBM8kFZqMf5r1R2OrgDHXCvI4mp27mRF3I2WznM1b/U8kWe6P6dWAxY5k
         IMtDS7oyUcCDChUqn9bO8loTUsprTzN7TZFwMWIPspzR8pGmcSCIBuLTdqL1uLA1Ytca
         8FjMIAXGe+6nbK8WtZlaxu9uo3CL1FILBifZL6CydrHFTeQXV3Pn0NhG+1MQFWiSgWtD
         8uVyMhAv7PBcApVHj2tPkvKOloc4GmSKhBnS35at018jnQ2mT0ibRbK3WxnkOx50D6KZ
         RHFw==
X-Gm-Message-State: APjAAAW6bnuNeurcynVVEwtELVdModyBG+rtH6zqmr5pbCXu4AqD0kus
        KTNTBSK1a8x8P5mFLxmwY1rwR67g
X-Google-Smtp-Source: APXvYqy1/OXcD6cTIixykP6rn1JDtdL491gR6qFtZv7sHVG7RoFtebToWDKm9lMZduwLlgQvmae9DA==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr4367946wmj.68.1579155280022;
        Wed, 15 Jan 2020 22:14:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm28345171wrv.34.2020.01.15.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:39 -0800 (PST)
Message-Id: <8d731fa39c3c51cf33e1e105e756d2bf34a8f9a7.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:20 +0000
Subject: [PATCH v4 06/19] rebase, sequencer: remove the broken GIT_QUIET
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
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
index c299869e7b..57875485df 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -699,8 +699,8 @@ static int rebase_write_basic_state(struct rebase_options *opts)
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
@@ -1153,8 +1153,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	add_var(&script_snippet, "GIT_QUIET",
-		opts->flags & REBASE_NO_QUIET ? "" : "t");
 	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
 	add_var(&script_snippet, "git_am_opt", buf.buf);
 	strbuf_release(&buf);
diff --git a/sequencer.c b/sequencer.c
index 354d0b5a38..078a68eaf3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2568,8 +2568,6 @@ static void write_strategy_opts(struct replay_opts *opts)
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const char *orig_head)
 {
-	const char *quiet = getenv("GIT_QUIET");
-
 	if (head_name)
 		write_file(rebase_path_head_name(), "%s\n", head_name);
 	if (onto)
@@ -2578,8 +2576,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
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

