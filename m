Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF356C650
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885721; cv=none; b=cS1k+zj1nuahc9qwLHVeGMHQh000sa13jDUlHzyW3hpZc+fnSsvlQiqk7eejo0uVxBEbAPT0zgmRrNpQmYo6Kkv+Sqlbx9Jz8/jOUs8NAADDH8ywNdKJLq0nctN6AH13P9BykuCIq36kVg2DLXIBVadJQjIVzvjPaL7pFUy8Cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885721; c=relaxed/simple;
	bh=QOrDAzniDi/VaEmYBwcLz8e9yVcOzqJI8KI9PQQdYMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU1oeswi8QS70JrGRvqPHujpqTvn5D3xzO20aOiFDaNpZ8aXT8hCgi1aIj+eTbuT07oaa3UWcfSEpIxM8nYHKN5i9H5zG9YvtYT2FykWKACfzXZ6wXvzn0nJqIOyMH5XcY5PdFMWexFXtxvlqzEug7TsYmi61BZearFbcGzWDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnNm63P7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnNm63P7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f96c5b722so3443028f8f.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885717; x=1789490517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rPraoFevRgVwjUVNRd9YHuJ+EegIeJNPUHL7Ou5eExU=;
        b=FnNm63P7nkyCzAYNgP0xihghNu32uabaXI/8+TT2so05N9dcXdQM0WtwdydBZ5hcii
         5sRJKHB5mnfyftinuSo70yQbS9ar/V4uKY4RZOypaQDDVOCYKFEdpQt/v3yJSy+dm/Q0
         VppL+1bUDAFncOKFtRxkbAOs4AROFXGeItO/EfDIqE5+Apj9CVNinnKXEmxfJai7j9lu
         Wmj1on9c8D3PRId0LspW9ZIVJHKPvtZuxp6BhptjVK/mSiUSge/xJ3oJfwBM+X1Wwy+M
         a2lY0Nm0feyWILWWvIvwTE4V+zt2lCtxwV5JyM5mPz9rhONFEX71xTI8XTUr4RG5XY6/
         fITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885717; x=1789490517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rPraoFevRgVwjUVNRd9YHuJ+EegIeJNPUHL7Ou5eExU=;
        b=Evd3pBEqW6zC8wmxAB0CuzYCKB+B1C/bMzyODVRhy6mhWiukpfuivT+KB5ct+rOEnq
         pqrZQ1Yok0PZiGKgqKuySoAwTMmyq2UCM7swnYxXB47QkJxKJhGwJ6f5CWw4DJ4skjlM
         UMlxZ4NO6N5iyhXe+e3y50wyeSN6Bu1XtT2I2zpG5f5GEDgvShH6srDYKT6K+ueah358
         nT87Vgh5uDKxkBJttedmgKHBBJzvvwDgl+A6UIIgf4I9DGfjWzQ7DymLdm+gutsMpB/X
         f1JzoCXRCMTQpsHKhDc7tNstSCx8q0ko+O7WwWbk4bU3qCQG7kXBpgPR6V192Z3tXjUy
         LB+Q==
X-Gm-Message-State: AFuF++m8Md+VbxSRo91HTA/6QiVTc8iKnKYB+tDtMvyjXu8pPR+JhiEB
	vrmYzwbsZWkbxAsrPhpvaINbBvKYnvjlGn3zcY8VeQ/rWR5kjxjz+GAhyZZTaJ1B
X-Gm-Gg: AYBFou38cI/V0RXZEM1qUL907YwxlpC3cSILWqtKG4TexKxspcwrAV5YzZJ3n92w/is
	fG+9KiYZfftIWpxA5E4km2xWahjmNEs50pwqkRP5RgS9W4jeUemYYe86NpWN+tZpeFy1BYoFWqc
	8LjejlkE5qXubHAXXzhDQlzChSm6P+M8q5r6hIgVl/CnTJ7vcC5PuiswEWJ6MaFtBzCIia0kWRa
	zSxtpcUQctTQaeoiqGkcsBSAK7roIvkTtSc4/rVaXTFI+GYndc7IFvnxNw4rTNVNEw41JFw102E
	MFY9pF74YKhppCcwAgLnfVwsv6YMvGw478SUNJq3Zg0AJUfCSIJt7Rn/6Zui7ujN4c3wvqwR/Vm
	LJhMaRE4VM+GcEugnD1zvBAlcpn8iEAIv63J7Smp/9pkBnRRZKLdNczK/o3tIK0R6kGTFrtMtFx
	Or8xhc2r3bJXw1FBiiyLm67vVWKD3i2S6z8Y825X5yO1rmEB0pRJLAKp/atb8iHZuWKD3VALu7h
	MqdzKX02ulpuDHYUMHX1BVUGFjZiJBpmyix3pDOHqbeOl+OAGQDDN5xtiIQSKQLWgnpBaacBE6m
	7lhsnUzR9+BxQZyVTH0F6z1LqhR6FHisqKnd8i6ED9VBEv7dijKjBFOn0Pbtbt6LTyi6wak4BS0
	=
