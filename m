Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D21A841B
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028715; cv=none; b=rh6iM2qlsXwRWD8Q+Dk1lTjjuPHp07LjFndYtcI8e0mdQtDYIUpwwHLvaQnbphBNiI7rycbNG/9x5InVA29UnLkxVCr+3lAYie300gPQp3WHb8O2WC51tpD56Py2uinA0UAe8JSQDmwVmYQG8UG35cJ8HXA7H+1s64uTnhhj358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028715; c=relaxed/simple;
	bh=rt9oQld5OfzMYH6A0MnFkx76vypwH2In32Yf96XTBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLHsj8PtIgQCeac/BnKcsGj6FvFEXR/2z4FpgNKqE3A3D05QuBT6gWeEy0v9fuyzTFzICY0esYZD0prLcUf6IW6xCt5QPf/h3bIzyRRTFBON4unKNKAycjyZkXkvIDHv1INSRRcGC0VYKr5mSMXWi4owa4D36cpoNEOuPG9Lu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cgevbPj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n5d/0kyn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cgevbPj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n5d/0kyn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 153801380289;
	Fri, 23 May 2025 15:31:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 15:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028713;
	 x=1748115113; bh=hXPTLxTWAjvSulMd55xMHPwYF5PEdwGFqcpyZdCh6hI=; b=
	cgevbPj5HOn3wmzSpJnekWCEeqSxh2mm1inTtUlT+YJuxf6u/uK0YyQiAW4T1OiL
	qYa9mhC4cTvInB3iMUYxSZzcJs4468k/JCuce9fV5QXKtp/kU0EQODVGuKpJOBsU
	BES0Hq/eIBJ+bnoPHyArcSzxdMZxp6YFd8v/aeu4o210dUj7No0cVrcP/VDgSuMV
	cgBj+onoATjDWwR+rZ3Wjl9KVsy2Akr2JKBh+U+CYIasxufD6qWRsWNhwJo9kOZT
	1SYvVJ/y12AlMQ0uhsBM38UNb4bctp+sshGqYjDUNnsZLe4fB0DRYXZKZPdFimlR
	D+WqQJODe23DV5/f2Q6w+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028713; x=
	1748115113; bh=hXPTLxTWAjvSulMd55xMHPwYF5PEdwGFqcpyZdCh6hI=; b=n
	5d/0kynq7q7ia3XCQpZHP4qHipXAMhrhyq6dFIFsA7KAaTZGslb/hR1BfjdXX6MF
	W78rmhoweNN51f8MnN6WAd3REOtXORblngjfJFmyYnjrePHinxglQhTC/yJx8RWQ
	h3fK3b2eTjVvS3+EM7AcGLhQh8upjMelPqZsfn4AEqziKjHZS1dqLqNG4j15aUhl
	UeuhxLrnDOT2ypzElfp2UDtew77KYiWkc4WDOoxGcjRUbeq08KcnXiDfkqvsMKGt
	1Y6UWD6AniaTVDpxX/fNBrHQ9VbyVcGKHRNGd+eK9Z/IA1zGRX2uSIm5e/4rkuwL
	KvlS1wdMUIAJTX2bTnwNQ==
X-ME-Sender: <xms:KM0waLJK-Y_WgnyZIW-0hWIwpImTlDp2UhpceylhRDmbtcez2et9Dko>
    <xme:KM0waPLVTsZeyvJVivqEWS9T1R3aG0u4RK9Tv25nfmw01E4uC-4JMBuSXGJna1nQf
    OV0mQsZ0-a96oudsw>
X-ME-Received: <xmr:KM0waDvcQFIxp68Eh5ypxldQ6tx7u5RyrlVXjpx7YcjKo3nWlXrAYAR5v3KZT-Z8mni9wm3It5oLFg2uec4bS8fZjqb1AxqElto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgueeiueet
    keelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KM0waEYzwsDdp-96wjr4m5dZ_dagUpZHbr5xp8PAW7yFRPkttHzgcA>
    <xmx:KM0waCZ9jMG04vAFM4hCGPN0tYDGGrM_MgieKGjzZQ2l54_vb6oSNg>
    <xmx:KM0waIAJMHUnNWfBjZ1apC_qNO6K6XdGPvWJddlJi1G8-ahfgpxC3Q>
    <xmx:KM0waAadmkKM1ZsrZihGcvmeZJAUFWJMmgDU9UU3sGD0yeWT5z-AIg>
    <xmx:Kc0waAWo8v8-GgczFtRgEWc--sCLc8U50XfAw6N-BBjFS9LqkMw341ft>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:31:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 1/9] doc: stripspace: mention where the default comes from
Date: Fri, 23 May 2025 21:29:47 +0200
Message-ID: <bf3ea7f23c08b5c477fedd42e2a0e518607c8ec6.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Also quote `#` in line with the modern formatting convention.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • More terse mention of the default as well as the configuration
      variable.  Don’t link to git-config(1), there’s no real need.
    
      Link: https://lore.kernel.org/git/xmqqjz6bhzkm.fsf@gitster.g/
    v1:
    • “modern formatting convention”
    
      It looks like characters are quoted with backticks in the commits I’ve
      seen by Jean-Noël Avila lately.

 Documentation/git-stripspace.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-stripspace.adoc
index a293327581a..37287f211f0 100644
--- a/Documentation/git-stripspace.adoc
+++ b/Documentation/git-stripspace.adoc
@@ -37,7 +37,8 @@ OPTIONS
 -------
 -s::
 --strip-comments::
-	Skip and remove all lines starting with a comment character (default '#').
+	Skip and remove all lines starting with a comment character
+	(`core.commentChar`, default `#`).
 
 -c::
 --comment-lines::
-- 
2.49.0.780.g892193c3f50

