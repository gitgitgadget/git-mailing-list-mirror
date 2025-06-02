Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927AF9EC
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903535; cv=none; b=E0VzARZU292RZbcRCKLixwLHQl4hjZ36DZ2ZJbgFomM1FduHZza4Gk5/547d4DkMFgZ6/tPjsVD+sVPdG5xO2dIFoslNQiPOHubhLbkvWabL/wI+9q5SMDGxh+viSNQunaSY3F5Nu/ZKRcqgrl8UlM3yZwc8vQiH5eSStarR0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903535; c=relaxed/simple;
	bh=TVNrNa8e8GmdnYPz00KJH0Tu6jYI6MrcpkehdDHMRC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3zl9EfrGXCb0lx2IckhlpktsuYr2bmDw+vJbXzP6/SJ9bl0yxrOG0m/6Mdn0n7uwZ4i1sJESXD1bvBaYC1+qU5mKmaxM2NlCBBj9RGnwHnmRfOiQvB3BKWfU9I3puqlLMfeNHWs1SbXcp6XsMyL3pgvIWFcV36B84SUvycWalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9For3YH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9For3YH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c035f2afso3201231b3a.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748903533; x=1749508333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VfSP751XlHG+9sPpRFBsM/Xn8a5fO7vRRl9imEyvvo=;
        b=X9For3YHOYdDddnC4KX6biZ9No8FewdcDFILMzHYJaQAGNcRT8FaCys09KKCdtSqy2
         M678wL7pI2cKzjyTCb3GBt7zqkqIwYDNa96+FBJ/qoLVl1z4ammLsIAENf5xdN9ndEhv
         yxoxj0ve6sGiCZso8DHKCWbC+cGpWLEl09Ly/5DQlPG9q80EA9xg7HThin8DaOrx7pFa
         gbGCmrzTtFdm+u9c5DdJuHyKDfDW4wrP9MAdixFRrx3Umt005MrTTXEMBf6iTbHjPv86
         yQ7vAL+zECVKOOffDWd7cnYwinlP492I04M4tJ1SdBSQez7vB54HlVd7qULHYVuCc0Hb
         +ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903533; x=1749508333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VfSP751XlHG+9sPpRFBsM/Xn8a5fO7vRRl9imEyvvo=;
        b=QOFTC1AgImzJTR7J9B8iaOxvBydu6bXB21LMzrJUJiVSQ9x9hcchC0nKSFWUJTub5G
         HMG6kfKZn4OTAzu1d8oLzrPqGqGDO8pkgUOAHk15PfcDJzATr0A8mRkhjQvN72owqnTQ
         iJIOLtySMyn6uDCRgTVomOSDZP6KRU1JSoRHMlBmRWdgw5QZK19g8rcwh9hsYKAYDNDx
         l2+6fQVW6xfT80rrbhzJz1ZKGK5B6SdSNwypvex+DXaxqu9XpStwin11/1mWLYoLXQZM
         ndSuuWMJW7KZJvPdeIyCFk0umxq/tdP4wrICiUAtycIi4xuBc5NoDK3MHugWBuKspEeY
         kMyA==
X-Gm-Message-State: AOJu0YxD1q15/bUBKr+qwlkryfIcglCm9Xv3F9mY19yjCeqNYiB6dyuM
	VioHpObODQ3c6tDemr16dOj9pYYC/kCyoP6wpHoOC5uA9NMWACEK8PTpgGV0Rg==
X-Gm-Gg: ASbGnctTshdjtjI0aKFlHTkq4g3d4wkiCFMlPBPnKRekvxdTcmTFE3qIr8QyAXUSSz/
	sqAWv6RCv1P+DFDtFaFh6ws9OXSmj75ytYeA00NEGFJR0VRfbRC5HhEYPUVXYePK7YqsjvU0L7a
	2OVCQhlKVuJIRh4FQjYrguz4JtsNiNEfSfi5r7Ch+GYIlneuARZb/l8Wt7LvWS+seVDeo1GHFJe
	WrplFgNWtyF6F6gZji4NctOQjm+OwCH6npr+HriJ5fMW598cYOIaMy1CcsenloqogASD/1xLuvM
	qvUbTuo6h/H+i/DoM5YU4HcZjVeu/GhBtQ==
X-Google-Smtp-Source: AGHT+IHMJeoa1PooU6AJWv2u9mG3TF2yIRFgmTt9/UC18uy9Lz9mW2V77BEh5lFEOstfxKQ4DuYzEA==
X-Received: by 2002:a05:6a00:180a:b0:740:a85b:7554 with SMTP id d2e1a72fcca58-747bd95c4eemr20124830b3a.2.1748903532859;
        Mon, 02 Jun 2025 15:32:12 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb02662sm6082759a12.5.2025.06.02.15.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 15:32:12 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: jn.avila@free.fr,
	jacob.e.keller@intel.com,
	Collin Funk <collin.funk1@gmail.com>,
	Corentin Garcia <corenting@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] completion: make sed command that generates config-list.h portable.
Date: Mon,  2 Jun 2025 15:31:32 -0700
Message-ID: <59b2a12a3f43cf078fbeaf0271b5a7cfffc9eb8f.1748903426.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OpenBSD 'sed' command does not support '\n' to represent newlines in
sed expressions. This leads to the follow compiler error:

    In file included from builtin/help.c:15:
    ./config-list.h:282:18: error: use of undeclared identifier 'n'
            "gitcvs.dbUser",n       "gitcvs.dbPass",
                            ^
    1 error generated.
    gmake: *** [Makefile:2821: builtin/help.o] Error 1

We can fix this by documenting related configuration variables
one-per-line instead of listing them separated by commas. This allows us
to remove the unportable part of the sed expression in
generate-configlist.sh.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 Documentation/config/gitcvs.adoc | 3 ++-
 Documentation/config/http.adoc   | 3 ++-
 generate-configlist.sh           | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gitcvs.adoc b/Documentation/config/gitcvs.adoc
index 02da427fd9..31d7be3992 100644
--- a/Documentation/config/gitcvs.adoc
+++ b/Documentation/config/gitcvs.adoc
@@ -47,7 +47,8 @@ gitcvs.dbDriver::
 	May not contain double colons (`:`). Default: 'SQLite'.
 	See linkgit:git-cvsserver[1].
 
-gitcvs.dbUser, gitcvs.dbPass::
+gitcvs.dbUser::
+gitcvs.dbPass::
 	Database user and password. Only useful if setting `gitcvs.dbDriver`,
 	since SQLite has no concept of database users and/or passwords.
 	'gitcvs.dbUser' supports variable substitution (see
diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 67393282fa..9da5c298cc 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -289,7 +289,8 @@ for most push problems, but can increase memory consumption
 significantly since the entire buffer is allocated even for small
 pushes.
 
-http.lowSpeedLimit, http.lowSpeedTime::
+http.lowSpeedLimit::
+http.lowSpeedTime::
 	If the HTTP transfer speed, in bytes per second, is less than
 	'http.lowSpeedLimit' for longer than 'http.lowSpeedTime' seconds,
 	the transfer is aborted.
diff --git a/generate-configlist.sh b/generate-configlist.sh
index b06da53c89..9d2ad6165d 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -19,7 +19,6 @@ EOF
 	s/::$//;
 	s/`//g;
 	s/^.*$/	"&",/;
-	s/,  */",\n	"/g;
 	p;};
 d' \
 	    "$SOURCE_DIR"/Documentation/*config.adoc \
-- 
2.49.0

