Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736A1AAE13
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968414; cv=none; b=SqqmD1YoUdYSZKlbidGdDKcZ5LgzITaZv999r4smyY1cclznR0IUOPSeFe89kZYHimUomV0A6Ev8eeetLbljMUb6OrGYPmJvBk6dmNy9IPcioBfWg92hd0N+YpqG9uFpfehEYB4Zwp+KCJYmNSCBwzzz9eWV2SdiG1awyzmYkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968414; c=relaxed/simple;
	bh=RUi5p2l7h7cj9AXu04wpFk/bvRREK5ICo57ggyxEur0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJyUxLma1oCJmws/ri7PJvf5kj9nVFWi+5Uh69VVVoR57ex9FL2mtGmXa9AjLwHKyAPdgw5vLbCZ15F2OcefHRO25vPXeNzmGRX5doYnncQYyZTqAR+O2TeJHMNDR/W0YUBX/KV5A/k93BB2oCPgZGa0Nsy+7AzFyiYsA6t76S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=NlPGWFoL; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="NlPGWFoL"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqlupkMU; Sun, 06 Apr 2025 20:40:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968411; bh=sYctSVlYYrLFdg++eWYIQKaS3+U7IsdTHBPWNdOkzzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlPGWFoLaQvaudsEjoDZ5MQltCqXMMZqxsDQpzONenWYqS656OZHYUPK1U2daglby
	 a9QIqGPrcWL7m6KSe6R2QmwpbwXkwsEI/yrnHx6KvhAGctWl7gvRmt+T0b0zJU88q7
	 k1o3E40r7KrnERD5dv/XThEz0TmSthBgVGkunqOhcW0T2cV4NBjwq15JAxLVEOw+ZC
	 oCv1VvZnXGX7P7ndg3lfKqKLdl5aonuzISTd5yFeS7GiuMzU/u9fBD0u+BOH4Kzudm
	 2mSlw569//shwzfk2yMRF76QgIGtgSqtyLO33VZYR30Dzc83USEHUmS5atG3LjDbDn
	 qGiB85R7bgErA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d89b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=WBFf2OPKqg4umVxYW-kA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 13/13] config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
Date: Sun,  6 Apr 2025 20:38:39 +0100
Message-ID: <7b133af24b472e343a19ddc0e89c31da80ade098.1743859985.git.ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfE/43ByDBgd+hoN/AfaLN7EPKLBmLj1irIG1CggUPh67zzXHTSJNXUPlG0Utte7vBuJKGRPqj6z+MbjV4Gz0P1G+Rhj239Anm0BMt9/9Ai2YaFtQ9qE5
 hvoX6KVGODBmfb8duURjXgo5LaJa/3D0aMszWtKwbOznju/8OsYjWV1xlhcuSsoqJ8zCiVgAF+cROf1UbJ+bTO4OJuNk2tQk1n0=

Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
of several interfaces to provide a source of cryptographically secure
pseudorandom numbers. The CSPRNG_METHOD make variable was provided to
determine the choice of available 'backends' for the source of random
bytes.

Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
the config.mak.uname file, so it defaults to using '/dev/urandom' as
the source of random bytes. The 'backend' values which could be used
on Linux are 'arc4random', 'getrandom' or 'getentropy' ('openssl' is
an option, but seems to be discouraged).

The arc4random routines (ar4random_buf() is the one actually used) were
added to glibc in version 2.36, while both getrandom() and getentropy()
were included in 2.25. So, some of the more up-to-date distributions of
Linux (eg Debian 12, Ubuntu 24.04) would be able to use the 'arc4random'
setting. All currently supported distributions have glibc 2.25 or later
(RHEL 8 has v2.28) and, therefore, have support for the 'getrandom' and
'getentropy' settings.

The arc4random routines on the *BSDs (along with cygwin) implement the
ChaCha20 stream cipher algorithm (see RFC8439) in userspace, rather than
as a system call, and are thus somewhat faster (having avoided a context
switch to the kernel). In contrast, on Linux all three functions are
simple wrappers around the same kernel CSPRNG syscall.

If the meson build system is used on a newer platform, then they will be
configured to use 'arc4random', whereas the make build will currently
default to using '/dev/urandom' on Linux. Since there is no advantage,
in terms of performance, to the 'arc4random' setting, the 'getrandom'
setting should be preferred from an availability perspective. (Also, the
current uses of csprng_bytes() are not in any hot path).

In order to set an appropriate default, set the CSPRNG_METHOD build
variable to 'getrandom' in the Linux section of the 'config.mak.uname'
file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 4f6770a5f4..6ebe6dcf37 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -50,6 +50,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
 	# override in config.mak if you have glibc >= 2.38
 	NO_STRLCPY = YesPlease
+	CSPRNG_METHOD = getrandom
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.49.0

