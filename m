Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976C2356B0
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034698; cv=none; b=MaEmVvi9L9JsUcSu8z3UNOcaRD/BnnKbayKCMv4ya79zjJ0vdR4zd6sigpKtcke/KsXeWHyeUTPfBQHkAjsJKhiVfZzs/gfJ4NmvI27AC4N0Q5havJ/93YPUg4iPPoCby1ZFMPKleaGhm5sszTEvqQCsnJQdgUYQo6hZTTFHCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034698; c=relaxed/simple;
	bh=nAo5S9yMxhec22wyFhvpKvaSQlLbSp6XKgAUYgPH/Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfZ9n5Ztp6QsDn3mjOOFbws+GMFxxJ+rpPwTIGbG1hpJHpZj6O3HT4DkyrQmySb596IqNF89Cj6sxvBKq0nrGoxII4A5GnrpTaCLIqlKvKD8XBL4ITbOpmrA2XoHF11eDSe+XDN5fgOyCH4eL+IAx0cR57wopw51kG5A6utRKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SAo8Gqv+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuU0+87V; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SAo8Gqv+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuU0+87V"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C451F1382C58;
	Mon,  3 Mar 2025 15:44:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034695; x=
	1741121095; bh=vBq1/LGHTSxrO7sehpwIy+KDLq104OC+K+/5Iw35+wM=; b=S
	Ao8Gqv+HHxi6nPEEROsCRFngxkKYLogLV4y6hs8DFDbK45zs+nfJKXNrkYCgbOMP
	0uBbeMf+E++XhWnZESmHviG8ZLN3QggDn5MfCu71tyanK3Jj0zCGH9qR7b9fZHxD
	72xXCTmiM1g2LbXsA7blh75zEIYbHiE87W7w5b3zQMu14dSgdgspVz5NEO1zfqnL
	IwrZmaOaQa1XF1c2fCWgPGXDkhiGXL/Er1aBdxWcaLY4N6FhYn9Ff6pgTYRjcAyz
	zKKTjIQPyad5Deif3SBamWc9orG0DC2JQzDmlR5S9CmQ/QOGT3WR6qOI60guedPL
	1XLyv0ZslOcpoa5OXx68g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034695; x=1741121095; bh=v
	Bq1/LGHTSxrO7sehpwIy+KDLq104OC+K+/5Iw35+wM=; b=QuU0+87VsgBd6qUah
	8aOVOmkMGBylxl79utdeuswN4U5nz6qqA6XvLiomVyqVK8eDzVprsyrP2eCHs2Rb
	kL9G9JPoN0Q0cb4y/MilW9rTNFDJOeHsMaKhF9EVV6ioUCgsK75h3Zp7nkprbsoH
	aoH+b3sQR/1x9CI0x1nNMI27+OIm2y8TJ8SkqFr3rw85TYukOJ/XCZMEJk8h32To
	+qp5dQdgpfMIBj5mxsPu5TXpQubxbfTWwlEeX2jY0hkD0yelJBO3AENiHQnIcavY
	/G1R1fxj7QyTRfFARGB4Fp7D/FnK9UuLK3hAhjkXYkj6v+Uf8I2AvhUMdNaacWbT
	6wMAA==
X-ME-Sender: <xms:xxTGZyeyx5muzFHbMz6jCjV-WA_zWKv2Hco2g76_vvAP_aktdSyYoQ>
    <xme:xxTGZ8MAADpp8mLzgDzsa9gRlVQtSG78kiJkL0unFQKv0XX4X5WgyM4CF_b_icFdT
    72r6H57ttT4tzATZw>
X-ME-Received: <xmr:xxTGZzjd03f1XOJLGPXufnQY7s0jAGxv_RdK7HRaY3xDfVqY8SiEfFsXnn5v0uDzxdMicoFpSokXtUM_zWU23PW9ndE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:xxTGZ__seCJd4IbAHzjShLLl12S1xkHHN8Qim755PMCqecisr6WgyQ>
    <xmx:xxTGZ-vGwSst_twjjhEdgdFOii1ILXBCAtGJCTHkQ36gPiljoY6dfg>
    <xmx:xxTGZ2Fww2Xw5tloxGdrTzKX7w-P4QQ_wxgMXE1opzQiMxdZQqLZOg>
    <xmx:xxTGZ9OQNxUn163jz5siQL13CyMViXefh4oQCj-Tc-MblqlynDnKFg>
    <xmx:xxTGZyIhq-MWUcdSGiGyGAm9htMxqwNo-g4QdpmpljPdy7AkjF7sS36J>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:55 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 03/34] doc: remove unneeded .gitattributes
Date: Mon,  3 Mar 2025 15:44:01 -0500
Message-ID: <20250303204443.360595-4-tmz@pobox.com>
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

The top-level .gitattributes file contains entries for the Documentation
tree.  Documentation/.gitattributes has not been touched since it was
added in 14f9e128d3 (Define the project whitespace policy, 2008-02-10).

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/.gitattributes | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/.gitattributes

diff --git a/Documentation/.gitattributes b/Documentation/.gitattributes
deleted file mode 100644
index ddb030137d..0000000000
--- a/Documentation/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-*.txt whitespace
-- 
2.49.0.rc0

