Received: from mailrelay3-3.pub.mailoutpod2-cph3.one.com (mailrelay3-3.pub.mailoutpod2-cph3.one.com [46.30.212.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B241C07C8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804648; cv=none; b=BHMXxeDQIWh/jP7TlcibCnnvlI2ZNPk+AeHBO/T7DGh1WBGUV4312mj5sYf72antsjIRol3pUPjFHcWB+wE2rpwQUCozpZQASC7jGgz8wr6tp651pg0aE33SUkMuizk1YMxrWjNmauv8LtJ4lwhYRC1VPyjA4yGxyqxZJXB0sPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804648; c=relaxed/simple;
	bh=Aa2SlMuk7mymT5CAqp0LVKtNlYPWxPgl1bnt5VqRQPg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=orCt4xWvbwr+9Uh3yhm75z9NCiJqHiXIUqYqtWjXWuDu8jOEpSMKWeUJ1YmyMiYXQ9uwyUrLevvJy/gTCir0kj1SkYu/kOH6yfNRFyvgA4vG8gbTrqDIsQmGhYCoy/4okmHQ7123+lhL/9LJCM1JCZmzqzeMWCJdroe6PhL0Gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org; spf=none smtp.mailfrom=maxsi.org; dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=fxjUiCeu; dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=e3rpHhBe; arc=none smtp.client-ip=46.30.212.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=maxsi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="fxjUiCeu";
	dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="e3rpHhBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=rsa1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=fc/cgSfLxIvUjO2LJDWjIt4XsldLKcrVDrwomamH2nA=;
	b=fxjUiCeuqM+XhLWmFHGscmnw9deG+z39HeK/Kbc1+qHcric8U5Fa1pHyqy1IT4EhbvTJ/qHRkOl4W
	 1vMIhrfKDN8F6DuuIdwr9hVIwM7QSoX1P4P2IUW63XZwKSyRil6zya2ggdsjsn5ttM9YFOmF3IJlhM
	 TaFr02Y4wlo7e8/yM5L0Dle4pzAYxR27UyKF6YDHvSjJfKkbgLMc3THVrRzCj8GRjlaOoONTOJmq21
	 1HRoUXyrU82dupDsGX2BkYwkmdIZMhpXXgv29RxvUNBz2E50OEm43riQLHERPgBpBtUR01d2J1EluH
	 kfGClvaDqVnIzeftMn5oHuAC9J22CmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=ed1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=fc/cgSfLxIvUjO2LJDWjIt4XsldLKcrVDrwomamH2nA=;
	b=e3rpHhBeROF3vHCXPn+aZC0DMycoBGnF0W7pn1t3rPP1ztu6ILDSP0jgE0izZcrgTPS3MBTf+rRVf
	 UTHeIReBg==
X-HalOne-ID: 8076115b-9b65-11ef-bf35-dd3f8b2e2fd4
Received: from [192.168.87.156] (unknown [85.203.218.213])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 8076115b-9b65-11ef-bf35-dd3f8b2e2fd4;
	Tue, 05 Nov 2024 11:02:53 +0000 (UTC)
Message-ID: <0e949a77-0c49-4c06-9f47-d8455e9bb58f@maxsi.org>
Date: Tue, 5 Nov 2024 12:02:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH] configure.ac: detect sysinfo
To: git@vger.kernel.org
Cc: Neeraj Singh <neerajsi@microsoft.com>, Junio C Hamano
 <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This change helps cross-compilation from Linux systems by not assuming
the host system has sysinfo(2) because it was built on Linux.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 Makefile         | 4 ++++
 config.mak.uname | 2 +-
 configure.ac     | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6f5986b66e..639760661c 100644
--- a/Makefile
+++ b/Makefile
@@ -2087,6 +2087,10 @@ ifdef HAVE_STRINGS_H
 	BASIC_CFLAGS += -DHAVE_STRINGS_H
 endif
 
+ifdef HAVE_SYSINFO
+	BASIC_CFLAGS += -DHAVE_SYSINFO
+endif
+
 ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS += -DHAVE_DEV_TTY
 endif
diff --git a/config.mak.uname b/config.mak.uname
index d5112168a4..470b953581 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -59,7 +59,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
-	BASIC_CFLAGS += -DHAVE_SYSINFO
+	HAVE_SYSINFO = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
diff --git a/configure.ac b/configure.ac
index d1a96da14e..ea777644d5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1164,6 +1164,11 @@ GIT_CHECK_FUNC(getdelim,
 [HAVE_GETDELIM=YesPlease],
 [HAVE_GETDELIM=])
 GIT_CONF_SUBST([HAVE_GETDELIM])
+# Define HAVE_SYSINFO if you have sysinfo in the C library.
+GIT_CHECK_FUNC(sysinfo,
+[HAVE_SYSINFO=YesPlease],
+[HAVE_SYSINFO=])
+GIT_CONF_SUBST([HAVE_SYSINFO])
 #
 #
 # Define NO_MMAP if you want to avoid mmap.
-- 
2.45.2

