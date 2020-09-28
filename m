Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EFCC4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657C62078B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYsLf0MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgI1Xno (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI1Xno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:43:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A966C0613A5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f199so2638538yba.12
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QYvQjJAQ+jmD5ZnYreaXsAl9E+wqZ9K/76sBkYe+1DE=;
        b=JYsLf0MXn8/Vm3EAGlGMm9Ah+FqTlY4WJz/z2d4Z2NHjMNc0L067JM6f+zU9xEs5Ti
         4z/B6W16Bu9/Onbmbz8oCv2pS8fVH01DNXzTT266v2YYzu2FO1EPkneetfFwq0Y/UKK0
         GfNHkWDFfuEciSQj7t1M4R5y8O9s37o334FllvnXJOdiaKTzmcQ4gBKno5kBSFJPK/Xw
         Kr3oNMN3+PiT7CRbzHzPzK32pZElmeKPEvLfr/YsEP81MB9E/h0Csz6kWaqAtPSN1em1
         Vwni+HLZJIfgnBcCiMFBJ+B+7s3/VsZsmQAe9tI4SIfVLIek1NtWobONkoiYsORHaKqJ
         h7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QYvQjJAQ+jmD5ZnYreaXsAl9E+wqZ9K/76sBkYe+1DE=;
        b=aistTdKd7xcp5LktHczrxtXbZiCmnUFH9bwJR8Oc/HSb2TyElmT5GQfg5rrBKWtWVw
         reSjYiDQd7acIBJ/7sOz2lwkY0z6Iq+O33cFCzOf2A2mMheHB/7DnuormbhUj+YJ84zx
         fR1nKUJAiCSbQoPWgYoJ6NTLPDxJyj8TZPl2NyA+5DfwPRM/LFYDpFq2iMjZNNaRcuEh
         LoZKr01KwmLfTpwu+Gzbf1YZBxkO7EYx7wxT6UovAnAKaJJy5X1wplpRqqUbvTqdtycE
         2e9TVqwV/VqGqTqG09azY0kewpuck/SEq895Opxz8qWWLuymSp/q7M59dX0hMFnGaMSN
         ZDsw==
X-Gm-Message-State: AOAM532cTlpaiSBxuHjKxvTNXDtk9wVvCxDXO8B53s9PJWf/P8ba2FXL
        McchkNu+wNXUfD7kSHuL6Uf47CT8QrmKEijd+kNnF+oHX2qz12WaKr4St5W54viuFrxqerEd+km
        2ccP9s2BnDg7TGdOlhq9dmH//JEXgPUzroDxxPo9JeC3AVnP20ZCtVVuzmuuDpHt1Ox3LlqDfoh
        F7
X-Google-Smtp-Source: ABdhPJwyMKD7mmK1b87K/j8+Ht4scoeO5uGPoVFVkhHkN+JN28eBdYCP3B4UTU05zJ8lesOa+9VaAi0SGWEzdeoO8f+1
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:df08:: with SMTP id
 w8mr2328771ybg.436.1601332004689; Mon, 28 Sep 2020 15:26:44 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:26:38 -0700
In-Reply-To: <cover.1601331788.git.jonathantanmy@google.com>
Message-Id: <c3ced598751ae8fe7b7b6e787474331cf8219802.1601331788.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1600743698.git.jonathantanmy@google.com> <cover.1601331788.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2 2/2] fetch: do not override partial clone filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a fetch with the --filter argument is made, the configured default
filter is set even if one already exists. This change was made in
5e46139376 ("builtin/fetch: remove unique promisor remote limitation",
2019-06-25) - in particular, changing from:

 * If this is the FIRST partial-fetch request, we enable partial
 * on this repo and remember the given filter-spec as the default
 * for subsequent fetches to this remote.

to:

 * If this is a partial-fetch request, we enable partial on
 * this repo if not already enabled and remember the given
 * filter-spec as the default for subsequent fetches to this
 * remote.

(The given filter-spec is "remembered" even if there is already an
existing one.)

This is problematic whenever a lazy fetch is made, because lazy fetches
are made using "git fetch --filter=blob:none", but this will also happen
if the user invokes "git fetch --filter=<filter>" manually. Therefore,
restore the behavior prior to 5e46139376, which writes a filter-spec
only if the current fetch request is the first partial-fetch one (for
that remote).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 10 +++++++++-
 t/t5601-clone.sh              |  3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c555836937..97930f8201 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1677,7 +1677,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If this is a partial-fetch request, we enable partial on
 	 * this repo if not already enabled and remember the given
 	 * filter-spec as the default for subsequent fetches to this
-	 * remote.
+	 * remote if there is currently no default filter-spec.
 	 */
 	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index b66314560a..defd3dfd10 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -344,11 +344,19 @@ void partial_clone_register(
 	const char *remote,
 	struct list_objects_filter_options *filter_options)
 {
+	struct promisor_remote *promisor_remote;
 	char *cfg_name;
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if (!promisor_remote_find(remote)) {
+	if ((promisor_remote = promisor_remote_find(remote))) {
+		if (promisor_remote->partial_clone_filter)
+			/*
+			 * Remote is already registered and a filter is already
+			 * set, so we don't need to do anything here.
+			 */
+			return;
+	} else {
 		if (upgrade_repository_format(1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 15fb64c18d..4631f019fe 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -669,7 +669,8 @@ test_expect_success 'partial clone' '
 
 test_expect_success 'partial clone with -o' '
 	partial_clone_server server &&
-	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
+	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client &&
+	test_cmp_config -C client "blob:limit=0" --get-all remote.blah.partialclonefilter
 '
 
 test_expect_success 'partial clone: warn if server does not support object filtering' '
-- 
2.28.0.709.gb0816b6eb0-goog

