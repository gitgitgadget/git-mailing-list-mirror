Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBF25B30D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855883; cv=none; b=oAHNEmWSmJggwEj85MNkq5cseepC6kkGNoEMoJBJSJQPAuoTyx+LgusUQStd9oigDwd2oFX8kMiq2vp4zsXIjbdumw5/gBU+xPLixBHH8qSjROVy/uOKk2cBn+oP2REVLkGR2FpkU3z8T13Repi5N860Lmjq59fBd+4n9zH1y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855883; c=relaxed/simple;
	bh=7jYD8eOE9r2FiaFqc7tvgopGEy/2PpcjTIg8ua2j4Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur40WTNpaEjvWXjtBoaZp8QqWqei5ZJcoEKEu80y2fe3Kio4L6uHDM/kKRCIEJUNBqXtIOAb5VzcrLYlZqxftduKKkBDOE+C2KABkJ1laZKTIKGstRHfl9cyS/0Gu+3isT8VFZyHnqkoErldGkjdI/HSJUQqXNouSw2lsYEF/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0wTGitB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0wTGitB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3868920f8f.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855879; x=1751460679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG5rDwX9WMKf+qo6JDIVQCbdiN3CFxTtvOuLWN7gPTM=;
        b=O0wTGitB4LtrGl1QUDsWz3zPd3RvLq4ieMxEN4Hay5ROSZeo//izYjpqgvR3nl2ylm
         sRcbcyss2k0YPWCczEtA3bOVTx6Ntp6tkCd32WO/COz6il9EPdPtFPyzZg3uoC/PItQs
         5DVv3R5qIvbL7UHoAZkRyyWcpcPDP3o4fQqFOX2vid6QWGuLlePLt3fUm+ZkjNXyhF+E
         bL43qUbZx3AmlN8CUGj+/h7Bu9bgFNFHofBxWd5zFTs7iHl9LkGSKYbm7tluBJ4q1XPA
         +xKexnZnyzcLit78iGHpAm2caxOF2g6nq+hKobABC3KdpxK2vM/JRVxMAmRNSSy6I3lz
         xgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855879; x=1751460679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG5rDwX9WMKf+qo6JDIVQCbdiN3CFxTtvOuLWN7gPTM=;
        b=e722c4UcC/L0cnauAtX0oXqpZX3zsTRu3XqUSziTKjgEWyGPnva2Seayklc5bWzmRk
         R83Wz139hKV0MHGqaZ+CaeBmK3saWX4HLlOK0xB0B+kfzQLvBIdMbd2v2/HzoiLQB9Kw
         oiWGEZhc4Me3H/+8f0W6Tb0WC1ClpN501iqbgZv+WJUHKxSR4c664WumBuQ68ICGQgv2
         mCtxC5rJf7XAjPIKvahFnQiG8s9qCoY8jFWJozw1thBvLg/AjvT3TGmfIasWDUNyc6FU
         vzh+pfVHTSp6s3kPeuDHLWKYk0TMN2upGqxuvWBQq1qj+9Ra93RaKADiE8cqTe5doPzR
         vAOg==
X-Gm-Message-State: AOJu0YydUnkdEr7Ll1bbSyolHcibgPLbhudvJ7Zh3tmiqmnesrw/M33e
	O1rRtjF6dM00KiHZ+XAwTDtDytUjZRccR1DlJ3CcxwZfYN9EFpJ5Jt6t4iXBxg==
X-Gm-Gg: ASbGncsKp6UW3bZlQMw37RVMT0hcz8QXb2Rcggz2skYHb+0nklZITnVJ+vpz9ZXIn+l
	azJCVjxLEmfQli7lL8ervsOTCDIMMn2LHMGJV6KxL/jeuLnG2IAoDvwmSmvsC9NL02aFX9ycCd2
	RhF6faLynU62b9qrF13g+LqpNvtCeTlOsXDJSkBxbuWNzMpDG4UgW2BLIoNfTX3LdTXsSrqLW+i
	F8QL6ZahMwHfkiSlsVlcppwECoA+ibPZrSfJ9eQEOcELIrKmv1zlvIrzaCcDD4hmZfVlK4fIWbE
	o5R4EVDicZUXrLiQV8fkReebpfYXd79zm2v9Ig8eyQYZ5FQ3s4Nbca72w/26zd794xwe+MWuF9p
	yEwvRgp5OifbLQmtO3ovUnUDXKLsxkej7SFwoImCzxKyWKAAoWQ3Ti/4=
X-Google-Smtp-Source: AGHT+IE/VBoBcOo2fCsRPbfZ2blFJFoo+hA8VQrl5wLGPnc+d0xzgaihynI2V5jN95e5SNFokwSFbw==
X-Received: by 2002:a5d:5f8c:0:b0:3a4:ef8e:b31b with SMTP id ffacd0b85a97d-3a6ed601541mr2348172f8f.24.1750855878403;
        Wed, 25 Jun 2025 05:51:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349548sm19446905e9.10.2025.06.25.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:51:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/5] promisor-remote: allow a client to check fields
Date: Wed, 25 Jun 2025 14:50:54 +0200
Message-ID: <20250625125055.1375596-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.86.g149b275
In-Reply-To: <20250625125055.1375596-1-christian.couder@gmail.com>
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com>
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
index b68772d573..049406c882 100644
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
@@ -570,7 +639,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		    remote_name);
 
 	if (!strcmp(p->url, remote_url))
-		return 1;
+		return all_fields_match(advertised, config_info, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
@@ -602,6 +671,10 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
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
@@ -644,11 +717,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL) {
-		promisor_config_info_list(repo, &config_info, NULL);
-		string_list_sort(&config_info);
-	}
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
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
2.50.0.2.g875523421d

