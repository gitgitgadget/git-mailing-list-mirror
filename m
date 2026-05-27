Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA4322C88
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890930; cv=none; b=JoCeeHxXsOMQgznjCVx7GNB0SoC1fAOGpNjT9QT7ik1LRfe37My22vwkFRw9WQRI5lVFyA+PKl8aTDt4Id+wV7wq+aEYIVTrnER9zNjbunTodoL8bbrukAauhZLloHt3MUUcMemoirfeIWX2eSe196X9OdFapBqBKuqgKCuluXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890930; c=relaxed/simple;
	bh=Uy1J1TmZXdAy7L2ZNSx81W3bIi7uWqy/z9HK+LAzw3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV3SA6dCOg4yN488SMjagQ6IEYcokbr6ONWzLjhMlL2VNV26u4404u3p65DS0SKnOV9on4AE4PTnwU5DwF+/L6Jo0E7HmFdaEe9ivummJ1iBQq6IpFT/9vKKpleuaEVsHzYY5MJTMQqtRTkc+ieysfWTO/h83LYXd5c/z+diOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmiwr0Rm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmiwr0Rm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd85ebb368fso1740186966b.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890927; x=1780495727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDRhBOKUQvG2bh9zWaNk+M3I0Lr+pJ9XPMQ7AZlC//Y=;
        b=Dmiwr0RmllUt3R97X2xgrSh4uX6saNkp3wKtani1r4TxiDWqUnj0PXAcDTXLChJIEL
         1JbBE2CX1z7ByosFeOUheMRVC8w0O67RLQBpjXR077o8mjrwiZ5STjBU1+W5/4Df7xWt
         vdrMxnUAJSsZdC5JMRyO7dhRD78Uk+IdqxRRbIWAfzTE12Ec0TUD8s/+hRsojFSsQz4I
         VMWdxIKBQLgwn44lLFzvrYyStX0Qn4gOrqEoEFENkGkgmduIyBtrykjHrEAjHM/uiyDQ
         rLAHSdaBdHa6DSjXGtP3x8qTvSa6VGqd7I6QXB/73oBmJG/sCFgEm7vEjlLdnySTd2kE
         Qwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890927; x=1780495727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDRhBOKUQvG2bh9zWaNk+M3I0Lr+pJ9XPMQ7AZlC//Y=;
        b=H3wE2q1NFFj7kO/7X4ZpSD9lWDW3lNcSUi9GHF76hOcDd4oU+GNZsfb/FxQdvHDtgo
         Wo7kBXWzS5yYV0CFVR32yW5C/x2w0kzeE6Z+nuSNBO1D05nU4LIi1avApzBkF6PJGvFT
         oTqKWSyKxzrLJUJBzN9h88GGJ0oaX1HJzlpDMUWcNvytMp5dAEUqwBtk8Gy5sHOF1aSJ
         c0biLptnMmz2wTJZzKHvh522wenaQx8/oeModHJ6ofQgFGozdguQPnC4MM2KconCkM2e
         T6K6tPUblrJjgkikcUCjxGbFBsfahvYjuYD5CHPXcYKUXpMLHRrmvk21cCoqmK+OUc6m
         ezzQ==
X-Gm-Message-State: AOJu0YyfkLKYBKauuOL8tm93PBXSJaRFfVuzdeTZ/1WTIOobCiGIIwRT
	+RmZfybHVTNTOJby4inRn5CF2olQRi8jlAaPD8ame9YN9Ps2wKUyFCBDSvAUow==
X-Gm-Gg: Acq92OEShtwMA0YdJC6mV24hkqbzja8yGC7JsbRcEr6TFughYqK9KzbBTGwKRtY9f5W
	l49k0ElZw+rj7N14NOaQRu7fr5EqDaOoKb1bXJsitybXsS5z7ftvANKB/txow7SSrnktFBR4lHB
	Uv8LrOU4EhRB7q7gEReOKHNx97mwwwp43b+pQHeEbI82KB6MhQM8Vqqi5YU/er1zu6o0FHhLeoT
	za8rpFZ+gnRt9iZpfBxI0sy7vkyVv3iHDCVE+hpjED82kZNP0galDs9dTU0aEv3tSHtYVbCtJ1M
	WMRkAtKA6NWy/n1MvsBIs4rzyAcePmxbRfXZL2vOn+cUXHluC890O8le4Gp0q6l/wNxZ9VjWeX0
	F/c8XjoKWqTPFvINQaRi+I38uZXjYb64Z/Ltcby3xxGTyGSOyvfHT/62AqwOuTPpK2lcJ4S/a77
	AWsLesolNwku4xgOl5aZpBxBcGO/qLl7CSxvRAt0ASky4iME9ufQaE+ngs7EsT54PCKgaQQ+Sdr
	MpZfWXE2wZjfHb+IoKkOEce5kA0yL9LNrTNUFI=
X-Received: by 2002:a17:906:4fce:b0:bd4:e62e:d399 with SMTP id a640c23a62f3a-bdd25ceb7d0mr1489891566b.26.1779890927191;
        Wed, 27 May 2026 07:08:47 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/8] promisor-remote: introduce promisor.acceptFromServerUrl
Date: Wed, 27 May 2026 16:08:17 +0200
Message-ID: <20260527140820.1438165-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
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
index 138a412893..8d4f6e0a72 100644
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
2.54.0.275.g96c817d129.dirty

