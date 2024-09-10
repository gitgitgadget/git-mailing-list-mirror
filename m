Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512C38F9C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985828; cv=none; b=QUuNmUNGY0ITl49nK/GwcTkVZwPvw3d+lhpvDUlqguVj4y6WVljpgQiXEKpHaG8rn6NumLQgWzbMt/DE9cSncR6y8r31RDv28bkkGnQjcnxSZHtEmUJfF+zf8denwTVWoBDJnHmDoAgMezo7pLrOAF+CwDZyfxz70vBB3koYXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985828; c=relaxed/simple;
	bh=Ja9yno0OY0m4HCmmF+dXns0TB5JmALBNjGErubllYGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWpQKcysqg1ajgDP9lx+JEMEd5Fc2qQ/O1Z2HkxCQxA1b0NjoqC5QjNWXSQOc+BypWjetuR3+CvHrzen12eVQe5v9brlQitEhTqbiDxcAh6KkqR3Us0+cyLft8nIU48xNZnO+zE3pm+VV3MT2c6tySMmGoIAicmKS0SgUtC4IbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U11dp0Ou; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U11dp0Ou"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so44419335e9.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985823; x=1726590623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDvowuXzQh66ztbbksfGQJJCtfSBncvWNLO9yP0YsA8=;
        b=U11dp0OuJL2gK0ySOtwDtzwo86wQFCgYoNwBnLqIatrMe3OJ9FtOA0JODmzn1xJDgo
         6+CLXor6Ju3rmDT3i+bt4P/MKpTGPnkC+IWDYX7TUF01sXd3ntTXYnYbTRpCwz2N9ZYr
         s6m0jc/iJujodcD1ZmgJMv/bCRKnQdYf8ASblHvM4wOdou+knFRZ+nZ4XRJq81P0L2AC
         wemKdRsKVFpEZwFSsy690UoRhl0CD/JVzZuhTw8GuclGlh+GNgevRYJ67rWeIvX460k2
         3C3SPdSyztLkPZ2abgGLqEY4eJVY1yB4OXjNQnsrUVoZArIQqdSbUI4Y0W+z3bcLOW/q
         SeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985823; x=1726590623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDvowuXzQh66ztbbksfGQJJCtfSBncvWNLO9yP0YsA8=;
        b=DUc9DD8+ZzJBM+320Y+CmEwo+qlWWLtE2dC/4/lCi4nK10mnVJvdz3tocX4WYQfUTe
         LhDmd9gtaQrMriXL10KaZbEp4J0rgxIobWLED6f9TytD1X3B7J5brcUYv+6l3ZFUXyIv
         nuwb736c2Y2dqPff9rexf8+kFJFUuHr9luKV55RkJiJNgMFyIG8fuCUFb3dFMy+i2IB+
         9fiKgB9iJzc4V+7IuRXybP6Hlm8WNw/XrPjGh5ShskrGCkZOlOv0zRWX/Mv6S1d1vK20
         dWBRqy/cixcnDtTPD5wn752RvTcLLDFxMtPFV1IeHT1HSWzFoPe32slUsxBas8LjI3DI
         Xjeg==
X-Gm-Message-State: AOJu0Yw9Mc3rysVjSvq8AP1sKnXjLAXGJsNm7qnJZCe1NxyZV5LHX0MC
	u1FqNY0TI7SRNNz1BEDcWh70cay1UIsJSowAKjGkrso5YlR0KHZdC3W8rQ==
X-Google-Smtp-Source: AGHT+IElZCevoiv4wt55LpxCpcXh+nRHoCMnbA1pdYjxuFZKFD04ql71JYj7A69y+WYEB320TugF1Q==
X-Received: by 2002:a7b:ca4e:0:b0:42c:a6da:a149 with SMTP id 5b1f17b1804b1-42cad87efa4mr95631605e9.25.1725985823280;
        Tue, 10 Sep 2024 09:30:23 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm29897865e9.0.2024.09.10.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:30:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
Date: Tue, 10 Sep 2024 18:29:59 +0200
Message-ID: <20240910163000.1985723-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.g7a37e584ed
In-Reply-To: <20240910163000.1985723-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a server S knows that some objects from a repository are available
from a promisor remote X, S might want to suggest to a client C cloning
or fetching the repo from S that C should use X directly instead of S
for these objects.

Note that this could happen both in the case S itself doesn't have the
objects and borrows them from X, and in the case S has the objects but
knows that X is better connected to the world (e.g., it is in a
$LARGEINTERNETCOMPANY datacenter with petabit/s backbone connections)
than S. Implementation of the latter case, which would require S to
omit in its response the objects available on X, is left for future
improvement though.

Then C might or might not, want to get the objects from X, and should
let S know about this.

To allow S and C to agree and let each other know about C using X or
not, let's introduce a new "promisor-remote" capability in the
protocol v2, as well as a few new configuration variables:

  - "promisor.advertise" on the server side, and:
  - "promisor.acceptFromServer" on the client side.

