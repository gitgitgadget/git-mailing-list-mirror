Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DF2C86D
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215682; cv=none; b=gsGJF0j09T2TTz3I5zGcVHWs7m4hijbM6qx5gSwS909Z+mBjqOVxCCq3+SQ/gdmtUvxqHLWYgKcjBjjmPlIUhoUYgHx35dJzrlfxW8WQJgA0rqNS0UlKLOr6t3vHS6HZzgPqxShAIOkG2XOS9AsyclxX0n348YZj45CG9zfDpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215682; c=relaxed/simple;
	bh=2jEecN/s/fudxgqBUwfKrrUL0g0suT9izl2h9uoJ31s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Es+U09Ea8qdftRPHnua7yi+Tr70ivR8i4VXTv9x/4uXQ7O9VF9eEv1tKrSG/S7jBfrv3YlrGgL4m7orZvlGPEosIJiRsxSTGdrwUVHZPGw8T8T9zWuP7gxF6ub9wdVUkFYv61mpECkClD+5tTa6T7u1T1VdybXaXj0fkyA92Og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CselbDHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqeKgNr8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CselbDHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqeKgNr8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BECBA1D001C8;
	Mon,  8 Dec 2025 12:41:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 08 Dec 2025 12:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1765215679; x=1765302079; bh=1R
	spbWMPF97gz65RRQ4aVRzJwq/Xfgb1yq+fHchPScw=; b=CselbDHIT+fq+O7KvA
	snyV7zSJf0sTMgx8L8pbWPGlPNaGK+a2cUvqm9bmZrJFE5MvhcLXjxM8DGRmXpn9
	bE7KstfoglCw4xu36qw5T10/AUuDALsBYZCzwofgok4Vn1DetAuvnUf4Egs6NBvm
	R6iRepk5zvw5Bzgl+e+df+uQ+P7BsyYdLPC5bnjZBYdnNplN/vcfTsJxfUoEMYSI
	oIzzCZYaEdibJTck6KdEtxZm++u/1yPIyin8edfT+uP8/MrY0GMGH4R7kNhh+tBQ
	BH4xvMtI2yk8mSu6zHCWIPbq/G8xj0st/OQ5ah+60NUVXFcQyin1K/IYVsgcm9ix
	KcmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765215679; x=1765302079; bh=1RspbWMPF97gz65RRQ4aVRzJwq/X
	fgb1yq+fHchPScw=; b=UqeKgNr8cHubUcIjltB8a4S1imfjtTrVx6Rwmx45jvGb
	c/1mqZsllRht9qtdFLRDQZ61l6dmepYZX3ybaKLIT6LF/6bSfG747EVnZ89KEuUT
	tNaOwuM2E2SStQgPAhZg9GvwgWRwGUpu6/0O3T5d4toamgCxIoMAhUb0LkBf2tDt
	HKU8YTSaBkuYnXli7OdCfTwJXAXJR4RBnTzDuCC3vjOpCiZica+xEjDJwcybVPPU
	nkh7MIQwlCCjHbnnVe/hH91DJ4fvrljRCUkj7Fft8Q6rzoDAjy0LW3IW5pLkFNgm
	XLu0VFiGj1ZB+nLWXOyAmfK5/x+SgYNaRQWN8KRE3g==
X-ME-Sender: <xms:vw03aU8pGw3flZT_uYuuAKGOk5ONV2z0xaUwBt_-EEnQlMQR2bgKmkE>
    <xme:vw03aSswFWvwP6nvyCIKQ_nzHY0f2QpvFRRNvZ7BnjBQX-_c0T8zIBBqquBngtEar
    NgSRCLmvYp0tZdoYJSSLvxxfHWXkRfrEt_WqPfaBD7C2t-_sRivag>
X-ME-Received: <xmr:vw03aXoaOYfk251Q2jtlXbQo5OSV4SewzVF2ia7Vu5BoRm8Z5aNjQE20pWgMXukx6J81vhE7vI2U5IniQC-3u0srOFeIIrU-KGm4NLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephffvvefuff
    fkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedugedvhfeive
    evheehheehvdetudejueehleeljeegtdelleelfeetvdevjedvfeenucffohhmrghinhep
    rghrtghhihhvvgdrohhrghdprghstghiihguohgtthhorhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:vw03afkqbD2H0jaP_NELpeRo3USpUvAnGdzr58tyNKvNZ2CpD0fKtw>
    <xmx:vw03abx__MpnIY2AGV2y4DiZuUH3LubYVF3Mb2RP0PL9aqZy4lzSsA>
    <xmx:vw03aXk2La8eBk2i_BK66rvmSnM3gZhAqyuRCYZmilVyh8rZJMWPNw>
    <xmx:vw03aUeaUTY-bkzz80pu6qJipGfCJ9Md5-w9SSBbx8l8SmLCJx2jsw>
    <xmx:vw03aQULYvRz3CFpiG5oJnBKx5g8Xw24vr22qb7hBjLvMxwe1Zm7j_xm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 12:41:18 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: send-email: fix broken list continuation
Date: Mon,  8 Dec 2025 18:41:01 +0100
Message-ID: <send-email_list_contin.112@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The list continuation has to be “immediately adjacent to the block
being attached”.[1]

[1]: https://web.archive.org/web/20251208172615/https://docs.asciidoctor.org/asciidoc/latest/lists/continuation/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-send-email.adoc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 263b977353f..688efe2786c 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -321,7 +321,6 @@ for instructions.
 	If disabled with `--no-use-imap-only`, the emails will be sent like usual.
 	Disabled by default, but the `sendemail.useImapOnly` configuration
 	variable can be used to enable it.
-
 +
 This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
 for instructions.

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

