Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF63A2E18
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353689; cv=none; b=tjyMO7F8nFaJ1hds0xZofKEeU9Nx/7FhVFKe4cMCpev7VvXhqUVOXblq1+i4rk1g/23sL4wFGxKFjb6NLTh6It/TT9asIqlWD7w3HL3KmQCTsy0PemliEM+Kk+SfKIFV14rDkP4AyKLJ/2fMynINlE/IPQvwm9nS0hC/PMK0Wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353689; c=relaxed/simple;
	bh=P1Zxzy4/86iGeK45XMVZTSAvbmnEPbhUJSm+/OJTHhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcDxVGfxGqzCQZdGio+SjBCyOXrXVFicudLCYsY1jPWFYs+r0px8NWzm3aRd4leNyB6ja0JVzyYgS3DnQTivFytkjimzW2Bt09rchnQr7pbtu1kfvb8co10m/MaHQ0Wu5QmvAwZkLYGgO/JWJn1dsy28+sTUWjisgFJ3kOviRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=auFc1bop; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="auFc1bop"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WbPGadszUsiPLZnF7JFKdmqLoBBWoetp6JGGz8VK9WE=; b=auFc1bopCi6b2pVkocih5d5slp
	NzO+UtqjTFQJHeLEoxtUyZbJXEuZZ69Zf6rE/A68aYfHCCv5CqVAjqZshjj/tCwf7MdTFqHAYDb9e
	vTvByMgE/hqBhc9a8YFwEnoJrP7DHsbGS/aIl4mUtzyX/4Mk9C1OyyU1cAgri7iplh8oWYto3rTmE
	9nKysFJvBGt/Hce5NSIl/30LiacVmn9FjrQmRCN1uzXvXQAAq5fFvUP/hnpVbdnVGcG861GFNUwKR
	kW5qBz5wFGtbZoF5rky/zU1/Qh72CcPA9bbLwZM6u3R+D6+RJE/UgSH8iEBveo8d5E2qhg5Ux8ioh
	wcr6anTw==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT1-0000000740k-1Egm;
	Sat, 13 Jun 2026 14:28:03 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=localhost.localdomain)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT1-00000001VX9-0MuS;
	Sat, 13 Jun 2026 14:28:03 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v4 1/3] compat/posix.h: enable UNUSED warning messages for Clang
Date: Sat, 13 Jun 2026 14:27:09 +0200
Message-ID: <20260613122711.38662-2-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
References: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
 <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

Use a dedicated Clang version check for the UNUSED macro.

Commit 7c07f36ad2 (git-compat-util.h: GCC deprecated message arg only in
GCC 4.5+, 2022-10-05) restricted use of the deprecated attribute's
message argument in the UNUSED macro to GCC 4.5 or newer.

Clang identifies itself as GNUC 4.2.1 for compatibility, so
GIT_GNUC_PREREQ(4, 5) does not detect whether Clang supports the
deprecated("...") form. Add GIT_CLANG_PREREQ() macro and use it to
enable the UNUSED warning message for Clang 2.9 and newer.

Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
---
 compat/posix.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat/posix.h b/compat/posix.h
index faaae1b655..273cb87101 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -12,6 +12,9 @@
  *   ... code requiring gcc 2.8 or later ...
  *  #endif
  *
+ * Note that Clang and other compilers define __GNUC__ for compatibility; use
+ * GIT_CLANG_PREREQ() to check for specific Clang versions.
+ *
  * This macro of course is not part of POSIX, but we need it for the UNUSED
  * macro which is used by some of our POSIX compatibility wrappers.
 */
@@ -22,6 +25,15 @@
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
+/* Similar for Clang. */
+#if defined(__clang__) && defined(__clang_minor__) && defined(__clang_major__)
+# define GIT_CLANG_PREREQ(maj, min) \
+	((__clang_major__ > (maj)) || \
+	 (__clang_major__ == (maj) && __clang_minor__ >= (min)))
+#else
+# define GIT_CLANG_PREREQ(maj, min) 0
+#endif
+
 /*
  * UNUSED marks a function parameter that is always unused.  It also
  * can be used to annotate a function, a variable, or a type that is
@@ -35,7 +47,7 @@
  * When a parameter may be used or unused, depending on conditional
  * compilation, consider using MAYBE_UNUSED instead.
  */
-#if GIT_GNUC_PREREQ(4, 5)
+#if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
 #elif defined(__GNUC__)
-- 
2.54.0

