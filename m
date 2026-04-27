Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C763B9618
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293701; cv=none; b=TBt11Dupra8WUuW5OdLTUb0WDZu9j01eIr2YWPoR+odTFMueY7nlGuRfDpAlLheFu2EnTFNnNhKFzAl8KwDgsZFQvzYDUQPEcIoyMlkdSq3RmhD2pKqGJlPgcvYGuPNBoudtJXcx1nARcrZciKwXV/DR6S64WCaKeviY61IMp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293701; c=relaxed/simple;
	bh=SB424Jq8IDxk8iiElXedKYGjCaNG2i8ZY0yA24lKeEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeb32bN5/uiILW07QzfDNVEH1kUGlum65YzEGJHdOvH/PSrkRPP0xmnyj8+3JfXYLWowwRrMpkKCzKRMSY77Ca4FKdhkIdIvX4BHJjETlLSavFx4kKabhR7GpFQVeyD0fErhsvaPmAg1WJBJPsOBZqd9yKCrl4DRouZLJbLMaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdwHxqHD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdwHxqHD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so15315945a12.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293698; x=1777898498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbRN28dCcTxcP/HyVN7nudMDmE2SJ/Akq2fj0dI+RKg=;
        b=RdwHxqHDd6NEsB/YrObKxJITjnnurFLhOsaYy0H+sI4TL+Kcmnu43kGDa+2Vno6nRo
         ZSavuHIJwVEPG9cOJqb3PItFiL/5peiO4ErHHVzZQq/OmItsW8yN4AdgeJcRg1R7xzUR
         DQ7VzNkwHGR0yThQU2jc7TXU8n7yxuYzNTEkJc5qi3hp501wBKyboar//B7AK0ssnmw1
         7qUjWGZpTIfm9kHn17kX222Dr8S5j189kFE8p/kbeULoR4F2yc+Kq7m3B9laIVfCzW5a
         UwlHkY9/o+iu894goDkPjAnT8W3z1CLO9Y3PWBOtktTHJd+b9wjpzTO+lO3BDE72GXM9
         sRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293698; x=1777898498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbRN28dCcTxcP/HyVN7nudMDmE2SJ/Akq2fj0dI+RKg=;
        b=aar+bGK+H3SXZwXLhKF0x+J8BiYSsW8dIdh1MBr7v/hQwo6YAhAF6PXbsUkrgK58gs
         g9gqBPz9u7Eqwy2eJhvNf2Pdrq4XiUnfJnWgmwLC7+9Cu1wNCvXUjFUH/QjYQZTJvILr
         kDhGaWUM/bmGFAK7rRqzV9NICBNzeJdWQkXhT28t8XHgl/uXpRw8q3dQUoZUfJsdF4H0
         BdvHTgUFm3v3HLcCwTK17YapRLsAdC7+xXXb9S8Lm2onqGzwkgKdYdF+IbRiD2oqSat+
         bdd54qiA7EoZrYNmE4X4f4nt7kxbYpHUcWtP8xEKdayPbBK6BfIFak1Ih0CTu9FJu0PR
         iKGw==
X-Gm-Message-State: AOJu0YzNrcbHRnXoRzGCDLPZCbT9/nAaz8Wo3cmN+l/hjzH6w0RocWbA
	7OPlwQay2vWPHrwTlKDRjbze1k8IX+1PU6y8+DMMCLoMNLN8QqsEVmvMHkjJLQ==
