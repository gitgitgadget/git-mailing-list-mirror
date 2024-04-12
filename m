Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B750A88
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911881; cv=none; b=AtmKyZ0IE7MLC1b+psRaZ8fdhhulhgz6pzfwOWMPfYkhOx2hhrCzxQlCtd0QVAUk96gGUxIgCMGt8vRotCMDKY59Q+zfWri/EZqFjmnlrD+eQAyDHNr2HnCyQEGp7bF7FxD63r6KPxCZ5M65ToJDTcm6QK8mYU+mEUJGpqY0Ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911881; c=relaxed/simple;
	bh=mPgyD/coOPB3d3ot+bHbImHuZBJeKAfg5ougPNm4/0Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XhqyTqtFpzTxBqojCXJk1nEfpa0D28lVuyo5rWs4gUjwnuAKPqRYFmuZpWGHkqbM1FNqFYWsr6XeTKi6CP3T2ISH2VFbA+oTruBu5mP0Dm6PXmOJ6tVpKPlPrQYjhdoYxLk7ob/2OXjOXlGXTFPhlhvDSox1zVkyi0NiEMBiaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H12hYQKY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H12hYQKY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417d0194705so4864335e9.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712911878; x=1713516678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u2mU8/g+SdUvJgT9C8Wm7+mtQVywsK7JIFt5ITEVH6M=;
        b=H12hYQKY0OsYQmKwJa4nJpCJiTvoYhtbD4A9hd+SePVs/1NEt+WM/e/LC13QyMZsdF
         zVC+5b1g3dRfJw8EfYYDjEZ+dduLqm9577du9msb+3XzMBDvEmB1VtwbrSMTYcypRCnT
         LEN//ul0gYPB3G9WAZdI6rMJY0W5XmbR3VIPVcCxUuMWoxp62YQWsoCAo2W3TQeA8APx
         P+qoFNQ7T5sySOGJGfU6/OlbQUvZupq1Ha9i3vwoN1l/LT9aYnvs5nB5xgtOyeL4RRQu
         HjKEnS8+lKmQENyRgsk3JGfbjoz86sLLxaEjYMlZEpHJ1U+8g8s+b8pvV4FSraaonbBZ
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911878; x=1713516678;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2mU8/g+SdUvJgT9C8Wm7+mtQVywsK7JIFt5ITEVH6M=;
        b=tqJo2y6cHWNxdIGepXlG4yxrNsnWRYnZH3lUZ15qDx/MV1UaCFB+QBuItfMAgN99Xy
         GuhBMMHglu7jlSOKQwIFI2JCiUB5hAMwUFUjzeiHKf4iYAlePouoReq0M0/AAiXWn9+P
         dQkLtx5kVzNsv4eZPE9TjFILXmOd3l2cMD5Y08Thyo0cM4iB2bF0grGfQUV68NioJKFB
         yN3OCqiMKKE/UCci4L3SfWWHvgOUh9gYUvtsFEfRsTUwyMXXaIojUK2m+tTwVnuXhgua
         OTFw0PPA1bhKf55isPHp4fZg8Czp4S62sDzFMKUPg/dpzrGzfzhrRpVnAf9DBBfNdB+x
         wklA==
X-Gm-Message-State: AOJu0YxaRxOMvfDMPlVbkHhAXz/1oqXbbG/LKlvn+Bao3vQe35MgB0l2
	FGe5Hq6BCnDz+bIncmrVhIkx6SDqQbtYJTUGbDO+nQeIHdaK+7NH8hf8wA==
X-Google-Smtp-Source: AGHT+IG1DpaqpShpnPRSv8eo5Kq0laCL6pWuZ+EMaJ2k/CbqVwspxj6C42ofGfVRogeCDqLGyBUVdA==
X-Received: by 2002:a05:600c:c2:b0:416:c63c:5f74 with SMTP id u2-20020a05600c00c200b00416c63c5f74mr1647851wmm.18.1712911877957;
        Fri, 12 Apr 2024 01:51:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b00417451f4f52sm4976670wmq.33.2024.04.12.01.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:51:17 -0700 (PDT)
Message-Id: <pull.1716.git.1712911876943.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 08:51:16 +0000
Subject: [PATCH] Documentation: fix typos describing date format
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
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

This commit corrects a typographical error found in both
date-formats.txt and git-fast-import.txt documentation, where the term
`email format` was mistakenly used instead of `date format`.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    Documentation: fix typos describing date format

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1716%2Fblanet%2Fxx%2Fdocumentation-typofix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1716/blanet/xx/documentation-typofix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1716

 Documentation/date-formats.txt    | 2 +-
 Documentation/git-fast-import.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 67645cae64f..e24517c496f 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -11,7 +11,7 @@ Git internal format::
 	For example CET (which is 1 hour ahead of UTC) is `+0100`.
 
 RFC 2822::
-	The standard email format as described by RFC 2822, for example
+	The standard date format as described by RFC 2822, for example
 	`Thu, 07 Apr 2005 22:13:13 +0200`.
 
 ISO 8601::
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index b2607366b91..0ccede255ea 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -303,7 +303,7 @@ and some sanity checks on the numeric values may also be performed.
 	with e.g. bogus timezone values.
 
 `rfc2822`::
-	This is the standard email format as described by RFC 2822.
+	This is the standard date format as described by RFC 2822.
 +
 An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
 parser is accurate, but a little on the lenient side.  It is the

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
-- 
gitgitgadget
