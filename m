Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522E2DC792
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670539; cv=none; b=feqGiIYMIP6ZhhLmwngxBAyq8P6jzHPopyO39DNvIBNbVkvA1Cr5vRFAlGEe1erQEGF2kkQBkdoh8Bqu4ChyALWeIHZnr18UCwYjJq5IkwCc6Lj4fFxJas5U/irsnfaLfGQ63nO2s2xE/BI1KpsoKP8laP8zG3mR1cxiHxyodE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670539; c=relaxed/simple;
	bh=63SB6JcV/TFj7GLcrBb+AP9yg5v70cGK7EQymIElCYY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=og5KmNqQ3mPhhL3Dn1XIj+DN3CngnUM0ANQ0eGo5Scg4NTqzj9PF/5E9yfy/P+RphlgheNRzFD+uktss4dEQIl+2tT9fVn5TyNSxdAGH/xRYK6Ju+Gcf2htT6jIzRxOMDZ7UT2lEv8MhACUsbdY1fk77N7WWCovlV6dnGBtPgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPGO0Wes; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPGO0Wes"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so957142a12.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789670537; x=1790275337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zf24Q1wFnrMU1Zricz4ZNkGbkB8iV8w9K7EB+IhBkL8=;
        b=pPGO0WeshT1/XsZZgfZF9hjVxnK3TiuF6g4MaNRSQgVCt+Ajg0PvNGeo5zy9tuP8+W
         aAKx7VHVdjFsQvUoksgJhg4eNsF0hy0BwwgA5Dr+6SoisV6nVBLw+7MgpT7/69lBM470
         qeDFCQOZeK5ICKYqQ6diPRUXhtp+bheQSs6qBkvs+GX3YXPcDWLzHsknz411PICB2QYR
         h6iGRNHNCOYwmEHQylBZfJDUhY1IalEdUKVg6PZIs1bapQCiskldLkKIzRCfgNcM/P4u
         ygPjErDMY+QGNZS73VkZoRm/a+mRBWdeNldFjC8nyD27K5xD+YZnDfbL9G/TLUfM+EB2
         5GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670537; x=1790275337;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zf24Q1wFnrMU1Zricz4ZNkGbkB8iV8w9K7EB+IhBkL8=;
        b=N1KIPOLT4Ue3OPWoFoOTVxe9FFB0cEeAX7NhtNoeIcJAeXjJVvEfJMnRRavSGpK31+
         E1+t4yR2m/1UTpTbVkRsQKG2jFNZDVa+JF8ESu4LST7wB879F5B7E5m4zJVtcSbEoKAw
         0onAIzGm/mKCtL/ZyJ0CLr9nBxRC3GftiPlEwdEKBVMh4B9EjUaE2CBEGsKrSPXmVt1C
         pU8l18es4HXRGhyQZNLRo80DTUWPBnxuL4nuyAqtt8GsLTAAcSVLzZn2hC90o3jJFhXA
         A84AjGGmj9cGtq/rpTduiDdOSCSID8viSjSj9kVQzSdxa9hqVhLDquCj2KyGayKnBkXp
         9vfQ==
X-Gm-Message-State: AFuF++kbUntt818pC7OdnZoe6cE5AUVc6bchSbR/SkK837tpaJW9qNk0
	3sGFAFxiCuMbgSzck3L6P0DsseRfJDaWjxykPWiergxBRn1nc32asAR/LHLWig==
X-Gm-Gg: AYBFou2UHZOgYjM45FetoZ9RjIakGkdefRmczrtTES5qvyvteHiQ7ZBOfWqceBf2/kI
	pPN+nWDFA+Fk+fYVmgLVx/FF/BCsstaRMMh57cBNj/zMxjOVmlIrqgfcscbSiwlE/B6ZqjO+GSz
	CtGAkj6gg6RZA/MpZ53W5Mh+05rUVgltcGRKmGZo/Gr0hhxUpxCNhA0nfskBJE5oYATy2YrL8zk
	bPVI0rFP3toPW9Ty/uRSyQJvlvnmIrJzpd8dCoDXcm1hnGS/NGZROh9lZKXglffmkTFkCH2m23C
	RSypg9w7Axt3nX0V6g49yVOZehXC2fjRqajQGxihn4syjAwwkVPHLtpSYvDDHVBlG8k/PT03n1M
	/BsEJL+ZmYWlWKKVbPcwiPfmNjJkS/LzWbMLOi3pXV4NeRPBs3rD0x33I2ebI41sPCB0mD6KB3B
	kSZL6oHyLkdJAIw3v86o4U7B+Ht9gjFlZLd4qYE5m1IW0plrWViLKXOiH6k7GKuXUf1uekuWYK
X-Received: by 2002:a05:6a21:490:b0:3da:e7dd:45d5 with SMTP id adf61e73a8af0-3dd5f5ed8a3mr19167439637.20.1789670536976;
        Thu, 17 Sep 2026 11:42:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.125.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395bf6e8esm15538805c88.0.2026.09.17.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:42:16 -0700 (PDT)
Message-Id: <724baf2789f77477101bc909b243c67981d78eac.1789670534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 18:42:12 +0000
Subject: [PATCH v5 1/3] config: add git_config_append_parameter()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git -c" passes its settings to the commands it spawns through
GIT_CONFIG_PARAMETERS, a list of quoted 'key'='value' pairs. The only
place that formats such an entry is git_config_push_split_parameter(),
which writes straight into our own environment.

Split the formatting out into git_config_append_parameter(), which
appends one entry to a strbuf, so that a caller can build the value
for a child's environment. The sequencer will use it in a later
commit.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 config.c | 20 +++++++++++++-------
 config.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index d9019e7e6c..e0bb29b53d 100644
--- a/config.c
+++ b/config.c
@@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
 	return ret;
 }
 
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value)
+{
+	if (env->len)
+		strbuf_addch(env, ' ');
+	sq_quote_buf(env, key);
+	strbuf_addch(env, '=');
+	if (value)
+		sq_quote_buf(env, value);
+}
+
 static void git_config_push_split_parameter(const char *key, const char *value)
 {
 	struct strbuf env = STRBUF_INIT;
 	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
-	if (old && *old) {
+	if (old && *old)
 		strbuf_addstr(&env, old);
-		strbuf_addch(&env, ' ');
-	}
-	sq_quote_buf(&env, key);
-	strbuf_addch(&env, '=');
-	if (value)
-		sq_quote_buf(&env, value);
+	git_config_append_parameter(&env, key, value);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
diff --git a/config.h b/config.h
index b66dd08007..b048f63571 100644
--- a/config.h
+++ b/config.h
@@ -22,6 +22,7 @@
  */
 
 struct object_id;
+struct strbuf;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -186,6 +187,17 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
+
+/*
+ * Append a config option to the buffer that can be exported via the
+ * GIT_CONFIG_PARAMETERS environment variable, which allows us to
+ * propagate configuration across Git processes. The format of the
+ * variable is a space-separated list of quoted "'<key>'='<value>'"
+ * pairs. With a NULL `value`, only 'key'= is appended, which git reads
+ * back as a boolean true, like "-c key" on the command line.
+ */
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value);
 int git_config_from_parameters(config_fn_t fn, void *data);
 
 /*
-- 
gitgitgadget

