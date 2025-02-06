Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D3156968
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828444; cv=none; b=XxiOPCcwXoHmRPGDq7u7QWigI4ZFGad76hs/qrMgxJGDSryUrjze6DJSap5Nwmc9lkU+wWw8GGElUHXbJtvTdF09WKWgXzLYJcgbQD5s+fO8/LUxmfX3TrfFQX0wBuqIaboCZyZaYdxxu6+JKph+FqzIil6nS/lOJ3cNJ1bHdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828444; c=relaxed/simple;
	bh=edpcq+5Hl9TBrC2J2xICYoOLOH4AvQPaoIV73Yc7Zjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=nvfjNmCy1Xy1U88MzNIqclIRyAPXbJE72mm11lj/Cy7e0Ktl2vKTnz5NVWZFRWy9326apG9Cr4cCqfxzDiedpdctGoDJXhLJvh6UsYQcW00sSbYARU+nShXR7f9dVD3Y3GPMTnsqMrR5iIN5OsG1r2IVI7c4AqMjYUR69rEW4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=szJEVw0V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpOmgt5R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="szJEVw0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpOmgt5R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3324D13801B6;
	Thu,  6 Feb 2025 02:54:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828441;
	 x=1738914841; bh=o3UwbQ933v/xsq9vK6FA1Sc7R/dT+PGo3ynUJ1LaLoU=; b=
	szJEVw0V25DztR8FUgG+nmNPsLu+nWNe0s4VERSEpIuGsFT5wxgGrySibmQzNnKR
	r0OJTWNxL0zxDC56W788VAEL2kBstNkA7Jbkpq5CPE35kDndgpLPYfufT2cne2I6
	xcbi0X+FmwMCYiZe9cwPqoXlGZTECokZzrPCCPaxwW17n0OBlFQgAe9xPy6K1W9x
	67mtE6/ML3fWTaOtU+N6F8ZpG/8sGJAKzMNTuGp3MW3seUgAV2phQrvjkuO0j6OM
	8458ObCka2ZEoDN29p7qeHaLY4fBpqUevQZyqIA8J9qpeSptcR3/PDeIt1LguoN3
	upt+e6vNjQ6NlXInM6Rtmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828441; x=
	1738914841; bh=o3UwbQ933v/xsq9vK6FA1Sc7R/dT+PGo3ynUJ1LaLoU=; b=T
	pOmgt5R5+CWtz0uBQPi4DYuvtnRO9mcQ0RNqBajxrdzM71oAelUhT/q/6ORa0QHH
	vf3ssfyOO0pvhKRLBS71t23JEMeDLa3sGsDvrP5JDcMRTqDWziAFGGVolBK341tX
	2F+nZcAd12ytSgtXHoJHEoL64Fn9wcbKypmYAmFXosi/7YLXs9qUDVo/daaP/vjz
	4OKsFt3vvkFtYitCegyXf+1V4V7uhcXP56wWKad9CFCcVr3QiqgdaWFAlkui+5vT
	sE6J9BD24MJRXEm5FLOcbtFgw9OqlpyBWZ612iNLn2ewNgYiUdsM+iSp5TKYf6hf
	hZ5LzVzYvKRrJeRrnoS1g==
X-ME-Sender: <xms:mWqkZx5vwA-40CUU2RxqCyFbgMmBrjKKZXRxqQNRfs9Bnw760JmLCQ>
    <xme:mWqkZ-5fYlTvhSEazjfmMhufKkZlOB3iy-XZe3AHILIVHt3UREOP2GKibg9tfvCQz
    sENOk6lcYISht48Ag>
X-ME-Received: <xmr:mWqkZ4cE2xqAu_2DwqRD_iC13eiAbkdTSoh9jz0nx4uJbF20vKPXzhBnM7Y01LTQYHCF1NykecXI7JuW_YW3rmnAWJJVp4pn_okN1QXhmalt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepieduvddvfeegudfhteegueffjeelhfekheefkeet
    ueetleehuddtieefkeettdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghg
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepiihothhtvghlsggrrhhtsehtqdhonhhlihhnvgdruggv
X-ME-Proxy: <xmx:mWqkZ6KjqbjeOLEouhSzZFg0hNCsGA6BcnJr2yS4Hcip9s1N33vSYg>
    <xmx:mWqkZ1L82ZpQJ0aC-9__CiCpB4uAAc6kk8tYtvqv6uhu86qUNC_l_Q>
    <xmx:mWqkZzy3AABvWYJyEilSMfAdVXwj9ryBZzwQZb5miMTxp7CA1VZEpA>
    <xmx:mWqkZxJ-2wpCPFyt9gwkr8Z7_W0LtdIbpsQzsPrOpPYALLE3T8b7XA>
    <xmx:mWqkZyH9I3X1S4JdKsW66VOTKioHRJ1iHm7Ut9h4mzIp8t0Zy5Au0hgv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:54:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21ce4c0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:53:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:53:58 +0100
