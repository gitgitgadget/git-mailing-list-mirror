Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FF156C6F
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833246; cv=none; b=mlexmBehqn8sKjLDdwKNQcVt2nYwAvmB8GKKke3Cdl6YkJFBucR/rJg4NUD77GZF09b14qk8oN6iBjCRUS0Q5MCJd73IqmQzk8ugZQyTyXWyuMtiF1wJ2r7bI/4H3BU0sxUkrd6/Y4hVwGcDvOx3jSESo5xlmLV1qo995R4SBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833246; c=relaxed/simple;
	bh=Ql/wS34l94LBCDfphZEQ8RUBUlaHS351VETlePm5/90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uytgd6Oj6pbmXds9uD0EPRvMII2o/4DVl3s+K3tRv6EdtcGCuQ6EbGm3PbkwqHXM6AYHROsSIFkfe9h10ZycI3Ttj/wLV0xYKp8bU0dU79FgxkQI0/eBMid/1TK426bLC5nNwTjaSgc/rp9K5cyB/ARTsC4YbY80q3soF9e7NXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V6wGoXQm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfpfU18W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V6wGoXQm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfpfU18W"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A3DBD1380348;
	Fri, 13 Jun 2025 12:47:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 13 Jun 2025 12:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1749833242; x=1749919642; bh=P2
	bl9WP2rMl80VVPDajgbCQFyj1RC+3gpHipTCxTIRo=; b=V6wGoXQmjcXXTqGn8Y
	/VYPi6ZrXJNZR0Oarfy63igKyIBg3qxGszeQdxHXrfd/Hxoux4xNgGQ9BGwP03L7
	ZDBB7Tco4xVbK6kKzK1Qt4WHu2v1g9N5QgHMU49QRE9d9LxOfy9hxMgNZHZkay8N
	ArFLNzqrHaGh8tMWoIzUeA9NBsNP5XiJvP31qL6d0eegCweUTIhYV46VEntmOcrC
	vQHTRMeP7BGjyWuUu9QXcmtkw0aCvL/cPkr9UPcOD+8yRmbQR5VohR/poD4atY08
	4k2Iw3EPI32xg0u6jK20hKXcqe4EZBtWW1VWCwdug3GZ1PRpjWY39bdZx7uk7G/N
	cc/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1749833242; x=1749919642; bh=P2bl9WP2rMl80VVPDajgbCQFyj1R
	C+3gpHipTCxTIRo=; b=XfpfU18WQ9shC8dajnE0PLue1gB9UHubIb+0P1ZSmv6u
	jalOh5MFzrwh6dI6IVeS3EObwl8jVTLvc3YARQwCejEBtaMs88duXzz/6uT10PwJ
	Bt3YV5aEGfEAWoEgx1fIB2l4T2hLlE8gOcs+itwaJJ1TAMdc6QCxjBKzrKXi2rD7
	0Hu7C3cV0MzTPF/uj8L/OYPRJRwhCevR2qbaN8vODIbX1Y6H7cQo0KUvMqdBarye
	6wkBj4JnQZMOo+i5o/V5ECjICVCQsx2YSDg+iStPh6g+beKvB2xqK+z2etG9uYbr
	IOjbBm0ORTE2xBHe4qoa4tQK5PMPBCsZJt9/W1BfQQ==
X-ME-Sender: <xms:GlZMaMOLUDbfkqsQPE2ZYfwdjIbqQhT2D41feHEwanI8fH_TOT0FP9E>
    <xme:GlZMaC_Qlrfa0rVjR712ufen5D_RSYkdXCBpFoQc1jl44Rx2E-9BNVhJgvlYom7Tv
    1s55G9COjXtWk5RTA>
X-ME-Received: <xmr:GlZMaDQ29U6uka1pebUr_Pk5952PQ8ltoTr5KDn43hfDykVlp_DL_nddGY0PmcwmfaUihQeCz5VxRatr4LAxXzLLPPqFXiwILKppfT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefjeehgf
    evjeeuiedttdehudelfefhvdffheehgeetuddvkeeihfegieffueelleenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:GlZMaEs47kHtHnAqxx2IvOrWWUEvQq8MALVq9IBDX4cRcrIPM0zVjA>
    <xmx:GlZMaEceaUTBlWkYBbeIXEZVqptDQ_dq-yht1UR-TAsb71-sd1S86w>
    <xmx:GlZMaI1KUI7Q_M8KYQU047aD8cpmKV9d9dJJAHTM9y8z2FZRGFVppg>
    <xmx:GlZMaI_9wy2d015j3AOPFPxacZ7t82KZKIORk_lgg-fQ_rPQBDJ2lg>
    <xmx:GlZMaIPD_XbZyECWx7uy5KK6yyBL9uO6-v1xX5KblIDAimyIpsMYYERX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 12:47:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: provide clone commands for the pre-built docs
Date: Fri, 13 Jun 2025 18:47:04 +0200
Message-ID: <45581cb36fbcc33992cae5b740bb801e2724aa90.1749833159.git.code@khaugsbakk.name>
X-Mailer: git-send-email kh/v2.50.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These repositories need to have these specific names.  You could end
up cloning the “git” organization htmldocs repository[1] which is named
“htmldocs”.  So you would need to provide `git-htmldocs` as the second
argument.  But it’s easier to clone the GitHub “gitster” user
repositories since they have the expected names.

The aforementioned “git” repository also uses `gh-pages` instead of
`master`.  Which means that the `quick-install-html` target will fail
since it expects `master` (`GIT_MAN_REF`).

[1]: https://github.com/git/htmldocs

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Spaces used for indentation here inside the comment.  I don’t know if
    that is correct.

 Documentation/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b109d25e9c8..0493a38684f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -439,6 +439,11 @@ install-webdoc : html
 
 # You must have a clone of 'git-htmldocs' and 'git-manpages' repositories
 # next to the 'git' repository itself for the following to work.
+#
+#     # From this directory
+#     cd ../..
+#     git clone https://github.com/gitster/git-htmldocs/
+#     git clone https://github.com/gitster/git-manpages/
 
 quick-install: quick-install-man
 

base-commit: b07857f7dcffee4d3b428df8dce6c9b49a57c9c1
-- 
kh/v2.50.0-rc2

