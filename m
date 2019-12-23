Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6466C2D0D2
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E920643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHI6F5wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLWSuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45715 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWSuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so16083312edw.12
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FGi8Re5Xsr69EALhyOtGMpdb7t1ii+72BJ5qReN/2e0=;
        b=LHI6F5wqgsyQjaZZdRpAg+2hHQ1BdZky91zW5TKqzEaSwf2VERSM8yT5zOHFNl0ZE+
         7p76jGPjDJ+rVzv4o1GkzJXTVG+dXS4Vndj65b49J4IXaaBIX5lrrjU6jGqPLY1NRBlF
         PcSw4WhKfDqYR4fzgtljspx6FpqVl54dV8jEz+Tu5GpweVaX/eziJhwVDQioBw4VGLVT
         +N26930MvfS2lb1/ZB4GGfR+c+6GWb/NsI9oHwOa+nPQTAo88Jj/6f2wftVf5ldoC5jU
         KEHg2jMhjsO3i/3YOXxyEtH3236wMYdNVChO50S8538VoUljT83XrUg7QfHVZAhd8avD
         WplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FGi8Re5Xsr69EALhyOtGMpdb7t1ii+72BJ5qReN/2e0=;
        b=ZLyqVS+oTfLMs4IxMOkS6j0mBFhF4f++oQw9eS4tHJHayKwfJl1gTNE52ZO8tGcIyi
         YlQKipWa7SzLjL9oweHXXGqp9+URruRzG019EOZEA2ffXhaFemeKAYmt5rgs+tkESskr
         eOlE8MdVSOjtkqH3WRrimagaUS6DbN+4UK1kpIdrcNlhaZYMCAZycuCFeZyLpUp+Tjae
         ZRRyaMql/y1PGazCvQLPOt7tlKSUor5246luoEY2ByHxZukqAmifk6swcFezP5ObPhel
         DbBSH91W4c+IuDYBRMeY5kvp1hxaExqOXBAQz1J8uG2K7ARxT/FDl9vYwHvWDY22SjGK
         Ib1g==
X-Gm-Message-State: APjAAAUf7KoGx4KzA6cRqhICXkfke8jyzLMZkVbNV/WAG4QEDAgtMVbF
        1m3AeUqkrd79k/NLZcuaiskiCMIQ
X-Google-Smtp-Source: APXvYqwr2vzmnGDiUXKdrMSzk0W1Xj4IdBKInLX/4OiiKcARLkbW3rKFTlC8bxWucwiHm4U1I6ByuA==
X-Received: by 2002:a50:a2c7:: with SMTP id 65mr34127168edm.144.1577127003475;
        Mon, 23 Dec 2019 10:50:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm2392071eju.88.2019.12.23.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:03 -0800 (PST)
Message-Id: <49388b79fddc339f3a5df747406621ec5ad28789.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:47 +0000
Subject: [PATCH v2 03/15] rebase, sequencer: remove the broken GIT_QUIET
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
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
index 6903249307..32026a62e8 100644
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