X-Gm-Gg: AeBDieusqk+sBNr/cOOKSLfPSlySEXXpKJoc8Us+ftLahj2/ufs+jVoHR+7pOpD08d2
	5wI6Om8q2qdXpKhAHgS5Ws1ohKrGsLXG0bdLUQtoteHrm99KsgO+E9FxukfOiGbo9GjAAG3iind
	V1Z5togasWOLK/97TdiZLQvjFxJNaHSYgGU7QsyJ10DIQA6u5oLM+5tRMeLM2MG2yZrdLdiES54
	B9gaHSfEibC+qKmYq78m6ya+WM5oR1okKjbw/HcucYMYKjfDwtrBp0oJSEW9fCnmFhFhQtNyVzD
	lA8Nvwx1dEhawXOlpT4hEeJSKz7sg2c+A4g1eyqiD9MM9VDIE8QzCUbO2nmSWU7YEERJp6aNDEI
	TbqZ1KOgdJITxJCkvdcRLuBRV5yVw8GhyxY5QRb6iXwOe4H9kT6vsw+UQlc2qRDExK6h+HsYheB
	rYFqiKNWTLQv+8HhyOv+XEAxvdCEQxbCNvGBVklFrVNL0DsjRGeckM33s7LQT7i/jDumS+2nGl/
	t0SHck1+VZS6TI5pBdFzP9ghOnyl7+7P52td4nOXP2y8m/asI9mw5Q0M39S
X-Received: by 2002:a05:6402:3891:b0:678:a507:e80d with SMTP id 4fb4d7f45d1cf-678a507eae8mr7036042a12.22.1777293697242;
        Mon, 27 Apr 2026 05:41:37 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 7/8] promisor-remote: auto-configure unknown remotes
Date: Mon, 27 Apr 2026 14:41:07 +0200
Message-ID: <20260427124108.3524129-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have introduced the `promisor.acceptFromServerUrl`
config variable to allowlist some URLs advertised by a server through
the "promisor-remote" protocol capability.

However the new `promisor.acceptFromServerUrl` mechanism, like the old
`promisor.acceptFromServer` mechanism, still requires a remote to
already exist in the client's local configuration before it can be
accepted. This places a significant manual burden on users to
pre-configure these remotes, and creates friction for administrators
who have to troubleshoot or manually provision these setups for their
teams.

To eliminate this burden, let's automatically create a new `[remote]`
section in the client's config when a server advertises an unknown
remote whose URL matches a `promisor.acceptFromServerUrl` glob pattern.

Concretely, let's add four helpers:

 - sanitize_remote_name(): turn an arbitrary URL-derived string into a
   valid remote name by replacing non-alphanumeric characters,
   collapsing runs of '-', and prepending "promisor-auto-".

 - promisor_remote_name_from_url(): normalize the URL and extract
   host+port+path to build a human-readable base name, then pass it
   through sanitize_remote_name().

 - configure_auto_promisor_remote(): write the remote.*.url,
   remote.*.promisor and remote.*.advertisedAs keys to the repo
   config.

 - handle_matching_allowed_url(): pick the final name (user-supplied
   alias or auto-generated), handle collisions by appending "-1",
   "-2", etc., then call configure_auto_promisor_remote().

Let's also add should_accept_new_remote_url() which reuses the
url_matches_accept_list() helper introduced in a previous commit to
find a matching pattern, then delegates to handle_matching_allowed_url()
to create the remote.

And then let's call should_accept_new_remote_url() from the '!item'
(unknown remote) branch of should_accept_remote(), setting
`reload_config` so that the newly-written config is picked up.

Finally let's document all that by:

 - expanding the `promisor.acceptFromServerUrl` entry to describe
   auto-creation, the optional "name=" prefix syntax, the
   "promisor-auto-*" generation rules, and numeric-suffix collision
   handling, and by
 - adding a "remote.<name>.advertisedAs" entry to "remote.adoc".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  26 +++-
 Documentation/config/remote.adoc      |   9 ++
 promisor-remote.c                     | 202 +++++++++++++++++++++++++-
 t/t5710-promisor-remote-capability.sh | 104 +++++++++++++
 4 files changed, 332 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index efc066c3f2..ae1686a6e0 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -54,7 +54,8 @@ promisor.acceptFromServer::
 promisor.acceptFromServerUrl::
 	A glob pattern to specify which server-advertised URLs a
 	client is allowed to act on. When a URL matches, the client
