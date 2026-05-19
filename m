Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29307313E36
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205117; cv=none; b=dcql+J4tJhnEl09uAVkpX+yIremlHD0fY11eJVd+uaYUl6ImzQO41cSgFYeS/NgdEb3CwcyLA8B7xWG8Cs32ZA61KwJqXzmqpiiSPiA6LA1hIE+AIE/ifDKwu8LlO8fBDSSTO73DbSQYNRjwttoVK5yy3G97skoQIubV8+WVqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205117; c=relaxed/simple;
	bh=lQEaITPjuOxymv0tAxZBPKPxVjd8+fgud8qiGBbkyrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1UiRUabw1IpdmvxwCDDTicDM4R4kEurcofA7mYZqhRJYNKrUHYJF4mxNYAl1q8Cv3Cq9QBdMfXoS+j+Lcz9B3nkBONRQM7i71L7EoBphWXUXLx6Szmm1mfPsQUXUbDSigoS8QV5r77llxeophkdHSWKMIY3Lr8UTv0+dC60BaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu5Eg/D4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu5Eg/D4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so373798766b.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205115; x=1779809915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9zZULSSR4LZy+08b/a2VuhjMYvisirhWrp8VTWIDmE=;
        b=lu5Eg/D4OHIy7wSZ6nDup0v1UEkRZRKP/BFITwvHchZXtKMAqlxsbOe+Umnvb9s7Xu
         /HLSvEd+/hAoyAaQQJquHSCFQhXL/18d3/p7YLfK88HpCMQ+W6KNu89k6KagPHw6av5z
         x6HFz21Ep/nYFkYr6RA9SEEXYBqEsAakmLp2oraMpBTtD/qyeOsAlAsWBfyvLX+QZRTC
         Q0aXK6tbrNFJ60jxF2fHFkLL6qvpyYWOR5VGYd+TPhn85+BVDq8vx/krcnhxvYivMQcI
         iyVLZL5aGizsKt82rk0JA9eMcG0c1yzp17JDcsEe/fkHCXkxu+/1T+lPqjqsTe/IjwJN
         mDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205115; x=1779809915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9zZULSSR4LZy+08b/a2VuhjMYvisirhWrp8VTWIDmE=;
        b=Gj/VoPp9qC6R52meUgRcEfKCxS2f4rDLKZ+iYWL00AZG40SP47qgnVVg2z9kiZYDMh
         NVpPHKQ+TZ+3TlVZKVi8WdOAUWJ9Xc/+pfVa6FA+mRnWRb+GZ+NQxBmNzoCiiqCbr7Vw
         I91+vdHn56w/RcvEL3vl1uUUuHmCtTKmt5GoIdXailnNH79Ea+gtHTuFGCAyXm4wWxm9
         SXN7Y9KglFEEwz9MiWBajMpxcYL6holEfY2NMyuQv9i62Va3wDWB4Xq6snlpAYjKZAsG
         lkcfU6j5nIAEwnRjKDq75vBngudQF6FZgZm56NWkshS1k8PDUcBGZFmqr8icGPj0iZQM
         Fong==
X-Gm-Message-State: AOJu0Yw8kbFXouAyAbdWERJfy3BY3mhRicb66V46ETzKfcThxCeTROXK
	D5TrHOkPEjkVYBxnQSYSulpqOfKmGbNpF2or9vFDw9KG57A0syyfwj0xBAR1OQ==
X-Gm-Gg: Acq92OEvkcu7G0h3BAGjhY5m8lGStAgfLIY3s2I5zDGD515no7dXkVy3v9vY/iRbx4l
	F3mKqFhAM2gGbypdaOem0p5DQHoklDjWaIOz8bejz1JuYgDyjxe4+2fjl1j/4ghAz6c01YkMpFt
	6LyNvxO/8pSxF+RRo50msrUGFaNNDwxvduZgQ8EE1zbrNCPO2irlHP7OaeKs5zV3MDHW8PxeSGM
	zAR85Sl7qZ4vWyL3ocjrlaDbibN5PDTbX9KJiWfsPypfSQpVWG/dqz80gB34H8x5N11P4ntuPJ/
	AiumwabMGegdlcues2vNVMVonBCTVHUQZLpw1Rr9q/iSw2CT7oL2qctFq1sYumH07pOX1bHsPxF
	wrfUeFRXuBFhabXfPZwl3dpT/jKZ/4x211Y9Do3PFvTvSAbH3Jie7C4gS+om2Z4vq2vqtQhPoG9
	D0iaullnotqVJtc29nbf78TroJJb7P7vC5Kf0i3A97uDcGfmFXvHOD1KooVtFDFGohvwpBeyHO9
	vocdntQ4TRN7yO9oaIEX9EQi+hlagZ3rV+0WZPfOdE05BY+pg==
