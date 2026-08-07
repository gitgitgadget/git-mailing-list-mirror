Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583AC327BEC
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110940; cv=none; b=B/PFnvdD+lopSlxEp8hjd5hQSSqbH8vGPrvMbwAODAATzhYnlszzO5mjbc6FUn0+zDczY6mfFJnJ2QHNSYvV5y7vO0na94gMXWb8qDed0D5mg6IbQhu4nZgFQp2h6COLUXxm5laW0mpCdwl1PWzhFD22L0ygZhKPOJ1nowY86RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110940; c=relaxed/simple;
	bh=7AcXHtbJjI06zl9uBZCb8RwN7JEi4Br19zZ7MJdkBkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw59DI091cHLtWbW0YX1zLuibBpzncsYI0uyxgZZ1txO954qNbOePvefUhAXAR/pXlVdsVYcOI+3intWpd67prVwc2QNEOUyTEOXZemSAUXuoWPjoR4fbCFX29SXkNdKXrycJfFik0imdUB4JsvSJQvYXqgpAHWW0N0BnnSVDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6qpLD5A; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6qpLD5A"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3266302f8f.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110931; x=1786715731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtKf+Bnu2yEwMDEOz/D4L1Mn3iDPYOsb8UICvH96rlw=;
        b=m6qpLD5AL3ES0NgHjeX56hLjrscvWAau126+VjkFHpFp4nqAOZWJR5954ah9irZv2P
         HstRoCkxdJp3gWqUf5c6uQyvDfWdcSgEFH/nLT3wkArWNhz/2H3dof0stDeCrrM6k0J3
         +QNivi0iXEcqupSHWKz6Ui9YqJsUDVJuUpj8w5v/FFm3PENr8SKq0OecQ4c+fHcCjRrF
         tkCd6lopmxxX9Z9SaotypCwW1K2VqnI67Qjjc7xuvTQITnKrQCXrRgiw+9mMc7/fQb+w
         nUO65vv3Syd5MMb3OnaL1pkDSExho0lVpAFxaRdPib1MAK6pVySmIjKc+8gWaSeOChEf
         rFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110931; x=1786715731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtKf+Bnu2yEwMDEOz/D4L1Mn3iDPYOsb8UICvH96rlw=;
        b=XF+O9HjkiBv1L47rFd23faWvOx5O9w94JmvAeQ49BIhDo09rofukO3aIoJbo7skojd
         6964Y9Wcz3y/KXjHCVXjAI9889A74AJagjhiVzJDTM6ikaq4f5wPKANA0ek+3PoZP4vl
         Ad14z0kWLCJA4wNOJnOZr0GNJFzY6ayoDSQRwV/3VRLpkrcCaFwqCw03qFy6hEvd1QE8
         jmlHZmENMUkJi55B02if+XQSG8tGUaelLxnqqqE/rfBODwwq5LxLqakt8MfPvD6T6fyd
         xMPlO/u7ZJMsrIKKM/HF+6kKUGEoiLK+yA7CcNwpGf+u9+I1d8YHPova2uJMs9nCV8I+
         4lcw==
X-Gm-Message-State: AOJu0YwcQ0JCBbglntOi2icOyu+z2j6byhHpiirMkT9Nd7QIdLHuckQ6
	gyVKIvMYlrKGhy9SBCAp7udsvUDKE77+AjJ9xcCqA7mpXJt/eg+i3uVBTzFkdA==
X-Gm-Gg: AR+sD11t+UnVjGoKpbAo7/HsxuyOTNsxsvzX9JFsHF5qY3ImKBFVbgcZbWPoqI2fki2
	p8sWAsbVu8K6ikwixVhLFvzJ6B5Weqe1uBLqumRvIuZykRG3z2vT6k++abJ5PPRFXpvpot7O2Bj
	lzlb33ox/RFpoIZFFlynkOKVszoQ8bCGzEqcRUYsw1jL1NXnH22O5x0U2fqoEf/khT/n1YwUPxH
	x13le5f3swBaqhaOMAydLtMh5d+80T4y6fNv4ZLf8PGn2cQqr6ReSKSb3hRlWo5s5NIpnss2x1m
	Et0u3prybHQsqH9Gc0wvxDQR4QNXFOQ0aDlK0dMGTrRQ7qrVO5KKK7wOMMzKS/48WcT0EuYeSS/
	XuLq1R/jKjrCRf+CiXsiy3EQHZHWzFkbvZGgseRTOZXp31rVg/hoCMwhQyvYDdp0k76d9uM28X5
	8S6ho91wdOp7Y/OiZtwKRVdgUDXKSa/XjHHkInlbiAKxpPwP7/9vJFLq5UebONGhc6+c9GLy4fa
	a6UwW62CXdKIHF8B6MWBf1EJU6+I9fsGHhlVcjR+pfx9i90hfergDIXUzg2Kwo3PPFMtK+adWGz
	lbde2LcdVaY=
X-Received: by 2002:a05:6000:470e:b0:47f:7f95:8a1e with SMTP id ffacd0b85a97d-47ffd203d5amr16407218f8f.5.1786110930521;
        Fri, 07 Aug 2026 06:55:30 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:29 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] setup: extract path_allowlist_apply()
Date: Fri,  7 Aug 2026 15:55:08 +0200
Message-ID: <20260807135511.1818458-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com>
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

While at it let's make the helper's code simpler and more generic.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 setup.c | 107 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/setup.c b/setup.c
index 95909e9603..39dfa1cc5f 100644
--- a/setup.c
+++ b/setup.c
@@ -1339,6 +1339,64 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
+static void path_allowlist_apply(const char *key, const char *value,
+				 const char *target_path, int *is_match)
+{
+	char *allowed = NULL;
+	char *normalized = NULL;
+
+	if (!value || !*value) {
+		*is_match = 0;
+		return;
+	}
+
+	if (!strcmp(value, "*")) {
+		*is_match = 1;
+		return;
+	}
+
+	if (git_config_pathname(&allowed, key, value) || !allowed)
+		return;
+
+	/*
+	 * Setting the config variable to a non-absolute path makes
+	 * little sense---it won't be relative to the configuration
+	 * file the item is defined in.  Except for ".", which means
+	 * "if we are at the top level of a repository, then it is
+	 * OK", which is slightly tighter than "*" that allows
+	 * discovery.
+	 */
+	if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
+		warning(_("%s '%s' not absolute"), key, allowed);
+		goto end;
+	}
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
+		goto end;
+
+	if (ends_with(normalized, "/*")) {
+		size_t len = strlen(normalized);
+		if (!fspathncmp(normalized, target_path, len - 1))
+			*is_match = 1;
+		goto end;
+	}
+
+	if (!fspathcmp(target_path, normalized))
+		*is_match = 1;
+
+end:
+	free(normalized);
+	free(allowed);
+}
+
 struct safe_directory_data {
 	char *path;
 	int is_safe;
@@ -1352,54 +1410,7 @@ static int safe_directory_cb(const char *key, const char *value,
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
+	path_allowlist_apply(key, value, data->path, &data->is_safe);
 
 	return 0;
 }
-- 
2.55.0.530.gdb3615d990.dirty

