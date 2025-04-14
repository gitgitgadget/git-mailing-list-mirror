Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7A274FDD
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646662; cv=none; b=eTzCNA3hNKX6II+QuYA65xV8gEruG/jmOWyKlPmXuDA8SbcUY/BLd72cuJIViR03IlnE+fJyLezFAjVR6b/XL167kZXh61/cqz4Y06p5O48fKXaYf1VwYFCqW1C2uLx8xo5+B05ZbW0CzwDlvADgHrddoDuSC/lOpqwL+xHlZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646662; c=relaxed/simple;
	bh=6OdCY7lJNau1sdct+Tne1pviPwRPCrStnBLBFQYYwZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLYR5deARhrqNHHTal5m/tYuTvA7Ze+T+udAGPk0xD968oLHpDO/ExFjs/aV0eK/c0jeBIzSmMic+5neHMYU4E0cqdO7djXKt9nOAppS6EvDIiX8/mY3kFVNrNdUWcr/IiTHhmoDsctjNcwVYGw++tsw5qWQ1Jlj7OoQcjAU7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO+3LPcC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO+3LPcC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so2685639f8f.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744646657; x=1745251457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPOCgMRAMAj6oIp2oaeafLCaj6yIbtKAFYzkOPz+III=;
        b=fO+3LPcCtrX8n1A3jeq8u8rGLGcKAe1m+t5pPITdP6vuKG8zqbPChW2KyNjsmE7Efr
         IvWmmMFQQ97fBW6kbeWIopWOVjijoNfpycTSCl5iWc9cED1GeD8NxNUPXyApEL6eLzCC
         FxjIwtWdtf66YK7wzC8Oc1/Y2hamDPlxOt7V3HmYBQdF7MNGN1aiCR3EjNpr6qCWSnUz
         gMH4JEM/2+8KS3bgBIvGkEMU2pQ5uHTb1GlbcrWcr77GguqBif//Kq2pTzmb2rU1Ed0V
         e+G70BFKOohiPiwW8F0pPIir5WEIKoRbTwncpKUE5ebP1hwaRmJ0Fc6/kyDJ+y7TRvla
         rw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646657; x=1745251457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPOCgMRAMAj6oIp2oaeafLCaj6yIbtKAFYzkOPz+III=;
        b=A3l+Z44TdHbNa0BzVEDNrfWpCZ5rNwr26w2CiLW/CLok/fXP+ny7LnVNfdvAOcLycy
         vSkJRU/dx5XGKKXdH7fuHJ9fkB3kxqTOuUip26yhc9Y8gbemRlSMcPtUGWxV9+oFjIal
         7UQ+39nyTITAlHZTpqMhAILTDcfN03UFQ7o6VmkHh0DyEjwutdy+u9EK1pI9b6sWI4YJ
         KkIRef9kZpq5xDoRsKu2zjll57cPad477iazCCvqH9FaiS7KsMZt+zZ+RF07dpSTayfw
         M7K3CZMM0Jdpg0KoTyE9IZz224+5vPOteGQvxvMD8SR9NWVXW+RwgEZHPqCPa/vgxMzO
         gbhQ==
X-Gm-Message-State: AOJu0YysUQl/XldmW5idobPMSnF1eabZadl4vnmUc2vqKdP84WQRmY0I
	VgT/PuNe+B+2PDhF0FdJ21ziTfDMmB6nzYmGpiUhfGfP8B+rBEv0vw7XYw==
X-Gm-Gg: ASbGncuse51kgBuzcpHRsFfBPrTo6P5KZVdClSkGOn0bsi+7nMV9W4+tK/ziEclDjAk
	8T3bwPulTsRzv3ORU6VJv5Y03SkTDSBY2Ogw6wlR5S+I8/d1TFs6jeJyoBbH4mXWyvWnh5OtpxT
	pq4Ldt7zieH7X4HaojfWGI2W0V+8ijR/eY/OqwjLlM2nu4Bv5NoqA6f7JxT5Pyv3veLrl0R/LKF
	EhXO+SQjikg/VnWx4gPbJe8IF02DnHgLP2qTuQKaP8r4oNkrGzO5MeMiUzir24mac55HBhZjbA+
	CG33AYQiyiTsBJhemx+PjkUnCVSxSI9PdR7dqFT+cgG0bKiiij9MApymjWB54OoKq0tChPVWvHI
	=
X-Google-Smtp-Source: AGHT+IGeV+2ChvVraiPadqt3IkuZnuf+uMusGVq/9tptAJvet7N/FVDl4CTYB4hGH7bz+zJAsXWwXA==
X-Received: by 2002:a05:6000:2912:b0:38f:37f3:5ca9 with SMTP id ffacd0b85a97d-39eaaec991cmr8044605f8f.50.1744646656545;
        Mon, 14 Apr 2025 09:04:16 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:a9d4:af7b:bb5c:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm11258029f8f.42.2025.04.14.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:04:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] promisor-remote: allow a client to check extra fields
Date: Mon, 14 Apr 2025 18:03:43 +0200
Message-ID: <20250414160343.2216312-5-christian.couder@gmail.com>
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

A previous commit allowed a server to pass extra fields through the
"promisor-remote" protocol capability after the "name" and "url"
fields.

Let's make it possible for a client to check if these extra fields
match what it expects before accepting a promisor remote.

