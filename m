Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B5208D0
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770887; cv=none; b=emlsV/MZ985/KZwZQkGPyr1Ai2EvTGgyqErxkpYd3arnCHCrGB051FpWhDzLHrASOm26dX3Gr03Q95n0+vppqtJ1LvtXH7o8ZbRMjxXn11DktbPrMfCU2U6caRWvA8dVe+G82QdXeMZei37DJFHaM/zb2eXXzDDdvScBk95Yt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770887; c=relaxed/simple;
	bh=4ovyVg+pa2WktLEDbnlAg+WAugwtIFSwniycE8OvhOM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qJIog9ImLJF24uBcvnpuPW8rwLFAn4U1qOd4DeJ5tomIIfFB9JslKEqpN2yMSiUGIGxjbKvAMDiw7YE5FJYmp5P08q8XOFFlOTrNmz5KNOuEzd7/NTMHm37jTZfToMl75QKkIDHdiiqAc12R0s/gFFykzLcW5yTzmfqAOQ9mfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJHYxDpJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJHYxDpJ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so13286751fa.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770883; x=1727375683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbpZB1fCGbX5jwup70jkn5fMTVqwfXBuzU6rzECK6XQ=;
        b=LJHYxDpJwzZz9Oaulg1cFNC6q62MF49kkstsuOG66Jyge/U6Fh6Me/gAZjqd6TBoIC
         KH6E8GQB2WsXphyCEMfomCj6Oa4uFxlW4gHkEKO7fb0bYb7PanaI5hXblyaAMV0yjquy
         Qe1MuJxzPTbKxnCAKzEHtyLpjYQt2A63xxBFPkEvXrG5/g4LnjuI9G5EtdkTsDbmu1mC
         2Jd/CWJyCzkVHAVovniOAqrfquYg8/L+oPQ0IO7+2LnZVy7kdyDSK+K3Ywz1NUGovcKU
         v6Atg1NTfMhF6DrF3CoFhGz1HEDc7SWD6jUWsyeDkdSvEGc6+QGzf8zxicjqMdDQpwXi
         53QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770883; x=1727375683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbpZB1fCGbX5jwup70jkn5fMTVqwfXBuzU6rzECK6XQ=;
        b=unz3m6et52kXpHZn/1/flFgqwvyEMXCZ+/Sz0FHQ0vZctB8jhPVq8itjWaAqCRkKu/
         RrxMoRipURIka2v7wV6dkbvT8sefI2CJaWlscdWV2rhmDlIp3QV/6EemOkJBlWkw+/C0
         oduvXqnU6qVLWwGisSTUIY8qkTz/xdR0l1QLnS0u0qP37grS0Uf7xSlSXTHjVWHSEW5i
         5KX97XZrVK/uRma5AEXWOP+wrRsIlk0zlVhnZLIpANawfauIag/T7pRtR+q84nzAXZ0w
         FlR53/CbPnGSEybEK1GS3mz5LP7iHQFGzvOy5E/roSBeIkOhC11cXIxYyjLr7peRTdkN
         ucFw==
X-Gm-Message-State: AOJu0Yw45Sf1vZS5eJvTQLmEpJcjyVyrMY+kvV3yD6MLIFbkSdCO9V0y
	XCoZr5sgrXSDeyL+kTyDvnJ5I1yfvOl9TmeOyustq78Q2KrIEsu1Gn6FbA==
X-Google-Smtp-Source: AGHT+IGnOJhNrreKN52J/6X3Qm3JhpJJ2aZBSLkLrrU+3YlNKjjJ4W//3kXbe/iBgxjM7HW54uLH7Q==
X-Received: by 2002:a05:651c:198d:b0:2f4:f22c:53d5 with SMTP id 38308e7fff4ca-2f7cb2e6944mr3828981fa.8.1726770882933;
        Thu, 19 Sep 2024 11:34:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb535ddsm6341036a12.25.2024.09.19.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:42 -0700 (PDT)
Message-Id: <588327a291d95a0bae01b41316f271d98809db24.1726770880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:21 +0000
Subject: [PATCH 01/20] config.mak.dev: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 config.mak.dev | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 50026d1e0e8..8eca7fa2282 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,7 +69,7 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
-# Old versions of clang complain about initializaing a
+# Old versions of clang complain about initializing a
 # struct-within-a-struct using just "{0}" rather than "{{0}}".  This
 # error is considered a false-positive and not worth fixing, because
 # new clang versions do not, so just disable it.
-- 
gitgitgadget

