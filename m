Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0833B27FA
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791069267; cv=none; b=f50iVZt4taAIrkQsyuerAtIdJhcD6zQ+9Z3elYbjxBDrY4f6vLrQABbodEwTi6zOM8GxjC3NlyLEA2+P1kMBLR1v6nrvVsnECam6W8U5uRnDKFJTE9GU8JBnOBRjyEj4rsFH5BUQQ2QWrbjIxT6R8uKvT8LsX3KadFlc3ziXB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791069267; c=relaxed/simple;
	bh=6itJoKQhKkwQV7rkRqEy6fLJC3Rq4Zm7Vwp0//UQjxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk8S1ZVXJxL3A6Gs+vfgaDrviLCwA447aPip21K8CLe2LlHfn6QPfk+fWwCpLMg4JnFVyA5Bh5kX2QBl/XcMh9jpqP8/jhQVmBtkW8IcDiSslooJ4Wdb1L47oD0/Ykkysb668JIlou9kkmZgBgBj8S+BcXwiOQZ4DBUHYsTJVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W86WUAbW; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W86WUAbW"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34c4a0868b6so428164eec.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791069265; x=1791674065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBL13OjYcLefuIKeRHScn+iPwhGuNiyw7Zw2O9bOgqM=;
        b=W86WUAbWXcYXKi3HhfRYj0UUJjfSv26Aj5dxe3/bjCvLBOl8lLi393aAcFnfno+kHG
         fOF7XF8VDXVz3uus0ROrU1D6CRlGj//xb/jbxcbZm+7T8N5p6J7UoZmF31oOBN5XelKT
         RF+X0UEjk6AsYR4VaBvlXtAGc4BrdnvtgWr3Z6qMad+2pu39ZWQ0tGCmkxReyZlRU3Jr
         M5XQoDVedNzGji1tK8myPZVOWOJ1TpBXK734UjWqB47zsoGLOgBzWt6kERtGzW/0+Qna
         N4dpL1/hRWWXXPFfax9BSWaOBSOF/IamANQZShkBImXw1ruekrLwbE7WQKLS2n6unWSD
         7osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791069265; x=1791674065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBL13OjYcLefuIKeRHScn+iPwhGuNiyw7Zw2O9bOgqM=;
        b=gzO2rozHs8DEIzQZV28wn72O8gUrB9RWeWWIfeZrUWRrfvczm643Cs1ScUf0bLZWDM
         4dgW7r9bxfpePjd+8GXg3mTyPu88EBOQDSa6o+rFuwhmewzVCi+EvEqeWHr37Mi7htyp
         65Q//VJMC/LFnmgblYf9yLea5ghRB5MH0q61PM5Z3d5/iLFWBVBCt6dEpDFpI1MdiDYC
         p/H9k4kkUrVKEnISO/M5/O6CVAhCR31OLd0OLQOo7mDVSCh/xgv8VIPIZlR5JlF165nG
         QGS13nB7DqrknAY+9G6T5A5i/XgmLQKIg56FmQH8M3buP+LztFKB2mT5L7rRdmOe3BjH
         nhuA==
X-Gm-Message-State: AFuF++kZhSB2M9nvPNZ8xx8IwEXITtxiZcjzPz2h2iWlOw0kcbkXzQM3
	XPo6QadSuGYi6auZFWIKuwZ30QOrmDqhg7dhcWQrr3CcnBYSBldEcsPwQXJMXw4Y
X-Gm-Gg: AYBFou0E8P3276dRG7cZVqlpnj4ZHGyxFuFd6dB8Od0nJr8dEGTDbBnnq9QSkcTodUG
	crIOzmUAgBeXi34jX+6YIQ9fFvQpMRLLsWPQprdcuKo36M7glERWN+lZNybHbo/XKaBg9/WUquF
	ddWf6bo88hgfT5pHc4ao8oOm5XyH78wYNMQprIi15e7dl0jyMXGkhIVtXFk7F3o30vaaQ+InRyH
	UG2+ROK5GUBpc/xEVCZb1rKB1EXW4W261SUU+ItnTu8+nRmJcqz8tHrA9hlcdW/pE8TLfLc6JBB
	fyOkgt0ZzOaRcHWDnMzrCgHNW4EV5N5QMy0fBV0yGuQscgsqxyOWJgnbaf6y3tWplSgeIJhokvH
	Df2hvEo4eOWgWmmEMQS+SYHjix2ox7xeuADLF5fgUSnGedsXQtLR9VEHoZTtCws0zW9VjKAkK40
	8CF10VevqbD8fVRjiFfFYHtxOz//1DqhBFjVkfeg+GFFm5XL0gQYaWg+2wL83clus11un2uSCYf
	VL2L4GvyJgNEfPv
X-Received: by 2002:a05:7022:1587:b0:148:516e:53e with SMTP id a92af1059eb24-14dd07fbc16mr14251138c88.6.1791069264494;
        Sat, 03 Oct 2026 16:14:24 -0700 (PDT)
Received: from Velociraptor ([2603:8002:cb00:3bb7:1447:c2ed:f52c:1593])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa74fa1csm9381033c88.1.2026.10.03.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 16:14:23 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v4] fetch.c: defer fetch.followRemoteHEAD validation
Date: Sat,  3 Oct 2026 16:14:22 -0700
Message-ID: <20261003231422.6004-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260925230621.179649-1-colinlewishinton@gmail.com>
References: <20260925230621.179649-1-colinlewishinton@gmail.com>
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
fetch. Leave NEEDSWORK comments at both the now unresolved call site
in do_fetch() and at the actual defect in handle_config(), so the
remaining scope is easy to find for a follow-up patch.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 builtin/fetch.c | 68 ++++++++++++++++++++++++-------------------------
 remote.c        |  7 +++++
 2 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..2cb0bcca8b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,7 +103,7 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
-	enum follow_remote_head_settings follow_remote_head;
+	char *follow_remote_head_raw;
 	int all;
 	int prune;
 	int prune_tags;
@@ -176,24 +176,33 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.followremotehead")) {
+		free(fetch_config->follow_remote_head_raw);
 		if (!v)
-			return config_error_nonbool(k);
-		else if (!strcmp(v, "never"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(v, "create"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(v, "warn"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
-		else if (!strcmp(v, "always"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
+			fetch_config->follow_remote_head_raw = xstrdup("");
 		else
-			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
+			fetch_config->follow_remote_head_raw = xstrdup(v);
 		return 0;
 	}
 
 	return git_default_config(k, v, ctx, cb);
 }
 
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+{
+	if (!setting || !*setting)
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
@@ -1918,11 +1927,10 @@ static int do_fetch(struct transport *transport,
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
@@ -1938,22 +1946,6 @@ static int do_fetch(struct transport *transport,
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
@@ -1962,8 +1954,16 @@ static int do_fetch(struct transport *transport,
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
+			else if (config->follow_remote_head_raw)
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+			else
+				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
@@ -1987,7 +1987,7 @@ static int do_fetch(struct transport *transport,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	if (do_set_head)
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
@@ -2164,7 +2164,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (do_set_head) {
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER) {
 		/*
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
@@ -2509,7 +2509,7 @@ int cmd_fetch(int argc,
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
-		.follow_remote_head = FOLLOW_REMOTE_UNCONFIGURED,
+		.follow_remote_head_raw = NULL,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
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

