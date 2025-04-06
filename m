Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAA70814
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968560; cv=none; b=hg5U6TKUro/iR6+7C3dPGCM5YYLpmWsyh5fvpwrb8fSkoCYNQFCjHxWNg+ZbkTbZIfoA+oJQoe8w1qcctks6kJhoAIUpfsObtlBfZEW8cUueSJ2HbxjyV9tJ5sjMueHcAaamfdVtADd/vFz0/vaG1OCNVS3p1r3H2yhFTOIAYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968560; c=relaxed/simple;
	bh=tzPzckbvdUhXQEiO2ILe2extWUQisgdqfIyP/L4PGps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATIxELv42BRKojRyPQYHsccQPwMsQTsh2qtND96WIYeWyiSLXpEZNSe9NZBWEbN/p4UKGmWa/5/YT/yJgk8R3xsukSYVjUn+Lx8QPao2UvtRsaJASRlCjRuOuo8jZPO5ZmIvNSK3D5M2LzOuHVgkPXyhdiBK1OjHNe1htkh3yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=SRl2PFsK; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SRl2PFsK"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqEupkLZ; Sun, 06 Apr 2025 20:39:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968379; bh=bGD7ZGnPLY1NQoF0MwEgIdUtKb+sl6vNMUFMQlbU8Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRl2PFsK2UKvRM8SFxfku2zWVqxnbn0etMYhyk1i/Xw47YX5A9uxVqy362WNWSzre
	 zHbd7mwKyVpRcOSQVTwKCUxxFWP47HaxctEWBBVPWRawJnX2Lm6z4NpZkCjvOJQmme
	 jGW1cR9ag3/KUb/6stoH9Qnjti4EEbtgR88TovGmjH6awKrT44hwAyhDiTDcc3U5le
	 m6iyMqW21j4y5OWwlsXTYpzfXJLe5dZPHc9S8KC1iQaeo5eGTYGjwXUgGWZvdWs4NI
	 +BII4ov6+lFHPbkI2VfOWx+ACcWoMOT8Tw7ka6Kt3ciiuP8MOUN7x/oD+fM1AsQbvu
	 NJ+LrwYv0jkxg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d87b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=MwKkaEpK1oP1WH10rxgA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 05/13] Makefile: remove NEEDS_LIBRT build variable
Date: Sun,  6 Apr 2025 20:38:31 +0100
Message-ID: <e73c2c321985d6e17f2592ad36f4d319ea655459.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfADEZ7j5j/GcItCpoX3VQSL2uogHzCxqGdQ/Y4uyhfQQGTxEqwhL7vIuzZwGPdchpQUFR4W/gWp6t9z/esBDv5t9h0KWYgU4TdvYYRYzdKYM9HPRmF2n
 KCUsSWjl33G64Y0kaQpTRELeVsqrz1xfz7b8dBaFIS8K9xSYoW/b3xsBRizlNRVEaCfq9Tj/BBlZRSP4nKQOzLLGIW5v45hisak=

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

