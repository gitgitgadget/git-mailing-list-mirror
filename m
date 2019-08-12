Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F371F45D
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfHLVfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34330 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHLVfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so50355966pfo.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Hwy3/5BzW5uxAy7srHmx22uS7SbvjvEUbmgy6cfbiiY=;
        b=uNRfLlOgK9/1LsnxqYmgfQGT7sW+EqawDr1TvoSiVRYkrP6gDgyw9u8a3hj6nIKmK6
         JjlHSE0ODpzMtyNHJ3LDzAl/dRcMOAVsFkuqNHRO8RvtnHxEJzSwLTcMpiVEHhnPJecQ
         nKyBI3K/sg6phGkiooKJ8GpiSDIsKkg3/Q4D8IL38tUmtA5rJNBhPi+Hc5y+RXdf3axr
         b31eypqlOon5T9P1FIuQIzjoTV+alpJNCi+lYU2Sns52kSap35EOa9havQEEVg9POPqv
         Aj6IPMGXoNbUi6kOpsiVvqSLPI6XOaexrB37K+X3pBXmhm4PDJ3bcO1yeRepthHfuTsq
         Bg1Q==
X-Gm-Message-State: APjAAAWRulyaS5zULc15J508s1GU0q+5A6h0fR4FWr2MZzMDHBo5CJH1
        IaAY+lU9S0gbMaJkFfJ2eQoFWQ==
X-Google-Smtp-Source: APXvYqx+TEKmItKUiWgU0AdRhS5JqKV1HLAGrMPOhr+s7iAQ6NPR4AvNM0YAZRp+zikHnvCxz8tC+A==
X-Received: by 2002:a17:90a:35e3:: with SMTP id r90mr1251613pjb.34.1565645742851;
        Mon, 12 Aug 2019 14:35:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g18sm156041453pgm.9.2019.08.12.14.35.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:42 -0700 (PDT)
Subject: [PATCH v2 1/5] fetch: Rename max_children to max_children_for_submodules
Date:   Mon, 12 Aug 2019 14:34:44 -0700
Message-Id: <20190812213448.2649-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812213448.2649-1-palmer@sifive.com>
References: <20190812213448.2649-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not change any functionality, but instead just prepares for
the upcoming "--fetch-jobs=<n>" support.  Essentially the "max_children"
variable is ambiguously named, which would complicate the diff in
squashed into the "--fetch-jobs=<n>" patch.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 builtin/fetch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 717dd14e8961..8aa6a0caf1ab 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -54,7 +54,7 @@ static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosit
 static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
-static int max_children = 1;
+static int max_children_for_submodules = 1;
 static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
@@ -96,7 +96,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		max_children = parse_submodule_fetchjobs(k, v);
+		max_children_for_submodules = parse_submodule_fetchjobs(k, v);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
@@ -134,7 +134,7 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_INTEGER('j', "jobs", &max_children,
+	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
 		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
@@ -1633,7 +1633,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	fetch_config_from_gitmodules(&max_children, &recurse_submodules);
+	fetch_config_from_gitmodules(&max_children_for_submodules,
+				     &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
@@ -1716,7 +1717,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 						    recurse_submodules,
 						    recurse_submodules_default,
 						    verbosity < 0,
-						    max_children);
+						    max_children_for_submodules);
 		argv_array_clear(&options);
 	}
 
-- 
2.21.0

