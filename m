Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1922047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbdHGSVd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37661 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdHGSV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id 12so851931wrb.4
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKZZbmN1mK4+mBP5WJuP8wPIPZDmV9EuqTGwlbibrFA=;
        b=rt6ZusBl+KeHerNQjOp68C7tksuivIBBL9G3dFFwHC6HB1t8XsvNTzpLcq9oS7RB6F
         ILEJk2VYxNbQ9nrwF+6aebWFdpZJbN/Jva6DuFLM+pTnhF07qu7pwrJs7ztLZYswQkji
         5MC1KdBmCat8w7WTUIuuEMyYHrz7Q1GIJaKlIBRzotf5Dp7fTfS06RGELkQHsOivgL4+
         ER5uB6ompUkbHM3KvhWSLsCcht3u2F09KTM62hDpYmeg4gCxNne6LLAtY+spA6/0GBj9
         5rt5WKUs39idR4c8Q6+f8TvkN9EkTXIR2FzlwiXi04UE8G+W8nYpBkQMhb1aHnQT1ydT
         5VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKZZbmN1mK4+mBP5WJuP8wPIPZDmV9EuqTGwlbibrFA=;
        b=Zmbm5PJ+I5i8uiBBFBCpW0/Va4QpAK2ToHdyQX/Aa9WPQI7GryM1CpPO05Jsctd/c9
         p4hzUudcUFabb9hKej4yC2ASFgK2eTdPK4vCPod+LSdsuusu3CllSCmtP0L6AdgS/YkR
         5ESHj1wcnnYwQx2DNxWiS+SWyJQSPclupLAHDCN5QcFPH6FBJ/6S8CKDLb9u050lek36
         BoPuhnUv10P7MTFWlMgwOO6R6KrTMTZ0CWGUR2eCfRHnkgx1weTQK/dX4HFsI1+gPkgg
         i5slBrR0SOHHwoLyF3YRKqJgKMEqCJjctRE5NvofKcIX9kVPr84HaT+2/b4f2QhlSl2c
         hrjQ==
X-Gm-Message-State: AHYfb5jKxGheezR34yqNabTzEg64eU1lnkzW4c4SEIjbR+Wp+18VivfI
        spa/m0lGVu/UGlRm
X-Received: by 10.223.130.69 with SMTP id 63mr1205895wrb.42.1502130086480;
        Mon, 07 Aug 2017 11:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:25 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] treewide: deprecate git_config_maybe_bool, use git_parse_maybe_bool
Date:   Mon,  7 Aug 2017 20:20:49 +0200
Message-Id: <4309125367e7bad34dac2347bc27c2ec59fda36e.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only difference between these is that the former takes an argument
`name` which it ignores completely. Still, the callers are quite careful
to provide reasonable values for it.

Once in-flight topics have landed, we should be able to remove
git_config_maybe_bool. In the meantime, document it as deprecated in the
technical documentation. While at it, document git_parse_maybe_bool.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/api-config.txt | 4 ++++
 builtin/log.c                          | 4 ++--
 builtin/merge.c                        | 4 ++--
 builtin/pull.c                         | 4 ++--
 builtin/push.c                         | 2 +-
 builtin/remote.c                       | 2 +-
 builtin/send-pack.c                    | 2 +-
 config.c                               | 2 +-
 pager.c                                | 2 +-
 submodule-config.c                     | 6 +++---
 10 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 20741f345..7a83a3a6e 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -187,6 +187,10 @@ Same as `git_config_bool`, except that integers are returned as-is, and
 an `is_bool` flag is unset.
 
 `git_config_maybe_bool`::
+Deprecated. Use `git_parse_maybe_bool` instead. They are exactly the
+same, except this function takes an unused argument `name`.
+
+`git_parse_maybe_bool`::
 Same as `git_config_bool`, except that it returns -1 on error rather
 than dying.
 
