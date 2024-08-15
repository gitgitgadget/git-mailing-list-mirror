Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C1370
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765787; cv=none; b=GsKkRoR199AP99j3/uWKj9DXokIV0S77Mk6EBkyW96VavtIDP8zDSPacjzlP8Lo+R7l55as/ECkX6dNSQQ3xpeujP/kMBMAb+I5MyDMzp4opia/vNFVngk3uNMJca9f+Ibz1g4O1sDOEAf/WUJteuYsDMXllsr9ZGzexsrtN79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765787; c=relaxed/simple;
	bh=o9DkTGafdDYxpdWlQNf3kxiUmnfBy6PlD34V1HpijNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xsu7yWm2d1ZS3pamN7V8gcoTzpUYQdHNO7K7vwVmzhNU/w0tlox382kUGgoANOi4jZ9BWJ5h7bC70tVPmS3np9F0pa1OWgtKmn1g0AKK08nOb6bYPTS7TezCbC1uI79AC2h75MORY7vm/4HzTJmDxdLgojG2EB3W3itlkLUOEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZCAHYkG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZCAHYkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765786; x=1755301786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o9DkTGafdDYxpdWlQNf3kxiUmnfBy6PlD34V1HpijNA=;
  b=lZCAHYkG9QPiWC6nULmpvyP4R4tmour3ay//75sF6eR+f77zPtxQfi1c
   /ctJT/epzrSss0lUYXQg+6onk0+bSJ1c7wrHQyoQxKgDj1aEUC7UT4dh0
   T37+C2nsGwdQdA8At6mIIe/HH5EjC6fVTvpCstXcGvfJnpfYkhm6RgRL5
   lg7OYMY3lwfmgjifm7jgJjd9FAgu8w7nDoh04Z2hSprcZLaEFlNDAe4Zr
   y6wrl/aOU9o/gxux7Lc2zbX+bLvEQWjAmp76mB/u78vDa4J5kZgZ+T43D
   Qp64SGWc0NI10vvAvfY5AQJr2Yc1KA81CcNgTw2RfvMMWKgrC2QZM/H8R
   w==;
X-CSE-ConnectionGUID: +1/Jc+5aQwyZHOYtJEG8Gg==
X-CSE-MsgGUID: JCgHBgrcTJmmdIlMhXFS9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22193838"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22193838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:49:45 -0700
X-CSE-ConnectionGUID: ddlL3+zwRJuB+M6h/ZdeKg==
X-CSE-MsgGUID: Ic7Fjsa5QnuMTQdQuBbr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59666100"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:49:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 3/3] fixup! send-email: teach git send-email option to translate aliases
Date: Thu, 15 Aug 2024 16:49:24 -0700
Message-ID: <20240815234924.3963696-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.46.0.124.g2dc1a81c8933
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

Two of the tests added for --translate-aliases did not set the
prerequisites, so systems which build without perl support will fail the
tests. Fix this.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 13f1453eebb9..c5e862694e16 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2202,7 +2202,7 @@ test_translate_aliases '--translate-aliases gnus format' \
 	(define-mail-alias "chloe" "chloe@example.com")
 	EOF
 
-test_expect_success '--translate-aliases passes valid addresses through' '
+test_expect_success $PREREQ '--translate-aliases passes valid addresses through' '
 	cat >expect <<-\EOF &&
 	Other <o@example.com>
 	EOF
@@ -2213,7 +2213,7 @@ test_expect_success '--translate-aliases passes valid addresses through' '
 	test_cmp expect actual
 '
 
-test_expect_success '--translate-aliases passes unknown aliases through' '
+test_expect_success $PREREQ '--translate-aliases passes unknown aliases through' '
 	cat >expect <<-\EOF &&
 	blargh
 	EOF
-- 
2.46.0.124.g2dc1a81c8933

