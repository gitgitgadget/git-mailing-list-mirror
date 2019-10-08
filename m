Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5E51F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfJHSrt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:47:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43992 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id c4so14085716qtn.10
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QS5KRFlw+nPOu0HRH7qq5jVH5+eYA15Q0b6PvRuNIK0=;
        b=MK+r6Nm1bMw/JFinrENT1dA+a95AvWAljaQENqXenrElgSYo9vqD5cpZYCwlTfT6ce
         E+mbCTVG9+Ch9em0E5fvZufEZ5rgbuWFEet49PrHjWr4Etfd7krmhWyWOfSsgUuQkr23
         6L7bYnExE0HsjsWl4u7kWD4J0CIXGkTdQV+HKkQZy5jpgoa94coEQVM6K7z6+wU8+NeC
         Pc1ZxJGenykd0j+Q8CVdayd+0A7pVV0f2ecs0BiOkKPxfEWrtd76tJ0MY5SK9k7TNefd
         M9vRZJzrdYAkpbgjn06LVzXzh8loCW5TvhlXjBRHon9M2Afyk9Cn0E996fBAxojAslxc
         iRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QS5KRFlw+nPOu0HRH7qq5jVH5+eYA15Q0b6PvRuNIK0=;
        b=H1Z9IZeNNY7qnMXMay6VWz8ooyokPP096rt99VAQtn6D6JDrRvFTFk3P45+FQ2DFia
         1zGq4Euw5J0D9nhrd13Excwgj09bo+V9kNRuQ2mzQN2fK+812QhkE2N3Bm4Zivd1DIl7
         iQHECIQgD2qIJp8/EzjypTGiN4bfCOjsf5m/DtPdXt8bVnYLHWRSODmyHKBj/xrxqx7M
         ikAAtRxItswUi5QLdq3X1HexxtRbZlFlR7yK+XoyFi2iqkfJL6nLiPoN+n3v+CPdFoug
         vBzYrnA1qpEa65chP7+uId3KIn1oPtODlWs7I1PDzcDUfTmE1bDoZMIRJFJyP8oOg5aF
         skew==
X-Gm-Message-State: APjAAAWqZr36/FfO0FTKK4GeMqL7A2HxKRQ/aocolBSKwxYc7Ikqvgzn
        eKqMXFXpREg1IOptvp9ogESLZ5Ul
X-Google-Smtp-Source: APXvYqzY/Tn7Xt1eSxNpa9XS1G0ZZvqYSI3uLSg/sbIl3YriOP6g6NHv7c+gn6sQ7Y1km14zeuPBow==
X-Received: by 2002:aed:3c52:: with SMTP id u18mr37009892qte.194.1570560468001;
        Tue, 08 Oct 2019 11:47:48 -0700 (PDT)
Received: from wall-e.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s16sm8185118qkg.40.2019.10.08.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:47:47 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     git@vger.kernel.org
Cc:     kernel-usp@googlegroups.com, rcdailey.lists@gmail.com,
        me@ttaylorr.com, peff@peff.net, matheus.bernardino@usp.br,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.dcf@gmail.com>
Subject: [RFC WIP PATCH 2/3] tag: factor out prepare tag template code
Date:   Tue,  8 Oct 2019 15:47:26 -0300
Message-Id: <20191008184727.14337-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve code readability by moving tag body reading to a new function called
get_tag_body. This function will be used in the following patches to fix the
--no-edit flag.

Enhance legibility by encapsulating code that loads previous tag message
(if any) in new function prepare_tag_template. This code refactoring is
part of a series of commits that intend to implement the git tag --amend
flag and fix the functionality of --no-edit.

Co-authored-by: Bárbara Fernandes <barbara.dcf@gmail.com>
Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Bárbara Fernandes <barbara.dcf@gmail.com>
---
 builtin/tag.c | 65 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e1e3549af9..0322bdbdfb 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -244,6 +244,43 @@ static const char message_advice_nested_tag[] =
 	   "\n"
 	   "\tgit tag -f %s %s^{}");
 
+/*
+ * Write the tag template message with previous tag body (if any) to the given
+ * file.
+ */
+static void prepare_tag_template(struct strbuf *given_msg,
+				 struct create_tag_options *opt,
+				 struct object_id *prev, char *path,
+				 const char *tag)
+{
+       int fd;
+
+	fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+	if (fd < 0)
+		die_errno(_("could not create file '%s'"), path);
+
+	if (opt->message_given) {
+		write_or_die(fd, given_msg->buf, given_msg->len);
+		strbuf_reset(given_msg);
+	} else if (!is_null_oid(prev)) {
+		write_tag_body(fd, prev);
+	} else {
+		struct strbuf template = STRBUF_INIT;
+		strbuf_addch(&template, '\n');
+		if (opt->cleanup_mode == CLEANUP_ALL) {
+			strbuf_commented_addf(&template, _(tag_template), tag,
+					      comment_line_char);
+		} else {
+			strbuf_commented_addf(&template,
+					      _(tag_template_nocleanup), tag,
+					      comment_line_char);
+		}
+		write_or_die(fd, template.buf, template.len);
+		strbuf_release(&template);
+	}
+	close(fd);
+}
+
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
@@ -251,7 +288,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
-	char *path = NULL;
+	char *path = git_pathdup("TAG_EDITMSG");
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -271,31 +308,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		    git_committer_info(IDENT_STRICT));
 
 	if (!opt->message_given || opt->use_editor) {
-		int fd;
-
-		/* write the template message before editing: */
-		path = git_pathdup("TAG_EDITMSG");
-		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-		if (fd < 0)
-			die_errno(_("could not create file '%s'"), path);
-
-		if (opt->message_given) {
-			write_or_die(fd, buf->buf, buf->len);
-			strbuf_reset(buf);
-		} else if (!is_null_oid(prev)) {
-			write_tag_body(fd, prev);
-		} else {
-			struct strbuf buf = STRBUF_INIT;
-			strbuf_addch(&buf, '\n');
-			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
-			else
-				strbuf_commented_addf(&buf, _(tag_template_nocleanup), tag, comment_line_char);
-			write_or_die(fd, buf.buf, buf.len);
-			strbuf_release(&buf);
-		}
-		close(fd);
-
+		prepare_tag_template(buf, opt, prev, path, tag);
 		if (launch_editor(path, buf, NULL)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
-- 
2.23.0

