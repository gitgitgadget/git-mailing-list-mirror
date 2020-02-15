Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB96C71153
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E29217F4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZwt7oas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBOVhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgBOVg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so13509649wmj.5
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A76u3/uMzdTlCDHG/KGMZewRuJnIKOvXOS+Rj9GHhvg=;
        b=sZwt7oasvxxcWZkDbZWpw3E6nQR1yO2/sodCzybUMx2aLMCoHb01svc7biDsynlAxT
         /i1EgpB8s4RY/+z1sgyyqqnxJRkGcZ4z71Btz3Nf3I9rJjPDPg3blCVdUTYNAu9mjjBo
         EEwFbodB+Kh4w4pHkyepmCjI72mjV2wStVu1scrigttWtkYAfocnMJOwfI4K5DJ+ANg3
         Mwfu+EZGYWfy0ywjJEJ54UY6X3+IybUEk7VwI8yQ2b6fJuqIY8WPDtwwPUxQCYXT2swp
         Tatvnwaj4QSioORsj0N+0SErOhvrTqpxBEbDG7Y131B7x0C9tMFz8jRluP72CAVY0eM2
         yg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A76u3/uMzdTlCDHG/KGMZewRuJnIKOvXOS+Rj9GHhvg=;
        b=rsWjGJYUmUOCNFrsRy7Is8QRx+FrI0I+ZHm9U8fMKLZefBwgffI5/nUiqq6N4E9R2z
         KEcmtc2tclrK8OyA5ig7BHiKlqBzda3kpEyvyIJdI7VxuY2KytMAtie/RDLWQHiUXGNh
         FlBvcUrrHpiUWzDBxvwEEcS1T6BSUlFVfg8MET/iIVUB/iOCErHUkBNF8WqcqFAvL9+z
         A6Td+Ux2S992YUZT3xoyJpz61jsPGZP3GP3I9lC12eKJUKfZmC36hiYz1JO3MoguB1en
         qoJWTSbeq1TAMWWiGnJFpKNW9AP2+56W+akGoeY5UWPawfOM+5SOLUo9EyHw8Mp1PSUo
         heXw==
X-Gm-Message-State: APjAAAWa87maeSEEvD9+GzApbgQWtS/hvx3lt0o0eYfZeUEEVBt3JatV
        hHhONEk39I6RSUCU2EYuhPB+ohI6
X-Google-Smtp-Source: APXvYqyWZvWXuAId6Lki3bkVdNKzhK5FrGyc9XCRAya0GHrgBwRxUnOWVsbMilhEbhP6SCXEPygbtw==
X-Received: by 2002:a1c:9ad7:: with SMTP id c206mr12801244wme.140.1581802616689;
        Sat, 15 Feb 2020 13:36:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm12983008wrp.95.2020.02.15.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:56 -0800 (PST)
Message-Id: <ba1f2699b397985750cc32f638b438b27f6c2eaa.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:39 +0000
Subject: [PATCH v5 18/20] rebase: make the backend configurable via config
 setting
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/rebase.txt |  8 ++++++++
 builtin/rebase.c                | 31 ++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index d98e32d812e..e6ae30c9999 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -5,6 +5,14 @@ rebase.useBuiltin::
 	is always used. Setting this will emit a warning, to alert any
 	remaining users that setting this now does nothing.
 
+rebase.backend::
+	Default backend to use for rebasing.  Possible choices are
+	'am' or 'merge' (note that the merge backend is sometimes also
+	refered to as the interactive backend or the interactive
+	machinery elsewhere in the docs).  Also, in the future, if the
+	merge backend gains all remaining capabilities of the am
+	backend, this setting may become unused.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ffaa7935240..f0a862f41b5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -60,6 +60,7 @@ enum empty_type {
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
+	const char *default_backend;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
@@ -100,6 +101,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
+		.default_backend = "am",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1272,6 +1274,10 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.backend")) {
+		return git_config_string(&opts->default_backend, var, value);
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -1900,9 +1906,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
 				break;
 
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
+		if (i >= 0) {
+			if (is_interactive(&options))
+				die(_("cannot combine am options with either "
+				      "interactive or merge options"));
+			else
+				options.type = REBASE_AM;
+		}
+	}
+
+	if (options.type == REBASE_UNSPECIFIED) {
+		if (!strcmp(options.default_backend, "merge"))
+			options.type = REBASE_MERGE;
+		else if (!strcmp(options.default_backend, "am"))
+			options.type = REBASE_AM;
+		else
+			die(_("Unknown rebase backend: %s"),
+			    options.default_backend);
 	}
 
 	switch (options.type) {
@@ -1915,10 +1935,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.state_dir = apply_dir();
 		break;
 	default:
-		/* the default rebase backend is `--am` */
-		options.type = REBASE_AM;
-		options.state_dir = apply_dir();
-		break;
+		BUG("options.type was just set above; should be unreachable.");
 	}
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
-- 
gitgitgadget

