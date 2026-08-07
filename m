Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D72D0C7E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110944; cv=none; b=mjQ5PrbXHSo2UtDPOxClTpFBf8W0lOhupx9GOpe+Iw3oknIVBu/eH7c8DWCR935l+OYFZkw9oypRnUIO4F2pmSLACfkph6UFNDcTCsRtd/t7bwVwAGZlK1Nr9dhjWD8Y4sG/lY728xvZKsZu181lMVX6xeTribw2nE/USSk0wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110944; c=relaxed/simple;
	bh=Oh7AJV/cnIi1+Yv5epW8j0zVwU9RB56PYBUcJ5Zkq1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MujHFqTFcRc7kkyJt18TA7dp/n9w9iJrtbSbl+Kd2vlTJnB7BRUMieQIXKryqy+4NSjAZi/n8SUYC4SD8qUjQhoRb7idJ/+BBqNvPbsiVlR2Wf4QKpj0WpfPPb/18MPzxShbMQw2gE82p1NTlfg0H+y3Pu/4nUGz2Y21ZcFt1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSytwjoK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSytwjoK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ffaa8ebbdso1381155f8f.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110932; x=1786715732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eALS19OvTurT3e7yfXP6nEXDg5oQV6o7+Fc0tHgOfRM=;
        b=QSytwjoK1WJnRuTEuvG8/YMsk+oDEy6h/JRRY1gUVafvNjoFhfVhElzIuRnp5Flm4y
         wyMNSafk9HnzrCHjsWAXZmFGaiIWleDre5opRfSwHVIQvE8iajOBC9iqeGY6qc+eYslX
         ArMmwoCak7J9ES4VL1uur1Z5dtHw8JwnvRX5NhZiwN3E8D6e4L1XgxJZzCU+ya2WrahD
         zUj7xptzxHG0r7Vxnmq4x8lLQWtEeWmra7k34oedQM6tcgImXi7NSNK99Nof2Yz0mjRL
         0oF9+M4fU6L32gCJy4LpsAVGtccpFHhZgeIfj0mcmmAJKg/372XdEie1+fe42GLvIAF6
         TqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110932; x=1786715732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eALS19OvTurT3e7yfXP6nEXDg5oQV6o7+Fc0tHgOfRM=;
        b=gh+RAx9laomXEv2dX1lZiIA3XvGFhBrkN45tiVGBogohiHsouFy0G384dC2VD9gIQ+
         uVTMn06432+mDb9fiMVDq80/bZg3tutt/Bv6wRNL+/V4FTPTdkSogwngWIEOLomkjWtk
         ibZfh0tPgqrbuzNplwBAC+hbK2xOsgOvjm5Yg8iUVhUhXKNW9sxjOD56kl4c7CLSvE+3
         Xp20tqYSZk6EfesejHl1MxZ4lNOBYXSLi91PyWaee2jE9p9j+zi+uC0JjgINbPRqcdgU
         DCpmFiKiEmp3XK7xkMEjvmoV+4nl972KAKXsC17/wJRBfWv95o+Nb0kA6Rb85WIE+Gw/
         1EYA==
X-Gm-Message-State: AOJu0Yz/hxIZcvlSgk6GWXLMbq/bXexuN2qiMODh5j6EKa1P3k+Zg+Wk
	HyhY+Ky8seMY0AkppEG4qWrPixZOAh6RPzO19oerZliWud/WhSIMRg1PYwszww==
X-Gm-Gg: AR+sD10QRTu4mE5T/uqLxIgGr9Z4dko0tiJHrJaWdEKKyTU68AYm34yc/N+md4zBP0c
	3Ejsz1Ot583QDlDYYIDfWTfEQFyE4FqEQbE+ORXRFmaSr9wrT5udfhJU53GIUA9aoJTNo91/HE9
	ozXaJ3ZGIzyAGamCq8uu4pMocMy4ThlTfqzuo4rJ83hN28ivPAA5VJ7ou9vUzfyRFzHUDZt06Va
	luVicfZAecNzsdmGMngu8dcD9wlsCxmPqpkvL8WY2okZyC2Dpqa4bYDBlWj53gseG/L1JOVqgaf
	ErwroeYV667F55DSTfG2VNIvKB0UPOJN8oVMk6yqvMPO1AOXx9UmyVKGW/4z0B/9usqShf8Njvo
	3H5bvUswim/R3uLHrfHH+3pAbVknv9ApsoSNqDjTMvrQs6jhWxknXTF12oXRbb5ayETTSxAQifd
	mLZbix7M8GOG4fqrC/bZgmwsf4G3DgEOPNP576w5NHkdYOtbnSOPjxWFbBUd9uqUALHArDInRI4
	YelvGZ2eD5xN74e05sWBw4NKklcvWs4HQe/Jc25pzLbXwH+5wr5nnUOSRb6KT+JDktfN6cmto1p
