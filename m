Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5545D20357
	for <e@80x24.org>; Thu, 13 Jul 2017 06:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdGMGvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:51:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35584 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdGMGvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:51:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id y28so3840321wrd.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9jtwiE50kIbzoSje1zXJSkBLUsP4RAh+9WD0Jgz2gTY=;
        b=eAwnV/dKINShiVOeOjOkoEN1TXFsS31Loq0M69EeWkUKtMOhYtmqymIT38ScyYOWPR
         jHk+ZVy8JGe7RI9IBNIjvxZ2eG/4gXUEcJApstJnBVx3cc1Fo96kD2/XqgpK5YsuKNz3
         AZoTrJcYwastRKlo7iNvMBnAJhkKJ2M5l5q1d41NlvJmVfl7182sL+vn2pfdFOLwicip
         T/bylpnePXxAusdwttwvxfyjX9ZGnVzJkVHiA23cN7ttRD1vrZSp1aOY3uFvv8Xk4I5n
         OF+8+jnd21bUongyPXH1acmC4gyQ7CpVEA8kkXLcbP4jItQ6ri/e6Vqy6O5FNHoNcPC/
         LZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9jtwiE50kIbzoSje1zXJSkBLUsP4RAh+9WD0Jgz2gTY=;
        b=aNAFRKocAW8omth0Zn/aHjSE/vp6A14vs/FvyP+jtQaL+/7jTz6nMwn5eorOxpGTSb
         MM/RagZtNeGDYGiQII9XHTZ2PNpU4HrtcbAd3Rl22316MtM6HkT7TRjh+8BTL1Psei0N
         rsuikJWo343vkz1G3wqqG7qz0UyOyoSrXnTqb6xvjMwfvxHaFNpjXu+9cebe/ir0cDih
         2sxbcAQjSSw5XlUDY4SAfOh7Hmu5u0nObe88666i7ANzgMktQC3+++/15qSF6L+Itff9
         GTLlKv0R0QKa7nX6VbEjbUtp2NYj4A0W3+NE+XDPuKdcrkcD1fds/BoUWlOdAeLVK3NT
         NurA==
X-Gm-Message-State: AIVw113k5NMf2fr+SJaD7j6IeLGXyjTekkIaMsdCdkt5GdTzB8mvxGlZ
        YvvFVqZxJc/3Re2p
X-Received: by 10.223.173.69 with SMTP id p63mr112158wrc.25.1499928666244;
        Wed, 12 Jul 2017 23:51:06 -0700 (PDT)
Received: from localhost.localdomain (43.40.120.78.rev.sfr.net. [78.120.40.43])
        by smtp.gmail.com with ESMTPSA id l20sm3332564wre.25.2017.07.12.23.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 23:51:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 4/4] perf/run: add calls to get_var_from_env_or_config()
Date:   Thu, 13 Jul 2017 08:50:50 +0200
Message-Id: <20170713065050.19215-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.2.647.g8b2efe2a0f
In-Reply-To: <20170713065050.19215-1-chriscool@tuxfamily.org>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These calls make it possible to have the make command or the
make options in a config file, instead of in environment
variables.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index ad442fe64a..6bd15e7017 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -116,6 +116,9 @@ export GIT_PERF_REPEAT_COUNT
 get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf.dirsOrRevs"
 set -- $GIT_PERF_DIRS_OR_REVS "$@"
 
+get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf.makeCommand"
+get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf.makeOpts"
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 
-- 
2.13.2.647.g8b2efe2a0f

