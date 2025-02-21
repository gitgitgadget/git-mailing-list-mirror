Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4F206F01
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181717; cv=none; b=jj3dDCjTJLnraaQen7tc3op8nk8KYV28JOGKCEYebaCfBI2hcCIt4BqgDsKw8cSPAj1nj1Qg+EDrxCBhAWixQCsNZ3x3qvXpJ7/9i7UabGDvjgMqrsALfdO/sD295WrrBKOmO1Ji08juGlN5dDN/RyggpJouXgYhMdxzZY/gAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181717; c=relaxed/simple;
	bh=HqNGe01NcGowBnISX/USoLb7NJpXOF31xynKsPYAHfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q8A+u8si0alvcYNmpbmkKf/DUgqUbOrpO4SjyrZTsL0hvnLrBbSQAPxi8fV4T49/5Rf475ybwEEORmQ6LgU93y2nivIvWEMI1cSS1USB7UnUYB5agidg8LbQf3LcEvk/i4YApu9qEse05J+ZgpR4Pe0nFLtxFSP5Ijr1J5rIqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzCFqHec; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzCFqHec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740181716; x=1771717716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=HqNGe01NcGowBnISX/USoLb7NJpXOF31xynKsPYAHfI=;
  b=LzCFqHeckcFLJ55d9mgcATF3MwqaEAOJeuzAlVzXF2Uqvk+izz8gfLsg
   VmPN9DyeLJWoXtpvH6QK32U3SSJ5x9dxHI/ZMlF2595p4K44iaX7ViUgQ
   JvORqYu+fHtE46IBLMuVmkaj1MOBkQfoRnuI7/ikvjyPutesK5jZS2Cyr
   go5Pbi3oKt8WKxlW9CthK6Hs0H1NG6oMuePML4XmfNB2yRGffs9+xQO9o
   Lt174rXEk3hc27TEY1bQqpgi1d0IGmir2e3IkmwPR9/locVA7NbWes13k
   f2jdtwzR1n8lXMSXiixdxP4hF2h+yYPPfuXej2OXfoSpLLGqcjmqF14iS
   w==;
X-CSE-ConnectionGUID: mLksfoJcQPahgSTDNEa6EA==
X-CSE-MsgGUID: a+b9CTtTQY+CZ1QaWbP7pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51654833"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="51654833"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 15:48:35 -0800
X-CSE-ConnectionGUID: +Wd/cBDlQXuTEJbOe/BxZA==
X-CSE-MsgGUID: NlKgYfGPS96TizkEO0i5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115465203"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 15:48:35 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Feb 2025 15:47:58 -0800
Subject: [PATCH v2] mailmap: fix check-mailmap with full mailmap line
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-jk-fix-sendemail-mailinfo-v2-1-9aca7dc05dbb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK0QuWcC/42NQQ6CQAxFr0K6tmZagkRX3sOwgKEDVZkxM4ZoC
 Hd34ARumrz+39cFkkSVBJdigSizJg0+Ax8KsGPrB0HtMwMbrgxTifcHOv1gEt/L1OoTt6HeBSz
 ZGa476s5SQ75/RcnN3X1rMo+a3iF+91czbdt/rDMhoTWdOVmmyjFdhy072jBBs67rD3qNV6XCA
 AAA
X-Change-ID: 20250213-jk-fix-sendemail-mailinfo-32f027b1b9e7
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

I recently had reported to me a crash from a coworker using the recently
added sendemail mailmap support:

  3724814 Segmentation fault      (core dumped) git check-mailmap "bugs@company.xx"

This appears to happen because of the NULL pointer name passed into
map_user(). Fix this by passing "" instead of NULL so that we have a
valid pointer.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v2:
- Just fix the NULL pointer dereference, leave mailmap resolution as-is
- Link to v1: https://lore.kernel.org/r/20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com
---
 builtin/check-mailmap.c |  2 +-
 t/t4203-mailmap.sh      | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index df00b5ee13adb87881b8c1e92cac256e6ad319d1..be2cebe12152e38d3bb8cf12948823c8d710bdda 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -35,7 +35,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 		mail = ident.mail_begin;
 		maillen = ident.mail_end - ident.mail_begin;
 	} else {
-		name = NULL;
+		name = "";
 		namelen = 0;
 		mail = contact;
 		maillen = strlen(contact);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 24214919312777b76e4d3b2b784bcb953583750a..4a6242ff99b59ea1a46eb14ca812c94e5e620162 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -113,6 +113,18 @@ test_expect_success 'check-mailmap --stdin simple address: no mapping' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check-mailmap name and address: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Bug Reports <bugs-new@company.xx> Bugs <bugs@company.xx>
+	EOF
+	cat >expect <<-EOF &&
+	<bugs@company.xx>
+	EOF
+	git check-mailmap "bugs@company.xx" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):

---
base-commit: b838bf1938926a7a900166136d995d86f8a00e24
change-id: 20250213-jk-fix-sendemail-mailinfo-32f027b1b9e7

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

