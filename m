Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47825C7618D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjCOPPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjCOPPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 11:15:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D135DEFAA
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l1so17615766wry.12
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893333;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gk3yh4aeo7T8CLcO1xQ0T4v1emGBYXjM1YvGAdHDdSM=;
        b=fx/zCyAkZhJuknWN0ocHnQyCyV0Lq8yWq/Z7/gXZZHEcu9HhBm9Pk/UOXN7sC4VA6j
         SGz8gA/F0jiVu6ivRKvCht/4IRDNN62pob46IdZ+KXLJM97WdLPdFaXbgs0MhzkJYnzt
         gzvAXLERl6iIqI0QlI9tJYr5bxWVTOBtdmjXObYKlF6l5DKMi3PA0urGnH7htnxW6d0d
         VqD206Fa5vvDBC6KHC3RSDERg15fgjEG+f17SdFC7qMp64qLKJT3zvHU/9Zjn/fl7Xgm
         72E/p1eot4+jcksVkbyLDtr9f+YLx8nTbjqPMqEEW2eXIWky4DqV17pcqzwJpII/dSz6
         fMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893333;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk3yh4aeo7T8CLcO1xQ0T4v1emGBYXjM1YvGAdHDdSM=;
        b=DphqWSGiHRgXOz46O4Zvq9LqutXwXk/oGXuTdA2GaElCjOKIoro0sojdzfQwY3ZMVV
         Dx2WxHP9M5u9kuQIZpg/iUoTTaJf5e8hxtR0RVok7WpiVre+ESKwR1PpafFNqymiq22E
         2gWWek3N5KbDVRr8b8J5mDAC+qZGr8JqxbGGbBkSf3UJA//iD6kmboLiywYCJJnpOIDU
         9zb9bsbLHp+rcTlQRbuvrcG6XvdAWYkhHj6d21Mo9z9HZAEYXV8UaUYFhCLEAr0jy32w
         oAAkve8ucQ0D7fWhLfZ6gFLbhCQGDlKIhvdzm6hOkHJEMfW+XHkNJHV3ICruRtXFiSXm
         TVGA==
X-Gm-Message-State: AO0yUKUjvWEcv5UETd9CM7HxvYoFuB3sDk/0laq0Dg9NYIlipG+2To6s
        r0+KukDJ5aKOLeZRtK8qqGrlP0dvcz4=
X-Google-Smtp-Source: AK7set+RZskI7oIeZR4elR2cLYPB3+gojS0aAW5veG9vB2MSsS30STCDUBmpLdseQRM+aQCChB9vYQ==
X-Received: by 2002:adf:f48a:0:b0:2c5:5d21:7d4c with SMTP id l10-20020adff48a000000b002c55d217d4cmr2104185wro.43.1678893333189;
        Wed, 15 Mar 2023 08:15:33 -0700 (PDT)
Received: from localhost.localdomain ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm4783191wrv.32.2023.03.15.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:15:32 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/4] rebase: stop reading and writing unnecessary strategy state
Date:   Wed, 15 Mar 2023 15:14:56 +0000
Message-Id: <029d0bf2b6249ddc3e79fe1bf3df3e05d22348ad.1678893298.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The state files for "--strategy" and "--strategy-option" are written and
read twice, once by builtin/rebase.c and then by sequencer.c. This is an
artifact of the scripted rebase and the need to support "rebase
--preserve-merges". Now that "--preserve-merges" no-longer exists we
only need to read and write these files in sequencer.c. This enables us
to remove a call to free() in read_strategy_opts() that was added by
f1f4ebf432 (sequencer.c: fix "opts->strategy" leak in
read_strategy_opts(), 2022-11-08) as this commit fixes the root cause of
that leak.

There is further scope for removing duplication in the reading and
writing of state files between builtin/rebase.c and sequencer.c but that
is left for a follow up series.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 24 ------------------------
 sequencer.c      |  1 -
 2 files changed, 25 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..516ad1b12a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -482,24 +482,6 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
-	if (file_exists(state_dir_path("strategy", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy);
-		opts->strategy = xstrdup(buf.buf);
-	}
-
-	if (file_exists(state_dir_path("strategy_opts", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy_opts);
-		opts->strategy_opts = xstrdup(buf.buf);
-	}
-
 	strbuf_release(&buf);
 
 	return 0;
@@ -517,12 +499,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
 		write_file(state_dir_path("verbose", opts), "%s", "");
-	if (opts->strategy)
-		write_file(state_dir_path("strategy", opts), "%s",
-			   opts->strategy);
-	if (opts->strategy_opts)
-		write_file(state_dir_path("strategy_opts", opts), "%s",
-			   opts->strategy_opts);
 	if (opts->allow_rerere_autoupdate > 0)
 		write_file(state_dir_path("allow_rerere_autoupdate", opts),
 			   "-%s-rerere-autoupdate",
diff --git a/sequencer.c b/sequencer.c
index 886fbc3616..55b3ba3a51 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2946,7 +2946,6 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
-	free(opts->strategy);
 	opts->strategy = strbuf_detach(buf, NULL);
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
-- 
2.39.2