-	will accept the advertised remote as a promisor remote and may
+	will accept the advertised remote as a promisor remote, may
+	automatically create a new remote configuration for it and may
 	automatically accept field updates (such as authentication
 	tokens) from the server, even if `promisor.acceptFromServer`
 	is set to `none` (the default).
@@ -66,9 +67,10 @@ this option in _ANY_ config file read by Git.
 Be _VERY_ careful with these patterns: `*` matches any sequence of
 characters within the 'host' and 'path' parts of a URL (but cannot
 cross part boundaries). An overly broad pattern is a major security
-risk, as a matching URL allows a server to update fields (such as
-authentication tokens) on known remotes without further confirmation.
-To minimize security risks, follow these guidelines:
+risk, as a matching URL allows a server to auto-configure new remotes
+and to update fields (such as authentication tokens) on known remotes
+without further confirmation. To minimize security risks, follow these
+guidelines:
 +
 1. Start with a secure protocol scheme, like `https://` or `ssh://`.
 +
@@ -99,6 +101,22 @@ are resolved. The port must also match exactly (e.g.,
 `https://example.com:8080/*` will not match a URL advertised on
 port 9999).
 +
+The glob pattern can optionally be prefixed with a remote name and an
+equals sign (e.g., `cdn=https://cdn.example.com/*`). If such a prefix
+is provided, accepted remotes will be saved under that name. If no
+such prefix is provided, a safe remote name will be automatically
+generated by sanitizing the URL and prefixing it with
+`promisor-auto-`.
++
+If a remote with the chosen name already exists but points to a
+different URL, Git will append a numeric suffix (e.g., `-1`, `-2`) to
+the name to prevent overwriting existing configurations. You should
+make sure that this doesn't happen often though, as remotes will be
+rejected if the numeric suffix increases too much. In all cases, the
+original name advertised by the server is recorded in the
+`remote.<name>.advertisedAs` configuration variable for tracing and
+debugging purposes.
++
 For the security implications of accepting a promisor remote, see the
 documentation of `promisor.acceptFromServer`. For details on the
 protocol, see linkgit:gitprotocol-v2[5].
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..6e2bbdf457 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -91,6 +91,15 @@ remote.<name>.promisor::
 	When set to true, this remote will be used to fetch promisor
 	objects.
 
+remote.<name>.advertisedAs::
+	When a promisor remote is automatically configured using
+	information advertised by a server through the
+	`promisor-remote` protocol capability (see
+	`promisor.acceptFromServerUrl`), the server's originally
+	advertised name is saved in this variable. This is for
+	information, tracing and debugging purposes. Users should not
+	typically modify or create such configuration entries.
+
 remote.<name>.partialclonefilter::
 	The filter that will be applied when fetching from this	promisor remote.
 	Changing or clearing this value will only affect fetches for new commits.
diff --git a/promisor-remote.c b/promisor-remote.c
index 72d5b94bf7..8c8a798fdb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -816,10 +816,197 @@ static struct allowed_url *url_matches_accept_list(
 	return NULL;
 }
 
