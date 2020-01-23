Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F78C33CAF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D366D2064C
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+LcLoPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAWP0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:26:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41601 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAWP0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 10:26:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so3520001wrw.8
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XUjnovCds1mo+XUD+WrTF3JItHEpyHC01R01O6GvRqk=;
        b=f+LcLoPqToXDJh0J+/syLgYXcKj5aAvSa7C9EtTqaJ0hAnj99LQ7/tsiYbR1AMPI0U
         1IqPeypPE1JcvHErqcgP1sdU89H/yQPhPAkKLa0BRZHYC37AsFW+B5eP8VXBYjy4665A
         WUPWN2vcqkCxtq2Z+7+ZslWivCVCp6zqNghcAylCmDJ+VzcthKXlErQiAlhfHVZ0zo8B
         8bFsUY/Y/L96/hd9jnRvogMeMmNgb/bdMxLxPPC+nW2dMPRBhH+SunvmNcToDxtF1xDZ
         Ecm9a/pm3fw5KjmXURqv11EdWHlcihngfaQ1BsO2wnX0QI3DQH8D9rOy3KbRRTfH82wl
         MjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XUjnovCds1mo+XUD+WrTF3JItHEpyHC01R01O6GvRqk=;
        b=MPqswBMdes/Xs8QynChIGHvKIMoFd1kkX5j1fouAc3YEy6MbCiubDkvdnhH6A7rQhk
         g3+T6oohURBfjJlqMxM5YEaijbbZgodJaA5Bb7V8y2jHmoTLCwOS9UhbBws5lTYP6b+M
         V+3ikKLW6PhWHfvW01XudwFRVmiS53u/3z4LLCv7X5stWhznPKXIZ+5zalocEA0p3/Ja
         YoSnbTrb/SPyTUSeid9H2l5AbMgTV2AnryLsxM+XMhYH1cYJDrPnNk0CXIvjDgtwwIen
         w2jSF13Gw8rhUzKpdS6MeigGpn1vGA3ZtnR+KqkFGb1ncSe1J+1ZhvHKVZ9phmJvM+V+
         WN1Q==
X-Gm-Message-State: APjAAAVFQ3PUnBlmuZfJX2hWxWptdiDiep35HeQyqgR0nKjPJm5Ta+y9
        hftT5q66H2t4yS2imUSglz0xHLNu
X-Google-Smtp-Source: APXvYqwcpKyBn8+c/bC4u+dIf6Th990Y9O9xD/KOw+wY67QTzptcXxBowSXKdLA8VMAKFHJzz2R/zQ==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr18973395wrx.66.1579793210726;
        Thu, 23 Jan 2020 07:26:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm3442602wrr.75.2020.01.23.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:26:50 -0800 (PST)
Message-Id: <f969c4bc17b79f7c857987793cb0c23ad3f4e899.1579793207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
        <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 15:26:45 +0000
Subject: [PATCH v2 2/4] fsmonitor: handle version 2 of the hooks that will use
 opaque token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
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

