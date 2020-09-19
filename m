Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD5C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E7A20771
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCO8u7F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgISRDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRDs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8060C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u9so4655104plk.4
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXOfZBeB9A4TKKq07yVval4tStxAwmkHMWtKSllYgSA=;
        b=gCO8u7F1Zro7RiwS7yT5LstGKIoBHC5jnlRtOSIh/8+m0Lwg25AtYaYjKlEWvuRwW/
         /umIXT5EpJPcqwt6wcVBPZPhyOdut/1ngdegpdmF9jMejv57UcH5P1xLmfCSOMBjxB3x
         0dsrZU2eraAQ0LLzvOXWzSFBEVUYN1Q/FykVpQw+4+mOjdVJkIaRqj6bo7T1n7sDtA+V
         Amo5ZEm2bY0YycC/nGAX5qqjrqMBWY18BwR6chrBvS0ZQpHRqi8S8/24gJHuYCbAzCo5
         /gDGCUlk945GCoSduXOfOG3Zl1+yUYviKo+ok4fdXuDy4cGnfz+7/jMX/GfCDnUFR7D7
         76eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXOfZBeB9A4TKKq07yVval4tStxAwmkHMWtKSllYgSA=;
        b=hJ9H4/JC4FHQjOyx3YRz0ZmNG93QAWBah+h/qfYYOS1NuvXcozEk/PmFiQ0PmnygpJ
         04bqIG82hG1YP0W4UjcR7z/sn9obtIm/6dOww4xQesKx91P/fkGGy8bCxGY5e7go0bbn
         rsTLZkEgjd/Xk/nDOR8mq24Z/t7ZB9JzmbB6L0NcSRihBwA+lBXI9cXPFLzntVe6J+q+
         dp0AkYRty081cx9xk8H0nN44VKocoGDiT+pHf5DVHaD85R8VzH9Q7a5gkV9AjApuWoMN
         RJz6KyDWuAWGeybhc48IKJdpdBl86L9ltz35+nqvshtH2cX1ymbc/Lj1N/J+YbhfVNdD
         PO6w==
X-Gm-Message-State: AOAM530ogIDltbY4AwWSQey2/o/1ypoohJ2X9Lb7nNSN6mLEhi5VYysZ
        qAD9ujAIoAemZEMSc+LuSAJPGO5jtnFZe5GW
X-Google-Smtp-Source: ABdhPJwPpZihZukmfiozoTQQuzNStcJpzM0nq2M/d3+grwQP633o4ckHd5JcB2ZfV4dqoi0A5FbPuQ==
X-Received: by 2002:a17:902:c411:b029:d0:589f:6e1c with SMTP id k17-20020a170902c411b02900d0589f6e1cmr39323095plk.0.1600535027811;
        Sat, 19 Sep 2020 10:03:47 -0700 (PDT)
Received: from localhost.localdomain ([104.200.132.172])
        by smtp.gmail.com with ESMTPSA id 25sm1510140pgo.34.2020.09.19.10.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:03:47 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v4 2/3] push: parse and set flag for "--force-if-includes"
Date:   Sat, 19 Sep 2020 22:33:15 +0530
Message-Id: <20200919170316.5310-3-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a flag: "TRANSPORT_PUSH_FORCE_IF_INCLUDES" to indicate that the new
option was passed from the command line of via configuration settings;
update command line and configuration parsers to set the new flag
accordingly.

Introduces a new configuration option "push.useForceIfIncludes", which
is equivalent to setting "--force-if-includes" in the command line.

Updates "remote-curl" to recognize and pass this option to "send-pack"
when enabled.

Updates "advise" to catch the reject reason "REJECT_REF_NEEDS_UPDATE",
which is set when the ref status is "REF_STATUS_REJECT_REMOTE_UPDATED"
and (optionally) print a help message when the push fails.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 advice.c            |  3 +++
 advice.h            |  2 ++
 builtin/push.c      | 27 +++++++++++++++++++++++++++
 builtin/send-pack.c |  6 ++++++
 remote-curl.c       | 14 +++++++++++++-
 remote.c            |  5 +++++
 remote.h            |  6 ++++++
 transport-helper.c  |  6 ++++++
 transport.c         |  2 ++
 transport.h         | 15 ++++++++++-----
 10 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index f0a3d32d20..164742305f 100644
