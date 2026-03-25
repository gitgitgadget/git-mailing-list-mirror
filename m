Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD633ADAC
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465757; cv=none; b=lb+f/Z3NRJJfip2nTur0JxCKOe4HrvaY/gkfS12S7QnSn0NPycQ1UYJSSOG6kq3Z94JtZ6+eUloiDULQAfdNCs9kjYvmiVqMiR55Ltdiwg3HJgt9vNgK9VAb2WAiwc5PUQK4wYh48C5cOBK69DageSWWlSidgMXLGeoS9OgyDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465757; c=relaxed/simple;
	bh=HT35K06W0VBVtRuku9ecVLResgLwHcUIMdETeaGqyX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMeQpJuEt5AMOEiWezolP5RT3aWyDWH7VSfbHuVERiIh8ol3KN2/Ey1ib7mI0jzVEF2dX6GUT75Gju9WMl8wohARsX6UqEMmdxn/G7rUT9wX6AE/WG/H4v+gYKOyjVkyV7M6s1N5cbHUvYHT3SWRFZii4QKcOcUNTcyJk5FcM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1smzygw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1smzygw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b07069e2efso964355ad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774465755; x=1775070555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2s2b9AF5nU0WcIQOBy+CjmMOhlteAc6CHqAHJ2taq8=;
        b=S1smzygw1n2/7/mKHRLcgb7vw+w6WlOWGmxGyy+siprYXAZ6YpCpmK6n4QHMPRNR++
         scfmoAcAhkq4JH4XW6voAwN1O4eevoZ50rX++jgX67zm6DTzgoqQg6J6RBupWa0NrNqM
         mtlSm//woKz6whw/4XbyjPCDbwaPQ1RTFWXJvevL9Z6sjfU17YJpZ+iQ0fTRPHvU69/H
         pu6sDwJ8DoFcCKS2Ah/5meIg9Wr+WIXR7OI5QsHg2OJqc/KUbEyZGTwF4+INWo45hGbg
         j8myKz3iBTNDE9eaodTXFdJGrAIegcOrycYKhNELmmc1Qj3AJ4TjYw2biZLDnxP+8BP7
         Bvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465755; x=1775070555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2s2b9AF5nU0WcIQOBy+CjmMOhlteAc6CHqAHJ2taq8=;
        b=ZPW+jOggCyQqQn0sBlETIxPrvPBulm//ZrMrfZNdGoqWGMdMqeUuGfGoiRMSqNdzoK
         TF+K5vQt9VWyqQOj3yfFZTtQRtLYvI/vQNI4lvo1OwSYm/obvdE82/rt2PdA4TuYzdyU
         SEhfpPi0U6KvJoFqKKN4jmzUw+wFuzy2vdX2Mjd8lI3NzNsmJzt8Ux7MLOMh8ylKp6Ok
         j3S8Tx+ND40fLFWLtCqf3Tp4RVfZXqGp1gHlbqbI4qWAk4bq4srBEZPImxHpf757rKJS
         zhkrj1hBXFbumVvAR5km+3krRNzIF9PEeXhXVQJ8L6NqeVsloCKVm/kvzDo/p8ZuCN1A
         qk8g==
X-Forwarded-Encrypted: i=1; AJvYcCXCJHXeE4SUEJyV6HlpNoNMfaU31cY2mDNYiR9Pr9wBP7C2FAj+MvIlAl87DISe9UMCUys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSPZK0aqKJjVUyGjchjoQUjpXdQlLV3WeAvhRP6GnlgqK63fb
	CW9TDJv5+52ZJ1ccPPmaK/5Yz6b0FPu0a2fsjGhRsZgtrGJ6L0ntmPzu
X-Gm-Gg: ATEYQzxbLvVRAXSj56jqfSpMvf8jfxRJZM/r5MyckK4NoCTjIy2jM74KLQdtZSLe15k
	P+YqTNRZo4Ng24QnJZpS07NRzUP6qRdReBArPeXhWoC6ZhVuZDR6ccK0Yui3vtXz5LmyRWiwVTZ
	cK5vVd+78q4ywoxAIUDzJLpisS8MMiLkkA/7WeYuQtptOlS/rB4hFAdea+BgaB9ZtGbApo4lH2j
	aJGAFZ/COpHoPkTayU8ByezyLLCLR7xD2qL93s2t9rSYDAyO0FkKlHUeEZ2hThQSU3l6NcS5jDE
	F/40DgabKC4gI03pQ7gGWOI4IcDqZcoIl4TmtuaxldOflf6e4pAZkGaYxJP/D1vjNLbV5b4ojhs
	wKNYB2tVXc3LvIBNlZtFp9jsNk/5eyot0j4ERrJsTTZ2fLlOV6Z/CTJmzHCGmcCvMPsIzDIcNzq
	vpAqw+OFrvBAerzE+cdagPYDjqBaky8wUn7JHsMbGaL5/Jh6mMirWiMDTKy9qUTA==
