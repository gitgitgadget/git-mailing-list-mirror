Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8F17BB6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780008; cv=none; b=Zjr+gQmlxy7uYi+hconrhIunj7/4DXwpoL3zssaa26BcZPIOiK4pNm9kFLb+pjDUU6dJl99fTStlWIfQjvoQDSSLc8mMV4naFyirdiMRvt9EHriNEqrn4DMWdZ62mY9yNaoh0rusxBCTX7A6ETh+Lcwy/nvmn45wdtOLOvS/5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780008; c=relaxed/simple;
	bh=nulL5ir+28BgtYPpCB+SBys8/djIT80lhgrWk8GLpsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTOd4JJ1VAo3/msY1rBZEdBmsq0FfyXYmInwYC8sHh9mjTcEQermk/43cxC3i5q3WcUaX0flN80dakYiL/ouf+1pDZvcrVd2ecBfNISg1E7ZZCQCNFN9urEPtDbhIl36+z2lxLnZ0i2JjoxuFTaqs1aMOIqakfovP8vleZ19iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYqAzM7k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYqAzM7k"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d129c1aso569634f8f.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780004; x=1742384804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq5Upiao6M5549cOM3OlslE2kes25hs8wMsP10MPQPo=;
        b=DYqAzM7kGaL5NW+yAMMdlmr0KoKacwGQuxNagvBmGw3HJUF4gt0TekET2NEmDE4Zfg
         KiQ3ZvPOTo4i1eOp5x65jfklkgHxbYv0MaWi2+JB2Np6sords1nF/4cVzuqf5a9bLVgz
         zrbxY8yJlGd3+cvgv1Jt1K/Yj3CY9mzk++gdrDzXPmVsHNz24dS+GYQ0O7WR3H7hoNne
         wXoPeEwYr1l+wll14Pwhgzg4vwRfn1vMsSqVDDby+uICzRMzBFTTjZLRSsKEQqNSlXL9
         q6AoL5mMtT55u58cQKYM8GNgJTreWyuUY0NcpXIFICqsBAAY5a/uxzT38/PPY5G8N3B6
         PSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780004; x=1742384804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq5Upiao6M5549cOM3OlslE2kes25hs8wMsP10MPQPo=;
        b=IzbnV3BqTC/RIFwKyYNS69WVw79RrRK+gncJ7ZEq7FafP61JvIpGCakQoYy+KOJgm3
         BoRBwk8NLdWPqaZgJGZ9pJ1WFt6K1nlLyyXzZN8DiIzwaFGlXGZB4Ch3N6FfGGHKUy2E
         M8hyoIhpFQYoo9DXur/Y45eSkpxXhCEchyZQwKg1z+uyZusezRWW1ojz553TBBdzlYux
         vUQ9u0i9jINk6l3LsualhbH+DB/RE+amuXBImDwFWF1ydf/N56PWlFL9xg7neP1xJa/a
         b5Yut85Mlhx6B/0Pw12UeNSNtZPMW5HbdE3vMPQOMpOTOckKoupT1kRiWv8C/ekLzNWX
         D+Ww==
X-Gm-Message-State: AOJu0YzNdQHgDMaWnCQ3rdCOXBWlb9F3MiyLJqlzZ1zXoWk/Jqm5yCzJ
	SSMzwWQaIgab0qK3pXR+4t9pjwLHqqi/xAiiYr2IhXNILYA5HpY3hbLPeA==
X-Gm-Gg: ASbGncuVJaBXu987hfQIDjineDxKDCt4eyaeIuWsk+2c7lp8EjRNuVBQdwJYfqLyKmk
	K49yJaa3mZEq3hhSEvEMg2BUbYruSPOk0o9o9d57y3oLE4MI+aDxZjlQpVmpeO3EH7fZGcH+RWn
	U5uB84418xiS8a8+uGmlOC4+Nu3GAMcldXaWoh4SysG7mlvwDuvidisapm9IgbHcyc0OfcJZOJK
	KtRCDF+nXairhFdZWRz9QkF8YJe6XdjFUC7rCPve0ejfLVJctzLXQns02MMcPhu2xaRa0w6W6TY
	zWyEHLDHRUmgmDtamzt/rwiCxwc4dfZ2yqOU62Db2V/bB1egxDqACTDuxe/+iItoUUXwrdDGeQX
	SWbNYeJ6iBMIAjURloQ/BB9LEvbk=
