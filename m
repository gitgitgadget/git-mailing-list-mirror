Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB21B3725
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433245; cv=none; b=A6Rbkj3y+VLLRPlBHA00RJjUtHvrivuHoyIh2/Zk0CzU4n3HvVFII1Nq62h96MRF/905GFaiF5JkPD7hlNH/uIzOaDaXz+0iZDYlAq0hdRUtJY/dw8Z3J5LJropUszeTP11qAu4jgVgO5sUD4tiIN/aHN3V6iq7vJmB3BxWAASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433245; c=relaxed/simple;
	bh=hJlwTA+qPz1rgVod0RhTPKeC1xQyJlfg7Gw9/FmjAfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMgXqt37JgV1uf4OEnW+Yip1oxmY1C8ccaB/ISiFv/LNOl/SrnPXpHGAkbLKXdHKoyhwRn5GWztZ1+pS8T6eJs3slvSYWoyboWQnG26QoeGI37JWNtmxICbMuixtbq3e6M/jXO57A5uubLhVumOu92iuyKGdFZesNJ0NKQa4Hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQp5NYN7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQp5NYN7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1668279a12.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433241; x=1723038041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eR2ppw8yqKUtBKcBi0eacxbKntUQ9fIW8hQN9g+P2c=;
        b=mQp5NYN7oPWfjD4PaPFXFGMeXQkr1XKNcavRLnCDuaVb/65C9Uc3vTHxcKM2gpg0ld
         koF2kwRV9VwZHx3ohrZLwnjxQ+xUfEqKKFCcEOKzTFFAzuupQFNxhS04ZwgNfTecJ4C0
         PfKb15mPDvWl1ispEAHCppX0ZLe0KACA2MU5ys6euPyqwnChk9VKQQIhsCmZdsGgXna5
         neEcUSZBL0TZJ0wDULpObqkC4UdL1V77ybJpdezUlCRDnnaQJ0JW86VuRPrJlOJ3Z1Pn
         Rf7TldDqoRdA3rQ7UTlGInc+yHqwz6o5QCejG7n1ZibioUinq+cgVdGxfFuAODVxDzJB
         J4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433241; x=1723038041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eR2ppw8yqKUtBKcBi0eacxbKntUQ9fIW8hQN9g+P2c=;
        b=W9YCUqW27bThZMWQtT+W9BePaI25pirOJY5jMd7rLlN4cBcKmvVU7JMsFEkMTLvbdD
         rCVFQSmr8/pqoXVQSdzb7Aa34tNQamjUWifC41rbx/S7hbJTBsA26oVN+8k/eXnxwfTv
         jfobpx3V2of4X2pQNaxseBkljVUA1YwQlBUspkbrx768fKbdoT2Twn2SzlERLbxyujAm
         /l8F9g0+yeamf2QxsaCsHfaoMcuRSOOx62O81yBeBjEbntPcYQaf6JUFXbVWg2+ePzrf
         /3OD/9NiT/2GUULvZUBkZuHki8sFdfTO5VgVMMO3XiMVkGdsWmN0uzo2KdV9yW/J5pot
         CSzg==
X-Gm-Message-State: AOJu0YxFJGLl3PJkLCavGK66V2H8ALLRZWULFHqqn6mSAOn+YLGP79O7
	15unQgmk3s7O2R0RXa9efJ0R14Cyf6pd0wwk8ru7RL6RBlxxroOnaTyAfg==
X-Google-Smtp-Source: AGHT+IGqjv+5ngDBr06iNWYLBTCne2Aolf+putPkzh/rU6p172QiN3N3TduY6hXtUc3zr7IRab2mxA==
X-Received: by 2002:a50:c30f:0:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-5b46cf13951mr4552624a12.17.1722433240149;
        Wed, 31 Jul 2024 06:40:40 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8669641a12.56.2024.07.31.06.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:40:39 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
Date: Wed, 31 Jul 2024 15:40:13 +0200
Message-ID: <20240731134014.2299361-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.gbcb884ee16
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a server repository S borrows some objects from a promisor remote X,
then a client repository C which would like to clone or fetch from S might,
or might not, want to also borrow objects from X. Also S might, or might
not, want to advertise X as a good way for C to directly get objects from,
instead of C getting everything through S.

To allow S and C to agree on C using X or not, let's introduce a new
"promisor-remote" capability in the protocol v2, as well as a few new
configuration variables:

  - "promisor.advertise" on the server side, and:
  - "promisor.acceptFromServer" on the client side.

