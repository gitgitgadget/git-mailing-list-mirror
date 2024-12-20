Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363C1A3BC8
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729539; cv=none; b=a6EN1mHOlIH8iRJteDCZdw42jugDSt6c14JIt4M1lU0IWCJdHL00dnk+EErbhKB6yGo+h03vidB1o/axYhx6xRWqe4+Eml+bf/0yr903qN5eNgZ5gzswp5fRQIq6CelGp+dy7gk3jgTLMLXO/tDG0WxJiq3LvuaKNoxLQl147M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729539; c=relaxed/simple;
	bh=HVFzylOfubuJk3WMmw69YKrceURP9O03D8EOXwQSe2k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=i7b8uiDvspcLWkWangIirnl1z8Q2T5u/ITH7BFOihv8Vzn8QIi3xukkl5bQY+0ClIzDresyDIm7uuFLn/eZ+qDjU7wVsFyEM3/kBaTeUG0jOz6f8arQXHbJRlfygJ5xhiU0Zc1PHg/Oasv1drEz1k9u/rShWhAVPAWHyH7Cl544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6lp4whh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6lp4whh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4367239aa86so1947905e9.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734729536; x=1735334336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N+3xv52r+5Bu8KcGDJvsNg64ZYKRe/R2ggem4hL6fqM=;
        b=P6lp4whhoBF12ZaEeQDcSNjn546LDJv51A2TjAvS+YXM4vbEpGw3QKG96/q8KLBMNO
         n/CAOEOoX6B0WgyZztkkwc0erXq6/bnKzRiW0EwiYlIiqKJ6ruwvuJPxQGXBftaW/PnM
         gh5PqNkmwbOq41tA2FunzRTmmwewZA+HYXGMjbRAD+8qrxvAHoR6bpSodRZgjBJHx0wm
         h48TQX2TytyWp67wySGr8+/Rw/F1GYh1glNIJ7xEtMIrUU/wDo8k5Do12dD/8aUdUHc3
         NG1EjbxKzO27lTMeUJClf15Ynfa1jzS2Kx/aFtpLQNFAiVTOEUCIkdGbJ3kzTU7hc4uX
         jSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734729536; x=1735334336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+3xv52r+5Bu8KcGDJvsNg64ZYKRe/R2ggem4hL6fqM=;
        b=OO03TgjM1urTSr1uSkzQzXHSTypDGwSapA4Dp9cNVtN55pAiui5vEPfWfzvnWkdP80
         ICwKrneu891cjEqBUzuSZjEZR2u8AKi6Y5IVkK4RCr9HiTbrECv9WbYxyXiMcnvd3Rm9
         ErAxTtXcTRJnkQSJCbtw2Ualy2SGW6kRYdlZo5wsERUYbd1Ms1raqTt/ZuCJUOSaBsNj
         BfgEW0A1lzA+VKZy5aDtiu7MgM1SynsAq8nrvnOcRL98akW0EfcVlraLadBBvR88uQA9
         BaXjWsCi9ctfcR53dNbtjTvGsIeB0MrNgE2Nd4/r7Qjvnwxh4ZSPJN1qqBcGb9FI0K9m
         z5Nw==
X-Gm-Message-State: AOJu0Ywzj9iK3xnSgLYO6j07mBzL05T5nbAU6qJCKAtbQhuXBZNxZnc8
	0upe5FviMfcVBuaeYzZdtViLQFJhV2kdP+WA6Q4YEXePeTTm4ZGV4IaTFA==
X-Gm-Gg: ASbGnctYKSTBYawms1+fdSde8ojP14eBiNurX+AHL3RBOv6w/sqMvYZA4gXUUWxfrUl
	VvEQrlrWEd16EUINgbZAS7Y3Unwb349QJCmoHcsiXymmsYFcZHeFDrbFISk5xD+Yi64AEptuHEJ
	7ZYkD5Xi/k6nsNHyy+ubIoelJs7bIfcVlgrmFAEIA4WQmFG74uGa/yZC76HErMI8whmKqjK+u/Q
	06ox7ILl+un8VN9R/t54N4YqMt/5IMObYYoS4ujkPWPb2msMkQ/DWSaJg==
X-Google-Smtp-Source: AGHT+IG4keE47QJ5teICyVxNkd6erZ/QdWaxJMALlUJpbp+zV7O80BNKV/fXTaSL3qgAeyL6kCMswg==
X-Received: by 2002:a05:600c:19cb:b0:434:f335:849 with SMTP id 5b1f17b1804b1-43668b93637mr38749795e9.29.1734729535603;
        Fri, 20 Dec 2024 13:18:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b0532a6sm114144695e9.1.2024.12.20.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 13:18:55 -0800 (PST)
Message-Id: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 21:18:53 +0000
Subject: [PATCH] credential-cache: respect request capabilities
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Previously, credential-cache responded with capability[]=authtype
regardless of request.

The capabilities in a credential helper response should be a subset of
the capabilities in the request.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential-cache: respect request capabilities

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1842

 builtin/credential-cache--daemon.c | 11 +++++------
 t/lib-credential.sh                | 15 +++++++++++++++
 t/t0303-credential-external.sh     |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index bc22f5c6d24..692216cf83c 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -134,17 +134,16 @@ static void serve_one_client(FILE *in, FILE *out)
 	else if (!strcmp(action.buf, "get")) {
 		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
-			e->item.capa_authtype.request_initial = 1;
-			e->item.capa_authtype.request_helper = 1;
-
-			fprintf(out, "capability[]=authtype\n");
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE)) {
+				fprintf(out, "capability[]=authtype\n");
+			}
 			if (e->item.username)
 				fprintf(out, "username=%s\n", e->item.username);
 			if (e->item.password)
 				fprintf(out, "password=%s\n", e->item.password);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
 				fprintf(out, "authtype=%s\n", e->item.authtype);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
 				fprintf(out, "credential=%s\n", e->item.credential);
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 58b9c740605..fe170b513fd 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -566,6 +566,21 @@ helper_test_authtype() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) does not get authtype and credential without authtype capability" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=git.example.com
+		--
+		protocol=https
+		host=git.example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://git.example.com'\'':
+		askpass: Password for '\''https://askpass-username@git.example.com'\'':
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
 		check approve $HELPER <<-\EOF
 		capability[]=authtype
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 8aadbe86c45..437eae5002a 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -63,6 +63,7 @@ helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
 helper_test "$GIT_TEST_CREDENTIAL_HELPER"
 helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
 helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
+helper_test_authtype "$GIT_TEST_CREDENTIAL_HELPER"
 
 if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
