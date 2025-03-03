Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652F236427
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034699; cv=none; b=ABC9/rjODZVdLpAPw7wNC72k4ITUCB4ds7ijnmpk6MKknh+V3IS4LUEyngFx6zsCEKaR0WlJeJxLWgfU/Mb/DWYN66uaAEw/PajseYGcpfTcDCe1ZMCmnAInVmg8ULo9iI4SygbRx3KY3JJBRtshKSIe8sKZOFa1/CEYGF/D6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034699; c=relaxed/simple;
	bh=oMkZFVQELeOcpjkK8Hpulu/osPSIYKypyuPzaLFbCyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5/ZodZhGMzJrVBQI7GBtiylr0qh6YK3WrOr5KXGaufiDQsP9gA945r6j+45v6Iyn/w2RPXo1xBz3edIPCb4ps7R5nDqeoE3RfGHJIZiFVR3XgHlbkVl47g+alaHaCv0rdyMdT1VYXDIuGTMf66f7xDY6CYKMz1fKqHgcaJdF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nb1qV9Hj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jm7HUT8J; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nb1qV9Hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jm7HUT8J"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F06C1382C5B;
	Mon,  3 Mar 2025 15:44:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034697; x=
	1741121097; bh=1O0FsewFAVVHKDPoO9+KRupWXceBqpiBzoYwVmzXDII=; b=N
	b1qV9HjC1cFk4XfbROgIUz3g2E0/mnoLnTD8D2f+tyQaO/6dAo9RmyxbLyy+dFz1
	3KTqo5+RHjEaA3rUWYDZWWSJK1SXp7HhydC52UA+sRm+Q1Y0vkRzZJDm+qEcTSsc
	V9WnpR3bsTZb9PeKEFIN5/YRaLqGJgPWZkQ/n2JJNgPxDKdccXpdqT8jamGPIOmh
	QzsYA/x3vVEFdcu2HnDLDOl3UCTB0TtShiwy1P9Jyb2Sv7OXKR8AHv/fOqB08Q9C
	wbdq/Y5YRIjFwZHFunVdLhQGsrKsWSfp8Qr+GtrSv+6nMv2FbcQkdoRA3XtLRpC4
	TWV99jgTHD7J4loQJaIKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034697; x=1741121097; bh=1
	O0FsewFAVVHKDPoO9+KRupWXceBqpiBzoYwVmzXDII=; b=Jm7HUT8JtNOx+19so
	qd9cxhRvt2iXaFuvsSIuB3vx4FpqL6PR5evDfcuRIgRGLyqACFXViGDtMcD6Krky
	bWuV2Iw+Cm5pNe5xJJMnE6/uEuYjd9GgHxCH9ldeSTj1L1Kejse2/d1+E6tV23dJ
	hlueJIh2iq4RdLQA0/vbzrD25mZPocKexaczn/Kx8LesU+Hr0+1IMDLKj559Km1z
	mGggnE28ZvKe5n3Zv+NSPFiBLsPIjM9RCGcykizE+AeORwDpmjGKsATZHRBiKJiU
	dWx3hmBx5FHUocnxSPNOnzE9w8L8QcimMzFJG9Hmpqebd1DxPh0tvxKF0onadPSU
	UnWeg==
X-ME-Sender: <xms:yRTGZ3Yx2Jatdv5rcP-x3zs8KNv-UuLZo2iBX2KdE7MH5_wzklzNfQ>
    <xme:yRTGZ2YvO6tPaXVvjPQ0CL2dG7fUC-s3FiMNSyroin6aquqjw0rfON7zNzL2dZScB
    1mWYdflBJORIg8gjg>
X-ME-Received: <xmr:yRTGZ58qMTJqwSh8J-6PQi6pKvWb4PRfENBHiCFYdreGBS5nvuCoPNWDUH-AS4ThJMu3hT46YTKS95Eu2OTP2QjykE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeduleekie
    etueejgfeivdffjeeihedtvdelleejvdegvedtudehjeeikeegkeegudenucffohhmrghi
    nhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:yRTGZ9prsfwPAoVvv59V9fYDQVAaKLtDbBDP91NF9gkt_xTNgfnwTw>
    <xmx:yRTGZyqMrLNo3e5hTNave0RaexBnkawXr37phcElApjyQ_oUhF5WVw>
    <xmx:yRTGZzQGBKqmWQMm_MR2dtmtMoh_vhO6W8eOWJQbQSJHOxMIgoeMDw>
    <xmx:yRTGZ6rt1kPOY0DrxP9oPSF0-pyeDG0SCR0yY7aLcIAeSawtGin3JA>
    <xmx:yRTGZ1V-i4Et24-zcCWy4QSey3SJxRQaYVGhdOEDbIwqqtRNd74SZSL9>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:56 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 05/34] README: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:03 -0500
Message-ID: <20250303204443.360595-6-tmz@pobox.com>
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
 README.md | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/README.md b/README.md
index 665ce5f5a8..d87bca1b8c 100644
--- a/README.md
+++ b/README.md
@@ -17,15 +17,15 @@ Please read the file [INSTALL][] for installation instructions.
 Many Git online resources are accessible from <https://git-scm.com/>
 including full documentation and Git related tools.
 
-See [Documentation/gittutorial.txt][] to get started, then see
-[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
-`Documentation/git-<commandname>.txt` for documentation of each command.
+See [Documentation/gittutorial.adoc][] to get started, then see
+[Documentation/giteveryday.adoc][] for a useful minimum set of commands, and
+`Documentation/git-<commandname>.adoc` for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with `man gittutorial` or `git help tutorial`, and the
 documentation of each command with `man git-<commandname>` or `git help
 <commandname>`.
 
-CVS users may also want to read [Documentation/gitcvs-migration.txt][]
+CVS users may also want to read [Documentation/gitcvs-migration.adoc][]
 (`man gitcvs-migration` or `git help cvs-migration` if git is
 installed).
 
@@ -66,9 +66,9 @@ and the name as (depending on your mood):
  - "goddamn idiotic truckload of sh*t": when it breaks
 
 [INSTALL]: INSTALL
-[Documentation/gittutorial.txt]: Documentation/gittutorial.txt
-[Documentation/giteveryday.txt]: Documentation/giteveryday.txt
-[Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
+[Documentation/gittutorial.adoc]: Documentation/gittutorial.adoc
+[Documentation/giteveryday.adoc]: Documentation/giteveryday.adoc
+[Documentation/gitcvs-migration.adoc]: Documentation/gitcvs-migration.adoc
 [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
 [Documentation/CodingGuidelines]: Documentation/CodingGuidelines
 [po/README.md]: po/README.md
-- 
2.49.0.rc0

