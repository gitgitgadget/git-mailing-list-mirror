Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C761F453
	for <e@80x24.org>; Thu,  1 Nov 2018 03:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKAMNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 08:13:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeKAMNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 08:13:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so18577008wre.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCVh5crGODg5dUTm6v90a57uYfbKyiduK6qlITM943o=;
        b=nXWTuPsizVijwTYlTom+/RVED78FPZBq5ojf1sicWNmE4zDRlrUUNsqaTuCHhcrPCX
         /kKmksu5YNAezgRvbkn1aZ+W1y7F7Pxvr2yOplBdw6zleatgrZyqWTbH0am8modWEEim
         SWxKJUMT/mCQZ+hOYaOTpmG8HVJtrwE4qN6BsDCNrPCbbDrf3kAjH1cLmfQ8AfyBr6kx
         KyVWhj3nA0yrvJMpqVMhyMWGyb5bn4Tmwg/xVP04ezmWA+psk4RrfLbJN+7WFx7Sk3VI
         cXReJxThigZ+xeO7h/7PYG7fUXfAM978kKqnh2ZrM5iVrCtcvSZaHVkrkfI69G+tzRhC
         NdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RCVh5crGODg5dUTm6v90a57uYfbKyiduK6qlITM943o=;
        b=f/H1bMPXx7FApiWB+wAXEkx80APFyumpHJ3aAUMONu+4isXUcNtI5wHDtwWVdYx+3u
         pZi6GOHjslcx+/EGn/Y4UdY8CeGmP1iiRbUQBJ4x7Lf+ONvdn4XcL11u5CSBxmIau2dY
         dUDbC57t34VdEVPoPXR122nf3WkGWqDEBFRHa4Oa3zBYF52bqJ32i5Yq4JnwhaRL85Ro
         Ymmr2EUoYR4nMOWXzpYgR9wVlrzofbONjUavTHLTPjctsDASR0HdeqSyqyTw/QRCg8NQ
         4G6Nw3PSDEUPNtZlU1V/5NJA1ZPXlvne1nh6iOtl8nSHZ9yGae0P8iTx7vz52jF0tJ/N
         liXQ==
X-Gm-Message-State: AGRZ1gI2nvRanK+W2R3Zjuh26G4wugSgAuRTYIhnucFkD3vOshQEo2tK
        Zse/2ssDhpe2akGfp8ogw8mSK0EVUKc=
X-Google-Smtp-Source: AJdET5dkQmMfHfYkelf77WMaIJmAKt/XxgTEVIxsV2bpuTIdBkmWbp6XRW+0csSFkBMqchLCz9UNyQ==
X-Received: by 2002:adf:94a3:: with SMTP id 32-v6mr4616554wrr.98.1541041969476;
        Wed, 31 Oct 2018 20:12:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n76-v6sm12600500wmd.47.2018.10.31.20.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 20:12:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4fixed 4/5] add read_author_script() to libgit
Date:   Thu,  1 Nov 2018 12:12:45 +0900
Message-Id: <20181101031245.185587-2-gitster@pobox.com>
X-Mailer: git-send-email 2.19.1-708-g4ede3d42df
In-Reply-To: <20181101031245.185587-1-gitster@pobox.com>
References: <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
 <20181101031245.185587-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add read_author_script() to sequencer.c based on the implementation in
builtin/am.c and update read_am_author_script() to use
read_author_script(). The sequencer code that reads the author script
will be updated in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c |  86 +----------------------------------------
 sequencer.c  | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h  |   3 ++
 3 files changed, 110 insertions(+), 84 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c78a745289..83685180e0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -260,36 +260,6 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 	die_errno(_("could not read '%s'"), am_path(state, file));
 }
 
