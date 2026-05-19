Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C13382CD
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205120; cv=none; b=iyoLFeUbQzNZ/q+hSssPM2WqxAXOabZ9qp7WU3wX0+m2EYrNJaNsi61sOpGgjL9uugDll5Q20xstEKAqTCgBQliJHSW0aBTqTneXZzMl6+vFFTGVbL/Nao4m7+5NPvTsa0kp9Ap7WWb02xuA8ypqR5ucjrqWMiaTGeErvfUyahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205120; c=relaxed/simple;
	bh=obascepQEI0x0RWziUrwK02QV3HKB8QOueU+opwthuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZwj7jQH3f2ACt7HUaxF6yrduXnSsw3MBxv40Lv6vnPopZL8NLfCYVfuF/L8UPu37zrb5z+ge0U1Kel1BOSRzwnx9hrrt+NybJmrKPkhJiPoGKZEcsbKMW/6/bcUOZueT0pJ9HHmsjLqC6SRzRlMF4F4rwgXXCOqmCbzpkglwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdOkd2ow; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdOkd2ow"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd394f4a931so798977766b.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205116; x=1779809916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIGj8uQWre93EtA7OthgJ1muvhRXJpjrZCMNjb366Bo=;
        b=LdOkd2owmwKbrrVBGp16AM8VM0NNp3cMQda1JBVihHj96CjaHEppSm/7xSLQ8SVSej
         E6uPvCC6xE/ars4Jy1y53oZjFc2L6OcdAYLFjcpw8hDUrsXuTHyVPM5pqkrAD+MFV7NU
         tiWMmDr4KmYPpdwEcryCNl9kVUBawF5ZPk9+2wRfdWdk3wmXLXdNDvmcbuoeC8E+kBga
         NVhqmbHei7A1bOhBVGcDl+oraSzlGfKioM5ghM1ATo8aN176azl02HQFSwvP0sMS62QN
         C8uzsfJwV6jP05gM9c4WTRTHi1icbErGBxxbUKA3HVVvLqmElSzhzOp5WUOGG0smzclV
         8VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205116; x=1779809916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VIGj8uQWre93EtA7OthgJ1muvhRXJpjrZCMNjb366Bo=;
        b=OzTYPhVgBMOReqoWFeYygNFgUcYtrtMem/1IF9erc3huqfSzJ8VXT1iFBV0Fgewts7
         Gxy6qIIJzsAI4CWuxD2zMlogHsMO63l7nlmAx0vF325v7i/qHHGyyANXMbsK63ULY4x4
         wIY1uGaIoQzs+KThcH86V6A5MVbFvIsBgHltdZCi3blbsZ0NPCrK4DaLNcbkunkyRCx/
         ks26syghtbzzxqpIUWAjoZI9h8N+Z6iri6TNMdx721FpZDyRuPjwk5On7UJIuGDZ4xEY
         wZ8Nz6STRy6KOkGd3wlt8wiuVLq4DwP19d43erooyy3KwXAu8/QoUL0rZ3BG0HzCsMTk
         4HTg==
X-Gm-Message-State: AOJu0YwI9KFDehlMrBU/O2t51N/AqmTLH+ei5DfDDOfk9PkqUM6ahVcm
	a2cWT4KgrWHh/2+j5KBmgyv9HEt4Oqqa/mSKvs6S7eM4tkgiUnP54lXDU7BhKA==
X-Gm-Gg: Acq92OGIoKIFNPC/5+5lhvK+CtbmV+jwfze4SIAozY+aS8KX/2sKE40xBKS9XEMoTU+
	xpmoY3CsQ3CC9yZJyxJ1gHIS7WaCL7Eazjvotp4NF4bTlSjHEvMgfoJiIo+NWT56X8RAL6b5NDY
	Md6X1ix+6th7e+Gratt+lWnog0nzj897EX91icykItWLy56asNMRbpz+JJ2T1gXJ2DOdGHCbrmR
	0bMSB10kZbjN6OhEzj7TkBXj1we8P4gGofg1Bv0Mx3Oma/BauHqbtmCDkAQzypRjKbFrRe5d+US
	2gbcaV4mnhOaHZ5noic9zOeg6EcJJQCyJCgtuFkiaRaZ1Yui0jdSSFDFl3/JMdl8Gu3U1ynXUnX
	Rgu+TOOJswhcRhgigIfUjB/sMQxKVrWb56DGOa4yb6EFjbyXEFYL1kIH0thBV/IPAbKvTYC7vDx
	SfqBy84G9Jict0JHvjXVP/sS7mTUrCDgGWdf/6PtHPfb0L5cKpHNn0tabIgGbMO/EuJFxcKSJU3
	WRH6Hm7Hemh3+Fe31e7YjHQh8xHGsTN1q6Lqps=
