Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CC28506F
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930886; cv=none; b=DgKxwBcRGtQjyK72w/9Ih+GF8mkEmb5yydKnKJf0XvypLe9Ra6L79UPjokMc/KoovfJ9lm9MTPJxn9Ngl1lScVkoPA502xpCtGKWZKtbSc+mK2Q0i0TGADbfGcqPVnKyHyBuYt/dBffCCcpuPgZird7pIp2BecjMkYcbNWwEHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930886; c=relaxed/simple;
	bh=kcpw6NCqcUHz3W++8lLvGABSwZY+6gVQNX9AIGtUbxU=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=FvCdyZhuQOvPwdROT6z388b8cIBIoXbt6ue7c6DPniqBeCUJ56uGVcs/uNqD9lHlETox8Xk2BKYYSxqvTStwFqzF7CkWV6EBpe6c17GPURR74pUuLorZW4pqIpxRKR+7O+yXyzteMQfd04tNZP7BQHtrf7oVMnpbCcsJ6aSahTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxEqT+Zo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxEqT+Zo"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed861eb98cso6022921cf.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930883; x=1763535683; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ue5hVSc5IWhRVAM03wMlBFwZwBEte60Jx6NSu3fOg=;
        b=IxEqT+ZoqoYjqllWgh0EGNyX5tB+NZ5Ngi5baJolQ3mF2NhknwzpRWBwjLKsGWH/E8
         PvxzLU+4QxnuO7bJsdnjo5Tg9Ks1MkwCUIiEaxcHFPELBPFB4tGRniSn/QORglWXgcnW
         CcbK83GJhhHli4fQY96UALOa/TilKUAPrKrsLyD38Hc0gc0fmr2qY5S3njjz3zQ/BIcE
         vxzfgU+G7gbFXFkxHEYMPvsiPeEG+9k+tLDECJsIP/Jm9lw57YL1vqOsDHebCBufgWGp
         AWRjo6kR+Yvv170Rs694hF/ba3isUUqTwo89E7cxgs2trC/Mk58utkUf6COcevqrq9Xb
         tKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930883; x=1763535683;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ue5hVSc5IWhRVAM03wMlBFwZwBEte60Jx6NSu3fOg=;
        b=JX2HVt8XMO3v/Kd+JpKRpcUF1SPDYJizZsS9ckhEyoeWBua3+fqVLLFDVFdYzTTSq8
         sq6tD07iziyQSa2T6k5UER9u3eej5NtLyvdViHiSurIeSXTrAwMxwpuXojugqtndO3WC
         oECoXrQPF2vAM1z4magi5td6xGgrHBKV38QoAVfyerMgVR4A9TOVW33PqsHZed0Q5vUF
         z66/ulJcorFgRvQdDLrS6NVStJ04tKQK5+hPfrQS5S5oq6IFOy4EEp5KvBF83AiUF70t
         VaRs2NxD6kxpszhCXpepFTUOFsFS54RL99jFZHVzU5TwT2RsdOFoVELdmtlHDaWn3//5
         RqPw==
X-Gm-Message-State: AOJu0YwSrqCeojjfmlAcrzZlRvwQ4PMKx33xRn0Vb8SP0Ztl7X4V/0ZF
	vYKgt4WWYhfXUnrW4aQnvLf+CjeKV86MQFe2sFS3LvhnYzY/oFwH4c2nv3cPIw==
X-Gm-Gg: ASbGncscw+Hv335XHEKVI7BomQzxG9p5UeQFPF2c6Wtw0IRbksyh+XJHK3IeOZfmKEN
	nH0/+irxWbCKFmnQMo8O765ADdiyqPXYKa4j9yRbhFLr0zwzjxf644Nc/3plRnFuKaAxRJjUf+3
	n6DQYEb2skLjowbbHFFqJKBFraeZCoJ7b2zgs1gMtfsF7DdbFjggVH1gO4N+wInjaYdrtLwMrtJ
	S2l9exLX9Hxz1fHJ9CPRyPn8EWxOs0CwdQ9VBduXG+kYIbiPBT2ZfFUFEQs5bHIwjkBzHkJYxlZ
	tioC4m8HmzH21qe6hj1PV1wm8ur10xOIV15l0tiJpMUhUTmlUChWmkWas3YQGx5s/5oe7Fh1wxD
	PKGNnM6rN199T582/CqCcRuy2jqTuamEguxWFrlbWJitG4Iztdv0XhzQOSduTrcscp13uCmqUIM
	dcCw==
X-Google-Smtp-Source: AGHT+IFnGn+TH6D5ED1cj+k2c/PzMmZzMH6BX7ZMQr9BHksF4/qDGcO8zReAgNfJoNERxnD70AQQnQ==
X-Received: by 2002:a05:622a:14e:b0:4ed:b4d2:bb10 with SMTP id d75a77b69052e-4eddbd9b07emr20664541cf.55.1762930882644;
        Tue, 11 Nov 2025 23:01:22 -0800 (PST)
Received: from [127.0.0.1] ([172.174.165.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238988d8esm85527456d6.20.2025.11.11.23.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:01:22 -0800 (PST)
Message-Id: <pull.1998.git.1762930881599.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Nov 2025 07:01:21 +0000
Subject: [PATCH] Revert "osxkeychain: state to skip unnecessary store
 operations"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

This reverts commit e1ab45b2dab51f94db9548666dfd7af626d2aa7e.

That commit was trying to skip to store a credential returned by
"git-credential-osxkeychain get" by setting
"state[]=osxkeychain:seen=1". However, this state[] is kept even if a
credential returned by "git-credential-osxkeychain get" is invalid and
another subsequent helper's "get" returns a valid credential. Another
subsequent helper (such as [1]) may expect git-credential-osxkeychain to
store the valid credential so that "store" cannot be skipped by just
checking "state[]=osxkeychain:seen=1".

In order to solve this issue, the state[] mechanism can be refined or
"osxkeychain:seen" can encode the whole information of the last
"get". For now, let's revert the change.

[1]: https://github.com/hickford/git-credential-oauth

Reported-by: Petter Sælen <petter@saelen.eu>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    Revert "osxkeychain: state to skip unnecessary store operations"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1998%2FKojiNakamaru%2Frevert%2Fe1ab45b2dab51f94db9548666dfd7af626d2aa7e-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1998/KojiNakamaru/revert/e1ab45b2dab51f94db9548666dfd7af626d2aa7e-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1998

 .../osxkeychain/git-credential-osxkeychain.c          | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 611c9798b3..1f49ab8548 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -12,7 +12,6 @@ static CFStringRef username;
 static CFDataRef password;
 static CFDataRef password_expiry_utc;
 static CFDataRef oauth_refresh_token;
-static int state_seen;
 
 static void clear_credential(void)
 {
@@ -172,9 +171,6 @@ static OSStatus find_internet_password(void)
 
 	CFRelease(item);
 
-	write_item("capability[]", "state", strlen("state"));
-	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
-
 out:
 	CFRelease(attrs);
 
@@ -288,9 +284,6 @@ static OSStatus add_internet_password(void)
 	CFDictionaryRef attrs;
 	OSStatus result;
 
-	if (state_seen)
-		return errSecSuccess;
-
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return -1;
@@ -402,10 +395,6 @@ static void read_credential(void)
 			oauth_refresh_token = CFDataCreate(kCFAllocatorDefault,
 							   (UInt8 *)v,
 							   strlen(v));
-		else if (!strcmp(buf, "state[]")) {
-			if (!strcmp(v, "osxkeychain:seen=1"))
-				state_seen = 1;
-		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do

base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
-- 
gitgitgadget
