Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D821F1932
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480888; cv=none; b=egF8pqoS+y73YcOq1GFWZefv7Cu07yJWHlKfShFO2MG8+yuNtRNWTwkOMqF0e0OjV7Nsekw2vErf62r6lN6VjNAqO9xwoR51PICXHJEEmk2AixL96BjMh5qkLX973d0+aPWIgGCDxX2Eru9AvLVkWTMsqmqT93L/J7wEN0PA1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480888; c=relaxed/simple;
	bh=HmsWv69cPQkPOBSnTaFWILphnsDWaw3WgOKjDS9RtwQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=skvbmoAcO4seUwPCp9iKEAcEdYnGIaG1ZxSLpshxO3N+q/XT+gbCUiJPRlu5YiKl0lRJfRgWBDdC0uFYLy9fyw26tLk0g68wObHSVHkYelVYc+d3eQk/vTNySShoy8sX51sCU5ayMCzVuCo9YzammEtAdgj0ziteF+FP23sTdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvZKYPv6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvZKYPv6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f0e5e36912so1464366d6.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480886; x=1784085686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h13bqto2Pab1aZKKptXYvGM0StAyaNXcTJzQ/1Qogpw=;
        b=UvZKYPv6PhZUU1QQFdrW+/fgNRUt/FwtukScRribC3qLMPZJt1TtBgGYTv5Kgh21Oq
         6fGNqdJbn3UpKfnHDo7ZndCx/DdrakVwTIAnpFRyHPLMlyoWYrP/6wboBY3Y9F9s0Fo/
         AjHzvhsZ95loJ9WktwjQbDX8CDOu7wgoW1FEzqVUbHWG9w4lJX0xrP6jlCg2AM8HbPkG
         tJQdIDmxXEC2JIzmZYMpPKdjgjIwWQWE4QuMSvsJ5u3up/jXPGO0sOSPVprsXf/oZqxt
         QVW4Y09oPnFdannRpySjXykJFrty+zDr10Pv7CeZWuKjc/IC+FDj0NDT4e0M3id3Qqof
         K2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480886; x=1784085686;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h13bqto2Pab1aZKKptXYvGM0StAyaNXcTJzQ/1Qogpw=;
        b=MviqQNmyM5hKloqTC/yIpyGzfipjl9yeE7S0gMI3UKGfDJExo4dYJnv7Vsa6SGBOVL
         5/USPuSG9B48AuBNaK/nmHXMDEwmG7l6WfeZx4oDesVyvlqigslZRN96v+exAmLYf28p
         ObbxnI6lZIYLkuDyfIP0+GqkQ6ERXD1Ga5U3wP1W+77WhTQUhr+ipnZl1sXBe2hYfVop
         jZyHbEnXKAlSOWm6XhusZzdgMFuO6LVZZIGCA+Wkxd/co67CpKA2PLUlIEQVcvSStkpy
         MvbMnovIuzt3VEyVqpwSdejC43ecWYMp9qyp7fesQQalvirn+wDYAMhBob5XaYccFyOO
         elsQ==
X-Gm-Message-State: AOJu0YyzN8VeAKGrIRarh8me5+VgtVhB48TwJvz9NZFr31Ld8sr0jC84
	KHcSNlhwqo81RJSir0XUWF1mY6nvYv2VkSRjMdjWoptfv7KbKMcxvsTVOdmTH8cr
X-Gm-Gg: AfdE7clXcjYaIQmo8VZ1ibOA7wbGEpqCJHwScSLqU+2iebHqgUsCntRm9uD96ybgcPN
	PJtyNRwQdGWK+hFKVDeQuC+TKv1vWWfT/fDaNfJmCa5gsu90RvFIEdQvYWlBeimy0OmGmZWJSSh
	JapZ5WFoITrrLQRoMagUj3IHlHjWZrQv2BsTy0zANAFUYxadQu++3Xpw0HKNECk8/uUNVO3FPYQ
	4eEnz+R2Yk0rzg4CzPfk9PDvlaqU84G44bLitAUKvKTPZ/R1k25Xp8z9l9yCZ8mDQzOBXirc3CS
	rVof1mRYZwJN2vSV9jJiGIyvuJAe4TRfMxvoe87h6srIUHN9SyOWF9kFC0DJGkRVGtaeZ0VW7HQ
	Lkis+m4CJf7lwjGcmRFjxIOJmRI25/ba5pQ1jxanlMSiZw1H6Y0yRh+72vUWmzyaK/zuon19vd/
	ISNlAb3+8Dcnq5AHJyig==
X-Received: by 2002:a05:6214:449b:b0:8fd:6e12:970d with SMTP id 6a1803df08f44-8fec47de45amr3668376d6.59.1783480884992;
        Tue, 07 Jul 2026 20:21:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f74c399a40sm114666686d6.29.2026.07.07.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:21:24 -0700 (PDT)
Message-Id: <5659709ab4193ee4a63ea7f51cb7eb1b31fff5e0.1783480879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
References: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
	<pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 03:21:19 +0000
Subject: [PATCH v8 3/3] contrib: wire up osxkeychain in contrib/Makefile on
 macOS
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
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When running "make test" with TEST_CONTRIB_TOO=yes (which is default in
macOS CI workflows), $(MAKE) -C contrib/ test is invoked. However,
contrib/Makefile only invoked tests for diff-highlight and subtree,
meaning git-credential-osxkeychain was never built or verified during
standard CI test runs.

Add a "test" target to contrib/credential/osxkeychain/Makefile that
depends on building git-credential-osxkeychain. Additionally, wire up
credential/osxkeychain in contrib/Makefile under "all", "test", and
"clean" whenever running on macOS (Darwin).

This ensures that running "make test" or "make all" in contrib on macOS
automatically builds and links git-credential-osxkeychain, preventing
future build or symbol linking regressions from slipping through CI.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 contrib/Makefile                        | 12 ++++++++++++
 contrib/credential/osxkeychain/Makefile |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/contrib/Makefile b/contrib/Makefile
index 787cd07f52..1203c7263d 100644
--- a/contrib/Makefile
+++ b/contrib/Makefile
@@ -1,10 +1,22 @@
+include ../config.mak.uname
+-include ../config.mak.autogen
+-include ../config.mak
+
+
+ifeq ($(uname_S),Darwin)
+OS_CONTRIB += credential/osxkeychain
+endif
+
 all::
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 test::
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 clean::
 	$(MAKE) -C contacts $@
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 219b0d7f49..d9fba07e8d 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -10,4 +10,6 @@ install:
 clean:
 	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all git-credential-osxkeychain install clean
+test: git-credential-osxkeychain
+
+.PHONY: all git-credential-osxkeychain install clean test
-- 
gitgitgadget
