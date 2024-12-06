Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0B207675
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488997; cv=none; b=uk5UQ+TvdnMtNXtkVk+dPbPj9jAQuUR3IWomLVRvl1/aqQ07srnyGFXoNitHjq2u1FQQ11STWoYtCQHfKOzimEIfogZR+Nu1ePKARDoHHIHeVg6lYbDJS1s9J38Qg1axiL0zCAf7CTgshVUPL8q16BiVDAJzX7xVynTK0+VL53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488997; c=relaxed/simple;
	bh=Pw2miDFzsRu+dAJ/e8KYKWRRA55H+/Fq7pZfw4D6m1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMF2DDcQ0zoqm36vhRl7/EuLLuvfCR4q+nATteyl4L/pHZ5hhVWwe9bA3B/r2FjG/L0hiuyaSy5o15ln1i1kG119y9pHQMWx1exjpT3moGiYe1ZMCx1MuAFd7CFaAzs3IsQY5eQK7oPSpLvAagV9mKIb6xRMuxW7eJhCLEJmrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeUAYwSo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeUAYwSo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso377191a12.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 04:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488993; x=1734093793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWfFOoMeiINHdqOPgLH7F2YzWjOHQKzRfyIVzr4PNQ=;
        b=GeUAYwSoeEJk+2Lx8e7OeFYED/b/kghmWRi2iq/SJpUykOT0OM9caySUR02VaYwO+1
         eStha4RplhnbJqD31rpDpsKZxseMa7YIKiRPe/aSUNhPpa1/f8yOWy/51ckVECCF9a03
         0nMsSu8R4ph0eUauyOEkmwoltcH+aqFXwt60BE6p2jw9tBd8rkI+f2fiyG5+vbGq22Hd
         lCWkbXVjAfExNdTLSi/P0z+colZF2a3NjfrJb00vfJYyArorBi9w7ssp+ZM2LX+B5bzO
         DkxEUCLgqx5IUn7iZhKYu3iWbc1cUER05i8GbIWxmqUNO3A4fXeEny05XoJvBI8IbQwA
         A9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488993; x=1734093793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hWfFOoMeiINHdqOPgLH7F2YzWjOHQKzRfyIVzr4PNQ=;
        b=S7JrrWFT6o8ni/UULmE8fKbljqpQRfYWYNaAWYArqRRef3oWa36nLZf0Z4Yqb/aHoh
         k61RKhhdcJku/SKA3iFA1U2M6ax03e0nvnL3R4A8uZw12KmOTbgqYAaqji0PS0qF0q4O
         2xWGG5mRmYVk8AGeL5bNeVt6wpri1CDF6MbH/LVjtSxoigomaW//oTnCEBgbhIpO/bsP
         ywz2MKVC5OpNa1x8aWA+CwqKtoSimXZEZuCK5aG0xfpp4EgPlmD5PSePn6Q8/ooDtUiZ
         k5xmWjyjF9c8Lw0xRHMZ+4BumjBE8NhZ47yme+qLz1sardOgCwzoLY7iZ+2u2/tDJFyM
         L7FQ==
X-Gm-Message-State: AOJu0YzN2lM6fyMLC7Gca3Lo6RhluvsxP0kVj8sbWgtzogLp6IpXDIQ5
	f4qntDMwsCklB5n6y0wOLSoEtQ+T6XbZZzwrRH1Hivo+F+t65FSbwKGLlg==
X-Gm-Gg: ASbGnctHzpKI7ZItBSG5cCEociF5uL/oEGouB4oKfgpRNc7bV6YnCmJSv9g01yf3S2H
	0hD+uSuzwpMtbKjfhv2rlBJwbDzegfbV7iZMeEiJ1TWVZ3ccjbyjUjQAbyruLyfU3N/b6Fvve3s
	WJYRs5+cgS7YzKrKn/pS+zpcwxAvsrU4zPn4vDt6nFvgy5z6ikfiXpgGKn2V46x/+CXUZfdjLa0
	PXSFkppui3BI5QhgDq3xwxKQ60zBChHyf4uR902jo65CnslaqfbxibQnwGiX959xf2tkd0Bi094
	+AR1DrCAYm3jhUdSN/oRqo2hTzFdrpmS
X-Google-Smtp-Source: AGHT+IGN1mp8JpbM19sQWzUbSXR9vLhyGssv+qW7MM/t055XynbiZAxMpmHuowEYUKV8Azc3dcczbw==
X-Received: by 2002:a17:906:23ea:b0:aa5:63a1:17cf with SMTP id a640c23a62f3a-aa639fecd9amr240695366b.20.1733488992775;
        Fri, 06 Dec 2024 04:43:12 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da51sm236527266b.37.2024.12.06.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:43:12 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/5] promisor-remote: check advertised name or URL
Date: Fri,  6 Dec 2024 13:42:47 +0100
Message-ID: <20241206124248.160494-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.47.1.402.gc25c94707f
In-Reply-To: <20241206124248.160494-1-christian.couder@gmail.com>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com>
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
 promisor-remote.c                     | 60 ++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 68 +++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 12 deletions(-)

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
index ea418c4094..b72d539c19 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -369,30 +369,73 @@ char *promisor_remote_info(struct repository *repo)
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
 		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
+		else if (!strcasecmp("KnownUrl", accept_str))
+			accept = ACCEPT_KNOWN_URL;
+		else if (!strcasecmp("KnownName", accept_str))
+			accept = ACCEPT_KNOWN_NAME;
 		else if (!strcasecmp("All", accept_str))
 			accept = ACCEPT_ALL;
 		else
@@ -403,6 +446,9 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 	if (accept == ACCEPT_NONE)
 		return;
 
+	if (accept != ACCEPT_ALL)
+		promisor_info_vecs(repo, &names, &urls);
+
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -432,7 +478,7 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -440,6 +486,8 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		free(decoded_url);
 	}
 
+	strvec_clear(&names);
+	strvec_clear(&urls);
 	strbuf_list_free(remotes);
 }
 
@@ -448,7 +496,7 @@ char *promisor_remote_reply(const char *info)
 	struct strvec accepted = STRVEC_INIT;
 	struct strbuf reply = STRBUF_INIT;
 
-	filter_promisor_remote(&accepted, info);
+	filter_promisor_remote(the_repository, &accepted, info);
 
 	if (!accepted.nr)
 		return NULL;
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 000cb4c0f6..483cc8e16d 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -157,6 +157,74 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
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
+test_expect_success "clone with 'KnownName' and different remote names" '
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
+	initialize_server 1 "$oid"
+'
+
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
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
+test_expect_success "clone with 'KnownUrl' and different remote urls" '
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
2.47.1.402.gc25c94707f

