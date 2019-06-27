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
	by dcvr.yhbt.net (Postfix) with ESMTP id E14211F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF0Wyc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42984 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0Wyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so2078252pgc.9
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e0zrX29cXTiPgzh0S2x3jm3vNwOrDTtHpzupGcqrZMw=;
        b=R1r+wqupxbTlW9Uvlrhe2WOYGgHXFAbu4paLckC1g+NpInA0cStNbPOdxs05Ed90K0
         tIpWuUXecJETGUnPI/q9+mv3dvRzr+dMwCOoZulh2o+slGENfo6F3D9Bjn5Ux6V9i0TV
         zuIVsql1jf7theny26kZlnPOvMhFFB7AdZMblf5+e1IDuIJE61o3CNV5DRmAr2ZCvrmm
         ircWcpDGrOFDjMA5cg4iRmJv4U44l8Zn2004DiTiCcty2kQkk268lSp+mVGaz7gmZHVb
         bWUsefugkK2WvAn0TeI14yJpmugno3XDcvxJhyJHlWnxyhjfPfPlOsWdQ14zEHHpQBsY
         csFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e0zrX29cXTiPgzh0S2x3jm3vNwOrDTtHpzupGcqrZMw=;
        b=LOgwhvZrYOCtCStyGYneu8O8BOKvxZNr/6agLq3yuWVRZTNnrYkslQEG506jfOa7ng
         RHask1a0wdBZ2IV8umsfiCGvkI0FUuEWNM/JaQ0t+++CKg2eqaDIwHS88WEDxVZyAqZI
         BwfjFjgKJvs055a2mcnrAoG2OivlnMBXpx8/9Vl43a1YY5V8Ok7GD7rmFqDK6NgBL3ie
         uqbeSINGi0QS0/d4TTKveioTvQY8FMvm/OyTXxaEf8CDWd4lSOhr7MT9Z+NQ5iVB5GDS
         Sa+ah2cEURzXBOsObpeUZOQ/jD/0SGCphaR8KZkV6x0exOuVe4wfim4pWPUJSUYZtiOj
         THgQ==
X-Gm-Message-State: APjAAAV918Clsen+1FtWQ5K1hTe0yH0i4A5qHerW5ztCpYXfHzwpciSc
        5NmJ3Szqqdzw/wyR9I8sYA84CvmB5LGlq7QlXOMwxkoz6Z5E9XoEEZZQlDASA+/ifaaie9a18xa
        wtnU6kWqtZSlrYnFadfi6CszP9x5GFsr62FluuRjGhh3Et9cWbC52x9WdTnA=
X-Google-Smtp-Source: APXvYqyrrjfAooMu7JQ3TWvtg650K7QlSC8U7Bdm/SPjFTav1eceO/ZDPF017dljA1LO/UHDd5QPYYUfWte8
X-Received: by 2002:a63:c03:: with SMTP id b3mr6236095pgl.68.1561676069908;
 Thu, 27 Jun 2019 15:54:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:07 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <14400b99b888d6181ef95220de0b372216e6ef1c.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 03/10] list-objects-filter-options: always supply *errbuf
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
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
index 1cb20c659c..7c3e397d29 100644
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
@@ -83,22 +76,21 @@ static int gently_parse_list_objects_filter(
 				errbuf,
 				_("sparse:path filters support has been dropped"));
 		}
 		return 1;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
-	if (errbuf)
-		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
+	strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
@@ -168,19 +160,22 @@ void partial_clone_register(
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

