Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C219D8BB
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886032; cv=none; b=e7qEn6HGOmQFE/WSYUZ5U7Me+MzfWPcEqtnKi87p1BK5UrG7k2ykU0ToFxxMKtxemqs5VuWoBwvlx/YHV5OfPaipXCKnqXDnzAzBQWgDjpMg8JD9q/AHIKJWnP2gdSCzjK14eQ25aRXeeqrrPLG0pIax9yeVXdqBPX4bbAtdsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886032; c=relaxed/simple;
	bh=D6Hhpn7vxHV7XfFB4j51n7BZsMwQz9dQhOFEKLgOFAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLcb/rhN/vAl9MvIIxYHPLxZC6lvvVthzdShAO5LMR6X6MvjNkpmrFlb1jY4+TX6aS5ufq6JEs9zm7p+Eh+oNNGfd7trT4EOGpw2jbEYDuQaugrE6/qePCfpyJkckz2/R4nKzMmstqjPmv0PtTXyf26BsNRC5oMyPf5OnVpUGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8WOnrvr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9wNay5L; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8WOnrvr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9wNay5L"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E0C4611400F6
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 29 Nov 2024 08:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886028;
	 x=1732972428; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=
	H8WOnrvrejsn7w8gB6tzHLoBS9Y+SUEmJoaN43EnsnET+P44Vd6yIwiVDqY1XwK3
	CLgnUzQmz3My1uMf30FX8AVxt6n+kbAq+3VKWPEgTDGbMFwJI3z1PBOBhklhM1De
	CnjcuHnliexsWeYoDNPV6n7KFDBUf8J8bMq1Zx3VknYfkMPcxYAzyDsEn4H1gM2R
	2omxwN9pjSZdQVpNM+jZ+pnqg3QdP77AUfMu5q6KgDFGmqe3n9f5Bxi+5g2Zc49d
	k8rxrxq7cETzx7OUY7V2Ex/hDIwmAWZyI5ejePtex0gM3djSR43FbJlLJ66L5Hpc
	pgWvpq1DlNB8S9ck3836jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886028; x=
	1732972428; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=D
	9wNay5LHjXghVzsmoOrFJ1FNwmqsSA7mCJjdRFUtDSZe2qrKRCibzhVSvjK3EmVC
	FCh2PRifF6LdcTpgKU246GqO31uytqqE01jvevxTM+lkdZbCirtomdMjydrdVl3U
	RTsHyk/mf/jTWns+Mq0ggBvy6ueV88ImwPHR7X/75Nb5nFAHseJj+Q5I4pjCVNWD
	olKriP9aQS9urARuWTdANgZI5XY2gsxCKFvQkFObMIYPBa5KQpYd/nkOCYeKq4RI
	/HxJpkJGxAEBzQyRW3ZtxaEly828GkDYaHQvZjP81VsZ6ZxtvUC8JCXVTz7tabtc
	y8+ojX4lwzLnCLp6cquhg==
X-ME-Sender: <xms:DL5JZx-EgRdgsdTvlo_f-awBwQdHOgJafn-gwi1w1Vkubx7b6YvN5g>
    <xme:DL5JZ1s3Y1Vqq6cc1naM5RhLpsJzA-4GpyMvIlrl4Htxk7QxD1mJhf96wLQfYRg8Y
    Q-4WCHmnS29W85qhA>
X-ME-Received: <xmr:DL5JZ_CrPmhjmFyAV52VUcV4p0FVRmBu4fjHqLpzghWlOPrHg-9qD22KUXXOHXYL0m5mqfB5py8aBrpKI2nP6dTMxwEVF9YCXS8fykMcdvbmva4whQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DL5JZ1dBTJf-57DX6RMnxiZJGHfe6RqZujxK3K2dwXxtPKXYM5rgzg>
    <xmx:DL5JZ2PAo9hPB0VKpFp3eJXsThgqGZd5yZ2epux1U2Ip4Fqvg0Qq8A>
    <xmx:DL5JZ3l4vBLcgwP4PEV3kk4i5r001kXOLIKHPrA-vdT1c774w1O7eA>
    <xmx:DL5JZwuTpb55t0YtcwS5ZyHEcuEIpPcHMPz50sB2Xb5yVLgjpleppA>
    <xmx:DL5JZ42AU3NCTiE2B6MtIpnKnWAZsYLw6meB1dpoA1FXeciTrkcCA-7O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a21af53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:24 +0100
Subject: [PATCH 03/10] compat/win32: fix -Wsign-compare warning in
 "wWinMain()"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-3-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

GCC generates a warning in "headless.c" because we compare `slash` with
`size`, where the former is an `int` and the latter is a `size_t`. Fix
the warning by storing `slash` as a `size_t`, as well.

This commit is being singled out because the file does not include the
"git-compat-util.h" header, and consequently, we cannot easily mark it
with the `DISABLE_SIGN_COMPARE_WARNING` macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/win32/headless.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/compat/win32/headless.c b/compat/win32/headless.c
index 11392a0b9a6dac5522bc5042064f492bd73cc871..a6eb116ddc7b586fea80f46ac36d50a4b3ddb656 100644
--- a/compat/win32/headless.c
+++ b/compat/win32/headless.c
@@ -53,7 +53,8 @@ int WINAPI wWinMain(_In_ HINSTANCE instance,
 	wchar_t git_command_line[32768];
 	size_t size = sizeof(git_command_line) / sizeof(wchar_t);
 	const wchar_t *needs_quotes = L"";
-	int slash = 0, i;
+	size_t slash = 0;
+	int len;
 
 	STARTUPINFO startup_info = {
 		.cb = sizeof(STARTUPINFO),
@@ -66,7 +67,7 @@ int WINAPI wWinMain(_In_ HINSTANCE instance,
 	DWORD exit_code;
 
 	/* First, determine the full path of argv[0] */
-	for (i = 0; _wpgmptr[i]; i++)
+	for (size_t i = 0; _wpgmptr[i]; i++)
 		if (_wpgmptr[i] == L' ')
 			needs_quotes = L"\"";
 		else if (_wpgmptr[i] == L'\\')
@@ -79,16 +80,16 @@ int WINAPI wWinMain(_In_ HINSTANCE instance,
 	extend_path(_wpgmptr, slash);
 
 	/* Then, add the full path of `git.exe` as argv[0] */
-	i = swprintf_s(git_command_line, size, L"%ls%.*ls\\git.exe%ls",
-		       needs_quotes, slash, _wpgmptr, needs_quotes);
-	if (i < 0)
+	len = swprintf_s(git_command_line, size, L"%ls%.*ls\\git.exe%ls",
+			 needs_quotes, (int) slash, _wpgmptr, needs_quotes);
+	if (len < 0)
 		return 127; /* Too long path */
 
 	if (*command_line) {
 		/* Now, append the command-line arguments */
-		i = swprintf_s(git_command_line + i, size - i,
-			       L" %ls", command_line);
-		if (i < 0)
+		len = swprintf_s(git_command_line + len, size - len,
+				 L" %ls", command_line);
+		if (len < 0)
 			return 127;
 	}
 

-- 
2.47.0.366.g5daf58cba8.dirty