Subject: [PATCH v2] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
X-B4-Tracking: v=1; b=H4sIAJVqpGcC/42NwQ6CMBBEf4Xs2TW0FBBP/ofhQGErG7WQLaKG8
 O9WEu8e32TmzQKBhCnAMVlAaObAg4+gdwm0feMvhNxFBp3qPFXaoDU4XgMKuamxN8In+0wje3w
 EQhIZJGBVVKYyTrvOlRBNY2zza3s515F7DtMg7+10Vt/058//8s8KFWZ50dm2PGTWuFOc7PkO9
 bquH0l1eM3TAAAA
X-Change-ID: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7
In-Reply-To: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
To: git@vger.kernel.org
Cc: Christian Reich <Zottelbart@t-online.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Unlinking a file may fail on Windows systems when the file is still held
open by another process. This is incompatible with POSIX semantics and
by extension with Git's assumed semantics when unlinking files, which
is that files can be unlinked regardless of whether they are still open
or not. To counteract this incompatibility, we have some custom error
handling in the `mingw_unlink()` wrapper that first retries the deletion
with some delay, and then asks the user whether we should continue to
retry.

While this logic might be sensible in many callsites throughout Git, it
is less when used in the reftable library. We only use unlink(3) there
to delete tables which aren't referenced anymore, and the code is very
aware of the limitations on Windows. As such, all calls to unlink(3p)
don't perform any error checking at all and are fine with the call
failing.

Instead, the library provides the `reftable_stack_clean()` function,
which Git knows to execute in git-pack-refs(1) after compacting a stack.
The effect of this function is that all stale tables will eventually get
deleted once they aren't kept open anymore.

So while we're fine with unlink(3p) failing, the Windows-emulation of
that function will still perform several sleeps and ultimately end up
asking the user:

    $ git pack-refs
    Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
    Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
    Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n

It even asks multiple times, which is doubly annoying and puzzling to
the user:

  1. It asks when trying to delete the old file after having written the
     compacted stack.

  2. It asks when reloading the stack, where it will try to unlink
     now-unreferenced tables.

  3. It asks when calling `reftable_stack_clean()`, where it will try to
     unlink now-stale tables.

Fix the issue by making it possible to disable this behaviour with a
preprocessor define. As "git-compat-util.h" is only included from
"system.h", and given that "system.h" is only ever included by headers
and code that are internal to the reftable library, we can set that
macro in this header without impacting anything else but the reftable
library.

Reported-by: Christian Reich <Zottelbart@t-online.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

This patch fixes the issue reported in [1].

Changes in v2:
  - Rebased the patch on top of ps/reftable-sans-compat-util at
    3f172f1391 (Makefile: skip reftable library for Coccinelle,
    2025-02-03). This is done to fix a semantic merge conflict.
  - Link to v1: https://lore.kernel.org/r/20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im

Thanks!

Patrick

[1]: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
---
 compat/mingw/compat-util.c | 5 ++++-
 compat/mingw/posix.h       | 8 ++++++--
 reftable/system.h          | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/compat/mingw/compat-util.c b/compat/mingw/compat-util.c
index 1d5b211b54..0e4b6a70a4 100644
--- a/compat/mingw/compat-util.c
+++ b/compat/mingw/compat-util.c
@@ -302,7 +302,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
 	return wbuf;
 }
 
-int mingw_unlink(const char *pathname)
+int mingw_unlink(const char *pathname, int handle_in_use_error)
 {
 	int ret, tries = 0;
 	wchar_t wpathname[MAX_PATH];
@@ -317,6 +317,9 @@ int mingw_unlink(const char *pathname)
 	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
 			break;
+		if (!handle_in_use_error)
+			return ret;
+
 		/*
 		 * We assume that some other process had the source or
 		 * destination file open at the wrong moment and retry.
diff --git a/compat/mingw/posix.h b/compat/mingw/posix.h
index 8dddfa818d..88e0cf9292 100644
--- a/compat/mingw/posix.h
+++ b/compat/mingw/posix.h
@@ -201,8 +201,12 @@ int uname(struct utsname *buf);
  * replacements of existing functions
  */
 
-int mingw_unlink(const char *pathname);
-#define unlink mingw_unlink
+int mingw_unlink(const char *pathname, int handle_in_use_error);
+#ifdef MINGW_DONT_HANDLE_IN_USE_ERROR
+# define unlink(path) mingw_unlink(path, 0)
+#else
+# define unlink(path) mingw_unlink(path, 1)
+#endif
 
 int mingw_rmdir(const char *path);
 #define rmdir mingw_rmdir
diff --git a/reftable/system.h b/reftable/system.h
index dccdf11f76..1492bf6d70 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
+#define MINGW_DONT_HANDLE_IN_USE_ERROR
 #include "../compat/posix.h"
 #include <zlib.h>
 

---
base-commit: 0fb5c2116049c665c6550d7e0419971a277af345
change-id: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7

