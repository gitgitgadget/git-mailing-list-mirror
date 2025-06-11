Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A244C63
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649532; cv=none; b=eGEDu0uk4fBJxa6BnymZZHIRdtX2gFdG6JQiiTb0bRQdH6urGjD9s1/dbbzk1Op+371aOEyY1XcmN0bEzJQzOq8M91nvLYXCX+79jKBifG8HUy9pwmv4X0v53E1IGBSb1e/DpcbYPqQsedrRd9lhpkybPwUj/fd+83mhALQuig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649532; c=relaxed/simple;
	bh=ovCtQ7uDu1q99GpCsjT4cYDJYF7DoisDpjw5YHbeq0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2lETBozwiMBt7jdNj3HTuxV6xgl3/XQgK7mJwOUbgzDTfCR5EN5grXntCY6bk2uTNZINS906dHTxb8JTNj0nVhbZrytAiVlpDUHx5j3Jzum3ISKpXUnk428Zql9SKtSPR2TzwZpY1hEJOr88JAzlRzRPnciEgMu5F8p5/8SxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGIbQASv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGIbQASv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so43489645e9.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649528; x=1750254328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfedqOCDUnij+ZVBW6ARGISWUNad49VHi1IH46TR0Uk=;
        b=WGIbQASvx76BcjLFWRbctp0sj3xU1w5Hs6FE8iw9HIW+ChrOjkqmSuowQJAR9WFYkT
         pPShlgaKMIceVGPubBb3FM0g/TCCOlV9RK6FdPMLCVVX13ryn8Iro+VpBloBe79xLQj9
         8aDsVNby6A3rIH//I8/Y9MMCtE+wUaQj6x6o6B/xpPt4zgj86iGFLudpS/4NvKddk2+a
         xVnrRoBeA0krF4UrjOtbvfnERdFu02D6ltJspNsEUPZsHw8ymDZ1aGtI0q/jyq94o5/1
         i8HivZoRaPW2toddu8RoMyNv/75UN49tvKcoDA8DdFZIxE0/L7MuFgR165SvR4GPnJ0u
         NSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649528; x=1750254328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfedqOCDUnij+ZVBW6ARGISWUNad49VHi1IH46TR0Uk=;
        b=chRXvylE3G+9YwuzAqo2yxuA+w/BrSOslqJ+M6N/fR2g4xzm6RqUcHC0+8zb0uIJPZ
         VJJJg1OX5Wr20Jfv5c2rmsAXKQzscO7ADd6beWbBU4r3pTx5QPQ6hQ7Yjl7gw7AgkFRb
         bvEOHM27VE5N3R20iF3tLJQzQjH9K7r/HMFwz4XVoahzaMpCFw6AjZtFyBy2EDn+d/nD
         WEfu6TrjloJ6A+VB+qFO8mZUNHgj7wwfBHUsoa3uvvEg8uo5w12brgREobJmYdVRSBOh
         1jPddCJANPqxXmbFDNiDJ++szECqxUuJZSWBGeSweCbuRidLgEKNZwoMYgr5aUUVtO1F
         bR2w==
X-Gm-Message-State: AOJu0YwJMnSnJOPbj1xcAUsYc7kRnrm/ywmM/zjErsRn7aSnGIpBn7cY
	QJZBw+V4WZ5jI7D3oQpNgQaBBJcaO4rJjZmIn6mc1yeZBPYuZbBJfzfABV0LZw==
X-Gm-Gg: ASbGncs5un1Y4vkJTbb51skUtKLbbf9Fpvay1cevBm9aOneSIO6+mJ6hSXg5dIe2U2u
	Yd590Oc+yHl2N7Bbm4jh3xz0vFt7Y0ZhJiG4MzSOlmmsbsjTkBnInGuF5Q8La/gix9SNpZp5PuY
	176ebRY7r9zzhCk+ESgCDcdhDZsz614wVk7RL8moIF+r8svWr1v1l0GiDlFKgGCLUYi9EJVAzyI
	l/Yg/QQyi7zUNUwa/1MCY2MYYITMmAPmJ1F80BTM1d01ZW9lMzHuLb9mBN7DA6MM914cZ5pPTEU
	RUUmBsWs/smsgCKno7B3c8DbqwkmP3v3KfJEFI2gRdGsWGLdPrOAXqnu4s1bi+p1sDw4DBlxuFh
	XqVTEjoyvQHWF8yhIMD5xvNtxzHemSf+2c629YxIkBgAhNZUsRae7YQc=
X-Google-Smtp-Source: AGHT+IFUE61FHT7LxvRQwhG6rLkzukju9sEbWGMn1rng59wrd2gYM8DwyghpZY5jQiidfajxQYrcyw==
X-Received: by 2002:a5d:5849:0:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3a558a45b65mr2761729f8f.43.1749649527433;
        Wed, 11 Jun 2025 06:45:27 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:26 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/5] promisor-remote: allow a client to check fields
Date: Wed, 11 Jun 2025 15:45:05 +0200
Message-ID: <20250611134506.2975856-5-christian.couder@gmail.com>
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
 Documentation/config/promisor.adoc    | 40 ++++++++++++
 promisor-remote.c                     | 89 ++++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 34 ++++++++++
 3 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index beb8f65518..9682ada23c 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -50,3 +50,43 @@ promisor.acceptFromServer::
 	lazily fetchable from this promisor remote from its responses
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+
+promisor.checkFields::
+	A comma or space separated list of additional remote related
+	field names. A client will check if the values of these fields
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
+`promisor.checkFields`, the advertised remote "foo" will be rejected.
++
+For the "partialCloneFilter" field, this allows the client to ensure
+that the server's filter matches what it expects locally, preventing
+inconsistencies in filtering behavior. For the "token" field, this can
+be used to verify that authentication credentials match expected
+values.
++
+Field names are compared case-insensitively. Field values are compared
+case-sensitively.
++
+The "name" and "url" fields are always checked according to the
+`promisor.acceptFromServer` policy, independently of this setting.
++
+The field names and values should be passed by the server through the
+"promisor-remote" capability by using the `promisor.sendFields` config
+variable. The fields will be checked only if the
+`promisor.acceptFromServer` config variable is not set to "None". If
+set to "None", this config variable will have no effect. See
+linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index e291a00a73..939cc78a7d 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -382,6 +382,20 @@ static struct string_list *fields_sent(void)
 	return &fields_list;
 }
 
+static struct string_list *fields_checked(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
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
@@ -527,6 +541,61 @@ enum accept_promisor {
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
+	struct string_list* fields = fields_checked();
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
@@ -537,7 +606,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return all_fields_match(advertised, config_info, 1);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -549,7 +618,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -564,7 +633,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		    remote_name);
 
 	if (!strcmp(p->url, remote_url))
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
@@ -596,6 +665,10 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 			info->name = value;
 		else if (!strcmp(elem, "url"))
 			info->url = value;
+		else if (!strcasecmp(elem, promisor_field_filter))
+			info->filter = value;
+		else if (!strcasecmp(elem, promisor_field_token))
+			info->token = value;
 		else
 			free(value);
 	}
@@ -638,11 +711,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info, NULL);
-		string_list_sort(&config_info);
-	}
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -657,6 +725,11 @@ static void filter_promisor_remote(struct repository *repo,
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
2.50.0.rc2.5.ge8efe62b7f

