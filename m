Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FC1CF7A1
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391415; cv=none; b=CJsNJipSMjV+lyk1M0HPvzJjrm5mt+lbl9hTQLq/tFjO3d58s54LxhAETGymaSbBC0xwXosUzqgt7AcOKHw23kTNO7GO2/lV8X8ovrI5ITEE2xiaOkG0gVpwwHm8S03RZlYT8YLVeseunHC315w9IxzBMb0+9jwupdjHLlDu0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391415; c=relaxed/simple;
	bh=D6Hhpn7vxHV7XfFB4j51n7BZsMwQz9dQhOFEKLgOFAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmTyovTysF2iDsXFgeWKJJYQieWpN/PZJidxeAKWZ3YbymL6t3VI/ivCyYCCFSuBcsj1n1dcXrUeW7hjskHCizLa5thoTZwZ6ClzFHDDOcTB7g+yTVNYvbR2stE3tlaF2+id/kNcuKUQ3cSE96y6vrwxYBi40UYsDYzDI0+Sl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSAt4RPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuFyEWci; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSAt4RPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuFyEWci"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B699C1380B82;
	Thu,  5 Dec 2024 04:36:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391412;
	 x=1733477812; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=
	ZSAt4RPFPZy94Tg97J1uypuhWOsZ+lt9UOs9n/KOW5OSY3qQ+z60ygQO0vUuyR9K
	709l962oC3voZjt4r90cipSSqngu/JJumFA295icgg93hFlvFGDEPS+YpsjTJwy/
	P4F5OzknSfC7IOzQBbDoEb1z5FKyWyj01rHiCOeyJntB9SP6V9f94fy3ZPcFz7zI
	KsQ14Ubeq/jk0e4RjLnaJdQocSuONfLhsOtC+yKgVqrp4flFOkyme5mHkrupiCed
	tCvnsLufS6+gVurbLiDA3BiewrCG4GUj/YQCvOKBDacar6mUa+mjJIrSt1KaoZkd
	RhT2KLgYDwo2PHqqdqxsqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391412; x=
	1733477812; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=c
	uFyEWciOVjwsxKbnwtgcxbf+yd91Gibkj8NRi+t/VlctG8bQY539oC8OY/GkfK9b
	xI+pJKyL2IrFL1OfCeFZu6UflPNrCxqTYfHxkb+lOoNqBuvy1KUbkpYSbwA0bbBm
	DttT4HNX//xT9rPYbv0RWOBc3dfzZYqNNafCWSQWNuGDTqUm0OaZsXn/9dp7KaQg
	q1kTKa4Vh1ckIGVtajvPkvurmvfOTE5MZ9EZffBrrmIhl/DLJXeDU5Eri7R1drxo
	IUn0grCIgtPAmDCP/etXj/IhLegeV9ccCVzZpehKfdy5cztBul4So9BMAs4Yyh9x
	dj9fSkuLsXLoQDGcGzcOA==
X-ME-Sender: <xms:NHRRZ2vjTF5Dkj5PTKpUu11Z2RNWvpG1xpJBk3RQrwpHM0L0cFaHwA>
    <xme:NHRRZ7cSqfOEs0dpDKo4Pa3cv3sQ9v3aO7eVeXlegfucigPSyVOn0gSQSsSGd7865
    MJ9FcD5--eqlvGwWA>
X-ME-Received: <xmr:NHRRZxy64Y-pZB_VCRwzugRNXoLqj8VoMh7cK3VjGvTIDcFWRV9qEsLLt_ItM7NvqTkABFb3jTqXRAd3qbPA4xpT_AoSrJ8ZvJTgIKw5-BaLBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NHRRZxPSBC9xhOye2PMfBiBjOJKEyFldFzl_my26eJ8BZ7o0US-FQQ>
    <xmx:NHRRZ29IkrnT15f_12Nvq8lVttdvZ7rh0IlgwYp8xoHyksOkW0W7qA>
    <xmx:NHRRZ5Utl_lwGJD46kvNBR_7MHIYdwj8xWnYxvvYRcVmDjWE7sjb6A>
    <xmx:NHRRZ_fXS8YB4fWAQI9U2T-vjFoKkNdNSPq7uoRcikOIn7JMFdv9FQ>
    <xmx:NHRRZ6bOjZ8sXySOua7U1ApC046WFJteX--TWCSxSNnMvN5Uor4j_fhF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d98fa6a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:25 +0100
Subject: [PATCH v3 03/15] compat/win32: fix -Wsign-compare warning in
 "wWinMain()"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-3-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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

