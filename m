Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB23F1077
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020478; cv=none; b=AFC/y2NZxD+33lfnZpZWXut+Si8tAzB/YwjU+ympYpq6DNUkyg+ODNDEYbYM4QqJW1Yx2iNjyRi8RmwryLT6Pf/2AaL5C75HwRmipp4yC7LiJSMvmPlsInekcGFed0nQdmnbXd5imYEDnPSq4EzVFjisnh/Fo+YswOjYl1WliXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020478; c=relaxed/simple;
	bh=ldrCPyQxxLqpg0CnKD9NhoCI1/7l5GoRcWXkVdVX/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTBHUUMQjIzhSERwR+d3hmDtswbckLe38WQvxahW/p3hO9BjPfWWfl21Jdv0J/OgKmVaPfMw/9czwj83j9+OuxPk9H3psp3WWbIXSZzskLf1IhXEiq8EbjR2Ar6l9CplOoR3AuHWM3My/iBYMMDCBFcCSv4aNZVLseR4KMaCjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAZz6Aes; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAZz6Aes"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so5771668a12.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792020475; x=1792625275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3C/RwPyAdCjRrliWydvh8yJuczPPo+gYJ8j3sTlJpM=;
        b=UAZz6Aes7Kt7wZuRGwkSiG/7/iOMvn6H8dF3QilvvgZ2afBkGtpceq7W6p7ld8Wl2q
         G8mL7nLq1yBceYMkP1Kt04qR8lHY6SDvq4gYR+keK90FR4sS7yIMmt8cCBI+2QmSO8ig
         1QMWQRDkEx2vxTbPlNrK0R0kgzTkLuv5oE7D/r1hajxtM8nWseSDzc5kULe/J4+mC7fn
         2T9C+35SPEILgOUlD9E1L+XK/yQwu/7rep1aV62VGP94w6LVQeQJ5BsrGzAc/D1sGO9/
         WFJep2gZH7PpLdQyCUX3oHP3Tp5fS3gxJ6BjSRIOJ15ZiovRrtqhvcYgklFHK1fb/m7I
         S21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020475; x=1792625275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3C/RwPyAdCjRrliWydvh8yJuczPPo+gYJ8j3sTlJpM=;
        b=s7nArbB8Uo6UAuwdZRHnSx3hzqI4UBJEL63j+Ij7POr5gDC1euCblukmfjcwkZwe3p
         hVHayozooqMo6GVjFuZyQxGwY0F0bMj0GT7UtxfqOpLj2u/OchB1M3H+8f+cx76YxqUE
         dr9/6HKgELt1xrbhrUacd1RaGW+XtUSw6o6TC2YoI3cn2rD+MzCZ2TXue5X5Ngv227EI
         V/vIAJfJpa0DJTUWnMwTcs8xHChO+aiuYzIhdaSTzWynb0X545eMf3CmS9fbya+f0oQh
         8Xr0MNXasF4HtY7n8ITKzTW1YsIixMfl+McWmWwcqinQvzT+s0E1NrbC5kPpmpfmnBO4
         C8dQ==
X-Gm-Message-State: AFq9FYKTGcKvWkk1OoovsJ3jiUnIHeCiHYv0Dl62LVjDLwxlVckIRvTU
	FNqLW0jC+InU81g/smkEO0zM/iNF2YEjCSrUjPfW4O5UmiAlFBd4wkMK
X-Gm-Gg: AYBFou3cfczsov7H8MjP5iV/eb26TZLB3g3tuEMDO65BTnWjT68BmGkYK1MxWt4kPo1
	/rsBPnmwLtndlgZ9ZF/MaZhipJtGv2aMExX+Coz2qLfD1s3SO2mA6sS+JNK3QIS5I64k7A5cFVt
	sbAO3MAVuupsjwKzqv3+gG4JGhdckwYYLedU3d0DHb1rgGrA7Iug5VHjqLLeCKT8ViOg0fipvEy
	i5JfIK70SBWkDvtX5d9WkOsBk2ZyNyv7LtXp7lVns03I1riOxQmxDLfCCP1UIsOufLCFWBNuLqF
	VWxT0UkF419K356NPBvIh3lCiBaUACVSbJlciuUCF9LUHVtB7pysZp+J8cepr3di1p+cZaDhrV1
	0c/a46IJG4VM+P5b+sKfXJOd8Xbd8174IQY8vHbrYGIjsy/mS5Hv+xMIFje8+tvss6z7Fu2ZXFA
	XdrtheGrzeHuKL4rjY67OzAwFw9ZJ3YChQ+5Wwz0SVtzk+ze1o8O2kwFPzCADtWBWj0/XFxir1G
	Jc6O9s5kEKcKpDrHHceeAfCTuf6oBNvkcBYp8JV10cy8tUEJ4nudjVeEMbk1sb3N/lNSbh2PiaA
	1LpJZf3gxkB3G7o5WOegpnj+y8hq0QBq8KO3kysuc5UZq4AyGczodXnwFnU/0Y73GEUyZ35HP7G
	YI8hKbZCsFw==
