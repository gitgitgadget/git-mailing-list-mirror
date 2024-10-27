Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915D1714A0
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043567; cv=none; b=YB0if5E/D5oe2upYxU31+PVzOvDICxLvkhDKzUPnmybRMQNTjGkXqsqL5xc7re0IpSJkN7tcE9i94Cd5hxNhWUkBtL9VN/5scK98FjUoy1MuWnLKHDAdSBRpP2afUA4e8QW1pt4KEIMg/8g9xc8FcTHnXK6cg8J0szw4CzQNPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043567; c=relaxed/simple;
	bh=fW8TzdqCozzMrwAnBzNHmbmS5S72+f4rfuF+XB0o2Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR50/pyIAfdAdofTwx4iH0J/OfrCP/K+7aL8sayv/nSvLgtAjklG1CcYKscCpyk8ZIylhf4ldfo9PRje+tKlL8D5u2r9JoexBuHo9vteAnKlg4SjnRfaeoiJtVZzUmdpppfj4VPe/hlCXvGCYKCwL+o34kz7AG+1zIGcy6PLBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wLaD6z27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6CfD2xD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wLaD6z27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6CfD2xD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1898725400CA;
	Sun, 27 Oct 2024 11:39:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 27 Oct 2024 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043563; x=1730129963; bh=3lq/fAD2A2
	Bir0VqUARmjJCkaQhoU1Oczp1QdRonFAY=; b=wLaD6z27DQuJF12jNUzNIMxjN3
	qNnON1n3Qe2somTpqlWxEIsJatdZ+x/jDpgahGlXOvIeELMstqEUYQfluKb4ib4P
	WqzQxrvZAHW43HtWZSQFXUv8GdASmTP8JKb27jA6lsYQZDqADkdUTEC1RzJ49yst
	Q+SnmN0UGfG3y6ypiwvA6JO4BOudCLPyijB/nUH++GMy/izSi+8y/Vdr9frRQ2/j
	6J1vEcgCcIXXGAS+uzKvBjZm0+cuF1LUUX51KmeVVwgawpAh16FAcDMDPo/BPgvy
	6tlToKwg18Z7sx2PS2GklMxIuuLwD0IxJQYQu0of/mC2AccYhJjms2p4Cdnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043563; x=1730129963; bh=3lq/fAD2A2Bir0VqUARmjJCkaQho
	U1Oczp1QdRonFAY=; b=Z6CfD2xDohcZukO3teyxQ/V81RFqhG7yL7maP8MRXiyN
	+617UpIjtE1DecGLYPGuWrSnj7YTJkNn7u2G75XVAwFwH/PagHnSGpvcCgS5/ZHi
	vKWWVBzf2+f8lwXEAJAMh3ZVZHyWYJtt9+vR/Uw/cFdwxKVmniiMmdvm8LRtIyKC
	IJmvKexuyI8UNmPOoUG82/mtBbFGG9vaJJ9vB5+KpeF1bBAzDpZuBRc9A9pCkRq2
	XiVL3AnAxdNI5YltzLifERXF4nUg2EihWxZWJKYZf7Ed0D52K6gZnuu3AWqZCelu
	SnQuNs7sehD/jluH3hTqP7/sghGlIwEhnOK8U5V64w==
X-ME-Sender: <xms:q14eZ8xR4o_upTIpLmKd9_AXmJd2_Ja_2ClxUszk8g6Nt3sl6GanYA>
    <xme:q14eZwQ44DAxgi6klbDOQuF8KyoTvMvYJhorGBX9oQ3X809M5GPgEzrCcMsaJ1pMK
    qS_FsM4-m4CcrR60w>