diff --git a/builtin/log.c b/builtin/log.c
index c6362cf92..9182f0ee3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -60,7 +60,7 @@ static int auto_decoration_style(void)
 
 static int parse_decoration_style(const char *var, const char *value)
 {
-	switch (git_config_maybe_bool(var, value)) {
+	switch (git_parse_maybe_bool(value)) {
 	case 1:
 		return DECORATE_SHORT_REFS;
 	case 0:
@@ -821,7 +821,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "format.from")) {
-		int b = git_config_maybe_bool(var, value);
+		int b = git_parse_maybe_bool(value);
 		free(from);
 		if (b < 0)
 			from = xstrdup(value);
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb4..6a5122921 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -566,7 +566,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
-		int boolval = git_config_maybe_bool(k, v);
+		int boolval = git_parse_maybe_bool(v);
 		if (0 <= boolval) {
 			fast_forward = boolval ? FF_ALLOW : FF_NO;
 		} else if (v && !strcmp(v, "only")) {
@@ -940,7 +940,7 @@ static int default_edit_option(void)
 		return 0;
 
 	if (e) {
-		int v = git_config_maybe_bool(name, e);
+		int v = git_parse_maybe_bool(e);
 		if (v < 0)
 			die(_("Bad value '%s' in environment '%s'"), e, name);
 		return v;
diff --git a/builtin/pull.c b/builtin/pull.c
index 9b86e519b..7fe281414 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -39,7 +39,7 @@ enum rebase_type {
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
 {
-	int v = git_config_maybe_bool("pull.rebase", value);
+	int v = git_parse_maybe_bool(value);
 
 	if (!v)
 		return REBASE_FALSE;
@@ -274,7 +274,7 @@ static const char *config_get_ff(void)
 	if (git_config_get_value("pull.ff", &value))
 		return NULL;
 
-	switch (git_config_maybe_bool("pull.ff", value)) {
+	switch (git_parse_maybe_bool(value)) {
 	case 0:
 		return "--no-ff";
 	case 1:
diff --git a/builtin/push.c b/builtin/push.c
index 03846e837..2ac810422 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -481,7 +481,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
 		if (!git_config_get_value("push.gpgsign", &value)) {
-			switch (git_config_maybe_bool("push.gpgsign", value)) {
+			switch (git_parse_maybe_bool(value)) {
 			case 0:
 				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_NEVER);
 				break;
diff --git a/builtin/remote.c b/builtin/remote.c
index 6273c0c23..a995ea86c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -301,7 +301,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			}
 			string_list_append(&info->merge, xstrdup(value));
 		} else {
-			int v = git_config_maybe_bool(orig_key, value);
+			int v = git_parse_maybe_bool(value);
 			if (v >= 0)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 633e0c3cd..fc4f0bb5f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -105,7 +105,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
 		if (!git_config_get_value("push.gpgsign", &value)) {
-			switch (git_config_maybe_bool("push.gpgsign", value)) {
+			switch (git_parse_maybe_bool(value)) {
 			case 0:
 				args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
 				break;
diff --git a/config.c b/config.c
index d87376a5d..9b474d9a3 100644
--- a/config.c
+++ b/config.c
@@ -1851,7 +1851,7 @@ int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *de
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value)) {
-		*dest = git_config_maybe_bool(key, value);
+		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
 		return 0;
diff --git a/pager.c b/pager.c
index 4dd9e1b26..92b23e6cd 100644
--- a/pager.c
+++ b/pager.c
@@ -194,7 +194,7 @@ static int pager_command_config(const char *var, const char *value, void *vdata)
 	const char *cmd;
 
 	if (skip_prefix(var, "pager.", &cmd) && !strcmp(cmd, data->cmd)) {
-		int b = git_config_maybe_bool(var, value);
+		int b = git_parse_maybe_bool(value);
 		if (b >= 0)
 			data->want = b;
 		else {
diff --git a/submodule-config.c b/submodule-config.c
index 5fe2d0787..11a32584d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -232,7 +232,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 static int parse_fetch_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
-	switch (git_config_maybe_bool(opt, arg)) {
+	switch (git_parse_maybe_bool(arg)) {
 	case 1:
 		return RECURSE_SUBMODULES_ON;
 	case 0:
@@ -277,7 +277,7 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 static int parse_update_recurse(const char *opt, const char *arg,
 				int die_on_error)
 {
-	switch (git_config_maybe_bool(opt, arg)) {
+	switch (git_parse_maybe_bool(arg)) {
 	case 1:
 		return RECURSE_SUBMODULES_ON;
 	case 0:
@@ -297,7 +297,7 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
-	switch (git_config_maybe_bool(opt, arg)) {
+	switch (git_parse_maybe_bool(arg)) {
 	case 1:
 		/* There's no simple "on" value when pushing */
 		if (die_on_error)
-- 
2.14.0.5.g0f7b1ed27

