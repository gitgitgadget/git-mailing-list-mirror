Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93E1A2576
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985830; cv=none; b=SiBW7/OYLDVnL/TT0zD5hDhB+R6l5PWEohncfJmogmxi0Q4Ey9GHYBI+z9uhKRWjakSNdUXtuaSGQ3NIt7vV0Mlcd7Ih+MoKyIIUZIxX7jGK+Ci6Ql+kddb8q8IuUl2jDlomhJk6u8W6Tb9caC+iVrW6DZYE5Rr5aeCMQEUAI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985830; c=relaxed/simple;
	bh=j0mLt02jD8fWrq09lJ7n2yvN8x079uNgRzeKXfUNT1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmQZYSDmPYhwwsaIJwLOHEeN42kzr8ngOZIeHaSINAuYjn5zQMQdtL8whWzlShw1Y2gwpOClH74fgN9iOaTvt176AWbg7ae3cUecp4wyOvrJx1+spRLqj8o2GpbwrDeGSpo1SIk/hY9JvYCjvR7LlVOC5OdUMJDbHH5lNCFXpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyV1DQEt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyV1DQEt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so9900945e9.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985826; x=1726590626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fofkcqyB+IkL+epoxSrto4IA9ljK97B/4ILztsK04ag=;
        b=OyV1DQEtFFNdj3l7X56eREXJLP2Elh71S3VsO9muPUGkIEEjMq39+07z2DAzZEAWJk
         UpQzMm8fOb9pjG1NVoSmCI3HHY73osRVdOAzUgbdGSagfFrnnSZErK4JODMbiIUPa4o1
         2iJBHDCC5ywfvrgUQpeWCr9CiXLq/qXDnWHiCsriiQ839N7Jw4Kxv064Kc67dy6rdo2h
         ML/17UUBgqO2cfLx7Zv/ccVXyGjSUZOJQI35ByniDfuJ3bre3BnrWaWIfX8+zTJlOCTQ
         eLXmUEGR6X8utKII2lSbh71PZwFDHGVAMb3b6p4rNYemAVH6v3WyfOgR2QZxfJatA1H4
         op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985826; x=1726590626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fofkcqyB+IkL+epoxSrto4IA9ljK97B/4ILztsK04ag=;
        b=KUix2Bc2O7mG9E6ek5DdwAxXvRwBCRCAk70+sSOX6ES30ljkp09MH5juaQ+m5iW4TX
         n9lE58TDqGIV39X4BbRcaMrZhGfNPyr2/hxcnW2r9caP6XOnDIgoELA0CiPyiI1Rm/+d
         7RBG292KBrFy/ABqIkg33299ft+Fn+8kW26pLWptNmkCXtbjOZqWIuxL+353mXShPD/M
         H2AhmHAJHpFXfD2mjBp+x0sL3OVHLCUahG8KAv0sRYSS0s70CTOZn9vtgWYrALRJqEsc
         oVtIv7AOfWPAolWPzlBfvmziB/w13zh6U3gGa59HYoLEm0MnZYsoaPUbMOIMOWrQKF83
         TQEA==
X-Gm-Message-State: AOJu0Yyujv50dubsyosEOD2IOgj2dq0MepwwafIbFPHnqJNNpAVWoaV1
	O0IX8xe+Yz2yEL2FE7it80OM4w/OcrqSjONH3UInZiwZdxk63nbJZqGdkA==
X-Google-Smtp-Source: AGHT+IG9rNi/YFxu4I/XsnzVaxTxqG9aZSJMt4I/BxB8LsQ4d+Gv47BfoPF/Fxz2a9pIOHdWCaoQfw==
X-Received: by 2002:a05:600c:3541:b0:42c:c37b:4d53 with SMTP id 5b1f17b1804b1-42cc37b501fmr17241935e9.0.1725985825133;
        Tue, 10 Sep 2024 09:30:25 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm29897865e9.0.2024.09.10.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:30:23 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] promisor-remote: check advertised name or URL
Date: Tue, 10 Sep 2024 18:30:00 +0200
Message-ID: <20240910163000.1985723-5-christian.couder@gmail.com>
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

A previous commit introduced a "promisor.acceptFromServer" configuration
variable with only "None" or "All" as valid values.

Let's introduce "KnownName" and "KnownUrl" as valid values for this
configuration option to give more choice to a client about which
promisor remotes it might accept among those that the server advertised.

In case of "KnownName", the client will accept promisor remotes which
are already configured on the client and have the same name as those
advertised by the client. This could be useful in a corporate setup
where servers and clients are trusted to not switch names and URLs, but
where some kind of control is still useful.

