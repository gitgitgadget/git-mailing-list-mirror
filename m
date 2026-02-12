Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C682E8B9F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890958; cv=none; b=W3AOFG2qLNMLOsyU827ojot7LyDe0DJDI88YxJDTJlZynTaj5Z4ujJz7UGJSk+J/tXu6I465K9pYJ9NdyPn8Pc2YsJkwH3p8W9liAk2TA0eKVxZF9wVzC8nn1Ml49H+Csv2XdqL71KlYmM8IfwnE8X3Zz2YfS+SnUDKxEu3ypE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890958; c=relaxed/simple;
	bh=4whjzx16Qg9LFSSaqV7pqzDrakCu81hPtX5kA6fEmqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQunB2pi4cineqYBXd6o63x5lu0gheKh3vAXSHddvhxqKC9IVcuVSejNEOS4CLOOdug7FtdNrhlD9/7Ce/3UO3fNgL6IwKMKhuW/7xNHXXcqXL4kus1bWFnmdMYVnRDLSBpwL6PZwX+ny2CqZzH2GPNYlp7+lhj/SqMaxArZAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm1Ug2YI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm1Ug2YI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43767807cf3so3332662f8f.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890952; x=1771495752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTQvpd14cXKcH74GupBQJ/4G1v6qNFHubz8uL2pyf/Q=;
        b=hm1Ug2YI+VCCEfr5PlLTciCZgH6ajkynxWARu+eyu5qWjXApFa/U+3qlldcXKr5x6a
         UtNxPdMWRCulAMqHZ9HV8JWf9ihtLubSllGRmiSV2/2Vs7/fk7+dAi3ySw3dVr229cUv
         tmUMUgY37cTRv9QAzodhSlpvTQ3HIQcehFemHZc08Hb3daa1IuqQL1b5zP5B+yl1J2S4
         RwZgGY2Xtamyh0TmoMmO006rr/OdNQZGtDMZuekJKVuqgCY0nh7qbJHwDdVexl9yYAXS
         jGDyYj7/zxP1AZHdn+DgjEwkbGZOzJW8QAkUPhD30m+oqu33M7+2o2neVdo0NEEP6gdA
         d6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890952; x=1771495752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTQvpd14cXKcH74GupBQJ/4G1v6qNFHubz8uL2pyf/Q=;
        b=YIlL7p9A09e0g43Eb2wCJOQQinK1wlSjIslZV01A5bWCRmwo8hn2EUcHttcDERkgcY
         ij8jiYmO4C75x5WhAeWz0sQsaSHJe0V2NyNK0OE6HXoG3PqWD20L3TTlxV4Rq+QT7ROO
         EWy/Gqw/4CjDla7QbFn2kfzvmRLA/Sb3B3iqpr3+lEMQrLx9NfG6XAP447BRBoBd4nM+
         jKJ6OtnbJmVw7tjIJYiCLZtWJWZca8H4ECK8xgv51Fk92xljf9eedTFecQ2k9pw67FBd
         gGxiPeCOODo+NNfNO94kkOOLl+q6q2gLC1J4w30gEF8ltgmKY/6ex6C8vZmDVVwo7oLE
         Wu2g==
X-Gm-Message-State: AOJu0YyGQVGG6MKO3eMN5FeHtQUSln01HXaWef/g6RRimSGrCMb32E2r
	tyeBx82LgdXCYUdv9V03FcifIZ1N6xa5Jhs9irIVLi6rfzL289GBH28E/4Z/vg==
X-Gm-Gg: AZuq6aK4YXmBzSfiqS/M8RSKAuefpg//WBoRzMmVSCo9lVcQB5qRhX5KwEROv1svMbW
	BZgwCGsbph1DIS3p6WsxqhjixVDPrGqlkhZOBnAqBmXJqVOBzMBlT6eunyu6y6WL7IVLMlKF0Dw
	kaSfp8Nu4Y7ZAe9Q+q8IQcXmifG31aLPjWBRQ2ZXpa4v0KsPE4vh5invyQk7R3YEV5SUaF5Wtbb
	YfTpEfItFWCn3vuAl8RmXHbVz1ceNGtNH5A0gpPfpLCr67SlTNcTO7hpe3mX0lbgnEfvNjV+ub4
	lPg9w/d11MxpZH81vy/q/XvfIrkUltiUvtbmAFrAi1pMpDACsi/omYhXvCLK3ITdYu021wJs2j3
	rdcGJxdv7tTGm6c0TQOPVT/dADhX3484kT3ppcucpDZRYFAQdh6sCqOIHP9091inXsVX5OkrR6W
	Kx/josXyMKKokGDxzGAoqR1to5ePkFs9fF1RCpFLvDAXeQGGOIEGcqzjVTKWPIWrP405PiGM4KJ
	290cp+ZxA5HkvgTFIqMwz26FXz66Uizqsiy7js=
X-Received: by 2002:a05:6000:144e:b0:436:42fb:154c with SMTP id ffacd0b85a97d-4378acd7047mr4162343f8f.61.1770890952193;
        Thu, 12 Feb 2026 02:09:12 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:11 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 7/9] promisor-remote: keep advertised filters in memory
Date: Thu, 12 Feb 2026 11:08:38 +0100
Message-ID: <20260212100843.883623-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
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
2.53.0.70.g3d1fd9d397.dirty

