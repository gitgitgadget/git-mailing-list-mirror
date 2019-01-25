Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8FD1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAYWA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:00:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34150 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:00:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so6322395qke.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfVWv3H54/L5n9Tyh02QacG9xhkXs7boLdeqN1jMxF4=;
        b=XL/D9VG64JT68ubma5tLsl3CbzZj7vCCFKHPNOkNpOpO8K2pILE3dX2NYekd/1skeM
         ak3vNt/ANMdOyCX6cNJ6l3aYvka6zKb0vp9HhJLzlHzz9ZowQIXYxDfn2ChGPgGTZbjT
         VT5eKMG6Za7sGVhqlGjBmNJo4eD0WnPtgP/ePUJdW7Q9Q1/w+6Amz7khvHfLMHAkU11h
         2IGdH3cCDJIUwUUeyCqSB3nKq3UBEbU5k5L7yhMSOVO0DkUw34edya9Uuqv0VNWZp1Su
         2kQeM+rPfM4riNbnJ11TwDhB/yfnYCtmVf6wrA+WA2f1VOdnIS7lckZos29Ac8dDxvPR
         FMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dfVWv3H54/L5n9Tyh02QacG9xhkXs7boLdeqN1jMxF4=;
        b=GqUje56Osnj/54kuOfOhRscgom9jszBVp0ALhBkfJqLRcuQsGJbpReUqKR7hsvR2Q8
         hU6RLzRDVxyXmTdbAcjiPecYCZhnz/YMzNmQD1jrxD7Y68N7AJhW3+2+igQe/cOGGRU0
         uaTp8jBKslFifdqmCCwfgsUmeBFEhK0qNx7KyLhM7qnX+Q8r0jX+O8gW7zX7FOWBSTqZ
         w0QdrIvpzKwGdA7CSR3c3yke8RrqgMByCF86jZI9RIR/db36v1ebFXjO6dt7+tGvKPVe
         I6CDyIb8IoGsIWdMnUyOnWyxUj/+lHZJpUsD/BmK1QZDH2TMD4KCCduTs/Y/GgEJlie+
         zXrA==
X-Gm-Message-State: AJcUukentckR6K9VXTD+69s9/cckGe7+03FOY50D2V4XSEys/a6bfjpa
        OoVtoouhR58ks7DtABXcasFLEwhD
X-Google-Smtp-Source: ALg8bN51vOlEX0k9DX7B+6rvsze2uqi+WZHulpQCFinivHFk5lawjA8oGQAkZUDPxncj2qyMpN6ZFg==
X-Received: by 2002:a37:c304:: with SMTP id a4mr11387216qkj.269.1548453657341;
        Fri, 25 Jan 2019 14:00:57 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id z8sm55898744qto.45.2019.01.25.14.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:00:56 -0800 (PST)
Received: (nullmailer pid 30176 invoked by uid 1000);
        Fri, 25 Jan 2019 22:00:55 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v2 1/2] config: allow giving separate author and committer idents
Date:   Fri, 25 Jan 2019 15:59:54 -0600
Message-Id: <20190125215955.30032-2-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190125215955.30032-1-williamh@gentoo.org>
References: <20190125215955.30032-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The author.email, author.name, committer.email and committer.name
settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
environment variables, but for the git config system. This allows them
to be set separately for each repository.

Git supports setting different authorship and committer
information with environment variables. However, environment variables
are set in the shell, so if different authorship and committer
information is needed for different repositories an external tool is
required.

This adds support to git config for author.email, author.name,
committer.email and committer.name  settings so this information
can be set per repository.

Also, it generalizes the fmt_ident function so it can handle author vs
committer identification.

Signed-off-by: William Hubbs <williamh@gentoo.org>
---
 Documentation/config/user.txt | 31 +++++++++++++-
 blame.c                       |  3 +-
 builtin/am.c                  |  2 +-
 builtin/commit.c              |  3 +-
 cache.h                       | 13 +++++-
 config.c                      |  6 +++
 ident.c                       | 81 +++++++++++++++++++++++++++++++++--
 log-tree.c                    |  3 +-
 sequencer.c                   |  5 +--
 9 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index b5b2ba1199..18e1ec3c1b 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -1,12 +1,39 @@
+author.email::
+	The email address used for the author of newly
+	created commits.  Defaults to the value of the
+	`GIT_AUTHOR_EMAIL` environment variable, or if
+	the environment variable is not set, the `user.email`
+	configuration variable.
+
+author.name::
+	The full name used for the author of newly created commits.
+	Defaults to the value of the `GIT_AUTHOR_NAME` environment variable, or
+	if the environment variable is not set,
+	the `user.email` configuration variable.
+
+committer.email::
+	The email address used for the committer of newly created commits.
+	Defaults to the value of the `GIT_COMMITTER_EMAIL` environment
+	variable, or if the environment variable is not set, the `user.email`
+	configuration variable.
+
+committer.name::
+	The full name used for the committer of newly created commits.
+	Defaults to the value of the `GIT_COMMITTER_NAME` environment
+	variable, or if the environment variable is not set, the `user.name`
+	configuration variable.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
-	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
+	`EMAIL` environment variables or the `author.email` or
+	`committer.email` settings discussed above. See linkgit:git-commit-tree[1].
 
 user.name::
 	Your full name to be recorded in any newly created commits.
 	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
