Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC1205AD8
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462726; cv=none; b=KDZHo+RxEghPJPdVqao/aHjy7tEkGivrMYzdJR0oUzknVUyW1cTjg4oDPGFqyroZfgPKko0TIFC7+gdEgh/2bk03uk7k+s5uSDBpCV5lPwJ+k2l2VZil+h3lP767GfX23yqV3t+jUwWLx2lHpnl3mabRzQQ3ot9n8leO0SqYMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462726; c=relaxed/simple;
	bh=13mQWn2BtJi8fimxoNZb0Yt4OH9s8NPHahPscxZViSI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NoXA5AhLWnnynaI/FRzzp2br0BwVeqrEC5W0D++vKyJ37XkTK5lPGd7V7tPgnL9+wzBV3fyNXzVxZaqr/V/zxhntFHcceZk6FzD+VaThF+pJf1Qe0795MFAmbj1JY5PBz/Rv0lruBU9cjjAmNYRAkyMKZBIWbu44GnMArfEQQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXmR7SjG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXmR7SjG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436345cc17bso11609555e9.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736462723; x=1737067523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cg9VBpikgzxcLKTC7wpNCTDE6i+qsYfMIfiAJLPhbA=;
        b=TXmR7SjGcd2OqyqtQEym0W17LWxnMKNdYSG/uyEsW6BPkvpoKL5jo6numwe7FjqTDN
         pDN5HvB7aKuaz8p0QgHOEPruWlf8PxNBRPPoIaLWlY+eJKvu+IGfMh+VMNJT0NWSMKy4
         vrVLVyHzrFxhjRSyZZeduI2S4RC2a0MqIb2PUlsXEJcnlvHDsRfZGKIRNQvVi540Z/3J
         OLcEn575jQhyiHiBsMyUGw1wwRWD2sX8byErzMYbTEHbbF43GLa6jWoMBzsS5RzvJ92Z
         b8JVju2UC9lDJcwcZh8Ejay7QvTsB+UU8Y7E/ZQWKX2ZLoosxtTjhZR/5D91ry7AIJj7
         0jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736462723; x=1737067523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cg9VBpikgzxcLKTC7wpNCTDE6i+qsYfMIfiAJLPhbA=;
        b=gQUdlQ51j5XmyuvEk+eBcTnHg58MezGufx4udT+BtS8bqVV4pTTqWZ1kwsUkGre4s/
         asXwfjXvZC3DH96Q+H4ET5foaw/44x3hCowlllozixNga3v+L4OrAgIVVUs/qVFYnZCC
         nz2N07XioKLH8rfeS7XLmgiCO8tewUI/hYTmHziF+7oMdJPFqCj0p/wWJQiyou+gspB6
         IbJEEwzOU++X9wqG5m70i6U/hf19y3/dMixUbzE1ESscp34DSUM85YM2OF3XP6sjZW6w
         eO/hfvzV5YVioR1dkZKqCje2D1/rzUVWOv2dqeZlx5m5tOonilqxFbXwSRbzGHZkGZIf
         7CFw==
X-Gm-Message-State: AOJu0Yyij3ZR+CKVApVCl9FhbLbTIBj8Vo1as+5rYG6GuNTyz/adCyN/
	OBaFVTV0HcOdSTOBG+R+6HVHQk6uYjC9OpFUyrKJnV7O0eNjrFyy5KYwUQ==
X-Gm-Gg: ASbGnctPwc7PWGgO25Ec5dlQSXJYOL2bF7h9EQsw9kwbLz9peZVzo5cL3Ayk1fyknxI
	/HeoEvTgLvJ66RsiPdXP7AxMGtbP6yDGaerM2hOFT1AwUV8n0MYFwRd6Vj6h6aRYD1poVm3kLkj
	36Shj70dxC8qgH7e4BoWbrCUM5Ium7Pr2+FoTffRm+LfKBhIZaookPJr7JdsV0Ec9or28Nm7CBP
	b7avb9ixx2rdvEa1VmLk2QRrcUKY66aFlLiOGYh0duo7HotxTXoi7s+Bw==
X-Google-Smtp-Source: AGHT+IH18xf3wGVx7S8hApIC+yHR65mTbxG6LIfhU4W58cl28wDdaDbmMZb6Uk+j+CrWQ3C9+ceAmQ==
X-Received: by 2002:a05:600c:3114:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-436e2677361mr76210005e9.4.1736462722649;
        Thu, 09 Jan 2025 14:45:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm33244745e9.35.2025.01.09.14.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 14:45:22 -0800 (PST)
Message-Id: <pull.1842.v5.git.1736462721156.gitgitgadget@gmail.com>
In-Reply-To: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
References: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 22:45:20 +0000
Subject: [PATCH v5] credential-cache: respect authtype capability
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

Previously, credential-cache populated authtype regardless whether
"get" request had authtype capability. As documented in
git-credential.txt, authtype "should not be sent unless the appropriate
capability ... is provided".

Add test. Without this change, the test failed because "credential fill"
printed an incomplete credential with only protocol and host attributes
(the unexpected authtype attribute was discarded by credential.c).

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential-cache: respect request capabilities
    
    CC: sandals@crustytoothpaste.net CC: gitster@pobox.com
    
    Patch v5 adds details to the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1842

Range-diff vs v4:

 1:  23942f9fa47 ! 1:  db575d9d116 credential-cache: respect request capabilities
     @@ Metadata
      Author: M Hickford <mirth.hickford@gmail.com>
      
       ## Commit message ##
     -    credential-cache: respect request capabilities
     +    credential-cache: respect authtype capability
      
     -    Previously, credential-cache populated authtype regardless of request.
     +    Previously, credential-cache populated authtype regardless whether
     +    "get" request had authtype capability. As documented in
     +    git-credential.txt, authtype "should not be sent unless the appropriate
     +    capability ... is provided".
     +
     +    Add test. Without this change, the test failed because "credential fill"
     +    printed an incomplete credential with only protocol and host attributes
     +    (the unexpected authtype attribute was discarded by credential.c).
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      


 builtin/credential-cache--daemon.c |  4 ++--
 t/lib-credential.sh                | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index bc22f5c6d24..e707618e743 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -142,9 +142,9 @@ static void serve_one_client(FILE *in, FILE *out)
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
index 58b9c740605..cc6bf9aa5f3 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -566,6 +566,21 @@ helper_test_authtype() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) gets authtype and credential only if request has authtype capability" '
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

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
