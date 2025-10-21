Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E62313E00
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035646; cv=none; b=LZkpjLBDpimIR/UaI3s87gVgLYI7Kwp5iUTQMLLpTJY5IW+dj1gWdnVuXcmvhWHaSc4WP93/I0zha847MNbBRs4cCYq5Hv2QxtnU8sB2/T1qDT0ClHQDzhmBZ3ioAH3NLmJB4TbUbg85XPUFVBxZHeHPOimwE78p2k9YWcWvPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035646; c=relaxed/simple;
	bh=C2ToKxE65+OlwYnGp38ufPfS9eaZlhhJ522CZkf2VRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaAjs6nC0HvpsPU1fl0eP7JCMvELhBMoaSdJx9YCmx/q0fnsbwInjrs5nF+F5k69XDNM8ly/XDPtqs7fClfzPvxt+FZemAaBfWnzx2fXpRZNqN9ZNJAaIv4P30uIiKuc/OYgjgIdfZzwvfmkZRDyD+7/uPjbp8blU6hkdyX/ev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPI5mxY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWsevCLg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPI5mxY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWsevCLg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D4CF14000B9;
	Tue, 21 Oct 2025 04:34:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761035644; x=1761122044; bh=aOg2R5bFzi
	MhE0o+MHs/0gb3sxXwV32BmYglktV/d14=; b=OPI5mxY2XRfmI9VIdX5MJtcmiF
	r4YTXDrTwyVapxmGciAqBnKmJ72plJx672D6cSPov9hGve2SJj8ad8Gs+RidnMvd
	UX9EUSe9cbqpIeyTz4BibHrDeE7K0n72C9lVPDHEs1Vy/+9lqNnYGXzOw9P1Zi3U
	AEB8mfPKl6JeIyiDbo3Xj3wEn/m8WBQ03MSf4X+Ny0K8bpNjjMZ6SXxhJJZfU7RN
	y9ezjfOkIRTP+g7YbfW+OJ3t6TVUXxF8UIGhx+3jlSOE+esobU74ny+gYWSKVCCf
	Dyg8xuHMx9eAjB6JkAEO7HTXdAuu6R03on5W3c2Lim4D5i7mmINyTS7pWqjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761035644; x=1761122044; bh=aOg2R5bFziMhE0o+MHs/0gb3sxXwV32BmYg
	lktV/d14=; b=tWsevCLgP3rupem5g+8h0dRmRCY/X81HOyjNw5+ukMySqCzoWYq
	arT+/bj6yXafSqRWg7cHOn6lu9nrxDwqEX3m6ytbhLo582+VCnv+7W3MileKu1yw
	zPTrCioNZBHNWpBqvOxidtFk2lOqii0jlEYmJPogOjVNlJ5GYZ62ysVFjUyFC9rr
	cCNgb9xlgdcWoRhzcLe5ATMu/iYxlPst5OWVirhBlAPYripflaQaL70v16wI9bvy
	ORWWkCmxUf80G9JuNr3/5Kab34mTNz2oJOkxprJ2eSUz4Jqd9U5T78QsJNY5rVwv
	XThWYK7zRMpmQdhf1UPijDrIS4uaBBxE/GQ==
X-ME-Sender: <xms:e0X3aN4NU54Z4ISHgQwiHQlRQ2x7E4m8C0WpVvzpEL3RcGUzuHTsHg>
    <xme:e0X3aCVTTAYXk3iIo_GVswOKZS5qXSBeMslNmGMBkvkRjlhKEN9t40eW0Y7b7dl7n
    B5wINr92JiAr_hims7lKNhl4E_jn3mZKsmYVBmzFdGfrYkToF7yFSE>
X-ME-Received: <xmr:e0X3aB2tzDEjXpn-EqtQnc95i1k0_UxKFRbjmwJbDlazyuMkB18IWbgQQ4J8F-TjBSAq6gotoB6Bn4-pXVF6AG-p5VFRqxl0dpm1FeAizkPxFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:e0X3aP1GNL2D7iVMjxI8TVNAeyJ0xtuIF2Pnnynad8oTsfdMuGD3yA>
    <xmx:e0X3aE8Dp8h8n4sdjd9EQ2FhuV5th3ootvImIz82c_2U6DVxfMPqnA>
    <xmx:e0X3aM3jehUxmqyYIh6GvYytEqBXoL0Aj0inHEdjE0zSKdunFYaisQ>
    <xmx:e0X3aB82zMJr0DDscWJsV4x9fSwlzPhvktp5fO3UKbRv-xWim9ndTA>
    <xmx:fEX3aLwVXvpKcExjctOb21_0tXLiXOOseinbrjGtJjLm64nIKT8I7Xtp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:34:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51c9a70e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:34:03 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:34:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 8/9] xdiff: change rindex from long to size_t in xdfile_t
Message-ID: <aPdFeHZKEsRw1cTX@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <6dca5e6222e1d02092d4ba8296b757b123b85afa.1760563101.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dca5e6222e1d02092d4ba8296b757b123b85afa.1760563101.git.gitgitgadget@gmail.com>

On Wed, Oct 15, 2025 at 09:18:20PM +0000, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> rindex describes a index offset which means it's an index into memory
> which should use size_t. dstart and dend will be deleted in a future
> patch series. Move them to the end to help avoid refactor conflicts.

In a patch like this I would appreciate some explanation why we can
change the type without adapting any of its users. So basically explain
why this refactoring is safe to do and won't cause any issues.

Patrick