We allow this by introducing a new "promisor.checkExtraFields"
configuration variable. It should contain a comma or space
separated list of fields that will be checked.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  17 +++++
 promisor-remote.c                     | 102 +++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh |  35 +++++++++
 3 files changed, 143 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index bc08999733..75207de2ac 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -43,3 +43,20 @@ promisor.acceptFromServer::
 	lazily fetchable from this promisor remote from its responses
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+
+promisor.checkExtraFields::
+	A comma or space separated list of additional remote related
+	fields that a client will check before accepting a promisor
+	remote. When a field named "bar" is part of this list and a
+	corresponding "remote.foo.bar" config variable is set for
+	locally for remote "foo", then the value of the
+	"remote.foo.bar" config variable will be checked against the
+	value of the "bar" field passed by the server through the
+	"promisor-remote" capability for the remote "foo". The remote
+	"foo" will be rejected if the values don't match. The fields
+	should be passed by the server through the "promisor-remote"
+	capability by using the `promisor.sendExtraFields` config
+	variable, see above. The extra fields will be checked only if
+	the `promisor.acceptFromServer` config variable, see above, is
+	not set to "None". If is set to "None", this config variable
+	will have no effect. See linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 424d88d4a1..3645093f2f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -358,6 +358,19 @@ static struct string_list *extra_fields_sent(void)
 	return &fields_list;
 }
 
+static struct string_list *extra_fields_checked(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_from_config(&fields_list, "promisor.checkExtraFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
 static void append_extra_fields(struct string_list *fields,
 				struct string_list *extra_fields,
 				const char *name)
@@ -497,15 +510,65 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+static int check_extra_field_one(struct string_list_item *item_value,
+				 struct promisor_info *p)
+{
+	struct string_list_item *item;
+
+	item = unsorted_string_list_lookup(&p->fields, item_value->string);
+	if (!item)
+		return 0;
+
+	return !strcmp(item->util, item_value->util);
+}
+
+
+static int check_extra_field(struct string_list_item *item_value,
+			     struct promisor_info *p, int in_list)
+{
+	if (!in_list)
+		return check_extra_field_one(item_value, p);
+
+	for (; p; p = p->next)
+		if (check_extra_field_one(item_value, p))
+			return 1;
+
+	return 0;
+}
+
+static int check_all_extra_fields(struct string_list* extra_values,
+				  struct promisor_info *p,
+				  int in_list)
+{
+	struct string_list* fields_checked = extra_fields_checked();
+	struct string_list_item *item_checked;
+
+	string_list_sort(extra_values);
+
+	for_each_string_list_item(item_checked, fields_checked) {
+		struct string_list_item *item_value;
+
+		item_value = string_list_lookup(extra_values, item_checked->string);
+		if (!item_value)
+			return 0;
+		if (!check_extra_field(item_value, p, in_list))
+			return 0;
+	}
+
+	return 1;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name, const char *remote_url,
+				const char *remote_name,
+				const char *remote_url,
+				struct string_list* extras,
 				struct promisor_info *info_list)
 {
 	struct promisor_info *p;
 	const char *local_url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return check_all_extra_fields(extras, info_list, 1);
 
 	p = remote_nick_find(info_list, remote_name);
 
@@ -514,7 +577,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return check_all_extra_fields(extras, p, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -530,7 +593,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	local_url = p->fields.items[1].util;
 
 	if (!strcmp(local_url, remote_url))
-		return 1;
+		return check_all_extra_fields(extras, p, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, local_url, remote_url);
@@ -564,9 +627,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL)
-		info_list = promisor_info_list(repo, NULL);
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -577,14 +637,27 @@ static void filter_promisor_remote(struct repository *repo,
 		const char *remote_url = NULL;
 		char *decoded_name = NULL;
 		char *decoded_url = NULL;
+		struct string_list extras = STRING_LIST_INIT_NODUP;
 
 		strbuf_strip_suffix(remotes[i], ";");
 		elems = strbuf_split(remotes[i], ',');
 
 		for (size_t j = 0; elems[j]; j++) {
+			char *p;
+
 			strbuf_strip_suffix(elems[j], ",");
-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
-				skip_prefix(elems[j]->buf, "url=", &remote_url);
+			if (skip_prefix(elems[j]->buf, "name=", &remote_name) ||
+			    skip_prefix(elems[j]->buf, "url=", &remote_url))
+				continue;
+
+			p = strchr(elems[j]->buf, '=');
+			if (p) {
+				*p = '\0';
+				string_list_append(&extras, elems[j]->buf)->util = p + 1;
+			} else {
+				warning(_("invalid element '%s' from remote info"),
+					elems[j]->buf);
+			}
 		}
 
 		if (remote_name)
@@ -592,9 +665,16 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, info_list))
-			strvec_push(accepted, decoded_name);
+		if (decoded_name) {
+			if (!info_list)
+				info_list = promisor_info_list(repo, extra_fields_checked());
+
+			if (should_accept_remote(accept, decoded_name, decoded_url,
+						 &extras, info_list))
+				strvec_push(accepted, decoded_name);
+		}
 
+		string_list_clear(&extras, 0);
 		strbuf_list_free(elems);
 		free(decoded_name);
 		free(decoded_url);
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 26f3c63112..858b34587d 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -321,6 +321,41 @@ test_expect_success "clone with promisor.sendExtraFields" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.checkExtraFields" '
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
+		-c remote.lop.partialCloneFilter="blob:none" \
+		-c promisor.acceptfromserver=All \
+		-c promisor.checkExtraFields=partialCloneFilter \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that extra fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,id=fooBar,partialCloneFilter=blob:limit=10k" &&
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
2.49.0.158.g6ac6832dc3.dirty

