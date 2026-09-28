Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C54C8FFE
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602754; cv=none; b=PS9lKfVxUEwuZnRmPqCDYVORVu0NsdpALED5MwXShjfDaazVaCo/NqmqsZoWqOHzViBJUuwMtCR8ikOAaaYVzL1yDI3ojRVzUulo+JhH+poWEmGYy4cw8906UCs70qGSiMKae3l21y51cQBX4rV4qAUsu744b/gl2Luddk2LAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602754; c=relaxed/simple;
	bh=275g261XSUd9EBL66RH1wx/ybcNIEQ10YAx54to5VNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM1FLfmIGxhanbwGJHY4Jyid2fvyzXNfiso2iZ+T1pthT9JnwxykKFfm9NkvxK/gh4iyXeydIgwchN9pi2l+rQBwikEcHpStkzj2agn1fy8xlqaBOpPIQESz0p/M/r3A04E3OQ79qVsEB2FUYiGdJJyTzT/ySh7E5TDTpHgBDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTrQd79u; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTrQd79u"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so15779075e9.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602750; x=1791207550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSpR5MwZng5AHNm5w09VkPfNiqv5g9XYeJgLMd5egxw=;
        b=MTrQd79uoG7uMKkHvRXpINRKMzkyAeIyPO7q3Gj4mgSLiq97Z/9/yFZe2cgujc9Ep1
         kxS9tWrsCsZO4kZnwcP6ZInHH8zoQs/lPPSsElaa6bESqYnI7YtCjcqr2G73KOLe9lyx
         YOfzU5hwhWrHAHmYgdbRMEPQ9A3T9NL/n+vYj2cVTKu5hB2NlCHe/A6SACvvxhdGZAgk
         ef1QqmhoX93ZB3K28LrD0iG9I61cdmGP6YzdMAZv0mN6zdeYl3YqP/dQMA5Vv1Q+0/fk
         Hg64gNiB7lptvZAivFSn3FRvHOweaBlWbFCbEOyamx69SseEPVaqMzsxFTeOD2fEYOqs
         ycXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602750; x=1791207550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSpR5MwZng5AHNm5w09VkPfNiqv5g9XYeJgLMd5egxw=;
        b=SNcS8f/JNP98r9I1kURXgg7szVzxLOa5i7TeapBSSpRpCpTVZauea4dMtl4Y7tVGhs
         ae7DB8ofzB9X1XMINzhBgf4w6qzrq4X5EVyDgw7bgxJeCtupqVK7tR8VpUTwagJVRPWG
         MfXCfD33CHtMPt7l9ajVs1ood+N6APabtdntrokC61BrfhH6MHVmXwXd1EY7/QkulYaQ
         KV9fJSJLvNMeHFdp/qpB8J85lImaAKFvsNhe4dOkLjosx9/jZjxaP96jtsqOILBFSaeA
         Mgi2QA12/1lKDUnD6Ay9wv+5GFOvyHIGEyUMGPuLFFjHx3dTI3LbQpxMaMGK/UFljyF+
         XlUw==
X-Gm-Message-State: AFuF++k2qnpVucVJ7VaCGIzCiq3uYYMprcUf/ztVwR0CqliChsZBYn3E
	1vog3bmfGl7afZ8ok8MC3rJxOB0SCHGnt/tGO3S0+vL2mwIJx3B1bVWG3VI7Sw==
X-Gm-Gg: AYBFou1cuTV6OLMp7rh/k4GW+XNoKcfazcPBS72sxYdp0f9WcgVXn0kdUacjHlJJecI
	tYLJ8OZK/kl4yilJwoJ//3GyG8jGdOwvzp0DHnm10YRzXo0Qe+hhEzIqLDXSlbUyzBM9OnRwWss
	Nwo309bQDbUgCHu23GTub7lcD3mdr/B0XtclDXR7esJ8PMIpEQi+m8/X10LdDqwQb++6x27wSvh
	N+bpzVXlS6UO/SmH15Gp9ydGsDIEbORMIYmujf1Tm/zt3DmsRdcLxYiQ+8pPC78eOhyz47KxDCX
	Xm0eeXfNWqRVKJoqG+JgksC5s4DeBTniC+kURNP7EBZmR8XA1ZkWuPxJd0KUiSvd99qjYi24kKy
	P5kL0O4W1R/vm6Eek4+64fE8ovb/6YiAc3mtkfqbEN8i6HIapMCwfp8AufenF++no4hTH6Kqhy7
	rnnKoA9S8x4pjZbslupBukj7Nx3M6x5CidQZok3nfcIflCI2tCw7Y+JwfGsRaTWRb9Gec6Il96y
	TsMCwZ33QL0t2kDoj9gp2Xp84p2K3LWiK6Vk2ZDKGge1+bVS/BzWMa8pjPC9KqO0MPxP1GvGBtd
	AyR7DmE6I1So8thlsvjV8n3OuBXWgte78SUMBUOAGwaIbm12j3/tlkwcysYgbgE+aDs7hcQfp99
	q+cQGmZor
X-Received: by 2002:a05:600c:6994:b0:49f:dc71:e609 with SMTP id 5b1f17b1804b1-49fe66e6468mr208429945e9.20.1790602749377;
        Mon, 28 Sep 2026 06:39:09 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:08 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/5] setup: extract path_allowlist_apply()
Date: Mon, 28 Sep 2026 15:38:43 +0200
Message-ID: <20260928133846.2094261-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com>
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

As the new path_allowlist_apply() function reports its result through
a `bool *matches` argument, let's also change the `int is_safe` member
of `struct safe_directory_data` to a `bool`, so that its address can
be passed as that argument.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 setup.c | 136 ++++++++++++++++++++++++++++++++++++--------------------
 setup.h |  50 +++++++++++++++++++++
 2 files changed, 137 insertions(+), 49 deletions(-)

diff --git a/setup.c b/setup.c
index 0d157ac254..adef789d54 100644
--- a/setup.c
+++ b/setup.c
@@ -1355,67 +1355,105 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
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
+	bool is_safe;
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
+	path_allowlist_config_apply(key, value, data->path, &data->is_safe,
+				    allow_safe_dir, &cbdata);
 
 	return 0;
 }
diff --git a/setup.h b/setup.h
index 7394473e95..7362467ee5 100644
--- a/setup.h
+++ b/setup.h
@@ -305,4 +305,54 @@ struct startup_info {
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
2.56.0.rc2.20.g34f06850c1

