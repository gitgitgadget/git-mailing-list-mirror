Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F563275852
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782237; cv=none; b=UCzJ830eg7KvZH3bPAi1iZUbCiaVQ9MyRBInAeQgIF13KY+ya3IevoruvZ/AEZaqvJY/7V3qzE52udf3joMbGDW3GbZRwnToC2raZ/3vwiXa+gsJvZfv9HQfKFnGpMAjvIfZ4TYtxPmk8FQAbieYWKcRKdpS6k7AbWjAnvFRkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782237; c=relaxed/simple;
	bh=Qs2nI9O08Bja4b0nNYyIh2Yo/bcxgQl2SNexj2sZzFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNx0Hwf9K0IEAezqHBtc6jhUo4ZYS1Y+fdusCg+CKtbxWkIeBIOy5Rm+MsnsejfDi0bhggUSgs1YlxLq2ggaoEXrgn2iAsazGsoD18eWeBxdy7dzJ5yru+p8UGqz/ROoMZpSU5MchHgp8tZYg1LFYzCnxZ1xqS5Q/eyIM46GoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ji5CKO8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMBYbMAP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ji5CKO8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMBYbMAP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C05011400B6;
	Fri,  9 May 2025 05:17:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 May 2025 05:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782234;
	 x=1746868634; bh=h9UGZ8hMRW3VG8XNacB2pKOBbc7Ri0kMDoC34rpCgfM=; b=
	ji5CKO8TQOjnopnN7BzV3G2a9G2SabPYHIYI3iZmzJ+MsuBMU3132wrspPFNAYDj
	nq1NdcP69yoMV5oqBqFKkU4+1HEdMfLU65g1mLCSUGvlFRAC3EJZRJYEH4mg4mD1
	J3UVZvsIOLSUU5uqCS13GxPt79WiEvO21Kj7ebBJxoBrTostlELXHTpbCDKyC4Wy
	+cvFARekrIZ9J2vuFHHdEtOfyKaDwzp0seF2uzIW6HjFC7lWO27GQ/EhrngXS+nz
	chVrO2jEYfpBt8Lldys1vXMnVRCeR/MfbKosHH7dxphyn2SUxsg2ux+Lri0u+l+E
	q28l6uR/b5Kw2Wu60dBiyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782234; x=
	1746868634; bh=h9UGZ8hMRW3VG8XNacB2pKOBbc7Ri0kMDoC34rpCgfM=; b=u
	MBYbMAP5Fs9kjU5Ly3qEhJJ6dS3oeo9KgHiBie9/ZpI0jpGQSo73iVHDw/Q2EySy
	eHJ6ZnRHWrWWRIkkABlWiIrKVpAD6JL/JuV800IILt8EA08wSc7aYr9shbzb0HR2
	BWsAed5R3fC56R2IoB/i8zeEk/Tmozh/JgYVgWTVllh74oR4chpOF3x3wk6uRnu8
	KpGTGQ4S6h9gt5efl9wQT1/fD/MzeqWjtmIBwNqhLJKpcHvn/JvGG/nrVqXrVxMB
	9fWPI0bBTJ6hzHg7PV9Rc6gJugaYqyA1VR28LeRgz7ftfjJ4Wpu+4TzKoijleKa9
	w2ryzG48lug17bts7RfTQ==
X-ME-Sender: <xms:GsgdaDxZP5AzkbBKnMgq-sIl8rqwOp0t9LyNHkSYTq2SD6vPMLTbsg>
    <xme:GsgdaLQCa-jrdIfWZyn-FV3aSuo5IgPHjg7heYjki1QsS6nB1LSg8qvny_Q4SD1oq
    fK-UMkHo4lVx5mYfA>
X-ME-Received: <xmr:GsgdaNU2Tqczy2Va9kk7lXWEGkY4fyi2mqgz5xrunJyAk-B44VJ5NzV1LfHY3SzxKSwgpKjK6LrNSqJgIS9VjR04C7CnzjLto2FOULtGlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfelgeehheff
    lefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:GsgdaNgi0AgcIAXH8061mrszCkqYa7xORMbOJzwmETd--n6x_xZeYg>
    <xmx:GsgdaFCqUGv1ftqWGel95NlqOOsHFKmmpShlA9on1yjKwIsS-m3_uA>
    <xmx:GsgdaGIAAw3svR5XbdbhhHtUNOUwebFgIyg0kgvohWrpEULgeNSBgA>
    <xmx:GsgdaEDHlAUNyt2utTA0Vgbxe075_UIxFO5yJ841WR9stzwu3GD1Og>
    <xmx:GsgdaIZf9qM9qZlplUWCM3KiPw4NeJ3vkkzVogaF7b-wMOdaw7Zzad5p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76906802 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:03 +0200
Subject: [PATCH v2 03/11] contrib: remove remote-helper stubs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-3-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

The "remote-helpers" directory contains two remote helper scripts for
Mercurial and Bazaar. These scripts have since been converted into stubs
in b2c851a8e67 (Revert "Merge branch 'jc/graduate-remote-hg-bzr' (early
part)", 2014-05-20) as the helpers have been moved into their own
upstream projects [1][2].

Given that these stubs have been created more than a decade ago it is
very unlikely that anybody still tries to use them. Remove them.

[1]: https://github.com/felipec/git-remote-bzr
[1]: https://github.com/felipec/git-remote-hg

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/remote-helpers/README         | 15 ---------------
 contrib/remote-helpers/git-remote-bzr | 11 -----------
 contrib/remote-helpers/git-remote-hg  | 11 -----------
 3 files changed, 37 deletions(-)

diff --git a/contrib/remote-helpers/README b/contrib/remote-helpers/README
deleted file mode 100644
index ac72332517a..00000000000
--- a/contrib/remote-helpers/README
+++ /dev/null
@@ -1,15 +0,0 @@
-The remote-helper bridges to access data stored in Mercurial and
-Bazaar are maintained outside the git.git tree in the repositories
-of their primary author:
-
-    https://github.com/felipec/git-remote-hg (for Mercurial)
-    https://github.com/felipec/git-remote-bzr (for Bazaar)
-
-You can pick a directory on your $PATH and download them from these
-repositories, e.g.:
-
-  $ wget -O $HOME/bin/git-remote-hg \
-    https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-  $ wget -O $HOME/bin/git-remote-bzr \
-    https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-  $ chmod +x $HOME/bin/git-remote-hg $HOME/bin/git-remote-bzr
diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
deleted file mode 100755
index 1c3d87f8619..00000000000
--- a/contrib/remote-helpers/git-remote-bzr
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-bzr is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-bzr
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
-WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
-EOT
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
deleted file mode 100755
index 8e9188364c6..00000000000
--- a/contrib/remote-helpers/git-remote-hg
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-hg is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-hg
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-hg \
-WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-WARNING:   $ chmod +x $HOME/bin/git-remote-hg
-EOT

-- 
2.49.0.1077.gc0e912fd4c.dirty

