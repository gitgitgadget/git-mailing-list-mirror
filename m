Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498F218AC4
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681717; cv=none; b=Jy5WPP7THOhftRhtZEm12EZ3UkxutI6lXVUAjADVOvdEi7k7whQTJPIduC8Oo1iScOlA6ySVOURK73nT6/XR0/DZeVdC2JN8BIQ3UK4NnjYVIcnbGc9w8hUn2eVG1Vcv1pn/TZxWASMwEpYS5XE0u1Lq9BgqkPfo3USL20jR9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681717; c=relaxed/simple;
	bh=KHUPB2FulOnQQU2l9r6eQG11Q5WQLa/RI2TPYPNYGAs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=f3l43CBcz59E8DMcL1zApOQubW3Fy1uDH9HOiWWZLd2+5O1Diw2FO30Mg+FxeJ0Z7PRpP7++MVl6ZZZLFLsU5OOSjmXjVpEdYMMiP9uf+0qniaL4+lKPoGXAqw+xXDYXgPyl0ni/w3AFiM7Q2wfjoCnTTA5c1nAXJ20IaZ3y5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nUwLuBdy; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nUwLuBdy"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id kSosu94IeN4WEkSouuVQpS; Fri, 08 Aug 2025 20:32:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1754681524; bh=oWjO5BDUbyHnNfZ58DYM5SzFHJiC0dcRYBwt7u1FcUA=;
	h=Date:To:Cc:From:Subject;
	b=nUwLuBdysxOSsxmua5i6Xc1LRN6nj2mRBYugV3AGGT0/emGa1yD4I+rCasXdtAC0o
	 mQSKdXtVFFi7fY4AeQP8Hpy+Ymz99ObsI1lUsp7SwPvzx/l1oZ9tAI/jkHsIvHUvQm
	 CO6481jzGl7AVF8TDNZLv446ynYQBhsaDab2cCR6oyAbfOHMAF9ES0Q385KPfstNzp
	 CacxA/PkBfV0TViFZ9WFb4Jp2hC6uI8jsNCyePLYyDmYmA9k6BA81yrJDkmkyfoydZ
	 U4wKOyh9GA8AUuSoJuPjieDPEKd83nM/eFLcNQ+75UhLYGAr3vj8NvVzbyERUcTtgB
	 qP027OzmiSxxQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Zae+NdVA c=1 sm=1 tr=0 ts=689650b4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=lp_exNrLYDopM_ZkwYgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5514f2fd-3307-42c8-97ac-bc2147a7ba41@ramsayjones.plus.com>
Date: Fri, 8 Aug 2025 20:32:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t6137-*.sh: fix test failure on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAvBwmbf2bCjjRoa7BNsCoGGzCIwOo8F5tecBxDXmJt7ANqHp0ugMgMPIF6CpFDQYjDbfdK35GweHxrCgCkQC5Xo+DECdKRmcujFdK09s5qt4mfF1Q1w
 xtIentlaCC/wsuh+rrJ0ycqsqN7L/8dF/aXusB0Fv9lJ9ziA80d21b8XRhlTjrkDRGKSQcb1i+DSBvT4Z2zpCht22rCLfDuCNqw=


Commit 6fd1106aa4 ("t3700: Skip a test with backslashes in pathspec",
2009-03-13) introduced the BSLASHPSPEC prerequisite. This prerequisite
allows tests to check for systems that can use backslashes in pathspecs
(e.g. to escape glob special characters). On windows (and cygwin), this
does not work because backslashes are used as directory separators, and
git eagerly converts them to forward slashes.

This test file uses the FUNNYNAMES prerequisite to skip this test file
on windows, despite not really being appropriate for this test, which
does not hold on cygwin. The FUNNYNAMES prerequisite is set when the
system can create files with embedded quotes ("), tabs or newlines in
the name. Since cygwin can satisfy FUNNYNAMES, but not BSLASHPSPEC, this
leads to test failures on cygwin.

In order to skip these tests on cygwin, replace the FUNNYNAMES prerequisite
with BSLASHPSPEC, so that this test file is skipped on both windows and
cygwin. While here, fix a few test titles as well.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This test failure is not a regression for this cycle (it was a
regression for v2.50.0-rc0), but it would be nice to get it applied
before release, if possible.

[Hmm, I have just noticed that the 'skip_all' message could drop the
redundant 'skipping: ' at the beginning - oh well! ;) ]

ATB,
Ramsay Jones

 t/t6137-pathspec-wildcards-literal.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wildcards-literal.sh
index 20abad5667..17a03085ef 100755
--- a/t/t6137-pathspec-wildcards-literal.sh
+++ b/t/t6137-pathspec-wildcards-literal.sh
@@ -3,8 +3,8 @@ test_description='test wildcards and literals with git add/commit (subshell styl
 
 . ./test-lib.sh
 
-test_have_prereq FUNNYNAMES || {
-	skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
+test_have_prereq BSLASHPSPEC || {
+	skip_all='skipping: needs BSLASHPSPEC (backslashes in pathspecs)'
 	test_done
 }
 
@@ -184,7 +184,7 @@ test_expect_success 'add wildcard f?z' '
 	)
 '
 
-test_expect_success 'add literal \? literal' '
+test_expect_success 'add literal \?' '
 	git init test-q-lit &&
 	(
 		cd test-q-lit &&
@@ -241,7 +241,7 @@ test_expect_success 'add literal hello\?world' '
 	)
 '
 
-test_expect_success 'add literal [abc]' '
+test_expect_success 'add literal \[abc\]' '
 	git init test-brackets-lit &&
 	(
 		cd test-brackets-lit &&
@@ -280,7 +280,7 @@ test_expect_success 'commit: wildcard *' '
 	)
 '
 
-test_expect_success 'commit: literal *' '
+test_expect_success 'commit: literal \*' '
 	git init test-c-asterisk-lit &&
 	(
 		cd test-c-asterisk-lit &&
@@ -328,7 +328,7 @@ test_expect_success 'commit: literal f\*' '
 	)
 '
 
-test_expect_success 'commit: wildcard pathspec limits commit' '
+test_expect_success 'commit: wildcard f**' '
 	git init test-c-pathlimit &&
 	(
 		cd test-c-pathlimit &&
-- 
2.50.0
