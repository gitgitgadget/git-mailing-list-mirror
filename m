Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F145945
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363351; cv=none; b=slN7dyzH5cJxzQ5pYcq/KAwHlHQVMno42XE0WO6POuS1/ox9xICU6her63SAtA5ScpPQ3LI4j/Xkmiih6dMbu2ow/nuxceWZzHtC7YCXJMMf0PhPdo4K0iVV8EP6IDKP9spYAdLR4ctS/K388Fn4mZYOTdSds3sTH9vjFSCXJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363351; c=relaxed/simple;
	bh=Kk8wt/ey6HkPG1o6XkYLUvDruJf8fsSI8fXSnGdu66o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGybMTmsBOhOkrWIip0DknxQQ5EpMVgBhwq8rlRhCTfJ291on/6WKPLbQ+xU8UMVwh2keZi/fnQWCSLcYzAYopiHdPhvR8PmzQBLMVR4sYL2iga7AX4W981q2X8/3HRWzBA7sjZI2Skd/nfhiVcuf2lv9NaBr7vYpvuQ2j6vPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Me5Z5hv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dc3CQouk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Me5Z5hv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dc3CQouk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 244C21D00126;
	Mon,  8 Sep 2025 16:29:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 08 Sep 2025 16:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1757363347; x=1757449747; bh=EO8Dn5i7a5ZJOs/mrLwjZ
	k1PAUw8kxGvepByaThoJjM=; b=Me5Z5hv3XJXy/drCFAkQt56xZvf10OSL+lF5C
	TZyvX4+lxIIPGZsSWZhh68nHGn+sVY1pW2CHSr8GL+bW4WKlE37bVty8vgbo8Lbm
	c2UAKCEOFAvuydxQAv9Ng31f211D3E1CIdnnlBl7erWZ+e+zwRgMMvDvu8hnEI89
	cNCVOVGwCh57wJIRYnXUxeChS16BwJeWEe1S1jcEwWDWC21U9ykrv5/qP1Dv7h0Z
	uP/6b1SW8p7voCQUDmIUBwzfUdX48BtWqwoMt5rengzuN4OcmM6uF3yjl55kdBvp
	ZTEHJh0N3fTTGC5Mk8RGW009nH03DL4qrdOPKjCEwf34JPaKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757363347; x=1757449747; bh=EO8Dn5i7a5ZJOs/mrLwjZk1PAUw8kxGvepB
	yaThoJjM=; b=Dc3CQoukOryH0Im4xzEJdZV6fq0NhVs7Kqh7cCnVb9k7CelSwHU
	HB/k/p4F5z34uoH4IZCX2Nx9WxmPYHCMUEl1fMtfF77OMQ99tFNlzib/cs/rnqNx
	Ht3Te/BoAdP+dyWjeaoHj5EOMSlUgB1ZIxS2e35bZGsLScI5uC2vPYvVA8CB9CUi
	qR6A64fEovIA+JaehawRtZo8nz/EQFzAS2ZBK51UJkPG+eceeKJ4Orm9zKWlzZZQ
	u7vvKdyDyUIY5sNAJzlACl1JgEJjGi9LGAdbYFJ7RMQb57d17VnOfUz1rjIgQRGF
	xFTTMD/9XOr3U2UVouJMXE/gBt0ckUI/GFQ==
X-ME-Sender: <xms:kzy_aHZj5gjo5B3geU_tUl2FQv1uMRx_3hV7WVQgkvzA1wa5ohf4GiY>
    <xme:kzy_aJplugDZYVKdidmrPJuXdU2NWPS05YqEpU47mf_Q0z2c_TNn2AVj_uxbkJpdg
    2n9cVfTKQ8srJNeGw>
X-ME-Received: <xmr:kzy_aDYiaOWtJdlw2-jSA7MBMh2HsIy5LeniFK-p-L8wKaKqgRyDLWVu8XFv8donE2dwlTBwSAQWk2H5C_Lnrc2z-vvOWp92iUCbHdBo6ivRckkOtW7Am_GLOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmnecuggftrfgrthhtvghrnhepvdehledvjeehjeejheevtedtjeekhffhffevte
    dtfffgkeduvddvteefjefhuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghoug
    gvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvth
X-ME-Proxy: <xmx:kzy_aJSQPATx1A1STLkbhfr9i0KkwUEsDop4V5-cuUMv7csRjl1-kQ>
    <xmx:kzy_aC4IsOLkQZfr_hW_F7BQ5qPo8nq-cFCJV4aqnKQ3Ui4oU-rEmw>
    <xmx:kzy_aGzZh4ibtpADJ_QUpqNzMWvlWw45v9EnefcvEQV3Ys3zUeADog>
    <xmx:kzy_aJRb7anW8a5jr3urFOAsSc_Tj3T9N64KvcR1KEE8w2-WVbfLqA>
    <xmx:kzy_aJsCCKFJxttJume1dVrthB21qi_370JptyVeBVMqeWltx3iB0ExR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 16:29:06 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH] doc: fast-import: replace literal block with paragraph
Date: Mon,  8 Sep 2025 22:28:45 +0200
Message-ID: <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

68061e34702 (fast-import: disallow "feature export-marks" by default,
2019-08-29) added the documentation for this option.  The second
paragraph is a literal block but it looks like it should just be
a regular paragraph.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    > but it looks like it should just be a regular paragraph.
    
    ... unless this is some kind of callout-block style?

 Documentation/git-fast-import.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 3144ffcdb68..c3951f5f879 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -61,10 +61,10 @@ OPTIONS
 	currently impacts only the `export-marks`, `import-marks`, and
 	`import-marks-if-exists` feature commands.
 +
-	Only enable this option if you trust the program generating the
-	fast-import stream! This option is enabled automatically for
-	remote-helpers that use the `import` capability, as they are
-	already trusted to run their own code.
+Only enable this option if you trust the program generating the
+fast-import stream! This option is enabled automatically for
+remote-helpers that use the `import` capability, as they are
+already trusted to run their own code.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~

base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
-- 
2.51.0.16.gcd94ab5bf81

