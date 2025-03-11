Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82E33EA
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706678; cv=none; b=jOEJqBOG6vky+te+CIkuXoGm4leJPKd4ps/wOG25HDMZOnhRc4jrvFCv8HrCn2CWx/p8q5HIYkg6rt2v0lo4PUvXn+XUiNeuIIKypPay9MXqq0z6e/VE0/t4rOXrnb0AVhAM2QU9WtbXnsEciHp62DSN7Sq338YyN8xBbgx0kKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706678; c=relaxed/simple;
	bh=E+41W2P0EGXjYtjQqXV6vDy2vINRmiv3EVTmkY4dKNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFHzrC4KZvfzc2p72Jnndj3yqyzGiMltbCVhV7VXLgJIsURRDPPOHj+cDKJ/zViQYUgzrW3FGXJwZaKsDY5CBrA+6DvfG9SqF2/wlq7bE3yyvFiJZ0B5D39xWCqF0JgqBjty8eeSj+9kBj8Y2GHRlJA80ZcHSbnakjONEeN5MzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL9GeIxA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL9GeIxA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391211ea598so3152741f8f.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741706674; x=1742311474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TmLVfttTRdVEZmSNmZDNVZl6jro7po/knFoX0RsW9A=;
        b=RL9GeIxA5tvY45/wpOAxhnxwApVYTarWmEM85jqGLJw7oIoQB9jRpLz/Ponk8bzFLV
         6RWa/gqy528YMxaJGKhKCpY3J5ijmviLcIa+azQb3rIcFMgka0prc7aAM3FL8QF/dESG
         zPGXPy/ronkcjLPB1zoFaJjMkpFR/HVKi9OQ4G5j+AYB96Oyi5FPJAGJc+Fm1icLaHVj
         KO2JpEibMa9h9krR2aAj9gVOp2ckcPxMvulCa9puTF6U1wie926eQ0yk4RMNRvIE9MNq
         KMF+wvYG0OxvcrbJcYqcfzM0k6iexk00BSSXZRrZijwFhciLjeBy7Ctz/L3Q2Pu02qyN
         CPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706674; x=1742311474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TmLVfttTRdVEZmSNmZDNVZl6jro7po/knFoX0RsW9A=;
        b=rPRixp49lnhZM04+T+uvBjpIVaZT74nvzraZLqEUWwpWnioMvg2UHw0oGq00qsD3iv
         BvRSLqhvPo0s1F5a6KLnX55ej4xULGxnABAMwOMFenWnWoxJYR/1y3SeK70Sm0UKjzmN
         lSE+lbKenAaNnwGteNe0lwq9UTst9n4+w3gFEw9Zt3jxBQvox2pSI4tQI7d5GzP5Ltiw
         UrOXHyjhn70XLTMhGnebGClTme6EI0b98xNqF9tbEq1zgYbUom94no0kMCTUMV+OQgL6
         iRph+6MX59PKJXC/4l2dUESNmL7Gp88gU5Ng5pNSx+Qt5uDFKcl41EanwPsPlf38VWAr
         sD2g==
X-Gm-Message-State: AOJu0YyRSTFhRsDI3sSW3XRT86m30alQmUA5ybVoQ+fgX5zVBrXhAY7E
	Z4EVMaPBpzCeoK8SrQtvStHS8iWCrjnULNYOQevIWyqEqYt+P4i+4kQShQ==
X-Gm-Gg: ASbGncu1+Opwoi5S+y+PtWBZucMVA82QNeS0fj6zZPcqp+Sb90TbtpfF59xHsbtBhak
	l250zIzlyi/fz6pDAj8exhWdKh1wH3fWcO8pTiw46HOcaBHHZItCMAeijecLYqmV/X3sbhsrSf6
	iAEjpZ84JTOyGYinQsTZq5gZ5wrHZ4+Ml8JiDGmgZ1BkQkdNCcDo5sS0m9tV/7zd98eOun3t5Wj
	uJNuIRGFVgQtIf0qAJoCPv3HpBhxFgHmC6q9H5zIsVermJ07xOH6eTlOVBGeSNpCTXgGBICR6AS
	0JNs6irHGfHRD/J/MKRJgT6a6QRmKq3lONSVm23bBiw94T0XY/ZfZV/i6RChZFrqF+bHmRhjocN
	FZBG0rZNynZmsgDkUkWVxsx+8ArA=
