Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90A21A459
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179045; cv=none; b=lBvunGVgUsEfUw3+gPkDSFYvOiaf2nZ37asMjd6FTIM2vb6wlhofRNpSgogNNBkoqP8K7DW63SX4KsSnIyEhNPls0iMQ/MhNk1dbpFKY1D4rJ5HtLi+b2z/0eeV6Io7fIkQiDpwqtKVGz8x8iBiLoTmvUAtXQbOmsmHc4GwRQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179045; c=relaxed/simple;
	bh=7bfvpvsAkQ8aeGJMhbs8Uje0JYa4tqibIRXu/PLv+cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5EpFZQ0frp6wnSQvQimZz5bNsG8+bN8D5VgMQolwqFCXfmAU6KeBHEOPvSxrdN9EA36lTZGR660fbqlkXsLHVkas2uGC7AwjqmjFbkHtGklVeovJ/yT6kHiOGR/HW3yYaKraZaoHpSh4pLSl6u/NrlvyXReR71RToUFVFRMImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lqIF3Vx/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lqIF3Vx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775179042;
	bh=7bfvpvsAkQ8aeGJMhbs8Uje0JYa4tqibIRXu/PLv+cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=lqIF3Vx/wzyB8CZuDOjXnoHUt9N1QM7raZhW5BUK3fUHS35CHrMDfEHwf82JdTCdk
	 jGLpVLzs0FelaQpPLt2yGzvqCHX8nE9k3Wns1H9qgtKmIWwXQEZaXlmkcuvpySOlo9
	 68qnd4zH/fGwOJjSUYfdHtgLGyEYVNMbEpymoWrJARoK5bJa8yAbmiVOs/b9vAe99v
	 XMequ6BGNHOmdzCztjoPTMzGqzth2c4nfsI6R48Syj26SqaPiVB6k/Vz9S2ZZ1pfue
	 CINCRFU3cFTcohldYQ+etAv/BjN4q34HPvpfeKobNxhqJ++ZBHQ8uZsZ/SaXMHhHW2
	 chruzdDk9B4bCH07xYC2L0rmDYCsbmwf+eX9bsKSSJD4T8RdNsP8m8Fy6mKHnibHKQ
	 GBnQ4DgVvOhtQ8xqSjKe1DVRu9Ko79FBShUlD7wiwzQEFbYC3gEh6s+EBbcya2xOJB
	 /ca8MlRqDM0WOhDITJMpFxUh7Vm04LL9HPKCt4WDtzIYi4HuRDV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D520B243C6;
	Fri,  3 Apr 2026 01:17:22 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 3/4] Linux: link against libdl
Date: Fri,  3 Apr 2026 01:12:48 +0000
Message-ID: <20260403011249.4133372-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older versions of Rust on Linux, such as that used in Debian 11 in our
CI, require linking against libdl.  Were we linking with Cargo, this
would be included automatically, but since we're not, explicitly set it
in the system-specific config.

This library is part of libc, so linking against it if it happens to be
unnecessary will add no dependencies to the resulting binary.  In
addition, it is provided by both glibc and musl, so it should be
portable to almost all Linux systems.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index ccb3f71881..7aab56c590 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -63,6 +63,7 @@ ifeq ($(uname_S),Linux)
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
+	EXTLIBS += -ldl
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
         ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