By default, or if "promisor.advertise" is set to 'false', a server S will
not advertise the "promisor-remote" capability.

If S doesn't advertise the "promisor-remote" capability, then a client C
replying to S shouldn't advertise the "promisor-remote" capability
either.

If "promisor.advertise" is set to 'true', S will advertise its promisor
remotes with a string like:

  promisor-remote=<pr-info>[;<pr-info>]...

where each <pr-info> element contains information about a single
promisor remote in the form:

  name=<pr-name>[,url=<pr-url>]

where <pr-name> is the urlencoded name of a promisor remote and
<pr-url> is the urlencoded URL of the promisor remote named <pr-name>.

For now, the URL is passed in addition to the name. In the future, it
might be possible to pass other information like a filter-spec that the
client should use when cloning from S, or a token that the client should
use when retrieving objects from X.

It might also be possible in the future for "promisor.advertise" to have
other values. For example a value like "onlyName" could prevent S from
advertising URLs, which could help in case C should use a different URL
for X than the URL S is using. (The URL S is using might be an internal
one on the server side for example.)

By default or if "promisor.acceptFromServer" is set to "None", C will
not accept to use the promisor remotes that might have been advertised
by S. In this case, C will not advertise any "promisor-remote"
capability in its reply to S.

If "promisor.acceptFromServer" is set to "All" and S advertised some
promisor remotes, then on the contrary, C will accept to use all the
promisor remotes that S advertised and C will reply with a string like:

  promisor-remote=<pr-name>[;<pr-name>]...

where the <pr-name> elements are the urlencoded names of all the
promisor remotes S advertised.

In a following commit, other values for "promisor.acceptFromServer" will
be implemented, so that C will be able to decide the promisor remotes it
accepts depending on the name and URL it received from S. So even if
that name and URL information is not used much right now, it will be
needed soon.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.txt     |  17 +++
 Documentation/gitprotocol-v2.txt      |  54 +++++++
 connect.c                             |   9 ++
 promisor-remote.c                     | 198 ++++++++++++++++++++++++++
 promisor-remote.h                     |  36 ++++-
 serve.c                               |  26 ++++
 t/t5710-promisor-remote-capability.sh | 124 ++++++++++++++++
 upload-pack.c                         |   3 +
 8 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100755 t/t5710-promisor-remote-capability.sh

diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
index 98c5cb2ec2..9cbfe3e59e 100644
--- a/Documentation/config/promisor.txt
+++ b/Documentation/config/promisor.txt
@@ -1,3 +1,20 @@
 promisor.quiet::
 	If set to "true" assume `--quiet` when fetching additional
 	objects for a partial clone.
+
+promisor.advertise::
+	If set to "true", a server will use the "promisor-remote"
+	capability, see linkgit:gitprotocol-v2[5], to advertise the
+	promisor remotes it is using, if it uses some. Default is
+	"false", which means the "promisor-remote" capability is not
+	advertised.
+
+promisor.acceptFromServer::
+	If set to "all", a client will accept all the promisor remotes
+	a server might advertise using the "promisor-remote"
+	capability. Default is "none", which means no promisor remote
+	advertised by a server will be accepted. By accepting a
+	promisor remote, the client agrees that the server might omit
+	objects that are lazily fetchable from this promisor remote
+	from its responses to "fetch" and "clone" requests from the
+	client. See linkgit:gitprotocol-v2[5].
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 414bc625d5..65d5256baf 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -781,6 +781,60 @@ retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
 
+promisor-remote=<pr-infos>
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The server may advertise some promisor remotes it is using or knows
+about to a client which may want to use them as its promisor remotes,
+instead of this repository. In this case <pr-infos> should be of the
+form:
+
+	pr-infos = pr-info | pr-infos ";" pr-info
+
+	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
+
+where `pr-name` is the urlencoded name of a promisor remote, and
+`pr-url` the urlencoded URL of that promisor remote.
+
+In this case, if the client decides to use one or more promisor
+remotes the server advertised, it can reply with
+"promisor-remote=<pr-names>" where <pr-names> should be of the form:
+
+	pr-names = pr-name | pr-names ";" pr-name
+
+where `pr-name` is the urlencoded name of a promisor remote the server
+advertised and the client accepts.
+
+Note that, everywhere in this document, `pr-name` MUST be a valid
+remote name, and the ';' and ',' characters MUST be encoded if they
+appear in `pr-name` or `pr-url`.
+
+If the server doesn't know any promisor remote that could be good for
+a client to use, or prefers a client not to use any promisor remote it
+uses or knows about, it shouldn't advertise the "promisor-remote"
+capability at all.
+
+In this case, or if the client doesn't want to use any promisor remote
+the server advertised, the client shouldn't advertise the
+"promisor-remote" capability at all in its reply.
+
+The "promisor.advertise" and "promisor.acceptFromServer" configuration
+options can be used on the server and client side respectively to
+control what they advertise or accept respectively. See the
+documentation of these configuration options for more information.
+
+Note that in the future it would be nice if the "promisor-remote"
+protocol capability could be used by the server, when responding to
+`git fetch` or `git clone`, to advertise better-connected remotes that
+the client can use as promisor remotes, instead of this repository, so
+that the client can lazily fetch objects from these other
+better-connected remotes. This would require the server to omit in its
+response the objects available on the better-connected remotes that
+the client has accepted. This hasn't been implemented yet though. So
+for now this "promisor-remote" capability is useful only when the
+server advertises some promisor remotes it already uses to borrow
+objects from.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/connect.c b/connect.c
index cf84e631e9..1650bbd71d 100644
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
@@ -498,6 +500,13 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	} else {
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
 	}
