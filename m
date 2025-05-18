Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B138207DFE
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553695; cv=none; b=uc+j+W9yAYdDjED9KrrVMUN2zUlUIFa94SIYgHMkEP2bCnpWg03HGyFlUeYu0XZtxNRqcOochO8RNIeceltjy11Twz57C9DzAXfn7ACCQQxfEid8cHhHARuGuZ1tKnrkSZMUwt6TSjJ764Co/1Q+kb2u2a4RfcCLFwHqPURGi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553695; c=relaxed/simple;
	bh=Yb1ek0lClboIairr5Vk5ApHD+LIwZEvsKfwlWEKMWuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB6sRexYyl9IIRkXwvcvKAR40v2bbODppnlqqT3UugwXw6/HwZguIXUOKAzsME9JPKuCA8wlrlPxUxT9FYEZSBTmsXnpHVV89LJUfH4qbPKCLIRhA5osTcIqHqRXoNXk9gUXZqF/Ps8XMqpxXIeqlVJ0csp45PtNG3WTEH9iNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+OXu+/k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+OXu+/k"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e033a3a07so33848105ad.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747553693; x=1748158493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtSdPimipaF6pT2LJ2ParwcPUaiMGRS9ZOpCEqNRpM=;
        b=i+OXu+/kAx7FEE3uttnqYzwPhauLiCMcBzFF3g9hgmwSzolHIaTspq9q9FLBwc6Ksy
         m+lc4aO4pGSW8B35PZCSDMchm32QBG/9MCOxJBca/OmHoo/IGo3Kd14zIxYjgXedHU15
         1GCiGlCxLiCI7HN2AsnNqDRu7N95QCSLL0RcOt/g5wSKLATB5JueRm0JCGeJfMrIPifZ
         ZW3lamivI0s9n6KJIaTJTnWoJOx3zITGkoX1fVNo3ob8QV7aPlwP1cMyFzsGy1ZbWbUL
         2iQtTq38EC0oW6AIvzMP/gZHedXs7aQp4yvBUcoczTHHZ9qXeioSvNuee/mYyhmgBdt8
         pN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747553693; x=1748158493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtSdPimipaF6pT2LJ2ParwcPUaiMGRS9ZOpCEqNRpM=;
        b=KcKprSlyrKzuUEr1t8/9sSfuv480a7/QUk1TcoXZQYY+cU+heUdJPLJjWN1dsj6Yw8
         HO9HetqQR2ITMsaAFzscNutLrYRIA76vkAsPGEa/8PsPtSFtZPPDpGcYyCQo59DAD3X4
         71By9yqb3rdzEU3h18/hBPNNnWzm5sl/fJC/V1vrLvJsE9FuGmSL4fPb4LE/tbXRH/W0
         wtzxyS+l9PN6kvri7ZsdR7YxZnIwG+t2++T69CWk5iZ5l/V576jL0y6rWJL2KSIS3Kmq
         fO25q/NLncaiaownOq3UN6V+7uu8YgL70Q+54m91lk7EYc4Hqd4arjVKRNw8AqP5PnlL
         1ATg==
X-Gm-Message-State: AOJu0YxQffC5o6Nr+WRcEFHcwqfmNl4AatgnPOF521yfQ3YNJ/RJZCSV
	u7tvzav9O+FVdffkOfkWxEYv9QQvuxHoxOTzLQQQflnOLJfwS4qB+Zx/
X-Gm-Gg: ASbGncuREXgZMD/ojXDLaINBKX6nARe5o1dAXtC3bDNddjct2UqkrSdPO7Bzmp+2OQG
	mrE63uHwQcFKj8w/Hb/GEWFEVygmcdWBr8HY6HjmWi2U6iBouMqcy+D6m9zXcATADNDY7/Bg2uM
	tI8TO+aYhfmqTQijh6r7WQr+zGscZztOrLRr+9djjZ9SN8o1Xp9OpQY/jLE7gDMsxH2PVWzjC6t
	/rwqJH7JCBLVDvScUG3tmrHu6vf42NjYZzmegmVtNmY/hp1ZGBQMYVejgm8oRdhDLQ/20DUL5DS
	QBIC+TIQlUGn21f7fzM/hoP/pAhxEV+yUW/JyD1XteR38GrejGOaSswEb3U7DerxeC4=
X-Google-Smtp-Source: AGHT+IFDp7g83Qyg3XTweafLAuDc5R1oenNM+LS+vgjCJjh4WAQxCwqgvGwlZwkguXsvw5mmSfoPww==
X-Received: by 2002:a17:903:f8c:b0:223:50f0:b97 with SMTP id d9443c01a7336-231d45d67f2mr109303995ad.52.1747553692844;
        Sun, 18 May 2025 00:34:52 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm39847715ad.250.2025.05.18.00.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:34:52 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 2/3] docs: clarify cmd_psuh signature and explain UNUSED macro
Date: Sun, 18 May 2025 13:04:41 +0530
Message-ID: <20250518073442.72666-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqa57bqdxt.fsf@gitster.g>
 <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample program, as written, would no longer build for at least two
reasons:

    - Since this document was first written, the calling convention
      to subcommand implementation has changed, and now cmd_psuh()
      needs to accept the fourth parameter, repository.

    - These days, compiler warning options for developers include
      one that detects and complains about unused parameters, so
      ones that are deliberately unused have to be marked as such.

Update the old-style examples to adjust to the current
practices, with explanations as needed.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ef190d8748..da15d43d1f 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,15 +142,31 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
+	     const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
+A few things to note:
+
+* A subcommand implementation takes its command line arguments
+  in `int argc` + `const char **argv`, like `main()` would.
+
+* It also takes two extra parameters, `prefix` and `repo`. What
+  they mean will not be discussed until much later.
+
+* Because this first example will not use any of the parameters,
+  your compiler will give warnings on unused parameters. As the
+  list of these four parameters is mandated by the API to add
+  new built-in commands, you cannot omit them. Instead, you add
+  `UNUSED` to each of them to tell the compiler that you *know*
+  you are not (yet) using it.
+
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
 declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -166,7 +182,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+	     const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -279,8 +296,9 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
-existing `printf()` calls in place:
+Modify your `cmd_psuh` implementation to dump the args you're passed,
+keeping existing `printf()` calls in place; because the args are now
+used, remove the `UNUSED` macro from them:
 
 ----
 	int i;
-- 
2.49.GIT