-/**
- * Take a series of KEY='VALUE' lines where VALUE part is
- * sq-quoted, and append <KEY, VALUE> at the end of the string list
- */
-static int parse_key_value_squoted(char *buf, struct string_list *list)
-{
-	while (*buf) {
-		struct string_list_item *item;
-		char *np;
-		char *cp = strchr(buf, '=');
-		if (!cp) {
-			np = strchrnul(buf, '\n');
-			return error(_("unable to parse '%.*s'"),
-				     (int) (np - buf), buf);
-		}
-		np = strchrnul(cp, '\n');
-		*cp++ = '\0';
-		item = string_list_append(list, buf);
-
-		buf = np + (*np == '\n');
-		*np = '\0';
-		cp = sq_dequote(cp);
-		if (!cp)
-			return error(_("unable to dequote value of '%s'"),
-				     item->string);
-		item->util = xstrdup(cp);
-	}
-	return 0;
-}
-
 /**
  * Reads and parses the state directory's "author-script" file, and sets
  * state->author_name, state->author_email and state->author_date accordingly.
@@ -309,65 +279,13 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list kv = STRING_LIST_INIT_DUP;
-	int retval = -1; /* assume failure */
-	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
-	int fd;
 
 	assert(!state->author_name);
 	assert(!state->author_email);
 	assert(!state->author_date);
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		return error_errno(_("could not open '%s' for reading"),
-				   filename);
-	}
-	strbuf_read(&buf, fd, 0);
-	close(fd);
-	if (parse_key_value_squoted(buf.buf, &kv))
-		goto finish;
-
-	for (i = 0; i < kv.nr; i++) {
-		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
-			if (name_i != -2)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
-			else
-				name_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
-			if (email_i != -2)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
-			else
-				email_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
-			if (date_i != -2)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
-			else
-				date_i = i;
-		} else {
-			err = error(_("unknown variable '%s'"),
-				    kv.items[i].string);
-		}
-	}
-	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
-	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
-	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
-	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
-		goto finish;
-	state->author_name = kv.items[name_i].util;
-	state->author_email = kv.items[email_i].util;
-	state->author_date = kv.items[date_i].util;
-	retval = 0;
-finish:
-	string_list_clear(&kv, !!retval);
-	strbuf_release(&buf);
-	return retval;
+	return read_author_script(filename, &state->author_name,
+				  &state->author_email, &state->author_date, 1);
 }
 
 /**
diff --git a/sequencer.c b/sequencer.c
index 6387c9ee6e..bf84a4f8ea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -664,6 +664,111 @@ static int write_author_script(const char *message)
 	return res;
 }
 
+/**
+ * Take a series of KEY='VALUE' lines where VALUE part is
+ * sq-quoted, and append <KEY, VALUE> at the end of the string list
+ */
+static int parse_key_value_squoted(char *buf, struct string_list *list)
+{
+	while (*buf) {
+		struct string_list_item *item;
+		char *np;
+		char *cp = strchr(buf, '=');
+		if (!cp) {
+			np = strchrnul(buf, '\n');
+			return error(_("no key present in '%.*s'"),
+				     (int) (np - buf), buf);
+		}
+		np = strchrnul(cp, '\n');
+		*cp++ = '\0';
+		item = string_list_append(list, buf);
+
+		buf = np + (*np == '\n');
+		*np = '\0';
+		cp = sq_dequote(cp);
+		if (!cp)
+			return error(_("unable to dequote value of '%s'"),
+				     item->string);
+		item->util = xstrdup(cp);
+	}
+	return 0;
+}
+
+/**
+ * Reads and parses the state directory's "author-script" file, and sets name,
+ * email and date accordingly.
+ * Returns 0 on success, -1 if the file could not be parsed.
+ *
+ * The author script is of the format:
+ *
+ *	GIT_AUTHOR_NAME='$author_name'
+ *	GIT_AUTHOR_EMAIL='$author_email'
+ *	GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted. We are strict
+ * with our parsing, as the file was meant to be eval'd in the old
+ * git-am.sh/git-rebase--interactive.sh scripts, and thus if the file differs
+ * from what this function expects, it is better to bail out than to do
+ * something that the user does not expect.
+ */
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list kv = STRING_LIST_INIT_DUP;
+	int retval = -1; /* assume failure */
+	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
+
+	if (strbuf_read_file(&buf, path, 256) <= 0) {
+		strbuf_release(&buf);
+		if (errno == ENOENT && allow_missing)
+			return 0;
+		else
+			return error_errno(_("could not open '%s' for reading"),
+					   path);
+	}
+
+	if (parse_key_value_squoted(buf.buf, &kv))
+		goto finish;
+
+	for (i = 0; i < kv.nr; i++) {
+		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
+			if (name_i != -2)
+				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+			else
+				name_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
+			if (email_i != -2)
+				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+			else
+				email_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
+			if (date_i != -2)
+				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+			else
+				date_i = i;
+		} else {
+			err = error(_("unknown variable '%s'"),
+				    kv.items[i].string);
+		}
+	}
+	if (name_i == -2)
+		error(_("missing 'GIT_AUTHOR_NAME'"));
+	if (email_i == -2)
+		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+	if (date_i == -2)
+		error(_("missing 'GIT_AUTHOR_DATE'"));
+	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
+		goto finish;
+	*name = kv.items[name_i].util;
+	*email = kv.items[email_i].util;
+	*date = kv.items[date_i].util;
+	retval = 0;
+finish:
+	string_list_clear(&kv, !!retval);
+	strbuf_release(&buf);
+	return retval;
+}
 
 /*
  * write_author_script() used to fail to terminate the last line with a "'" and
diff --git a/sequencer.h b/sequencer.h
index c986bc8251..60f15a4d9c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -114,4 +114,7 @@ void commit_post_rewrite(const struct commit *current_head,
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
 			  unsigned int flags);
+
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing);
 #endif
-- 
2.19.1-708-g4ede3d42df