X-Received: by 2002:a17:907:c311:b0:bcb:98cf:1a82 with SMTP id a640c23a62f3a-bd5177c0402mr1235594766b.14.1779205114392;
        Tue, 19 May 2026 08:38:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/8] promisor-remote: introduce promisor.acceptFromServerUrl
Date: Tue, 19 May 2026 17:38:05 +0200
Message-ID: <20260519153808.494105-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" protocol capability allows servers to advertise
promisor remotes, but doesn't allow these remotes to be automatically
configured on the client.

Let's introduce a new `promisor.acceptFromServerUrl` config variable
which contains a glob pattern, so that advertised remotes with a URL
matching that pattern will be automatically configured.

The glob pattern can optionally be prefixed with a remote name which
will be used as the name of the new local remote.

For now though, let's only introduce the functions to read and validate
the glob patterns and the optional prefixes.

Checking if the URLs of the advertised remotes match the glob patterns
and taking the appropriate action is left for a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c                     | 90 +++++++++++++++++++++++++++
 t/t5710-promisor-remote-capability.sh | 21 +++++++
 2 files changed, 111 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 7699e259eb..3f3924f587 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "environment.h"
 #include "url.h"
+#include "urlmatch.h"
 #include "version.h"
 
 struct promisor_remote_config {
@@ -657,6 +658,90 @@ static bool has_control_char(const char *s)
 	return false;
 }
 
+struct allowed_url {
+	char *remote_name;
+	char *url_pattern;
+	struct url_info pattern_info;
+};
+
+static void allowed_url_free(void *util, const char *str UNUSED)
+{
+	struct allowed_url *allowed = util;
+
+	if (!allowed)
+		return;
+
+	/* Depending on prefix, free either remote_name or url_pattern */
+	free(allowed->remote_name ? allowed->remote_name : allowed->url_pattern);
+	free(allowed->pattern_info.url);
+	free(allowed);
+}
+
+static struct allowed_url *valid_accept_url(const char *url)
+{
+	char *dup, *p;
+	struct allowed_url *allowed;
+
+	if (!url)
+		return NULL;
+
+	dup = xstrdup(url);
+	p = strchr(dup, '=');
+	if (p) {
+		*p = '\0';
+		if (!valid_remote_name(dup)) {
+			warning(_("invalid remote name '%s' before '=' sign "
+				  "in '%s' from promisor.acceptFromServerUrl config"),
+				dup, url);
+			free(dup);
+			return NULL;
+		}
+		p++;
+	} else {
+		p = dup;
+	}
+
+	if (has_control_char(p)) {
+		warning(_("invalid url pattern '%s' "
+			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
+		free(dup);
+		return NULL;
+	}
+
+	allowed = xmalloc(sizeof(*allowed));
+	allowed->remote_name = (p == dup) ? NULL : dup;
+	allowed->url_pattern = p;
+	allowed->pattern_info.url = url_normalize_pattern(p, &allowed->pattern_info);
+	if (!allowed->pattern_info.url) {
+		warning(_("invalid url pattern '%s' "
+			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
+		free(dup);
+		free(allowed);
+		return NULL;
+	}
+
+	return allowed;
+}
+
+static void load_accept_from_server_url(struct repository *repo,
+					struct string_list *accept_urls)
+{
+	const struct string_list *config_urls;
+
+	if (!repo_config_get_string_multi(repo, "promisor.acceptfromserverurl", &config_urls)) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, config_urls) {
+			struct allowed_url *allowed = valid_accept_url(item->string);
+			if (allowed) {
+				struct string_list_item *new;
+				new = string_list_append(accept_urls, item->string);
+				new->util = allowed;
+			}
+		}
+	}
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -901,6 +986,10 @@ static void filter_promisor_remote(struct repository *repo,
 	struct string_list_item *item;
 	bool reload_config = false;
 	enum accept_promisor accept = accept_from_server(repo);
+	struct string_list accept_urls = STRING_LIST_INIT_DUP;
+
+	/* Load and validate the acceptFromServerUrl config */
+	load_accept_from_server_url(repo, &accept_urls);
 
 	if (accept == ACCEPT_NONE)
 		return;
@@ -934,6 +1023,7 @@ static void filter_promisor_remote(struct repository *repo,
 		}
 	}
 
+	string_list_clear_func(&accept_urls, allowed_url_free);
 	promisor_info_list_clear(&config_info);
 	string_list_clear(&remote_info, 0);
 	store_info_free(store_info);
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index bf1cc54605..3b39505380 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -387,6 +387,27 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# As "bad name" contains a space, which is not a valid remote name,
+	# the pattern should be rejected with a warning and no remote created.
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c "promisor.acceptFromServerUrl=bad name=https://example.com/*" \
+		--no-local --filter="blob:limit=5k" server client 2>err &&
+
+	# Check that a warning was emitted
+	test_grep "invalid remote name '\''bad name'\''" err &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.sendFields" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.54.0.134.gbbe8e27878.dirty

