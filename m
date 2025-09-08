Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FC2309BE
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309486; cv=none; b=UA7doUdvComlQt1CPb34OEUDUGiaWk82D28BcnbDIK+14bLCunNXUj9UlgdBCtwPE0O/A2qk+2L68m+iTpop8byGbpgHhk0swuit+ESkubBdbNbgX1Zw7sZvIUcnqx0TGylXe6TptYnq40RfQXmKy83I577W5ty7dJK+PxSsRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309486; c=relaxed/simple;
	bh=GH68wh6DZpYMq4dIfgMb66MsWgLLy/faOoLcGQzEbQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/YJtRlhygi6XHowgkLc6m3L/2sIO9Efh8uK6oCtSJiUh3HJnoheVjKFPbaWlaXhOi7BXpqlTSQDGc6CE4EPcl6wClCJyizxJF8ssYpZ0Ixqe/3LGGkefwpyctIrAUES1iLR7u5QwwdCwJxPby0awDapCQiHL1bO2AX/htWL/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAB/weFY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAB/weFY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso34827815e9.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309482; x=1757914282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixdQRjoObWMK27uVs+2Y3+9/n4n+KTjIFkp9XfEGzUU=;
        b=jAB/weFYSZcs0/JU3yrH7q6x75fnsJEF44mHLHBzEaWY1oNUMwLKV5ZdEuCObVikun
         XaBanaDfpsPQuy/+4wF/vyg3EnQEAFkd19QcV1gMGEyo2J4q5r03qFQBiQXqoHReW1rU
         tStv3XQadSym1lgxbCGDxT39T7n4+FtEr6AWQZ1vpZuR8+nZ9QD1E3gQo+/a9U2uLcpT
         WUOTy5/EhVTPUOf5PpeQJ/FHUBMf/9wLucBnoLXgZWkZcjPjXyG4m547UG6t6Ayi+qWk
         M2b65rq8ZrsKjuUc+9nMJmx5flahxTPLigjg41Q6Xdwp1T6mD3rHW2ObW9+5RPM0FnkO
         jmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309482; x=1757914282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixdQRjoObWMK27uVs+2Y3+9/n4n+KTjIFkp9XfEGzUU=;
        b=WrddWFaGZpDG+GaUcY+vlNNO08ySoH9ZrDP6e5shNlGB3EFY9f9gThox2slBRbNkUQ
         oypLJcPRvexaN2Pjm15Vj6fN7YwqdRqTgOKwWf7lHvJfi5pqFTFw8J3vjEjyyMlwsjPP
         0fSWE6SukWCS0qX5HOvE+1Cli1A5OJNB0Rwls6ke4c6tR09fr4MrGEfKOELAxFObCp9W
         /BRdXizKfkuhJokPbRBV0zrjR5TGMD8L+2pZ0+IWyb6owDemtpHsgOtPi5RrcUzfiELo
         VyALEZD2WUwmCYRYhTbsf8bMDJ0RTPQ2inQUch9Im23VDZGGxM/LnOLqzxGScz6i0O3X
         CxaA==
X-Gm-Message-State: AOJu0Yxz1vhxgYKAlxokif6+IivG6I20HOfMsXUNA2R13FYBw6KtrlzH
	2Rode9JIz4M0kMaYuXQDj40JTBbR0by3xK+jXU46h7SdmF6uwxezIMVYK2TyBg==
X-Gm-Gg: ASbGncuOa14B/iwAuGJjnSjuvKxgAjEcCYGSZiIT6n453ps41iC4Y5tWts5vWqB+5wj
	p29/b4SzpeAE4tKUambYXSSNZQM1qGHgOOkHggoIgovx1zTfItft5JSbsqHyC03eX6u51K7vr7K
	d+GhhZ66MlCt0XqE0GWy6imn+xmbxy2Kt3NJB5jJfj+oRaW+StBDdqHQJIeaB4H6JB2FpPlm3U3
	B2PlrU97annfYDUzdJH/w3CGrqtuaTTMUPkdZht6MYfslyAXwiIcuyKJdSvJGWRZsO5u0PiZjNP
	HT/dR/KqPmhmp01Aiq2xGYLInyeVbnCs7u1hzOYliBNPs9bD8WPYh9qWKhcL3OxQA9LOF6aZ+FL
	ncWv2EaP6UaVaC4NoMFxDnJRqVh1YfDJ5FM2SEvY3AbvTuAzoIFqfC/VxBN6eKFydwg1Ru6pCgN
	tN4ZVwyMJrE6CxGg8=
X-Google-Smtp-Source: AGHT+IGR1wlsrKM2C3lgYM0jysFeq60sPIwfzoe1SmlEsDL4OivVHjhB4dMSkzmR6dbJca65SDOmZg==
X-Received: by 2002:a05:600c:1991:b0:45d:d6fc:24ec with SMTP id 5b1f17b1804b1-45ddde8a579mr48505005e9.1.1757309481523;
        Sun, 07 Sep 2025 22:31:21 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:20 -0700 (PDT)
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
Subject: [PATCH v8 6/7] promisor-remote: allow a client to check fields
Date: Mon,  8 Sep 2025 07:30:52 +0200
Message-ID: <20250908053056.956907-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
 <20250908053056.956907-1-christian.couder@gmail.com>
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
index afec0d081d..a6cfade223 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -389,6 +389,20 @@ static struct string_list *fields_sent(void)
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
@@ -534,6 +548,61 @@ enum accept_promisor {
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
@@ -544,7 +613,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return all_fields_match(advertised, config_info, 1);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -556,7 +625,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -567,7 +636,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	}
 
 	if (!strcmp(p->url, remote_url))
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
@@ -605,6 +674,10 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 			info->name = url_percent_decode(p);
 		else if (skip_field_name_prefix(elem, promisor_field_url, &p))
 			info->url = url_percent_decode(p);
+		else if (skip_field_name_prefix(elem, promisor_field_filter, &p))
+			info->filter = url_percent_decode(p);
+		else if (skip_field_name_prefix(elem, promisor_field_token, &p))
+			info->token = url_percent_decode(p);
 	}
 
 	string_list_clear(&elem_list, 0);
@@ -646,11 +719,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info, NULL);
-		string_list_sort(&config_info);
-	}
-
 	/* Parse remote info received */
 
 	string_list_split(&remote_info, info, ";", -1);
@@ -663,6 +731,11 @@ static void filter_promisor_remote(struct repository *repo,
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
2.51.0.168.gc8716bf361

