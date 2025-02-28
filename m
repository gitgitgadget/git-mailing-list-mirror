Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063AC1F4284
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730406; cv=none; b=DTCNnQDy/JejbcypIGJAdnY7u2b/9hbDV3COlc5B+aevSlfCcNqSWyYl4MQixgKfD/E+AG2WyRcHSHnB1Cj2wVE7GCXcpeluUoug6EVZ6+PZ3BXzpNGyuyv5xAywRW3/fvFPLOZBkeHGqtgj8Jug50iP88RPws7aw2RJIl6uVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730406; c=relaxed/simple;
	bh=7oDE1gNs02LnvOTTm4NNR7/KwVJFHVniINV9zsdZAco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQWxD9gZAYrgSc5lDDbRYyHKh5CgXPegl6z1Qlant98AiXqYe5Cpe16AR6WXt56CRlLz3OvVjcFzXAWICZc7O5+epraheBPuWbO9+2CCjowBDu+1nIX7ksNA9TQi3Cri6st43ZJaE/EQbDQeb+2X4/N1TXuW1T01U32pNlqYZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D9VFoZmr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mn0VN8JS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D9VFoZmr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mn0VN8JS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E760911403CD;
	Fri, 28 Feb 2025 03:13:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 03:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740730402; x=1740816802; bh=lr95CLO7vv
	YrXPrpbBsreXHTD5wGh1uuGOigOuZVVBw=; b=D9VFoZmrBFRavhOHUD/IwHf+kt
	XJRfc8fJMwgFD35bKDHo5Fd854yGJMy++SxqHZozMsOTdufnxsWqa3wgPv5CnxZh
	MVBG/eUpDfUgSmU2r7jdPdmuX0C5zgR6YPyem4nyUIWADAwjUCJjQZ36zJsmKdb2
	/+PuhFMD866fAdP41ZLVGYaGYaFj4TGgE+T/shEyFHPZsEN2nlfUdOltixVnJcLt
	ghawjnOzaO/pFhT2m5xusw7jIOgRCMq8L+3xl/O8A7hZlQzkHDy024GB0IXPhpwb
	OJjP0WyyaA6NebMZG0aRyAaGhWGU/XCgChbyIygbOPUl7LRSgKRqZViRKWOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740730402; x=1740816802; bh=lr95CLO7vvYrXPrpbBsreXHTD5wGh1uuGOi
	gOuZVVBw=; b=mn0VN8JSu8i99LHgKL96Eckrv9TAlaHAFU2uCe6PSrxZysiNURW
	HEgwVws3OHVuYT7pf1Xcd/RD1xESvpsVrGCh6Ar6rvfMW90J0aU2qmmKGkZ+zIEg
	4s0P7mW2hQe+JqvXXmIk6DSrtnl8cNUZX+mEdepCcgO2m84xn9Gozs/ozypK2IGH
	V4yssWOc+4Td3n0sscXrA1pWYXzAjvJy8hpKlL0HkBAnwYk4vW70eJCV7pYlCA1e
	E4ONYhhRqNBQHKIBBproZD5zu6qyadKggutlAzZLCVRthruCJxC3wd4hBOKokD0S
	VnPETLQ+vLlKYANg8JLpLzZ36Ck2cX7Nbaw==
X-ME-Sender: <xms:InDBZ2GATej8ANtQlgTLybtpAJK8lVoJ1kRYJasFgiD8fNeYZSFUhw>
    <xme:InDBZ3XruEmvai4dGMCr9iTh_3AwPKAO8zTRhd0fmbqprgfaUK5CQiFPafn_d7p9K
    6vTP0TJRdZ08562sA>
X-ME-Received: <xmr:InDBZwK3gwTheYWOON8YGRHU8bjAfcYaWUhG9rbhcPTvOGxVKRHrKl-lBlMtWQLMnCuS1nxTy6T6HVScE9D8qna0ZdT7j80YlM4RXMtE0T-aITvj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vght
X-ME-Proxy: <xmx:InDBZwEkPPkBrBSlzi5FOntFbzYPZFWCtZN8fuscc_jk11eusjQwLA>
    <xmx:InDBZ8X-I3KAeuSEsblSW_Tz-7DyQqlevtgFLIR0AXxwhd6du3_nhA>
    <xmx:InDBZzMUuyQgiKqSX20tewllwPDBVkfdRP87QUDBjeRJ2rxlwO1Mcw>
    <xmx:InDBZz39bgO3HRO1c2IUF1a7H14vbt77WtiJpZUGBFkI-iWgkB5l-g>
    <xmx:InDBZzStsGsX8uYydGaU1o0Y6a4upxmvloqNva_5KG2axKmx1c8LI06P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 03:13:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 20683df2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 08:13:20 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:13:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] contrib/subtree: rename .txt to .adoc
Message-ID: <Z8FwG_q7NmRDUqof@pks.im>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-4-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228034713.203461-4-tmz@pobox.com>

On Thu, Feb 27, 2025 at 10:47:06PM -0500, Todd Zullinger wrote:
> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
> extension for AsciiDoc files, 2025-01-20).

Same here, we also need the following change on top:

diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index a752a188df1..9c72b236259 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -32,7 +32,7 @@ if get_option('docs').contains('man')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-subtree.txt',
+    input: 'git-subtree.adoc',
     output: 'git-subtree.xml',
   )
 
@@ -63,7 +63,7 @@ if get_option('docs').contains('html')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-subtree.txt',
+    input: 'git-subtree.adoc',
     output: 'git-subtree.html',
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc',

Patrick
