Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E44C62B
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820916; cv=none; b=C9Nje44AH8gHuR1jLcHgj5FyqMknclfE9w1Wjh4+6MaCJs+7L9xWGMfLCOCaaTh5+8ZZAJJiPzh3ej7xaRJqg2i2+FH3BSL9lZSqS9uUs7oWS+DdY1MeGRtvT1gy4BDIMKz69Ih8u4i5Y4RfmoWOS5ZEuFSr2bNps9xf0+hLidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820916; c=relaxed/simple;
	bh=IgU8PotYnsRlHnmBoaJnQZt/eIy5KRdziBxNHAO3kQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JER0G9HzgntYMu/HZjLxnzn4bmqYzWVH2gu1YKG5VCJDOFq1N9e1ZbgUG0VlohFUGAdKfho3zpV0J2Rzjx3cvM907ZnaT/oW/K/mIk/o3m6yw4QWVM/lqixGyIMBJLg0fqln6aTGu3pJ4bkpAYfD8Na5x5ugQsK9P+7X+Fb0VII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEqAQa/q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEqAQa/q"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so15800025e9.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726820913; x=1727425713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1p08nUdSU7jTzJOTCIp7Ga1VQ5VTUiYL4fFZVYZ7V0=;
        b=nEqAQa/qEVnsIC2psAq6zsgTwCwTTYmjaomXhlZuP68wi1QG1SwvCjFYxwy57MXfsK
         FILOjPLu6REC+Mvme5ZyTDNQrcToNgQ8aVGEwFCCa2KWGmtlgmRR4akX+EUzJHI2d/c7
         0nlXopZ/Zd2QcgJGI+272EKxAXDWNskNeMbXMLfDnAas3rkU1yh0294jmA8mPOTUENoC
         KcnzJLDvI3FZSl9Gj+TxdHknlWePMStUXiCn/qtgI89TuP6+u8y3D51FJSSisF1i5Zqi
         9K8m1ACyn82MRKj4o4M9NxeiSPoGEXgWTvy9hPZZODhPvmgoH1BD5jwpkNfaGYPhlzGq
         8zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820913; x=1727425713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1p08nUdSU7jTzJOTCIp7Ga1VQ5VTUiYL4fFZVYZ7V0=;
        b=kpTWF5+qkY8czSZ1TO1xmbqMd1F62iuzau5ItGplKO4Y6ngh8LnD4PHP/EWfmcXU89
         eQKwbaRWM3Lg6zvpZ9SkC5lybH6JfOJ4fb2+rJsVOLGnyjkWP4BK+GdNKQcf1Cc3ehNa
         eIlbQD1RxkWzeIkbM6+hAnC9cftObQOPOjYlCTyEUSL+PwIcAaNxBMdl1x/1oISBlCko
         kclHzJ43Tr1PnpE8w8F9ENkL6isv6tHITtrep9lqjWCvr7wDTbIiG8y0WjZALQuF5SKU
         /xcBv31mx03mmCOD0gK1aXuv8dtZAQ6DLCbcoa2LNuqTZRz7jXrTS1VC9TSdwToY5V1/
         pdyg==
X-Gm-Message-State: AOJu0YwDdqLhkOOrCXi0LqPOhkk5VvLq+w6zmdwGtwcYqzKEd/584nOs
	q/QI7wb93dX/iwToPqpqRLye5rF64Hs9TC8bGZi0gBepb6Qtxyw2PHocZpOC
X-Google-Smtp-Source: AGHT+IEKHRC9mhkP/89TQYlHAegAa/+n4ZXzPB48PcS7KoFrXZyEcNzfLWVY8o2TE0Hb5kOpfUQTUQ==
X-Received: by 2002:a05:600c:1553:b0:42c:b180:d452 with SMTP id 5b1f17b1804b1-42e7ac4b610mr14753575e9.19.1726820913065;
        Fri, 20 Sep 2024 01:28:33 -0700 (PDT)
Received: from void.void ([141.226.14.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm42514965e9.21.2024.09.20.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:28:32 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 1/3] Documentation/technical: fix a typo
Date: Fri, 20 Sep 2024 11:28:13 +0300
Message-Id: <20240920082815.8192-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/technical/sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
index fa0d01cbda..d968659354 100644
--- a/Documentation/technical/sparse-checkout.txt
+++ b/Documentation/technical/sparse-checkout.txt
@@ -287,7 +287,7 @@ everything behaves like a dense checkout with a few exceptions (e.g. branch
 checkouts and switches write fewer things, knowing the VFS will lazily
 write the rest on an as-needed basis).
 
-Since there is no publically available VFS-related code for folks to try,
+Since there is no publicly available VFS-related code for folks to try,
 the number of folks who can test such a usecase is limited.
 
 The primary reason to note the Behavior C usecase is that as we fix things
-- 
2.39.5