X-Received: by 2002:a17:907:3ccc:b0:c24:87e5:6491 with SMTP id a640c23a62f3a-c31a9a2da3bmr1624971966b.2.1792020475366;
        Wed, 14 Oct 2026 16:27:55 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963e710sm44164966b.20.2026.10.14.16.27.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 16:27:54 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] credential-store: add lockTimeout config option
Date: Thu, 15 Oct 2026 00:27:39 +0100
Message-ID: <20261014232739.23021-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014155529.84134-1-okhuomonajayi54@gmail.com>
References: <20261014155529.84134-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support credentialStore.lockTimeout as the preferred setting
for credential lock retries, retaining lockTimeoutMS as a
deprecated alias.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 Documentation/config/credential.adoc |  5 ++-
 builtin/credential-store.c           |  4 +-
 t/t0302-credential-store.sh          | 56 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/credential.adoc b/Documentation/config/credential.adoc
index 80a7c77772..6fa40560be 100644
--- a/Documentation/config/credential.adoc
+++ b/Documentation/config/credential.adoc
@@ -48,8 +48,11 @@ credential.<url>.*::
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
 
-credentialStore.lockTimeoutMS::
+credentialStore.lockTimeout::
 	The length of time, in milliseconds, for git-credential-store to retry
 	when trying to lock the credentials file. A value of 0 means not to retry at
 	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
 	1s).
+
+credentialStore.lockTimeoutMS (deprecated)::
+	This is a deprecated synonym for `credentialStore.lockTimeout`.
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index bc1453c6b2..9fef54d218 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -67,7 +67,9 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 {
 	int timeout_ms = 1000;
 
-	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
+	/* lockTimeoutMS is a deprecated synonym of lockTimeout. */
+	if (repo_config_get_int(the_repository, "credentialstore.locktimeout", &timeout_ms))
+		repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
 	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index c1cd60edd0..408f26bb10 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -210,4 +210,60 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
 	EOF
 '
 
+# Holding creds.lock makes the next store fail. The error reports the
+# timeout that was actually used, so "in 0 ms" means that name won.
+test_expect_success 'credentialStore.lockTimeoutMS=0 gives up immediately' '
+	test_when_finished "rm -f creds creds.lock" &&
+	>"creds.lock" &&
+	test_must_fail git -c credentialStore.lockTimeoutMS=0 \
+		credential-store --file=creds store 2>err <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test_grep "unable to get credential storage lock in 0 ms" err
+'
+
+test_expect_success 'credentialStore.lockTimeout=0 gives up immediately' '
+	test_when_finished "rm -f creds creds.lock" &&
+	>"creds.lock" &&
+	test_must_fail git -c credentialStore.lockTimeout=0 \
+		credential-store --file=creds store 2>err <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test_grep "unable to get credential storage lock in 0 ms" err
+'
+
+test_expect_success 'credentialStore.lockTimeout wins when both are set' '
+	test_when_finished "rm -f creds creds.lock" &&
+	>"creds.lock" &&
+	test_must_fail git \
+		-c credentialStore.lockTimeout=0 \
+		-c credentialStore.lockTimeoutMS=500 \
+		credential-store --file=creds store 2>err <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test_grep "unable to get credential storage lock in 0 ms" err
+'
+
+test_expect_success 'credentialStore.lockTimeout allows a store' '
+	test_when_finished "rm -f creds" &&
+	git -c credentialStore.lockTimeout=1000 \
+		credential-store --file=creds store <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	echo "https://store-user:store-pass@example.com" >expect &&
+	test_cmp expect creds
+'
+
 test_done
-- 
2.54.0