X-Received: by 2002:a17:906:4fd2:b0:bcc:e8f:c3a8 with SMTP id a640c23a62f3a-bd51797a61emr1112606666b.29.1779205115706;
        Tue, 19 May 2026 08:38:35 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/8] promisor-remote: trust known remotes matching acceptFromServerUrl
Date: Tue, 19 May 2026 17:38:06 +0200
Message-ID: <20260519153808.494105-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit introduced the `promisor.acceptFromServerUrl` config
variable along with the machinery to parse and validate the URL glob
patterns and optional remote name prefixes it contains. However, these
URL patterns are not yet tied into the client's acceptance logic.

When a promisor remote is already configured locally, its fields (like
authentication tokens) may occasionally need to be refreshed by the
server. If `promisor.acceptFromServer` is set to the secure default
("None"), these updates are rejected, potentially causing future
fetches to fail.

To enable such targeted updates for trusted URLs, let's use the URL
patterns from `promisor.acceptFromServerUrl` as an additional URL
based allowlist.

Concretely, let's check the advertised URLs against the URL glob
patterns by introducing a new small helper function called
url_matches_accept_list(), which iterates over the glob patterns and
returns the first matching allowed_url entry (or NULL).

The URL matching is done component by component: scheme and port are
compared exactly, the host and path are matched with wildmatch().
Before matching, the advertised URL is passed through url_normalize()
so that case variations in the scheme/host, percent-encoding tricks,
and ".." path segments cannot bypass the allowlist.

The username and password components of the URL are intentionally
ignored during matching to allow servers to rotate them, though using
the 'token' field of the capability is preferred over embedding
credentials in the URL.

Let's then use this helper in should_accept_remote() so that, a known
remote whose URL matches the allowlist is accepted.

To prepare for this new logic, let's also:

 - Add an 'accept_urls' parameter to should_accept_remote().

 - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
   explicit 'if (accept == ACCEPT_KNOWN_URL) return' and a new
   BUG() guard in the ACCEPT_NONE case.

 - Call accept_from_server_url() from filter_promisor_remote()
   and relax its early return so that the function is entered when
   `accept_urls` has entries even if `accept == ACCEPT_NONE`.

With this, many organizations may only need something like:

  git config set --global \
          promisor.acceptFromServerUrl "https://my-org.com/*"

to accept only their own remotes. And if they need to accept additional
remotes in some specific repos, they can also set:

  git config set promisor.acceptFromServer knownUrl

and configure the additional remote manually only in the repos where
they are needed.

Let's then properly document `promisor.acceptFromServerUrl` in
"promisor.adoc" as an additive security allowlist for known remotes,
including the URL normalization behavior and the component-wise
matching, and let's mention it in "gitprotocol-v2.adoc".

Also let's clarify in the documentation how
`promisor.acceptFromServerUrl` interacts with
`promisor.acceptFromServer`:

 - Precedence: when both options are set,
   `promisor.acceptFromServerUrl` is consulted first. If a matching
   pattern leads to acceptance, the remote is accepted regardless of
   `promisor.acceptFromServer`. Otherwise the decision is left to
   `promisor.acceptFromServer`.

 - URL-mismatch guard: even when the advertised URL matches the
   allowlist, an already-existing client-side remote whose configured
   URL differs from the advertised one is not accepted through
   `promisor.acceptFromServerUrl`. `promisor.acceptFromServer=all` and
   `=knownName` keep their pre-existing, looser semantics.

The precedence paragraph is intentionally scoped here to known remotes
only (field updates). A following commit that introduces auto-creation
of unknown remotes will extend it to cover that case as well.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  74 +++++++++++++++++++
 Documentation/gitprotocol-v2.adoc     |   9 ++-
 promisor-remote.c                     | 102 +++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh |  71 ++++++++++++++++++
 4 files changed, 242 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index b0fa43b839..4a1ecb4425 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -51,6 +51,80 @@ promisor.acceptFromServer::
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
 
