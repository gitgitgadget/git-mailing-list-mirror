Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72A1AF0C7
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878348; cv=none; b=sJ3znXTE+gLJrYNVUqlwm8OjbypJsmwWYr/gvikL5LYWqbPogxXxvqybGG3/Kz2YNqRm4cAPoEoefCntVZEqTTBJQ1rnvRxvArC6oLVjEmHANpJl5bmmqhI8a8q9dlRJB7LXu6KVRWwEbSsUSOH66yJovqxRB2OpftiICEOe+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878348; c=relaxed/simple;
	bh=jKUEJOP9hCOcXXDufloDh89LAi+vtoIFpFJYOHmVnpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRi1GirEbR/rDNTs2/4y9H7bZkBuAOWk3q5+6ri9naUxOKQEIfZLMxEtB053ZSzO0ei/uqrq5hBH9HfouYrTPz/h2HZlkN1k0AUpRF0poTI4ZFhSgbWMmgaeeu6gvaVXnjL2/ffx2mLw6RzUJQQwc4lb78FjFQ0ADCH2c1OH29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRDDAH9b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRDDAH9b"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43996e95114so2489405e9.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878343; x=1740483143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vm2F+AoJrJ0AC8c2nKFtSWa9bI40E8doum+Ewtdldc=;
        b=dRDDAH9bVElDZMMJd9iTUZ4FWgrCJ5nYGgqH7QgPtgai4ClC3s3g6up36eUu9xIbJw
         CsnSCzl2G48oqBKqnOHzZ/uGpP2ptGRlc8Q4l+lkDPeqwtmEPNSiHRoNcgLCX2ZuE2oF
         J4qUZnn7xWM+IEO3lZEsALw8kKP1gHHL8V/3H4HPqlw4HKs3U0VVIENv9bnUAIDqy+B4
         jOp8fuvTda66I3qDB3BnNqFoK59IT1TUka1DNR5ye18NpTv6TKdMJYujZILQ+H7++mrd
         31fikpJdsxDILLWbXNz3Lm+ZG6A5cfHx2Bd4LDy0aZL4BP4V0vxPqPTt20iOuk7ge0uF
         3y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878343; x=1740483143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vm2F+AoJrJ0AC8c2nKFtSWa9bI40E8doum+Ewtdldc=;
        b=h50b5qCvynEd8LEND6pRWqgKrvGJBtj03qW/plEEocamasqC1/gc549Tjx/WR2WA5r
         sDmJPE52liTEgK+A3+iJhGxHXOiyEJlflBZ3+Yu+v12mJntA7o3fbRRp2O6OVzruuRHo
         uhaL5wvnvzEBzEsMQ0ewFSHfO1qCHErXPCMT6pRdY/4st5YPsL7PM750GLNmsHxuwxRG
         8GFz3BCgTZuX2fCryMYVkj3W+OhQwixhh2XXKD/VX3J4gndPbz/xLFMbpd46VrBf7O01
         iAbtFHivvjvgnvI2PKABQKgfv0yWgbLsNJt0barjRuqCaeAtgxz/Vqpj7p+3AB5HEud+
         4vpw==
X-Gm-Message-State: AOJu0Yy4tg4n60O5vRdvpPV7UK5xvZMq3ZzIpZUHUZpUmfHHG3zkTUHW
	LoR06/BIZzNrDTkQtwO9dPiNkiKUuBy7w+7GWdsC3X7JaNQwf6vj69boeQ==
X-Gm-Gg: ASbGnctX2ZRWVkY+aR39cfqSIbYN+SIAuBCV7sSCL6olQXxcV2DtpIxVvI4qj9/zZrd
	awb15v4z8LfujckS91UYFfh+TTIx1pE7sURnpHDc0xtSu7MG+Rl9HI2MgXIC0VztmwVXtWfFytw
	n3umBiKxcVRB7LaM4xtQRbtyKNE/y0doIiK83p9P/IzXIlk++rW8FFFYkDCLZYS1U+Isq3qSVhT
	hH7xuVuYuyOdXPm84MAMAtz/RjfROduYAOwMHDTTuj0h2LkZ6MMlVOZceayJXIqZiwJa7KgPtGa
	N9KcCLpTmIXABW2LXhsmqlyURk9xzqbhfKWMjB0KSTL6exb29kwkOzVei6ggiuzcUtzNCpUxnw=
	=
