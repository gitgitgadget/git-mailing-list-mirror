Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0542327AE
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845588; cv=none; b=M8K76f39ylj5xq/3BHAq/5GOVjwTcxv+YcrXvSgPRcnvuJQJudkfygaKrCjbvWXi3K8S8KmbeTv737yaj6PSVeUWQfUMWQq+yDRPpaU5AYbwphlmca7dg9wQ0JHjQ/BTeKWHQM0/ykwUWs3Ox50Z3icpuEMn+T8H2zUir7r2l1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845588; c=relaxed/simple;
	bh=++VZgwa5yodMJ9h/fbxSWGLYPmGm0xnRJlXcFciQ8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD9OCJvhPOYlR1QChRd4U8VnD7+YSfdxg3iBZmrzOhX/1sCTFL7oZQFKVfpbE9UIN5P408Jh8TiyLQL81Lz0MrjFFL55Qx+M+oV3T0MfsnycgVhB7EKKY9Gljwbzghod+JUTIpdGeht/Fj+fOlMdQjp/14JBB7CPcgkcAtzsMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=GaFWYtTy; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GaFWYtTy"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2ju8KPf; Thu, 17 Apr 2025 00:19:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845586; bh=sDV7FUwY2Wamm5gxYivbZ4pkl/sK/yvmuVnvrjPMzlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaFWYtTyckuk8RtyCromVTYCANLOgaVd41Nzw/NS/rkeLJmTjGLh/YrGykHO/W8AC
	 ZL/3XrL0p7cQGIucLCCg1vpB5eF3fHlwEN7Zt2B0EpnDkXXrydsIgVS+qSYMrSBaW7
	 rjuz9g7bWJc7xcqXAHFWvqu2H2QarlK3eLue+CvHKDn7THPgjFgByjvbZoJgvrzul8
	 ZEcTMvOKh3E4EE+vi445SrpAFZBoKyhWILM0a/ZVYzHprN5bdqergjjbQNhwXK+rde
	 AMaxvX5QvBAVBn6B37F1WBSGdFsuT/izgVYbil5/GsbszlkL6JIuNPQp2LTq84zyHt
	 4GeT8/my3d7KQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b12
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=ZO4WGqYwhwYn17qujKgA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 07/13] config.mak.uname: only set NO_REGEX on cygwin for v1.7
Date: Thu, 17 Apr 2025 00:18:28 +0100
Message-ID: <20250416231835.2492562-8-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfMqWpUcRXewHxwF/43I1F0OF/nXdXGfSMfRHoWDB4F6fp83XY8ZgVf85PF7dkU1nLvpDxQpAajZ40EfySrisqZ5rtYvtnKwAZk7d9CgBulF2sGgfXflX
 oEWIaQ9lajxrsdTBAV5Ylb6lBFql79bRhDONIYnVIODHKaWGl6YuiuGZr5lG01CSZGUVFekTNILlwElsBXdCz/2mPhPq30X3F9Y=

Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
the NO_REGEX build variable because the platform regex library failed
some of the tests (t4018 and t4034), which passed just fine with the
compat library.

After some time (maybe a year or two), the platform library had been
updated (with an import from FreeBSD, I believe) and now passed the full
test-suite. This would be about the time of the v1.7 -> v2.0 transition
in 2015. I had a patch ready to send, but just didn't get around to
submitting it to the list. At some point in the interim, the official
cygwin git package used the autoconf build system, which sets the
NO_REGEX variable to use the platform regex library functions. The new
meson build system does likewise.

The cygwin platform regex library, in addition to now passing the tests
which formerly failed, now passes an 'test_expect_failure' test in the
t7815-grep-binary test file. In particular, test #12 'git grep .fi a'
which determines that the regex pattern '.' matches a NUL character.
The commit f96e56733a ("grep: use REG_STARTEND for all matching if
available", 2010-05-22) added the test in question, but it does not
give any indication as to why the test was framed as an expected fail,
rather than a 'positive' test that the 'git grep' command fails to
match a NUL. Note that the previous test #11 was also originally
marked in that commit as a 'test_expect_failure', but was flipped to
an 'success' test in commit 7e36de5859 ("t/t7008-grep-binary.sh: un-TODO
a test that needs REG_STARTEND", 2010-08-17).

In order to produce the same NO_REGEX configuration from autoconf, meson
and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.
In addition, skip test t7815.12 on cygwin, by adding the !CYGWIN pre-
requisite to the test header, which (among other things) removes an
'...; please update test(s)' comment.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname       | 4 +++-
 t/t7815-grep-binary.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index ae6ba15586..b6adce0bc4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -245,7 +245,9 @@ ifeq ($(uname_O),Cygwin)
 		# Try commenting this out if you suspect MMAP is more efficient
 		NO_MMAP = YesPlease
         else
-		NO_REGEX = UnfortunatelyYes
+                ifeq ($(shell expr "$(uname_R)" : '1\.7\.'),4)
+		        NO_REGEX = UnfortunatelyYes
+                endif
         endif
 	HAVE_DEV_TTY = YesPlease
 	HAVE_ALLOCA_H = YesPlease
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index 90ebb64f46..b7000dfa32 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure 'git grep .fi a' '
+test_expect_failure !CYGWIN 'git grep .fi a' '
 	git grep .fi a
 '
 
-- 
2.49.0

