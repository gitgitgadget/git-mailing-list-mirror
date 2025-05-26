Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CF1F4E48
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255623; cv=none; b=NnDrpVTYZepbl1AekQK8siyLC33hvg15cy9d2vW+7PhEPQ7qf3XlcUY8xkD3en1LYTzmjrwrNDB1qYoAwAd/za3lEuOWEcOnvOU9AnrZSEjZ21/NUcc6fUUXUjIE21b+hB1xYyxnDBw3FpkWWh2MngZtt69jdKx+mJtXmWUCiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255623; c=relaxed/simple;
	bh=ykg2cLYMnSCfld8+ZYPK2TvwpQCas09KaXJBqem//9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/QPRq3fTYfwsGVTcIdBeshEQSG8A+1xTXTEhQwHghd7kjGovosIM55eChjx+wmcRa+CIB6jgVskQhiEC/cSX2yLbw6yx2a5Y6SeDTJMmtHcHGzpnmDDRt91B2OhCXnZW1WxWDoMa/VNt8LtcArc0WSad4u7kIH6jUwEkwNvrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0vSZ9Jz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0vSZ9Jz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so14204495e9.3
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255619; x=1748860419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3JgXwKJDNifj1Yet5oTI+H0cWgDMNLJhlFyGgVwMOI=;
        b=B0vSZ9Jzjpssikega8IsKoTiA+JriebmDF/z99FEuOH5tkiVuoDBXlfDXm46iKrbpv
         ugGO3VLDmV67wD509L2I7SajINwmqsxmZpY3LKAb36roLfKKX6xasydQwFtgiyTzd7u9
         5XbHoJopJWgF2L1wjquHdxeQVm5Txm4NtEvAcVQQ5DOIq8IhBSUq5B2e8JlITKTr2nzN
         PH5hrXOy3L2T2mPEJ1XFEpRRrAs3nJ4fGUoInD5nPKf3wqJQx1+DPKtAK02YxwRDgoNW
         SPJ33s/SNqGY2jPKnX1QmC+Cla0/uvnXSN+PIE0GnYTVGUs4XbkmA12mDB5Hkbm7RRVp
         NJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255619; x=1748860419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3JgXwKJDNifj1Yet5oTI+H0cWgDMNLJhlFyGgVwMOI=;
        b=nKmWN1rHmNApeV3A2zUvF7ujAoKUJ9cQfdp66KXebbNcAnsRS28a8amHwix1m75dhU
         WUFiIreliUNe152TGHInTR6NprFDxqShwQqZ/HdgGjS0OIUyzuvnkClaml2MCoGL2u3f
         nhJR5MKsNtdu7AVwBvxch8BhAlqO7JO/90BURwtxQ9D0PM7iDcNHse+EwhdkcIIY9rkz
         c+mwJ8a7E9lIhkun2fyZeXVTn4bwRdBIFxnZKcVCEbgC3HFMxNFJAMC0gMNgJh/uovfp
         vFKI+Y0CSNslqDUzOEuaASoJxFNhGM9iBjLE1MhKmy/2qynJxz0cBTmx9Ob5LDGRvtdV
         OBFA==
X-Gm-Message-State: AOJu0YzsZ8OGz0Qb3PlSkPWMXMqFeszViZVus5+ZCoE5a6C80D2hV+GS
	T3VGia3Oc2eMVl5xU8i81ZL7f08W6PtaC7Rw0x8rvI10fj7+7bN6PBcx7UnjdsUJ
X-Gm-Gg: ASbGncu39M4qahXfMGQMlW7hpdnfIkXy+6ZRS8G+d1imiUkyq5yoL1KL4pq3iJi0NPy
	VBaum26BCT93Yy7E33waYSIMOD4ACMeqovKZVxbM3UJZJDyoyLtcn3TV8kBupiqlrioFayU9zPF
	qbpc+NY05PDS6cmyN0OcU8TtHoG2dgvcfve58cCodMne9eG5mtcg+u6IKJzE1xj449u2r5yGJoz
	27Mml2AMXjYcusahANvwhCtZ7ZQCGfaOKkJl7hSP67B3OrP0kcQwCmTMgHHXGPT9X7ZhKYclKTC
	TT0unngblst7BJdZdThkD0kOrt+gbPAzQ8yfBCl9Hfu6ISc4FS4RCPHqMJnGJ1ArNS/9Sz1e/GF
	8P/RYYI+m++BAmPbQC8o6FatOB1+aTPu+R5EEC0ysps/thbE=
X-Google-Smtp-Source: AGHT+IHZN0DTK55bFnJPxemy9J+s8pgMngUVChQtsWWVmftaC2gotto5UCv+8iExO3tg8icf7fWTDw==
X-Received: by 2002:a05:600c:138f:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-44c94c2d54emr69862985e9.33.1748255619175;
        Mon, 26 May 2025 03:33:39 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/6] gpg-interface: use left shift to define GPG_VERIFY_*
Date: Mon, 26 May 2025 12:33:10 +0200
Message-ID: <20250526103314.1542316-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "gpg-interface.h", the definitions of the GPG_VERIFY_* boolean flags
are currently using 1, 2 and 4 while we often prefer the bitwise left
shift operator, `<<`, for that purpose to make it clearer that they are
boolean.

Let's use the left shift operator here too. Let's also fix an indent
issue with "4" while at it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index e09f12e8d0..9a32dd6ce8 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,9 +3,9 @@
 
 struct strbuf;
 
-#define GPG_VERIFY_VERBOSE		1
-#define GPG_VERIFY_RAW			2
-#define GPG_VERIFY_OMIT_STATUS	4
+#define GPG_VERIFY_VERBOSE	(1<<0)
+#define GPG_VERIFY_RAW		(1<<1)
+#define GPG_VERIFY_OMIT_STATUS	(1<<2)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
-- 
2.49.0.609.g63c55177e5

