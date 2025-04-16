Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900624A070
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845578; cv=none; b=m6Ko4eLbybIQWL6hj/zwgZVL6ZXGaTycLI/JNbHQDC1htUK+MT9TNlKTYoKAclSuh3/aif1D9fvdTWpxSjwL4g3zvBqyvHbV9cRsTXT54ejMXp0O57VGrW+NNyz3/t9NC5wbG9waZerLMVbE8W7xBsxgdSJvxUfHkbB9mU5450w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845578; c=relaxed/simple;
	bh=tzPzckbvdUhXQEiO2ILe2extWUQisgdqfIyP/L4PGps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5h3UXekrad/VSs/EhA+BGD7sUEl2+PoNoUnUOaGjXGmKO0AQwJ5YvGvO54xPcDKKLzc1Rjvlke12vasz5pjzP6m1HCoxZuJCgKNpuoQKUnvkC47f2SoVW17KgqSh8KCn6RwG7ajCkocXv5sbhUpd0jF6yvNkg6Klgy44iHfBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=POiGDBLG; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="POiGDBLG"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2Zu8KPU; Thu, 17 Apr 2025 00:19:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845575; bh=bGD7ZGnPLY1NQoF0MwEgIdUtKb+sl6vNMUFMQlbU8Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POiGDBLGp4jaxjKuH8wPw9FnZ978VmiULQpayxQVoXEugGxutx6q1OgA10jJaEu9P
	 O6u1RZuWSD9s1PW3lJdAI2k78IVvVfBBlmP7XhgwNJBeQcQyn45GoCP99gBUX2HWKM
	 BLU0rqHHwqbrPTHZmKhhubckPzuYVvNng2Vvc4YoSny6gCZXREtufTjg4HYa7HK6cB
	 hd2YKcQzNPJvQ7ZbZXi3qILup2Pfh/cFhuQAcCJnU6fPVzrSN52ifbYO9DOTkuqEUH
	 jU3HT40LTEqicySPYcoDlmuFOo4JKQ/xJDmOyaCcYYOF9dxri+CwkexDCAyr8uFX89
	 enUSfy7E9ugZA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b07
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=MwKkaEpK1oP1WH10rxgA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 05/13] Makefile: remove NEEDS_LIBRT build variable
Date: Thu, 17 Apr 2025 00:18:26 +0100
Message-ID: <20250416231835.2492562-6-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKNN2ris+rTZKp3S14XZAmI1+DyRF6JVOnJcAVfhGxg+R9KXo3g6BjfFrw+nqVcN4j2HmdO/ubMBg4fSuv2eicVMUKcSc7vfYE9W8afVAMpjnyDHy/mo
 oZvEzDj8lgXCSFgXgHMTFAF7p+FyLootZHNEXco1Fqomfg66QQn5k4oGFWVFu9W2JAFxJJiuTIC9tR71CtSvJCqVJHSCjafkooA=

Commit d19e3a5b21 ("Makefile: add NEEDS_LIBRT to optionally link with
librt", 2016-07-07) introduced the NEEDS_LIBRT build variable to
disassociate the HAVE_CLOCK_GETTIME variable with the unconditional
linking of the librt library. At one time, the clock_gettime() function
was not available as part of the libc library and (on some unix systems)
required linking with librt.

Commit 52fcec75ce ("config.mak.uname: define NEEDS_LIBRT under Linux, for
now", 2016-07-10) set the NEEDS_LIBRT variable in the Linux section of
the config.mak.uname file, since Debian 7 (wheezy) was one of the few
remaining distributions, with glibc 2.13, that required linking with
librt for clock_gettime(). Note that from glibc version 2.17, this is no
longer necessary.

Note that Debian 7.0 was released on May 4th, 2013 and benefited from
long term support until May 2018 when it went end-of-life. Since that
time, Linux distributions use a more up-to-date library, for example:

    Distribution   version  end of support

    Debian 8       2.19     30th June 2020
    RHEL   8       2.28     31st May  2024 *
    Ubuntu 16.04   2.23     30th Apr  2021

* paid 'Maintenance support' ends 31st May 2029

Since it is no longer required, remove NEEDS_LIBRT from the Makefile and
config.mak.uname.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile         | 7 -------
 config.mak.uname | 2 --
 2 files changed, 9 deletions(-)

diff --git a/Makefile b/Makefile
index 818dde32a9..8fa4d2664e 100644
--- a/Makefile
+++ b/Makefile
@@ -340,9 +340,6 @@ include shared.mak
 #
 # Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
 #
-# Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
-# before 2.17) for clock_gettime and CLOCK_MONOTONIC.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -2171,10 +2168,6 @@ ifdef HAVE_SYNC_FILE_RANGE
 	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
 endif
 
-ifdef NEEDS_LIBRT
-	EXTLIBS += -lrt
-endif
-
 ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168a..88007c4f13 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -54,8 +54,6 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
-	# -lrt is needed for clock_gettime on glibc <= 2.16
-	NEEDS_LIBRT = YesPlease
 	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
-- 
2.49.0

