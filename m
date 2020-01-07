Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE7C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AD12081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN9zRa2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgAGTEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:04:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36709 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgAGTEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:04:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so515899edp.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XUjnovCds1mo+XUD+WrTF3JItHEpyHC01R01O6GvRqk=;
        b=iN9zRa2WqRtTW41W6zNxI5qqYbIfRZuEo9xeXlVFdHtMZwLMMKfkc/07YPoCBFiHGE
         LVQ0fufMceBdq5ioKeW/jIgCDj8H0rG1FzkDCoZrSpJGe3zEVWGl4ax3gWJPlNt1lSB2
         QPJ9cvoySnFIfReX7QoMDSUyCQ2uWlr6DtnJ24bcw2+NVGOIx6PlcoLW9lf3mAYHYOt2
         TWik0rpRCNEtl/+58EnAlBii6rQXFHZOiMlmduTf8+y6Um++ZuEfZlozWqLMo/agcSeW
         za17L3ZOsvoaFao5LXL5XLdWTNt4s7WkZcNbw1PTNfW+mn5o9IkHer7H4ItWnpQ8ORMl
         nb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XUjnovCds1mo+XUD+WrTF3JItHEpyHC01R01O6GvRqk=;
        b=G2HvJuAaDBJVL2YKquF6x25hpEiXq/UqyebWQdVZhX1agoovQiYA7/qn/wsagSNxxJ
         eMSSxU2VTwGlLgmuzKa5Nsvf2n5RyroSC9dw4dctHVhse6UqBAaTcJMmJ+ZFYWs1Zfot
         K/QsAcoQQ9kOsPVHP/pYnBopZucTrEd80rUI+/wTodldonsrKK901lc4HbcU2TYOj2B0
         rlcfIO2YSceIaBwSWznhqkUe8Iu1nTkYDJLxzeiDyUDCb9n53aq3VYZX3MSN2b7eWspz
         W+iD5zNgIAJV5tfRoMjjvSrgwgD+Dq7ufLHR66MWQnXEHINwCfxsWexLYoDKUAScmMdg
         q44g==
X-Gm-Message-State: APjAAAXvCqzKmhvvR2jF+u5SoWBW5XlaqG/XZT0OVKKS3z2e2Oh9j56n
        pfDu/5benq9hJfKzsAL47BIRCm7m
X-Google-Smtp-Source: APXvYqywv4qSlMm4sJQJ/OA6sKQ4nPQ7eKXlGEOS+CCCDM8uJsNVUMhMLrmIRS/rPQ47dYM/2Ac/BQ==
X-Received: by 2002:a17:906:aad0:: with SMTP id kt16mr857946ejb.223.1578423874180;
        Tue, 07 Jan 2020 11:04:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o88sm17065eda.41.2020.01.07.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:04:33 -0800 (PST)
Message-Id: <f969c4bc17b79f7c857987793cb0c23ad3f4e899.1578423871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.git.1578423871.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 19:04:29 +0000
Subject: [PATCH 2/4] fsmonitor: handle version 2 of the hooks that will use
 opaque token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

Some file monitors like watchman will use something other than a timestamp
to keep better track of what changes happen in between calls to query
the fsmonitor. The clockid in watchman is a string. Now that the index
is storing an opaque token for the last update the code needs to be
updated to pass that opaque token to a verion 2 of the fsmonitor hook.

Because there are repos that already have version 1 of the hook and we
want them to continue to work when git is updated, we need to handle
both version 1 and version 2 of the hook. In order to do that a
config value is being added core.fsmonitorHookVersion to force what
version of the hook should be used.  When this is not set it will default
to -1 and then the code will attempt to call version 2 of the hook first.
If that fails it will fallback to trying version 1.

Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
---
 fsmonitor.c                 | 75 +++++++++++++++++++++++++++++++------
 t/t7519-status-fsmonitor.sh |  7 +++-
 t/t7519/fsmonitor-all       |  1 -
 t/t7519/fsmonitor-watchman  |  3 +-
 4 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 9860587225..932bd9012d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -8,7 +8,8 @@
 
 #define INDEX_EXTENSION_VERSION1	(1)
 #define INDEX_EXTENSION_VERSION2	(2)
-#define HOOK_INTERFACE_VERSION		(1)
+#define HOOK_INTERFACE_VERSION1		(1)
+#define HOOK_INTERFACE_VERSION2		(2)
 
 struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
 
@@ -25,6 +26,22 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
 }
 
