Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53923E35F
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034713; cv=none; b=RTGhOGbgFi1uz3KjseYEFv1rejXV6CV1zlHhDu1NufyBub7tOUBKWRbts0ppajqjdVBD5to9VTE2WFQsIOKgrIThpVY68ixqGuc8ARAOwimfrN7hoL1EIVYo9OuFuctgLrjgxVmswQUmiP4ChOIQfBNX8vBeqE7I9fI18rwxpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034713; c=relaxed/simple;
	bh=mc0nQ10PoDYGBcdFfwPnpElCCM8gcD/Vq7yG8PFsDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW3pIMaK69J6NXhE97yyNh2DW9QT+/Z2yQKr5+/my54TGQAeALdpY2ViWGcAcVRK8rZLgVF0fdsRapvYdo2uXbTjUoUGJQH3m5XGDlwLVAQGbN9mxPGH0b/FAbicCQtulSLdpi7HE/q3GiKXPVvITqt/u1Tt0ECdURqiBtWwGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fRG5XK8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNIcatyN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fRG5XK8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNIcatyN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 001601382BB0;
	Mon,  3 Mar 2025 15:45:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034710; x=
	1741121110; bh=cA8oddLXNJVqIgdp2GqQIGXaqggVUIcfn2qOmOPvjME=; b=f
	RG5XK8F5RbCE0B+IYazC7Uq6o+wAW8rCSxUvuCTxKfrxV+Qi874xAjE/D/54t04v
	4syTuFgUxVZu5hcWWv6oyuOgUwFvVnTh2WaJUrn2ZEE2/uCNBpapeihLHooxVGKY
	KZgxjz/n7yZo29L78wMOzI0QzEV5zZ9ZNRSo/HFZqfBouXzFvzCuvEkYt8/Yo9B4
	jWZLxrbyuSb+5bRccqLYdoKrj1lG5IIKk1urCGjEPcAGI7vyDjqk7INqHeKA942l
	kv4cYivfL4RNQLZykXchQcCaxcXPVEHOfrqLjmkhHoaEApXc9KNPNgF/dlROJcaQ
	z2biRNbTy7iPajflEhgcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034710; x=1741121110; bh=c
	A8oddLXNJVqIgdp2GqQIGXaqggVUIcfn2qOmOPvjME=; b=DNIcatyNV9Ezr1afO
	ELBU6oLr09arPFuWjhNbXr7OfH0ZbyfMzros80aI6CxOU8UAQv+K7KiCRPMGO/ws
	57KnLT1Qia27XQZOrQI1U+S23IEUW7iYQ7PQr7kW9HTP54/0kv36t6hOWk2Rx4GL
	bqxwVYa4EFR5qVeNUAd/TQTt7zbHRVKoxD0kigvf9cDw3hDrTJmk7h1G995vg754
	pT4QEzOBtwcWVUWXYnUX2Hvo1XbPx+y84qKr9G+LhSepn6iEuYY8YczimXdfIXAn
	FwWCBkiIGIIGS1bAmszkhpKOGLB8aYgOsjAz4mAC/20agYHKMAHjRj75oZAaldmb
	2hBjw==
X-ME-Sender: <xms:1hTGZ--by5P9HxWpq8afYruxCRBZYSQAEvj8M6r8akLnDkwuAsp7iA>
    <xme:1hTGZ-s6FCb7ODqauKa01KVfCuGWsxmjbQuSNNo2-q27mhBxopE6u-6qcoSvsXmCA
    S9jmesLk3yvS40hPA>
X-ME-Received: <xmr:1hTGZ0CQkHWYb_Hm1X66xv245H3w7qEh5cEWgRXJSrcqhiOr8CcWwVxXtzCCqvqDDFvUFrAMOt0d3OMbQAqED_fjiSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:1hTGZ2dXCrCQVvMA-UEWtKJd0YSYmflD6AqKqs_uBe38iZ-Z3yElMA>
    <xmx:1hTGZzOFJWDUWpJhZBgDKpNX7civ6hz2EELO0go4QRftS44XUb2m_w>
    <xmx:1hTGZwklkCsQXumwFks0woNJcC0xXqjzEFmDr_bF43OurDByd-gGTg>
    <xmx:1hTGZ1tsj3K-AHHxG12bb8-dOQ5y6FMTulOI3xTDPCGrg-1UWDF2OA>
    <xmx:1hTGZ8rCivvG4bIHeXSh-R8bgoztGR6nQ5_eNSpDw0r1SScpcCUp4RxH>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:10 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 25/34] setup.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:23 -0500
Message-ID: <20250303204443.360595-26-tmz@pobox.com>
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
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 7da7aa8984..801bd8c1ee 100644
--- a/setup.c
+++ b/setup.c
@@ -1822,7 +1822,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 *
 	 * Regardless of the state of nongit_ok, startup_info->prefix and
 	 * the GIT_PREFIX environment variable must always match. For details
-	 * see Documentation/config/alias.txt.
+	 * see Documentation/config/alias.adoc.
 	 */
 	if (nongit_ok && *nongit_ok)
 		startup_info->have_repository = 0;
-- 
2.49.0.rc0