X-ME-Received: <xmr:q14eZ-XJ21RoMQKOMrnHLZ0uFml_afImKeCgNkfwV9CY3EVMgxIhMEI1EAqcnvNMqHujyI27NXxI8kfplui_KTRfk0mNqLeu_ptJuQeChrLDng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeehffduffeufeeludelleeivedvffeludeuheeuuddt
    udelgfetgeffffdukeegnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:q14eZ6gg-JKosbnacfVj1uQzoNBzhpwFY7vADvz29TNHX0c95vpSsQ>
    <xmx:q14eZ-CbIIgX7Cvzd3WVOwKvxlk8wNqqW0RZpnpIMg288LIuTWRBrw>
    <xmx:q14eZ7I6VLV7cNotCDfC71m4mmmiCZkmGl4JC4PZof-JRqq5re0wTA>
    <xmx:q14eZ1B7TsxYEyM3H245Nwva11L3lYZ92FFzIDCx1btxw_s1ScP0VA>
    <xmx:q14eZ14xXprEVlmMuJWMHDbvtoult4-5p56OdjR3O6d3xIijY9npQC8r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:39:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4d25518 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:39:18 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:39:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <2447d332a851e41e613dec181c347d5a15c310ab.1730042775.git.ps@pks.im>
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
X-TUID: ibLLLeK8jhGQ

By default, Windows restricts access to files when those files have been
opened by another process. As explained in the preceding commits, these
restrictions can be loosened such that reads, writes and/or deletes of
files with open handles _are_ allowed.

While we set up those sharing flags in most relevant code paths now, we
still don't properly handle POSIX-style atomic renames in case the
target path is open. This is failure demonstrated by t0610, where one of
our tests spawns concurrent writes in a reftable-enabled repository and
expects all of them to succeed. This test fails most of the time because
the process that has acquired the "tables.list" lock is unable to rename
it into place while other processes are busy reading that file.

Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
that allows us to fix this usecase [1]. When set, it is possible to
rename a file over a preexisting file even when the target file still
has handles open. Those handles must have been opened with the
`FILE_SHARE_DELETE` flag, which we have ensured in the preceding
commits.

Careful readers might have noticed that [1] does not mention the above
flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
not for use with `SetFileInformationByHandle()` though, which is what we
use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
not documented on [2] or anywhere else as far as I can tell.

Unfortunately, we still support Windows systems older than Windows 10
that do not yet have this new flag. Our `_WIN32_WINNT` SDK version still
targets 0x0600, which is Windows Vista and later. And even though that
Windows version is out-of-support, bumping the SDK version all the way
to 0x0A00, which is Windows 10 and later, is not an option as it would
make it impossible to compile on Windows 8.1, which is still supported.
Instead, we have to manually declare the relevant infrastructure to make
this feature available and have fallback logic in place in case we run
on a Windows version that does not yet have this flag.

On another note: `mingw_rename()` has a retry loop that is used in case
deleting a file failed because it's still open in another process. One
might be pressed to not use this loop anymore when we can use POSIX
semantics. But unfortunately, we have to keep it around due to our
dependence on the `FILE_SHARE_DELETE` flag. While we know to set that
sharing flag now, other applications may not do so and may thus still
cause sharing violations when we try to rename a file.

This fixes concurrent writes in the reftable backend as demonstrated in
t0610, but may also end up fixing other usecases where Git wants to
perform renames.

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information
[2]: https://learn.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase-file_rename_info

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c             | 87 ++++++++++++++++++++++++++++++++++++--
 t/t0610-reftable-basics.sh |  8 ++--
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0d9600543cb..c4320769db6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2217,10 +2217,16 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
+	static int supports_file_rename_info_ex = 1;
 	DWORD attrs, gle;
 	int tries = 0;
 	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
