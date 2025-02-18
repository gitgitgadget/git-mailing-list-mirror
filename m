Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365914A614
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869163; cv=none; b=TsznUqyhi0gmbT6ndm3ZEDmO+5z+XFa1cZrwxxFOzqsX0EzQQDJWFJsM0x2yZ9TR1ASVonkpxTSVqBoXt+O27cW8wjeDsbPpaekEVn4apm3zxwk5jn2pWmu3StpoEII3Q8Ci5TUXkspYqPDfqNg6N6gM63/IUe9wsSCK9gH2+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869163; c=relaxed/simple;
	bh=SbFLUaY3yMqYL6bzldpbT3gxus2Kf+E+Xx/Gpr8MhU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ja84Bp0sKO6E2z7ZOor9PRn9uX75omXvlAJ4bqVOI2caTS13cH7/y2WXGSIODu73jxQMcblP5vHRo7vQwn8y6Ya8FFTYd2hz9tSdThQZ3kWF6Dwh4WJ8ck+qrB3UI8ZfusHS4eVYAW4dHgqtYb2uTkzlDPa8ZMe4FcDaU7M+4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=TIqPWJ1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEt027Sg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="TIqPWJ1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEt027Sg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 214EE1380A51;
	Tue, 18 Feb 2025 03:59:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 03:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1739869158; x=1739955558; bh=gYQ73/TJdh
	ArBPonpGxujVYcxqyIXj7UoqKaaPq1nbM=; b=TIqPWJ1W9JrMJ6pVOEE5I9sQqX
	osN39xGLhQDrzhc+owuYZBTOZcBjMjRj23E8j5p6jG+86PlVS/t4vPE1uzIFUwgI
	MFXJZokr1vJAM3JiuyrCaWeuxWD6cckW3Vei6ksI/A4pWdw+JjiP3xm0rZrxBj+H
	PiNAN0ZzGcQBNF5yPKJvqdFHu0Uij8MP4TtCUHOeOvQFJcer6fEVZ25DsaQDIaYS
	/FpsQpYhOlyphW5yVRb5XYEmkvF4rwspveUigrjATsVklGnmR7iHTILFh8RGxA2T
	mxFL+2muUyvaKLPPAjL+fTlJ28+nYC4BSPoaS59SJYbb1enBpxOYpwTyyepw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739869158; x=1739955558; bh=gYQ73/TJdhArBPonpGxujVYcxqyI
	Xj7UoqKaaPq1nbM=; b=UEt027Sgi97QP5mrvFuGChN7oJzmNLOGVDYYUYl0dPRr
	pbIowYY8zWc+xA6coNxmcJIipiumsIcwPpES612/ithRaU7RV2kEW1eFJJ2IZNIk
	AlRtKV9nCclA7Hr0Vm/PQYkdKT2M7TJLSbj5NdncjYoE9bhT+/aDUF4Or5cdhBrw
	WIARpy8QfVzD6B49Ef5lOv0+Fdncnqh+smN4IG/AGoC2Z9xfU0v69t8GRK1admJE
	VkLZVCZRrGY4Kpy3jeca/kRAjcsm/QAkNErprDSyDf76v+pLNM3fAgM50zEES5UI
	PPsM2weAJuqc/c3FqVJp3O96Kj0KF8WDLqywuNjqcA==
X-ME-Sender: <xms:5Uu0Z8UeGqVDQKXI3nG2XRbxLpigAMP_FXSUUCgGJhrQ1k47kyhSvQ>
    <xme:5Uu0Zwk0Vj9QpA_Lw-vcjNQpyc9e0z_Pei-dOaC-SoW0R6YmGQ3cgBEFo_K9H7vgk
    CPE0QjcBm8DD3YlMhc>
X-ME-Received: <xmr:5Uu0ZwaWICg2g1dX8cXtr_GlJNp9iwKdWWC6VRQPlDcaIS0BIf-CGXzRqD0ncZCOrt3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghtvmhjucevvghplhcuoehm
    tggvphhlsegtvghplhdrvghuqeenucggtffrrghtthgvrhhnpeelffdvuddtkeehvdehhe
    euudfggfehffelhfegjeefudegveduhfdtffffudejjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdrvghupdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuh
X-ME-Proxy: <xmx:5ku0Z7WwFCP60iLnqNdfUXW5ALJY67kilp3G-amv5d-1lnvUPRhixg>
    <xmx:5ku0Z2mfsZ8GMgUrcEsGKmk2HyS9B9oaafRnxNDqNmAX4IFPREKqnQ>
    <xmx:5ku0ZwfSixeA0IS4mOJY_G1ooFtYPfF61CKb1v8MaHbcWb7AkerKmA>
    <xmx:5ku0Z4FITMjUvApm4DnRIF12pmCHq2fVmO7vfG0VpsJkENfdBuTfoQ>
    <xmx:5ku0Z7zQ3-X-WQ-W7G-62RE33D8Sa8z-oqeCYWpwu3ATesUEm2_pqyji>
Feedback-ID: i8c5e488c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 03:59:17 -0500 (EST)
From: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
Subject: [PATCH v2] doc(send-email): use correct name of the --signed-off-by-cc in git send-email doc
Date: Tue, 18 Feb 2025 09:58:38 +0100
Message-ID: <20250218085913.1381537-1-mcepl@cepl.eu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I don’t think there is an option --signed-off-cc (without -by)
for git send-email.

Signed-off-by: Matěj Cepl <mcepl@cepl.eu>
---
Rebase on the top of the current master (Whoops!) and improve the commit message.

 Documentation/git-send-email.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..5287f1115f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -389,7 +389,7 @@ Automating
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+specified, as well as 'body' if --no-signed-off-by-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
-- 
2.48.1