X-Google-Smtp-Source: AGHT+IGPoU/ow1YmVnJsYP0V+DcXV4I1O23A8PrLXY+MTYUXpM2xV+6UW/ZZ8VD0r3rkD1kZqOuzWQ==
X-Received: by 2002:a05:600c:5253:b0:439:9274:81d0 with SMTP id 5b1f17b1804b1-439927483edmr19122485e9.1.1739878343031;
        Tue, 18 Feb 2025 03:32:23 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm25270825e9.39.2025.02.18.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 03:32:22 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/3] promisor-remote: check advertised name or URL
Date: Tue, 18 Feb 2025 12:32:03 +0100
Message-ID: <20250218113204.2847463-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.359.ge980fe0aa2
In-Reply-To: <20250218113204.2847463-1-christian.couder@gmail.com>
References: <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250218113204.2847463-1-christian.couder@gmail.com>
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
 Documentation/config/promisor.adoc    | 22 ++++++---
 promisor-remote.c                     | 60 ++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 68 +++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 9cbfe3e59e..9192acfd24 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
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
+	server. This is more secure than "all" or "knownName", so it
+	should be used if possible instead of those options. Default
+	is "none", which means no promisor remote advertised by a
+	server will be accepted. By accepting a promisor remote, the
+	client agrees that the server might omit objects that are
+	lazily fetchable from this promisor remote from its responses
+	to "fetch" and "clone" requests from the client. See
+	linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 918be6528f..6a0a61382f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -368,30 +368,73 @@ char *promisor_remote_info(struct repository *repo)
 	return strbuf_detach(&sb, NULL);
 }
 
+/*
+ * Find first index of 'nicks' where there is 'nick'. 'nick' is
+ * compared case insensitively to the strings in 'nicks'. If not found
+ * 'nicks->nr' is returned.
+ */
+static size_t remote_nick_find(struct strvec *nicks, const char *nick)
+{
+	for (size_t i = 0; i < nicks->nr; i++)
+		if (!strcasecmp(nicks->v[i], nick))
+			return i;
+	return nicks->nr;
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
+	i = remote_nick_find(names, remote_name);
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
+	if (!strcmp(urls->v[i], remote_url))
+		return 1;
+
+	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+		remote_name, urls->v[i], remote_url);
+
+	return 0;
 }
 
-static void filter_promisor_remote(struct strvec *accepted, const char *info)
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
 {
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
+		else if (!strcasecmp("KnownUrl", accept_str))
+			accept = ACCEPT_KNOWN_URL;
+		else if (!strcasecmp("KnownName", accept_str))
+			accept = ACCEPT_KNOWN_NAME;
 		else if (!strcasecmp("All", accept_str))
 			accept = ACCEPT_ALL;
 		else
@@ -402,6 +445,9 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 	if (accept == ACCEPT_NONE)
 		return;
 
+	if (accept != ACCEPT_ALL)
+		promisor_info_vecs(repo, &names, &urls);
+
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -431,7 +477,7 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -439,6 +485,8 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		free(decoded_url);
 	}
 
+	strvec_clear(&names);
+	strvec_clear(&urls);
 	strbuf_list_free(remotes);
 }
 
@@ -447,7 +495,7 @@ char *promisor_remote_reply(const char *info)
 	struct strvec accepted = STRVEC_INIT;
 	struct strbuf reply = STRBUF_INIT;
 
-	filter_promisor_remote(&accepted, info);
+	filter_promisor_remote(the_repository, &accepted, info);
 
 	if (!accepted.nr)
 		return NULL;
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 51cf2269e1..d2cc69a17e 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -160,6 +160,74 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownName' and different remote names" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
+		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.serverTwo.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownUrl' and different remote urls" '
+	ln -s lop serverTwo &&
+
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/serverTwo" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.48.1.359.ge980fe0aa2

