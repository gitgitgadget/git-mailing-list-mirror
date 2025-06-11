Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AB142E86
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649530; cv=none; b=hrKhTFJtM/TDMqYtgaUXRu60pZ4/2YQgFb4LkpjDneKwDdOUmIh0OjyiWbTZ5GSyVBIpSxgMaQV5bbbhr6iadImERwzrVs7KJxphDqJ2yoFYTIJRtN2HdppDhSdgkIPtZ1Hw9XfW342FYp42zErRlFhmk7y6GVlihJRrrBJAv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649530; c=relaxed/simple;
	bh=CYSO5kCaOrB9uupIn3txpNuW4IzQoArQNAkSyMcNsYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wkb2am3LpGfPMkS4jX6A3zWnQGGxoSdjri4CjUGwblxWnyog2ybnAxqDsEQNlAaZ678ro3qEdbC2hD+PtYpXx5kIXE9PWbM0xIaV0+/qyfR7n3EtcPukoKiX54l8da3s919lAqB1TIfN3Qp88OZDdOB8YYzcis3g4piPaILqDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHd63Rbh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHd63Rbh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so5071482f8f.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649526; x=1750254326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbE5edj+O9RCbWXUoQn2F1EF5YpZLD3ZkhRivaCai90=;
        b=dHd63RbhKxndWUmKcMxwtr7za59/h56CDj364EiL9Q6QwGURk11quFfbnwm1MuVFD9
         Zr/2o4nMR2HrRKpZYliCdE0R/1qaK29U49zLgkRDR2fBGx6z7snSYbxyV7/DDhWQCHeH
         gKnMpTzcg08irtHUXyNuixbO8ZgPEUpuWIzjig2q1em+yiCK7U6o+tag29GUjNxsf7OG
         Rgf1k3X3WhW2LW1XcQ3XgnM+azGo0quIcAp8PGGbd8vcr1HvzLMgC3Wn0sXKtnPIMP1w
         fFV+z9caiQg1bf6FTxWZz4crbXMcLJni4rCP89Xh//yPrPWhLwoKqgpyLAH1dTGByJJG
         bqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649526; x=1750254326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbE5edj+O9RCbWXUoQn2F1EF5YpZLD3ZkhRivaCai90=;
        b=MU7j2qaACZIloI8gC4jBvX+nNj+qfou9yv/9REwsIUXC+5UG1gRp1CmuxyUwFcovCh
         petlaEETO/kg3qJCpWGYwibDb/+vZood4LqPDEJs43G62h9cf7WiPGC3YoLIBl0n2rnL
         Y7aaB011BAjReIaRX3hCUM+ENjUm6C+hyTFBce8tyVxNRVmRwae+ePPOYsDkFTK9oktu
         t87Iyd3VDxSfuORDRtBBsXTKofsTPctgwqKctUSS6xbeJ+UQerJTLujGKQ1mE3xqURUK
         dhTdkmNMasJjOb28Nov9g4Yxy06wW44hC+n5NpBL/SrwOj+4injfXzsaDMIWvRN9sQuP
         nyEA==
X-Gm-Message-State: AOJu0YyScahPyf0W7h1ayOzJHmhD/u5EI9I3aK+6vw5GuI86TYasv5sY
	fT+jG8GyvdFA6Rpp9jgiQyjawOkZWRMi+OMFOCHOQzitljX+MWnNfr7nxvklCA==
X-Gm-Gg: ASbGncsT43/k3tcQz12XG7jw2EaahrPv0xjRENSqPeRj1xJYw58WmIXOPMa0gc0HOZu
	esFEJOPXL8TqJMyK5D1VVobkaNia1X2oKcWyFAEpjiYE2p0UBPORa88U8xJ5QH7aJWhdlHSopzO
	hx5VK2wgoffPNO6ECGqpVsxJVLhOQ6TYrIa84bHoFndSIpgucVwoD1V7dnHV2/zeK/ewKPduabk
	PvPc/U1qMgSukZpRgDY/xBdJAlCc5D0S1vxOaGmkdcLYeKU0L4GyQ6S9+yKexFIldnG2l96Ayn+
	ul5XPpvPnARJ6IEsNGka3e9mkzordZHADzUeqwVlmTHMouNXc/SJmZR00+EPwB4HYH782Yx9I1P
	nz4/Xqvhx1UtJM1vO/CuGk8MasTnZZ0tQRGWYIYyQAJCA
