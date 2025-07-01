Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7C286D60
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401239; cv=none; b=dfUyxQcfXnLlr7NQycI3LIcpqa9JCzZm5dq9Hmis4YQTQ8iCcJrWU3Y7061Ou5NoxAOuQeDIRTTdOR3hWlltfXsiU2ru44Yn4k3KK9aqiKT1Xbds6mH9uf2cD1w8SqU/oySNy16/jlxNGwxgkfqTUqbPX530YvoeDwMroLiwW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401239; c=relaxed/simple;
	bh=yU8JqTWLUwVx3/2MkFLh8mWCp1Bodr35A38BM5dQRic=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X68V9fYwbbkCrce0+mHvurADCsyi3cfGt+nnbYJTdkC16m6bhUNig2DVTk+eP4QrNN+J8bVV48oz3kjro3fmdhfo8+X3EmVaRmQvQQ11uX7x534ojGsSdXQ1CY5KDd/90MEbK/mDOJA3/Ai2kZld8FVpHo61kaFQIvegVg5xPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZORKikVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1NyiX2f; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZORKikVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1NyiX2f"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 10A411D000E9;
	Tue,  1 Jul 2025 16:20:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 16:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751401235;
	 x=1751487635; bh=HjLOfCSMPRUpPUxxpXVfwKCMRdZZeaGAYbDY1HX91zM=; b=
	ZORKikVY/aJwuTB6vn2JtXwpTrU6VES2egycfubKdZfNOaOhQhT+YIyGuTUC1TKI
	lpSajZXwbdSnNjXbfZBcTC7LpRP3JO3eXgm6oxi3qGDFtGb1iy1N6ZPXTrDCEY2m
	CQeDnL0G5/Cg26NONG9VrwTfOa8yT7kfSffl/Lj7ImAdMZkF0onoTCMo/IGmB7q6
	wn28T2oshRRiazWglHphbaT7iShsTaj+wYimzTQHlnxQIMrOo9OVnN0NQi0bqPvT
	NIkTobmWfgxCwAnbPDPdtZQSzx/XR8cfI4yObq1sv/vxuzt8dUm6FJQ5FqJchCKY
	Gb5K02gB8S2yHiDM/wklrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751401235; x=
	1751487635; bh=HjLOfCSMPRUpPUxxpXVfwKCMRdZZeaGAYbDY1HX91zM=; b=N
	1NyiX2fWKTCPezGsijI4/9XAoWBLE43gVfFTqUjr3kQgzIfYODab91OiXWVDR9xg
	jJKa36qNdH8LMkGy/ilC9vUNajcGBZ4LbdQ0u3fNUBHL6NSPd0DMAPRG6izC1w9s
	0Bw/QdyRuOquKmxDxsZvyjIqfFyfAV7cHkYDtWUE1gEPD/Qn+ApGGP1rplddfHPo
	ug5UfN0MMPtsHAinJRPW1cdpcm+KU7jx78i7YoPKpCxshKJvKzuN/1UXsPjHNBEi
	UmxlSWGIrMm3jjcrH4y+yIBvj9X+haHVRC4azDAJNRat609DtnyWwDTwqQffP+e1
	ZfiSQTmR2yNRDGF0mtKyw==
X-ME-Sender: <xms:E0NkaA7JhEMZ-V2ZfNxTKlECFUw-lUa3jajoHKlQWl1mMvgyuDMVAzc>
    <xme:E0NkaB5LCtE__cFZBJ3vH4zblZmoCeYXwoQLf0mmt7MFlJ4tF-Akj5uvLJZhj5K-a
    PTPVDenu2cTv7n91w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E0NkaPdH53u090dF6pESeK1339C4oDvpirNF8lSCZZjDcFVi1sR2eA>
    <xmx:E0NkaFL6uFoVxhHazi8m3_xfdQDn_zeWpiav-Wle8k3Guami0rBm9g>
    <xmx:E0NkaEIFhO2rRf68Ipk_7HuXwTed_kYGwLtLsWkkHahku9HI9w3qyQ>
    <xmx:E0NkaGwlrlMqwCMLmInVCwjc5Xw1t6W1PFQ86zmAo547An1aoj4Y2g>
    <xmx:E0NkaLfPH7voFoRqIvcmrHyCEWBptP3ljfHWSv7lPjXWzs4WJzJW3AdF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09F171EA0066; Tue,  1 Jul 2025 16:20:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tedbcca4a1252e1d5
Date: Tue, 01 Jul 2025 22:20:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
 "Derrick Stolee" <stolee@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <9b4742f6-9468-46a2-b612-5985d936ccff@app.fastmail.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-1-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250630-toon-new-blame-tree-v3-1-3516025dc3bc@iotcl.com>
Subject: Re: [PATCH RFC v3 1/3] last-modified: new subcommand to show when files were
 last modified
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 30, 2025, at 20:49, Toon Claes wrote:
> +	of the current working directory are included in the

in the search/traversal?

> [snip]
> +			 * a final path/sha1 state. Note that this covers some

nit: oid state?

> +			 * potentially controversial areas, including:
> +			 *
> +			 *  1. A rename or copy will be found, as it is the
> +			 *     first time the content has arrived at the given
> +			 *     path.
> +			 *
> +			 *  2. Even a non-content modification like a mode or
> +			 *     type change will trigger it.
> +			 *
> +			 * We take the inclusive approach for now, and find
> +			 * anything which impacts the path. Options to tweak
> +			 * the behavior (e.g., to "--follow" the content across
> +			 * renames) can come later.
> +			 */
> +			mark_path(p->two->path, &p->two->oid, data);
> +			break;
> [snip]