-	if (xutftowcs_path(wpold, pold) < 0 || xutftowcs_path(wpnew, pnew) < 0)
+	int wpnew_len;
+
+	if (xutftowcs_path(wpold, pold) < 0)
+		return -1;
+	wpnew_len = xutftowcs_path(wpnew, pnew);
+	if (wpnew_len < 0)
 		return -1;
 
 	/*
@@ -2231,11 +2237,84 @@ int mingw_rename(const char *pold, const char *pnew)
 		return 0;
 	if (errno != EEXIST)
 		return -1;
+
 repeat:
-	if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
-		return 0;
+	if (supports_file_rename_info_ex) {
+		/*
+		 * Our minimum required Windows version is still set to Windows
+		 * Vista. We thus have to declare required infrastructure for
+		 * FileRenameInfoEx ourselves until we bump _WIN32_WINNT to
+		 * 0x0A00. Furthermore, we have to handle cases where the
+		 * FileRenameInfoEx call isn't supported yet.
+		 */
+#define FILE_RENAME_FLAG_REPLACE_IF_EXISTS                  0x00000001
+#define FILE_RENAME_FLAG_POSIX_SEMANTICS                    0x00000002
+		FILE_INFO_BY_HANDLE_CLASS FileRenameInfoEx = 22;
+		struct {
+			/*
+			 * This is usually an unnamed union, but that is not
+			 * part of ISO C99. We thus inline the field, as we
+			 * really only care for the Flags field anyway.
+			 */
+			DWORD Flags;
+			HANDLE RootDirectory;
+			DWORD FileNameLength;
+			/*
+			 * The actual structure is defined with a single-character
+			 * flex array so that the structure has to be allocated on
+			 * the heap. As we declare this structure ourselves though
+			 * we can avoid the allocation and define FileName to have
+			 * MAX_PATH bytes.
+			 */
+			WCHAR FileName[MAX_PATH];
+		} rename_info = { 0 };
+		HANDLE old_handle = INVALID_HANDLE_VALUE;
+		BOOL success;
+
+		old_handle = CreateFileW(wpold, DELETE,
+					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
+					 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+		if (old_handle == INVALID_HANDLE_VALUE) {
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+		}
+
+		rename_info.Flags = FILE_RENAME_FLAG_REPLACE_IF_EXISTS |
+				    FILE_RENAME_FLAG_POSIX_SEMANTICS;
+		rename_info.FileNameLength = wpnew_len * sizeof(WCHAR);
+		memcpy(rename_info.FileName, wpnew, wpnew_len * sizeof(WCHAR));
+
+		success = SetFileInformationByHandle(old_handle, FileRenameInfoEx,
+						     &rename_info, sizeof(rename_info));
+		gle = GetLastError();
+		CloseHandle(old_handle);
+		if (success)
+			return 0;
+
+		/*
+		 * When we see ERROR_INVALID_PARAMETER we can assume that the
+		 * current system doesn't support FileRenameInfoEx. Keep us
+		 * from using it in future calls and retry.
+		 */
+		if (gle == ERROR_INVALID_PARAMETER) {
+			supports_file_rename_info_ex = 0;
+			goto repeat;
+		}
+
+		/*
+		 * In theory, we shouldn't get ERROR_ACCESS_DENIED because we
+		 * always open files with FILE_SHARE_DELETE But in practice we
+		 * cannot assume that Git is the only one accessing files, and
+		 * other applications may not set FILE_SHARE_DELETE. So we have
+		 * to retry.
+		 */
+	} else {
+		if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
+			return 0;
+		gle = GetLastError();
+	}
+
 	/* TODO: translate more errors */
-	gle = GetLastError();
 	if (gle == ERROR_ACCESS_DENIED &&
 	    (attrs = GetFileAttributesW(wpnew)) != INVALID_FILE_ATTRIBUTES) {
 		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index babec7993e3..eaf6fab6d29 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -450,10 +450,12 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 	)
 '
 
-# This test fails most of the time on Windows systems. The root cause is
+# This test fails most of the time on Cygwin systems. The root cause is
 # that Windows does not allow us to rename the "tables.list.lock" file into
-# place when "tables.list" is open for reading by a concurrent process.
-test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
+# place when "tables.list" is open for reading by a concurrent process. We have
+# worked around that in our MinGW-based rename emulation, but the Cygwin
+# emulation seems to be insufficient.
+test_expect_success !CYGWIN 'ref transaction: many concurrent writers' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
-- 
2.47.0.118.gfd3785337b.dirty

