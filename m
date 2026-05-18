Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424603815FB
	for <git@vger.kernel.org>; Mon, 18 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128855; cv=none; b=DIUQ4x4sjfJ0Vs9vS9gmcxS7Ipt7n0EcokQImDFjRb2v0t+WpVfT83pZ0wluEGnHSvZv80rdw6sL1zcBRn2U7m220k10d8jqqhietI4RYJTSUhjLxKJ+htVUIy/mcV/bmuR2XP4VZm3KVi2Ih5hOZYLXyTR4kbJd+lWgiDzFA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128855; c=relaxed/simple;
	bh=LIGSz8bW9AkAMPMLgy0oQUBGqtFOgIXzRpJ38lQnmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsJ8rtKzTWdT+Q+BwtB11m06Ppzg5SC3cnnM8DEti5ZHAr5Ab7u8s5EKGNvVCWtCBhSrtGzdwUmOmbO4D3ch/sMQgowzKmugprmNtTH2mSX+RLTQe2b9DzH63WxLO1BtVPSGzr8afH61fthFSvHy3vM+1umka+CvfCCHqVBH1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byo+IMCE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byo+IMCE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adff872068so11549865ad.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128852; x=1779733652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75VW8M5N0KoeSua+4woYjy9i85mV3OCWrD0NCxDTQj8=;
        b=byo+IMCEbedqO/hRWH9ERwcgjaqESkUN9dUDWGJJSjLecAu9PU4XNfziv3NEd8e07r
         imzJ5YclN/wAmdBiO1yd3BdQ3qGPHjT2YAyJnoeBl2xv+WlAipuXdwXHGsvHFdWKjkOy
         U9AM/4Ecwht8+wzoh3Ajf9V/4v7hz9YadnpRBQTdX8QR7brglQMWlBe+PUbZf3u5mcF7
         Qv5p5Ylrr+/yEs3psmNHOT3eENsIf5rbvaBEuH+hlDG9EyjhelO7Dop1AXYtYYMFBznI
         70F1qPribGa5HBQKACUcUJpHer8Ju2wllMlgbc0YfOH59prOQSdtthbGBH8VHEqstmLC
         qjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128852; x=1779733652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75VW8M5N0KoeSua+4woYjy9i85mV3OCWrD0NCxDTQj8=;
        b=WrqWnju1/D8SyKaSBSnGg9tBy4VB8YioTYN5AYgn5tgfdP66wD/AiNyxqgJf0qzYUB
         n74iSWeMIDa9NECl1BLOaecql9Og7SvkxbAYLmFUoI9h8HL7QTH82x89aKL0fer5ik6w
         CdXZA//dYauXdmsD6BvUfD8yO4Cx7k0fqQ0g2SMTuotSBm/wdWDjWzF/w658XrfMMFXh
         Au8TlVQf+yVqMg3iobE9wJMRbTHMxkjlg4txqG4EzY9/ALEMXv4RbisZrIM5bOm91tV/
         9f2e43ODBW10yb2J7656mb4QzUqOfGWFlJcwWL8jOox/EAWGhR2IljhX2MsVeo1d0VPo
         Pxiw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZziemzyknSkCffJINTb57UfOusVTuolIEgSX+g+yU9iMZtQ4JZMbM0PH0sp0xed5iI4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Na0Fyo75t7jYdcQXmklrkP++D+XmxJ1e142LHzRP8mvoJR0S
	eB5xlNq9str1qVLbyRav7zf4oo9fC34Q3VHjgxzgKegLbEqt3iJefc0k
X-Gm-Gg: Acq92OF1Jmtz71aNly4jUsP7R/zTbEd114TtRn7OnBz6o4MU9ytuq/ZnBXdf9V6Ee3d
	SaetCVlHkl8uzorMta99OaBo/X9302OlTd6CCPD6GE92QXvH8nPp21Rh2VuotG/VItjhlDTuDlJ
	B5NHRn9JygL7veZlBP8BkvjndIFLsFIc8LgRXEvFdT1S/z1QzddHkRxa2uNVdcRnzIONdjvCKXH
	1D06/YzCRQpijTcAhzkNtSTagiIfc5+HF1GQr1bvi46MxoAb3UHpUf1SmhIG3BSuwh70wY2KpCF
	Ika0K/NJND1a3kA3sVTZNnzeqRTifLJ6v0JK+zikh3oNUcfj4YJ+eTBJLxDMAoHlcI/qSGaNZwo
	cZhcyF1kp+M6HTUicCC3D0WGB0DdewXQKu7UY7LUVa6E2aczyV6wtXd5Yrz2bTNsz635LbAXWCU
	2IK6dSRHf+uhxrWek9Np72kbTufLn3ldG5G3nR0BcPV+a/rnlB7woxQFjuzYpHLLV99A6vUxFhq
	5Q=
X-Received: by 2002:a17:902:b405:b0:2b2:4d78:eec2 with SMTP id d9443c01a7336-2bd7e92ca04mr121648235ad.18.1779128851914;
        Mon, 18 May 2026 11:27:31 -0700 (PDT)
Received: from archlinux ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600a4sm148530085ad.30.2026.05.18.11.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:27:31 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [PATCH v6 2/3] remote: move remote group resolution to remote.c
Date: Mon, 18 May 2026 23:57:20 +0530
Message-ID: <20260518182721.155070-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518182721.155070-1-usmanakinyemi202@gmail.com>
References: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
 <20260518182721.155070-1-usmanakinyemi202@gmail.com>
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
index 741d14a9fc..7915be3111 100644
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
2.54.0

