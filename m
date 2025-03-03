Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB7235C04
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034708; cv=none; b=uK5xyOEB7V+7zNcM/VOsERNJw4d+xXF9LrBm4x/4DAobmoyF0aJFRfeAAIsGvLbnRAn9DFGrx39a+1hZEUf66BIl9IWPGNTouH/r/6IZLOzNrfxHn8eFVLrFZy4jlEOBJyUOygiUFzfhAKdBlS4/hMblqRkIPE5sQ4NYFz0pmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034708; c=relaxed/simple;
	bh=ugMMbce1qMQcGRhKaFD6k4nYvv5yXQwwziLFMXbiut4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWCb9lHlkD2/ppDAikQnC4KQJPQK3zrzk39Lohwp+RekJUru8ZlEgdz54rzkQvva+6epcNJge5gmD4S2OR7skgmYoFr3s6httahtPmlmStc5Pd1Dgt1zBXVzNZGrlY22zo3IrwdxAivAnQ5fn4L0EEcbEpFkjIfQxAnfrUAqw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g7GRwPV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWXXBEY4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g7GRwPV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWXXBEY4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32BD61140189;
	Mon,  3 Mar 2025 15:45:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 15:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034706; x=
	1741121106; bh=XU/awOk3sgjemUFvKBljxwnoPtru+3wmM61qHajmi7A=; b=g
	7GRwPV9nn08bvzWEKUY7NSbfNe/DBw3LFp0sLAlDGB9bhWHw65vSMrmr3eR9Bimg
	aT0NRHkKGKyiD2AOdjNDrOmPZoZTKLCkskxvcXGYBmydqzPePftRmYjq4RO/ihic
	zvnpuyftwSISwnLrvLzmVzyFpiun0ld5AtdwgJ7+A7LwBA0PlaeJSoTTJb3aFKys
	InfejvkGKXNth6r8Bp1qCS2XejcNM3Nw3v5gP82gfXskq09HRSjq9HTB5IJzzNI5
	DuWCUP4Qq/0fiH/aScGuuKNDqbdIm0eRU9jfJVdB2coc/iAEqQJvhkvU/mAVMxl0
	N2GAAW1AseP461oJSjEIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034706; x=1741121106; bh=X
	U/awOk3sgjemUFvKBljxwnoPtru+3wmM61qHajmi7A=; b=NWXXBEY4AVV3DS7H1
	2JI9UCc3YgKfVGayUTsM2UjseO4cbeLh3vFe1uS+MMdM36H38tx31P/E/kbBz4Ja
	zBHVCna5usHvKUfVvxkctChDysx82/e1qE2x9b3+TCoWWE1vjUFz9Ms7IM5R5SAJ
	1bG/JRbgpeAuhMJapx8OtpYLghKujVKgQTQutmTcH3/TymX8tGO91qXH7fV1NQS7
	rrAb0esIsZp2HZTRkLhhr57DRbVZempKyfBJ+WEasd5+n7c8v8jkATEKe6IqZtQ4
	ms5P/eV5RyKQk43nwwNemiWuu/e2wimDzt09xylYnQutcXhhA0cgtHkK5aUMcTWQ
	FJLSw==
X-ME-Sender: <xms:0hTGZw8VrusCszFsQJotlkUDH-bp_kT0j_re4UdhTOXL5NePh4xP2A>
    <xme:0hTGZ4uN1HMhY00njoxGXFlritPZnVP7-M2Tz9dV3kXJepFdQfKUHhBiCqc8DxnXM
    A8xstnUZbxi-wGfoQ>
X-ME-Received: <xmr:0hTGZ2B-L0aDsVk4UjFpN3aeEh5gt71tOHw0LYdFOLbGsKfzKf2oRS0YmENW1FhPy3HzEmJ5v95vk3OUBzMDRUB52OI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:0hTGZwd7JpOnXzwhWWpdppCkxyIuVIzGX7EwMfzuXbJCzeUxbC8xjw>
    <xmx:0hTGZ1NwovKYd_NQyUm_l5kO85v0Ay5HZOlO4bHhQquuayYFVkjtvw>
    <xmx:0hTGZ6kBf0cnFv8ukGzRnr1T3PsapptMoxzCNvIrrnPBQZixCMVDYg>
    <xmx:0hTGZ3sc-xRAmaXw2L5AFdWPLJk1-qeDrEwR-7hTME4gJYV0Y8VpZA>
    <xmx:0hTGZ2qTfDNsGy1dQ2f0TeakF2IHRAt_00RY6m1-cBbWYedVPHk4fmMJ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:05 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 18/34] diffcore.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:16 -0500
Message-ID: <20250303204443.360595-19-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 diffcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index 2feb325031..9c0a0e7aaf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,7 +107,7 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char status; /* M C R A D U etc. (see Documentation/diff-format.txt or DIFF_STATUS_* in diff.h) */
+	char status; /* M C R A D U etc. (see Documentation/diff-format.adoc or DIFF_STATUS_* in diff.h) */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
-- 
2.49.0.rc0

