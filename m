Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B48221DB0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592483; cv=none; b=kc/57/KeNUCMUinU7hBoZDBbfl/QMSugWpESasKIW7pEiuzlz0F7nd1xImXak1A8O7CN2GMLlKYovzhmqIiWOJMeZKTz4ZJcM1eedEo7C0WAB4RKMYmvh5aPmcViIiALFTA4SwWWX4vGN0FS+6ciKwvrENq5m7dCXKMjSzDiDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592483; c=relaxed/simple;
	bh=iQCtzi3qXnxE3Jkt7AdNSjq9ab2bADqbV/EjehOGS+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJW4qDK+zooTL0UOfyslCsAwFnLVmdKeLnoy/UmgfwmngmhN8LX82d8Z9X6TDiacsbK5MNVVFX4iDBQyu4+vAz4Z47Y5VoAFSv3MLeKBPwtmIM6SznDzNguTFQgmWQAlQzVfuWFWTDsGcLB62eGl3JjiizJvqE4fsYCLKWwrmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5AYmRpT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5AYmRpT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso22488935e9.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741592480; x=1742197280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhsz/eCQuoPFaASZu+3hgUOjXQ9/eH4sXjTtjI0OTNM=;
        b=U5AYmRpTm2c4AkVp4Z9qKlUfs48IJlWXBnRQsI/c40f5EpNlipkD11Vsq7BImOJb5D
         sFkDrsFklPIwyW4mtreOC6JpFbcoyfgiEcI/+LhF6zL2RUI7j1LKt36osfp0YuJKX1Kk
         CEyaV0qmIsxR7NrqUlROETxL/r4GMCHqQQQIwOS8AzeWvl0ADGzn+SPSpyOkajCYXs5a
         Z1PMm7iswLhe/2ATbvWu7Sdfh0EYlrkrsWD0zH2uhku7oJfgRVWIyaEaTqBAhaIVeR9z
         0YNWjUTcmO5EN9nG6UQEUrbK9NZfc6jEIdoW44M6E3VVVFpOtH2hx/NDBallTmzhq19F
         eiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592480; x=1742197280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhsz/eCQuoPFaASZu+3hgUOjXQ9/eH4sXjTtjI0OTNM=;
        b=kOXwYICtBa+kiiCs77Jz3ojzSkaCffBIuCiHanpho6TGJ2RuUv0jxqHH74tCKLsqW9
         Lp/LZgVuLE+XYYbnNvLeB3X8m3i5l5JAcnnGagbPIjyv91JenijQQ5HJi3xYsIoBORrX
         Kml+pd25ySlsjoLneWc2L2QwmFYTzBvjlkyRqqouedtIakthcgbJ+yH9DMn43e35DSw5
         fVw8n6gWBJutuNnHLIcfWVyQvQpLP8EnP/ofby6cT7I2kBj2hAdAH1aKRkpBFHBQMWdG
         biXJRin2reDKnmOgI1jeLYCxqnJoU5AxmGBSubl235/V/dWhkALKv87j+Km19Ta9HVPY
         n/3Q==
X-Gm-Message-State: AOJu0YyhpjkZg22br8Ee7ReLDR7nfuG5p2LwJK2kL50+9rDPzzuVW8kA
	gkwU+345PJWMDcJvfKqyuoXRqIhSrA8gY09g0BSWeINfE5SNACfIGyMuTQ==
X-Gm-Gg: ASbGnct7fiDm89OadYdSIQvQ9GO9PDP2caut+TauH8rlW+qbUTXUOP1+uqFc1hDOVMc
	OJ/PQg96yPFQ+WSKZ5aE1hm6S6DTdaZR9bgp8akm/TXalF/aiS9SYqIBlJ897OfW1Y9LHkXlcMT
	8GjkXAciOr+6iYfD3z/OvRXTgh1/1J0Etaq1DxCrNZ6rxALjx1ZODRFEPy8azthYjIaiC+l0VIs
	zPcIIrxXgi49AKXmv+gC7Al8MxDHOVrjAHcRe5/gooWOg5gUuUXMpK7qYSZArpUhIq8eG9cE/My
	dc1pkXY/ItnutiKgVNEux8eVqjmAGzeBymkk/aGSazqt85Xw+p9AKSGrO6ynjrFdA2ESKtnQqSg
	momW8eYwjUMPLnKmt1uEnCe0PjR0=
X-Google-Smtp-Source: AGHT+IFsLD0zJqNspDagXIhrvLmJXAwqeyn2jRHV5LhP4+eQuA5C5q/dnzJi0wesIOq228wivtlckg==
X-Received: by 2002:a5d:47c1:0:b0:390:fe8b:f442 with SMTP id ffacd0b85a97d-39132dc35b2mr7365737f8f.54.1741592479491;
        Mon, 10 Mar 2025 00:41:19 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceed32e64sm54417915e9.5.2025.03.10.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:41:18 -0700 (PDT)
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
Subject: [PATCH] promisor-remote: fix segfault when remote URL is missing
Date: Mon, 10 Mar 2025 08:40:53 +0100
Message-ID: <20250310074053.1886097-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.84.gc0d5bab425.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pushing NULL into a 'strvec' results in a segfault, as 'strvec' is a
kind of NULL terminated array that is designed to be compatible with
'argv' variables used on the command line.

So when an URL is missing from the config, let's push an empty string
instead of NULL into the 'strvec' that stores URLs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This is a fix for cc/lop-remote. Sorry for sending it late in the cycle.

 promisor-remote.c                     | 10 +++++++---
 t/t5710-promisor-remote-capability.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..56567c6e45 100644
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
+		if (urls.v[i] && *urls.v[i]) {
 			strbuf_addstr(&sb, ",url=");
 			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
 		}
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e..d9c5676e4d 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -193,6 +193,22 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownName' and missing URL in the config" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
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
 
-- 
2.49.0.rc1.84.gc0d5bab425.dirty

