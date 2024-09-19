Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E71BDDB
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770897; cv=none; b=Y/wLC1YhJxr9B7Fo69FtbKdn37OCT7KoxKV6CtYUIs5vE2k2CB7tVs+9zECvfppX/5KZ4h0YgkqKtLzrj99j13ThBzuP1jsjWiMyCK41r9+5TrHxqzKunqYfVjvoFpXyfrPJz4qv7eMe2Y9ZilyDdko9vhGrOmt4vz8TRAirFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770897; c=relaxed/simple;
	bh=IJ5y4KN8AK8EXYwSJqFd3l1X3QZlCJR5CGurpN7nf1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bYFOMubAY6twFRPIfLr/CndjIbU5ZrxgPn0sW7RUGnxM1FmGZPMIwImBmcAOemnFbkkMjnm2StQsLeuzA0gfhxlY82/cg7gMrZb/7PLV0225OygJmavM5jphoq/QLolmUH4Z2SVoc7MfhikOyhRuVfWGu+2vueehH4kgCaWPE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHop9Jzo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHop9Jzo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso1564467a12.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770893; x=1727375693; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCeGLH2ZioJbTl6shmLbUkJiRDQ3GKFwSJFKIpDui1k=;
        b=iHop9JzoQ7nr1wT7dViPGEVwBeVYa/0RmMIz97JQmREdRzh3vWmh8WCYn/6MlcuHz9
         aponLh22SOdesbNpmzUEaP4AIuDnA2HO2YRX1fvJXwkO7q1D09i1daWdJBVnrXID/Tfc
         8XNVOZ7lnqxaDZO1fFlKiGsdtch7V7vfscgjbABWgH0jUjQJL8w7Eu34jY+Yrk6WvTpv
         wwaMoJdfvzr8MAfHqtI5bgyqWcglJ5zowipHHVSUanVagIC8R7jWZajnoSUOSSLpABc/
         /hCZL+4plBuZy1U9Z53GIM1c0OxrBXpqPftAh/caSqMnwtn73v6ho98RlBhiD4wH4wak
         Vznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770893; x=1727375693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCeGLH2ZioJbTl6shmLbUkJiRDQ3GKFwSJFKIpDui1k=;
        b=K07vr2RtMgQUpAS9eqjiRkFb5pgWvNsa6xRX3FNdzxB3TnCPnGgxB6n/pbHsV/4LUG
         9VYN/qG3LlXanGM356a+AY2PNfUkeIi6PZ1iM9o78cF8BENLzcYqcjP5k4LNviCvHPr+
         HGDux75OHNnjaCJCWLTMt3n/2FeOyNyCY+S/JXXXHhSzTCIy7ze4BsAH4gSaaOSrymKz
         tG06I5QBGc+cHjYL8Pl3UpZBNB3QL8GO0zTCX5jB+Mv3wToGAgm50bn8rnInszOqOb4X
         Ra0Fg5vTeKs+IdjAF+vQUDispq/n2bSb7xrWfVWtZFNJBWLW38FsZZEy9XAFN+xJdu1j
         Burw==
X-Gm-Message-State: AOJu0YwMlLFriauEZiw/N0NtJo4qvB9Nzf1dzi+LyEKm19uis9q7y2jV
	jr+iLHy5bIPHfPHif1fKRXPXzP+FehYsj5gHtWHcPq1WphrpEjL0X2fAHg==
X-Google-Smtp-Source: AGHT+IFWOPHI+caYuDAq/fg0NWtCwqG6wY2Q5g4QM1fPYXfq74hcQuuum8JGA9HxqOjDb3hdGjsxTQ==
X-Received: by 2002:a05:6402:3219:b0:5c4:2fa2:93ed with SMTP id 4fb4d7f45d1cf-5c464a43a9fmr146559a12.16.1726770893210;
        Thu, 19 Sep 2024 11:34:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e2asm6268098a12.73.2024.09.19.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:52 -0700 (PDT)
Message-Id: <877bbf5c3904c2453b4dfe0eed6695fa3fafe063.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:30 +0000
Subject: [PATCH 10/20] object-file: fix a typo
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
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index c5994202ba0..21266429817 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2275,7 +2275,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
-	 * end writing loose oject:
+	 * end writing loose object:
 	 *
 	 *  - End the compression of zlib stream.
 	 *  - Get the calculated oid.
-- 
gitgitgadget

