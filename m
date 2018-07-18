Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BBA1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 00:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGRB21 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 21:28:27 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51146 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbeGRB21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 21:28:27 -0400
Received: by mail-oi0-f73.google.com with SMTP id p11-v6so2661152oih.17
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=oEtEHPRHdb46S6jcpX2aAFTXt/BjymAoUh2b9qE1ZKM=;
        b=Ecdb3xoSR68lm4sTuzZXZbMYEr369o9uS8JmCMm90XcldsGdyDBsHLpZNCeMGBSHRR
         BOvUNDrMdemAGrnBiEkbGp27PuMxIhNGWKRjeAJUdDQos9SJ3rmoYWD+u8/aUn408k2X
         xkHviEx65m0mSXgNnJUeO4j69CdHa/BTr8pV/cZrJvhPkM2pG+CJQmwpR4ZWIkKw1KT0
         t227fYrLv9VhfSj+ROKPksGHGWRGbxE4AjJsImcWJ8eTCUgjMqVjZ/lAOw65wa1z+Bb4
         Pv1N1CFU1kVUPzo9msZHUyBCNv34aqlSBB2g+tXff/FClrHg+kxkMxy06rc47S/0Jzdv
         afPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=oEtEHPRHdb46S6jcpX2aAFTXt/BjymAoUh2b9qE1ZKM=;
        b=CEMX1At/d3S7tOjwBDY22Ibn7psvikN1JGZ5a8Zq5+as6lTvFK+DnDnEwLsvk5Q7kF
         LyRi4upQg1GQKQeo9Z3nv8cy5o9nxEPakY0m0GqlT9FQh8xflpAYBCC6ABXvH7dUc7ij
         uoolfZ0FMDliaS3dk22pxpslUyHdwI7XJJCXVSgajUIh+1NSaWtUbUWwQCj6Hw9n4E+F
         zzgMbGw5FswcvfRow72KZsTntBVA5OqKtXxavrdoJddCgU+zBQ3Qv4GVf+5JTZHtXV4m
         8XiKrJgJzPiVoCOXCCyyJGihzDjGa8dXYOyMSRohv1UbcxeMunJ7W0wR7Q7/iADvfzUB
         RLGg==
X-Gm-Message-State: AOUpUlHOhuMKRuzOb78EOOrUENyAYqqlfdSd2eSZbD2I4YULeuVea5GC
        B1VXV4x3k7dvrTREFjdGNO5HUY1Sb+HZ
X-Google-Smtp-Source: AAOMgpddVOWfWmD2YP5L2fnxUqNuvThHFx6kxood3lOqLD5OGICbbVlmYS+TKnbqdh0kejxyKtsf1L3llXqe
MIME-Version: 1.0
X-Received: by 2002:aca:6087:: with SMTP id u129-v6mr2301067oib.92.1531875194555;
 Tue, 17 Jul 2018 17:53:14 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:53:11 -0700
Message-Id: <20180718005311.136329-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] diff.c: offer config option to control ws handling in move detection
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is the cherry on the cake named sb/diff-color-move-more.

 Documentation/config.txt       | 5 +++++
 Documentation/diff-options.txt | 7 +++++--
 diff.c                         | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb37..6ca7118b018 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1122,6 +1122,11 @@ diff.colorMoved::
 	true the default color mode will be used. When set to false,
 	moved lines are not colored.
 
+diff.colorMovedWS::
+	When moved lines are colored using e.g. the `diff.colorMoved` setting,
+	this option controls the `<mode>` how spaces are treated
+	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 143acd9417e..8da7fed4e22 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -294,8 +294,11 @@ dimmed_zebra::
 
 --color-moved-ws=<modes>::
 	This configures how white spaces are ignored when performing the
-	move detection for `--color-moved`. These modes can be given
-	as a comma separated list:
+	move detection for `--color-moved`.
+ifdef::git-diff[]
+	It can be set by the `diff.colorMovedWS` configuration setting.
+endif::git-diff[]
+	These modes can be given as a comma separated list:
 +
 --
 ignore-space-at-eol::
diff --git a/diff.c b/diff.c
index f51f0ac32f4..9de917108d8 100644
--- a/diff.c
+++ b/diff.c
@@ -35,6 +35,7 @@ static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_color_moved_default;
+static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
@@ -332,6 +333,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_color_moved_default = cm;
 		return 0;
 	}
+	if (!strcmp(var, "diff.colormovedws")) {
+		int cm = parse_color_moved_ws(value);
+		if (cm < 0)
+			return -1;
+		diff_color_moved_ws_default = cm;
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -4327,6 +4335,7 @@ void diff_setup(struct diff_options *options)
 	}
 
 	options->color_moved = diff_color_moved_default;
+	options->color_moved_ws_handling = diff_color_moved_ws_default;
 }
 
 void diff_setup_done(struct diff_options *options)
-- 
2.18.0.233.g985f88cf7e-goog

