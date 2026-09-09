Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8346A607
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942338; cv=none; b=Od/GPFWur1Zu/T3FRFhUG4YXiwTXLOkdzStnl0dj0RqeuT/0cP7324vbk7knm1WSab238l/Tr8rh81j8SnjCqWE4ksaKbUjL+Ewbg2mq+VHvfpN/6SLSGhV4xAtRqURWN7dYAoErqcp7+QaylBXtq8zdsAAOQUqOILiE+faUVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942338; c=relaxed/simple;
	bh=PCKXxwr0IcdVyYPUJZ8RUAyKCUVJLzg71DqA3QSmsA8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oVWyoxrjPU6XFkNr0CX+WhWM3JDAu383WzYH0YpK8rm4/jks/jb3/YFS1dEWW7J/3Cd7+pWhO+X7hrJLDmY4vb2xASlNOxYqLcuOqwaHG2PE3Rwfz6q6z8fBcZQLU16XGzsFZHoA22YThIvlExTO2+JzYeQZm66FADR4TWJEmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTa0ZqjR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTa0ZqjR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d032846c95so64998085ad.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788942335; x=1789547135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zMGNP/3K42rb5HTYomM4d2IdY+B62+2kH9Mr6s21URg=;
        b=dTa0ZqjRPqwRU6YV3C2EsFgz+HZ7krEWE/bfQzL1SQ7l8MMcya+GKVmcCSdwspcXB2
         aOvwS/JifN5FlNz/DlA3v50vLV4WlGpgzCfoFElLvThlWEP24aervpCRb++hpNBa6ehw
         +xiATyFsf/siXVI9/ijiKKsMTToYyKp3G9Z/8UC/9bXfVlk6V/v3r82iHst94gtKk2KV
         stL99a1q1n1FArCxE7in/LKBwfQIWUUEviyxfGff8twIe6y/+m8b1cUNlyXnO80/YqxD
         uC89okOSG/XMNodqM+mBg/bTr4aIQN8imoFqzapp6SIGrcYgOr5z4EnGnllYVvMb80WA
         1I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788942335; x=1789547135;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMGNP/3K42rb5HTYomM4d2IdY+B62+2kH9Mr6s21URg=;
        b=bdkVEbQ1bzoXaQnqmyvEbrvlkHwcNbKhYNlbQBp3byrFaycxm5BI2P35xuUzi46k8V
         pJpB3ZHiJWIv4g1AWzzP7i6GRYBCwMk+ci3Accsqj1waqkeAUP4taavYgM3wSHia1F0I
         bxUj8M3yUKgytubtLBRnPN1xPzcSWFMdBxHPZX0u8uZzJzUfJoqmX8UTrkGGgTvNmRUa
         L4MPBQ8YXf45D7GsdopYBC477+2ZfC58JJcOovxDfrQHqQSo5Ouit/ARaM3Kj9fxJBhR
         HioMrqneGnktuhsM0G8juOcQ6q4OXNQEWWG+l7x8+uQAG5hGVwQZw7ePYA0CJK47OHsf
         JktA==
X-Gm-Message-State: AFuF++mlFe5lxCRDSQdtTIV5m0AViltMTrPTlDKT3bD2dDLzcc2b0su9
	1HJeDHN0/GUtYXs/D0U9uhgIyYpsGt5h0+W0aobOX56MeYp46WWFcsHXNU07rQ==
X-Gm-Gg: AYBFou1iXtSdJtCvkhLGTGITrs/1hA4mggTanCPiF76qWZ36wFywRXB9UHTuGlulRM2
	8UhEFEpvMnlFN17ueyeLVAqCnh/jf0ux12/2j8/r4t5Cn8mDZNd5unXIqL85sMzLaSgOgf2vSZL
	FiuFAQnFhEvFgZXu9ZvTUTcD+/bYS0JkPFYypXULAYscgU05H1i3ZzfNXqZOOJuwUbWwNErozNB
	rzxkWv9U1iQBzLC+q5NIkAo/aMNVZ2Ew2PdJfnS8o6GZuxdp6iDhHXRGaBXeLyt7430HPYex2XO
	2vWnE5SvIV48gotTGqaZW4u9WL9YVbrgTmDUMQhDnJXbucQOUb3FNeVGvxP22aw6hBunfSKIIkn
	qzs0NxlstD02rTvJ6zNk6rZRtuY4fE9Wk8r3QvYuwu1laXHJEBpfMkZD6z0Ye9mDp2WY5oROP7s
	NNeg70QKvIiNcWHjMj0TBWrzKDjbvSqoYEcFS7qti4wAakd087T64k0WyK1MR0q4Otjs83Ork=
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39b26204e5bmr47105106a91.13.1788942335399;
        Wed, 09 Sep 2026 01:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm47055931eec.30.2026.09.09.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:25:34 -0700 (PDT)
Message-Id: <0472fadbc564fb724e2cb14f306c1c29ed42ef40.1788942331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 08:25:29 +0000
Subject: [PATCH v4 1/3] config: add git_config_append_parameter()
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
 config.h | 13 +++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

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
index b66dd08007..838d1509a9 100644
--- a/config.h
+++ b/config.h
@@ -22,6 +22,7 @@
  */
 
 struct object_id;
+struct strbuf;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -186,6 +187,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
+
+/*
+ * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
+ * `env`. The variable carries such settings from a git process to the
+ * git commands it spawns, as a space separated list of 'key'='value'
+ * pairs with both sides single quoted, which git_config_from_parameters()
+ * reads back. A NULL `value` appends 'key'= with nothing after the equals
+ * sign, which stands for a boolean true, like "-c key" on the command
+ * line.
+ */
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value);
 int git_config_from_parameters(config_fn_t fn, void *data);
 
 /*
-- 
gitgitgadget

