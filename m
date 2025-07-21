Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEA2DAFC9
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107083; cv=none; b=QRmloSVz5ohrf6PHEn8P1YVHcbXGuTMm/UPZdEpSKXAwWuUEpoXQ/K6cbb4LsiDXS3derQz/okBDnlyLVyKr5RSyph8yNGbaVI9ywedBtxRlPAAjgX8ZJUhvmsJ0l7sVHmUD9tJ8Up/EpjWIvM+vDt2ZJRtYjIOz2RDuaEMajwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107083; c=relaxed/simple;
	bh=yPcsHnB+jIOXwVRisHm3qA8cunQZCtyj5J+wP7aBp1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRin2uLe9C6DMlTYz+0J/ybD/1iAVzcu9ikxD4vAUh2JVvNV0vQ5lzWo6lcNyuMU3mIQ+AIew+m5km1KoKF/0clJ7Ctjy1q5u+TH8rDOhsMHXMArzEl9PeAAS8yk/pQ5vqVK+UiXL1sqNDG1jALzwx1jMbDE1KtHPb2ZS5cg2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL9wSzET; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL9wSzET"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a510432236so2599990f8f.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107077; x=1753711877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2vfzZEklyk7ziUMu+QSep2vY0PHNpayozEN3ifFumM=;
        b=NL9wSzETnewYO+80dtqJh/MRizQuTBmo4LDtmYhcCGac0OpLwbxO7bZ8za2n23QF8g
         Hllxrp8ZOgt4f2yvBT4UCg5UhkRKaZFvgLMfBbk7lOlF4MEZjq1sc8uZMLJlaRkClKiP
         4t6K12xq3Wj3d2sSj4ZOpuzR/1jJvSp5olueIsrZFWbV6+o54HQztXw1KD/VSV7P6LZ+
         PYBXd2n8Cv3qXZUqVHjaufW1S2uFXHtZsVYl3ggyaSCfJE6l484o0A6IbbUiJ3woIbcJ
         tXAGoLgS93iewQNWGqtyjY7OcrJvznDqpfcSW/R35/wxbaN01FQrObRKNF1TMZ4JK4O1
         wCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107077; x=1753711877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2vfzZEklyk7ziUMu+QSep2vY0PHNpayozEN3ifFumM=;
        b=L/9VwgWE2eQ2Wr263IVP7dXB4pr6BTYAaDHicUdD+IGC7rrWKjXa1dkK7Bzv2emLeg
         Vft4Sr9TiBHAYHp46eofqUc1I4kzXDG6VMrDK8MA/WG0II5ktR8AVioxWsFXsCtl7hat
         MVbTwbrTRQrM12ahdbd05JJfXNvDeyWRLv/Nx99TVH9ocGSfK3WFNh+CqHz8Z54tVQjK
         dK2keQBiQdthXvjPByP5gV5GSAqNownA1cjOSLzPazwL3z2p0FNGDTvEofisCKuseGrV
         iqKkY7STg7gh/iM+HRiH+tu8NKnhkMNO5NhCjG/dH+7TFvufYK5PomWyPrHjRQPs4Jmo
         GwvA==
X-Gm-Message-State: AOJu0YyB464KY3OB0eeyP+vSHFgszkE48dPsBaXTud0s1iVmq9E8nZcw
	GkPOgX8enogfjx+XXaXWyVpgkNRz5rRv1bTtHrl8PVKebsxA4uQUkzrcoIk14w==
X-Gm-Gg: ASbGncs40enwM9bzmKI/MvVUW6usXa4+zm3Goh6AqO00hemDg+vS0mD4ZFG1gS+qXZd
	oMlyBC0ZBi22HhskDbY2zTG4HGhnz3YzjVXaTl2IRyks9RD8mzTHakGi8/vapKsmOMSyo83HIp+
	hJubAuMmsYoY876GJf/YeNdHmTsp65CuJ+agh5Nj23HKzKH65q95yzHy4WVxq/O9lhigocavEAZ
	iYQwCCfVHtQrHmId3/e1nWiDuDBbwKU8VpkZRvFsWH1TchvyWvb0B/P1yMGlmNhegvk3s158nOG
	LtOaxtCzZnN0GH3NDr9BU/my1eVY4uhVrIXVI92gZeVrpzFrF7aVY4A3rLbHF5DBKWGKQK8zTnO
	I1jpJ4Ob6oUTn0oKLN8s/Ig1UNPDsd+u5a+A5ZtXKmH13QgY8etiKysdwCNWT17QMB0Ca0Hn9rB
	PvDPcjEGDtoPZnTWM=
X-Google-Smtp-Source: AGHT+IETrE+KiYjNzjVBv034z7gy4fzG+K23di4Wb4hYnln0lR0cfpOdOOFHEFx9siHb/gcm0acTaA==
X-Received: by 2002:a05:6000:4284:b0:3b4:9721:2b1c with SMTP id ffacd0b85a97d-3b60e4c9134mr13759124f8f.6.1753107076362;
        Mon, 21 Jul 2025 07:11:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm160885585e9.1.2025.07.21.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:11:15 -0700 (PDT)
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
Subject: [PATCH v6 4/5] promisor-remote: allow a client to check fields
Date: Mon, 21 Jul 2025 16:10:22 +0200
Message-ID: <20250721141056.2283349-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.324.gc7d7c83534
In-Reply-To: <20250721141056.2283349-1-christian.couder@gmail.com>
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com>
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
index b4a72c2152..1cfea2fa07 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -50,3 +50,43 @@ promisor.acceptFromServer::
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
+Field names are compared case-insensitively. Field values are compared
+case-sensitively.
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
index ae2c49a0a0..501cb92391 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -388,6 +388,20 @@ static struct string_list *fields_sent(void)
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
@@ -598,6 +667,10 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
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
@@ -640,11 +713,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info, NULL);
-		string_list_sort(&config_info);
-	}
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -659,6 +727,11 @@ static void filter_promisor_remote(struct repository *repo,
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
2.50.1.324.gc7d7c83534

