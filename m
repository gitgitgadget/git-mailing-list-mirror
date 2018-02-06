Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8CD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBFAb3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:29 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45708 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeBFAb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:27 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so129257plo.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAzxhRR94C0T5z6RSwPVNMCufyflc6n1Dmkvq2gNvXo=;
        b=nrYkl9XnT3xsTe78fxWHPI6++JAhO6n/G8LkvHBkT4XT4MWb09Kn0+S2iFmrh7odsy
         VdO421Gk21uQbAVkTD7slBVzbrUGRuNd4uDLNBMZ0vuTiTjG3fCIpJUpCEDKL0j9Sj/O
         tzW64lF/VqViI7ssPhl3NQjBHuMDQn7sKOwOxkW4e9VZa39z2zqh3U+GsXN9+RxCxzEy
         zFC8Myv6bO92cYw9E5gWr2SsysNyKgj1l0D5b5P68Z2Y+1uW7RAtxiBjaF0TLOknmV0Q
         mxABikQd6rJg3y3KN/f4gXk1u3sjm+jdALf4eUAm3lgFJtopfW2NCdI2sFoyULSS4+bk
         0ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAzxhRR94C0T5z6RSwPVNMCufyflc6n1Dmkvq2gNvXo=;
        b=bY6eEeqOhSXF1w2Fj/RhsulUag+ZVdPCce6kWLaD3OB60oEOpJr96LIhnXIXg24+4Z
         ZobGHxJw1Fv6U3yjtb3Lhi9IQPPpxeBlu5vNbNYRkUhv3wFEUb838xypcfTRVFO68stF
         Q2hRtSQ+vu5v17p2K9eP1FyDDMRmHPIElsU7FmgmZbaTdHdniPezHDG2KfDUtviXZij1
         0GQx4H4DDGvFSxqVkIw74M1uCB/Bsz9Ik0COVXnwZpvrJ4bnXds/hQy5a/hs0Oc4SA9w
         t+vT/nrMjoNk0oDjBll3jg0ERdcpVgUrm/P7nnpRFJZUoiIzMl2dccxPje+s9xu9i7QK
         gL1w==
X-Gm-Message-State: APf1xPD4sAKCeU3epLOdzim1z2GISAkybXal4EKdSI/5LdTtA+HOUAWI
        0BGjjxwSMErEkIVUWjuRAfhYeRMX+Bc=
X-Google-Smtp-Source: AH8x225B4nYW0FJERUmlAHW0gPiGEpN1kZfBhd+wVTLoqIuygBCcckBbNUqJST4uO4DDQXwRRJjwQg==
X-Received: by 2002:a17:902:32a2:: with SMTP id z31-v6mr559715plb.345.1517877086625;
        Mon, 05 Feb 2018 16:31:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e82sm13315688pfh.53.2018.02.05.16.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 183/194] commit: add repository argument to logmsg_reencode
Date:   Mon,  5 Feb 2018 16:17:38 -0800
Message-Id: <20180206001749.218943-85-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c                               | 3 ++-
 builtin/blame.c                            | 2 +-
 builtin/commit.c                           | 2 +-
 builtin/reset.c                            | 3 ++-
 commit.h                                   | 3 ++-
 contrib/coccinelle/submodule_reading.cocci | 9 +++++++++
 pretty.c                                   | 7 ++++---
 revision.c                                 | 2 +-
 sequencer.c                                | 3 ++-
 9 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7072ec78cb..9bbf41912b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1328,7 +1328,8 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	size_t ident_len;
 	struct ident_split id;
 
-	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+	buffer = logmsg_reencode(the_repository, commit, NULL,
+				 get_commit_output_encoding());
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 956df42c67..f9c18f6413 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -186,7 +186,7 @@ static void get_commit_info(struct commit *commit,
 	commit_info_init(ret);
 
 	encoding = get_log_output_encoding();
-	message = logmsg_reencode(commit, NULL, encoding);
+	message = logmsg_reencode(the_repository, commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
diff --git a/builtin/commit.c b/builtin/commit.c
index cceb965569..c903893767 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1113,7 +1113,7 @@ static const char *read_commit_message(const char *name)
 	if (!commit)
 		die(_("could not lookup commit %s"), name);
 	out_enc = get_commit_output_encoding();
-	return logmsg_reencode(commit, NULL, out_enc);
+	return logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index 7c57309adc..ef16cbea0d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -111,7 +111,8 @@ static void print_new_head_line(struct commit *commit)
 
 	hex = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
-	msg = logmsg_reencode(commit, NULL, get_log_output_encoding());
+	msg = logmsg_reencode(the_repository, commit, NULL,
+			      get_log_output_encoding());
 	body = strstr(msg, "\n\n");
 	if (body) {
 		const char *eol;
diff --git a/commit.h b/commit.h
index b9eb079e21..33f7779602 100644
--- a/commit.h
+++ b/commit.h
@@ -130,7 +130,8 @@ void free_commit_list(struct commit_list *list);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 extern int has_non_ascii(const char *text);
-extern const char *logmsg_reencode(const struct commit *commit,
+#define logmsg_reencode(r, c, e, o) logmsg_reencode_##r(c, e ,o)
+extern const char *logmsg_reencode_the_repository(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
 extern const char *skip_blank_lines(const char *msg);
diff --git a/contrib/coccinelle/submodule_reading.cocci b/contrib/coccinelle/submodule_reading.cocci
index 17c2e02512..b3e3d88626 100644
--- a/contrib/coccinelle/submodule_reading.cocci
+++ b/contrib/coccinelle/submodule_reading.cocci
@@ -5,3 +5,12 @@ expression F;
  get_commit_buffer(
 +the_repository,
  E, F)
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+ logmsg_reencode(
++the_repository,
+ E, F, G)
diff --git a/pretty.c b/pretty.c
index c5a2f0b018..a0c95280f6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,7 +595,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-const char *logmsg_reencode(const struct commit *commit,
+const char *logmsg_reencode_the_repository(const struct commit *commit,
 			    char **commit_encoding,
 			    const char *output_encoding)
 {
@@ -1519,7 +1519,7 @@ void format_commit_message(const struct commit *commit,
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
 	 */
-	context.message = logmsg_reencode(commit,
+	context.message = logmsg_reencode(the_repository, commit,
 					  &context.commit_encoding,
 					  utf8);
 
@@ -1801,7 +1801,8 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	}
 
 	encoding = get_log_output_encoding();
-	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
+	msg = reencoded = logmsg_reencode(the_repository, commit, NULL,
+					  encoding);
 
 	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
 		indent = 0;
diff --git a/revision.c b/revision.c
index c5d376ba0a..427ccb1fe1 100644
--- a/revision.c
+++ b/revision.c
@@ -3002,7 +3002,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * in it.
 	 */
 	encoding = get_log_output_encoding();
-	message = logmsg_reencode(commit, NULL, encoding);
+	message = logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
 	if (buf.len)
diff --git a/sequencer.c b/sequencer.c
index 40ba4b6047..57b9ddb69b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -243,7 +243,8 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	const char *abbrev, *subject;
 	int subject_len;
 
-	out->message = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+	out->message = logmsg_reencode(the_repository, commit, NULL,
+				       get_commit_output_encoding());
 	abbrev = short_commit_name(commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
-- 
2.15.1.433.g936d1b9894.dirty

