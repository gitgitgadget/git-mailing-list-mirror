Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE270814
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968393; cv=none; b=fmX30fp3YMg7JkWEB7NlWuajGfPcwinilcLaNqz3nTeTK+s33cqvxeRx+dHEXT2UuRYSkJjHBn2Jf/JBBSVNm/o77JnyMJaekSoNnAxEzo7JhCTFDvMUmRJOpEYh6u/mbMHm9EXurKMgr0gOj2vmvIVGtQmqRbnQvRDo5cJB1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968393; c=relaxed/simple;
	bh=++VZgwa5yodMJ9h/fbxSWGLYPmGm0xnRJlXcFciQ8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYnTsdP6pDCI0Ru2x1jflP8/zfJTQHsPSoKSHmouxWsDxl048IRZq3DhanZ5HJ/a03KNDJ3fuE2+hbKZk5vL6JbI3T3t4t8WXm1dx006v6zCoVYwRVQ7rEBcYCRIt//vvK0JAM0AUjHtiZSbRPeHdZJC5X7EYXOLUzj2OoKyoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ADTn4r+C; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ADTn4r+C"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqNupkLm; Sun, 06 Apr 2025 20:39:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968387; bh=sDV7FUwY2Wamm5gxYivbZ4pkl/sK/yvmuVnvrjPMzlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADTn4r+CZwSeaUJlzRgv0Xszd7G+81VNTPRP5BTZcIVDz0/KMLkwgBF7RlGXXKruY
	 VKZXyyAEO7G8mYkgnOkZshLPsKDG0uMB5RKuna2eaJAXhtELqUwUPOp914nMc7vNb0
	 8RJqB96oF9h8NgRJ0RpKYimKkUjeCxOFJg92O3OTJuJYlGVgrZKjs/2py4/0DfHjIK
	 QecAnWyC7AvNQKfEqPnECi0btQdXTO4wMUvH4DUC4lH5R7gdNEAakD2i4ycWt3St90
	 A3Gag4Az6LpGl1LvWt2yuEwSh2y423NN1LEe6lziJjMg8buKLpIWBDgJm5WIlLiLLI
	 nXNOT8DKy7RTA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d883
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=ZO4WGqYwhwYn17qujKgA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 07/13] config.mak.uname: only set NO_REGEX on cygwin for v1.7
Date: Sun,  6 Apr 2025 20:38:33 +0100
Message-ID: <324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfObcks++MYbp+E6IovreqoqktdPVFM/StXIcc551YXAhVN09x/eSIWb9UtXVHgTvuiyb5e4Kwz6F4ewpHS5QAbx5DWXjgAPgm2RqDC3sOdo8186dpvL+
 XfIP5DXaowKp5TUufsJdh7BGgO6sAyRc3wJw5osUyDBZ8cPdw7P0BuKBJN1keuvA8k0IZrfgTVnDOl0Q+mHwUIqOgboDOs2TGjE=

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

