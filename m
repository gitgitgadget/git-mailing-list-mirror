Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2E2D73A6
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256985; cv=none; b=AuXvnYyrFCOysmWDZaLRMjeshP5Mi6AxMty9pAYqn4ZasGtyvAbFa2Q4BwqD4kZ48ggzX0sIdfqLsmsF293MaaYXz0YABOmJ8putMO07ZGoRFcsxqC1fDKLXUBDRE3eKZKky5bs2AX/0w+/I4L3G3I/eVmOOCe3fWsDq/XQkXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256985; c=relaxed/simple;
	bh=ogXSUfHMA7nJcB0+TzBQls0GgRQHv77TUQy/RcmObIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkmZakD5SkTDPbt0SC8iw4wmPl4r8rrr5PHXeKYoCsTgRU0jv8R6G5k0PMGt5sYJyS+5UsWndSpBfRNqlFYojoFvgtDRlIvnHapYKjcNfCbsjsOK/ofKcJMH0JDUClSH+5ulbnmTjAKagphnRgUTLHBocwv56IGk7jvQRgvjrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6IGW+vH; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6IGW+vH"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so6861970eec.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791256983; x=1791861783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Li3ObDinwHxUYBSy9WgU3SH9zc5fnHV7Qp94wcEMsvs=;
        b=g6IGW+vHGGx8dtGExMo8QtSIpuNvhgQ2/lj0v4FVjYktabWhpCh0jl8a5gPsaGXlnl
         FReLX5VfTKpJnsk1n0HCBOoXVvtZRHLJ2h7P4zz0U0pL8Ct17/g3RiAJoc9SPshihbql
         /kx3KjxKOP5xvptb/swqhX+eLnjL/iDB/Dp4mUlih7URtCi/yvOEBtkdimg0vcwkpuAl
         wDLTPAFFV4sIbI4mjKDTGk6+lkGIAWRpsPcqWC0Vd3IoYMke7MqL7MOk/bOSxDD1o837
         65Cmc1ltvMG1/nOzw38dFFxhMmY4t6/ZLe9C80EFTqnz2FLCHmuROy7kgv191J+2SV18
         XTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256983; x=1791861783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Li3ObDinwHxUYBSy9WgU3SH9zc5fnHV7Qp94wcEMsvs=;
        b=iWAVGIDWlpw42dgEC5z3wXIyPPbiuNvrG8GCHql7tv3Rk4edjj7ZWC+ihs4SEemSal
         Ulb/TRZmWSGS5sU4Mkpl94SuNkiLNSxiUzIv0JRO/ik91cK39UdPtkt+80XBUsUTdix5
         vUNkv6CC2Kij94X01dMRgSJLIePCUFEC9veC7sx0YaI4I1IhF+DdEWyamFPRT9g/of5Z
         pMWmhFomFpZvbHIg5eTtH4ynS+PqYRiYruqFGNOxxfJNegJhPObrE6eWIAp0iCNeYql3
         tYsFbko1cdZAi+ApeV07cASaolbLu74HtBRJRZeAKDQId704/hfqfWN6uY9jc3TJMOrZ
         2pMg==
X-Gm-Message-State: AFuF++m6LXcXHXsfw8Q5CLkr5sZanFekn8SXSa4pEwHzGjuzuZo8dweQ
	ayIjkxLmDauQVjwx76MionaYmuy9ZGNPrXJroy/WqYmUxChpde3GGBgqhVKBNo1K
X-Gm-Gg: AYBFou3vzDCqWM9u5JDHxjdu+NGQXCRu7iaAazvl6pMWKxGGJXW0GlRBASdEyuIYmCy
	lZ30SkxO9KlycZXcRVlMbjegzQbE9AAsuHoWAtWiitwQWN+bIqzQjOg76xZ61JtCjROZpciZkvC
	GV7wc4GfWjAdPh6xtzOmPtqPATuZrF7gfPTQE1Gcrl1D7IC1vI7tvaLcosToxxpXEb2wvZHTNs5
	osxbnpu2zN58zQdFPDPKHJN1V0k27n/xGbEuacKccqg3JM6zhtQTTdqhO1+pXdOa90ILAvpulkn
	4s6taHWYn6spwQpgqrCnNkCooqrOgYNLM+pqIFuD4blIeFxBPugB359tE1musiq3JkU/7KBpLHG
	LU1lX6qdvXyjC8eFwwYcj6CFyTbRJm4TLeP3pVyUezjIry2PMNh3MEBu1haK+ZfO78lRRpOMpiB
	y1pBDV8nVUubMqscB+5yJn8vZFnglpTybzvMHHRP6fAzvAkyXjJera4PsdwmhUXufbKJwWu6Zxo
	rxqmebJYovwSBiXzw==
X-Received: by 2002:a05:7300:24c9:b0:351:2696:bf86 with SMTP id 5a478bee46e88-3512696c138mr8654724eec.14.1791256982749;
        Mon, 05 Oct 2026 20:23:02 -0700 (PDT)