--- a/advice.c
+++ b/advice.c
@@ -11,6 +11,7 @@ int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
+int advice_push_ref_needs_update = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_status_ahead_behind_warning = 1;
@@ -72,6 +73,7 @@ static struct {
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
+	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
@@ -116,6 +118,7 @@ static struct {
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
 	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
 
 	/* make this an alias for backward compatibility */
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
diff --git a/advice.h b/advice.h
index 16f2c11642..bc2432980a 100644
--- a/advice.h
+++ b/advice.h
@@ -11,6 +11,7 @@ extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
+extern int advice_push_ref_needs_update;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_status_ahead_behind_warning;
@@ -60,6 +61,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
+	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_RESET_QUIET_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
diff --git a/builtin/push.c b/builtin/push.c
index 0eeb2c8dd5..c007b19360 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -290,6 +290,12 @@ static const char message_advice_ref_needs_force[] =
 	   "or update a remote ref to make it point at a non-commit object,\n"
 	   "without using the '--force' option.\n");
 
+static const char message_advice_ref_needs_update[] =
+	N_("Updates were rejected because the tip of the remote-tracking\n"
+	   "branch has been updated since the last checkout. You may want\n"
+	   "to integrate those changes locally (e.g., 'git pull ...')\n"
+	   "before forcing an update.\n");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_update_rejected)
@@ -325,6 +331,13 @@ static void advise_ref_needs_force(void)
 	advise(_(message_advice_ref_needs_force));
 }
 
+static void advise_ref_needs_update(void)
+{
+	if (!advice_push_ref_needs_update || !advice_push_update_rejected)
+		return;
+	advise(_(message_advice_ref_needs_update));
+}
+
 static int push_with_options(struct transport *transport, struct refspec *rs,
 			     int flags)
 {
@@ -374,6 +387,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		advise_ref_fetch_first();
 	} else if (reject_reasons & REJECT_NEEDS_FORCE) {
 		advise_ref_needs_force();
+	} else if (reject_reasons & REJECT_REF_NEEDS_UPDATE) {
+		advise_ref_needs_update();
 	}
 
 	return 1;
@@ -510,6 +525,12 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		if (!v)
 			return config_error_nonbool(k);
 		return color_parse(v, push_colors[slot]);
+	} else if (!strcmp(k, "push.useforceifincludes")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_FORCE_IF_INCLUDES;
+		else
+			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
+		return 0;
 	}
 
 	return git_default_config(k, v, NULL);
@@ -541,6 +562,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 			       N_("require old value of ref to be at this value"),
 			       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option),
+		OPT_BIT(0, TRANS_OPT_FORCE_IF_INCLUDES, &flags,
+			N_("require remote updates to be integrated locally"),
+			TRANSPORT_PUSH_FORCE_IF_INCLUDES),
 		OPT_CALLBACK(0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
 			     N_("control recursive pushing of submodules"), option_parse_recurse_submodules),
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
@@ -593,6 +617,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES)
+		push_set_force_if_includes(&cas);
+
 	remote = pushremote_get(repo);
 	if (!remote) {
 		if (repo)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4d76727edb..9289c0eecb 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -159,6 +159,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
+	unsigned int force_if_includes = 0;
 	struct packet_reader reader;
 
 	struct option options[] = {
@@ -184,6 +185,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option),
+		OPT_BOOL(0, TRANS_OPT_FORCE_IF_INCLUDES, &force_if_includes,
+			 N_("require remote updates to be integrated locally")),
 		OPT_END()
 	};
 
@@ -282,6 +285,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
 		return -1;
 
+	if (force_if_includes)
+		push_set_force_if_includes(&cas);
+
 	if (!is_empty_cas(&cas))
 		apply_push_cas(&cas, remote, remote_refs);
 
diff --git a/remote-curl.c b/remote-curl.c
index 32cc4a0c55..0290b04891 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -44,7 +44,8 @@ struct options {
 		from_promisor : 1,
 
 		atomic : 1,
-		object_format : 1;
+		object_format : 1,
+		force_if_includes : 1;
 	const struct git_hash_algo *hash_algo;
 };
 static struct options options;
