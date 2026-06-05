Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFC3BBFC0
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652896; cv=none; b=Ta8NfcvJzEXzl48MWAt70sN1IeJpRDWNJh1ugCugTy+0GP4eeSakKckfOjbT9CWlhPldBEuNnOqlTf4sAjodUdbHhN+dt72qvkPY3vPaWv5XJAa125WIBNgwDrXYeTdq0tCt/hhT9uVBAZvCPtH1br88DW4l2QnpuGCxC8HvzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652896; c=relaxed/simple;
	bh=RER9cGgdFUZmK0x9Xfu2b5Kp3PvGVjZhj7bQN7zTF8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/oiQKphTCstrzJIRgPgw9SUjwvnafcYIf9fbpMf3LvsrYO1NP3wEJ5A+hfSMtD/7OMRuNJl+mQ6XQaFwF3gVimGrKtxu94YPHoyZoJ+Bky5KmjP/GFKGiWdTVEE2PfR/byKPhZhmvzxqIGsRtq13lqKAvn6NPyOZNN1HmHVs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=QNYsM1Xx; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="QNYsM1Xx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C+FtcO4NgOkZKe9r6y4BZhEYbu2mqB99aUZW6fRe0tg=; b=QNYsM1Xx3izwo8k+cg7LNIndtb
	GqdA2n0rDsyj3t8zOhNN63iduc33wdQq2Zg2d/+h5BMyOVBOatb2MuRaoMg5a10HyYxJl6payiYUy
	Tq1k7J+hMb1Gevj+DXrGMs31LgrBnUzBOggheKyNPW5dBbj+tE6oRkOMxhUiz56fDqh7P3igb1UNr
	GkHe1R34BP7uIFjQScZHCOpGY7a5+ItfY+HXRddW8cmROdnGZhjmUOtyOpAqiMp+d8XGe8672Zc4M
	gM2QXUaupixqlMYuQzvhYZ8v1e4l3z1iaQQfPNwsyby1VpKGeSRCadHOcLrgKxSUZ0dM5OUf5YkU2
	ZoI/RoOA==;
Received: from jarvis.univie.ac.at ([131.130.3.112] helo=jarvis.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVR9v-00000007Lea-0Ijk;
	Fri, 05 Jun 2026 11:48:11 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=localhost.localdomain)
	by jarvis.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVR9u-0000000B0O8-3584;
	Fri, 05 Jun 2026 11:48:10 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v2] compat/posix.h: enable UNUSED warning messages for Clang
Date: Fri,  5 Jun 2026 11:46:47 +0200
Message-ID: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on jarvis.univie.ac.at

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
v2:
 - add GIT_CLANG_PREREQ()
 - require Clang 2.9+ for deprecated("...") in UNUSED

 compat/posix.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/compat/posix.h b/compat/posix.h
index faaae1b655..88ad29d74b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -22,6 +22,17 @@
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif

+/*
+ * Similar for Clang
+ */
+#if defined(__clang__) && defined(__clang_minor__) && defined(__clang_major__)
+# define GIT_CLANG_PREREQ(maj, min) \
+	((__clang_major__ > (maj)) || \
+	 (__clang_major__ == (maj) && (__clang_minor__ >= (min))))
+#else
+# define GIT_CLANG_PREREQ(maj, min) 0
+#endif
+
 /*
  * UNUSED marks a function parameter that is always unused.  It also
  * can be used to annotate a function, a variable, or a type that is
@@ -35,7 +46,7 @@
  * When a parameter may be used or unused, depending on conditional
  * compilation, consider using MAYBE_UNUSED instead.
  */
-#if GIT_GNUC_PREREQ(4, 5)
+#if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
 #elif defined(__GNUC__)

base-commit: a89346e34a937f001e5d397ee62224e3e9852040
--
2.54.0

