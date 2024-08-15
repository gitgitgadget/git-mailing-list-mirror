Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01997DA7B
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720876; cv=none; b=E8R7GWeUXUAFcEdvaoZzwSDzL0r6mnF5+sfCxuzvP53SPhQyO+MUWA9Tuwily3WYgIzwykVZH0Em1R4X+Vknebp/OrD3StnaQBHSOv2LALAWKJTZVYO0hsdSbVXDBW4GGxbHCXGvlhouvFyE5bs1bbcbglrUTMJXVLy81hAC008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720876; c=relaxed/simple;
	bh=QUfVicw0PIhBaOd4v4o0G0egL9SKzKHY7qJuj337zsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7EWEG4mHsy+mD4BzMLtCsBnZlu9jzYRWfkYbtijqTLB8798hfWMfBVjvI5NPNC2zvSA2jP6hSvWizesMSf7M6Ux2B0ENhWkUDbpa3pNRvJa1wu+Fnjkjnt0edQpNT5QijO5/4w8IpqJlwmCJU0g89BXO6mK8+0NCsBu7L+4I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ao6/0QmK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNCAs7FH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ao6/0QmK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNCAs7FH"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 047FD138FC74;
	Thu, 15 Aug 2024 05:47:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715270; x=1723801670; bh=qR+S9S13TB
	//xUp6XJigqCj5mklobo+Hv6D0rts6nOg=; b=Ao6/0QmKHiHer0cLQeX6SGVDOY
	M1yjC5sVxLtvFM0HUVL49lSIMK7cD0w0GUXbbhE4WYmQQTN2FsKd+ygANoyxEBb+
	n/cE3lBEvJ4T3ueAV5Y1zpKfuE3LWciRfhroStDgcpdUtXF4sadbQokYrhh95MIN
	EFo4rfLIptum6c8neS7n6dpSBYwNlV84GFhGy4Pu9cFJZ97dHnEp6mDjkTk1rPjs
	hRPmI9ZWJqeYKFKM71u/EDkEYrxMwk7kuB++AAf1qaWX2LLHff3ee1XqYXB/+HQV
	e3nCfByos+pAkX6Q+WuE65g/4qUbkqEsK/VBEqU3DG0YfJUCJhWxrRPBpRFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715270; x=1723801670; bh=qR+S9S13TB//xUp6XJigqCj5mklo
	bo+Hv6D0rts6nOg=; b=ZNCAs7FHbcVfJ/4wp/H3E9MIJlEd7oPrmTOvCyJ90VrC
	9GTwE1EJB8+JbMGhUmWlWpPIshocrapI+6gSOpRxenFsy0W2lgZaGR+kNBRBaLtA
	B0cUX7LGZ9JkOfMx+Aaqz2+ZvSUnU1Xma8vNZNTqGXFANV49XJjZjDvsiGpXKJl1
	ee+QMXwOrJRDO1pSPoV8oBkSQSZ1ww2ZPoZsaQQ8WThUf+ZYDDh8DWpXFB2S5Iir
	vZbBAYyUp5zwmvcjXfVcdZYAwFJ5+a+rU3ZD7KrfGqBiVwG0jnmD1/UEmB1AOtlY
	9KSyH4TgRC3gjPSJ4RYbZOome+Mcfa9dV4Koe6BBvQ==
X-ME-Sender: <xms:xc69Zv-gr-MnUbEJeBrGoTay5wFdSL8sQexvjOJfU5dF4Pn7xQmZJQ>
    <xme:xc69ZrvCdpHou5hzrB1q2TgdWKk7GffeJGLqsKcNXVlibIC60XY2SxGvjn39rhyY8
    644pEXoCwl3A4PP9w>
X-ME-Received: <xmr:xc69ZtBDSUjwDwXR-LLj77A96GGOxPm2v2kCZqmUTwxzxpbScAhz-T9CkcI-MNwLLvAhXV8ajkEXkONyQw0EL7fAHx4duolQHP7jvesK3WPH5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnse
    gvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvg
    drtghomh
X-ME-Proxy: <xmx:xc69ZrcrwsI4n-CDHYcbvTu51YVzoeFMEXEGqs7-U5fzrh990ALEnw>
    <xmx:xc69ZkPL6podmUcHC2j6qNwggAIazECdmUQipXRFfWUSsJyG0SWhDA>
    <xmx:xc69ZtlZQeXiK7KNbX_OxqJ_8tTV3yEeYev8kxSjUzLW6H1aOdoWoQ>
    <xmx:xc69ZuvINcgN_77uUI3JftThbByDOQ1R2meanBr9s_ZXBNRCcFHMhQ>
    <xmx:xc69ZljAEN-APljSiTD_iWVRzbjuPMwxx6K581VNwKlVEhICPeTvVTdv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22102867 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:28 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 4/7] t/clar: fix compatibility with NonStop
Message-ID: <75e097dfa4a59715cd26f0e0e97213f20f416d00.1723712012.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723712012.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712012.git.ps@pks.im>

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 7c177f3525..e25057b7c4 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) == NULL)
 		return -1;
 
+	if (mkdir(_clar_path, 0700) != 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-- 
2.46.0.46.g406f326d27.dirty

