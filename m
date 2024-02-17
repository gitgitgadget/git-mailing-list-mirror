Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C380042
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212903; cv=none; b=YCUAOvGCyp/qqVrdkZS/yo6h172NzE+zbpgEMkuKVWaqLx4i7m1zz3/TFuYsN1lXDeZzsV206xTh9VPuwqeIpkbx5LlsqIbdYoHhkRu9cpDH1PFIpp87g0REm20yokb0tDyT0X3OaCm5nOM/JkbSsS8CfwlTHYptUUCd+rkw2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212903; c=relaxed/simple;
	bh=gs6nnzFRGCUkPVsUkhaMnRYwHqjo2+l7oRX6zD+wDCA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jKl3olQOMXwn1/RoRmOeAHWRGZWAPENWFMKxKjoZf9w5oMqEX9H0TeFzDLCDA563U8JJeSvc4rstWSp3os9zazvGEHyJrnqYYMuIAWeqNLanFHbPUwuDVGJJlmvRwUQ1xVv3orlMXXk3yO9/kvUM0rfSY4hNxMeYuCW4tt8Q2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBSRwuMg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBSRwuMg"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so42894651fa.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212900; x=1708817700; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym+cgvQe/zgPnTgRyIPa1VB8AyqUW1kZLwDJyJ3v8LQ=;
        b=nBSRwuMgDyiwCyI/bEJxI2IdRmj1An+2jb5xPIVQ7nDaWLqOqxQ00fwpvrtrAiuOIA
         kGe8cV9kxCODXR47EjvZRxj+R7YtyUuD/PJahIielEU4XLiw1XpCTSkDPnj4omNXNlpc
         E6TMsaiSX433MhSQO0uf+ouMvJ8bNJTK72agmNM7hQRdvpjydvu7bTs3mFza4SfgmN/A
         QcICEWMxkxoenqcMBPvmHlLwicrNgYIdAPmYUTWz0NXXgJn8mJGvNa/MYVkDGnyElf5u
         Xr8ahf2ilzjNJob9ebpAaP7+v2k8baqN4P9sBTMHSO31/Q41sCbqZgMK+jQ1dY4105ge
         hmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212900; x=1708817700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym+cgvQe/zgPnTgRyIPa1VB8AyqUW1kZLwDJyJ3v8LQ=;
        b=xU5N3OV7A6TC+zWS9N2hjUWW6boH+B3A+hYa4zezAoMi5MVGW3o1/yjVz7oRXAHRF9
         UJkmT4ZokIs+p6/ByNcIr+6qu1ZWbYaLYlHbZbKZFxF05X5iDolmr46frbwqitwHdGg/
         yGz+tGCPdxXVXBoysK6EwK9P15+FAKGGQrNzhLVZX22P4dtEgLgIXWe21g9CnTmYh9iw
         fpitiJrGLlQSwggdW7k6dIH+9GC7NI/k//JoU/vr17uTpl4AaABYZflUi3l3JDw55Avl
         wl2T6J3qcu8nWWsXHttPZkmPbbgh6Qv4Yd6cQJLLeqPjVpAu/Hs81WAl84jLdrHmnr8J
         LboQ==
X-Gm-Message-State: AOJu0YzCjUZHi/qO77dXinnBTHLkZSoSt1XNKapnTX1e5HmPL9MzAW17
	dm7aJqu/mJanW7sMfXpR+fSaXiITQx8weGmaXc/npiJr/cENvJgtKEgY9Kj6
X-Google-Smtp-Source: AGHT+IGOqdFw0koXGOW2RicQSx6s/ASv/ePU/i1JFeXCvXZPHt4wbkFpjFFbglhcFxgGNbE0yZHMDQ==
X-Received: by 2002:a2e:2243:0:b0:2d2:298a:dfc8 with SMTP id i64-20020a2e2243000000b002d2298adfc8mr1431561lji.47.1708212899488;
        Sat, 17 Feb 2024 15:34:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b004120537210esm6460538wmg.46.2024.02.17.15.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:34:58 -0800 (PST)
Message-ID: <08284fa8e845e28da3c9a85d06475d5fbeb5cfcb.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Feb 2024 23:34:54 +0000
Subject: [PATCH 2/4] osxkeychain: erase all matching credentials
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
    Bo Anderson <mail@boanderson.me>

From: Bo Anderson <mail@boanderson.me>

Other credential managers erased all matching credentials, as indicated
by a test case that osxkeychain failed:

    15 - helper (osxkeychain) erases all matching credentials

Signed-off-by: Bo Anderson <mail@boanderson.me>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index dc294ae944a..e9cee3aed45 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -182,7 +182,8 @@ static OSStatus delete_internet_password(void)
 	if (!protocol || !host)
 		return -1;
 
-	attrs = CREATE_SEC_ATTRIBUTES(NULL);
+	attrs = CREATE_SEC_ATTRIBUTES(kSecMatchLimit, kSecMatchLimitAll,
+				      NULL);
 	result = SecItemDelete(attrs);
 	CFRelease(attrs);
 
-- 
gitgitgadget

