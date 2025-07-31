Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AF29DB86
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946668; cv=none; b=PI0RMZ4H05UTip0fzY/lAErSPnt/PrYZQuPtlMj3lEA5ieAv+aivjKSUwTpWRjaihZn3HnsGiD+K6tLL1s9CqRnPvRPyn6ga6V8Rz0M7jEHFj1/z2KsMRcC01e0uBJILkxOQDFjpNTqpSWdTsFfaI+PHtPzSi0275yREr3lPYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946668; c=relaxed/simple;
	bh=uKujVTfEu1nh6/lQowk/S155gYRun/p5n2X57p8U1dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH2go9AnYkOeYPOqhnkNWzsQZ4g/ri0Nf/rZXwMumJkxyFrColVLi30q7gHfKhFM+7EVQkrSsAXRQiGuKZ00suBSraxHEQm7ZgQJFqmMe1CUzZrfr2JQ3hg2Gp7jDxmk923cd8Mn3cciLaQXNNyjWmZVys+v+b37sNZTT33Qm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdGFgAoT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdGFgAoT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7848df30cso980909f8f.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946664; x=1754551464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WuQKvJNu1A4YdwOSWxaadq/HyJWxKnCFIg5LsrYyk=;
        b=SdGFgAoT/fY+wx7LXL69wluOe4S2CCDiiz/yDIaPRvhK4N9RSYgv7WedWPUTdXx4pM
         T/ziX1dBtSJBDXMi86aciSHECXi2JuRpAsuqAY229rid+1vVWqTLYMZCGbP96I9PE5v6
         /wpAiuM0GTUiJpudLF1hFmUAVHTApuH8mt6bOcEupWyZ3m/1nVyWBuzt3tOOWeRhmHUX
         0kaALTT/yNmL/jq9bQZ9wUGwTY45fKH7VOy9JvArZZaROp+SEYMQrW/PPqpEv2SIMUpx
         J1NwgQ2PBOlYZDiuTFULfKOSNTQokL+xmwKC8IBJ95SD+vVkBaWoB4rRAmlSXROwiWZP
         M9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946664; x=1754551464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+WuQKvJNu1A4YdwOSWxaadq/HyJWxKnCFIg5LsrYyk=;
        b=GlhEc6lMsCFhguSz8yOOYuyc57LAXjQmSghzIsEX6NwBzhUKiZkE9X1e9t+FUzyMUz
         q07KIe/Yds0tmCt2JrmdUZOnxLEPJTT+s7VJorv5ToYtkFJG+BVA+Z1pEunuYCMUcd8s
         6HSk0tqGLmcnDz3dY3oL+3AJs+6A4jNcWGa3FHEMyHQw85UJDq+VSXFr1/oYfqJORR3c
         TrjQlFdBk7t0R6pysmCD/YXzZuioDQ5dz2FfnX63ivDN72yJgz/qFr95p4PZuGe7BtWV
         6+g+QzlS7HHoDxDWKwWW/7GO6X03p+n1KIG/eQwg3XtLf9gcob13iBsjCy/X0G1AJi8/
         q++A==
X-Gm-Message-State: AOJu0YxBX4N93XVv9UrdzEQbtY78J3M5KCqcHDi34DBpGSTM7oyKwpk6
	DPa8994leE2CBsfk8FPmcLXIkg3PITaPUIv7dPz0yHg3aEqmXonCjMQPWAzQLg==
X-Gm-Gg: ASbGnctC2UT7L0IJluh0SRPsoqZsOdfBYJuN9nX54OMnjO2R2rr/j7gh3fP9Z8scpzu
	Lr/z7zoCSkbk3R4EFYdBjJd6CJbkjBO9TJ3yext25Xm9xpTa0yWlAfIt+QR6OwmNlJ1evMGIbTi
	98LSj5fJ8RtkShL5kQScDHkbvnv135fsP3q2Aygyb0KnG4W65BDEVcCZYXi5LjRz9s62hdM/79E
	rEub4NeBx0kBWRrwtkCmqu/Qe3Y12tZRC+drWi1F9UDMSQsi9XcUtCa3n/HHdGfbSKEskRvsdf9
	lQbouZP4rF+dS2ptiGWCy5bVA9wgYoDdT0vn0GQYOn0xE2mMEH0uYTyrg+vJ1f+4adDDwsUlZU/
	BWHbJq0EMezfZIDrE66E8NvsU3jTApABsiVSFN0iEj5NygzUiuL+WZ3CFNrYVg1vxWBfLKln2eS
	0efr0D
X-Google-Smtp-Source: AGHT+IF5DH3QhZPltS0QJSl+7A1QhRuHat9UKPgp7ACxPB7VQX6BDeByW0Wskv4m6K8BOSXXlqCHqw==
X-Received: by 2002:a5d:64ec:0:b0:3b7:8cf0:4b2a with SMTP id ffacd0b85a97d-3b79d4e3623mr644447f8f.16.1753946664171;
        Thu, 31 Jul 2025 00:24:24 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm52495175e9.32.2025.07.31.00.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:24:23 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 4/5] promisor-remote: allow a client to check fields
Date: Thu, 31 Jul 2025 09:23:56 +0200
Message-ID: <20250731072401.3817074-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.323.g4e0625aa69.dirty
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com>
References: <20250721141056.2283349-1-christian.couder@gmail.com>
 <20250731072401.3817074-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit allowed a server to pass additional fields through
the "promisor-remote" protocol capability after the "name" and "url"
fields, specifically the "partialCloneFilter" and "token" fields.

