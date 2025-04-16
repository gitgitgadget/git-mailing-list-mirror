Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053422B8B9
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784104; cv=none; b=luQaf8LdNyy9LS6qUvAuqtRKcztJKjuOS+9K8roDeApd2ga0xOcnS0vOf4pSyDMfJqe5Cf/BXCSTBSiTL1IcFjvmVbSZiSmyyxFVyu0EQCTlaqy7BnotpTQPx8XhYoMxH7UWbz4h7rndCw9rtOzMmnG1KnQHDDAsET5UhK9Lu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784104; c=relaxed/simple;
	bh=KSu7NJGZbMVGEDJaOJy5x/aX5wJY+yygap6WXAHnh7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa/QBGmJP3l5HWggImXBX/sCpAixVkQ2hu7g7FeWOYxJX6FY4cHm/ljeFZ+tHJURug7wDD6ku6PbdfNs1LL9/1UxFHh8MOe4vnWuLd/KMnyXcrC11Wm5/3ffS0Nxu80AK4O2J7iR+17RbHkbXwliPKWOE9uBfwdNx0z2rABgj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0g4wgz4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0g4wgz4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so6510552a91.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784102; x=1745388902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r+EWBs+StbDF2Lyn61xC0Cnw1Oxidox9T6bceE0r6M=;
        b=C0g4wgz4PCKoZhkppK4vWRqJZaEL380Qhmo/rg/0SEULBRp46rZVy2Ziv6b/UV+Kfl
         +Kw5dtgQRmcObku+mnqInDQq6/Sig22BDsqLownmP9QhzZerFoaYd5yoWj9cF872UV4+
         5Yt66q6bGgjgen+8CjGpLzKKMlJjnyHjlRZyjg5VubWrtFhMu2UfuY2pCiZhWy92iXWQ
         EjutLnrYUx4vj6D9o9j2X2BZvuh+V3SRkqdIAW1nHDbTtiDI9pobjnAz/huuKUXa4Mdw
         hfHx9br6nDHt3GquBKA6W8NX9FLnSVTowZvQGE25VnJ8NF4yHaK2V/41/whqSPi5eJ88
         2u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784102; x=1745388902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r+EWBs+StbDF2Lyn61xC0Cnw1Oxidox9T6bceE0r6M=;
        b=g1jx0hVXx790JoQCNOfTAy7ayw7utlEh5LJ94F33MnvoAIBDdeWLAteWIKRoETUNpY
         /fOkLTlGkQ/+4y3NcLRXPQXkYJCy76Gdq5uvpQOY3Q6fvJNuc3L4aofaTmN8AdiQ2cwI
         Y1h1xFIzz80SHmKydYjJntTKOQTuuan7WVfnzH4EzpKg7Q0iwDDoT5BzAMPNplWQ8pZ4
         rEw0Cgiftd6/NFYJibfOhCaZ0FY6rfW8z969MYnAiGQJ9s3xaBXE5owWWJJ9jDGN94So
         LnkYrCDo4L215SuLO+aOy+cIoKmvE6gC8Ue73HbYpWKZ370tuKop8Yre+4DES+7U6rEB
         1EkA==
X-Gm-Message-State: AOJu0YyYfsk9jCn5VJerVW4f9IUdGAInqYlGT2x2UxAcUs0dAyFSITYQ
	NJxTLI9EbJEbmGRANNmfAiXWnEH77zIF+iyLAU63LT90zQ724+lasPtQnQ==
X-Gm-Gg: ASbGncv86VEyNMVT20aBTCh0cH9GYwQl61nWaDSjzK24gZbmeoxvNqbmDH6pea0SYlf
	qqDb9km3/sBJoDYpb5KIN9YbX/NThP2r+rzKbym6j94ozBBtknMUHTDMwhxaEEH9Er1epzUWFCS
	J6lQXX8T9xu6g6A+ZGwDJip87M+2IkDrH8uWcARsXlarnE1qKaTyWYV+9vQMnOlBnavz90rzGXC
	j0QjWNPi6Y4ti6W7xYHCp3VaXWe+WiMETZ8NCWQ4m7DCmOD9p1wkmcK0JLbynPFkexe6YUMLuYB
	I4e+jX2uXjCYNoqmkb53juV/ljEhg6MJQhIRL/do5jtyAY+xeoJ+Gh5vyw==
X-Google-Smtp-Source: AGHT+IF0C0D3rhf3uwxROcZl/hhCg8Tb5TNftktU2gFEXOcgYQcYAs0xzUkdLsjBXdn7KG8Kpw+l7A==
X-Received: by 2002:a17:90b:2703:b0:305:5f28:2d5c with SMTP id 98e67ed59e1d1-30863f2b72cmr1053480a91.15.1744784102092;
        Tue, 15 Apr 2025 23:15:02 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm1688603a91.0.2025.04.15.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:15:01 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH 1/4] Remove unused git-mentoring mailing list
Date: Wed, 16 Apr 2025 11:44:47 +0530
Message-ID: <20250416061450.25695-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the details,
about the git-mentoring@googlegroups.com mailing list.

Reason: This mentoring mailing list is no longer actively used.
New contributors often use the main Git mailing list,
their queries almost always gets answered.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ca1d688c9b..ef190d8748 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
-
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
-- 
2.49.GIT