X-Received: by 2002:a17:902:cecc:b0:2b0:7a50:8878 with SMTP id d9443c01a7336-2b0b0b158b6mr54232275ad.48.1774465755287;
        Wed, 25 Mar 2026 12:09:15 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc773472sm6466235ad.7.2026.03.25.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:09:14 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v3 1/2] remote: move remote group resolution to remote.c
Date: Thu, 26 Mar 2026 00:39:05 +0530
Message-ID: <20260325190906.1153080-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
 <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`get_remote_group`, `add_remote_or_group`, and the `remote_group_data`
struct are currently defined as static helpers inside builtin/fetch.c.
They implement generic remote group resolution that is not specific to
fetch — they parse `remotes.<name>` config entries and resolve a name
to either a list of group members or a single configured remote.

Move them to remote.c and declare them in remote.h so that other
builtins can use the same logic without duplication.

Useful for the next patch.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/fetch.c | 42 ------------------------------------------
 remote.c        | 37 +++++++++++++++++++++++++++++++++++++
 remote.h        | 12 ++++++++++++
 3 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 573c295241..6e56c484bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2135,48 +2135,6 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 	return 0;
 }
 
-struct remote_group_data {
-	const char *name;
-	struct string_list *list;
-};
-
-static int get_remote_group(const char *key, const char *value,
-			    const struct config_context *ctx UNUSED,
-			    void *priv)
-{
-	struct remote_group_data *g = priv;
-
-	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
-		/* split list by white space */
-		while (*value) {
-			size_t wordlen = strcspn(value, " \t\n");
-
-			if (wordlen >= 1)
-				string_list_append_nodup(g->list,
-						   xstrndup(value, wordlen));
-			value += wordlen + (value[wordlen] != '\0');
-		}
-	}
-
-	return 0;
-}
-
-static int add_remote_or_group(const char *name, struct string_list *list)
-{
-	int prev_nr = list->nr;
-	struct remote_group_data g;
-	g.name = name; g.list = list;
-
-	repo_config(the_repository, get_remote_group, &g);
-	if (list->nr == prev_nr) {
-		struct remote *remote = remote_get(name);
-		if (!remote_is_configured(remote, 0))
-			return 0;
-		string_list_append(list, remote->name);
-	}
-	return 1;
-}
-
 static void add_options_to_argv(struct strvec *argv,
 				const struct fetch_config *config)
 {
diff --git a/remote.c b/remote.c
index f6980dc656..75fdb4019d 100644
--- a/remote.c
+++ b/remote.c
@@ -2108,6 +2108,43 @@ int get_fetch_map(const struct ref *remote_refs,
 	return 0;
 }
 
+int get_remote_group(const char *key, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *priv)
+{
+	struct remote_group_data *g = priv;
+
+	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
+		/* split list by white space */
+		while (*value) {
+			size_t wordlen = strcspn(value, " \t\n");
+
+			if (wordlen >= 1)
+				string_list_append_nodup(g->list,
+						   xstrndup(value, wordlen));
+			value += wordlen + (value[wordlen] != '\0');
+		}
+	}
+
+	return 0;
+}
+
+int add_remote_or_group(const char *name, struct string_list *list)
+{
+	int prev_nr = list->nr;
+	struct remote_group_data g;
+	g.name = name; g.list = list;
+
+	repo_config(the_repository, get_remote_group, &g);
+	if (list->nr == prev_nr) {
+		struct remote *remote = remote_get(name);
+		if (!remote_is_configured(remote, 0))
+			return 0;
+		string_list_append(list, remote->name);
+	}
+	return 1;
+}
+
 int resolve_remote_symref(struct ref *ref, struct ref *list)
 {
 	if (!ref->symref)
diff --git a/remote.h b/remote.h
index fc052945ee..8ff2bd88fa 100644
--- a/remote.h
+++ b/remote.h
@@ -347,6 +347,18 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* list of the remote in a group as configured */
+struct remote_group_data {
+	const char *name;
+	struct string_list *list;
+};
+
+int get_remote_group(const char *key, const char *value,
+                    const struct config_context *ctx,
+                    void *priv);
+
+int add_remote_or_group(const char *name, struct string_list *list);
+
 /**
  * Return the fully-qualified refname of the tracking branch for `branch`.
  * I.e., what "branch@{upstream}" would give you. Returns NULL if no
-- 
2.48.0.rc0.4242.g73eb647d24.dirty

