Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC4DC3F68F
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006CB206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l44286LV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLXTzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42490 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXTzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so18671483edv.9
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FGi8Re5Xsr69EALhyOtGMpdb7t1ii+72BJ5qReN/2e0=;
        b=l44286LVuJcibLg/35xpG5g71N0khjQpB0KaKl7Zp9Uefcoy6R19Qxk2XbBIxEokV7
         +AP0GjI9LKdeHuVOfaAJXWURZhvfUp4bUjs0ceOCHofDIo5AuN2LIoSIYyf1FhM5sAtN
         6srccbnxnmo2Y6WELPiHu1t908Zh3odsnux725iQZVF2oNYtbX9dsbRX+sW099jQRc9X
         RieXGj0c+T07VIKL3hDssSA3Ooh+FzP+lmZBmIApbSoWd2s2Y4/k7kdtp/Q/ee9NAsjr
         A7v5bljFi+H4r2bYeMbue55I+KVNE+7nS2dQODL3Wx26OXG98rxAjTRUBDJCy47V77yQ
         3dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FGi8Re5Xsr69EALhyOtGMpdb7t1ii+72BJ5qReN/2e0=;
        b=BfCY42oQQ+3uqdFO0Sw2sgrxCJVyTXeRgbh+JRvq4hXN4LzVZnagK8fPqrY4lnpp7R
         rB1Fihh1Pz0m+OlVb711YkY7hxLfaggq6ibjwEAJUH/x3ea4a/PICuito3LCjGSU1Nu4
         G9Z07nZEkzK6WOa4aaW52LGpayERb+7WHjJlRgsUGTqohfaSbrqNTe5fxGsSCg0jokjU
         DgBsp8ZrdYuZjwJ7El7+zcPdsce+Nw8UVsOnT0KxaDxSEn88GuVtH7Qh902EVsrHbvT1
         Q3zh1a2UKfb1giV7DSYRN9xzsXM8puxwmfl9X6rSbbVAbXSojzefNcdwIU6/kXyKQusA
         0a/g==
X-Gm-Message-State: APjAAAXFbTwCnITL6ToFdYy0wTGbnzzgPJB00N6gu/76UAf+rdBfSWrf
        wNCd8Uss0Xq0KEaDkxY66Ld/wUT7
X-Google-Smtp-Source: APXvYqys9iNhw5rLDDwk44WlQshM3Lb2Fa8cQUXSImlwR8ze+wWTzysC3//SeXhMWpZuG3AMIZI5eQ==
X-Received: by 2002:a17:906:248f:: with SMTP id e15mr39179601ejb.141.1577217303423;
        Tue, 24 Dec 2019 11:55:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm1654267ejl.5.2019.12.24.11.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:03 -0800 (PST)
Message-Id: <49388b79fddc339f3a5df747406621ec5ad28789.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:47 +0000
Subject: [PATCH v3 03/15] rebase, sequencer: remove the broken GIT_QUIET
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

