Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEA1EE01A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922748; cv=none; b=Elxt8UtboaSQvlnwHIS7YbPRMOx5jGrhBV4zZxzDTOf33xQOKVSVtN/uXb7akW641RcQi/V8uyn8K+FpdxH9yivcEsjyTQvf9IaadEW8F2frWVX1tCuexT6c+ypIXPLLA6+EYua2tSFkt2vuP1vffu9cj5eIhhrSmqGbHKb+xBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922748; c=relaxed/simple;
	bh=8LYIAxemGHStzoWKvgMovmH9rsD5xx6SeAkNiEH92b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACNBaEE6MQ8325ZpA3a3jCeSgwfV5AjoulnfpaY2FCyPBztTAMl45Yu/0KXp7qONdxcBB8ZgV4OmdvG8ADl997fzW4ehuBFwMFxWymXHO2kO7KIz4I4kPt/Ej5kH/I/xJz0fVbL6fwmskV/PIeInbeir5f+6tnl/1yeco4avTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=DAuGbDvd; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="DAuGbDvd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/IhEsaN3PnO2fPSqpoXkyBZsZMTozc4+j18BenPjoSQ=; b=DAuGbDvdvA+Hw6M6Pcs+o2iZg6
	BcfuPi9hKSZj9rwmK8khJYo6FoXY6ZAivmow6ceAkhMgSqHJa1WS1a3Ihzc0+BGjt4geL+PRLPJSP
	TAFg5GGkIxsVPeEf49AUgbNWs6AYWrW0yHaopbNNA9U5ZitKHNSXr2evJi2MkdUaVzWxQS97uRxiZ
	y/fLkvndtdIOnvgRSgNGkfyPXL3utsnHuXnKF+ws4cop/MNQSR9CmnK92j0tbyGcwAP+UsSQuRx8P
	TOBoljbN7R0Slv2LJQfo6Eo/ahDvxOvSyVc+1ft3hRD2Cc53m8sgRhxVI4ZcPSNpFRK24AUrDAGxK
	Coz43IXw==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wWZMG-0000000DQph-2LG9;
	Mon, 08 Jun 2026 14:45:36 +0200
Received: from [2001:62a:4:42c:9c6e:8d7c:8076:a7dd] (helo=eduroam-077-080-000-213.wlan.univie.ac.at)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wWZMG-00000005u8X-10ol;
	Mon, 08 Jun 2026 14:45:36 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v3 1/2] compat/posix.h: enable UNUSED warning messages for Clang
Date: Mon,  8 Jun 2026 14:44:18 +0200
Message-ID: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
References: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
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
v3:
- fix comment style nit
- remove unnecessary parentheses around __clang_minor__ >= (min)

 compat/posix.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/compat/posix.h b/compat/posix.h
index faaae1b655..ffdfd91c7b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -22,6 +22,15 @@
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
@@ -35,7 +44,7 @@
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

