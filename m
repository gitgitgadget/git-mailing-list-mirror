Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159030ACFF
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248228; cv=none; b=VrJlVDe8RoSIBh+8jMgd2Y1XZyNWpajTy8ADtrAeMenBQBXrcnh2mgITQORuIsoekVoJdd16pzpIKQgQ8q2c7NhlVMy3mSHO4QdVc+blgmisZLreQubAa57Q6WtTHGlO+ps/s/vPxN1iHJmU2VqO6yY3cAFXfWue4aoIxUJtnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248228; c=relaxed/simple;
	bh=Z3MkJAdumRKKYJFFirUFTNB/IAr8SHwzWquiaw2na5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHrmCKnRmrJOGrTcCk+wnihLhqTUyGeR3HbP4IoF/GhTIepfGsiP2XZhPd6kgNhA3qfmXM4FZHvdjX6VXMQq6zFbqn7wnIyPGNeCBHT3Leh+U2c43+ME9XvYFS/cCQnQ1VX1OaLFktV2L2B2+3LfQhr/filp/AE/Wq/x57MwH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNktewv1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNktewv1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso24053335e9.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248225; x=1771853025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwiAAZ96zJV9cPe8Z8jwyWbKxCgFYjoIg2Dm2OSSAKg=;
        b=nNktewv15FQTsqWlrAiiSvfr6jmkvmub4cMV3oeFMfxy84twW8b3K3VZFsTSMhH+1p
         I6DCJsG/kdow1R7wwr4welbMOqhA4SmYtnb8Laon55sRcfNt5VUrucIkI22tW21IZ8F3
         0ebFktenYyWpZ5WFP8N1TAE5hTVkcvNw/5M1YjjHSo/hcDweyrPcHV/CRC3WWHwwlIX7
         g6bB9QQtpbw4iBD/i+tC90RpYRB0GIc8wpyGmVTDmdhWDIOdh6eR9DWxQQogJGRVZ21o
         mkPxrNZ1UHycjNqqyBHmyyif//mBHc3+MbuFzYEwII6e9wFewZOsDROq8vsiAO8m4uOL
         J1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248225; x=1771853025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwiAAZ96zJV9cPe8Z8jwyWbKxCgFYjoIg2Dm2OSSAKg=;
        b=XAMdxb1A8vEgtEuZht2MZsSI56Xa1tWPXaeJDWwOxbcZjKQOyDJAu3h3JRkDIjt+DG
         4a5b10sxmZED36/keEaIybQGY5nX61aG5EWsazKqAA1NxGKNgXmtViB05HywyjtTdIyg
         HJ48raZkUvc6ILM9MD6NifUwmPu1hbeiNeIy8O9RtoMm18IqM+DZLXjE+Zcs+CAGOJb7
         qS6BmKKc1md6ich9XupTu5HQpGF0aPVYOtXTXRl5vSWEe91rjt/5qAdwS+ezDbBX7nKi
         JPrlfsdWR+mFicUqyHiXaD49MUGn+ke1jXlk35IMQlIYqBa5XAoVlcsrreQqj+u0J7tG
         xZxQ==
X-Gm-Message-State: AOJu0YxTEd8O3h/TgNwsNCAhVSfAQZR91eB8LMGOnx6/Y6KcpIB2PCX0
	v8V6hIp3GJRxuiXtvG+rLl7R3GFKLXBT0EyGbFytu+pHPtF4/WfO8RRoUkQJzw==
X-Gm-Gg: AZuq6aJ1s6jBIsN1l5xubxwIoU6ritgA0TUsgEEWABLCo/0ifIngxMmUpGCkcb5pSvC
	POcHuEn3dUo8Rd5ddI+pWuZj9r4g0AqUx10hu7U0euR25FA3N3Umgu/ZIrxC9nHqCRt49mnjB7A
	KtmUDIWz6iqLlpuuLaKI3OPdHqyQCCcomMb1v4E90bsjJ+CyPYKXYYmPN0cRT5U+d9xb6DNQt63
	PPxCfiunrAoGcxWzjScmSYEJoU6Jsn4X2gpIC9z6KKhTPL5eHzNE25ZTyajE67VJSVpwy7JSwk9
	m1xceGLSS1+HOfRYcL61Ikr47JehWT9rEUFS3/SFGH3zXERoUAIifq4lQ6OXft+GIw91jGNUvOV
	b4qnm++RCbR/tbKFqpVktI6R/gjTh6Vo3oChBzteaw1Jp5UV+T7R2KwjFP0MGjRLSToyG966ILt
	HaX5K6yiofPAFgrmG3OobcywDJhpNQ+bu03HA6vbtv0xCjeDD6pTmnHGuXUHxjJJnOgPuhiAOAk
	F0h5gGIL1A5BtJsrJnk4WjTc9jmb3/WOK2gu/SUMhsHGdW29A==
