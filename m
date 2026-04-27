Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525E3D1711
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298740; cv=none; b=penTD5DWCpcwsFBMucNVrdJLdcDvsFqSIiepwvztQKAPHWroxfBdKF0hxWcpJMjCIHqXesI7hJKmZ5/F9lu7BqSW6WaeOj0c9m+xAnx9KFEuEhHl4+Gy5A4akLbanxXeaPiuuJJ51exIDDW17q/kNp/+KRxnnJULYmUYDrB+rlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298740; c=relaxed/simple;
	bh=WD5JK84QI2x+1FRxcVdnvBCPh3HgxXA3ihsqM4kQPCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA5zwGdJxp3wHD3S3B4zPt0BdPUg8GA0HRbaq4RV3RPFG2E0Q5JTXLyloUL5fibJUZ67IuCD8XBwwephUui9uLmWoP7y20qH5svaYuDqE9/ktdwf0TZ5ESCTVM3TW69R0iQwgKWf2lPEUVCPMc4k0O7zKDk9h2+isb8yyu/GlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWyoC1Pg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWyoC1Pg"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so4053260b3a.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777298738; x=1777903538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCKqJVjPCic6rBLj1+llY1aUK9+4BI+BqSheNxRB1Y4=;
        b=YWyoC1PgTdSY8ExCn1GVMqdZFPPCp6RdDQcF2mWs9/F3wVo2jJbGDJLk+8HNBjU3FM
         sCG+R5dqVPMFlBNfOmyKSMWND84e8A1hFL0z+ovKeNNLLOkrGflAL0RFGZj5R6Ty/jIG
         7tUaOFeBQ1dgBVSEzxxtcYo4KQ3hU8Wifyb7lKgeaW8rY5Tq3kM02HMHySYA2giRcxdX
         IzDe/c27mfa7jY2ozXojWSP6HcGuXazBZ3J3gsqyHgju+dFcz+wre8Zr5r2/kCPnoFMt
         RWRPO9qEOrK5CiT0yXaPy2ZjtzPZ4sBT1IntYkAm+/K8jZvS84K/akmgc1BkKn0nb3zh
         BhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298738; x=1777903538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCKqJVjPCic6rBLj1+llY1aUK9+4BI+BqSheNxRB1Y4=;
        b=ls9kw6/hbVRCIW6oyFQU8GRsCgkqtHSVi5WjpF3ppI9raUDb/0myKDYA4XHyFL9kCe
         AA8HuGDtPCUSddiTYLoqU06sRGFgui0/ZUmTvQfORA/EhRkvPc95/JqSGi49pgyfKhnk
         GfiWbsYNDa+qg3VpFGTwqI4jtG2+5WMP4SVdIoFZdE/iGDD17qJHvZ0j9FgtiDgjWi5A
         GKq3c1Btz5OBYbNHTS0T7qKJDJlUIoVeWBUoRBd2oCEjLzVhQtx2L7ai9vKssQOE4Rjv
         iTJ2V9AbwVUhgCHI8M9NXTfNKtMtZy8BIeo/6nxOznf0bZosb3YaCedVSscGi4vBYHRi
         NL6g==
X-Forwarded-Encrypted: i=1; AFNElJ/pIdANCpW59NWwQgc6w0L+tQJTxDUoQsmZUVbCHEOX0g++HkhQJR6AGjtDrwaXJoOf5tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlk10nLXRNalPU6hBDT25+GPeseq0qUlvdJPEkU2BmWDk/kw4f
	qvP5XRv0D3VE9cGfQ2Tc1XdNY3Ome2LSh/3Y1Y1J9wuSBKRqKKxtrgNT
X-Gm-Gg: AeBDieue4k7hlRKmzvp2XCWJzSm44VnDRBDZbemmvXB+pC4SAe42qtjy+0XETRizels
	Ug0h8jILEdbB3gXq40JViOCjmeHfYf5y47r9WmqDZrS7OYC0zU34OGHDDlGaNq66mqEhusvn/Mb
	y9fcMD9oFtcvKbrZWI86mI7ZPP+bt+BilsOXUXbS7GgG/O4raX8+O1r1NcH1piKr4zPCdq7TgXE
	r7AwyoNNg743lFOIPBLl4w07EPwhSR2pms0WKIwKq2RXI+BZ1qh6P9fduaUy93RXpi0HER7pqee
	Ssf78bmjMnibluA2FFuTBLnGKk29yNZCEuX1GLZqMI3tQZ6yrDDM7dXBgRVMQhOxNNHKR+QSrPU
	HsQ5zWhPtmYOhWMaJsWAhD+X41qT79iRyt7vkArSnVOavIDifLvm0YkolvUIo5lgxgyTZlhfwOh
	A1ENp6sF96nxfOmirGZnee5YszAKN+sUFLpRAYku/rBcnngLmbHI2eNCbFPh50gQfNHiaIpQ==
X-Received: by 2002:a05:6a00:439b:b0:82f:8696:5a75 with SMTP id d2e1a72fcca58-82f8c8bb700mr45688016b3a.28.1777298738383;
        Mon, 27 Apr 2026 07:05:38 -0700 (PDT)
Received: from archlinux ([14.194.19.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fbb85sm37331623b3a.22.2026.04.27.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:05:37 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v4 1/2] remote: move remote group resolution to remote.c
Date: Mon, 27 Apr 2026 19:35:29 +0530
Message-ID: <20260427140530.856125-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
References: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
 <20260427140530.856125-1-usmanakinyemi202@gmail.com>
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
index a22c319467..cfb26eb284 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2138,48 +2138,6 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
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
index a664cd166a..7133d29332 100644
--- a/remote.c
+++ b/remote.c
@@ -2114,6 +2114,43 @@ int get_fetch_map(const struct ref *remote_refs,
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
2.53.0

