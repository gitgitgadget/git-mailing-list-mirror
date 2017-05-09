Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E56E1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbdEITSh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:37 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36552 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbdEITSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:32 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so4535280pfg.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Afu/xm6eQNx9QzG+aq4v/6TvzqONPZjfexEwiuXGoIQ=;
        b=sqnHlIHwE4/23AGvpwfSCAxvGBvAA59/tZTKlC4E1q50PIzYNnBvTUarD7sdBF0P1t
         YG2K7C85WGvCBKN92wUatSn0TwIlzhm67GEPqcOSFMkjStjM2eIUA1r+Jaalpsx+iW8b
         yphxgPGtOJfnBQT+4nHncBTBZ0dN9C6MUBg8Cx5tsTVZMRfA9HaYBXMdt5e2YXFklZ0y
         l8vg62ZciOymwZOcWxeAkqyHBuauUMY2fgxFo7ztw8IJ+pn935APoZVaBKUW8Og1WOx0
         jtfiIupmEiztKHegXuKNjfGBm+Nv5JdWNVlFLVxrMpFbhEKBQPXaVwlJhXlSHc6Wc9jn
         8nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Afu/xm6eQNx9QzG+aq4v/6TvzqONPZjfexEwiuXGoIQ=;
        b=MdepSvx/8zQ0WLt4xANyMxSaMGzoVu5IqIjAVCq9tkRLtix+8Dvjo0lHM8VfS9SHi7
         0TcGJo9/eANTlmwTjmg8nmisWsgsDfhQtTRgnx8vKtPaP8v6/RpzlKH3HfMWV5xUi0e3
         y8mb0q8RbFcgFbx6/Q6U2LWvQ1HKK9GOXZ2aHX/bD9x5B6OOjhsE4uO2J2JbxpHP4coe
         UTbEwCxx8zeLjeXr6iTgM73sIqU8wXGP1sGw/siDUQPeSlJsR4x4FQ9UQikQKUekYo0G
         ZYxptnzufgVLLicMQYcUEgS4EdAdD1IQ3xzDmkOIZgueBi0mJgxT2bNm+XFhuEXotrIZ
         Dh6Q==
X-Gm-Message-State: AODbwcBN4ExgqDUkyg2GKmtqzLFSt/XVuImF7rE2TSJPXT0lw7wi/uar
        ryDOa5x8BvygLBTe
X-Received: by 10.84.205.69 with SMTP id o5mr2420972plh.106.1494357511646;
        Tue, 09 May 2017 12:18:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/8] pathspec: convert strip_submodule_slash to take an index
Date:   Tue,  9 May 2017 12:18:02 -0700
Message-Id: <20170509191805.176266-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index a1297ca02..cff069536 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -386,12 +386,13 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 		return parse_short_magic(magic, elem);
 }
 
-static void strip_submodule_slash(struct pathspec_item *item)
+static void strip_submodule_slash(struct pathspec_item *item,
+				  const struct index_state *istate)
 {
 	if (item->len >= 1 && item->match[item->len - 1] == '/') {
-		int i = cache_name_pos(item->match, item->len - 1);
+		int i = index_name_pos(istate, item->match, item->len - 1);
 
-		if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
+		if (i >= 0 && S_ISGITLINK(istate->cache[i]->ce_mode)) {
 			item->len--;
 			item->match[item->len] = '\0';
 		}
@@ -497,7 +498,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	}
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH)
-		strip_submodule_slash(item);
+		strip_submodule_slash(item, &the_index);
 
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
-- 
2.13.0.rc2.291.g57267f2277-goog

