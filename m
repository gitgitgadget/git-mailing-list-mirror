Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9F22424E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467076; cv=none; b=ORWUNkEjpLN4cXqY/6we7uTeXsbDluEgqTTqExXzEe48kJjLx/rFplhYeuFR42hmy8cIB46ivUdRjcgLlDmWs1zN0Y9Gg4entS+eUEEC5AuZ89pcBHIvpGf4jrlgybpb+6ZSxeaufWYk8XVvg8/vYQhf0Ia9aGDB+R2EpRf/Pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467076; c=relaxed/simple;
	bh=riF18k/LAirF4rNiB/SsdFRYNBcKuH81Pj1q/6cTHi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ex+NgMyXHDbzevK3wIA8b3v1YlFEHZEj1yPLn9Z+DvzYCzam6hvgAO9Ee70h56NzQXI+vbFr7RM67sDDSwQafEJMUx2zWcf6UkZ+dyk0EIalmN9+nlwGiDp/qLr65hpEzEG/X6oOWgOaBa9b8EWa0BSHKhYdjrrgWejW8xXYfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFszzjD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRsJuFqY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFszzjD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRsJuFqY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 854E3114016D;
	Thu, 20 Mar 2025 06:37:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 06:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742467073;
	 x=1742553473; bh=GFj5RpghGy1NuLzcRErjD9vatkd8uAB3ibP2Zwnk4GQ=; b=
	NFszzjD82fEKBG4DH7uotq6ZZmSII3mFIfdJ6EueLDfV1WVa4g0BEzdSbRBYa73J
	UHexlG5kKvZTY8gyyn7BzyQRU7V7M4SYJH2UkgxSbeO3hku7+Wk05+3/dVwJaLg/
	bf/qC4Q8YO87uU8tRtBfriMGS/8zECiS9SMcm6IQerD8Gw34HiwEaFU+rEvkeH/L
	F53KbpomdD9GxUn6c1pZ4xqTotDd+ifiKSCjFU+tQ5QrQyx6kqzd/XTatBM1ZMfd
	KpnUWRWKLpzkFpArzcklifVe4DRcBVjmsv0fW0jc0vTlo6bR35IZR646PulNk7qh
	3fBR7RKZ65Ttn0oyDLv17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742467073; x=
	1742553473; bh=GFj5RpghGy1NuLzcRErjD9vatkd8uAB3ibP2Zwnk4GQ=; b=g
	RsJuFqY2uCPyYcVGCbmwf9z/biqbxKitNu+nKiSUA564lBSjw/7+kkiaVJrdsiFR
	Z1V25Qp+BkbMrMsy8+h/3WF2yUAtfZeaDOlAEbwsknY11KSrYJtv4GV2Dy7iMFKn
	mUQm9aWzZAc0wJmpOz2P5cY5akoJDkrQ/y22g2Q1a+T/P/vxPZtqKQQNwZRNa9CG
	tnROta8P/L6Rv4OdigGEAyNoDX7F+x2AdVs3KT0aBfkRJknoxoUIuTSYEUDE4Ncj
	WDFvT9ln12IHP0KjfaW8iIbSn+ackw5Q7YC0fq8R/Gk7Imrze9EKh3F2RF/yOA5p
	0jwDBQRHDYn8bsjdDjzdw==
X-ME-Sender: <xms:AfDbZzNOxnWOU7x1I0pkQqKQ8S4oB4r15tShFwraDAoROdD-4cS4bw>
    <xme:AfDbZ985q-gjU4iVl0N5WQhH84Z_K1R4aKn-e27Km6LYH3iRY1b25gg3wspPR8N-Z
    lkmbXWqbLYAl6R1tA>
X-ME-Received: <xmr:AfDbZyRW2pmq97VIw01cinDtpdL3XHTN84opcw-2n4k38kQcZbOLMXcW7_6nDXj_sTY65vGp64wMr4KhfcY5r2a8pSx5u1p_Koy7Llv-Oll4PvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeujeeivdeufefhvdeuteetteffkeehieelgfei
    feegvdeuleekgfejgedtleehjeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AfDbZ3txbpHkuzcqeEZq8K0fK9j9mfS6ja3xtiHX9d0_BzvwoySwzg>
    <xmx:AfDbZ7eXoqkQ9WkasUbF-1ky-BrVvCrXKCbuE_FGH9oCiX-GrkwnmA>
    <xmx:AfDbZz2fI15aN64p9hVCimFPn_oyt_xTlHyMJeJnBjd6HgZ-bZRzoA>
    <xmx:AfDbZ38sFTsrREeVbacBEW2f9f7nQm_gPO9FqkSiCqNzUjJYu_qi8w>
    <xmx:AfDbZy4sqmirIDPEX9BzUUZrlnSPMm9phXh2RtjV26zUxbb3cVlBy-Zb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 06:37:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56222425 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 10:37:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 11:37:47 +0100