X-Google-Smtp-Source: AGHT+IGtlbMCHtm0kc7+74xbemqXmrfETJ2DJZmHTYT+g8DY7dOdcSUaMpduAanl/8C/DBGBQ2WXBA==
X-Received: by 2002:a05:6000:240d:b0:3a4:dc2a:924e with SMTP id ffacd0b85a97d-3a558a926eemr2554510f8f.6.1749649525480;
        Wed, 11 Jun 2025 06:45:25 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:24 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/5] promisor-remote: allow a server to advertise more fields
Date: Wed, 11 Jun 2025 15:45:03 +0200
Message-ID: <20250611134506.2975856-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.5.ge8efe62b7f
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now the "promisor-remote" protocol capability can only pass "name"
and "url" information from a server to a client in the form
"name=<remote_name>,url=<remote_url>".

Let's make it possible to pass more information by introducing a new
"promisor.sendFields" configuration variable. This variable should
contain a comma or space separated list of field names that will be
looked up in the configuration of the remote on the server to find the
values that will be passed to the client.

Only a set of predefined fields are allowed. The only fields in this
set are "partialCloneFilter" and "token". The "partialCloneFilter"
field specifies the filter definition used by the promisor remote,
and the "token" field can provide an authentication credential for
accessing it.

For example, if "promisor.sendFields" is set to "partialCloneFilter",
and the server has the "remote.<name>.partialCloneFilter" config
variable set to a value for a remote, then that value will be passed
in the form "partialCloneFilter=<value>" after the "name" and "url"
fields.

A following commit will allow the client to use the information to
decide if it accepts the remote or not. For now the client doesn't do
anything with the additional information it receives.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  22 +++++
 Documentation/gitprotocol-v2.adoc     |  59 ++++++++----
 promisor-remote.c                     | 128 ++++++++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh |  31 +++++++
 4 files changed, 215 insertions(+), 25 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 2638b01f83..beb8f65518 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -9,6 +9,28 @@ promisor.advertise::
 	"false", which means the "promisor-remote" capability is not
 	advertised.
 
+promisor.sendFields::
+	A comma or space separated list of additional remote related
+	field names. A server will send these field names and the
+	associated field values from its configuration when
+	advertising its promisor remotes using the "promisor-remote"
+	capability, see linkgit:gitprotocol-v2[5]. Currently, only the
+	"partialCloneFilter" and "token" field names are supported.
++
+* "partialCloneFilter": contains the partial clone filter
+  used for the remote.
++
+* "token": contains an authentication token for the remote.
++
+When a field name is part of this list and a corresponding
+"remote.foo.<field name>" config variable is set on the server to a
+non-empty value, then the field name and value will be sent when
+advertising the promisor remote "foo".
++
+This list has no effect unless the "promisor.advertise" config
+variable is set to "true", and the "name" and "url" fields are always
+advertised regardless of this setting.
+
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 5598c93e67..3c12c158fd 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -785,33 +785,59 @@ retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
 
-promisor-remote=<pr-infos>
+promisor-remote=<pr-info>
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The server may advertise some promisor remotes it is using or knows
 about to a client which may want to use them as its promisor remotes,
-instead of this repository. In this case <pr-infos> should be of the
+instead of this repository. In this case <pr-info> should be of the
 form:
 
-	pr-infos = pr-info | pr-infos ";" pr-info
+	pr-info = pr-fields | pr-info ";" pr-info
 
-	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
+	pr-fields = field-name "=" field-value | pr-fields "," pr-fields
 
-where `pr-name` is the urlencoded name of a promisor remote, and
-`pr-url` the urlencoded URL of that promisor remote.
+where all the `field-name` and `field-value` in a given `pr-fields`
+are field names and values related to a single promisor remote.
 
-In this case, if the client decides to use one or more promisor
-remotes the server advertised, it can reply with
-"promisor-remote=<pr-names>" where <pr-names> should be of the form:
+The server MUST advertise at least the "name" and "url" field names
+along with the associated field values, which are the name of a valid
+remote and its URL, in each `pr-fields`. The "name" and "url" fields
+MUST appear first in each pr-fields, in that order.
 
