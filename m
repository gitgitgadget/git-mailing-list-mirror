Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631E2594A5
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212767; cv=none; b=Q8YJBTlUN1skQEJLmPGaUMR38pcW8SQcnCiP5M2b5spUXSSGETmHy8KHjfzFRKl/11qVry3rE/av8cYUKN5ObHZf62CDPP4u5CF2cwld0afjNO3TQCYe6kxqnyOt5I7LZQe9bs5XUHtRt5bNIa4WjQHER+w4FZZqC/ha75otFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212767; c=relaxed/simple;
	bh=LBPTABoVcB/NJh34q1FpDoXtaf0sz2NwD6UM0bHAcVg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i99BaDVQCqHYbu7Q2dG2QSNFA+MU8mUyRZz1o5D8cTxpoKuGL3kgPeut6v+mHtaz8TufbYJyB7myavA4IIMD+pr4O6ShTMlkL+6fNzHAjA0/BX4VCUdViDwn7mXffv+psoEIzfB53CbfYH6pAFThk9C/mMdk8aqOPBv8JAHL23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQROt5cu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQROt5cu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso99893485e9.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 17:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736212762; x=1736817562; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCOTCxgzV+LV6GCs30R+lFk6brPB0v014p4HxfxaaGk=;
        b=WQROt5cunufLizsYh1KWJPV2TXfiLfFz2tCxcNCYJpuuFr5oPb4qYqB9jPIcpYhD5i
         3jk34g0Wdh7LZ7cYVtr0rn4sx2GJ53lwSJHFVru5rg4qaRKn6lbePZOFBrfAGk4zc2Yd
         HFmu2cGPyr9gfpF0BsM/gQ6bPGU/Or1ZZei9swtfczr2KIUWpnN/izo+hF9huyqFA9UV
         GT4dCe4van/YG8TIl/HQJWYJJovkOk2QfaEn7qGDT5Eh6IIix+XjMu2L1lA50Za3QGlF
         qGZwpMKN5AOFvMA0LM/EhSJZ+HADeHCuHk+9JhlbfEuIqZVyS71adB5l3HGvjaAy4aLI
         C/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736212762; x=1736817562;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCOTCxgzV+LV6GCs30R+lFk6brPB0v014p4HxfxaaGk=;
        b=tmTdbd0AMYTe57jrT9e6Dgqz3xfdBkt/OtV3oBAxlTV12EjVfO+lsUWL1RFj78yS+Q
         ZYvNJvvoD7OL6P2sSDN1pVwLO78d4N0PbFAVGAuktG5Qx6qjsaFS7uJru3v8M+LeI+WV
         m5WqmsIzCPHf/tNGtayW65uIX59BSdALrS9Nx2lC/0G0pRJf43RCNoStE8pdtRQpnDzG
         oPRfJcp9NQ0qZhpyIosJT4qUZh/wp9GLs6cBokQQC1Di4R6u/Q8my9QljAnYc4QuIqZX
         Xu/LQf7+BxUzhnlvNcvQ1TwHCSyMVKhNO8ruY+1jxJFn99qmQIJFD+nIyKZyndowH48V
         VIYg==
X-Gm-Message-State: AOJu0YylxSi6q8WP6+GwYhwXaJoJAyHYOdHdvkvrecIjN9WqZyRrJgNU
	1ziBEzv8kcn435ADz4gMpowjKOcVd83Rjz5o/V42Ncw3sbDx20N2QrDlWA==
X-Gm-Gg: ASbGncuud0blwpKws1yRrF9yOkS9P1hZ5wTsq3vrPspZ2gnllzad7A5u4wNsp2DKyvI
	VQnbWvyvz5yVURcsFvQZNAQHfSWdyYd3XsxLZ6akl2wzLfK2zp9dPUR6qfTuLuHBdMS/nfGZbf1
	3KZmfCMa1tLMuNCT9nVbi4ndO3FA/hSODR/9h3iowqsuyhmKTdLVj4aQHaHeJWMmdOQXMH9SAmK
	e2BMvhegfnIRzKxPwoyRXBhwYI7/gLENq8QPJMyf1iGOvz3BIVKCwQUwQ==
X-Google-Smtp-Source: AGHT+IGH4eLOq5O1LWOWEUEVNfilJjY+8IE5z492v9BrEle0fMiIcdjLwRresfzwhPFBRvxo1l/sQw==
X-Received: by 2002:a05:600c:3b23:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-43668b5f3b7mr446849135e9.25.1736212761853;
        Mon, 06 Jan 2025 17:19:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611fc161sm579213865e9.10.2025.01.06.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:19:21 -0800 (PST)
Message-Id: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
In-Reply-To: <pull.1842.v3.git.1736204756030.gitgitgadget@gmail.com>
References: <pull.1842.v3.git.1736204756030.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jan 2025 01:19:20 +0000
Subject: [PATCH v4] credential-cache: respect request capabilities
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

Previously, credential-cache populated authtype regardless of request.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential-cache: respect request capabilities
    
    CC: sandals@crustytoothpaste.net
    
    Patch v4 fixes test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1842

Range-diff vs v3:

 1:  e9851c5c4ac ! 1:  23942f9fa47 credential-cache: respect request capabilities
     @@ t/lib-credential.sh: helper_test_authtype() {
      +		protocol=https
      +		host=git.example.com
      +		--
     -+		capability[]=authtype
      +		protocol=https
      +		host=git.example.com
      +		username=askpass-username


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