-	environment variables.  See linkgit:git-commit-tree[1].
+	environment variables or the `author.name` or `committer.name`
+	settings discussed above. See linkgit:git-commit-tree[1].
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/blame.c b/blame.c
index 43861437f7..c9c351eb36 100644
--- a/blame.c
+++ b/blame.c
@@ -204,7 +204,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 	origin = make_origin(commit, path);
 
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet",
+			WANT_BLANK_IDENT, NULL, 0);
 	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
 	for (parent = commit->parents; parent; parent = parent->next)
 		strbuf_addf(&msg, "parent %s\n",
diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..53fdd22c45 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-			state->ignore_date ? NULL : state->author_date,
+			WANT_AUTHOR_IDENT, state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
 	if (state->committer_date_is_author_date)
diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..f96b90daeb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -607,7 +607,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
+	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+				IDENT_STRICT));
 	assert_split_ident(&author, author_ident);
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/cache.h b/cache.h
index 49713cc5a5..f13c6e244f 100644
--- a/cache.h
+++ b/cache.h
@@ -1479,10 +1479,19 @@ int date_overflows(timestamp_t date);
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
+
+enum want_ident {
+	WANT_BLANK_IDENT,
+	WANT_AUTHOR_IDENT,
+	WANT_COMMITTER_IDENT,
+};
+
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
-extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
-extern const char *fmt_name(const char *name, const char *email);
+extern const char *fmt_ident(const char *name, const char *email,
+		enum want_ident whose_ident,
+		const char *date_str, int);
+extern const char *fmt_name(enum want_ident);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
diff --git a/config.c b/config.c
index ff521eb27a..4bd5920dea 100644
--- a/config.c
+++ b/config.c
@@ -1484,6 +1484,12 @@ int git_default_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "author."))
+		return git_ident_config(var, value, cb);
+
+	if (starts_with(var, "committer."))
+		return git_ident_config(var, value, cb);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/ident.c b/ident.c
index 33bcf40644..a1e774c3e5 100644
--- a/ident.c
+++ b/ident.c
@@ -11,6 +11,10 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
+static struct strbuf git_author_name = STRBUF_INIT;
+static struct strbuf git_author_email = STRBUF_INIT;
+static struct strbuf git_committer_name = STRBUF_INIT;
+static struct strbuf git_committer_email = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
@@ -355,13 +359,19 @@ N_("\n"
    "\n");
 
 const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int flag)
+		      enum want_ident whose_ident, const char *date_str, int flag)
 {
 	static struct strbuf ident = STRBUF_INIT;
 	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
+	if (!email) {
+		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
+			email = git_author_email.buf;
+		else if (whose_ident == WANT_COMMITTER_IDENT && git_committer_email.len)
+			email = git_committer_email.buf;
+	}
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
@@ -377,6 +387,13 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (want_name) {
 		int using_default = 0;
+		if (!name) {
+			if (whose_ident == WANT_AUTHOR_IDENT && git_author_name.len)
+				name = git_author_name.buf;
+			else if (whose_ident == WANT_COMMITTER_IDENT &&
+					git_committer_name.len)
+				name = git_committer_name.buf;
+		}
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
@@ -425,9 +442,25 @@ const char *fmt_ident(const char *name, const char *email,
 	return ident.buf;
 }
 
-const char *fmt_name(const char *name, const char *email)
+const char *fmt_name(enum want_ident whose_ident)
 {
-	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
+	char *name = NULL;
+	char *email = NULL;
+
+	switch (whose_ident) {
+	case WANT_BLANK_IDENT:
+		break;
+	case WANT_AUTHOR_IDENT:
+		name = getenv("GIT_AUTHOR_NAME");
+		email = getenv("GIT_AUTHOR_EMAIL");
+		break;
+	case WANT_COMMITTER_IDENT:
+		name = getenv("GIT_COMMITTER_NAME");
+		email = getenv("GIT_COMMITTER_EMAIL");
+		break;
+	}
+	return fmt_ident(name, email, whose_ident, NULL,
+			IDENT_STRICT | IDENT_NO_DATE);
 }
 
 const char *git_author_info(int flag)
@@ -438,6 +471,7 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
+			 WANT_AUTHOR_IDENT,
 			 getenv("GIT_AUTHOR_DATE"),
 			 flag);
 }
@@ -450,6 +484,7 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
+			 WANT_COMMITTER_IDENT,
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
@@ -480,6 +515,46 @@ int git_ident_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "author.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_name);
+		strbuf_addstr(&git_author_name, value);
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "author.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_email);
+		strbuf_addstr(&git_author_email, value);
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_name);
+		strbuf_addstr(&git_committer_name, value);
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_email);
+		strbuf_addstr(&git_committer_email, value);
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/log-tree.c b/log-tree.c
index 10680c139e..43ef4f4300 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -687,8 +687,7 @@ void show_log(struct rev_info *opt)
 	 */
 	if (ctx.need_8bit_cte >= 0 && opt->add_signoff)
 		ctx.need_8bit_cte =
-			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
-					       getenv("GIT_COMMITTER_EMAIL")));
+			has_non_ascii(fmt_name(WANT_COMMITTER_IDENT));
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
diff --git a/sequencer.c b/sequencer.c
index f5370f4965..3505d52bb9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -836,7 +836,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(name, email, date, 0));
+	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date, 0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
 	free(name);
@@ -4087,8 +4087,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
 	strbuf_addch(&sob, '\n');
 
 	if (!ignore_footer)
-- 
2.19.2