-	pr-names = pr-name | pr-names ";" pr-name
+After these mandatory fields, the server MAY advertise the following
+optional fields in any order:
+
+- "partialCloneFilter": The filter specification used by the remote.
+Clients can use this to determine if the remote's filtering strategy
+is compatible with their needs (e.g., checking if both use "blob:none").
+It corresponds to the "remote.<name>.partialCloneFilter" config setting.
+
+- "token": An authentication token that clients can use when
+connecting to the remote. It corresponds to the "remote.<name>.token"
+config setting.
+
+No other fields are defined by the protocol at this time. Clients MUST
+ignore fields they don't recognize to allow for future protocol
+extensions.
+
+For now, the client can only use information transmitted through these
+fields to decide if it accepts the advertised promisor remote. In the
+future that information might be used for other purposes though.
+
+Field values MUST be urlencoded.
+
+If the client decides to use one or more promisor remotes the server
+advertised, it can reply with "promisor-remote=<pr-names>" where
+<pr-names> should be of the form:
+
+	pr-names = pr-name | pr-names ";" pr-names
 
 where `pr-name` is the urlencoded name of a promisor remote the server
 advertised and the client accepts.
 
-Note that, everywhere in this document, `pr-name` MUST be a valid
-remote name, and the ';' and ',' characters MUST be encoded if they
-appear in `pr-name` or `pr-url`.
+Note that, everywhere in this document, the ';' and ',' characters
+MUST be encoded if they appear in `pr-name` or `field-value`.
 
 If the server doesn't know any promisor remote that could be good for
 a client to use, or prefers a client not to use any promisor remote it
@@ -822,9 +848,10 @@ In this case, or if the client doesn't want to use any promisor remote
 the server advertised, the client shouldn't advertise the
 "promisor-remote" capability at all in its reply.
 
-The "promisor.advertise" and "promisor.acceptFromServer" configuration
-options can be used on the server and client side to control what they
-advertise or accept respectively. See the documentation of these
+On the server side, the "promisor.advertise" and "promisor.sendFields"
+configuration options can be used to control what it advertises. On
+the client side, the "promisor.acceptFromServer" configuration option
+can be used to control what it accepts. See the documentation of these
 configuration options for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
