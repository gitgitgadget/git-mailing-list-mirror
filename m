Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E424170853
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770390; cv=none; b=jhVHziJiYnyDFt1AD/NrQO9IDBPsrw8wPAOqjipnDw2RSn18WiHU8ejOeuTgTQx6exsdpirP0IZwrO6JPdAmaVGfKsv4D6WKCzd9fpWZUexR2TL4ytAIBol4lWXGnQr+DBELUJnU5YPooWx522JmCW72yKMGeNAVJJ+R6jTrvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770390; c=relaxed/simple;
	bh=ieqZX9cixRkKreNQS5LSlKhSy0wtaD7nT+ENiWSqX1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5LAb7zT0IhIY+wXSAdi6qyQKDs0oRNt1U4CdHLIMWWcKSkok7n33Cd90DKEyZTizyaurvCOYJK/yrQ+Zt+mr6MJq2SKz7lv5oajighBNeOQz4m0BU3Flrlmuccz5KTkuAexS6+rGM4EszgP3HP1jhbGsq1wHyUmWvJULSRoqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zPQq543N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncKNeUba; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zPQq543N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncKNeUba"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F7E6114017D;
	Thu, 24 Oct 2024 07:46:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 07:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729770387; x=1729856787; bh=D9lvrtj2Po
	/MIjLzuFkdAv7rGKqis51gfkHfcbOwbdE=; b=zPQq543NvCEPoJhAJOY05wT1jF
	fTt+KMxBSZuRwYrQNTBrK3woYPTspp26csCXeiRrnJBXPhzEOhmhCuatuS3VDzgb
	a7IejgFPu22mtsbZzUayzj7ynnxIPZvZozH6S8Dc/s81fRWxcn9GJ+8i5d7AWioc
	suPSw9zon9CP1rthRFNbaNGv1z4gCE0wqNSBah/WYrBYpHIDWnGaYfBuZhi5NbnG
	aQ4B/NDCPEjkAot95191cxhDu53Cj3MqLL9iH91A+icKwDSZHZr+vW3DSbFrxjfC
	mQYLoPmd2baKHXaocM4FYfyt019IMkM1VDyOo6/b1N/CHmatNVk+0zALeImg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729770387; x=1729856787; bh=D9lvrtj2Po/MIjLzuFkdAv7rGKqi
	s51gfkHfcbOwbdE=; b=ncKNeUbaDUriTC4B64NllLcgaOBq0lBWrXUBNVtfF+zz
	nrSrg6ohecLze02tV9vqkXUDc8BxoJcCUfQ7O5xDNafFxB4q3mkRoVIpupYKkQ6R
	ihud3yqReRVhcplLoObygKqcSa9OwTt7L/wCpinhNlnW20IQHEDa5av5VjlwL96c
	97ZE/6jRN5TR4BLseA4XEJhtJYjGuY8JLgU2hPUeO9nK0vAfT1J3RMnX8bb2h9IX
	5inDx17jpazd5BCultCjljfzbQsw5cGwYRYi2T0YnfS/uGjQv2YtfcvjIb9o99Jf
	1DZBpWKsSQkemKK+sjJC3s0GbZ/SX0Fy72L5EOgcZQ==
X-ME-Sender: <xms:kzMaZ7LaeZGEyXERkluXI3KTENwZRWCQpyOMHAi5eWu8v4CUtbxhZw>
    <xme:kzMaZ_IlbKuNZ00Tlo5sODPfnhIHFXaPegTs0Rzl5OLqmTg5_pmlK3wvFXjfQa-k9
    2-Pj6lzGNFEhABEjw>
X-ME-Received: <xmr:kzMaZzvsm_UjXMhL9sVBrECdTywBVz8LVE-JuUvEAIndT-5940ksBMkdm5q4YPett_jVZge4-aFfzjM73P466uhElDYdNAhh6p6If_EJDrJ47uiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kzMaZ0YD6N53ERxUxk_zfafzJQXWDwKa_NdjPkSBEfnyl-q6WIHTxw>
    <xmx:kzMaZyYNhlC2PA51I_oR2gfTd28v8mNZhyni481S1QJC9fxDu48ujQ>
    <xmx:kzMaZ4BZ0ky40dHJwqqmiTxyAUiUPpx2s2438Cn2Gfq2a3Zl2mA45g>
    <xmx:kzMaZwatlqa-liCdg5hbwYp8vlsIDKd8oRlKuaNyDLIVwYYneDfe6Q>
    <xmx:kzMaZ5WWsh9OvHGBgJwn1XJmQ3fU71ap_3J9OVZQHwipRUpMjbAQmJx_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 07:46:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15ab1f42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 11:46:29 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:46:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729770140.git.ps@pks.im>

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
 compat/mingw.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e326c6fcd2d..6c75fe36b15 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -532,6 +532,62 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
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
+	int access;
+	int fd;
+
+	/* We only support basic flags. */
+	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if (oflags & O_RDWR)
+		access = GENERIC_READ | GENERIC_WRITE;
+	else if (oflags & O_WRONLY)
+		access = GENERIC_WRITE;
+	else
+		access = GENERIC_READ;
+
+	handle = CreateFileW(filename, access,
+			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
+			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+	if (handle == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+		if (err == ERROR_INVALID_PARAMETER)
+			err = ERROR_PATH_NOT_FOUND;
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
@@ -567,6 +623,8 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
+	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
+		open_fn = mingw_open_existing;
 	else
 		open_fn = _wopen;
 
-- 
2.47.0.118.gfd3785337b.dirty