X-Received: by 2002:a05:6000:41fa:b0:47f:fa17:ae0e with SMTP id ffacd0b85a97d-47ffa17ae68mr19112983f8f.11.1786110931882;
        Fri, 07 Aug 2026 06:55:31 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:31 -0700 (PDT)
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
Subject: [PATCH 3/5] setup: add 'allow_dot' arg to path_allowlist_apply()
Date: Fri,  7 Aug 2026 15:55:09 +0200
Message-ID: <20260807135511.1818458-4-christian.couder@gmail.com>
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

A previous commit created path_allowlist_apply() with the goal of later
reusing that function. But when it will be reused in a following commit
this function will need to reject non-absolute paths including those
with a single dot that are currently accepted.

To prepare for reusing path_allowlist_apply(), let's add a
`bool allow_dot` argument to it, and let's export this function.

While at it let's document it properly in "setup.h".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 setup.c |  9 +++++----
 setup.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 39dfa1cc5f..a09e697e3a 100644
--- a/setup.c
+++ b/setup.c
@@ -1339,8 +1339,9 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
-static void path_allowlist_apply(const char *key, const char *value,
-				 const char *target_path, int *is_match)
+void path_allowlist_apply(const char *key, const char *value,
+			  const char *target_path, int *is_match,
+			  bool allow_dot)
 {
 	char *allowed = NULL;
 	char *normalized = NULL;
@@ -1366,7 +1367,7 @@ static void path_allowlist_apply(const char *key, const char *value,
 	 * OK", which is slightly tighter than "*" that allows
 	 * discovery.
 	 */
-	if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
+	if (!is_absolute_path(allowed) && (!allow_dot || strcmp(allowed, "."))) {
 		warning(_("%s '%s' not absolute"), key, allowed);
 		goto end;
 	}
@@ -1410,7 +1411,7 @@ static int safe_directory_cb(const char *key, const char *value,
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
-	path_allowlist_apply(key, value, data->path, &data->is_safe);
+	path_allowlist_apply(key, value, data->path, &data->is_safe, true);
 
 	return 0;
 }
diff --git a/setup.h b/setup.h
index 654f10e059..d4f8af5457 100644
--- a/setup.h
+++ b/setup.h
@@ -304,4 +304,32 @@ struct startup_info {
 extern struct startup_info *startup_info;
 extern const char *tmp_original_cwd;
 
+/*
+ * Apply the path allowlist in 'value' against 'target_path' setting
+ * '*is_match' accordingly.
+ *
+ * `value` is the value of a multi-valued config variable named `key`
+ * that holds an allowlist of paths. `target_path` is the (normalized)
+ * path being tested. `*is_match` is updated in place:
+ *
+ *   - an empty value resets it to 0 (so a later, more specific config
+ *     scope can clear entries from a broader one),
+ *   - "*" sets it to 1 (allow everything),
+ *   - "<path>" sets it to 1 if <path> equals `target_path`,
+ *   - "<path>" + "/" + "*" sets it to 1 if <path> is a leading
+ *     directory of `target_path`,
+ *   - any other (unmatching) value leaves `*is_match` unchanged.
+ *
+ * Non-absolute values are rejected with a warning, except "." when
+ * `allow_dot` is set (used by 'safe.directory' to mean "the top level
+ * of the current repository").
+ *
+ * Callers are expected to invoke this once per config value,
+ * typically from a protected-config callback, so that untrusted
+ * repository config cannot influence the decision.
+ */
+void path_allowlist_apply(const char *key, const char *value,
+			  const char *target_path, int *is_match,
+			  bool allow_dot);
+
 #endif /* SETUP_H */
-- 
2.55.0.530.gdb3615d990.dirty

