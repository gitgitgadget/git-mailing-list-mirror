Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5A3C1F4B
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927033; cv=none; b=V0DT5/8uNZ/6xPnLXIgX1YElAOkMgESNP1xjAa9MIeQf3kfdPqedWpfc1KGhXWERXmTR+86eOikxcqOZwN71M+81H/rmqBF3GmhLPIFeyTMmmqhR1m6r6ROzVoHEg528bN1OG/xIQgfVbI2obbG+U6bCUIp3Do7nCB3hwicBPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927033; c=relaxed/simple;
	bh=jPLIu2KCxj4VntzfmfbUKF9K2lKhai+oMJBVsZFRxXY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q+A9kt+LyCNBgo+m6NQ8hrSOwZKkLoqhwp+YnYRE3LPmDAe1KoL+6uUSxmjfnOfdnqgK4OsyMEihiIn919Z2Wm6k1g0VC05byPmFHeswhGoKZ8ldMSMiazXOKL4k+6HMrR2gwQp2OavXP7Havya0gEIAxKBa3KVW7cWKPD6bXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg1I6ktj; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg1I6ktj"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-660e9ea23cbso2119658d50.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927030; x=1781531830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffXPbMX+9vdR+7mSi7lo9cx/t8f3UvQrZzrIzwkAjx0=;
        b=hg1I6ktjVTHccTrNewdzkoGuouduJCRqj+GCVT7RyW9dqrLm56Qs9Pn3y9hjJ76qW3
         fIEprkIhQC1A8VbO8Z+ECI2aetZecSU60Q8DXIdVDBPskJDb045LEWUtWnohLOiU4sL/
         Iyc4JcuO63o3ZMBZ1UQCR4iqmOKeTHdXdrMAG7q3JWV8H9tlVYtbR7N1m/PCEWePSV3w
         AtXqxkSa36UIOgZz7Sn1HPyshMBU7Dn5QIKs6e+PEw9SvODnkbWpHAcasWR8fANpwuaf
         kyHQ5S6M8po6dsk0gACxnvPnDkwK84XQVpBdoqUNw7UsUfcqgRMyv94MFu1WzlI5cPW2
         wZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927030; x=1781531830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffXPbMX+9vdR+7mSi7lo9cx/t8f3UvQrZzrIzwkAjx0=;
        b=KKw3i2XSa9tfESUlNuaDaYdika2LIV7k1N8gQGVMUUss005BHIMyjisza70GKpanVz
         fd2qcyUjTlwfHWV8Kr27H27QdiGLe39L8XqCMXcg57d5vR6tu22HfUIjrgUZvct142Ra
         FFJ5fM9+Fa1/jhQCXyugmicT3EgswlDWzLPM93chXdUmBWcqLEet4xQjp1+NPK+HADS3
         ev1DxIf0YyCJ9Q+zZb3l/fkHVjvnt6Z1AJnr6uEBNeawNbU8tNZwz/ZzE/kS4m4pGZvo
         nXcxWHlwnulu1Gg3bl4VfYoCTQM6OqqakaqY/NcyAXSdz4yAoA27o5qM2sY/q3kl8hQU
         blPQ==
X-Gm-Message-State: AOJu0YzWs7jrta6iHgySbAKqea8MbY9ppzsZ3OSQ+ipOMmebxVmOhUMr
	d5/NmP2diDMkvJuYAafG9vrUa3WqIt7VYJAkZGUS9yUH0sqjcWkUTLjv9Zzdig==
X-Gm-Gg: Acq92OEc5NtkeH5gvay8vV1mzGCcoJmJu22aOQpaM1euBHElqnzUeOzmsc9k7Ewe2FV
	905qJMeo14c411O05iAGj+MDjMlj3bkU9i4CcZLeCmjGF8zL5F2uIC5GTbUSc9HyC9t/ANtXvbq
	ZI2RKRA0EbpPvY8P5VGGwr/3CtjJligHLYGtVnt8LoP8iq5ruqMWdC4HAMmisILXsA3BrxzDnC1
	Tur8L5/aiQP63Y454tGTycxtGLcXj5eh8EMB370StoY0p8UNr9qYpfbiy0GJfa8ZIVtUXNbGsnS
	fiP3cPnPiAGDQVjiNmH2Ad38fKGH1Acn6f6aGqCIT7r6TpX/ai5lLj11iwzCaiFsw6bBB10oXgz
	FiMIjmIblnTpx89m6ltibIrVjo4G30BjDApPKl9VN7wgyTsCYAoCfuGyZk2BXzduoHcKUx+RFAi
	pb8RIURr29jPOaR32gJI1++b2il6qUhFyuDUvv6g==
X-Received: by 2002:a05:690e:134e:b0:65d:93bc:dad4 with SMTP id 956f58d0204a3-66106fad5b2mr13103950d50.52.1780927029747;
        Mon, 08 Jun 2026 06:57:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.210])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d64409e9sm9378191d50.15.2026.06.08.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:09 -0700 (PDT)
Message-Id: <c996ef0b06faf83ffcc4559833a31d0e529a1905.1780927027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 13:57:04 +0000
Subject: [PATCH 1/3] git-config.adoc: fix paragraph break
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The bulletted list about environment variables is missing a '+' between
some paragraphs that belong to the same bullet item. Without it, the
bulletted list is rendered as two separate lists with "See also FILES."
as a normal paragraph between them. Adding '+' unifies the lists.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 00545b2054..044d776613 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -476,7 +476,7 @@ GIT_CONFIG_SYSTEM::
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
 	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
-
++
 See also <<FILES>>.
 
 GIT_CONFIG_COUNT::
-- 
gitgitgadget

