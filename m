Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302F34B19A
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749979; cv=none; b=SF6EnJ8WGXwHI2hkBLSxJK09DGnIvd2GYRMqZhAN5yv2FjggsKiqJOIy0fawgey8OjdYjx83+p9Fp9mxuVNhUFKKxRI5BqvUM+Re/5OJX+ld5/NTrX5WVNFbrUEiuFSNMfR4j2w8/fCSZBgD/PI4tgeYOqv+HXsfNbo26HANO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749979; c=relaxed/simple;
	bh=DRtLhDxVZsySzDvXrz9rUOKR6K2CokgGDzKsLBVpFbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+8umdf+1bFVOHVpklG2qLkZEtGDcYwfXiXN2MJaX+HITzevzpt4opWmRtyPUiECMnJaanKq7VsR/1hTId1MKe9GthP9wlMp4NdWCZ1zQEQWeiQKapVqDDxGlUZjVtTmkYvGmTtJmnXYs2DZyBBvU4VaqUjb9f7BKFDiO/To4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVKtlGwM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVKtlGwM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296d553142so1364491b3a.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772749977; x=1773354777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FWiRr5WeylO52O5xpWzebi0y0x25UJs9EuC31xlQ6w=;
        b=KVKtlGwMVZM9QaIFSV9vj04sATOAryG01MIrlr1+HEZinN5bdGB3et5/+9BKkwIRlu
         TMdmwasHzU+82WRHtSXmQAzwxtevTlTYXSpqaUHjXyOTT1Ry+yGXoHs2Pc+4I3IsGZ5y
         w+5ng9iCJ3h2rmAZX2mWWjnbX4oEH98iuAK94RvTDTDrUjjRp3HEk2ReD94FyKGvkrCV
         SSpbw7wUteB2xplVPdlbtW9i7eRTPAUi+SlEhFMwtOCHU3BfXH19VBBdkAJHImrSq7ii
         FIDSC161jsT9oU3+lVhv5cI+UcN0iQcPa1vmO3cEKAH4XIQj5mUkTp/IMETroCy14BAw
         2zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749977; x=1773354777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7FWiRr5WeylO52O5xpWzebi0y0x25UJs9EuC31xlQ6w=;
        b=nw/IF+Rhb9IRIIHZDtVPvjlUsK8y+PzmOoDR84oxjZ6jIIJvHh2oi1HoTY1CUXtjgp
         PojL1tJcCHHWm8EkqIZj5ri+0MNxOmvrWYvyMsRRXmMyRtgQfyAlGaH1RWxjS0ZW7lrb
         /Z13LhPDWm7x3yMCmnD/SWZ1sOfZBL8zgUBladMq1bgz9f3P9CaesnWLbA7Z3Cl2ReqX
         LMjvVrs3odlc3iwPR/oBlAe8T3S1w+JThjV1pvrD5KUoqbd6JMwwIXa0yGLzrhny8kqJ
         nd61dUorMYE3n1n9NWWTRVWs7UVDvGCTzOtj9Hi81RqL3m2yQQpM4arvk32wEP4/9RWy
         RUFw==
X-Gm-Message-State: AOJu0YwmG99p7fL2dB4eR/VKjVlNCt2FFTZHJ+A50lg3sqRty+Cya4lI
	mHe1Kr08h+Sw7+/YwwTO0MNsff3yr35l7kJucvj68rhO8XieGO6BglZ5eRTUbLGh
X-Gm-Gg: ATEYQzwZDtbRSKmr3ISf+yk8sVboUWGMBhSZzJlaMRHngtncml7E9KOaRGfh140a1Rl
	Js8OxK/37yK9exFv61kv+Qz4VBXX32IuJTLWSgZksk9H39FziUcvBbQjue6426u1QVVnnQSZpQI
	wMMuBTNWr3O91+ubIlmHpyj8dp2/Ld3TrqNdlrO86AJOA3IgV5B5ct2TH3uR+odH8+iAxmDnCPp
	4DHdAXg+NbAu9yMMYlWnzFdcW+imwiSy+6zbaoIh1ZZGkXODcaGnZiO3v23tHPsY/VTsUXRNVTl
	SurleThJ4LnPMopgD5iw+vnh7lbNp51qL7wZRBE3RyACw3app9RX5kMhyZOozKCksUXdf36lr6r
	XBN7sDJy4im9JHGaeQ8+p+FO2ohflVpltIsS+89wj0dx149v4ZeDAv3iD8YeIiM8TpV0jz4blrZ
	uOM4CgcA7g90q/bL4iQ4s9kiLaWRDlQCIH6/N6ra2pQZ9sBc8UQ+TvMVfuIEEXds4HZvDXSw==
X-Received: by 2002:a05:6a00:2316:b0:81e:8e66:38d7 with SMTP id d2e1a72fcca58-8299aa65f88mr1382228b3a.17.1772749976882;
        Thu, 05 Mar 2026 14:32:56 -0800 (PST)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297ef26eb1sm3916721b3a.49.2026.03.05.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:32:56 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH 1/2] remote: move remote group resolution to remote.c
Date: Fri,  6 Mar 2026 04:02:47 +0530
Message-ID: <20260305223248.170785-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
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
index fc052945ee..fa38f951a2 100644
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
+			    const struct config_context *ctx UNUSED,
+			    void *priv);
+
+int add_remote_or_group(const char *name, struct string_list *list);
+
 /**
  * Return the fully-qualified refname of the tracking branch for `branch`.
  * I.e., what "branch@{upstream}" would give you. Returns NULL if no
-- 
2.53.0