In case of "KnownUrl", the client will accept promisor remotes which
have both the same name and the same URL configured on the client as the
name and URL advertised by the server. This is the most secure option,
so it should be used if possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.txt     | 22 ++++++---
 promisor-remote.c                     | 54 +++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 68 +++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
index 9cbfe3e59e..d1364bc018 100644
--- a/Documentation/config/promisor.txt
+++ b/Documentation/config/promisor.txt
@@ -12,9 +12,19 @@ promisor.advertise::
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
-	capability. Default is "none", which means no promisor remote
-	advertised by a server will be accepted. By accepting a
-	promisor remote, the client agrees that the server might omit
-	objects that are lazily fetchable from this promisor remote
-	from its responses to "fetch" and "clone" requests from the
-	client. See linkgit:gitprotocol-v2[5].
+	capability. If set to "knownName" the client will accept
+	promisor remotes which are already configured on the client
+	and have the same name as those advertised by the client. This
+	is not very secure, but could be used in a corporate setup
+	where servers and clients are trusted to not switch name and
+	URLs. If set to "knownUrl", the client will accept promisor
+	remotes which have both the same name and the same URL
+	configured on the client as the name and URL advertised by the
+	server. This is more secure than "all" or "knownUrl", so it
+	should be used if possible instead of those options. Default
+	is "none", which means no promisor remote advertised by a
+	server will be accepted. By accepting a promisor remote, the
+	client agrees that the server might omit objects that are
+	lazily fetchable from this promisor remote from its responses
+	to "fetch" and "clone" requests from the client. See
+	linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index baacbe9d94..f713595eb0 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -367,19 +367,54 @@ char *promisor_remote_info(struct repository *repo)
 	return strbuf_detach(&sb, NULL);
 }
 
+/*
+ * Find first index of 'vec' where there is 'val'. 'val' is compared
+ * case insensively to the strings in 'vec'. If not found 'vec->nr' is
+ * returned.
+ */
+static size_t strvec_find_index(struct strvec *vec, const char *val)
+{
+	for (size_t i = 0; i < vec->nr; i++)
+		if (!strcasecmp(vec->v[i], val))
+			return i;
+	return vec->nr;
+}
+
 enum accept_promisor {
 	ACCEPT_NONE = 0,
+	ACCEPT_KNOWN_URL,
+	ACCEPT_KNOWN_NAME,
 	ACCEPT_ALL
 };
 
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name UNUSED,
-				const char *remote_url UNUSED)
+				const char *remote_name, const char *remote_url,
+				struct strvec *names, struct strvec *urls)
 {
+	size_t i;
+
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+	i = strvec_find_index(names, remote_name);
+
+	if (i >= names->nr)
+		/* We don't know about that remote */
+		return 0;
+
+	if (accept == ACCEPT_KNOWN_NAME)
+		return 1;
+
+	if (accept != ACCEPT_KNOWN_URL)
+		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+
+	if (!strcasecmp(urls->v[i], remote_url))
+		return 1;
+
+	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+		remote_name, urls->v[i], remote_url);
+
+	return 0;
 }
 
 static void filter_promisor_remote(struct repository *repo,
@@ -389,10 +424,16 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
 
 	if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
 		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
+		else if (!strcasecmp("KnownUrl", accept_str))
+			accept = ACCEPT_KNOWN_URL;
+		else if (!strcasecmp("KnownName", accept_str))
+			accept = ACCEPT_KNOWN_NAME;
 		else if (!strcasecmp("All", accept_str))
 			accept = ACCEPT_ALL;
 		else
@@ -403,6 +444,9 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
+	if (accept != ACCEPT_ALL)
+		promisor_info_vecs(repo, &names, &urls);
+
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -432,7 +476,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -441,6 +485,8 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 
 	free(accept_str);
+	strvec_clear(&names);
+	strvec_clear(&urls);
 	strbuf_list_free(remotes);
 }
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 7e44ad15ce..c2c83a5914 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -117,6 +117,74 @@ test_expect_success "fetch with promisor.acceptfromserver set to 'None'" '
 		--no-local --filter="blob:limit=5k" server client &&
 	test_when_finished "rm -rf client" &&
 
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server
+'
+
+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownName'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch with 'KnownName' and different remote names" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
+		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.serverTwo.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=KnownName \
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
+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownUrl'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch with 'KnownUrl' and different remote urls" '
+	ln -s server2 serverTwo &&
+
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/serverTwo" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 ""
 '
-- 
2.46.0.4.g7a37e584ed

