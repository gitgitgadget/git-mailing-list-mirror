Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930F3009E8
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718404; cv=none; b=VBZlBzAojlJNwPlPKJ7fuwKAa0ygn88ipLR1XcWBfezgoEUsWlByr7O8XIxIPXIvb9hT6gN0sD0ua7kj1lZGMbYdQg1nCBI8nwdtrCAQWtYJOQQqxyfzyUfVPnwd6J39EwQkmugGUAslhid8Msf7XjU5Kvizhu7N1mBspGAWRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718404; c=relaxed/simple;
	bh=HcyjotHM01uDT5QWFcQejox5PJZAKmwDpPPq9k7rU2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mwE6Kr5z2mXQgYunf7qeIXVwwtKMcNQZq1VlfmcVc6H1rYxUwtetyeCJnfbiRgzS2mblbOtTU4ahwAYiB2Ik5pZLGLtSC95W/FU9Nymlx5VO6ffKl/VIHilVfTmQ4Al43IdSNXF5vAuMgPX3GBP7T2AKqLYQI7gGwtXrNmHFzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpSzlLLB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpSzlLLB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c9f6b78ca4so401982585a.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718402; x=1772323202; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM3vCqKYzvIlj5sr9Vc7buwqW45ez77hKog+NPxKRfw=;
        b=dpSzlLLBgQdEx4KqJELPlzF5A2b5SGIsM4sA7qb/WQ4ntsxFXMzT9l2BbvdqZ2gC/V
         RUOpOb/K9ieVDeqU9ar5af9M+Ux/bs1T2SsvViuSFRfUGeSrGyVuAdmtEU7uTKOgg1Ti
         hfAVEVrhntubpaypvyS28GqrC9CaufU/t1ehjB0VBhZrnrjkDzkMwvdl/J/Ret5HI6ig
         Obo9rybvbHPWCZ3CX+dIfzp8uR4Zxit7f8fAFkgh+ZZDIFabQz3t92z8lNeDZF338gPU
         g2VwJdDdXGVcBc3nK0XXOAkbwAqvWi6CDU1fkFk9Q9FkUtVkpxW1625S7jBx1nLux88B
         lBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718402; x=1772323202;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM3vCqKYzvIlj5sr9Vc7buwqW45ez77hKog+NPxKRfw=;
        b=O3LVefs9Il9zHn7/Vgs4u8/fUE4OL37MJONzwxCn/5p6c2q/lRZeZL+0V2NsZUWMrc
         rEvyFFK6gj3vl7EXs46jOSuu64K1yuOgD5uC04y0gZC7iuppiFe73Aytz2u8/BZGQXmL
         9lxrgWA6GQM4PIaqNJ1ziVexIjd43np/8Ko4W/kQ8sbYeUeoNtAsb26zkFgfZRoh/yyL
         cv7Y9+bpn/LM7/5/Iw6MjnFp+Xi7hUoFPgNKysNwEWRHilibu4A1qozYSEevejY9MpYm
         2ba7aA58AryfD6tZMFs9m0Ra9Dn/OD5V3YvYwonzEmRlhdTJe4YLPC2Gr7kAGGj66zAe
         tdMQ==
X-Gm-Message-State: AOJu0Yx4bOjC3ROF5dpLFL/XJ5qfZkyYhN2Wp7lOsStUbvPxTfKwjuNe
	8fd/UlceTj+6kO134qab9hFaSPXnEfjSBggXuPm8OFbUVKtgZblVNd4xAubUrg==
X-Gm-Gg: AZuq6aIHfORspljF4PcRnc+HUZacuvfdqd+taYyvfCgpUdrOfADi9tvHV1C0xqfahLz
	2g2zBquBFtTIAWw2sjT/ZeyfCrvxssLuCCmYbFN2lBR78fxHNlYA1PhATdAzAvly6rXK0qdSHTX
	AjLjJM6q4bH6exp2wh7e4z0Qt+n2k9NKejXEbSMhOq2Bw3bfOhfa4LZxUyljygL71ycXBqOjEPx
	UbLhL/aH6aA2tNYUs7Q93P39bCfCmg8CY21J/ARVSiqzuf2G3LKfxvNoLyV1KgQVAydboIQ95ls
	vzX4iyYivowbBA84uDblWAjjoe7yKZP5sH/kh+LPn6prJa9TD/crkUXXjKvVxnc+Cgyt3F6/BjA
	PHEm+/GZovWRkD+ftAXztm4Y4U5lQ0raikPVr1OyWh7j9Kjll3sOILVNsw7fWfwLz/Getx+FvCJ
	i9viPVV7AIprP4LKrBFkE7/yS4
X-Received: by 2002:a05:620a:319a:b0:8c7:10cc:758e with SMTP id af79cd13be357-8cb8ca6e517mr558847485a.45.1771718401930;
        Sat, 21 Feb 2026 16:00:01 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d064007sm340799685a.19.2026.02.21.16.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:00:01 -0800 (PST)
Message-Id: <42a25768784492a4e8187bad0b070ccb27e980f7.1771718393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:52 +0000
Subject: [PATCH v3 5/6] merge-ort: prevent the_repository from coming back
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Due to the use of DEFAULT_ABBREV, we cannot get rid of our usage of
USE_THE_REPOSITORY_VARIABLE.  However, we have removed all other uses of
the_repository in merge-ort a few times.  But they keep coming back.

Define the_repository to make it a compilation error so that they don't
come back any more.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 60b4675f39..00923ce3cd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -53,6 +53,14 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+/*
+ * We technically need USE_THE_REPOSITORY_VARIABLE above for DEFAULT_ABBREV,
+ * but do not want more uses of the_repository.  Prevent them.
+ *
+ * opt->repo is available; use it instead.
+ */
+#define the_repository DO_NOT_USE_THE_REPOSITORY
+
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
-- 
gitgitgadget

