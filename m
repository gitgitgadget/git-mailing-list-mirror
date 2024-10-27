Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7F17798F
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043564; cv=none; b=tKI/v/X/uno2XNXxTpbaeqZLzC3Trf3ekpoPYxuQzopQct4mml0+iySAF5tNoBuhTC+1hFnx2oW8wnD2aS5A7NJfO0QnufSCYnM2zarpNJNP8IrZqZxauKP7GZLYcCWGY34FhXVZRneT6Tv+pL3x0przsLyoJDkb6r3kKLZVmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043564; c=relaxed/simple;
	bh=bebsAzHb5qzC4brNAVmxVTg+CQAn7mKgBbjaeiuP12c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksNEpo4KhGVu9GvntyNOVug6+jUukoxE9sj06Bn8R6WZaBYxa8Ebe36zG8KkQwWjoCDobPKdTsfmD8pjqgFwunn4M/K010eulMap74WQmDmlrRBB3FSxBHSMXIfxlCd5WDw+e86LK8tbIKqtoRMLYGXMxVqik877Yzn5Xzi2gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=edqi7XB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLPZGm4X; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="edqi7XB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLPZGm4X"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 401AD25400AB;
	Sun, 27 Oct 2024 11:39:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 27 Oct 2024 11:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043561; x=1730129961; bh=7Lc3bD0flU
	4mOEXuSAZqpifraRo+wtlpPLkBbsqoFN8=; b=edqi7XB58Z/riIaNpY9sxFECXi
	hrSJbzuBUNqiT9OHyKV9ZhWk6Oo8G/KPOdhbcN1xHyH7B2WjkXX6dIxWi17hllfH
	vSelr/QUc8/9qJaT3VbWfj7aK8wzJcy06hoJNE7Nb5A3XgLXjcRceJXBXvJIFzae
	Js0LXhL1nDcQG2n19Vf6hoz21UQgt+t4MLSGutBTOYaiEOeQN95m+mUBqymNiZnI
	8DtiWvBSSLnU43jS/GIHCYkN5AnnuWVvTfNB/FLg+qlifYouJccROw9o9Sn6STRT
	RCKSmyfvNLUjj/S0YTGvyZ8v9vlQsrLlZVQptXSWMePkFK4FBU3Zd/tjFQtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043561; x=1730129961; bh=7Lc3bD0flU4mOEXuSAZqpifraRo+
	wtlpPLkBbsqoFN8=; b=fLPZGm4XwYBpNUf4Dn4H5Zu6K3/ecAfi8DbI5xQp4b/O
	24Qft/0YfNfI8qhXXUjjSm0fwbyLAE6j4PFHR3PMdqODptfjQ+bSIdWH9iNhQJWo
	eZ0ihLclPGzmQ0Ittcrh+nj0wV+OdtAtcfbf5tsRk0xuN3Rlehno18HQ61l2Qvpl
	Pzt86/3RF4cBgXzdfJVU+Re4TIMWAPMIogyVozHXxB7jAhtdpz22avtn4jHLUGKy
	TLKF50td0zd8xGvvA74UsobKw0MnBrSDjykrsigz0oOJBZoAe0s655VwOqCrGXwK
	QcuB0CNn/jBYSAgr2I26sJ+G1BEwXZv1qlWNiD7QpQ==
X-ME-Sender: <xms:qF4eZ_PBxjcTjy-rznUMSWLPyyn_Rxfq29ex8f9Nq2YVWW-_hqdyIQ>
    <xme:qF4eZ58C2x-otULRfhNcqXgcBmJJmk_JcCiYMG32JOwODR2mAu6xxKbHG-kxKezpp
    R8HjkhAnr2B0Z-BYA>
