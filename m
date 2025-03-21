Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114FBA34
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567435; cv=none; b=tQInezmBh7ldZOpjSm8VYNXNnJ3Lp5MIFgtzh/TJ0rd+9UviPAbIydRBc857RRN7Dd6wCs7TBNR1/yoAQvwe5w/f1ft5mGsMso0vXTNXG9bDbXmu01bSOeu5C80YIt/wHsDaWgcYa0jrJ0ByNxiBhUHII5KeVnTAT4XW0KGk7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567435; c=relaxed/simple;
	bh=l9E6zZl/5WK/iOGHklAZ2bvnyZlTBvQ2ss2cjdwOqHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF4za5tZn4hWdpDnznFZ7a8iiEZU9Ft1swLX6CtI3sQNm6rbEt+mWt+PanP3FyGqBbTitzpCbgEBQp+m4mNmtbMlrznumelGrl0DJpYv07lb/6edTJR2wF5bxlLN+WzgrgMrHo0jZqu03wI8n1Uw1k6urUb6yM1uN1oOSfgt2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDreDuBq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDreDuBq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fd89d036so39963735ad.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567433; x=1743172233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8jyhX8Y3f0nXFU/z2lTsaPEXCLRoENdVw1UfWN8xQ4=;
        b=FDreDuBqgwcUQzWLIGTPv9IkDX5NEkTf87RFmJdUQCGJcqLgiBvBNssMfZY6IcWn3d
         jXO5vLKMyB1o+EEjeXS3nbNgvB7swd6zL7ZSKytMSRWpMPXBjuMlHsL0d5cZ/53Vf7sm
         wmmvoTkezsayMJLPKAp4eXmJjzBPSmz0okwRsn/wSKn8AsRzsGbq5LFYTR1Ftzbe3zAg
         eawL5r8v+AP1y7MQbYa735jIRuOLa6V2PIZ3VKMZLJiHossU1uB2QoqbSXO+0LqKu/eQ
         GAQ35kyyquFK/DFBNn4hyCeQwId3ff+n7h0jJDVA5Vl1qO62FS6zZ1Jn0gYGlRS6OQwd
         XBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567433; x=1743172233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8jyhX8Y3f0nXFU/z2lTsaPEXCLRoENdVw1UfWN8xQ4=;
        b=wZ2udxZhKdkLOULRUu+uG+X8LH1u6Q8mObXW0CoUpB4pTAsG2ciG+AA5i9IeAYDMoj
         5n3dAIYjFRUVgMOZJB0XbO1OrdoU2ZVat3RczLCtuHmj9upjJp0uf4gS2aidJjohhlUM
         FscRoPoHodY+rC+AQDwCDy130n0T3zNPg+/txxxOKyAA41zG21CrC5U/UD/uGf8tC7bw
         4YaxJOMkXIHG/Xn2YtsMeBxHUmM7qzJhOlNZEKjOVH3H3H7T0rIfeswvE75kVD9IVL2d
         tPUV6nR7gJbFvMudkSKstsNO6M0hrqkahk9iPzUAWGd30oIG+sUvPL2e1P1J11UBMLxL
         Zybw==
X-Gm-Message-State: AOJu0YxjkJnGKUnGuCituykBPgPoRa83jOHf75eCE7dLHnuj8lUa59S5
	BcuyLnpfR1hoQG+bUqcbIM5zlINRKGx1D4ZX13zf1fNLLzBDHhjohy+yc0f7
X-Gm-Gg: ASbGncvoShHgc7p7z+BOmxGpMEetU//DKqp3gBGLo5TuB8pfD5akiXvclH9260gXEUc
	ocKaMhhgvQAnBd9FEoj0DVRrFS5aOcflYXrtp1+4Vk5/nbxrvf3mhtOmUvR1lSQ2hb3j6Y44u6H
	qwxx2mtnsf2Vx7K+XIiJ0FAAgp3BEWd/kdLWRD74S1JWeCSf8ZOpKthiDWIhC/sQizru3M6/uKT
	gV1sMAPCwlA/kn/81kLpOLORhHDwlVid3rX1jJusCwCkIMog27EetuK8NMODvX7+gMhOztLyvCI
	uBGuHWbT8QxbhU1s/wDAe/FEDk4Y7gi7Bs5rSd9F1mzma4X+hUrOJvk4Hcc2cZzJLJpkKvZnEe1
	8QWE=
X-Google-Smtp-Source: AGHT+IH0OCYSVinj4iRMvC8s88AJqhirZQ3Mr3I5GoDfSF7gf6vylHmdFroeqY7JcP7lVLMKUz0/ow==
X-Received: by 2002:a17:902:f70d:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22780e6125emr59024915ad.50.1742567432723;
        Fri, 21 Mar 2025 07:30:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bafabsm17054835ad.139.2025.03.21.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:30:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [[GSOC][PATCH v3] 1/3] docs: drop inactive mentoring list, add C prereq
Date: Fri, 21 Mar 2025 20:00:20 +0530
Message-ID: <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <xmqqa59evffd.fsf@gitster.g>
References: <xmqqa59evffd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-mentoring mailing list is no longer active, so remove its reference
from the documentation. Additionally, clarify that this tutorial assumes
familiarity with C programming.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index afcf4b46c1..7b856be41e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes based on comments.
 
 This tutorial assumes you're already fairly familiar with using Git to manage
 source code.  The Git workflow steps will largely remain unexplained.
+This tutorial also assumes you know/understand C programming.
 
 [[related-reading]]
 === Related Reading
@@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
 
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
-- 
2.48.1

