Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11D23315A
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936805; cv=none; b=baKNnycNKrumqyF65vaQVzEsN3BVRuGjhUjsXpObFQt6o2uwHZXIIsgkAGd7127iZ3Y+pTIAID/xAHaMbAzLvGAJt1Uo5OBCSGcV+u9i8qp7hI3nfBfOp/xgNMGnH/G0IGn1ZAoksBWR+U6JX4m0DKf07B3kk4vdLJH5UUm+Xi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936805; c=relaxed/simple;
	bh=uR2yNz0nMQCkvuD3R/B7OauT59Sx7/6tTzny9CR3Xgw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cJMh3FAjM+VWzmqJAeXIb4NHoOkTnBe+rkNw/4Y8UaM1EEaKcW+juFRloIvcLbW59WMOF8QwNPN60pMEmOWCIKjvfuJVoZfB6TjDoUDQsbED+676HvS1/Qhxcew2Nh3wGiN9tqvMdhabPt/Nw/CFsCUT/rEXvWujFa/hIMKHhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZY7j3BB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYsiXKQh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZY7j3BB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYsiXKQh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4579AEC00B1;
	Sat, 23 Aug 2025 04:13:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 23 Aug 2025 04:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755936801;
	 x=1756023201; bh=ZcUmkOrxjLsb9FtOXmkCk25nlddjsZ/r4KS38mSf9zE=; b=
	ZY7j3BB8n146aLVFKc7jiC5GWkpqWLVQ2OjKOL8NpdqGMBBQ7H+XGKnc6oUQzP/m
	woM4tLY6suvifq7jUJTi6uk5CehIE0lRiIMg2Z7XumfOlRsdSfy6JcsTPV6bvLh1
	8ZHrzNUx8NqzjfcesQQoWPwNelsFQ8ZpLyG2x5Y3EJyXGPCiYJph+wARGpxfLFpY
	feY+V0d5k24J4+5T6ycp5+0NZEZVvH2Oni/9EZQEylkhfnP4kGmeZIuxeXqJN7Nl
	rnHdb4yM2Yjyb3rnynjGQzhGwl/Wza/t6iFmMxhQbMfXogi5L6rvMTiRVKp5OW1G
	FQyfY78rn+Wf/1MbTX0dvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755936801; x=
	1756023201; bh=ZcUmkOrxjLsb9FtOXmkCk25nlddjsZ/r4KS38mSf9zE=; b=a
	YsiXKQhb7tjjPgF9mj+x4gsedyp9xpBhm65NYBZsjMt7C4iad8s8VblTz3W5koqM
	gsLsKyJcZHF+bPnztIj5t92bojKylisVbs73b8QXIJr4GhbgLqVz+MW9WmHTNOiK
	DidOo/mKl50D/EgTCTFnS7IlH6wgz0eq+aM/DyB+fqwT3qVuzMYPYPux18qkZ4hD
	BG+vkHD4g3S9SsF2+/Wf3s98lL4EOkrIH4IYpnG4VMQPqPss/g8dRPO19YPaP86A
	hVoMnkYuzwfH2FWfTDJ+0wNmyR361yCF6lwqHqU1r6J371JEgmbrJ5G+A5rOer94
	YL/J2rgccEd2JLdbSH69A==
X-ME-Sender: <xms:H3ipaFEOuc7XCFiXTrUGVUEOWmzD2c-SAHd0R-w00DMMtQ5HlGJo0Nc>
    <xme:H3ipaKX6SQDyy7hZPyRmS0YejjrQDDkKtPEk0icrroYzikiboQ30rJ3Ale__lKQMe
    ANH6FH2rxbqJTgrLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduledpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhs
    mhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehmhhesghhlrghn
    ughiuhhmrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:H3ipaKWjD7XFiIYsUR18CgiB46fY9p_MwFfsKSuNcIq04uQkFSQYSw>
    <xmx:H3ipaNL0cCzy4_AJkPb1HhKhAP-3_vKUSIAxKBe2cM_2hjNx5VMG_A>
    <xmx:H3ipaAFHiEoUeLc43JoUge5pu5oYIHo2saJibaI5mNnrkGPJUxyopw>
    <xmx:H3ipaKxzrDDCSc1bBn3x_TKdLKDDbzkwFrKhKgzH4L3kdUFJg6b-ww>
    <xmx:IXipaMwxNFjimD_KlE4lVKNIiamQHu4koihcptriZbHtrwTFW_YS4DYK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A2131EA0066; Sat, 23 Aug 2025 04:13:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUjxW90XxsEV
Date: Sat, 23 Aug 2025 10:12:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Taylor Blau" <me@ttaylorr.com>, "Christian Brabandt" <cb@256bit.org>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 "Patrick Steinhardt" <ps@pks.im>, "Sam James" <sam@gentoo.org>,
 "Collin Funk" <collin.funk1@gmail.com>, "Mike Hommey" <mh@glandium.org>,
 "Pierre-Emmanuel Patry" <pierre-emmanuel.patry@embecosm.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>
Message-Id: <ed31658a-9241-4d75-a086-633448b711a4@app.fastmail.com>
In-Reply-To: 
 <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable between
 C and Rust
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 23, 2025, at 05:55, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
> wrapper functions) in Rust is painful because:

nit: s/git's/Git's/

> [snip]
> diff --git a/rust/interop/src/ivec.rs b/rust/interop/src/ivec.rs
> [snip]
> +        // assert_eq!(vec.capacity, vec.slice.len());

Why are there three commented-out assertions? (all capacity/length)

> +        assert_eq!(expected, vec.length);
> +        assert!(vec.capacity >= expected);
> +        for i in 0..vec.length {
> +            assert_eq!(default_value, vec[i]);
> +        }
> [snip]

-- 
Kristoffer Haugsbakk
