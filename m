Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D80D1F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966060AbdLSA3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:44 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35406 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936804AbdLSA3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:39 -0500
Received: by mail-pl0-f68.google.com with SMTP id b96so5884626pli.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HjgVPEfb5rtUAyvV/7yn1mjCNmHbfRKpdLP8Ly61X/8=;
        b=wm8w+huWPHD1pX2sWUaqlkWmtDBRZIhUXDwkKseht6b60BO4uyNcL78gB84gkVdXn4
         qAIVb4EZRL2h/EgFkx98xBW97kTGdtBIqDqPRgEBufoNusTu4UefYooUiLpt8OjEh38J
         BmH1AKA+k+5vVHA4/UdSKDB91iJWCo1HKVwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HjgVPEfb5rtUAyvV/7yn1mjCNmHbfRKpdLP8Ly61X/8=;
        b=alOKSX+VGiRZiYjC2iaquFN1vBI+m8yITW5uTYq9sTob1ugwv/1YWkr3+k/zuj1AXK
         MMiqBFKD4eLySSQCFgnW1TIiwr5PXlunTpC1WpFkzGEsqOlL3Isu3yDaWr4arGCcNvBc
         4bb4Bb3dtgO/1PI8LTn5G4eYqRfhOTBgWSMGchM2usFmprLgX2c7MPJ5XqoAUZabt/Wf
         la7TMhz0fsQ1Ctqgbr6J6BRx73Nilq1tTL/LV1e7BgdqyPG3bQ0UKaAtYv65EzzmKngp
         7l7k0vKLEZ82oba+V8ehjq5zEBUHgtkdnxPcshSZ0u1yruQ03KRnmNNSb5tlyLzBeCHK
         LM+g==
X-Gm-Message-State: AKGB3mLreffjW6UCOlB1bug1Vi9MfeXyEg/EvzzGLZbEZgiv6SId+9Z+
        fYEb53cQOnxpoG19eP6EMuNAYcGqLv4=
X-Google-Smtp-Source: ACJfBosEEKPkUvSdloVuk6ny5TtFBWfenyY7Lu5VcJ+3fqDgR7PCCRig+ouBmqvsFYClHtTajS7vZA==
X-Received: by 10.159.246.20 with SMTP id b20mr1378143pls.95.1513643377356;
        Mon, 18 Dec 2017 16:29:37 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:36 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 3/6] fsmonitor: Update helper tool, now that flags are filled later
Date:   Mon, 18 Dec 2017 16:28:55 -0800
Message-Id: <e3246bad10b891d8e3f751b6ed368a9e3f37c425.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
In-Reply-To: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
References: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dd9005a0a ("fsmonitor: delay updating state until after split index is
merged", 2017-10-27) began deferring the setting of the
CE_FSMONITOR_VALID flag until later, such that do_read_index() does
not perform those steps.  This means that t/helper/test-dump-fsmonitor
showed all bits as always unset.

Split out the code which inflates the ewah into CE_FSMONITOR_VALID
bits, and call that from t/helper/test-dump-fsmonitor.  We cannot
simply switch the code to call read_index_from or the more specific
tweak_fsmonitor, because the latter would modify the extension state
by calling add_fsmonitor.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 fsmonitor.c                    | 9 ++++++++-
 fsmonitor.h                    | 6 ++++++
 t/helper/test-dump-fsmonitor.c | 2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 0af7c4edb..7011dff15 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -227,7 +227,7 @@ void remove_fsmonitor(struct index_state *istate)
 	}
 }
 
-void tweak_fsmonitor(struct index_state *istate)
+void inflate_fsmonitor_ewah(struct index_state *istate)
 {
 	int i;
 	int fsmonitor_enabled = git_config_get_fsmonitor();
@@ -250,6 +250,13 @@ void tweak_fsmonitor(struct index_state *istate)
 		ewah_free(istate->fsmonitor_dirty);
 		istate->fsmonitor_dirty = NULL;
 	}
+}
+
+void tweak_fsmonitor(struct index_state *istate)
+{
+	int fsmonitor_enabled = git_config_get_fsmonitor();
+
+	inflate_fsmonitor_ewah(istate);
 
 	switch (fsmonitor_enabled) {
 	case -1: /* keep: do nothing */
diff --git a/fsmonitor.h b/fsmonitor.h
index 5f68ca4d2..619852d4b 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -28,6 +28,12 @@ extern void write_fsmonitor_extension(struct strbuf *sb, struct index_state *ist
 extern void add_fsmonitor(struct index_state *istate);
 extern void remove_fsmonitor(struct index_state *istate);
 
+/*
+ * Inflate the fsmonitor_dirty ewah into the CE_FSMONITOR_VALID bits.
+ * Called by tweak_fsmonitor.
+ */
+extern void inflate_fsmonitor_ewah(struct index_state *istate);
+
 /*
  * Add/remove the fsmonitor index extension as necessary based on the current
  * core.fsmonitor setting.
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index ad452707e..53b19b39b 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "fsmonitor.h"
 
 int cmd_main(int ac, const char **av)
 {
@@ -8,6 +9,7 @@ int cmd_main(int ac, const char **av)
 	setup_git_directory();
 	if (do_read_index(istate, get_index_file(), 0) < 0)
 		die("unable to read index file");
+	inflate_fsmonitor_ewah(istate);
 	if (!istate->fsmonitor_last_update) {
 		printf("no fsmonitor\n");
 		return 0;
-- 
2.15.1.626.gc4617b774