+static int fsmonitor_hook_version(void)
+{
+	int hook_version;
+
+	if (git_config_get_int("core.fsmonitorhookversion", &hook_version))
+		return -1;
+
+	if (hook_version == HOOK_INTERFACE_VERSION1 ||
+	    hook_version == HOOK_INTERFACE_VERSION2)
+		return hook_version;
+
+	warning("Invalid hook version '%i' in core.fsmonitorhookversion. "
+		"Must be 1 or 2.", hook_version);
+	return -1;
+}
+
 int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	unsigned long sz)
 {
@@ -158,8 +175,8 @@ static void fsmonitor_refresh_callback(struct index_state *istate, const char *n
 void refresh_fsmonitor(struct index_state *istate)
 {
 	struct strbuf query_result = STRBUF_INIT;
-	int query_success = 0;
-	size_t bol; /* beginning of line */
+	int query_success = 0, hook_version = -1;
+	size_t bol = 0; /* beginning of line */
 	uint64_t last_update;
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
@@ -167,6 +184,9 @@ void refresh_fsmonitor(struct index_state *istate)
 
 	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
+
+	hook_version = fsmonitor_hook_version();
+
 	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
@@ -175,27 +195,60 @@ void refresh_fsmonitor(struct index_state *istate)
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
 	last_update = getnanotime();
-	strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
+	if (hook_version == HOOK_INTERFACE_VERSION1)
+		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
 
 	/*
-	 * If we have a last update time, call query_fsmonitor for the set of
-	 * changes since that time, else assume everything is possibly dirty
+	 * If we have a last update token, call query_fsmonitor for the set of
+	 * changes since that token, else assume everything is possibly dirty
 	 * and check it all.
 	 */
 	if (istate->fsmonitor_last_update) {
-		query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
-			istate->fsmonitor_last_update, &query_result);
+		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
+			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
+				istate->fsmonitor_last_update, &query_result);
+
+			if (query_success) {
+				if (hook_version < 0)
+					hook_version = HOOK_INTERFACE_VERSION2;
+
+				/*
+				 * First entry will be the last update token
+				 * Need to use a char * variable because static
+				 * analysis was suggesting to use strbuf_addbuf
+				 * but we don't want to copy the entire strbuf
+				 * only the the chars up to the first NUL
+				 */
+				buf = query_result.buf;
+				strbuf_addstr(&last_update_token, buf);
+				if (!last_update_token.len) {
+					warning("Empty last update token.");
+					query_success = 0;
+				} else {
+					bol = last_update_token.len + 1;
+				}
+			} else if (hook_version < 0) {
+				hook_version = HOOK_INTERFACE_VERSION1;
+				if (!last_update_token.len)
+					strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
+			}
+		}
+
+		if (hook_version == HOOK_INTERFACE_VERSION1) {
+			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
+				istate->fsmonitor_last_update, &query_result);
+		}
+
 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
 		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
-	if (query_success && query_result.buf[0] != '/') {
+	if (query_success && query_result.buf[bol] != '/') {
 		/* Mark all entries returned by the monitor as dirty */
 		buf = query_result.buf;
-		bol = 0;
-		for (i = 0; i < query_result.len; i++) {
+		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
 				continue;
 			fsmonitor_refresh_callback(istate, buf + bol);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index cf0fda2d5a..fbfdcca000 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -32,11 +32,12 @@ write_integration_script () {
 		echo "$0: exactly 2 arguments expected"
 		exit 2
 	fi
-	if test "$1" != 1
+	if test "$1" != 2
 	then
 		echo "Unsupported core.fsmonitor hook version." >&2
 		exit 1
 	fi
+	printf "last_update_token\0"
 	printf "untracked\0"
 	printf "dir1/untracked\0"
 	printf "dir2/untracked\0"
@@ -107,6 +108,7 @@ EOF
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
 	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
 	EOF
 	git update-index --fsmonitor &&
 	git update-index --fsmonitor-valid dir1/modified &&
@@ -167,6 +169,7 @@ EOF
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
 	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
 	EOF
 	git add new &&
 	git add dir1/new &&
@@ -207,6 +210,7 @@ EOF
 # test that *only* files returned by the integration script get flagged as invalid
 test_expect_success '*only* files returned by the integration script get flagged as invalid' '
 	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	printf "last_update_token\0"
 	printf "dir1/modified\0"
 	EOF
 	clean_repo &&
@@ -276,6 +280,7 @@ do
 		# (if enabled) files unless it is told about them.
 		test_expect_success "status doesn't detect unreported modifications" '
 			write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			printf "last_update_token\0"
 			:>marker
 			EOF
 			clean_repo &&
diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
index 691bc94dc2..94ab66bd3d 100755
--- a/t/t7519/fsmonitor-all
+++ b/t/t7519/fsmonitor-all
@@ -17,7 +17,6 @@ fi
 
 if test "$1" != 1
 then
-	echo "Unsupported core.fsmonitor hook version." >&2
 	exit 1
 fi
 
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index d8e7a1e5ba..264b9daf83 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -26,8 +26,7 @@ if ($version == 1) {
 	# subtract one second to make sure watchman will return all changes
 	$time = int ($time / 1000000000) - 1;
 } else {
-	die "Unsupported query-fsmonitor hook version '$version'.\n" .
-	    "Falling back to scanning...\n";
+	exit 1;
 }
 
 my $git_work_tree;
-- 
gitgitgadget

