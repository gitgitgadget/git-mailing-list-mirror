Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA927FD48
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646659; cv=none; b=P5V6ugQ9fodUbWS0iqPDDZ2T5UQX72e2iMzV9oO58TEc0ReVsynWCkgOF7KQvfZdXc8dOI+/U+TNXDJYph7DEauR/9SaDGDjgRp2pEmkje2C0Vwj2ZMj7N03EHns81Vds7ZW44cjSFUipAXA2nVl+n59Np7ra4rOxUT1MVgy3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646659; c=relaxed/simple;
	bh=28QxZscrjCKLGNy42Vz0m47aYYkYxK/SWbZX5R4G+Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQKgtYLJCERdi46Ebgkmc2v9dFadhvqP/lePEMJi+vHwgu15V/QMSTfBbTJKwVomRhe8OZH7aIkzaW3rHmrULBPrlljowMZQpNqLI6WW46JbTrMcv/0mf4GZwWDUK4y3SV73qZZW1Ap+Vq3W9hVqI99O0iS0JXVQsRgqHoSo3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPw27Iox; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPw27Iox"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4239942f8f.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744646653; x=1745251453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVpBcShTDNPOIYcIhwweVlGmsDpd6UOWlzB7PGNUNUI=;
        b=FPw27Iox7iJeG+Z1M16p06ZsUp7IDrAIOIPrilQjgm17zYa3Zb5iVPbX7wPjpis5ER
         VeDD/oUBnqUoxaB3diwGbwpDi6v/hlR8OOX9ZIn24AiXe/ydUBAjI/UuTNZOF2HujHBa
         GFxYYA20xmGptjA8bIW+KZMX15Zu8+FW3+1I7SZqr6VlvFWOuyBPxjB6oAeHdXHHp3HZ
         l4IS5t08oB+gxO/SIvvIlnISYhuSbDhrBS1DXCQ7erZ89aJhUC3wJg2K8tSj3qDeRMqf
         +RMGXtucUdd6mRU5Ufd9w50jB6cRV6AR+T3/CySqObis3yA49JYyz1dbg5kxwyIbmGfG
         igAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646653; x=1745251453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVpBcShTDNPOIYcIhwweVlGmsDpd6UOWlzB7PGNUNUI=;
        b=qC7fA6eRvrKCq1cQh0BoBk3CypA/xjqS0h5cYmpXvsaRVdMHrEG3jLXeDbhew7rxKZ
         4Tsp8wXSgKfyx934hlEiCrSCL50mYpmbreIYXrN/g5oLFKvHSWiMKAF4715LuCZzz8BJ
         /sa34TPqi1tyS4Cayl7G5yKVcoT4vOU9meCVHBR1o2F+ngPFOhdSVBPT2pJoTuzPV5oP
         E1lZaB9EYF0vxmQqBlMmFkMQ5u8wNIdmXA/9PmrGptFCq6tBWzmeLlbyLzH0VA/eX11Q
         XUI9upuy/fLCyhq+4La6cM+jMrMAKeGI9IqvpGrCkZs4UYaVmg0LVzqBWGdmhsEIpnwq
         d2pQ==
X-Gm-Message-State: AOJu0Yy+ZSDnrgnvHkpb6Zotag8yMibHvtP+EU0BnpWyt+6yMLYVwzBo
	dXe5eDy4DfdG2pbt3EWPFi3c/b7XdpthUS26/hjly2CIF5voNgqOJk/MFQ==
X-Gm-Gg: ASbGncub5AS1kumSd8FrDzv/7U8hvJzZfV39y14dXhQC5Z+WWpx2dq2EKsNtmgmyMCv
	l5Te42BQR1YBbp8ZeF4LqtCI0N1clc/WXWlnPdQ9nhhEjL002UxsPzyBC8a8/EA6kuwMfzjDFGd
	ALH4Tyewhp/AKzHjYOjLjV3pYdwBZTuSJZXG7JeT8fWiBUaaJAT3nHeJGImPdfnsLfIiimmnxbs
	OGgE+QsIpaLjfELpTscSad4RPS+mGWVCjPxZglFlyOSV4F5IRtCNt7ds4sxn4nrfn5+H8fLWP4Q
	PqtBAhp50rlR9cjnuPZx+LXWPOruP48EnxKvVkHUanYuixTbX5nQHU3JKWjJn7s0BcAoeXndcxU
	=