Subject: [PATCH v2 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
In-Reply-To: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In our CI systems we can observe that t0610 fails rather frequently.
This testcase races a bunch of git-update-ref(1) processes with one
another which are all trying to update a unique reference, where we
expect that all processes succeed and end up updating the reftable
stack. The error message in this case looks like the following:

    fatal: update_ref failed for ref 'refs/heads/branch-88': reftable: transaction prepare: I/O error

Instrumenting the code with a couple of calls to `BUG()` in relevant
sites where we return `REFTABLE_IO_ERROR` quickly leads one to discover
that this error is caused when calling `flock_acquire()`, which is a
thin wrapper around our lockfile API. Curiously, the error code we get
in such cases is `EACCESS`, indicating that we are not allowed to access
the file.

The root cause of this is an oddity of `CreateFileW()`, which is what
`_wopen()` uses internally. Quoting its documentation [1]:

    If you call CreateFile on a file that is pending deletion as a
    result of a previous call to DeleteFile, the function fails. The
    operating system delays file deletion until all handles to the file
    are closed. GetLastError returns ERROR_ACCESS_DENIED.

This behaviour is triggered quite often in the above testcase because
all the processes race with one another trying to acquire the lock for
the "tables.list" file. This is due to how locking works in the reftable
library when compacting a stack:

    1. Lock the "tables.list" file and reads its contents.

    2. Decide which tables to compact.

    3. Lock each of the individual tables that we are about to compact.

    4. Unlock the "tables.list" file.

    5. Compact the individual tables into one large table.

    6. Re-lock the "tables.list" file.

    7. Write the new list of tables into it.

    8. Commit the "tables.list" file.

The important step is (4): we don't commit the file directly by renaming
it into place, but instead we delete the lockfile so that concurrent
processes can continue to append to the reftable stack while we compact
the tables. And because we use `DeleteFileW()` to do so, we may now race
with another process that wants to acquire that lockfile. So if we are
unlucky, we would now see `ERROR_ACCESS_DENIED` instead of the expected
`ERROR_FILE_EXISTS`, which the lockfile subsystem isn't prepared to
handle and thus it will bail out without retrying to acquire the lock.

In theory, the issue is not limited to the reftable library and can be
triggered by every other user of the lockfile subsystem, as well. My gut
feeling tells me it's rather unlikely to surface elsewhere though.

Fix the issue by translating the error to `EEXIST`. This makes the
lockfile subsystem handle the error correctly: in case a timeout is set
it will now retry acquiring the lockfile until the timeout has expired.

With this, t0610 is now always passing on my machine whereas it was
previously failing in around 20-30% of all test runs.

[1]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilew

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index f524c54d06d..50c80b1b750 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -21,6 +21,9 @@
 #include "gettext.h"
 #define SECURITY_WIN32
 #include <sspi.h>
+#include <winternl.h>
+
+#define STATUS_DELETE_PENDING ((NTSTATUS) 0xC0000056)
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -621,6 +624,8 @@ int mingw_open (const char *filename, int oflags, ...)
 	wchar_t wfilename[MAX_PATH];
 	open_fn_t open_fn;
 
+	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void);
+
 	va_start(args, oflags);
 	mode = va_arg(args, int);
 	va_end(args);
@@ -644,6 +649,21 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	fd = open_fn(wfilename, oflags, mode);
 
+	/*
+	 * Internally, `_wopen()` uses the `CreateFile()` API with CREATE_NEW,
+	 * which may error out with ERROR_ACCESS_DENIED and an NtStatus of
+	 * STATUS_DELETE_PENDING when the file is scheduled for deletion via
+	 * `DeleteFileW()`. The file essentially exists, so we map errno to
+	 * EEXIST instead of EACCESS so that callers don't have to special-case
+	 * this.
+	 *
+	 * This fixes issues for example with the lockfile interface when one
+	 * process has a lock that it is about to commit or release while
+	 * another process wants to acquire it.
+	 */
+	if (fd < 0 && create && GetLastError() == ERROR_ACCESS_DENIED &&
+	    INIT_PROC_ADDR(RtlGetLastNtStatus) && RtlGetLastNtStatus() == STATUS_DELETE_PENDING)
+		errno = EEXIST;
 	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
 		DWORD attrs = GetFileAttributesW(wfilename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))

-- 
2.49.0.472.ge94155a9ec.dirty

