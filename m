Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FE55C3A
	for <git@vger.kernel.org>; Sat, 11 May 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428550; cv=none; b=uGDjZhFJv8t2X55ZFad8WQafstZ5fe4h9IoVcFMVh/U8NDYoZzZNOM+oqjT41TX6TqmClc86UrdiPZHBSWsYaI1Mgf1vZX001fWVUbwnupJaMBTu4wigaU4qkbtQF3Ap7kMwxTK4QDQzJvgXlFyfxXVgOCb2x/WmBoyY1Tz/GAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428550; c=relaxed/simple;
	bh=lTcW66YseaS4uN1g0v26CaZU2gTUj9WeLcBNfppHZRs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=msH87Q7RTWpjNR/TRcq0wAIw0swEPbgsI0SgZmbPia0jJRBmQQ+7W2lFQwe/d01dYm1OHhI3lMwPw7iOtteI6b8AZPO5AFmXE2Sb2vOKuprPqnEM+oaooFjHkjfbmMMmQ/L0gNCB/d+ZDtXYRZddRkpoWDI9hBWxeXL5i5O1/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAzzYXkB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAzzYXkB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so24848271fa.2
        for <git@vger.kernel.org>; Sat, 11 May 2024 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715428546; x=1716033346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YuZT1y/Y31QfffiCYXo5KOJ/HGhEUx5LPuxOCidK2A=;
        b=YAzzYXkBX41vD1p6CB9WUpUUjFHaLGrUzsdzu/QXNHUx94cqju9p+NYhhG9nFahec6
         KSOFn6o5tIFjdM167dYK35sqrrk9nFuUqjD1TDJHTsZaZHkqnj8q5D5Vmsk+MCAi0R0q
         F1SLgFirlH7co8kR8hVsSB5QGCGRxpsbcBh2kz70QacbZhtZQK14xL6y/II1F3rfGno+
         RtyFV6Vfv5qWnyDHWSy7e6PC0PNiQg//EsF2o+A4K8cluOUBYuEJrSHnge0fSwAnkm4S
         gA1kixgot3lEGoOr1FjFbruJLA+/Iw87XO/2YA39/cHakS2ux7gqYk40WVjog4Td/1l1
         Edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715428546; x=1716033346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YuZT1y/Y31QfffiCYXo5KOJ/HGhEUx5LPuxOCidK2A=;
        b=TVbgBR018KXT/mENebIjIE0humfboy8tTekC4tnEXLCfzM8Oe2rt7pMAjzrycZPoeB
         SKRAAHK/E/4pPtu1rYGchYpAVn8gT7D+YasE1kyf0Tn2r4iog8jebzM/2c5dbVwDbVt6
         5i67mCNdF/qWh7oye2X+CKgsG0VPlzZCRnx+kyO4ZFVfzCjZF0E/8RxzXM//saT9/LdZ
         Hr6rTdxKplZao1QhCh7R6lsXmFXIRcc6TseZwVHxK/c3AuQW14v72AhPbPEhCi4KQeN9
         cudcWrC9Oy2npcbFafZuh9UecTPkovxJw5SpPCqI8nMxbKxKR9QKF9QRYCEbhEUjtPti
         MgfA==
X-Gm-Message-State: AOJu0YwprnwCTY0ZzFFCnf9WTMF26jFWoA+FMMymTUx/WBmFEh6wEE9b
	QLU8C/ojEb7qIu6BJM+rG0c8dxSjmTMCvRhaAjMxPKvzavgsPG8+3a2CqQ==
X-Google-Smtp-Source: AGHT+IHL55UbfVdCOw5g/ybonijRmfQsVXVU2bhvpOrg86ACN5tECSak90lbFBa3fvYXoXrFeKfzzA==
X-Received: by 2002:a2e:a721:0:b0:2df:c0b8:2dd6 with SMTP id 38308e7fff4ca-2e51fd4a071mr34124231fa.21.1715428545605;
        Sat, 11 May 2024 04:55:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010ca475asm14356735e9.16.2024.05.11.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:55:44 -0700 (PDT)
Message-Id: <1f57718abff1d0e234c4145e833424da7be79311.1715428542.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 May 2024 11:55:42 +0000
Subject: [PATCH v2 2/2] osxkeychain: state[] seen=1 to skip unnecessary store
 operations
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
Cc: Bo Anderson <mail@boanderson.me>,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

Records whether credentials come from get operations and skips
unnecessary store operations by utilizing the state[] feature, as
suggested by brian m. carlson.

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
 .../osxkeychain/git-credential-osxkeychain.c          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 0884db48d0a..6ce22a28ed7 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -12,6 +12,7 @@ static CFStringRef username;
 static CFDataRef password;
 static CFDataRef password_expiry_utc;
 static CFDataRef oauth_refresh_token;
+static int state_seen;
 
 static void clear_credential(void)
 {
@@ -171,6 +172,9 @@ static OSStatus find_internet_password(void)
 
 	CFRelease(item);
 
+	write_item("capability[]", "state", strlen("state"));
+	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
+
 out:
 	CFRelease(attrs);
 
@@ -284,6 +288,9 @@ static OSStatus add_internet_password(void)
 	CFDictionaryRef attrs;
 	OSStatus result;
 
+	if (state_seen)
+		return errSecSuccess;
+
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return -1;
@@ -395,6 +402,10 @@ static void read_credential(void)
 			oauth_refresh_token = CFDataCreate(kCFAllocatorDefault,
 							   (UInt8 *)v,
 							   strlen(v));
+		else if (!strcmp(buf, "state[]")) {
+			if (!strcmp(v, "osxkeychain:seen=1"))
+				state_seen = 1;
+		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
-- 
gitgitgadget