-static int should_accept_remote(enum accept_promisor accept,
+/*
+ * Sanitize the buffer to make it a valid remote name coming from the
+ * server by:
+ *
+ * - replacing any non alphanumeric character with a '-'
+ * - stripping any leading '-',
+ * - condensing multiple '-' into one,
+ * - prepending "promisor-auto-",
+ * - validating the result.
+ */
+static int sanitize_remote_name(struct strbuf *buf, const char *url)
+{
+	char prev = '-';
+	for (size_t i = 0; i < buf->len; ) {
+		if (!isalnum(buf->buf[i]))
+			buf->buf[i] = '-';
+		if (prev == '-' && buf->buf[i] == '-') {
+			strbuf_remove(buf, i, 1);
+		} else {
+			prev = buf->buf[i];
+			i++;
+		}
+	}
+
+	strbuf_strip_suffix(buf, "-");
+
+	if (!buf->len) {
+		warning(_("couldn't generate a valid remote name from "
+			  "advertised url '%s', ignoring this remote"), url);
+		return -1;
+	}
+
+	strbuf_insertstr(buf, 0, "promisor-auto-");
+
+	if (!valid_remote_name(buf->buf)) {
+		warning(_("generated remote name '%s' from advertised url '%s' "
+			  "is invalid, ignoring this remote"), buf->buf, url);
+		return -1;
+	}
+
+	return 0;
+}
+
+static char *promisor_remote_name_from_url(const char *url)
+{
+	struct url_info url_info = { 0 };
+	char *normalized = url_normalize(url, &url_info);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!normalized) {
+		warning(_("couldn't normalize advertised url '%s', "
+			  "ignoring this remote"), url);
+		return NULL;
+	}
+
+	if (url_info.host_len) {
+		strbuf_add(&buf, normalized + url_info.host_off, url_info.host_len);
+		strbuf_addch(&buf, '-');
+	}
+
+	if (url_info.port_len) {
+		strbuf_add(&buf, normalized + url_info.port_off, url_info.port_len);
+		strbuf_addch(&buf, '-');
+	}
+
+	if (url_info.path_len) {
+		strbuf_add(&buf, normalized + url_info.path_off, url_info.path_len);
+		strbuf_trim_trailing_dir_sep(&buf);
+		strbuf_strip_suffix(&buf, ".git");
+	}
+
+	free(normalized);
+
+	if (sanitize_remote_name(&buf, url)) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+static void configure_auto_promisor_remote(struct repository *repo,
+					   const char *name,
+					   const char *url,
+					   const char *advertised_as,
+					   bool reuse)
+{
+	char *key;
+
+	if (!reuse) {
+		fprintf(stderr, _("Auto-creating promisor remote '%s' for URL '%s'\n"),
+			name, url);
+
+		key = xstrfmt("remote.%s.url", name);
+		repo_config_set_gently(repo, key, url);
+		free(key);
+	}
+
+	/* NB: when reusing, this promotes an existing non-promisor remote */
+	key = xstrfmt("remote.%s.promisor", name);
+	repo_config_set_gently(repo, key, "true");
+	free(key);
+
+	if (advertised_as) {
+		key = xstrfmt("remote.%s.advertisedAs", name);
+		repo_config_set_gently(repo, key, advertised_as);
+		free(key);
+	}
+}
+
+#define MAX_REMOTES_WITH_SIMILAR_NAMES 20
+
+/* Return the allocated local name, or NULL on failure */
+static char *handle_matching_allowed_url(struct repository *repo,
+					 char *allowed_name,
+					 const char *remote_url,
+					 const char *remote_name)
+{
+	char *name;
+	char *basename = allowed_name ?
+		xstrdup(allowed_name) :
+		promisor_remote_name_from_url(remote_url);
+	int i = 0;
+	bool reuse = false;
+
+	if (!basename)
+		return NULL;
+
+	name = xstrdup(basename);
+
+	while (i < MAX_REMOTES_WITH_SIMILAR_NAMES) {
+		char *url_key = xstrfmt("remote.%s.url", name);
+		const char *existing_url;
+		int exists = !repo_config_get_string_tmp(repo, url_key, &existing_url);
+
+		free(url_key);
+
+		if (!exists)
+			break; /* Free to use */
+
+		if (!strcmp(existing_url, remote_url)) {
+			reuse = true;
+			break; /* Same URL, so safe to reuse */
+		}
+
+		i++;
+		free(name);
+		name = xstrfmt("%s-%d", basename, i);
+	}
+
+	if (i < MAX_REMOTES_WITH_SIMILAR_NAMES) {
+		configure_auto_promisor_remote(repo, name,
+					       remote_url, remote_name,
+					       reuse);
+	} else {
+		warning(_("too many remotes accepted with name like '%s-X', "
+			  "ignoring this remote"), basename);
+		FREE_AND_NULL(name);
+	}
+
+	free(basename);
+	return name;
+}
+
+static int should_accept_new_remote_url(struct repository *repo,
+					struct string_list *accept_urls,
+					struct promisor_info *advertised)
+{
+	struct allowed_url *allowed = url_matches_accept_list(accept_urls,
+							     advertised->url);
+	if (allowed) {
+		char *name = handle_matching_allowed_url(repo,
+							 allowed->remote_name,
+							 advertised->url,
+							 advertised->name);
+		if (name) {
+			free((char *)advertised->local_name);
+			advertised->local_name = name;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int should_accept_remote(struct repository *repo,
+				enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *accept_urls,
-				struct string_list *config_info)
+				struct string_list *config_info,
+				bool *reload_config)
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
@@ -837,9 +1024,13 @@ static int should_accept_remote(enum accept_promisor accept,
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
 
-	if (!item)
+	if (!item) {
 		/* We don't know about that remote */
-		return 0;
+		int res = should_accept_new_remote_url(repo, accept_urls, advertised);
+		if (res)
+			*reload_config = true;
+		return res;
+	}
 
 	p = item->util;
 
@@ -1097,7 +1288,8 @@ static void filter_promisor_remote(struct repository *repo,
 			string_list_sort(&config_info);
 		}
 
-		if (should_accept_remote(accept, advertised, &accept_urls, &config_info)) {
+		if (should_accept_remote(repo, accept, advertised, &accept_urls,
+					 &config_info, &reload_config)) {
 			if (!store_info)
 				store_info = store_info_new(repo);
 			if (promisor_store_advertised_fields(advertised, store_info))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 0659b2ac15..549acff23f 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -458,6 +458,107 @@ test_expect_success "clone with 'None', URL allowlisted, but client has differen
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with URL allowlisted and no remote already configured" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+	test_when_finished "rm -f full_names" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that exactly one remote has been auto-created, identified
+	# by "remote.<name>.advertisedAs" == "lop".
+	git -C client config get --all --show-names --regexp \
+		"remote\..*\.advertisedas" >full_names &&
+	test_line_count = 1 full_names &&
+	REMOTE_NAME=$(sed "s/^remote\.\(.*\)\.advertisedas .*$/\1/" full_names) &&
+
+	# Check ".url" and ".promisor" values
+	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" >expect &&
+	git -C client config "remote.$REMOTE_NAME.url" >actual &&
+	git -C client config "remote.$REMOTE_NAME.promisor" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with named URL allowlisted and no pre-configured remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that a remote has been auto-created with the right "cdn" name and fields.
+	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	git -C client config "remote.cdn.advertisedAs" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with URL allowlisted but colliding name" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.cdn.promisor=true \
+		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.cdn.url="https://example.com/cdn" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that a remote has been auto-created with the right "cdn-1" name and fields.
+	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
+	git -C client config "remote.cdn-1.url" >actual &&
+	git -C client config "remote.cdn-1.promisor" >>actual &&
+	git -C client config "remote.cdn-1.advertisedAs" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the original "cdn" remote was not overwritten.
+	printf "%s\n" "https://example.com/cdn" "true" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with URL allowlisted and reusable remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.cdn.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the existing "cdn" remote has been properly updated.
+	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" "+refs/heads/*:refs/remotes/lop/*" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	git -C client config "remote.cdn.advertisedAs" >>actual &&
+	git -C client config "remote.cdn.fetch" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that no new "cdn-1" remote has been created.
+	test_must_fail git -C client config "remote.cdn-1.url" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
@@ -472,6 +573,9 @@ test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
 	# Check that a warning was emitted
 	test_grep "invalid remote name '\''bad name'\''" err &&
 
+	# Check that no remote was auto-created
+	test_must_fail git -C client config get --regexp "remote\..*\.advertisedas" &&
+
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 "" &&
 
-- 
2.54.0.19.gb68b9497aa

