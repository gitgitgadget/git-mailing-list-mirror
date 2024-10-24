Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692E1D041D
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770396; cv=none; b=C36kpW+bd/6py4QeivWEq+Up9k8jiFLlFmldBb7ExFOjq52kCBilbV5qO3XXQvq7NrtVP+kmmRmlIusbMGpZ3GIG0icgGFYX4SGO7PKo49YFggfq6fbRnzmGVrfQT3K/pkgbsKwP55VA6pjqxPsv7Rog/3vVulmED+7C1pi4O+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770396; c=relaxed/simple;
	bh=Zg0Zx3iHMWU3tSKhHL925MV8XsPECiDeHDgfAiUFzME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZXdS6brk51Sr74Q/VQ8h8jy+4HqLoGPloRiyiAuRCcBNAZPEIKfer3EikDUFko7U5zRy6mduoNx/FnLrg4ojj73EEqbRuPS5TlahsHR7U8hLiqBSd5EmFAzDPaRb6VXHYtJu9du5zwuKdqjdtVobgrlOPinFmpQ4yoHwvHwg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SyygtjKS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beS9w+Sl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SyygtjKS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beS9w+Sl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A341C11400FC;
	Thu, 24 Oct 2024 07:46:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 24 Oct 2024 07:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729770392; x=1729856792; bh=jKlUbthhLb
	vGbzMQesf1U36tzXINICflZOhFIFljN6k=; b=SyygtjKSBeacBDhHgjYFqQ7j03
	Ki0vusscuDjq6R/CENqiZ8sp62HqLbydMQElUycLaq1N0w/V9SgSoigQbtkzRBeX
	LDk5f41iJYqYqw8SiVtelnRNK0YxjczG2p+nS6jOFkI73clcA0BL4lXHXg1Ml0mD
	MIzoHVwwr+xooLUwALrn6qVvE8cn+YwQHl93Hia/O4gYo1YuAvrsoftbi7UwjUel
	ijK2cuVPsctIRiJwjAhstPFDwEmikNkT36f8G/UMBXDo+efbBrfdzHCUwPCgc3jj
	XNzt5utj1xHwG8gjAxMg5zLYBg3wOFJBkQU7xa3ZkXzK16V+ZrO+GCEgfEBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729770392; x=1729856792; bh=jKlUbthhLbvGbzMQesf1U36tzXIN
	ICflZOhFIFljN6k=; b=beS9w+SlwiGVq33pClMxHIxSESvsPuOeteauH8S+tggm
	ZmwvgXstwusG5lrOP7BaeUczhgG3v7CtX9QBUsCAdwHI9WFE8U1XOT+3A15oolpJ
	2ZVTJv3KZIcE6LdOxhLoRX6GJIviQ5Nw0+QFKlsWVXiEfgJdvvDpcoE/fwBwsLZZ
	00Fxr6EyJMDpBJYqdtFIGc7QuvYxFV3uW6a6k8COF3VXyLL1045pOmSNpbKOB1o1
	cN+/PyGMfPsvF0xSO1I4rjg+evN03Z6AW2YYSTnV/FcZ2pzthOfGJ3u0gG1cbpP5
	qB3VqqO2an5HHyYvV3I3E2ODV97CiJSSGHDKEjldgw==
X-ME-Sender: <xms:mDMaZ3EZ07AV-58Twi4smzSvNhXPz34KGxPIEHruE6XbaClrknHMCg>
    <xme:mDMaZ0V336wrX7Tm56Z11LW6lhm1Fkhbo8qi0p6-6vMHTrutyQC7fMQuZK4laBANH
    tAjnsPmSsIptO0quw>
X-ME-Received: <xmr:mDMaZ5IeSiF0yUGEypp_4Hhr3SoVlW3TlnBGjccTHirtQzmr3r3dqJSNoXLQr4o-zWYPg2FDLUin1hK3IvxuScch7iXpgh3LyLMx2MegwSh6AzjG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeehffduffeufeeludelleeivedvffeludeuheeuuddt
    udelgfetgeffffdukeegnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:mDMaZ1GcgdNMxPs7et_PjsHd4Ib8wyCKvp6EWH1LvAClVpI8wSKkVA>
    <xmx:mDMaZ9UYkBVk5QhzyovlaRddQ6fJT8v-flzbJIQdOo7a8ksXXqOXIQ>
    <xmx:mDMaZwON7L8o92naDNFA6cr14bTJvh_klrW4XxqGAYMlSAU7Jw4Q8g>
    <xmx:mDMaZ81NykncqcgWS3Gb5yuU9MEE5KbrSdZmvN4xRWTjL8vCcrdiEg>
    <xmx:mDMaZzzp-A98aF9TuZLCWWuDwWnBLrZwwyzYqBSzv1MCMcTnvKV9Ym6o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 07:46:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5755527e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 11:46:34 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:46:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
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
index 6c75fe36b15..22c005a4533 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2209,10 +2209,16 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
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
@@ -2223,11 +2229,84 @@ int mingw_rename(const char *pold, const char *pnew)
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