+promisor.acceptFromServerUrl::
+	A glob pattern to specify which server-advertised URLs a
+	client is allowed to act on. When a URL matches, the client
+	will accept the advertised remote as a promisor remote and may
+	automatically accept field updates (such as authentication
+	tokens) from the server, even if `promisor.acceptFromServer`
+	is set to `none` (the default).
++
+This option can appear multiple times in config files. An advertised
+URL will be accepted if it matches _ANY_ glob pattern specified by
+this option in _ANY_ config file read by Git.
++
+When both `promisor.acceptFromServer` and `promisor.acceptFromServerUrl`
+are set, `promisor.acceptFromServerUrl` is consulted first and takes
+precedence: if a matching pattern leads to acceptance (by accepting
+field updates for a known remote whose URL matches both the local
+configuration and the allowlist), the advertised remote is accepted
+regardless of the `promisor.acceptFromServer` setting. If no pattern
+in `promisor.acceptFromServerUrl` triggers acceptance, the decision
+is left to `promisor.acceptFromServer`.
++
+Note however that, even when an advertised URL matches a pattern in
+`promisor.acceptFromServerUrl`, an already-existing remote on the
+client whose name matches the advertised name but whose configured URL
+differs from the advertised one will _NOT_ be accepted through
+`promisor.acceptFromServerUrl`. This prevents a server from silently
+re-pointing an existing client-side remote at a different URL. (Such a
+remote may still be accepted through `promisor.acceptFromServer=all`
+or `=knownName`, which have their own, looser semantics; see the
+documentation of that option.)
++
+Be _VERY_ careful with these patterns: `*` matches any sequence of
+characters within the 'host' and 'path' parts of a URL (but cannot
+cross part boundaries). An overly broad pattern is a major security
+risk, as a matching URL allows a server to update fields (such as
+authentication tokens) on known remotes without further confirmation.
+To minimize security risks, follow these guidelines:
++
+1. Start with a secure protocol scheme, like `https://` or `ssh://`.
++
+2. Only allow domain names or paths where you control and trust _ALL_
+   the content. Be especially careful with shared hosting platforms
+   like `github.com` or `gitlab.com`. A broad pattern like
+   `https://gitlab.com/*` is dangerous because it trusts every
+   repository on the entire platform. Always restrict such patterns to
+   your specific organization or namespace (e.g.,
+   `https://gitlab.com/your-org/*`).
++
+3. Never use globs at the end of domain names. For example,
+   `https://cdn.your-org.com/*` might be safe, but
+   `https://cdn.your-org.com*/*` is a major security risk because
+   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
++
+4. Be careful using globs at the beginning of domain names. While the
+   code ensures a `*` in the host cannot cross into the path, a
+   pattern like `https://*.example.com/*` will still match any
+   subdomain. This is extremely dangerous on shared hosting platforms
+   (e.g., `https://*.github.io/*` trusts every user's site on the
+   entire platform).
++
+Before matching, both the advertised URL and the pattern are
+normalized: the scheme and host are lowercased, percent-encoded
+characters are decoded where possible, and path segments like `..`
+are resolved. The port must also match exactly (e.g.,
+`https://example.com:8080/*` will not match a URL advertised on
+port 9999). The username and password components of the URL are
+ignored during matching. Note that embedding credentials in URLs is
+discouraged. Passing authentication tokens via the `token` field of
+the `promisor-remote` capability is strongly preferred.
++
+For the security implications of accepting a promisor remote, see the
+documentation of `promisor.acceptFromServer`. For details on the
+protocol, see linkgit:gitprotocol-v2[5].
+
 promisor.checkFields::
 	A comma or space separated list of additional remote related
 	field names. A client checks if the values of these fields
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index befa697d21..2beb70595f 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -866,10 +866,11 @@ the server advertised, the client shouldn't advertise the
 
 On the server side, the "promisor.advertise" and "promisor.sendFields"
 configuration options can be used to control what it advertises. On
-the client side, the "promisor.acceptFromServer" configuration option
-can be used to control what it accepts, and the "promisor.storeFields"
-option, to control what it stores. See the documentation of these
-configuration options in linkgit:git-config[1] for more information.
+the client side, the "promisor.acceptFromServer" and
+"promisor.acceptFromServerUrl" configuration options can be used to
+control what it accepts, and the "promisor.storeFields" option, to
+control what it stores. See the documentation of these configuration
+options in linkgit:git-config[1] for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
 protocol capability could be used by the server, when responding to
diff --git a/promisor-remote.c b/promisor-remote.c
index 3f3924f587..ac4f54c590 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -14,6 +14,7 @@
 #include "url.h"
 #include "urlmatch.h"
 #include "version.h"
+#include "wildmatch.h"
 
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
@@ -742,8 +743,79 @@ static void load_accept_from_server_url(struct repository *repo,
 	}
 }
 
