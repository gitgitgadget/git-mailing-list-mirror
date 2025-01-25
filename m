Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C208155326
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737783711; cv=none; b=OPmekXFgnBiXCfY2VWy/xrwNUhtUneS7JYm1WJAoy9M02zqVnbvfm/twEyC07/o7YKf3bYldlcgTdwnndFlAaA6lNC/nWs1FW/Uj94rBwZQkAnOUSR+vVIvPUVPwlp8XCZrMuPaAdegompB2cUvgeMftZN7XoexKp9Jie6tL3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737783711; c=relaxed/simple;
	bh=xKsyxc+fq65l/nAUrJmRKAO2KKLKAWffoCWmCvn6e+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g1UW6Gh5sVY0F+xhUEEueUe8Q30UzJbRWFb/Xbd2yoB8f6FaVAuzeoAVsspc0xB04KmIA1/TNnfjaVaGlu6mJGZL+b4116AQzdCBSpMMQFa/X3gVzzF05RH/cfLV020CjCWItHdjk5raEJG9eWBSrgrRfjJOszxkW6rtXslVoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o4JNf4xF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJXCTl+C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o4JNf4xF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJXCTl+C"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 76D7B1380A0D;
	Sat, 25 Jan 2025 00:41:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 25 Jan 2025 00:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1737783706; x=1737870106; bh=w1UlRc+48v
	4ZX10hOPFBUi4A9/IRG/dyfQGUUTU9D5o=; b=o4JNf4xFN1BD53WubHUccouZgF
	Hy4NKN8/HbLW6pFR+1i5EP4TCop+9UIoRnD/waVrl3HHtQHt1F8R7Xl/QiShAY1a
	6ZGl5tBNqkZ1iyZD1LSN6nDmlmbRJ0xhufAZVAphWj/C8iHr76mN/WZnCKOBkvUn
	B0/s//UVI886EeUZzB0LLxSHfikBcSouwMliZYLhrm+V8xOJbcL/DuLTU8X0zmKd
	cYBG5d+4tS/i/7CPxOC3H9y4smNGk6sdRsMXIh646P/AE38LSc9nDuKn0D6CjW9F
	FTKDVgQ/HozdgkKylpIAREDNrVsqtJaZJ8a6jd2U9qW9r8SQBjfVdmrE1oLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737783706; x=1737870106; bh=w1UlRc+48v4ZX10hOPFBUi4A9/IR
	G/dyfQGUUTU9D5o=; b=RJXCTl+ChNAEJOLJgpfGmgRyC800YHjg2nDCxVLbjLaC
	B8Cyn59+hmt+qbwp/PsDNhRZhyEkjqwsInWViUK3xCllsDeoWzZsPug1xX/jQ1M2
	1fBWp5vtwU4T/3HFMGVoLbVomM4Bnv1j5/nMrJ070KdqnLhcLMScSLTLXoqZAaCQ
	Yqn2cpXNF3dUzVdKmFXIDhXBzPmZIwbPNHi+Eo1nfJSNYGVtrJFnNzMoTyEbqK7q
	3YIUnaT++zam8oXK/HFgYOI8JYDB3vDF+4EQsbInxh7rxSYal21zhPp08JqdWjw8
	wi9yHHIWqCU+9asE8LgNBIl2ptfXkUcQ23RhYYSL+Q==
X-ME-Sender: <xms:mnmUZ3EvK7tKYn3k6iWznW88BtZEMrrCW7ZzVAqLb2EfhW_ncI81Lg>
    <xme:mnmUZ0XVJIDdDtUNlyQcAOwfiCq1uNgTKcSLJzFlN5DJSsUJW_8tcMcO1sqbtnKYp
    P7DBuWp1QnjjMHaeA>
X-ME-Received: <xmr:mnmUZ5IkRxDjpM993x1ais0v8bJGZuz4okOVowe6zq3k39ZnnD6Y9cTboGnFkbHvyb_vx_JDgt4NOJPRSj0T9xAxipgxXWU-tGyYn10hMIZf0UOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgieehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhheekkeeg
    gefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiihothhtvghlsggrrhhtsehtqdhonhhlihhnvgdrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:mnmUZ1EqoXDwSrYzFhCZoiEeK-aFLgf6GMmCUFSdNGTx9z2IR67oxA>
    <xmx:mnmUZ9WOkz2UOGk-WpQhUDlzwbYgmwubN9rI-fWNwMz6pLjknRIO5A>
    <xmx:mnmUZwPLaa2JGPBLrpX-TzxATKxyESTHNFTSzeF6xxiBuU7QIpB3Dg>
    <xmx:mnmUZ82z0RVzbHPZY_u_cajWPvQYV7hCK4zn7JP_sMX7Gqgahutvmg>
    <xmx:mnmUZwRu0SkH7IE_h8KJGkFKla_y6Q7LR58YehvdqB6mdg7IjGEh6fo0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 00:41:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 181ce2a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 25 Jan 2025 05:41:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 25 Jan 2025 06:41:34 +0100
Subject: [PATCH] reftable: ignore file-in-use errors when unlink(3p) fails
 on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
X-B4-Tracking: v=1; b=H4sIAI15lGcC/x2NzQqDQAwGX0Vy7geabi3bVyk9aM3W0LJK0j8Q3
 93F48Aws5CLqThdqoVMvuo65QLNoaL72OWHQIfCxDWf6oYD+oD56TBJ765/CX6ajwzN+LhAzCZ
 zxDaGGBKnIZ2plOZi63+/XG/rugGkAt6CdQAAAA==
X-Change-ID: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7
To: git@vger.kernel.org
Cc: Christian Reich <Zottelbart@t-online.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

Thanks!

Patrick

[1]: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
---
 compat/mingw.c    | 5 ++++-
 compat/mingw.h    | 8 ++++++--
 reftable/system.h | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1d5b211b54..0e4b6a70a4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
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
diff --git a/compat/mingw.h b/compat/mingw.h
index ebfb8ba423..a555af8d54 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -224,8 +224,12 @@ int uname(struct utsname *buf);
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
index 5274eca1d0..fe94bf205b 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,6 +13,7 @@ license that can be found in the LICENSE file or at
 
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
+#define MINGW_DONT_HANDLE_IN_USE_ERROR
 #include "git-compat-util.h"
 
 /*

---
base-commit: 4e746b1a31f9f0036032b6f94279cf16fb363203
change-id: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7