X-Received: by 2002:a05:6000:26d3:b0:481:5b58:c589 with SMTP id ffacd0b85a97d-485870935eamr30529407f8f.10.1788885717120;
        Tue, 08 Sep 2026 09:41:57 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:56 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 2/5] setup: extract path_allowlist_apply()
Date: Tue,  8 Sep 2026 18:41:26 +0200
Message-ID: <20260908164129.560396-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to check whether a repository is
part of an allowlist specified in a config variable.

To prepare for that let's extract existing code from
safe_directory_cb() into a new path_allowlist_apply() helper that will
help with such checks.

While at it let's make the helper's code simpler and more generic, by
passing it a `bool (*allow_path)(const char *path, void *cbdata)`
function that decides if a path is acceptable by the caller.

To further simplify how to reuse that new helper, and avoid duplicating
the config-value handling in a future commit, let's also introduce a
path_allowlist_config_apply() helper.

For clarity, let's change the `int is_safe` to `bool safe` in
`struct safe_directory_data`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 setup.c | 138 ++++++++++++++++++++++++++++++++++++--------------------
 setup.h |  50 ++++++++++++++++++++
 2 files changed, 138 insertions(+), 50 deletions(-)

diff --git a/setup.c b/setup.c
index dfe05d9a03..366a7dc5c0 100644
--- a/setup.c
+++ b/setup.c
@@ -1338,67 +1338,105 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
+void path_allowlist_apply(const char *allowed, const char *target_path,
+			  bool *matches,
+			  bool (*allow_path)(const char *path, void *cbdata),
+			  void *allow_path_cbdata)
+{
+	char *normalized = NULL;
+
+	if (!allowed || !*allowed) {
+		*matches = false;
+		return;
+	}
+
+	if (!strcmp(allowed, "*")) {
+		*matches = true;
+		return;
+	}
+
+	if (!allow_path(allowed, allow_path_cbdata))
+		return;
+
+	/*
+	 * A .gitconfig in $HOME may be shared across different
+	 * machines and the config variable entries may or may not
+	 * exist as paths on all of these machines.  In other words,
+	 * it is not a warning worthy event when there is no such path
+	 * on this machine---the entry may be useful elsewhere.
+	 */
+	normalized = real_pathdup(allowed, 0);
+	if (!normalized)
+		return;
+
+	if (ends_with(normalized, "/*")) {
+		size_t len = strlen(normalized);
+		if (!fspathncmp(normalized, target_path, len - 1))
+			*matches = true;
+	} else if (!fspathcmp(target_path, normalized)) {
+		*matches = true;
+	}
+
+	free(normalized);
+}
+
+void path_allowlist_config_apply(const char *key, const char *value,
+				 const char *target_path, bool *matches,
+				 bool (*allow_path)(const char *path, void *cbdata),
+				 void *allow_path_cbdata)
+{
+	char *allowed = NULL;
+
+	if (!value || !*value || !strcmp(value, "*")) {
+		path_allowlist_apply(value, target_path, matches,
+				     allow_path, allow_path_cbdata);
+		return;
+	}
+
+	if (git_config_pathname(&allowed, key, value) || !allowed)
+		return;
+
+	path_allowlist_apply(allowed, target_path, matches,
+			     allow_path, allow_path_cbdata);
+
+	free(allowed);
+}
+
+/*
+ * Setting the config variable to a non-absolute path makes
+ * little sense---it won't be relative to the configuration
+ * file the item is defined in.  Except for ".", which means
+ * "if we are at the top level of a repository, then it is
+ * OK", which is slightly tighter than "*" that allows
+ * discovery.
+ */
+static bool allow_safe_dir(const char *path, void *cbdata_)
+{
+	struct path_allowlist_cb_data *cbdata = cbdata_;
+
+	if (is_absolute_path(path) || !strcmp(path, "."))
+		return true;
+
+	warning(_("%s '%s' not absolute"), cbdata->key, path);
+	return false;
+}
+
 struct safe_directory_data {
 	char *path;
-	int is_safe;
+	bool safe;
 };
 
 static int safe_directory_cb(const char *key, const char *value,
 			     const struct config_context *ctx UNUSED, void *d)
 {
 	struct safe_directory_data *data = d;
+	struct path_allowlist_cb_data cbdata = { .key = key };
 
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
-	if (!value || !*value) {
-		data->is_safe = 0;
-	} else if (!strcmp(value, "*")) {
-		data->is_safe = 1;
-	} else {
-		char *allowed = NULL;
-
-		if (!git_config_pathname(&allowed, key, value) && allowed) {
-			char *normalized = NULL;
-
-			/*
-			 * Setting safe.directory to a non-absolute path
-			 * makes little sense---it won't be relative to
-			 * the configuration file the item is defined in.
-			 * Except for ".", which means "if we are at the top
-			 * level of a repository, then it is OK", which is
-			 * slightly tighter than "*" that allows discovery.
-			 */
-			if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
-				warning(_("safe.directory '%s' not absolute"),
-					allowed);
-				goto next;
-			}
-
-			/*
-			 * A .gitconfig in $HOME may be shared across
-			 * different machines and safe.directory entries
-			 * may or may not exist as paths on all of these
-			 * machines.  In other words, it is not a warning
-			 * worthy event when there is no such path on this
-			 * machine---the entry may be useful elsewhere.
-			 */
-			normalized = real_pathdup(allowed, 0);
-			if (!normalized)
-				goto next;
-
-			if (ends_with(normalized, "/*")) {
-				size_t len = strlen(normalized);
-				if (!fspathncmp(normalized, data->path, len - 1))
-					data->is_safe = 1;
-			} else if (!fspathcmp(data->path, normalized)) {
-				data->is_safe = 1;
-			}
-		next:
-			free(normalized);
-			free(allowed);
-		}
-	}
+	path_allowlist_config_apply(key, value, data->path, &data->safe,
+				    allow_safe_dir, &cbdata);
 
 	return 0;
 }