X-Received: by 2002:a05:600c:3b08:b0:483:8e43:6def with SMTP id 5b1f17b1804b1-4838e436f0fmr9343505e9.28.1771248225404;
        Mon, 16 Feb 2026 05:23:45 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:44 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 7/9] promisor-remote: keep advertised filters in memory
Date: Mon, 16 Feb 2026 14:23:13 +0100
Message-ID: <20260216132317.15894-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, advertised filters are only kept in memory temporarily
during parsing, or persisted to disk if `promisor.storeFields`
contains 'partialCloneFilter'.

In a following commit though, we will add a `--filter=auto` option.
This option will enable the client to use the filters that the server
is suggesting for the promisor remotes the client accepts.

To use them even if `promisor.storeFields` is not configured, these
filters should be stored somewhere for the current session.

Let's add an `advertised_filter` field to `struct promisor_remote`
for that purpose.

To ensure that the filters are available in all cases,
filter_promisor_remote() captures them into a temporary list and
applies them to the `promisor_remote` structs after the potential
configuration reload.

Then the accepted remotes are marked as `accepted` in the repository
state. This ensures that subsequent calls to look up accepted remotes
(like in the filter construction below) actually find them.

In a following commit, we will add a `--filter=auto` option that will
enable a client to use the filters suggested by the server for the
promisor remotes the client accepted.

To enable the client to construct a filter spec based on these filters,
let's also add a `promisor_remote_construct_filter(repo)` function.

This function:

- iterates over all accepted promisor remotes in the repository,
- collects the filters advertised for them (using `advertised_filter`
  added in this commit, and
- generates a single filter spec for them.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 59997dd4c7..f3bafb7731 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -193,6 +193,7 @@ void promisor_remote_clear(struct promisor_remote_config *config)
 	while (config->promisors) {
 		struct promisor_remote *r = config->promisors;
 		free(r->partial_clone_filter);
+		free(r->advertised_filter);
 		config->promisors = config->promisors->next;
 		free(r);
 	}
@@ -837,6 +838,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
+	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 
 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -879,6 +881,13 @@ static void filter_promisor_remote(struct repository *repo,
 				reload_config = true;
 
 			strvec_push(accepted, advertised->name);
+
+			/* Capture advertised filters for accepted remotes */
+			if (advertised->filter) {
+				struct string_list_item *i;
+				i = string_list_append(&accepted_filters, advertised->name);
+				i->util = xstrdup(advertised->filter);
+			}
 		}
 
 		promisor_info_free(advertised);
@@ -890,6 +899,25 @@ static void filter_promisor_remote(struct repository *repo,
 
 	if (reload_config)
 		repo_promisor_remote_reinit(repo);
+
+	/* Apply accepted remote filters to the stable repo state */
+	for_each_string_list_item(item, &accepted_filters) {
+		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
+		if (r) {
+			free(r->advertised_filter);
+			r->advertised_filter = item->util;
+			item->util = NULL;
+		}
+	}
+
+	string_list_clear(&accepted_filters, 1);
+
+	/* Mark the remotes as accepted in the repository state */
+	for (size_t i = 0; i < accepted->nr; i++) {
+		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
+		if (r)
+			r->accepted = 1;
+	}
 }
 
 char *promisor_remote_reply(const char *info)
@@ -935,3 +963,33 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
 
 	string_list_clear(&accepted_remotes, 0);
 }
+
+char *promisor_remote_construct_filter(struct repository *repo)
+{
+	struct promisor_remote *r;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
+	struct strbuf err = STRBUF_INIT;
+	char *result = NULL;
+
+	promisor_remote_init(repo);
+
+	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
+		if (r->accepted && r->advertised_filter)
+			if (gently_parse_list_objects_filter(&filter_options,
+							     r->advertised_filter,
+							     &err)) {
+				warning(_("promisor remote '%s' advertised invalid filter '%s': %s"),
+					r->name, r->advertised_filter, err.buf);
+				strbuf_reset(&err);
+				continue;
+			}
+	}
+
+	if (filter_options.choice)
+		result = xstrdup(expand_list_objects_filter_spec(&filter_options));
+
+	list_objects_filter_release(&filter_options);
+	strbuf_release(&err);
+
+	return result;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 263d331a55..d227299fd0 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -15,6 +15,7 @@ struct object_id;
 struct promisor_remote {
 	struct promisor_remote *next;
 	char *partial_clone_filter;
+	char *advertised_filter;
 	unsigned int accepted : 1;
 	const char name[FLEX_ARRAY];
 };
@@ -67,4 +68,10 @@ void mark_promisor_remotes_as_accepted(struct repository *repo, const char *remo
  */
 int repo_has_accepted_promisor_remote(struct repository *r);
 
+/*
+ * Use the filters from the accepted remotes to create a combined
+ * filter (useful in `--filter=auto` mode).
+ */
+char *promisor_remote_construct_filter(struct repository *repo);
+
 #endif /* PROMISOR_REMOTE_H */
-- 
2.53.0.77.g4627d513d6

