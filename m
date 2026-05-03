Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906A344025
	for <git@vger.kernel.org>; Sun,  3 May 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822143; cv=none; b=S1HXLA37NgjXPF54AgjSCnZVWy0oTA0LdTku7w7Jg8dv+USBQBgMlApBEbsGgSNyKSE73kpakL8vbZrlN2kwmORp3B9jjVIy7el63G+h3OJa1bS4qmG8jmslyk5anNeL2r5pnLrDmoH5QX/t3vXht09mnj7rrvuppCnRmUHM4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822143; c=relaxed/simple;
	bh=yTiqn1tz9gq+PpXWdwIh2lUL8+wNAFGjmrC4uS5Y+Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUQay6zbRi91I59ZNS86DGGkNTCKQmsoKGhL0twHQaO+HLvcouFZCVa3B4qSU//3sP58EUim6BGS4QEMsinjwZPNeQVA0/hvAxhELZsYvhcIhjvo7S4Akn4Q8rW9bhr60o3JUjhfWnbNZ3MgRFURIrXRs6OU6ADM2Eh7Gkt5B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=lJP53ezJ; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="lJP53ezJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=BhaAptAiLsMtjT2SdC2zdHCO/Wze/yXedYLo/jz1AHU=; b=lJP53ezJ3dq1VkJRFVySJVkapn
	0V6LSIoY7QFND1TtAs/yvtRGXk0EuUxalDVe3lR5LuFEB3IjTAmc0Z7ekO9do1jJQe4t3m4foUP/x
	D60KlhqwVrcb5x9qX//s/AtdOwZAMQ7p8aPckkG3WiDBJWzhY6WcLKRywH6Dc2aCMGg1fTvMCIwXv
	aVGm4witdzcIgxdG2NODZhK+pABSyDbKgvm6rFPFUiIQCB78OM+6IxOfc8mKX/WdrUWpVm5K4929h
	T90fSnhw7B4wJoLHaUCafmrISPFR0ngTGIPc4w8VOjcmwUgHbl9KX/tS0PlG0Z0HKoW+p2IVRcI9Z
	kaqWFQDA==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.2)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wJYX3-00000008vnF-0azX;
	Sun, 03 May 2026 17:14:57 +0200
Received: from 84-115-217-9.cable.dynamic.surfer.at ([84.115.217.9] helo=localhost.localdomain)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.2)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wJYX2-0000000DjZI-3uiW;
	Sun, 03 May 2026 17:14:57 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: git@vger.kernel.org
Cc: Dominik Loidolt <dominik.loidolt@univie.ac.at>,
	=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?= <asedeno@google.com>,
	=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] compat/posix.h: enable UNUSED warning messages for Clang
Date: Sun,  3 May 2026 17:12:10 +0200
Message-ID: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

Treat Clang like GCC 4.5+ so using an UNUSED parameter emits the
intended warning message.

Commit 7c07f36ad2 (git-compat-util.h: GCC deprecated message arg only in
GCC 4.5+, 2022-10-05) restricted use of the deprecated attribute's
message argument in the UNUSED macro to GCC 4.5 or newer.

Clang identifies itself as GNUC 4.2.1 for compatibility, causing the
current check to use the deprecated attribute without a message, even
though Clang supports deprecated("...") since version 2.9 (2011).

Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
---
I am not familiar with git's minimum compiler version but this patch
drops support for Clang < 2.9 from 2011.

Dominik
P.S. This is my first patch sent by email. Please let me know if I
missed something.

 compat/posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/posix.h b/compat/posix.h
index 245386fa4a..ed83a4d9d4 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -35,7 +35,7 @@
  * When a parameter may be used or unused, depending on conditional
  * compilation, consider using MAYBE_UNUSED instead.
  */
-#if GIT_GNUC_PREREQ(4, 5)
+#if GIT_GNUC_PREREQ(4, 5) || defined(__clang__)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
 #elif defined(__GNUC__)

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
--
2.54.0