X-Google-Smtp-Source: AGHT+IGGJgWd7yoOLAbxotov0UQusyvKMjAd5vTQmAZr3LJXmRvsoSmU9GdEnD82Mq1euMmuM21zKg==
X-Received: by 2002:a05:6000:4287:b0:39c:1257:cd41 with SMTP id ffacd0b85a97d-39eaaede3a4mr10404297f8f.59.1744646653075;
        Mon, 14 Apr 2025 09:04:13 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:a9d4:af7b:bb5c:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm11258029f8f.42.2025.04.14.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:04:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] promisor-remote: allow a server to advertise extra fields
Date: Mon, 14 Apr 2025 18:03:42 +0200
Message-ID: <20250414160343.2216312-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.158.gd3b09c1afe
In-Reply-To: <20250414160343.2216312-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
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
"promisor.sendExtraFields" configuration variable. This variable
should contain a comma or space separated list of fields that will be
looked up in the configuration of the remote on the server to find the
values that will be passed to the client.

For example if "promisor.sendExtraFields" is set to "partialCloneFilter",
and the server has the "remote.<name>.partialCloneFilter" config
variable set to a value for a remote, then that value will be passed
in the form "partialCloneFilter=<value>" after the "name" and "url"
fields.

A following commit will allow the client to use the extra information
to decide if it accepts the remote or not. For now the client doesn't
do anything with the extra information it receives.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    | 15 ++++++
 Documentation/gitprotocol-v2.adoc     | 42 +++++++++------
 promisor-remote.c                     | 75 ++++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 32 ++++++++++++
 4 files changed, 139 insertions(+), 25 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 2638b01f83..bc08999733 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -9,6 +9,21 @@ promisor.advertise::
 	"false", which means the "promisor-remote" capability is not
 	advertised.
 
+promisor.sendExtraFields::
+	A comma or space separated list of additional remote related
+	fields that a server will send while advertising its promisor
+	remotes using the "promisor-remote" capability, see
+	linkgit:gitprotocol-v2[5]. When a field named "bar" is part of
+	this list and a corresponding "remote.foo.bar" config variable
+	is set on the server to a non empty value, for example "baz",
+	then the field and its value, so "bar=baz", will be sent when
+	advertising the promisor remote "foo". This list has no effect
+	unless the "promisor.advertise" config variable, see above, is
+	set to "true", and if that's the case, then whatever this list
+	contains, the "name" and "url" fields are advertised anyway
+	and contain the remote name and URL respectively, so there is
+	no need to add "name" or "url" to this list.
+
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 5598c93e67..f649745837 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -785,33 +785,39 @@ retrieving the header from a bundle at the indicated URI, and thus
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
+	pr-fields = fld-key "=" fld-value | pr-fields "," pr-fields
 
-where `pr-name` is the urlencoded name of a promisor remote, and
-`pr-url` the urlencoded URL of that promisor remote.
+where all the `fld-key` and `fld-value` in a given `pr-fields` are
+field keys and values related to a single promisor remote.
 
-In this case, if the client decides to use one or more promisor
-remotes the server advertised, it can reply with
-"promisor-remote=<pr-names>" where <pr-names> should be of the form:
+The server MUST advertise at least the "name" and "url" field keys
+along with the associated field values, which are the name of a valid
+remote and its URL, in each `pr-fields`.
 
-	pr-names = pr-name | pr-names ";" pr-name
+`fld-key` MUST start with an alphabetic character and contain only
+alphanumeric or '-' characters, and `fld-value` MUST be urlencoded.
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
+MUST be encoded if they appear in `pr-name` or `fld-value`.
 
 If the server doesn't know any promisor remote that could be good for
 a client to use, or prefers a client not to use any promisor remote it
@@ -822,10 +828,12 @@ In this case, or if the client doesn't want to use any promisor remote
 the server advertised, the client shouldn't advertise the
 "promisor-remote" capability at all in its reply.
 
