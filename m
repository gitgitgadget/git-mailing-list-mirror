Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61244BCA1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929427; cv=none; b=iP8XK9B7oyW0QeFHgoXWEk751nT3Zu4Cs/Ruvhw2SGYGDiBmtqkts0SpCn3vf+3H5dOVjy1Mm/MI9uu+rM05eoV10NWXtHIGAYDCbwe0OmjHFtz2KyXRLZlDJLW3wjSO1cQBOAACJ5XGQnitgArWUP1mxikYjfZnaseAAbc4JAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929427; c=relaxed/simple;
	bh=rPNcdEN94vU/O3HAF7VazQe6Zpo/U6HC2aXtlKdi+VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gebmWFv98xYAuCY666GtBLqqkPVrWSVr34apaav/IfNgQBQ4C30TnoEqpqMc1UG+p6kiu7NroWZUCPiclp4OIiX6KFfQtz+nVgcyl6U11Z38zv3uQvkq3jZnxpuBVAXj8Gz+XobWBU2gPHjojkezIcqTdPsLSgSUyDSCIXhVbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfiI9ysH; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfiI9ysH"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso3911630f8f.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929424; x=1791534224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6ZilL1nblyBpIYsoSb3gOV1ENDCNfbM6FESlwNWIec=;
        b=NfiI9ysHbwZhYrB3RJRqNIi3yKnHqkYDxV/rFNepZhNBBADKT0/EDjMigCQdGxpkbM
         p5ME+qsORlUd4VJykq7Gd0mWbQ++AcLZYYC/P/Dl7yBox7OcdppeTkFAiMUG22lCH9Cj
         JDYQxnJo3/WvwbJ4kUt6eWnCE1+uwQgx2kCdm3jePzkACLtpEZ+93FfboGDufguatmxT
         qQnAWkq1t++g82j3l2ycyQA3NgolV1y1QqhxmTad2wG6PTF54Zl7qZzXM92jXXX404gL
         wKNjGsaLWbalMY9RfiHrJ7WDZ1QiYkf3bCucH2+xEKqi3S+kLsx2CNuZCTfaAlIiJw5s
         /HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929424; x=1791534224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6ZilL1nblyBpIYsoSb3gOV1ENDCNfbM6FESlwNWIec=;
        b=ioPvZobiSHV9elH4DOmrK0gVNrxRhFWFl6xJS7Cw2vAI5GL8cn9PXHRTDi8yyVwcMp
         FjZ5cng0u7oA6LnmDrEALwZ5X97c+bOSSDT/E1cU+dtZiA4uFlLa4GjcWy/Eho/UblXC
         nVbDz9d2v/uteXs9tfR1oJEGs5SnwPaMXDUkkPI2iTwl04DGBZpXlrwgUogO5+Zfzx36
         leoWYboz1OaDRF6AJalmESElbDQilZ6jBkvi8eyed/6ymAi7X+HcesMdT8/wyHUEmfkU
         7cjITNy7WpglgZjqg4fCkWkW/VpWIIv4uaDPULW9MrXMPN9mt3dOgeiXiNztC39mMLy3
         Q6dQ==
X-Gm-Message-State: AFq9FYK9Z3mjWXYk9erS/RntPCVfPctjCCGxsL/Dp8pi0MtKe8jv9Rfh
	TxBMo7n6p4h3IE9uGXknljLSZDho3gdKvnt4POcZEPw0ly/ONsBa6yaRB6fW7g==
X-Gm-Gg: AYBFou2aoSfTICnfvBpdRztJjLo5z5S8EZ41WPxbc1VPC1IV6BWKPjHT1bS0a5SMRFx
	5U/3rZHFRMRctFoI3dN/VQJiDvJN9/i3Lj39lglnFDiZ7aIuyVbkPfxHisx8BY3CKh/gINnSp5y
	NsVOC1RJXGpkfyOn3hSXFMvDO56Dfa8/IqMXn8vMuD/gt1QFkdALKAfr2IT3QMPICuiNxizL45f
	I0jV17QCxVvBze4m9Ntgs2QHvsX1kTATkTo6LS7sUGzL8ySgPCP7+bbi6lGvlP6UaL4LF1ukv+x
	1suYx/97np9z6ZSvmeJilBajNzKC+MIRvkHTel1LVh9vZ3h5/oxBRM52HrzPkVwBwBoa6wjfVM5
	7RTqxjvBJYaEHudG4XQ0z2OqgFASO01fyZ2zjAjYAwVvKqK+Lonm7dheT1g04P64wZtAKr7jTZX
	owjAs/Kqp0TUM3Ary25K5tRfPAC4AE0fBUPaGOkWEMtocrafFX9xrYiepS1Wgc9i8DnXHhd2wuP
	R1kfqYdmIhc3n2AB/824Z8mIzyEUzb5mKfM15Qcv9+EgoTi6kejl6yO7uLEdWL0QEQ7NdCitDxP
	10r4RP4iFBHvPWROJHBlLU18fe2ow25Ll6GJbRLc6IaEmtw3dEuEChgRb0yQbgXBzbvXMVxv+R1
	77PfDaaW9
X-Received: by 2002:a05:6000:2382:b0:48b:69d4:bb35 with SMTP id ffacd0b85a97d-48b69d4bd9fmr2894047f8f.12.1790929423927;
        Fri, 02 Oct 2026 01:23:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 2/5] setup: extract path_allowlist_apply()
Date: Fri,  2 Oct 2026 10:23:19 +0200
Message-ID: <20261002082322.2682869-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com>
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
function that decides if a path is acceptable by the caller, and let's
add a NEEDSWORK comment about it silently ignoring missing, possibly
misspelled, paths.

To further simplify how to reuse that new helper, and avoid duplicating
the config-value handling in a future commit, let's also introduce a
path_allowlist_config_apply() helper.

As the new path_allowlist_apply() function reports its result through
a `bool *matches` argument, let's also change the `int is_safe` member
of `struct safe_directory_data` to a `bool`, so that its address can
be passed as that argument.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 setup.c | 142 +++++++++++++++++++++++++++++++++++++-------------------
 setup.h |  50 ++++++++++++++++++++
 2 files changed, 143 insertions(+), 49 deletions(-)

diff --git a/setup.c b/setup.c
index 0d157ac254..25c10f472f 100644
--- a/setup.c
+++ b/setup.c
@@ -1355,67 +1355,111 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
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
+	 *
+	 * NEEDSWORK: this also silently ignores misspelled paths. We
+	 * may want to warn about a missing path unless it is marked
+	 * as allowed to be missing, e.g., with an ":(optional)"
+	 * prefix like pathname-typed configuration values, and hint
+	 * about that prefix in the warning.
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