By default, or if "promisor.advertise" is set to 'false', a server S will
advertise only the "promisor-remote" capability without passing any
argument through this capability. This means that S supports the new
capability but doesn't wish any client C to directly access any promisor
remote X S might use.

If "promisor.advertise" is set to 'true', S will advertise its promisor
remotes with a string like:

  promisor-remote=<pm-info>[;<pm-info>]...

where each <pm-info> element contains information about a single
promisor remote in the form:

  name=<pm-name>[,url=<pm-url>]

where <pm-name> is the name of a promisor remote and <pm-url> is the
urlencoded url of the promisor remote named <pm-name>.

For now, the URL is passed in addition to the name. In the future, it
might be possible to pass other information like a filter-spec that the
client should use when cloning from S, or a token that the client should
use when retrieving objects from X.

It might also be possible in the future for "promisor.advertise" to have
other values like "onlyName", so that no URL is advertised.

By default or if "promisor.acceptFromServer" is set to "None", the
client will not accept to use the promisor remotes that might have been
advertised by the server. In this case, the client will advertise only
"promisor-remote" in its reply to the server. This means that the client
has the "promisor-remote" capability but decided not to use any of the
promisor remotes that the server might have advertised.

If "promisor.acceptFromServer" is set to "All", on the contrary, the
client will accept to use all the promisor remotes that the server
advertised and it will reply with a string like:

  promisor-remote=<pm-name>[;<pm-name>]...

where the <pm-name> elements are the names of all the promisor remotes
the server advertised. If the server advertised no promisor remote
though, the client will reply with just "promisor-remote".

In a following commit, other values for "promisor.acceptFromServer" will
be implemented so that the client will be able to decide the promisor
remotes it accepts depending on the name and URL it received from the
server. So even if that name and URL information is not used much right
now, it will be needed soon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.txt     |  13 ++
 Documentation/gitprotocol-v2.txt      |  37 ++++++
 connect.c                             |   7 +
 promisor-remote.c                     | 182 ++++++++++++++++++++++++++
 promisor-remote.h                     |  26 +++-
 serve.c                               |  21 +++
 t/t5555-http-smart-common.sh          |   1 +
 t/t5701-git-serve.sh                  |   1 +
 t/t5710-promisor-remote-capability.sh | 124 ++++++++++++++++++
 upload-pack.c                         |   3 +
 10 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100755 t/t5710-promisor-remote-capability.sh

diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
index 98c5cb2ec2..e3939d83a9 100644
--- a/Documentation/config/promisor.txt
+++ b/Documentation/config/promisor.txt
@@ -1,3 +1,16 @@
 promisor.quiet::
 	If set to "true" assume `--quiet` when fetching additional
 	objects for a partial clone.
+
+promisor.advertise::
+	If set to "true", a server will use the "promisor-remote"
+	capability, see linkgit:gitprotocol-v2[5], to advertise the
+	promisor remotes it is using if any. Default is "false", which
+	means no promisor remote is advertised.
+
+promisor.acceptFromServer::
+	If set to "all", a client will accept all the promisor remotes
+	a server might advertise using the "promisor-remote"
+	capability, see linkgit:gitprotocol-v2[5]. Default is "none",
+	which means no promisor remote advertised by a server will be
+	accepted.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 414bc625d5..4d8d3839c4 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
 
+promisor-remote=<pr-infos>
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The server may advertise some promisor remotes it is using, if it's OK
+for the server that a client uses them too. In this case <pr-infos>
+should be of the form:
+
+	pr-infos = pr-info | pr-infos ";" pr-info
+
+	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
+
+where `pr-name` is the name of a promisor remote, and `pr-url` the
+urlencoded URL of that promisor remote.
+
+In this case a client wanting to use one or more promisor remotes the
+server advertised should reply with "promisor-remote=<pr-names>" where
+<pr-names> should be of the form:
+
+	pr-names = pr-name | pr-names ";" pr-name
+
+where `pr-name` is the name of a promisor remote the server
+advertised.
+
+If the server prefers a client not to use any promisor remote the
+server uses, or if the server doesn't use any promisor remote, it
+should only advertise "promisor-remote" without any value or "=" sign
+after it.
+
+In this case, or if the client doesn't want to use any promisor remote
+the server advertised, the client should reply only "promisor-remote"
+without any value or "=" sign after it.
+
+The "promisor.advertise" and "promisor.acceptFromServer" configuration
+options can be used on the server and client side respectively to
+control what they advertise or accept respectively. See the
+documentation of these configuration options for more information.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/connect.c b/connect.c
index cf84e631e9..284ea3cf12 100644
--- a/connect.c
+++ b/connect.c
@@ -20,6 +20,7 @@
 #include "protocol.h"
 #include "alias.h"
 #include "bundle-uri.h"