@@ -131,6 +132,14 @@ static int set_option(const char *name, const char *value)
 		string_list_append(&cas_options, val.buf);
 		strbuf_release(&val);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FORCE_IF_INCLUDES)) {
+		if (!strcmp(value, "true"))
+			options.force_if_includes = 1;
+		else if (!strcmp(value, "false"))
+			options.force_if_includes = 0;
+		else
+			return -1;
+		return 0;
 	} else if (!strcmp(name, "cloning")) {
 		if (!strcmp(value, "true"))
 			options.cloning = 1;
@@ -1318,6 +1327,9 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 		strvec_push(&args, cas_option->string);
 	strvec_push(&args, url.buf);
 
+	if (options.force_if_includes)
+		strvec_push(&args, "--force-if-includes");
+
 	strvec_push(&args, "--stdin");
 	for (i = 0; i < nr_spec; i++)
 		packet_buf_write(&preamble, "%s\n", specs[i]);
diff --git a/remote.c b/remote.c
index 60d681a885..7679be9213 100644
--- a/remote.c
+++ b/remote.c
@@ -2255,6 +2255,11 @@ int parseopt_push_cas_option(const struct option *opt, const char *arg, int unse
 	return parse_push_cas_option(opt->value, arg, unset);
 }
 
+void push_set_force_if_includes(struct push_cas_option *cas)
+{
+	cas->use_force_if_includes = 1;
+}
+
 int is_empty_cas(const struct push_cas_option *cas)
 {
 	return !cas->use_tracking_for_rest && !cas->nr;
diff --git a/remote.h b/remote.h
index 38ab8539e2..72c374d539 100644
--- a/remote.h
+++ b/remote.h
@@ -350,4 +350,10 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+/*
+ * Sets "use_force_if_includes" for "compare-and-swap"
+ * when "--force-if-includes" is specified.
+ */
+void push_set_force_if_includes(struct push_cas_option *);
+
 #endif
diff --git a/transport-helper.c b/transport-helper.c
index e547e21199..2a4436dd79 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -868,6 +868,12 @@ static void set_common_push_options(struct transport *transport,
 		if (set_helper_option(transport, TRANS_OPT_ATOMIC, "true") != 0)
 			die(_("helper %s does not support --atomic"), name);
 
+	/* If called with "--force-if-includes". */
+	if (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES)
+		if (set_helper_option(transport, TRANS_OPT_FORCE_IF_INCLUDES, "true") != 0)
+			die(_("helper %s does not support --%s"),
+			    name, TRANS_OPT_FORCE_IF_INCLUDES);
+
 	if (flags & TRANSPORT_PUSH_OPTIONS) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, transport->push_options)
diff --git a/transport.c b/transport.c
index 99fe6233a3..da98ebf50e 100644
--- a/transport.c
+++ b/transport.c
@@ -664,6 +664,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_FETCH_FIRST;
 		} else if (ref->status == REF_STATUS_REJECT_NEEDS_FORCE) {
 			*reject_reasons |= REJECT_NEEDS_FORCE;
+		} else if (ref->status == REF_STATUS_REJECT_REMOTE_UPDATED) {
+			*reject_reasons |= REJECT_REF_NEEDS_UPDATE;
 		}
 	}
 	free(head);
diff --git a/transport.h b/transport.h
index ca409ea1e4..24558c027d 100644
--- a/transport.h
+++ b/transport.h
@@ -136,6 +136,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC			(1<<13)
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
+#define TRANSPORT_PUSH_FORCE_IF_INCLUDES	(1<<16)
 
 int transport_summary_width(const struct ref *refs);
 
@@ -208,6 +209,9 @@ void transport_check_allowed(const char *type);
 /* Request atomic (all-or-nothing) updates when pushing */
 #define TRANS_OPT_ATOMIC "atomic"
 
+/* Require remote changes to be integrated locally. */
+#define TRANS_OPT_FORCE_IF_INCLUDES "force-if-includes"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
@@ -217,11 +221,12 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define REJECT_NON_FF_HEAD     0x01
-#define REJECT_NON_FF_OTHER    0x02
-#define REJECT_ALREADY_EXISTS  0x04
-#define REJECT_FETCH_FIRST     0x08
-#define REJECT_NEEDS_FORCE     0x10
+#define REJECT_NON_FF_HEAD      0x01
+#define REJECT_NON_FF_OTHER     0x02
+#define REJECT_ALREADY_EXISTS   0x04
+#define REJECT_FETCH_FIRST      0x08
+#define REJECT_NEEDS_FORCE      0x10
+#define REJECT_REF_NEEDS_UPDATE 0x20
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
2.28.0

