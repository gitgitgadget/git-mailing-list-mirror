Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805231D735
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032292; cv=none; b=adjPC1AN8hFTiwQLVeNwEuup2PIgMXjqj5oz5m3kyATX1eqW55qPLoRSyFHvC7E+YtyKPaLFWv8KO0s8ACwNWhSP/wXKdA8P23Sbj57lplxs+q6y1QD06xsUO2LAgKwqodRmEqyUwzML/67afeYjCqej1vlxxYXWFYSmnR9rnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032292; c=relaxed/simple;
	bh=rfW+xzW+u8mUouzkuk3FGClA4G+vF5h4dTj7+3u9V9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MxmYclgJO5kMqAccUOLsDK7bQhBNOyqsuGAZccWCFKntrDVSIa74qmE2CH4KcFz/WG4W1EF6AZd/frFiZP1SCvbU40aFatgCunr7kaMlMQ4RUcbIZViE/Rw9F/kAIA/TmsOHexves7J2mBDLQImUpLVFINulQJ4uAzPM5uDzYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Sc+lFaDX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZHGbGrL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Sc+lFaDX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZHGbGrL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06693140004B;
	Wed, 21 Jan 2026 16:51:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 16:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1769032289; x=1769118689; bh=y+
	MSyeLhICf77FW4Ihs6HszEcpZmckzRSV42G+p0cWQ=; b=Sc+lFaDXXW0rV7kPm6
	NmSlwuuQLm7FqxAb3P9NL+/t9TEn68EK1/fCmrcvSLxsWm3rK8i1EM0Nmm+z4PSb
	DW3APmsyA6TkC27/pDeKe0Z0ysVMxZfLr/tiMzGnauaMtf4oGbacbYUI3rK2Pr5B
	CaI7P1SXEQ/ediib8/fgyx3jMOv1L94AAcybsijb+DjFxYjj5t7drQZXaEF5++Ls
	z4EJspnDAAQxOICe7S/yVpWQieSjy7amSxI81HJk2KuOcWguSunciBOKgqImwM1N
	Kz2/Vh0BF6GJCxBO/r2rZ5TKodSB00lMkw42DFwW8uxp/xpA5myka+TbBQz+QRSF
	chbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1769032289; x=1769118689; bh=y+MSyeLhICf77FW4Ihs6HszEcpZm
	ckzRSV42G+p0cWQ=; b=yZHGbGrLccI3ZkWY1VQ0yFJ1tmgvFnX8xqZECa64zC4r
	B538qZlE7+6pM7LGtSmi/79u0FBW2zczF8bOb4YuF+ww4i2QoB02RgfMWKmpFRoj
	1SUzNrt5Qa8dauaHOLQ0gPgrUcfSDgPWdANtAu9vKL8veb90CLPQq1aW0R8kK1ho
	13pwF5nWgHNBIz6TuJnJDzGUuY+EXW3w0VfNh7L6nGJCsKIt13Jnu8SYk8RG+glg
	WGVCi/oDebLbqgKxA0Z8yx1ENG6te0ELNJ8epv0zxyUiLQRSEexrE/wu/1zF5WEl
	JSVZV9S5qhRk+YEcw5d5woa80eAc7+K4julVh+FBqw==
X-ME-Sender: <xms:X0pxadjav8KVOb1EC8XMVNAx7snVrizaK72XLs7m-BhWX50TfyAtcj4>
    <xme:X0pxaZc1QAsIxD1uU7m2a9JSXytpIosiFGExt4K1R67jWoWz8v4K34KiNhoydbjUf
    h9cd-sendhCI7Ex80YDdpJpjhsPLZQ0NO-5yMgG_q2JK1ArjCDtkg>
X-ME-Received: <xmr:X0pxaaeDLgj8E8GacX4j9C-CLYoQ1nR3_xfMC7KweiYPnt52bXD4b-6wzV5_EqdYrxXkAtfdOwP8iHj6O8mJU_FH4AyrgtA2vv0EXsknNdyWmBfRxqaPjtnEkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:X0pxab-b1F7wayu5IfDYEhgXsW8n4An09wqJsrpV63A3IpPGGq7c1g>
    <xmx:X0pxaell6QQI-SzVEOTN48RFhAD1_9cqe7Oqasgj3rA9r9ba5QcjHg>
    <xmx:X0pxaV87TdRokUMYWU6qzIZDqPR4LpE6GRZKJ9bbyAhXfzf14Mw1rQ>
    <xmx:X0pxaUmroFMjpA-fPMMH7LZaHN23RZMpr1oXlc-tiRXgGjw6WmNKUQ>
    <xmx:YUpxaSXFhqVk6IwuyZhPa3yBJR8QkC-jmyp1AOmSP1o_I9YAdDiPBMjh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:51:26 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr
Subject: [PATCH] =?UTF-8?q?.mailmap:=20fix=20and=20expand=20mappings=20for?= =?UTF-8?q?=20Jean-No=C3=ABl=20Avila?=
Date: Wed, 21 Jan 2026 22:51:09 +0100
Message-ID: <gggadget.24e@msgid.xyz>
X-Mailer: git-send-email 2.53.0.rc0.21.gf037a7d9249
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The latest release candidate notes say that there is a new contributor:

    Jean-Noël Avila via GitGitGadget, ...

But this is a familiar face, just in a G.G. Gadget trench coat.

Also map the rest of the idents in the history.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Tested with:
    
        git shortlog -e
    
        git shortlog -e \
            --group=trailer:helped-by \
            --group=trailer:acked-by \
            --group=trailer:reviewed-by \
            --group=trailer:noticed-by \
            --group=trailer:reported-by

 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3cf26b1add0..799734821b4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -107,6 +107,9 @@ Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila
 Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA
+Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila <jean-noel.avila@scantech.fr>
+Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA <avila.jn@gmail.com>
+Jean-Noël Avila <jn.avila@free.fr> Jean-Noël Avila via GitGitGadget <gitgitgadget@gmail.com>
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>

base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c
-- 
2.52.0

