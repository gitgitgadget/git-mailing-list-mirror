Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640C34AB0D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709463; cv=none; b=b9H6CSV0J2AMHB5oeyRGwcAsDJHyLq5GOkm65vSo6/lVFtLq9SgFKZvYjHgc5dhNm1DHMf3BcYbaFT2DRDsINOr6gK4rVgtqEU2I/pWrNVT/BTPrsjyQRiN8XXKa/7B35cxVj4EtBa/0ELJ3mvj7yCxfNMdBXy4oplQgFJfwF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709463; c=relaxed/simple;
	bh=ZTlG27Wwp9VkajvRyGDYRs04frO1F+GFUoa/hq60c1k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KV8FKrTOObzudm64c0bvPDFY66Nt8N1XGFx/D3oVxQq0tOFfX1hsAnj6Wa9yzetz+Zcr+sQoQZ8sEK1XL3aY4NeJPh4GpGtbbpqJTHywyg7TipgwLgxICsiWbNbh8SkYtMpJBl9j0jNDtV1C1XrsVpLJ9Qs8haG77tkyiLBVaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=BlJMg9yX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h24Df/Ly; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="BlJMg9yX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h24Df/Ly"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 54680EC001C;
	Fri, 17 Oct 2025 09:57:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 09:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760709460;
	 x=1760795860; bh=da5eWkt89xml8y6gmgiEb/GzjUuTVZKo3au6YKjm98E=; b=
	BlJMg9yXbsDeW+h95zFUsixRSWoWinUHaiTdupl8AEwyQMy8oVA6Mg6R6e+En5ot
	AU0DmYgLDkdv03AYRytlt9GFhMkq/L5YWQausGUNfWeUjEO7F3iX/ZM2ISQm0sK5
	B1g+5ARcpbHkXwSCyTLIDdDQEGyF+OiZM7FmdVuSwk3GGMbdzXTvIfWCr4mkEwtm
	pWfj54+uDYTnUOg5UxuJBF50YMjhVO87jwBNsOyjQKpZ2M+i6W4KeYbavZI5JrDh
	p+tolhhc7kdrSL79AGeqd1zZzENBEncnCE5bGk5PsKCU0LpWEwdHTg3onf/Q+ztg
	r/Mn6/FYg+VzlehQTzDvUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760709460; x=
	1760795860; bh=da5eWkt89xml8y6gmgiEb/GzjUuTVZKo3au6YKjm98E=; b=h
	24Df/LyMN9dz+4wetLB+AlNF5LsnKe1iz4reJzFSsS1b3z5LYLZDI8Ls7ayMj0qr
	/haGUMi9sFTJSsFiShB4LDUrth4sDwmPKG5tRYemQONETIsRUQ9U8ue1qZjW87iQ
	fzO3e/nVbX3nMvotxwk4pmSgoKoutaJMzGClqPeoI4qZBVUp3g/LmZqEh/DR1Hjz
	XdjKwObdPxOEHZtz3sHb1QB5mtn87sfdTJ89qwgOJCHbxsC2ShRopJ4MwtDRSwrX
	nA38uIaoFgiUz3Z2CrhJJCMIIPbmLs3cAcOBkflIFAceNLXuyTM9GdqpqPkZ5PLR
	mB6L8Dq+Pq/Nrb+cOat9w==
X-ME-Sender: <xms:VEvyaPg6vEE-8VEuHwhl2UDOdzTUL-mEOOnijejg5sAyRDhzBNyXeg>
    <xme:VEvyaG2_TmIT9mcbfORbPGEVq0ygLmDsi5L4cCmKnuvrye9kLJSjgLwlHzQp-SLOp
    7_HeyrxcXUXWa1zp4BxgoEga28SaCrzNvukNjK28z6unHfhWyREfXtv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VEvyaH-Rzhm9XxCsHb7NVKVY0Dcu571x_9WqT5pBWsTXRMatj70YAQ>
    <xmx:VEvyaNJCAYRhwVcETzDmgtEPiZofJ1wNDZJ3g6laO7BBTJ2OpmpyYw>
    <xmx:VEvyaEltwFr5wjCjFO2mOjqQtNZoUMy12-5Ngkr-o3r6AShjeoJ_Qw>
    <xmx:VEvyaJMxVRt9Rsl9LOm7t5B_uOf7B13RjIT2lKOpUtcCkE2xIUhhCw>
    <xmx:VEvyaNoRWodtHAVWn5yVxuHSXjGwX851_XpGdL8vpstulU_4l8s2Bzus>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04CA0780076; Fri, 17 Oct 2025 09:57:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlDwczv6fChJ
Date: Fri, 17 Oct 2025 09:56:33 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <8bf911ab-c9d9-4a22-acd2-2dcd05517f41@app.fastmail.com>
In-Reply-To: <54bc6875cc5.1760652634.git.code@khaugsbakk.name>
References: <359afc34863.1759430054.git.code@khaugsbakk.name>
 <54bc6875cc5.1760652634.git.code@khaugsbakk.name>
Subject: Re: [PATCH resend] doc: git-checkout: fix placeholder markup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks, apologies for missing this at the time.

On Thu, Oct 16, 2025, at 6:11 PM, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The placeholder markup is underscore (_), not backtick (`) as well.
>
> The inline-verbatim markup (backticks) handle interior formatting. This
> means in this case that it applies HTML `<code>` to the underscores and
> `<em>` to the placeholder.
>
> That is the effect, anyway; we can see from the rest of 042d6f34 (doc:
> git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
> an unintended mix-up.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Since this has landed in `master` now.
>
>  Documentation/git-checkout.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 431185ca0ba..6f281b298ef 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -61,7 +61,7 @@ uncommitted changes.
>  `git checkout -B <branch> [<start-point>]`::
> 
>  	The same as `-b`, except that if the branch already exists it
> -	resets `_<branch>_` to the start point instead of failing.
> +	resets _<branch>_ to the start point instead of failing.
> 
>  `git checkout --detach [<branch>]`::
>  `git checkout [--detach] <commit>`::
> @@ -155,7 +155,7 @@ of it").
> 
>  `-B <new-branch>`::
>  	The same as `-b`, except that if the branch already exists it
> -	resets `_<branch>_` to the start point instead of failing.
> +	resets _<branch>_ to the start point instead of failing.
> 
>  `-t`::
>  `--track[=(direct|inherit)]`::
>
> base-commit: 83a9405e59e9cdfb587b19c50f0c040f346dd4ea
> -- 
> 2.51.1.498.g8f0801f1c10