+#include "promisor-remote.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
@@ -485,6 +486,7 @@ void check_stateless_delimiter(int stateless_rpc,
 static void send_capabilities(int fd_out, struct packet_reader *reader)
 {
 	const char *hash_name;
+	const char *promisor_remote_info;
 
 	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
@@ -498,6 +500,11 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	} else {
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
 	}
+	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
+		char *reply = promisor_remote_reply(promisor_remote_info);
+		packet_write_fmt(fd_out, "promisor-remote%s", reply ? reply : "");
+		free(reply);
+	}
 }
 
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
diff --git a/promisor-remote.c b/promisor-remote.c
index 317e1b127f..d347f4d9b5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -11,6 +11,7 @@
 #include "strvec.h"
 #include "packfile.h"
 #include "environment.h"
+#include "url.h"
 
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
@@ -219,6 +220,18 @@ int repo_has_promisor_remote(struct repository *r)
 	return !!repo_promisor_remote_find(r, NULL);
 }
 
+int repo_has_accepted_promisor_remote(struct repository *r)
+{
+	struct promisor_remote *p;
+
+	promisor_remote_init(r);
+
+	for (p = r->promisor_remote_config->promisors; p; p = p->next)
+		if (p->accepted)
+			return 1;
+	return 0;
+}
+
 static int remove_fetched_oids(struct repository *repo,
 			       struct object_id **oids,
 			       int oid_nr, int to_free)
@@ -290,3 +303,172 @@ void promisor_remote_get_direct(struct repository *repo,
 	if (to_free)
 		free(remaining_oids);
 }