-The "promisor.advertise" and "promisor.acceptFromServer" configuration
-options can be used on the server and client side to control what they
-advertise or accept respectively. See the documentation of these
-configuration options for more information.
+On the server side, the "promisor.advertise" and
+"promisor.sendExtraFields" configuration options can be used to
+control what it advertises. On the client side, the
+"promisor.acceptFromServer" configuration option can be used to
+control what it accepts. See the documentation of these configuration
+options for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
 protocol capability could be used by the server, when responding to
diff --git a/promisor-remote.c b/promisor-remote.c
index 0fb07f25af..424d88d4a1 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,65 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * A valid extra field "foo" should correspond to a
+ * "remote.<name>.foo" config variable, so, like config variables
+ * keys, it should start with an alphabetic character and otherwise
+ * each character should satisfy is_config_key_char().
+ */
+static int valid_extra_field(struct string_list_item *item, void *cb_data)
+{
+	const char *field = item->string;
+	const char *config_key = (const char *)cb_data;
+
+	for (size_t i = 0; field[i]; i++)
+		if (i ? !is_config_key_char(field[i]) : !isalpha(field[i])) {
+			warning(_("invalid field '%s' in '%s' config"), field, config_key);
+			return 0;
+		}
+	return 1;
+}
+
+static char *fields_from_config(struct string_list *fields_list, const char *config_key)
+{
+	char *extras = NULL;
+
+	if (!git_config_get_string(config_key, &extras) && *extras) {
+		string_list_split_in_place(fields_list, extras, ", ", -1);
+		filter_string_list(fields_list, 0, valid_extra_field, (void *)config_key);
+	}
+
+	return extras;
+}
+
+static struct string_list *extra_fields_sent(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_from_config(&fields_list, "promisor.sendExtraFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
+static void append_extra_fields(struct string_list *fields,
+				struct string_list *extra_fields,
+				const char *name)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, extra_fields) {
+		char *key = xstrfmt("remote.%s.%s", name, item->string);
+		const char *val;
+		if (!git_config_get_string_tmp(key, &val) && *val)
+			string_list_append(fields, item->string)->util = (char *)val;
+		free(key);
+	}
+}
+
 /*
  * Linked list for promisor remotes.
  *
@@ -342,7 +401,8 @@ static void free_info_list(struct promisor_info *p)
  * remotes. For each promisor remote, some of its fields, starting
  * with "name" and "url", are put in the 'fields' string_list.
  */
-static struct promisor_info *promisor_info_list(struct repository *repo)
+static struct promisor_info *promisor_info_list(struct repository *repo,
+						struct string_list *extra_fields)
 {
 	struct promisor_info *infos = NULL;
 	struct promisor_info **last_info = &infos;
@@ -363,6 +423,9 @@ static struct promisor_info *promisor_info_list(struct repository *repo)
 			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
 			string_list_append(&new_info->fields, "url")->util = (char *)url;
 
+			if (extra_fields)
+				append_extra_fields(&new_info->fields, extra_fields, r->name);
+
 			*last_info = new_info;
 			last_info = &new_info->next;
 		}
@@ -385,7 +448,7 @@ char *promisor_remote_info(struct repository *repo)
 	if (!advertise_promisors)
 		return NULL;
 
-	info_list = promisor_info_list(repo);
+	info_list = promisor_info_list(repo, extra_fields_sent());
 
 	if (!info_list)
 		return NULL;
@@ -502,7 +565,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL)
-		info_list = promisor_info_list(repo);
+		info_list = promisor_info_list(repo, NULL);
 
 	/* Parse remote info received */
 
@@ -519,13 +582,9 @@ static void filter_promisor_remote(struct repository *repo,
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
index b35b774235..26f3c63112 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -289,6 +289,38 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.sendExtraFields" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.id "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+	git -C server config promisor.sendExtraFields "id, partialCloneFilter" &&
+	test_when_finished "git -C server config unset promisor.sendExtraFields" &&
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
+	# Check that extra fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,id=fooBar,partialCloneFilter=blob:limit=10k" &&
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
2.49.0.158.g6ac6832dc3.dirty

