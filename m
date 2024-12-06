Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4701FC7CB
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480861; cv=none; b=UfLWK6OkcvDHoF0Agl/BKB4eJmgKaVcFYrdSE/TKUsx8PXxoNZj2Eh8o7A7ohyyPvI9B6S6KzkF0CmqH9jQTxq9xBW2fyK0DRQ0FaquqxkL3gLmvwttwZOALEt++Et8YNPGGL87MOVvOt73UCsckWUKjxIF6LBgb8ALRpDMe3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480861; c=relaxed/simple;
	bh=D6Hhpn7vxHV7XfFB4j51n7BZsMwQz9dQhOFEKLgOFAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSqIk7lRF+Y8jlyl7rRwxoo9PBWXiO4TOKofnHncTXVFQzg03t2HOOv/qA1lWD8x2uyP1CZTGCwTokpDeWk66esXD/AJyINIjbPW21rtUtQNgKeECO0r6sEzrHyXS/B9QXUGJZzD/ThSVSHoR6jhi92C0BqE/NeeQAyCF4rp1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T8P1Pmgx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yvNCknma; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T8P1Pmgx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvNCknma"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F8F2114017B;
	Fri,  6 Dec 2024 05:27:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 05:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480859;
	 x=1733567259; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=
	T8P1PmgxyHFv+bTWI396kTSGjXtS6hWBkzLsuZ+XnoNSIVZ/0OTaXCTESPTXIhk8
	xnDtsAFfxTgf0ibcp00y1oyRuD74vGCwLvGmfV6A7kbJ/XD0glJfJEEdHtxHXtzd
	ZjrVb5FA+nKPkJTJEPAGHKWfabVOKFGIi0jJSYfgMAGev2kjZf2f3Om1ItffNVg8
	U9pDxQszfoZmiSLpkeKwUD7KsegU+W9UJqg4/P0UAXXZnO54P8SEJUUTd2KwD9UT
	rpAK8c2u/HLe8a6xNmYcc8+9ThuZ7BRpH1M8wCzwSaH08rUN5U9Z0GbsjNptb9m7
	9G0g2K0yZNl9OGxjcdf0Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480859; x=
	1733567259; bh=lHuP+MI7HPf2IiuivPg3fmZ1QpVXDTwAnm9MlbxjQls=; b=y
	vNCknma4+8s/PQG6q9cqqVHgTvaeUDjFps7x8U4W7q264EkmlHOzetzNL9KnRrlT
	iDwvzKXRzz7dLz4WDg2v04LlxCkz3AZtd3i0a4D25FOJUlRECnieyetWx/XC3VWu
	SzbaSYyTahz3diT2i57vhOaykAiNSh9UJzl+tBNR6I/y0rI8fpH9Dw4zMYxIYNyw
	4UyqzSf0SL9eL3X9q8hh2014KAKjHLm2weBj+eNZidqcFkaOCi6QpGjqH6d0cYH5
	WFuTwtOdY0jDdgTMz0dfZpgNoBzywp6JxFL0QHEQnNr2loHteyLtgMN3W6OuAEoe
	ZVV0yUgCykBtzieEgTn1w==
X-ME-Sender: <xms:mtFSZ_Z5HOLUo768BabDCoaJjDhkj31nl0vF3kBxcCNKrOur7rs8Lg>
    <xme:mtFSZ-YNceb6Xqcz7Ms5RmwYSVpwekllRKhazlJ0HtmkK-P9RyXLCxIoiu35UkdJK
    EezLeObpjaukmScpw>
X-ME-Received: <xmr:mtFSZx_nB-wSqZhe8TJ3WYAp0Ef-vHMYlYYI35v_r5O8XcWOWT6acXv4SrG4RfXgQLhto3Tq44ISXLAWmNNQmvtGFgqP4nL1yqJp7fgVI9SzkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:m9FSZ1quetBA0MCwCVgiK2ZtCKSgPrXTP5wG_STSmfBjsQdegbG-Mw>
    <xmx:m9FSZ6rcHAA220WidJRvABEHobOVU1DCoDQd1PTdmRP9eYWFmEjccg>
    <xmx:m9FSZ7RMKVQXy0WaDn24jvt-XSGD8Vm9FWzhS6T0_5mgZTaUKaSdvA>
    <xmx:m9FSZyryDDGCTrjiwPAgy2gr7VDT8F82CUpmKdhdhR44k7ejFcZwxg>
    <xmx:m9FSZzncFsiUf6uZNRoN5-Ju0pTjfgtrpOXWhMTCCuhsHcis2XCezFoZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 441f1ec0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:18 +0100
Subject: [PATCH v4 03/16] compat/win32: fix -Wsign-compare warning in
 "wWinMain()"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-3-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
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

