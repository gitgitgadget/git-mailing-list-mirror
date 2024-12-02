Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FE2040B4
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141105; cv=none; b=HHOHdzF1qJePbb/xZymhwA5pnygCnempZ9qG1YLMfOrAcxOMlNeck+KOlmXVD9nQIDdntbPWjLpzJ1fj/96A/6NoezzBAdaUpa8I61D1XZCfZF+tzPJnXUVl7DKR398grMnWp7RlAm/ukBkb2YwqIE/2leF0ebgHjPDzy8cvmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141105; c=relaxed/simple;
	bh=D6Hhpn7vxHV7XfFB4j51n7BZsMwQz9dQhOFEKLgOFAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M69XFKxVTBH4sQdUL5cWKCLfCCYrK9uxqZ7fyRq3Y1OPwnG6yIjIOKIPT2TQeD1Eayl1bQPUL/wtjMOla8CgknDLJclmBqjzwi9k2TRpYiMaz0VJd0oPtySBNESt5VsIfa4zrO3KDdjokifmU4BtxqOnTfvDn+BLRBevd73ujRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vV4J8Yn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mibR9mMY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vV4J8Yn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mibR9mMY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BBA64114018F;
	Mon,  2 Dec 2024 07:05:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 07:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141101;
	 x=1733227501; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=
	vV4J8Yn+6dmCFGXh8kTK4M1VdOAR6PlAuwBb9/55WmRKgRsv/gmnCi/7KzxfC0mu
	OVbwyZC92lNbMGOOFKl5ZurcqSUZ345wiiAclQyge9GeKX/DX76grHvkxLA8RSp9
	vBYDg6rseM4Qx9WW9TV7Kp0xlkZCDyCvJtJ5GsoxgJWScSrk8K8AgvA/y+Utj9kf
	HOBz0+TepsPMyyFukNcInryRClLt+YRHAtR+C6Z4PYgKC5Bwqsu/SUBy+BAxxCpe
	JNXRcC5BdTESZ1r6XWMzWSc+tYWAYZhvlsCZoAi9FEU5O77YVGhVqhYPrJIdBFoZ
	dvh/mvyzAvxlCjQOdxd1Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141101; x=
	1733227501; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=m
	ibR9mMYccEOPLcWpj7fBjv68lsapKmkuLDsQAal4tcDovclmlhEebgHm49MI0wEZ
	GZUTfTVF2b+hTo2047aLckf4wV6HkzNyyRGra5PMl58Ai316TjCSA3d0oaew43NA
	sZxYo6Y0SjoqRXMRaAyTllWdrG/4trKjXQtde/M2Z27WYVjKH2lnZx8fJM98YiJk
	cMGBGF1R2ZK4C6C2nDzjnB9EHcGnNhJaOjw8YTPjOBnm9MznHZoFegmb8s1xKTRr
	QKiWuitdMIDYcCMz/tlsIQkQ1vHIdDtstR/tp2hpusfE3QA/nng96zI18x8/bpKo
	rW0v/JNd/NLK05lB3U/gQ==
X-ME-Sender: <xms:baJNZxOvR_ueGgy83eTHmS8bmAUr52gve0ebgoQsU_b9L81Hi4Vg7g>
    <xme:baJNZz-5SowVxD7zGbX4bbmRi31MKB9vv-RLHEvd7KOTKY1Xvbuf9Gc2hvr2ZV2Zn
    AdHUogZb0na8-eCeA>
X-ME-Received: <xmr:baJNZwTSsz3aRLVf3JV-uE-XoFE-2SnjVF50RfUSwsHO_sSuJzdEtnLotsXm9iHdxZC573hFUyhQKEqEqI5SvF1RnR2Uj5MP7ofuKUKGve9rss1VEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:baJNZ9tv0yzUEQM2XUPVr7C7Dj2GZa-7xw5524eG5_IMt-pH0gtO3w>
    <xmx:baJNZ5cmrVDbxMWFSgvnio-_rm4N75I4H2DZqPu3xOFq3U6QnFYk9w>
    <xmx:baJNZ520f_AnrZsXszYE0KE8uIGkGdMIOaCZF-uL1WferV_6EdLbWA>
    <xmx:baJNZ1-G_jsVZ5E4PyxghQv2psYxyMfMbdx0SrmEXasLymvNHQPE6g>
    <xmx:baJNZ94w_dSxfaBqxpYSmsK6AI25dJc_SdgQDB4DyJu5w3xjK5QMMMuI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3208a703 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:35 +0100
Subject: [PATCH v2 03/14] compat/win32: fix -Wsign-compare warning in
 "wWinMain()"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-3-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
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