Received: from Velociraptor ([2603:8002:cb00:3bb7:be3b:8505:4aaf:999b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b0fdc4sm2971456eec.25.2026.10.05.20.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:23:02 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v6] fetch.c: defer fetch.followRemoteHEAD validation
Date: Mon,  5 Oct 2026 20:22:58 -0700
Message-ID: <20261006032258.6561-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261004201428.5210-1-colinlewishinton@gmail.com>
References: <20261004201428.5210-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the fetch.followRemoteHEAD configuration variable is
validated while the configuration file is being parsed, which
produces a warning even when this particular "git fetch" invocation
will never consult it.

Store the raw config string instead, and resolve/validate it lazily
at the one place in do_fetch() that actually uses it, so a mistyped
value only warns, and a missing value only dies, when this fetch
would have consulted it.

remote.c's handle_config() has the same problem for
remote.<name>.followRemoteHEAD, but is left unaddressed here since
it touches shared remote-parsing infrastructure used well beyond
fetch. Leave a NEEDSWORK comment at remote.c:handle_config()
that has a defect similar to what is fixed by this patch,
so the remaining scope is easy to find for a follow-up patch.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 builtin/fetch.c | 73 +++++++++++++++++++++++++------------------------
 remote.c        |  7 +++++
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..d800978c38 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,7 +103,8 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
-	enum follow_remote_head_settings follow_remote_head;
+	char *follow_remote_head_raw;
+	int follow_remote_head_seen;
 	int all;
 	int prune;
 	int prune_tags;
@@ -176,24 +177,31 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.followremotehead")) {
-		if (!v)
-			return config_error_nonbool(k);
-		else if (!strcmp(v, "never"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(v, "create"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(v, "warn"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
-		else if (!strcmp(v, "always"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
-		else
-			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
+		free(fetch_config->follow_remote_head_raw);
+		fetch_config->follow_remote_head_raw = xstrdup_or_null(v);
+		fetch_config->follow_remote_head_seen = 1;
 		return 0;
 	}
 
 	return git_default_config(k, v, ctx, cb);
 }
 
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+{
+	if (!setting)
+		die(_("missing value for 'fetch.followRemoteHEAD'"));
+	else if (!strcmp(setting, "never"))
+		return FOLLOW_REMOTE_NEVER;
+	else if (!strcmp(setting, "create"))
+		return FOLLOW_REMOTE_CREATE;
+	else if (!strcmp(setting, "warn"))
+		return FOLLOW_REMOTE_WARN;
+	else if (!strcmp(setting, "always"))
+		return FOLLOW_REMOTE_ALWAYS;
+	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
+	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+}
+
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -1918,11 +1926,10 @@ static int do_fetch(struct transport *transport,
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
-	int do_set_head = 0;
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
-	int follow_remote_head;
+	int follow_remote_head = FOLLOW_REMOTE_NEVER;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1938,22 +1945,6 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	/*
-	 * NEEDSWORK: By the time this function executes, we have already parsed
-	 * all such followRemoteHEAD values from the external configuration,
-	 * potentially emitting warning messages for bogus values.  Ideally, if
-	 * this fetch ends up not needing to consult these values, then git would
-	 * not ever output a value warning. (eg: when pulling from a URL directly -
-	 * rather than a configured remote, or when a remote's followRemoteHEAD
-	 * overrides the fallback fetch setting)
-	 */
-	if (transport->remote->follow_remote_head)
-		follow_remote_head = transport->remote->follow_remote_head;
-	else if (config->follow_remote_head)
-		follow_remote_head = config->follow_remote_head;
-	else
-		follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
@@ -1962,8 +1953,16 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
+			/*
+			 * See remote.c's handling of remote.<name>.followRemoteHEAD
+			 * for the analogous, still-unresolved case.
+			 */
+			if (transport->remote->follow_remote_head)
+				follow_remote_head = transport->remote->follow_remote_head;
+			else if (config->follow_remote_head_seen)
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+			else
+				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
@@ -1987,7 +1986,7 @@ static int do_fetch(struct transport *transport,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	if (do_set_head)
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
@@ -2164,7 +2163,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (do_set_head) {
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER) {
 		/*
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
@@ -2509,7 +2508,8 @@ int cmd_fetch(int argc,
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
-		.follow_remote_head = FOLLOW_REMOTE_UNCONFIGURED,
+		.follow_remote_head_raw = NULL,
+		.follow_remote_head_seen = 0,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
@@ -2929,5 +2929,6 @@ int cmd_fetch(int argc,
  cleanup:
 	string_list_clear(&list, 0);
 	list_objects_filter_release(&filter_options);
+	free(config.follow_remote_head_raw);
 	return result;
 }
diff --git a/remote.c b/remote.c
index fe62068463..58f3436222 100644
--- a/remote.c
+++ b/remote.c
@@ -582,6 +582,13 @@ static int handle_config(const char *key, const char *value,
 					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
+		/*
+		 * NEEDSWORK: this is validated/warned about here, during config
+		 * parsing, regardless of whether the fetch that triggered this
+		 * parse will ever consult it for this particular remote. See
+		 * fetch.c's deferred handling of fetch.followRemoteHEAD for the
+		 * pattern this should likely follow.
+		 */
 		if (!strcmp(value, "never"))
 			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
 		else if (!strcmp(value, "create"))
-- 
2.55.0.windows.3

