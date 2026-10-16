Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7033C10A9
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185793; cv=none; b=SLi09JiJ+tYc9xaHis9xrQkDHrb52Zdk/PKTNOdHps0KuPNv+fDcI/N7GM5D9cnc6Q9OjCBU2hbLDR9drUPRe9BqpLKfR7EdKxI1LEBJJHNLipMfwLGk/HyyzBwqGvbopK4pn7wxqEnNmuG/oQSo1vgjcGwm3/m3igS4V+lyZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185793; c=relaxed/simple;
	bh=lr6G2nbPtA+uh6zCCepfQCLB65jl8LFaj/yD+feh+SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4AIqOxWNkZbcWrt062CZVa3N+ELvXG2ZBi/1Eg6If3xj/OKmeNMMfv2vgSsXyeHpXR1Ul659fDv6v86Y4q22NmyHWWjsjdQfuVQTBm4Mr9H+YaCKbFEAp4oQbB5Qsnvk+qnS0DFzLsFUDI08J2oSI/Y4U9OZ1pLUrl9Kne86BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y90fafEu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y90fafEu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so425574a12.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792185791; x=1792790591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbdMz9xxRnFLm3AQuI2IglTSFX9VmjfNzdQlwKSTxEE=;
        b=Y90fafEuoqK3SJGeVYa8NUKUZVZg842dDv/y9ZNCauU14sBDxRCECau3hlj13zrkAm
         E2uaN/KZCitv67SZyeHRzul0G65rpZsVRftp8/BX4OJ5sHrhcab5g3iQgHpDzJ2ut1Ce
         knJH+KFh9YI/VAcPX3re5Iy2mxQ4MQ8koeLLfp2nwUdgugM0ya9KtS/uVpM/AtBnB7NV
         Re65xSbO6HeqvPTWFbj7TRdAungymC/MyWdLQx/57shTEJUTWkWB69pJRhzxz/oeZi90
         XL5gP/GepC5/IyDTRDlfWpg50qvJoFE7wUkcWfbdbgXuFT+AXDbntfHn6mtA06rwyymp
         M2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792185791; x=1792790591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EbdMz9xxRnFLm3AQuI2IglTSFX9VmjfNzdQlwKSTxEE=;
        b=m9ASjbRN0StUwoaUr1lbD/jxEjez6ZXRXfaV6zDYTYV4HIVByugpCnd6/3k4DxbAxR
         W2kdqGxBK0ua6B7FfjbaSM/fh5ETQ1AB/3fOCZ38af7StuTHfnOlOD68TH1w59Q6uXNV
         gL3c79ZyG6bO0BQrhOWqRzwvfL/gqM3DVYvDMp/eNsp3o4XV1CbSBdi+xhkeCM5ikgqx
         D/K2vZnvZfw0vI45j53J++H5N7T4y8VmVT9wnTBtH07NiCyM94gellrzIsbDVEvXlqdM
         +oCO+/pch/0CB2Y5ebxFXibwDqSDHVlKd3k8SI3DDexAoxECMEYmQZEKfvF0pR0jnnsO
         fusw==
X-Gm-Message-State: AFq9FYKEJDBjyaqf5tJFHMOHWg2ldK3ycyM6fzV4nMQN0bLG/8w3tAtS
	ALjY808rFYLEZADfzHBUNnYCplPLWyxNIZDkPRJEn+b2IL3Ul/1zwdbIUiNe+yLykJY=
X-Gm-Gg: AYBFou1lHxpMGmkPQWLDDxzROTuduQIEWZfz0vsShaFtMYscwna+pWmNE+6oeN3t2kY
	zjfZ/bbk3qza/2aFIbPMtJiFtzHR0XphZLBZnbLNgDvLrW/C9h6/+bZBXMvlqho2Ma6GKOrv9i4
	E3HUp9mqF02aNQfq7gAQdPGANkQPGF/XvTW3+gYEG8+/zpK75/xhc86CldgPUjyzljPRIxz0Vuq
	3hWdExJooh5zLq7B1lTyRqpi9RhSCq7+wbui1nsm1kcguYYVsmyh5e+qRUWbwz8yQbufaoCx63t
	uvQTYhDHAixehd8xK3OTq1Pq2BlCFR9+JJJPla9aTdbcIpFmWjJwGsKoN5eDptKaUTB2OE94piK
	kvTxxsDkzeH5PQvToFsGlPOpw6ya7pTVwj7d5N7YiKwAxoqhhmPdAJgG0K1ICaXs+QNnSRg3eT7
	CtujtqekN/gHCwKPYQQPswrYc+sZ/NT8g5SRL1iiIJ6Pc+mIC9SuIO5R5G2AQJjhvgdkHcKwTnm
	KOoPNbDzbCwQwW1RUKXMouah6sBCAaTA4XklIMp4mHee2ZgFeQQ/TCH5zvXkS6MmAyK1L9EMWCL
	0Ra1qSCZz6+yyQBKjO0lVzK6/2UoHPXW8rm7f3Gwda4YgmLd2FmnUazgjuFF86dof6k70lwKyg=
	=
X-Received: by 2002:a17:907:6e87:b0:c29:59ea:5bf9 with SMTP id a640c23a62f3a-c419d05f7demr75381766b.14.1792185790464;
        Fri, 16 Oct 2026 14:23:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40918c5f47sm110089766b.51.2026.10.16.14.23.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 14:23:09 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2] credential-store: add lockTimeout config option
Date: Fri, 16 Oct 2026 22:22:16 +0100
Message-ID: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014232739.23021-1-okhuomonajayi54@gmail.com>
References: <20261014232739.23021-1-okhuomonajayi54@gmail.com>
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
Changes since v1:
 - Turned the two "lockTimeout=0" and "lockTimeoutMS=0" tests into a
   single loop over both names, so they cannot drift apart.
 - Wrapped the long lines the patch added in credential-store.c.
 - Added a comment explaining that the "both are set" test checks for
   "in 0 ms" rather than "in 500 ms".
 - Dropped the "lockTimeout allows a store" test: nothing holds the
   lock there, so it passes with any timeout.

 Documentation/config/credential.adoc |  5 +++-
 builtin/credential-store.c           |  7 +++++-
 t/t0302-credential-store.sh          | 35 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

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
index bc1453c6b2..afd2e4f3ce 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -67,7 +67,12 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 {
 	int timeout_ms = 1000;
 
-	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
+	/* lockTimeoutMS is a deprecated synonym of lockTimeout. */
+	if (repo_config_get_int(the_repository, "credentialstore.locktimeout",
+				&timeout_ms))
+		repo_config_get_int(the_repository,
+				    "credentialstore.locktimeoutms",
+				    &timeout_ms);
 	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index c1cd60edd0..e1bbca3fcc 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -210,4 +210,39 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
 	EOF
 '
 
+# Holding creds.lock makes the next store fail. The error reports the
+# timeout that was actually used, so "in 0 ms" means that name won.
+for v in lockTimeout lockTimeoutMS
+do
+	test_expect_success "credentialStore.$v=0 gives up immediately" '
+		test_when_finished "rm -f creds creds.lock" &&
+		>"creds.lock" &&
+		test_must_fail git -c credentialStore.$v=0 \
+			credential-store --file=creds store 2>err <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=store-user
+		password=store-pass
+		EOF
+		test_grep "unable to get credential storage lock in 0 ms" err
+	'
+done
+
+# lockTimeout=0 must win over lockTimeoutMS=500: the error says
+# "in 0 ms", not "in 500 ms".
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
 test_done
-- 
2.54.0