+
+static int allow_unsanitized(char ch)
+{
+	if (ch == ',' || ch == ';' || ch == '%')
+		return 0;
+	return ch > 32 && ch < 127;
+}
+
+static void promisor_info_vecs(struct repository *repo,
+			       struct strvec *names,
+			       struct strvec *urls)
+{
+	struct promisor_remote *r;
+
+	promisor_remote_init(repo);
+
+	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
+		char *url;
+		char *url_key = xstrfmt("remote.%s.url", r->name);
+
+		strvec_push(names, r->name);
+		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
+
+		free(url);
+		free(url_key);
+	}
+}
+
+void promisor_remote_info(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int advertise_promisors = 0;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
+
+	git_config_get_bool("promisor.advertise", &advertise_promisors);
+
+	if (!advertise_promisors)
+		return;
+
+	promisor_info_vecs(repo, &names, &urls);
+
+	for (size_t i = 0; i < names.nr; i++) {
+		if (sb.len)
+			strbuf_addch(&sb, ';');
+		strbuf_addf(&sb, "name=%s", names.v[i]);
+		if (urls.v[i]) {
+			strbuf_addstr(&sb, ",url=");
+			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
+		}
+	}
+
+	strbuf_sanitize(&sb);
+	strbuf_addbuf(buf, &sb);
+
+	strvec_clear(&names);
+	strvec_clear(&urls);
+}
+
+enum accept_promisor {
+	ACCEPT_NONE = 0,
+	ACCEPT_ALL
+};
+
+static int should_accept_remote(enum accept_promisor accept,
+				const char *remote_name UNUSED,
+				const char *remote_url UNUSED)
+{
+	if (accept == ACCEPT_ALL)
+		return 1;
+
+	BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+}
+
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
+{
+	struct strbuf **remotes;
+	char *accept_str;
+	enum accept_promisor accept = ACCEPT_NONE;
+
+	if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
+		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
+			accept = ACCEPT_NONE;
+		else if (!strcasecmp("All", accept_str))
+			accept = ACCEPT_ALL;
+		else
+			warning(_("unknown '%s' value for '%s' config option"),
+				accept_str, "promisor.acceptfromserver");
+	}
+
+	if (accept == ACCEPT_NONE)
+		return;
+
+	/* Parse remote info received */
+
+	remotes = strbuf_split_str(info, ';', 0);
+
+	for (size_t i = 0; remotes[i]; i++) {
+		struct strbuf **elems;
+		const char *remote_name = NULL;
+		const char *remote_url = NULL;
+		char *decoded_url = NULL;
+
+		strbuf_trim_trailing_ch(remotes[i], ';');
+		elems = strbuf_split_str(remotes[i]->buf, ',', 0);
+
+		for (size_t j = 0; elems[j]; j++) {
+			int res;
+			strbuf_trim_trailing_ch(elems[j], ',');
+			res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
+				skip_prefix(elems[j]->buf, "url=", &remote_url);
+			if (!res)
+				warning(_("unknown element '%s' from remote info"),
+					elems[j]->buf);
+		}
+
+		decoded_url = url_decode(remote_url);
+
+		if (should_accept_remote(accept, remote_name, decoded_url))
+			strvec_push(accepted, remote_name);
+
+		strbuf_list_free(elems);
+		free(decoded_url);
+	}
+
+	free(accept_str);
+	strbuf_list_free(remotes);
+}
+
+char *promisor_remote_reply(const char *info)
+{
+	struct strvec accepted = STRVEC_INIT;
+	struct strbuf reply = STRBUF_INIT;
+
+	filter_promisor_remote(the_repository, &accepted, info);
+
+	strbuf_addch(&reply, '=');
+
+	for (size_t i = 0; i < accepted.nr; i++) {
+		if (i != 0)
+			strbuf_addch(&reply, ';');
+		strbuf_addstr(&reply, accepted.v[i]);
+	}
+
+	strvec_clear(&accepted);
+
+	return strbuf_detach(&reply, NULL);
+}
+
+void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
+{
+	struct strbuf **accepted_remotes = strbuf_split_str(remotes, ';', 0);
+
+	for (size_t i = 0; accepted_remotes[i]; i++) {
+		struct promisor_remote *p;
+
+		strbuf_trim_trailing_ch(accepted_remotes[i], ';');
+		p = repo_promisor_remote_find(r, accepted_remotes[i]->buf);
+		if (p)
+			p->accepted = 1;
+		else
+			warning(_("accepted promisor remote '%s' not found"),
+				accepted_remotes[i]->buf);
+	}
+
+	strbuf_list_free(accepted_remotes);
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 88cb599c39..82f060b5af 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -9,11 +9,13 @@ struct object_id;
  * Promisor remote linked list
  *
  * Information in its fields come from remote.XXX config entries or
- * from extensions.partialclone.
+ * from extensions.partialclone, except for 'accepted' which comes
+ * from protocol v2 capabilities exchange.
  */
 struct promisor_remote {
 	struct promisor_remote *next;
 	char *partial_clone_filter;
+	unsigned int accepted : 1;
 	const char name[FLEX_ARRAY];
 };
 
@@ -32,4 +34,26 @@ void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr);
 
+/*
+ * Append promisor remote info to buf. Useful for a server to
+ * advertise the promisor remotes it uses.
+ */
+void promisor_remote_info(struct repository *repo, struct strbuf *buf);
+
+/*
+ * Prepare a reply to a "promisor-remote" advertisement from a server.
+ */
+char *promisor_remote_reply(const char *info);
+
+/*
+ * Set the 'accepted' flag for some promisor remotes. Useful when some
+ * promisor remotes have been accepted by the client.
+ */
+void mark_promisor_remotes_as_accepted(struct repository *repo, const char *remotes);
+
+/*
+ * Has any promisor remote been accepted by the client?
+ */
+int repo_has_accepted_promisor_remote(struct repository *r);
+
 #endif /* PROMISOR_REMOTE_H */
diff --git a/serve.c b/serve.c
index 884cd84ca8..7c5c7c9856 100644
--- a/serve.c
+++ b/serve.c
@@ -12,6 +12,7 @@
 #include "upload-pack.h"
 #include "bundle-uri.h"
 #include "trace2.h"
+#include "promisor-remote.h"
 
 static int advertise_sid = -1;
 static int advertise_object_info = -1;
@@ -31,6 +32,21 @@ static int agent_advertise(struct repository *r UNUSED,
 	return 1;
 }
 
+static int promisor_remote_advertise(struct repository *r,
+				     struct strbuf *value)
+{
+       if (value)
+	       promisor_remote_info(r, value);
+       return 1;
+}
+
+static void promisor_remote_receive(struct repository *r,
+				    const char *remotes)
+{
+	mark_promisor_remotes_as_accepted(r, remotes);
+}
+
+
 static int object_format_advertise(struct repository *r,
 				   struct strbuf *value)
 {
@@ -157,6 +173,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = bundle_uri_advertise,
 		.command = bundle_uri_command,
 	},