Let's make it possible for a client to check if these fields match
what it expects before accepting a promisor remote.

We allow this by introducing a new "promisor.checkFields"
configuration variable. It should contain a comma or space separated
list of fields that will be checked.

By limiting the protocol to specific well-defined fields, we ensure
both server and client have a shared understanding of field
semantics and usage.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    | 39 ++++++++++++
 promisor-remote.c                     | 89 ++++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 34 ++++++++++
 3 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index b4a72c2152..93e5e0d9b5 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -50,3 +50,42 @@ promisor.acceptFromServer::
 	lazily fetchable from this promisor remote from its responses
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+
+promisor.checkFields::
+	A comma or space separated list of additional remote related
+	field names. A client checks if the values of these fields
+	transmitted by a server correspond to the values of these
+	fields in its own configuration before accepting a promisor
+	remote. Currently, "partialCloneFilter" and "token" are the
+	only supported field names.
++
+If one of these field names (e.g., "token") is being checked for an
+advertised promisor remote (e.g., "foo"), three conditions must be met
+for the check of this specific field to pass:
++
+1. The corresponding local configuration (e.g., `remote.foo.token`)
+   must be set.
+2. The server must advertise the "token" field for remote "foo".
+3. The value of the locally configured `remote.foo.token` must exactly
+   match the value advertised by the server for the "token" field.
++
+If any of these conditions is not met for any field name listed in
+`promisor.checkFields`, the advertised remote "foo" is rejected.
++
+For the "partialCloneFilter" field, this allows the client to ensure
+that the server's filter matches what it expects locally, preventing
+inconsistencies in filtering behavior. For the "token" field, this can
+be used to verify that authentication credentials match expected
+values.
++
+Field values are compared case-sensitively.
++
+The "name" and "url" fields are always checked according to the
+`promisor.acceptFromServer` policy, independently of this setting.
++
+The field names and values should be passed by the server through the
+"promisor-remote" capability by using the `promisor.sendFields` config
+variable. The fields are checked only if the
+`promisor.acceptFromServer` config variable is not set to "None". If
+set to "None", this config variable has no effect. See
+linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 2ea069ff6b..46b2cb0bc9 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -388,6 +388,20 @@ static struct string_list *fields_sent(void)
 	return &fields_list;
 }
 
+static struct string_list *fields_checked(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized;
+
+	if (!initialized) {
+		fields_list.cmp = strcasecmp;
+		fields_from_config(&fields_list, "promisor.checkFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
 /*
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
@@ -533,6 +547,61 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+static int match_field_against_config(const char *field, const char *value,
+				      struct promisor_info *config_info)
+{
+	if (config_info->filter && !strcasecmp(field, promisor_field_filter))
+		return !strcmp(config_info->filter, value);
+	else if (config_info->token && !strcasecmp(field, promisor_field_token))
+		return !strcmp(config_info->token, value);
+
+	return 0;
+}
+
+static int all_fields_match(struct promisor_info *advertised,
+			    struct string_list *config_info,
+			    int in_list)
+{
+	struct string_list *fields = fields_checked();
+	struct string_list_item *item_checked;
+
+	for_each_string_list_item(item_checked, fields) {
+		int match = 0;
+		const char *field = item_checked->string;
+		const char *value = NULL;
+		struct string_list_item *item;
+
+		if (!strcasecmp(field, promisor_field_filter))
+			value = advertised->filter;
+		else if (!strcasecmp(field, promisor_field_token))
+			value = advertised->token;
+
+		if (!value)
+			return 0;
+
+		if (in_list) {
+			for_each_string_list_item(item, config_info) {
+				struct promisor_info *p = item->util;
+				if (match_field_against_config(field, value, p)) {
+					match = 1;
+					break;
+				}
+			}
+		} else {
+			item = string_list_lookup(config_info, advertised->name);
+			if (item) {
+				struct promisor_info *p = item->util;
+				match = match_field_against_config(field, value, p);
+			}
+		}
+
+		if (!match)
+			return 0;
+	}
+
+	return 1;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -543,7 +612,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return all_fields_match(advertised, config_info, 1);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -555,7 +624,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -566,7 +635,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	}
 
 	if (!strcmp(p->url, remote_url))
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
@@ -599,6 +668,10 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 			info->name = value;
 		else if (!strcmp(elem, "url"))
 			info->url = value;
+		else if (!strcmp(elem, promisor_field_filter))
+			info->filter = value;
+		else if (!strcmp(elem, promisor_field_token))
+			info->token = value;
 		else
 			free(value);
 	}
@@ -641,11 +714,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info, NULL);
-		string_list_sort(&config_info);
-	}
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -660,6 +728,11 @@ static void filter_promisor_remote(struct repository *repo,
 		if (!advertised)
 			continue;
 
+		if (!config_info.nr) {
+			promisor_config_info_list(repo, &config_info, fields_checked());
+			string_list_sort(&config_info);
+		}
+
 		if (should_accept_remote(accept, advertised, &config_info))
 			strvec_push(accepted, advertised->name);
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 204528b2e0..023735d6a8 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -326,6 +326,40 @@ test_expect_success "clone with promisor.sendFields" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.checkFields" '
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
+		-c remote.lop.partialCloneFilter="blob:none" \
+		-c promisor.acceptfromserver=All \
+		-c promisor.checkFields=partialcloneFilter \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
+	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
+	test_grep "clone> promisor-remote=lop" trace &&
+	test_grep ! "clone> promisor-remote=lop;otherLop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.50.1.323.g4e0625aa69.dirty