X-Google-Smtp-Source: AGHT+IEx2SX0goJgDgdoMplBElJfjAPyzfHZ4O+yvsGwOiMmjCw8k1XtLsi7HBe7MGndZV6cew1zSw==
X-Received: by 2002:a5d:6487:0:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-3926bdf5c18mr7215011f8f.1.1741780003846;
        Wed, 12 Mar 2025 04:46:43 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm21124582f8f.18.2025.03.12.04.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:46:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] promisor-remote: fix segfault when remote URL is missing
Date: Wed, 12 Mar 2025 12:46:28 +0100
Message-ID: <20250312114628.2744747-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.1.g28c2a23e4a
In-Reply-To: <20250311152413.1059343-1-christian.couder@gmail.com>
References: <20250311152413.1059343-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strvec_push() to push `NULL` into a 'strvec' results in a
segfault, because `xstrdup(NULL)` crashes.

So when an URL is missing from the config, let's push the remote name
instead of `NULL` into the 'strvec' that stores URLs. This is
similar to what other Git commands do. For example `git fetch` uses
the remote name to fetch if no url has been configured. Similarly
`git remote get-url` reports the remote name if no url has been
configured.

We leave improving the strvec API and/or xstrdup() for a future
separate effort.

Note that an empty URL can still be configured using something like
`git remote add foo ""`.

While at it, let's warn and reject the remote, in the 'KnownUrl' case,
when no URL or an empty URL is advertised by the server, or when an
empty URL is configured on the client for a remote name advertised by
the server and configured on the client. This is on par with a warning
already emitted when URLs are different in the same case.

Let's also warn if the remote is rejected because name and url are the
same, as it could mean the url has not been configured.

While at it, let's also use git_config_get_string_tmp() instead of
git_config_get_string() to simplify memory management.

Also let's spell "URL" with uppercase letters in all the warnings.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c                     | 46 ++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 59 +++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..479b9a27af 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -323,13 +323,19 @@ static void promisor_info_vecs(struct repository *repo,
 	promisor_remote_init(repo);
 
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		char *url;
+		const char *url;
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
 		strvec_push(names, r->name);
-		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
 
-		free(url);
+		/*
+		 * No URL defaults to the name of the remote, like
+		 * elsewhere in Git (e.g. `git fetch` or `git remote
+		 * get-url`). It's still possible that an empty URL is
+		 * configured.
+		 */
+		strvec_push(urls, git_config_get_string_tmp(url_key, &url) ? r->name : url);
+
 		free(url_key);
 	}
 }
@@ -356,7 +362,7 @@ char *promisor_remote_info(struct repository *repo)
 			strbuf_addch(&sb, ';');
 		strbuf_addstr(&sb, "name=");
 		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		if (urls.v[i]) {
+		if (*urls.v[i]) {
 			strbuf_addstr(&sb, ",url=");
 			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
 		}
@@ -409,12 +415,42 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
+	if (!remote_url) {
+		warning(_("no URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
+	if (!*remote_url) {
+		/*
+		 * This shouldn't happen with a Git server, but not
+		 * sure how other servers will be implemented in the
+		 * future.
+		 */
+		warning(_("empty URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
+	if (!*urls->v[i]) {
+		warning(_("empty URL configured for remote '%s'"), remote_name);
+		return 0;
+	}
+
 	if (!strcmp(urls->v[i], remote_url))
 		return 1;
 
-	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, urls->v[i], remote_url);
 
+	if (!strcmp(remote_name, urls->v[i]))
+		warning(_("remote name and URL are the same '%s', "
+			  "maybe the URL is not configured locally"),
+			remote_name);
+
+	if (!strcmp(remote_name, remote_url))
+		warning(_("remote name and URL are the same '%s', "
+			  "maybe the URL is not configured on the remote side"),
+			remote_name);
+
 	return 0;
 }
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e..05ae96d1f7 100755
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
 
@@ -228,6 +247,46 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownUrl' and url not configured on the server" '
+	git -C server config promisor.advertise true &&
+
+	git -C server config unset remote.lop.url &&
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+
+	# Clone from server to create a client
+	# It should fail because the client will reject the LOP as URLs are
+	# different, and the server cannot lazy fetch as the LOP URL is
+	# missing, so the remote name will be used instead which will fail.
+	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
+	git -C server config promisor.advertise true &&
+
+	git -C server config set remote.lop.url "" &&
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+
+	# Clone from server to create a client
+	# It should fail because the client will reject the LOP as an empty URL is
+	# not advertised, and the server cannot lazy fetch as the LOP URL is empty,
+	# so the remote name will be used instead which will fail.
+	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
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
2.49.0.rc2.1.g28c2a23e4a