@@ -1440,7 +1478,7 @@ static int ensure_valid_ownership(const char *gitfile,
 	git_protected_config(safe_directory_cb, &data);
 
 	free(data.path);
-	return data.is_safe;
+	return data.safe;
 }
 
 void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
diff --git a/setup.h b/setup.h
index 763fd384e8..6b84fbe507 100644
--- a/setup.h
+++ b/setup.h
@@ -304,4 +304,54 @@ struct startup_info {
 extern struct startup_info *startup_info;
 extern const char *tmp_original_cwd;
 
+/* Path allowlist */
+
+struct path_allowlist_cb_data {
+	const char *key;
+};
+
+/*
+ * Check the allowlist entry in `allowed` against `target_path`,
+ * updating `*matches` accordingly.
+ *
+ * `allowed` is a single entry of an allowlist of paths, typically one
+ * value of a multi-valued config variable, already expanded by
+ * git_config_pathname(). `target_path` is the (normalized) path being
+ * tested. `*matches` is updated in place:
+ *
+ *   - an empty `allowed` resets it to 'false' (so a later, more
+ *     specific config scope can clear entries from a broader one),
+ *   - "*" sets it to 'true' (allow everything),
+ *   - "<path>" sets it to 'true' if <path> equals `target_path`,
+ *   - "<path>" + "/" + "*" sets it to 'true' if <path> is a leading
+ *     directory of `target_path`,
+ *   - anything else leaves `*matches` unchanged.
+ *
+ * `allow_path` is called with `allowed` and `allow_path_cbdata`, and
+ * should return 'true' if the entry is acceptable to the caller. It
+ * lets each caller decide which paths it is willing to consider, and
+ * whether to warn about the ones it rejects. Returning 'false' leaves
+ * `*matches` unchanged.
+ *
+ * Callers are expected to invoke this once per allowlist entry,
+ * typically from a protected-config callback, so that untrusted
+ * repository config cannot influence the decision.
+ */
+void path_allowlist_apply(const char *allowed, const char *target_path,
+			  bool *matches,
+			  bool (*allow_path)(const char *path, void *cbdata),
+			  void *allow_path_cbdata);
+
+/*
+ * Apply one value of a multi-valued config variable holding an
+ * allowlist of paths, expanding it with git_config_pathname() before
+ * checking it against `target_path`. Empty and "*" values are passed
+ * through without expansion, as interpolating them is not
+ * meaningful. See path_allowlist_apply().
+ */
+void path_allowlist_config_apply(const char *key, const char *value,
+				 const char *target_path, bool *matches,
+				 bool (*allow_path)(const char *path, void *cbdata),
+				 void *allow_path_cbdata);
+
 #endif /* SETUP_H */
-- 
2.55.0.792.ged91fccac1.dirty