+static bool match_pattern_url(const char *pat, size_t pat_len,
+			      const char *url, size_t url_len)
+{
+	char *p_str = xstrndup(pat, pat_len);
+	char *u_str = xstrndup(url, url_len);
+	bool res = !wildmatch(p_str, u_str, 0);
+
+	free(p_str);
+	free(u_str);
+
+	return res;
+}
+
+static bool match_one_url(const struct url_info *pi, const struct url_info *ui)
+{
+	const char *pat = pi->url;
+	const char *url = ui->url;
+
+	/*
+	 * Schemes must match exactly. They are case-folded by
+	 * url_normalize(), so strncmp() suffices.
+	 */
+	if (pi->scheme_len != ui->scheme_len || strncmp(pat, url, pi->scheme_len))
+		return false;
+
+	/*
+	 * Ports must match exactly. url_normalize() strips default
+	 * ports (like 443 for https), so length and content
+	 * comparisons are sufficient.
+	 */
+	if (pi->port_len != ui->port_len ||
+	    strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len))
+		return false;
+
+	/*
+	 * Match host and path separately to prevent a '*' in the host
+	 * portion of the pattern from matching across the '/'
+	 * boundary into the path.
+	 */
+
+	return match_pattern_url(pat + pi->host_off, pi->host_len,
+				 url + ui->host_off, ui->host_len) &&
+		match_pattern_url(pat + pi->path_off, pi->path_len,
+				  url + ui->path_off, ui->path_len);
+}
+
+static struct allowed_url *url_matches_accept_list(
+		struct string_list *accept_urls, const char *url)
+{
+	struct string_list_item *item;
+	struct url_info url_info;
+
+	url_info.url = url_normalize(url, &url_info);
+
+	if (!url_info.url)
+		return NULL;
+
+	for_each_string_list_item(item, accept_urls) {
+		struct allowed_url *allowed = item->util;
+
+		if (match_one_url(&allowed->pattern_info, &url_info)) {
+			free(url_info.url);
+			return allowed;
+		}
+	}
+
+	free(url_info.url);
+	return NULL;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
+				struct string_list *accept_urls,
 				struct string_list *config_info)
 {
 	struct promisor_info *p;
@@ -756,23 +828,27 @@ static int should_accept_remote(enum accept_promisor accept,
 		    "this remote should have been rejected earlier",
 		    remote_name);
 
-	if (accept == ACCEPT_ALL)
-		return all_fields_match(advertised, config_info, NULL);
-
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
 
-	if (!item)
+	if (!item) {
 		/* We don't know about that remote */
+		if (accept == ACCEPT_ALL)
+			return all_fields_match(advertised, config_info, NULL);
 		return 0;
+	}
 
 	p = item->util;
 
-	if (accept == ACCEPT_KNOWN_NAME)
+	/* Known remote in the allowlist? */
+	if (!strcmp(p->url, remote_url) && url_matches_accept_list(accept_urls, remote_url))
 		return all_fields_match(advertised, config_info, p);
 
-	if (accept != ACCEPT_KNOWN_URL)
-		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+	if (accept == ACCEPT_ALL)
+		return all_fields_match(advertised, config_info, NULL);
+
+	if (accept == ACCEPT_KNOWN_NAME)
+		return all_fields_match(advertised, config_info, p);
 
 	if (strcmp(p->url, remote_url)) {
 		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
@@ -781,7 +857,13 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	return all_fields_match(advertised, config_info, p);
+	if (accept == ACCEPT_KNOWN_URL)
+		return all_fields_match(advertised, config_info, p);
+
+	if (accept != ACCEPT_NONE)
+		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+
+	return 0;
 }
 
 static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
@@ -991,7 +1073,7 @@ static void filter_promisor_remote(struct repository *repo,
 	/* Load and validate the acceptFromServerUrl config */
 	load_accept_from_server_url(repo, &accept_urls);
 
-	if (accept == ACCEPT_NONE)
+	if (accept == ACCEPT_NONE && !accept_urls.nr)
 		return;
 
 	/* Parse remote info received */
@@ -1011,7 +1093,7 @@ static void filter_promisor_remote(struct repository *repo,
 			string_list_sort(&config_info);
 		}
 
-		if (should_accept_remote(accept, advertised, &config_info)) {
+		if (should_accept_remote(accept, advertised, &accept_urls, &config_info)) {
 			if (!store_info)
 				store_info = store_info_new(repo);
 			if (promisor_store_advertised_fields(advertised, store_info))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 3b39505380..0659b2ac15 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -387,6 +387,77 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with 'None' but URL allowlisted" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'None' but URL not in allowlist" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="https://example.com/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
+test_expect_success "clone with 'None' but URL allowlisted in one pattern out of two" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="https://example.com/*" \
+		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'None', URL allowlisted, but client has different URL" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# The client configures "lop" with a different URL (serverTwo) than
+	# what the server advertises (lop). Even though the advertised URL
+	# matches the allowlist, the remote is rejected because the
+	# configured URL does not match the advertised one.
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/serverTwo" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.54.0.134.gbbe8e27878.dirty

