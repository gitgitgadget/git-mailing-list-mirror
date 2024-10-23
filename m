Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F81D0403
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695909; cv=none; b=P3ttvJjSsVR9Id4alFoYKSEic3H90PFQ0Qgztb3H6vNL3mST5qw58PUffpUYH16HR0GyEdzLV4SGAvC72+jyJ/emnTYzhDleIluxv0ROrMzXU6Pw5dD5VxXvGM9sYMlKSna4OQUgZ8wn+UwfL+F2gszx49JfYjg5D2Ycupzolc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695909; c=relaxed/simple;
	bh=BU6R/188O6ogaucoEMeeOYOsrUNpPf0BkhJWtdfZA4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2LVDPOwny868Ml5MYBU9mKJnMUFY3WXNP0FsJ26yw0fNI358XSt+8rl2NFANiw/jGIgLuWATLDUCyEdKri25ygC7/kVln/mhsYA1wZFvXpBJ7sdpRXtiLlSw0Ikk69rZC7MIajlVSSV3QScK0VbRgSPDkA+MRxbSZ3gTGSBgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PCqFH03J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OfYiiKhM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PCqFH03J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OfYiiKhM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 968CB1140188;
	Wed, 23 Oct 2024 11:05:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Oct 2024 11:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729695906; x=1729782306; bh=k376afiYp6
	gcscbxb5r0/jAR7Mc9ye2cFjhPVSoruF0=; b=PCqFH03JA6Xu6K8Kkcr8AeIRjE
	JhO4E8R07UiDDN59MvvAVcvF7qJQcMmxPH2d53HqNyioYFRm1vOVKH3Mkk37u8GP
	qOu/OS9qm/WwxoBhK6IU0B7DCsvyBUMJbX6ZwHgMdqxIIWlLK4kQoEjUp48LQAUI
	GDhMGtEDiuLU+pbch5mI3IFFbahKu73slLI5ZB6+POJotvWjsDvrFFtoLamh7LrQ
	mfP6NN9nFRSgP7J48apds0fVFC64OmRymMwj+V1xv27yCXg0xilPRBAZstT6dej8
	WdH3eVGeZKfvOnc3kUnOWGdXhDgbYj+dtI4ME+LoD4bQtNUeHnHLyg3MqrdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729695906; x=1729782306; bh=k376afiYp6gcscbxb5r0/jAR7Mc9
	ye2cFjhPVSoruF0=; b=OfYiiKhMhCcz3bv5LQSVtAseUdJh+ySQr+8P+uGxcg3L
	FAKo9frHYcvJO9osxX5zot9U5QXApabvsBfsY58KGUAhUht4gmWc5Pntso5Jox95
	2Ci4jtb3wY8BEtnjQYSVJf0mK3jlye+/PoyiO6f+oDYdtXFAAEK9pJ85M9BJzeqx
	gBJSUZffmVS2471V6x/easoO1SUUVQpL7bcR3UOFILz8wWRVa0rOZQYCeVZECLi0
	hWniqqxrM8ohwVefe0H2QgfT84vHYcqy15Wn0C74gTxF6km6dm8U5lTAK25jARXc
	1GFlZGhf7Rw1mKQlgJvahZtMQAQQ4Wvdcqm+jNPQSA==
X-ME-Sender: <xms:ohAZZ9uxdmk5o2PC-Bkz2mKY6CBgls8fFAvfAhLEtMPQYn1TJmkx1A>
    <xme:ohAZZ2eYLrMzIc-BKeQqKgcsyVcK5HbT267qciCZ6nmkvm18SprF6fCdbcZjAF-yT
    qc39zZB_shpOBUN-w>
X-ME-Received: <xmr:ohAZZwzGF_BO4lc0LVDlP3WJGm6T2sTnnFG0cVg9HdDr5GEJ3JeJ-4qs8C1ycJwZszR9fbaKow3Yer6Qb_pRWYpzzTGlq7XZAl4fyFfw10zv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeehffduffeufeeludelleeivedvffeludeuheeuuddt
    udelgfetgeffffdukeegnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ohAZZ0OHAdZLo8WTclctOPbZQh6lMlgpX6kVx3ACSdVEika_hrd3Cw>
    <xmx:ohAZZ9-NNIYFQVz5EqfWDwUsYqEuOXUQ0zl3pqpmCMk-sTyPEFqW2A>
    <xmx:ohAZZ0VeUQhlNAfhrRZZWRe8lHkfCifDDVrP5z_SiKNXpXZN5c1iLQ>
    <xmx:ohAZZ-eykNUh7Vqzkf43wvkQiLRO_FvU1ZWjBRZoCBGIrPSfA4xhwg>
    <xmx:ohAZZ_LX6a-ONvNP9BMQLL1oDBH_fYCUQjyXhDqVvarFVsLZOiShzh9W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 11:05:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1c642c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 15:03:33 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:05:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic renames
Message-ID: <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729695349.git.ps@pks.im>

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
flag, but instead mentions `FILE_RENAME_POSIX_SEMANICS`. This flag is
not for use with `SetFileInformationByHandle()` though, which is what we
use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
not documented on [2] or anywhere else as far as I can tell.

Unfortuntaly, we still support Windows systems older than Windows 10
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
semantics. But unfortuntaley, we have to keep it around due to our
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
index ce95f3a5968..df78f61f7f9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2206,10 +2206,16 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
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
@@ -2220,11 +2226,84 @@ int mingw_rename(const char *pold, const char *pnew)
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