X-Google-Smtp-Source: AGHT+IEIDNRyHbUlOj+KXu6LNRTEcVuqn8yttX2rLt15UCXwYWYqbno3IbGWt7SY4/tcGxchUD8NSQ==
X-Received: by 2002:adf:8c09:0:b0:391:3915:cfea with SMTP id ffacd0b85a97d-3913915d3c9mr8828401f8f.38.1741706673782;
        Tue, 11 Mar 2025 08:24:33 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf6c74f38sm77101025e9.20.2025.03.11.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:24:33 -0700 (PDT)
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
Subject: [PATCH v2] promisor-remote: fix segfault when remote URL is missing
Date: Tue, 11 Mar 2025 16:24:13 +0100
Message-ID: <20250311152413.1059343-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.1.gb8a6f6852f
In-Reply-To: <20250310074053.1886097-1-christian.couder@gmail.com>
References: <20250310074053.1886097-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strvec_push() to push `NULL` into a 'strvec' results in a
segfault, because `xstrdup(NULL)` crashes.

So when an URL is missing from the config, let's push an empty string
instead of `NULL` into the 'strvec' that stores URLs.

We could have modified strvec_push() to behave like
strvec_push_nodup() and accept `NULL`, but it's not clear that it's
the right thing to do for the strvec API. 'strvec' is a kind of NULL
terminated array that is designed to be compatible with 'argv'
variables used on the command line. So we might want to disallow
pushing any `NULL` in it instead.

It's also not clear if `xstrdup(NULL)` should crash or BUG or just
return NULL.

For all these reasons, let's just focus on fixing the issue in
"promisor-remote.c" and let's leave improving the strvec API and/or
xstrdup() for a future effort.

While at it let's warn and reject the remote, in the 'KnownUrl'
case, when no URL is advertised by the server or no URL is
configured on the client for a remote name advertised by the server
and configured on the client. This is on par with a warning already
emitted when URLs are different in the same case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c                     | 20 +++++++++++---
 t/t5710-promisor-remote-capability.sh | 39 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..92786d72b4 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -323,11 +323,15 @@ static void promisor_info_vecs(struct repository *repo,
 	promisor_remote_init(repo);
 
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		char *url;
+		char *url = NULL;
+		const char *url_pushed = "";
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
+		if (!git_config_get_string(url_key, &url) && url)
+			url_pushed = url;
+
 		strvec_push(names, r->name);
-		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
+		strvec_push(urls, url_pushed);
 
 		free(url);
 		free(url_key);
@@ -356,7 +360,7 @@ char *promisor_remote_info(struct repository *repo)
 			strbuf_addch(&sb, ';');
 		strbuf_addstr(&sb, "name=");
 		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		if (urls.v[i]) {
+		if (*urls.v[i]) {
 			strbuf_addstr(&sb, ",url=");
 			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
 		}
@@ -409,6 +413,16 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
+	if (!remote_url) {
+		warning(_("no URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
+	if (!*urls->v[i]) {
+		warning(_("no URL configured for remote '%s'"), remote_name);
+		return 0;
+	}
+
 	if (!strcmp(urls->v[i], remote_url))
 		return 1;
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e..23203814d6 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -193,6 +193,25 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownName' and missing URL in the config" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	# Lazy fetching by the client from the LOP will fail because of the
+	# missing URL in the client config, so the server will have to lazy
+	# fetch from the LOP.
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
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
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	git -C server config promisor.advertise true &&
 
@@ -228,6 +247,26 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownUrl' and url not advertised" '
+	git -C server config promisor.advertise true &&
+
+	git -C server config unset remote.lop.url &&
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+
+	# Clone from server to create a client
+	# It should fail because the client will reject the LOP
+	# as URLs are different, and the server cannot lazy fetch as
+	# the LOP URL is missing.
+	GIT_NO_LAZY_FETCH=0 test_must_fail git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.49.0.rc2.1.gb8a6f6852f

