Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D0C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiHBPrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiHBPqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A218364
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so13989062wra.11
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ePft4F1GYizENYuUn+2LUiiIQoRJcMjj3TGiEojPj8Q=;
        b=RIibjcIgaNROaSY8NjieziCIEYSPsaIf5Q9u0sLC+SKgNo0fBbpFTPtFhhOzeCY63x
         Av9uftTbm4nSW/awOpWLxW4dtYpTpUnN3bMDxehEyK63OfXWFJFKKR2DZg31A2zLzJen
         6zc23UX4g5f+lphFqqMe8LOAq0jYUJpNY3cZZxw3utc3YVl1VuWWzb7TmClnYlZ7IRkV
         v31MeyM1RdZw1JitIB15BfqwQC/g1Ft3VsZNfu7NooBrr9UcmEgIfzUnN4tHjOF98Xsj
         V7N8vu+Y1Qt6u3NLUFjr1k/TqNjVFIY5Xihf8z0nElpDNd9jTD3uLWUu48KZF1+MLZJG
         4TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ePft4F1GYizENYuUn+2LUiiIQoRJcMjj3TGiEojPj8Q=;
        b=DFN7cNBhm257gRvhOghZRCFo7YOp6LqOHr1P65Umxd/5WkJp/VrFUg8hYrrKPJ6iel
         Ewo+VZPgi/Rwk1wkJiU55qaDJphSCEYgTHoFP7WxNdWVPyi2XDjCikVIE24iMNVjwTDr
         ybgco7MzlO47dcGKA8Gu0QqIWDgeDbf/Tv/3f2w2O8eO9Y2A5MooSwvjmva69BwucPfK
         H9XXa1xQVEKxW+sOztCwV1OUNfNJW7Zz7aHKSM61hN372kIuKtxwj8BXb5cuIFvDLJcQ
         yncQVXnfjgUTPrf2OnljBguJdcOwpxGlihfj7zIB/4j1mCt9WXZqOqifiXM+0IXuVr9n
         oVgQ==
X-Gm-Message-State: ACgBeo2YzHXnrNQ/lNCOVwfoZeZu8K8NTgWPgmQo7RIPN7O/00m/Lx1o
        KvlWKgcTxw5C5UgoYJpN3pxsAfu1TXex+Q==
X-Google-Smtp-Source: AA6agR40HCD+XuHaLKlzLipMgYX9I4GZeIkg9uHjEH3fCnK8e/863Fa9rtXG3Wpf9hueScwbzYN4Sg==
X-Received: by 2002:adf:fd0d:0:b0:21e:f27b:10dd with SMTP id e13-20020adffd0d000000b0021ef27b10ddmr14015072wrr.295.1659455189935;
        Tue, 02 Aug 2022 08:46:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/28] submodule--helper: move "sb" in clone_submodule() to its own scope
Date:   Tue,  2 Aug 2022 17:45:57 +0200
Message-Id: <patch-v2-13.28-91558745e2e-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the only remaining use of a "struct strbuf sb" in
clone_submodule() to live in its own scope. This makes the code
clearer by limiting its lifetime.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63008970f1c..fe32abd45e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1557,16 +1557,24 @@ static void prepare_possible_alternates(const char *sm_name,
 	free(error_strategy);
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static char *clone_submodule_sm_gitdir(const char *name)
 {
-	char *p, *sm_gitdir;
-	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	char *sm_gitdir;
 
-	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
-	strbuf_reset(&sb);
+	strbuf_release(&sb);
+
+	return sm_gitdir;
+}
+
+static int clone_submodule(struct module_clone_data *clone_data)
+{
+	char *p;
+	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	if (!is_absolute_path(clone_data->path))
 		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
@@ -1655,7 +1663,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	free(sm_alternate);
 	free(error_strategy);
 
-	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(p);
 	return 0;
-- 
2.37.1.1233.ge8b09efaedc

