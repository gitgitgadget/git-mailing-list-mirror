Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664E31F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFMVvr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:47 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:34767 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:47 -0400
Received: by mail-vs1-f73.google.com with SMTP id x22so166886vsj.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Sm05Ojft7Jgv57glsY3MLUQyEXIMkpUp5vubVe/9o0=;
        b=ForzRU8juwWD9G781u/6bGqXq+IN7KbxwQaWV9xD+b4A/Xzrk2qUgEF04lrr3WbbNB
         5050g1yi6KvKQRPecMduRF8FKq5HJ8rJRQmZ0UO9CXC+o8HBJpEUdIZRIjjm5jbrgmt+
         YFkH5rNn6LllL3AaWHJ5oS8LIifm583utUk8dMTo1ausTdaqN3ZJkeTo4WjjM+tGZQal
         nzD/F1fZN4rzvOtNAZA/UtdvzL72o+oMffSQhlNiUefZ4jKeHLUB8qCaZEBM0GPCa6mS
         PQ/ICkxbrZEahLkPK+4jtOZ+7usXhGvArMdRYfH8fb76QTOU8peWBNu/tQZmROWPS4kO
         s+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Sm05Ojft7Jgv57glsY3MLUQyEXIMkpUp5vubVe/9o0=;
        b=l2MVpAYg5dngCljfoatk77TwPSP5po+a5MqFi1BBn1xyqessxVyWD+eUuztEWhExNc
         AI8pFi9srGBXXb5MwR5BKvRWwGFbunvWHvMi3265k1cRS6Y4+AAET+fihwHFoTPSaMkF
         pbqxrVFDyEIPVT0MHrQoUOXVKnAM4d5Shk266gJxVMs1tbE3+GXmPlpjZxsWFKSPFxyZ
         DdhEJWDYpW7DSF0bAUMIZ8yN8l9Mle0wec5qjmTs4RIXiWqES/hlXOv+8LpPn9SWC97q
         QS3uHJylzyO5nbgCQ6gowfi+4Iex8TXWxm8knAyKQ7dpsSq1LQdE4j2ydHGMPq7jD+Jk
         QkXw==
X-Gm-Message-State: APjAAAW4R1Qu72TlQRr8Zbs3/G7DFtWcSozS0vSpOdzvDErHw3iehzIk
        8IUj4B0dhDsY2yaPZmzTdsVWOSX7+z4CP6Wv2Us4ZLSSXXemA1R5tmQKuBwcCXJTy0PdjJgzjIV
        vsbsGGq2AQxcfdHY/381hCaNjue5a+B3gOi3Oibv7bA7ViB8izLpUpgzm464=
X-Google-Smtp-Source: APXvYqzYPI+Vo6gCYstuC9xRsnXVjvaBkWnUFlY3zZ4bubH1HJV3pwKRDYeslJKH/g5bs/lanfQElAPUeh4N
X-Received: by 2002:a1f:8744:: with SMTP id j65mr37244231vkd.17.1560462706106;
 Thu, 13 Jun 2019 14:51:46 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:26 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <a0f5671d4865f5325b7a75de57b30a5ac4e611a8.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 03/10] list-objects-filter-options: always supply *errbuf
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Making errbuf an optional argument complicates error reporting. Fix this
by making all callers supply an errbuf, even if they may ignore it. This
will be important in follow-up patches where the filter-spec parsing has
more pitfalls and possible errors.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..aef24ddae3 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -23,47 +23,40 @@
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
 	if (filter_options->choice) {
-		if (errbuf) {
-			strbuf_addstr(
-				errbuf,
-				_("multiple filter-specs cannot be combined"));
-		}
+		strbuf_addstr(
+			errbuf, _("multiple filter-specs cannot be combined"));
 		return 1;
 	}
 
 	filter_options->filter_spec = strdup(arg);
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
 
 	} else if (skip_prefix(arg, "tree:", &v0)) {
 		if (!git_parse_ulong(v0, &filter_options->tree_exclude_depth)) {
-			if (errbuf) {
-				strbuf_addstr(
-					errbuf,
-					_("expected 'tree:<depth>'"));
-			}
+			strbuf_addstr(errbuf, _("expected 'tree:<depth>'"));
 			return 1;
 		}
 		filter_options->choice = LOFC_TREE_DEPTH;
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
 		struct object_context oc;
 		struct object_id sparse_oid;
 
 		/*
@@ -80,22 +73,21 @@ static int gently_parse_list_objects_filter(
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
-	if (errbuf)
-		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+	strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
@@ -166,19 +158,22 @@ void partial_clone_register(
 	 */
 	core_partial_clone_filter_default =
 		xstrdup(filter_options->filter_spec);
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
+	struct strbuf errbuf = STRBUF_INIT;
+
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
-					 NULL);
+					 &errbuf);
+	strbuf_release(&errbuf);
 }
-- 
2.21.0