+	{
+		.name = "promisor-remote",
+		.advertise = promisor_remote_advertise,
+		.receive = promisor_remote_receive,
+	},
 };
 
 void protocol_v2_advertise_capabilities(void)
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 3dcb3340a3..27300a8bf5 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -131,6 +131,7 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
+	promisor-remote
 	0000
 	EOF
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index c48830de8f..c858c43db2 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -22,6 +22,7 @@ test_expect_success 'test capability advertisement' '
 	object-format=$(test_oid algo)
 	EOF
 	cat >expect.trailer <<-EOF &&
+	promisor-remote
 	0000
 	EOF
 	cat expect.base expect.trailer >expect &&
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
new file mode 100755
index 0000000000..7e44ad15ce
--- /dev/null
+++ b/t/t5710-promisor-remote-capability.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='handling of promisor remote advertisement'
+
+. ./test-lib.sh
+
+# Setup the repository with three commits, this way HEAD is always
+# available and we can hide commit 1 or 2.
+test_expect_success 'setup: create "template" repository' '
+	git init template &&
+	test_commit -C template 1 &&
+	test_commit -C template 2 &&
+	test_commit -C template 3 &&
+	test-tool genrandom foo 10240 >template/foo &&
+	git -C template add foo &&
+	git -C template commit -m foo
+'
+
+# A bare repo will act as a server repo with unpacked objects.
+test_expect_success 'setup: create bare "server" repository' '
+	git clone --bare --no-local template server &&
+	mv server/objects/pack/pack-* . &&
+	packfile=$(ls pack-*.pack) &&
+	git -C server unpack-objects --strict <"$packfile"
+'
+
+check_missing_objects () {
+	git -C "$1" rev-list --objects --all --missing=print > all.txt &&
+	perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
+	test_line_count = "$2" missing.txt &&
+	test "$3" = "$(cat missing.txt)"
+}
+
+initialize_server () {
+	# Repack everything first
+	git -C server -c repack.writebitmaps=false repack -a -d &&
+
+	# Remove promisor file in case they exist, useful when reinitializing
+	rm -rf server/objects/pack/*.promisor &&
+
+	# Repack without the largest object and create a promisor pack on server
+	git -C server -c repack.writebitmaps=false repack -a -d \
+	    --filter=blob:limit=5k --filter-to="$(pwd)" &&
+	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	touch "$promisor_file" &&
+
+	# Check that only one object is missing on the server
+	check_missing_objects server 1 "$oid"
+}
+
+test_expect_success "setup for testing promisor remote advertisement" '
+	# Create another bare repo called "server2"
+	git init --bare server2 &&
+
+	# Copy the largest object from server to server2
+	obj="HEAD:foo" &&
+	oid="$(git -C server rev-parse $obj)" &&
+	oid_path="$(test_oid_to_path $oid)" &&
+	path="server/objects/$oid_path" &&
+	path2="server2/objects/$oid_path" &&
+	mkdir -p $(dirname "$path2") &&
+	cp "$path" "$path2" &&
+
+	initialize_server &&
+
+	# Configure server2 as promisor remote for server
+	git -C server remote add server2 "file://$(pwd)/server2" &&
+	git -C server config remote.server2.promisor true &&
+
+	git -C server2 config uploadpack.allowFilter true &&
+	git -C server2 config uploadpack.allowAnySHA1InWant true &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true
+'
+
+test_expect_success "fetch with promisor.advertise set to 'true'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch with promisor.advertise set to 'false'" '
+	git -C server config promisor.advertise false &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server
+'
+
+test_expect_success "fetch with promisor.acceptfromserver set to 'None'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=None \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 ""
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 0052c6a4dc..0cff76c845 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -31,6 +31,7 @@
 #include "write-or-die.h"
 #include "json-writer.h"
 #include "strmap.h"
+#include "promisor-remote.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -317,6 +318,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		strvec_push(&pack_objects.args, "--delta-base-offset");
 	if (pack_data->use_include_tag)
 		strvec_push(&pack_objects.args, "--include-tag");
+	if (repo_has_accepted_promisor_remote(the_repository))
+		strvec_push(&pack_objects.args, "--missing=allow-promisor");
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
-- 
2.46.0.4.gbcb884ee16

