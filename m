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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C511F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFOAmK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:10 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51413 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:10 -0400
Received: by mail-qk1-f201.google.com with SMTP id s25so1312989qkj.18
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7zKuS7iipwTimLfJ6eFZ5cPDSJco3zW0cQiyEuARcYE=;
        b=A/i3GGbKvuDwf84/UgA9/7XW/YyvQpT0E/X7KyBBd5wfOKJ/X/89iEcxtieQMub8OF
         9RXmm2ZX+NVCXz0S/FzZndQjIiONxVjaUGuwQve6ejbV26mzcqEepjfBTm1DdPl79OOG
         kEZQJFsvORin7FcD3j5ZMSRl1ijJelp2uEcIIsRjIOmclNJ8Hsj8tFXSCsjsNk/PvFGr
         mQJQ8pv4KwBeNeUY/lFnACbmWKUio5YSp7aw2pzIbu4yx/1Pp7bAa3A89Ga3r13zaJc1
         zydP2wd1Qw6LgysJ28EjM+rSBNGkvbBbUBAvxqFYQ+CDacQVgwBUpua/zUMSYhLChjGV
         YuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7zKuS7iipwTimLfJ6eFZ5cPDSJco3zW0cQiyEuARcYE=;
        b=btQYUyzd1tPaKkBH3S+YJuJMmubuYVK9QMVg90TQWwq9nEbTFglQtOHyawzAfQgsT4
         YLgztMXyArfdmL8KMgzxvNECyngWzLCiJDeHP1qfZoUuNwsOn0yvEFuGQCbiV8kf1fkx
         tfCTWY1Y/kM1GE6WSiMFTutvKKjtcH0OhJxAdZrJOxYsp8MH+Dok3BcH+e0fEqMJQjal
         U04KwL5GCJtPboQIBtR5J3lEJ0uPGALV/+/cycbrHcqD9vqvas0zeIKEhcnv7e1rXCpD
         Qt/cRd7aF5Tt+5DLkCl5tx0/iLNjiKI0iOAHdjkQi5A1Seh/PiuvKyj3u3GRfFrKiM0e
         r6XQ==
X-Gm-Message-State: APjAAAWW0JrWaJW8Dh5GAXRs8uppUZbO66hmZmehpF0aIew0X5BGgc/e
        DUs+E5xFFWuTgr0/wGOoGlfQQWzpG5LcUZM2uysjR9J787ELfHfL47gATJuFsQfHKwsQ++e7qKz
        EWDRkaGspuFnoDGi122ZdWH2eFw58ET9RlWSVKtViTn10XTzf1SRRSA8Qokw=
X-Google-Smtp-Source: APXvYqxwloteyxdFAZC7ar5T2wwW9ukGFgeMDF8hLfugvOtL6NeGfeamR/7dOyQrZL/GUcTSAJy4btS/zC2z
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr39691540qtp.124.1560559329021;
 Fri, 14 Jun 2019 17:42:09 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:09 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com>
Message-Id: <1e2ee8a15f32acbd0aa02e51641be4b209e9505b.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 03/10] list-objects-filter-options: always supply *errbuf
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
index a15d0f7829..8e7b4f96fa 100644
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