X-ME-Received: <xmr:qF4eZ-RPj5hxjc6lUpkmGC-gBJK-_xAp9ocIm8_03K0LcGFEYFwGEnSdL-06JpNlsnl1YJN_xh20maBdRwjeUX6a0VwUuLo561QxpFV5-wB-og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:qF4eZztI31lA-Td8F7AVDIvjSP3cPQlKyEZnP6oBXdo2IuJ-3bdqWA>
    <xmx:qF4eZ3eHntsydrJO1cdHhOlSYZPJEYbvl11ZoeU7KKE3RpKavGYdLg>
    <xmx:qF4eZ_0zz4RryU8HkkW9RrrN7aGjnV4wyIrwTcubQMhkGwv4F4ezOw>
    <xmx:qF4eZz8CyHrI4JuXT5jtpPXuZtp5akuRW5kZeCH_t5Na_Vh_bttx1Q>
    <xmx:qV4eZ4E07Ew_SJ7lHqIsvxAI68vD1UIlkHqNysOH80cdfmCEZhC0LVTC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:39:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6792dde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:39:15 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:39:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <91d434116f3eec4444316804dfb3d955c9750a6b.1730042775.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1730042775.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730042775.git.ps@pks.im>
X-TUID: vI8jGBB/8bs6

On Windows, we emulate open(3p) via `mingw_open()`. This function
implements handling of some platform-specific quirks that are required
to make it behave as closely as possible like open(3p) would, but for
most cases we just call the Windows-specific `_wopen()` function.

This function has a major downside though: it does not allow us to
specify the sharing mode. While there is `_wsopen()` that allows us to
pass sharing flags, those sharing flags are not the same `FILE_SHARE_*`
flags as `CreateFileW()` accepts. Instead, `_wsopen()` only allows
concurrent read- and write-access, but does not allow for concurrent
deletions. Unfortunately though, we have to allow concurrent deletions
if we want to have POSIX-style atomic renames on top of an existing file
that has open file handles.

Implement a new function that emulates open(3p) for existing files via
`CreateFileW()` such that we can set the required sharing flags.

While we have the same issue when calling open(3p) with `O_CREAT`,
implementing that mode would be more complex due to the required
permission handling. Furthermore, atomic updates via renames typically
write to exclusive lockfile and then perform the rename, and thus we
don't have to handle the case where the locked path has been created
with `O_CREATE`. So while it would be nice to have proper POSIX
semantics in all paths, we instead aim for a minimum viable fix here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e326c6fcd2d..0d9600543cb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -532,6 +532,70 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	return fd;
 }
 
+/*
+ * Ideally, we'd use `_wopen()` to implement this functionality so that we
+ * don't have to reimplement it, but unfortunately we do not have tight control
+ * over the share mode there. And while `_wsopen()` and friends exist that give
+ * us _some_ control over the share mode, this family of functions doesn't give
+ * us the ability to enable FILE_SHARE_DELETE, either. But this is a strict
+ * requirement for us though so that we can unlink or rename over files that
+ * are held open by another process.
+ *
+ * We are thus forced to implement our own emulation of `open()`. To make our
+ * life simpler we only implement basic support for this, namely opening
+ * existing files for reading and/or writing. This means that newly created
+ * files won't have their sharing mode set up correctly, but for now I couldn't
+ * find any case where this matters. We may have to revisit that in the future
+ * though based on our needs.
+ */
+static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
+{
+	SECURITY_ATTRIBUTES security_attributes = {
+		.nLength = sizeof(security_attributes),
+		.bInheritHandle = !(oflags & O_NOINHERIT),
+	};
+	HANDLE handle;
+	DWORD access;
+	int fd;
+
+	/* We only support basic flags. */
+	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	switch (oflags & O_ACCMODE) {
+	case O_RDWR:
+		access = GENERIC_READ | GENERIC_WRITE;
+		break;
+	case O_WRONLY:
+		access = GENERIC_WRITE;
+		break;
+	default:
+		access = GENERIC_READ;
+		break;
+	}
+
+	handle = CreateFileW(filename, access,
+			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
+			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+	if (handle == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+
+		/* See `mingw_open_append()` for why we have this conversion. */
+		if (err == ERROR_INVALID_PARAMETER)
+			err = ERROR_PATH_NOT_FOUND;
+
+		errno = err_win_to_posix(err);
+		return -1;
+	}
+
+	fd = _open_osfhandle((intptr_t)handle, oflags | O_BINARY);
+	if (fd < 0)
+		CloseHandle(handle);
+	return fd;
+}
+
 /*
  * Does the pathname map to the local named pipe filesystem?
  * That is, does it have a "//./pipe/" prefix?
@@ -567,6 +631,8 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
+	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
+		open_fn = mingw_open_existing;
 	else
 		open_fn = _wopen;
 
-- 
2.47.0.118.gfd3785337b.dirty