+	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
+		char *reply = promisor_remote_reply(promisor_remote_info);
+		if (reply) {
+			packet_write_fmt(fd_out, "promisor-remote=%s", reply);
+			free(reply);
+		}
+	}
 }
 
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
diff --git a/promisor-remote.c b/promisor-remote.c
index 317e1b127f..baacbe9d94 100644
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
@@ -290,3 +303,188 @@ void promisor_remote_get_direct(struct repository *repo,
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
+char *promisor_remote_info(struct repository *repo)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int advertise_promisors = 0;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
+
+	git_config_get_bool("promisor.advertise", &advertise_promisors);
+
+	if (!advertise_promisors)
+		return NULL;
+
+	promisor_info_vecs(repo, &names, &urls);
+
+	if (!names.nr)
+		return NULL;
+
+	for (size_t i = 0; i < names.nr; i++) {
+		if (i)
+			strbuf_addch(&sb, ';');
+		strbuf_addstr(&sb, "name=");
+		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
+		if (urls.v[i]) {
+			strbuf_addstr(&sb, ",url=");
+			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
+		}
+	}
+
+	strbuf_sanitize(&sb);
+
+	strvec_clear(&names);
+	strvec_clear(&urls);
+
+	return strbuf_detach(&sb, NULL);
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
+		char *decoded_name = NULL;
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
+		if (remote_name)
+			decoded_name = url_percent_decode(remote_name);
+		if (remote_url)
+			decoded_url = url_percent_decode(remote_url);
+
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
+			strvec_push(accepted, decoded_name);
+
+		strbuf_list_free(elems);
+		free(decoded_name);
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
+	if (!accepted.nr)
+		return NULL;
+
+	for (size_t i = 0; i < accepted.nr; i++) {
+		if (i)
+			strbuf_addch(&reply, ';');
+		strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
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
+		char *decoded_remote;
+
+		strbuf_trim_trailing_ch(accepted_remotes[i], ';');
+		decoded_remote = url_percent_decode(accepted_remotes[i]->buf);
+
+		p = repo_promisor_remote_find(r, decoded_remote);
+		if (p)
+			p->accepted = 1;
+		else
+			warning(_("accepted promisor remote '%s' not found"),
+				decoded_remote);
+
+		free(decoded_remote);
+	}
+
+	strbuf_list_free(accepted_remotes);
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 88cb599c39..814ca248c7 100644
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
 
@@ -32,4 +34,36 @@ void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr);
 
+/*
+ * Prepare a "promisor-remote" advertisement by a server.
+ * Check the value of "promisor.advertise" and maybe the configured
+ * promisor remotes, if any, to prepare information to send in an
+ * advertisement.
+ * Return value is NULL if no promisor remote advertisement should be
+ * made. Otherwise it contains the names and urls of the advertised
+ * promisor remotes separated by ';'
+ */
+char *promisor_remote_info(struct repository *repo);
+
+/*
+ * Prepare a reply to a "promisor-remote" advertisement from a server.
+ * Check the value of "promisor.acceptfromserver" and maybe the
+ * configured promisor remotes, if any, to prepare the reply.
+ * Return value is NULL if no promisor remote from the server
+ * is accepted. Otherwise it contains the names of the accepted promisor
+ * remotes separated by ';'.
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
index 884cd84ca8..a8935571d6 100644
--- a/serve.c
+++ b/serve.c
@@ -12,6 +12,7 @@
 #include "upload-pack.h"
 #include "bundle-uri.h"
 #include "trace2.h"
+#include "promisor-remote.h"
 
 static int advertise_sid = -1;
 static int advertise_object_info = -1;
@@ -31,6 +32,26 @@ static int agent_advertise(struct repository *r UNUSED,
 	return 1;
 }
 
+static int promisor_remote_advertise(struct repository *r,
+				     struct strbuf *value)
+{
+	if (value) {
+		char *info = promisor_remote_info(r);
+		if (!info)
+			return 0;
+		strbuf_addstr(value, info);
+		free(info);
+	}
+	return 1;
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
@@ -157,6 +178,11 @@ static struct protocol_capability capabilities[] = {
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
2.46.0.4.g7a37e584ed

