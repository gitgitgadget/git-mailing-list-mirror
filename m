Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF026773D
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875481; cv=none; b=eVt0S3M93laAXxLsUE7l+rvz9KFc6dklruhdqn6FUBOjfRyGUuC0I5i5QFlS9rkoFMPKAXbyOeQL+AqgGXLX5LWPueqLRUZRWVxVJrByOJi+6yKQCA8kKeRopPqo1H5Ky0+BazzHxTH5cyuTGtNeESL1VAncuhl6sguQvKtRTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875481; c=relaxed/simple;
	bh=EPKBuz+se1g0fsXex8Fez681P4JfntC8LeZVz0DVBcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5XCx3WB2Bc5x+9kMQQvYOnhlA/lcbb2cAQxzvSkXSI4uNY64fw0k86Keej1wWv5bpvZeiBiJiEuTWGi1O3moR3lL73GP74cSiK0ogqHhOsDCU59sIaXShKJwmIVNYi1EhEZkaV3KvCi3U1N4WqyWquj/cVXLpyIfoU8bF6OEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gwLA5iYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxW3uUjx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gwLA5iYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxW3uUjx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 83DBD1382D3A;
	Thu, 13 Mar 2025 10:17:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741875478;
	 x=1741961878; bh=Uv+2hK3E17AFMT/Sf1tqoz3hDWcQM3JvdPM0flCSKF8=; b=
	gwLA5iYiiE0Xyv1iXWeHU5Bdw76gN4la9eMxktqxoAPv7XLDFxXgrpD+r37o+JJC
	rJrI4Fott5inqTc7gAqeMqHO3DbecDX+Cz85Ia37nG8car92CjSnZq65HMSV8Qny
	agcMWoom+lpVHjBUrNJTz7ggIUyFBs0Tg2k4+e2R5Y1mEXyzXJLusaRU6vugF5M8
	JaxqIDNN0KNVZ+O9d0V1ZkGmCzNgFUbTzoTOroMdYz+pHf04cQW05mgQpBDJTgfp
	JWBsZUH/JYPB4car3gC0Os9JBRekmhV0jkT292uoSYD4YkS1l4nxjiBnRftZ8mSR
	GUitmmfremH9s1jEAzcJHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741875478; x=
	1741961878; bh=Uv+2hK3E17AFMT/Sf1tqoz3hDWcQM3JvdPM0flCSKF8=; b=q
	xW3uUjxg4HQ5Xvj6fVij8wsRmRsrRLOESe4jt66HMnz7vxcI/GZ3Uq7YsY5BGHk9
	OSGDR9xxig3UnSar/IawIb3EBhRvttFJL/QJDO8ZlNoCKZqgS/EDKraExJo9V34r
	YGSsDCEJNdqkm5QMIwC1R79vb4hUXDm+Ic1Q5a1pp8WfsVubBS/zBAF659oSy8gQ
	MxfFtWJITE7OcFoOg3O24mBHCa6pyoM05576lfVEC78xX1nWtNK62h/+LywPAlR0
	TDurBeefY58ia3SE8lTzZsxZiyHOPxBbJFMA307xKyzG+Hxx64X0VILgkibd6/IB
	TksT43p3r1h2zJv+LtPnA==
X-ME-Sender: <xms:FunSZ74E-l9vHrwvRA4ljjsowVCIUfGkwEyX0pemk8nI6j5sfjON4Q>
    <xme:FunSZw7V1Og1MuC_JOYJ-Yw7fMKtNSR5JsSVw0F7JWmjcaIg9wL8TrP--SzWFHHYD
    z-LZ0yYJJmYlrvc9A>
X-ME-Received: <xmr:FunSZyejUd53nPIN7_6JbflGujzoJcQmf9qPIFU03_zVaJ5WcZYJfo1XumWec83pu5iCca6w_SkY99oF1yUhJjq7OXlxyHnJrSoQ128GA-bzgY_JAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeujeeivdeufefhvdeuteetteffkeehieelgfei
    feegvdeuleekgfejgedtleehjeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggv
X-ME-Proxy: <xmx:FunSZ8LtLoCu2gwkPsG7oQ7COHAFfX1-MbGZ7Sh1oyogBzSdCoW_gQ>
    <xmx:FunSZ_JLs2SyZd64ByqefyY0wiKtLxfXLLwVAqA8RC9TtYh7IIm5iw>
    <xmx:FunSZ1xekVb7BgKoy-zS0rilQN_PLnKXQ55OjtmTsyRT8gT65d76kQ>
    <xmx:FunSZ7JmGa5XDzClSCtmjJ616gBJaKbjBYdjhPfBAy9NuludVPVvZg>
    <xmx:FunSZ32zTB9GMpYm1WZDPd9rgq83fRozFaMDcHzzqmSB8Lkj7mRGw_QR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:17:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ba5e19e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 14:17:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 13 Mar 2025 15:17:44 +0100
Subject: [PATCH 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
 compat/mingw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 101e380c5a3..fb61de759c7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -644,6 +644,19 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	fd = open_fn(wfilename, oflags, mode);
 
+	/*
+	 * Internally, `_wopen()` uses the `CreateFile()` API with CREATE_NEW,
+	 * which may error out with ERROR_ACCESS_DENIED when the file is
+	 * scheduled for deletion via `DeleteFileW()`. The file essentially
+	 * exists, so we map this error to ERROR_ALREADY_EXISTS so that callers
+	 * don't have to special-case this.
+	 *
+	 * This fixes issues for example with the lockfile interface when one
+	 * process has a lock that it is about to commit or release while
+	 * another process wants to acquire it.
+	 */
+	if (fd < 0 && create && GetLastError() == ERROR_ACCESS_DENIED)
+		errno = EEXIST;
 	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
 		DWORD attrs = GetFileAttributesW(wfilename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))

-- 
2.49.0.rc2.394.gf6994c5077.dirty