diff --git a/promisor-remote.c b/promisor-remote.c
index 90a063ea53..ec7f4dd2de 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,74 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+static const char promisor_field_filter[] = "partialCloneFilter";
+static const char promisor_field_token[] = "token";
+
+/*
+ * List of optional field names that can be used in the
+ * "promisor-remote" protocol capability (others must be
+ * ignored). Each field should correspond to a configurable property
+ * of a remote that can be relevant for the client.
+ */
+static const char *known_fields[] = {
+	promisor_field_filter, /* Filter used for partial clone */
+	promisor_field_token,  /* Authentication token for the remote */
+	NULL
+};
+
+/*
+ * Check if 'field' is in the list of the known field names for the
+ * "promisor-remote" protocol capability.
+ */
+static int is_known_field(const char *field)
+{
+	const char **p;
+
+	for (p = known_fields; *p; p++)
+		if (!strcasecmp(*p, field))
+			return 1;
+	return 0;
+}
+
+static int is_valid_field(struct string_list_item *item, void *cb_data)
+{
+	const char *field = item->string;
+	const char *config_key = (const char *)cb_data;
+
+	if (!is_known_field(field)) {
+		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
+		return 0;
+	}
+	return 1;
+}
+
+static char *fields_from_config(struct string_list *fields_list, const char *config_key)
+{
+	char *fields = NULL;
+
+	if (!git_config_get_string(config_key, &fields) && *fields) {
+		string_list_split_in_place(fields_list, fields, ", ", -1);
+		string_list_remove_empty_items(fields_list, 0);
+		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
+	}
+
+	return fields;
+}
+
+static struct string_list *fields_sent(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_list.cmp = strcasecmp;
+		fields_from_config(&fields_list, "promisor.sendFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
 /*
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
@@ -326,6 +394,8 @@ static int allow_unsanitized(char ch)
 struct promisor_info {
 	const char *name;
 	const char *url;
+	const char *filter;
+	const char *token;
 };
 
 static void promisor_info_list_clear(struct string_list *list)
@@ -334,15 +404,47 @@ static void promisor_info_list_clear(struct string_list *list)
 		struct promisor_info *p = list->items[i].util;
 		free((char *)p->name);
 		free((char *)p->url);
+		free((char *)p->filter);
+		free((char *)p->token);
 	}
 	string_list_clear(list, 1);
 }
 
+static void set_one_field(struct promisor_info *p,
+			  const char *field, const char *value)
+{
+	if (!strcasecmp(field, promisor_field_filter))
+		p->filter = xstrdup(value);
+	else if (!strcasecmp(field, promisor_field_token))
+		p->token = xstrdup(value);
+	else
+		BUG("invalid field '%s'", field);
+}
+
+static void set_fields(struct promisor_info *p,
+		       struct string_list *field_names)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, field_names) {
+		char *key = xstrfmt("remote.%s.%s", p->name, item->string);
+		const char *val;
+		if (!git_config_get_string_tmp(key, &val) && *val)
+			set_one_field(p, item->string, val);
+		free(key);
+	}
+}
+
 /*
  * Populate 'list' with promisor remote information from the config.
- * The 'util' pointer of each list item will hold a 'struct promisor_info'.
+ * The 'util' pointer of each list item will hold a 'struct
+ * promisor_info'. Except "name" and "url", only members of that
+ * struct specified by the 'field_names' list are set (using values
+ * from the configuration).
  */
-static void promisor_config_info_list(struct repository *repo, struct string_list *list)
+static void promisor_config_info_list(struct repository *repo,
+				      struct string_list *list,
+				      struct string_list *field_names)
 {
 	struct promisor_remote *r;
 
@@ -360,6 +462,9 @@ static void promisor_config_info_list(struct repository *repo, struct string_lis
 			new_info->name = xstrdup(r->name);
 			new_info->url = xstrdup(url);
 
+			if (field_names)
+				set_fields(new_info, field_names);
+
 			item = string_list_append(list, new_info->name);
 			item->util = new_info;
 		}
@@ -380,7 +485,7 @@ char *promisor_remote_info(struct repository *repo)
 	if (!advertise_promisors)
 		return NULL;
 
-	promisor_config_info_list(repo, &config_info);
+	promisor_config_info_list(repo, &config_info, fields_sent());
 
 	if (!config_info.nr)
 		return NULL;
@@ -395,6 +500,15 @@ char *promisor_remote_info(struct repository *repo)
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
 		strbuf_addstr(&sb, ",url=");
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
+
+		if (p->filter) {
+			strbuf_addf(&sb, ",%s=", promisor_field_filter);
+			strbuf_addstr_urlencode(&sb, p->filter, allow_unsanitized);
+		}
+		if (p->token) {
+			strbuf_addf(&sb, ",%s=", promisor_field_token);
+			strbuf_addstr_urlencode(&sb, p->token, allow_unsanitized);
+		}
 	}
 
 	promisor_info_list_clear(&config_info);
@@ -479,7 +593,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info);
+		promisor_config_info_list(repo, &config_info, NULL);
 		string_list_sort(&config_info);
 	}
 
@@ -498,13 +612,9 @@ static void filter_promisor_remote(struct repository *repo,
 		elems = strbuf_split(remotes[i], ',');
 
 		for (size_t j = 0; elems[j]; j++) {
-			int res;
 			strbuf_strip_suffix(elems[j], ",");
-			res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
+			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
 				skip_prefix(elems[j]->buf, "url=", &remote_url);
-			if (!res)
-				warning(_("unknown element '%s' from remote info"),
-					elems[j]->buf);
 		}
 
 		if (remote_name)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index cb061b1f35..204528b2e0 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -295,6 +295,37 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.sendFields" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.token "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+	test_config -C server promisor.sendFields "partialCloneFilter, token" &&
+	test_when_finished "rm trace" &&
+
+	# Clone from server to create a client
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
+	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
+	test_grep "clone> promisor-remote=lop;otherLop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.50.0.rc2.5.ge8efe62b7f

