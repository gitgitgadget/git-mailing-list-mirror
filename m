Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A8273D76
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660616; cv=none; b=qvMC79AacdV5Oqqs7Iv+bgp9BLuKd2MOz3KED62XmLaj6Ld3i5ca0WW80L5du+67lCF0HjvAeRXvTKKEhWrGktxwmoOuyua9BkvDWstEbpZyELVMZaQWZtI07semQ9X22BwX1KMJO5ylmfgdZJFxXovu28ILPDTbj1tc2v6guMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660616; c=relaxed/simple;
	bh=6uFQSyhq0U7J2ES6G5zlnIoUzXq55N15hW5O1uQrf9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRgQfstvAHcVtrUKeq5xZV91atBRO3b0Rk3rEMxbFIsggtVk/jUB5Vf/AGTm1V/5C2yMCXb/Qt5HZGaeefQfb/4mqmUE05Q8RbuwEs3LRMYSoeMwkyuxnSN7ixZM8+OX86QksJeDkpOlkzOpM3dYAwbHSW118gRo83m5inpjKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lOWr99sZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnhLralq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lOWr99sZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnhLralq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A237CEC004F;
	Fri,  8 Aug 2025 09:43:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 Aug 2025 09:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1754660612; x=1754747012; bh=yGjYcATlPv5moZshOvIUM
	4PEL9rDktwpS5FNsEYVNZU=; b=lOWr99sZZlsG23bZJG6LvvGTr7Do7AiPC2Nu8
	j+Mx0Ctx5wVJ4cG0ji5TWmuUGjgSN7xuJS9iQyVkFQlY1NiOrXSpv11yWU/fDtRE
	Bln0yzJ7bcqgzEOakXF9yJQG9xWYvPXpshHdUHquofUFny5lY0khxp0xmVGd3eeU
	ow2kU5YIDOhZ4U+y1mYDnRQZMD7Qlg7sDYfyiRkSDhNcN7BByV9dYZd979psO4PK
	q/v8UHdWJhKxVSdw8FhmbHP/19yv+y6hfL5ztsKuKbd5e8a5Dpf91dA2sCKguQsf
	lGk0DaNiIS7HrBZbBQFjOokEMRJLz15pMbNEEizlJ1tPD8yhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754660612; x=1754747012; bh=yGjYcATlPv5moZshOvIUM4PEL9rDktwpS5F
	NsEYVNZU=; b=WnhLralqykZUllbwjhV92UpHpLENptaDfCsaIBV8b5obErl+kUC
	upcqcvPXTdCPdfNQmWwsVERDS4miJ3R7+G++FYVOZ85tW4hg3Zy4qtAKXnVw0ZfR
	yJQpJc5qZpncfgEP0YxY7if9p4GxMSDpgTr4YYhcQnGRsAID5EbGjJ9M1ZSgGfqF
	DGpATdpKysQ/gwX88D2cIJcQOAqp5zcsd8oj0T5En8FWBcB5Vph14Im/9jX0uJU6
	Eg20uICncvOuP50SqAFWzewIOxW5Qy0ZX6ss3y77YYAlzqMWTtOR/f+T+v4ff7Ng
	5mA4a5Sdg5dkZ7ySQaWR4II0/NZbnBR8RCg==
X-ME-Sender: <xms:BP-VaN7mscZ9VCZzndfZPHKte_H8gNMfK94kcxaXY_Tu8ToSFJ5hHOA>
    <xme:BP-VaOLIUPy72sTZyz-H-_lwI5UKLcbWP8GKs98XKyv4L3dOptkBTienXnFnhj2w3
    KiLxVUH-nVcF9S9dw>
X-ME-Received: <xmr:BP-VaN4XAxgTFU4k8yXbHgCPtP5j_ORxkiuhM6pWwkJtfiKd77FWfFbzq8-sG-FoNQn8GrPygW1H-Ra4agjeiawcx5iFJzLkIsGFHTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnh
    epvdehledvjeehjeejheevtedtjeekhffhffevtedtfffgkeduvddvteefjefhuddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:BP-VaBwZzO-kOkM75wZjkDqIr69Dx8uCi7ZCl6rMG32kr11DvUaWbQ>
    <xmx:BP-VaBZa1_ArCy0FBRXrng6EguOoYsUYJklmiSCStLZoLxKPH-aZwQ>
    <xmx:BP-VaDQpvJTE4hYocLcXIIOdOxGsKVCowqVyu-RPoAfg7GXioy8X7A>
    <xmx:BP-VaLwDQdhoV85Ht8Nwiw7hNmo1yvFQyC-nbqWU-Vn_cbjOm0AXkw>
    <xmx:BP-VaHaWa017nbGFx8_QQGhANzm4-U8f0ipzMGmjN0OSIw5m86R29YUd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 09:43:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: git-log: fix description list
Date: Fri,  8 Aug 2025 15:43:12 +0200
Message-ID: <aaa1734189ec8bab7cfa0965132e3d8e5909b1af.1754660514.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.1.8.gde7cc0782a7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

b27be108c89 (doc: git-log: convert log config to new doc format,
2025-07-07) intended to convert a paragraph describing the different
options for `log.decorate` into a description list.  But the literal
block syntax was used by mistake.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/log.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 16e00e8d296..f20cc25cd7c 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -23,14 +23,14 @@ be used.
 	Print out the ref names of any commits that are shown by the log
 	command. Possible values are:
 +
-----
+--
 `short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
 	`refs/remotes/` are not printed.
 `full`;; the full ref name (including prefix) are printed.
 `auto`;; if the output is going to a terminal,
 	the ref names are shown as if `short` were given, otherwise no ref
 	names are shown.
-----
+--
 +
 This is the same as the `--decorate` option of the `git log`.
 

base-commit: b27be108c89cc57ce068719a82266020436a478b
-- 
2.50.1

