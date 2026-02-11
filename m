Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D28460
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810513; cv=none; b=DdgTNyaOBAtDldeyE59kvXZPdDfDjuUQbWzELJmyDh0yF2/m23umG8EEjXAmL6X7gtwW2msprVQMM0gE9u5pDIsWtlErl1lTVY0ClJ7kHr8e8S90Cx5KwxzztoSjJVThWirOdx0Gnfg0qp+c0kEliIM1xSpGViK2Ur/eX6cj69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810513; c=relaxed/simple;
	bh=cc2226h/Dk7st+/qUxmHIxwqRJtZ74V27O2j1b1tqnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coLxurcazqyqHUJaKFTfgLLAHynRPI2k5Fxq4ZExqvC0MwbyJWs+iFxAq7IykWitCB6M36L4n5DSZCXu3JOHivyHcTTo6henAs31qaGzYbqo6DD8yKc2Rgx3dgt8mxFTmbxmZHJQDVIZcSoFk9g6GgGI74+QsinFmNfiWZp90vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgjJj2vQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RrSj428R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgjJj2vQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RrSj428R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8056D7A01DF;
	Wed, 11 Feb 2026 06:48:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 06:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770810511; x=1770896911; bh=+9lDuL0bDg
	e4WdJu+fNH/STfn1e1MqCCCQS9NsXnPRE=; b=JgjJj2vQ/DMJEz3jjfIJkO/w4G
	kAMg1tTBdOHc7huEEYcAAFEPYsc6OsEXCeUjueVHptNCJYxUMsosXExoiX/3T66h
	3W8syb1F3K6NH8jWQP0jNbos61UzPqeXRVBE1Z/pHVsg7230bzGK7OztTCd6xA11
	74RyTwpoKZltFLPy5MfD0qkdFufiOXp7/Ph2rv3wxeFi1U/d9ycAcxU7DaFnUs/B
	+gbLn7QNymVqZw1UyLnMoYZ+Dg4H9/TrBxcIdeWQwwgGgxAAD58JQxtBS1arBS6n
	2DPLH5Gcc9VS9XwU+ROF9OIBCc+2E7dtffHhqQDTGtfqrL5CQAuavnB0AKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770810511; x=1770896911; bh=+9lDuL0bDge4WdJu+fNH/STfn1e1MqCCCQS
	9NsXnPRE=; b=RrSj428R6vhIcEVRRDgOrCHhtf6LjyNpWUqMNymvoinzDbYr7ee
	sIbPAEul6Nr8eXgH7rAp12hgZXDQKPbBRcwteP4SM3cE+ht9iK7tjlL3h3td/8+L
	6ShgUsV6SHYCDGCEef4/c4J+S342ygDc1G7o/atH0Ie+97C6IvNFsl8V3JUcyoNL
	pZvH+2rr1++GFXC1svvccCRcAsE0oa2kKb4ncijQ4+seXjuYUZn2vN65ErLx6UTg
	O+v3zQk+mXfKjAO0ypYfFBk7KHnrKBfVAacmod1LfNWeIB4daFr5KdFPR4wffesa
	iW3snV7K2KPMtf4d4Yo6bQ1mpuAt+iWDkCg==
X-ME-Sender: <xms:j2yMaWfCXpecrBeXCjXOARbNcy9QeVrb2xbbqHyLg8jNeHVHdvTDYw>
    <xme:j2yMafRKXq1ejJ5kdYZKFC1CtDhynh1yaTIm8FXEyjMSgKZUbdfLSZiYpQW8YQTyo
    A9Mprqcro7n0lj26ms-71V8o0GuZ8F21FRy25woHDVk60kC5Xl1hmI>
X-ME-Received: <xmr:j2yMadvf-cxnIFw4jAS7HrchENR0P28khCZW8xHbtCnLSF9Eyn7IGA_-t2CRQL92nh063soOHD9yceLGqIgoaf1vgzRqxrci1u4CP6marUyr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvihhlrgdrjhhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgt
    ohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrgh
X-ME-Proxy: <xmx:j2yMaQcwUILIe8WY5LEfy_hOuAcfahmBfsOLkN-LwTOcJAyleIOA3w>
    <xmx:j2yMaXZL_Qdx4-8RIG4oKD7_LhdhoPdLiWnkoG0rrz8vgFhF4zMOVw>
    <xmx:j2yMaSYjJb7OiKjugS-PHNR7x386ZPmgnD-QktwuKdJdZa1h8vRqRQ>
    <xmx:j2yMacJrLzHiRGfxMVWetVmBzZXjGdCFTJQLEqwl0I5PFuG_bas5Pg>
    <xmx:j2yMaQ9ymr4EfWSUK_lfArm1iHRzhbzRJISwW3_JLTc4RfVqZVUbcVDV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:48:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e9b851f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 11:48:29 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:48:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] doc: fetch: document `--filter=<filter-spec>`
 option
Message-ID: <aYxsippsLqPnfIQ1@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260204110818.2919273-6-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204110818.2919273-6-christian.couder@gmail.com>

On Wed, Feb 04, 2026 at 12:08:10PM +0100, Christian Couder wrote:
> The `--filter=<filter-spec>` option is documented in most commands that
> support it except `git fetch`.
> 
> Let's fix that and document that option using the same words already
> used to document it for `git clone`.
> 
> Those words could probably be improved, but they are not wrong, so
> let's just use them for now and leave improving them for future work.

Heh, this reads quite funny to me. I prefer the commit message from v1
myself, but don't care strongly about this.

Patrick
