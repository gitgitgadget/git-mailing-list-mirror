Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7591F1538
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304242; cv=none; b=b4WvY+Yt5Q9XbS5lIXBNo20UdEVpidH5VdFNZe0XFIU6nYQqghcX4B8q1tiE0bRnzhVXgCaEvKdMfKAqef5+kJcnp9LQZKG73EsMrGB5cXITi+iTCGvoUfTQHLbLEmIwMPDmEfIdQse+/5qlV+ZAWgOZRcYaGciaKcMM/+SI+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304242; c=relaxed/simple;
	bh=qLLkJStI8RqAzVWMN6p60zHkvaFqrmld3p5ofduXBaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTT3ki93Br7r4uOTgxwtoGdPf5iwsUI6z9kDyg3IcplgHj40VBnJ4nOhmLt1wcDNeY2PEPjHKUkPc+StVweevSnZjecdHmNzOKdXauZFbAGXQU01An4pkFCs3Xsj1pSIvEkRc9Vpud8vaeCAQgprdVAWdg1m1WmNBo+OgbVcRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dqh51xfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEqc7Ova; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dqh51xfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEqc7Ova"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DBF8A1D001B3;
	Wed,  1 Oct 2025 03:37:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 03:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759304238; x=1759390638; bh=tXqrieXYub
	qd8zwNJTEo8VcVr+jmHN2WRlQuN2bzAk4=; b=Dqh51xfuarWtHTV+zI/zk1DzcY
	UYJehEyAtzdLLhajA+lSnsEKsmml5nGxl6PgqNw9BQQU2uuLwVN9wTm9ebpMBqQb
	pyA5ouW8om+uYoW9DdtegsH8FoNQaGH28EANF2rDprUkB9qDJv6cswmFlP2g9l68
	p6deNNNq//y1fhqGFXykxaq7CUcXc3680S56EmVkzAAFwXbLVkxUBn0rtOYEF4/d
	n3FiRDnHBTYO0ZkYBnvBZGcHknT3+42j6+1vJyrhwH/Nso26NL2eMb1X+EbSB3Kz
	1MOn/+hdk8YFp4bSM9jrm00QXGF5ylEiUgLTIUpFXYpzSYniXRqGZCbVxt1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759304238; x=1759390638; bh=tXqrieXYubqd8zwNJTEo8VcVr+jmHN2WRlQ
	uN2bzAk4=; b=LEqc7Ovartb6+XCr+VZ0pZDVSH2uj6Hc3nTNbu9N2JCnq/7Pw/R
	RJd/HrbV1hL4VAQRbRKtR8tob1bA6zMaJfwQ67QQuwru5r+mqQk8rVmJfvKVrouo
	Dh+G559tYZnU6jz8SmQEE1zPbsUKxiuuclnWHu4mB8X7kB+esryVDvOAsoclcEtt
	jdPX389tMOh3K7hB0THAR4NU/gd5J4xmOsg+Wgz4nihiZm/e6hfGSSaWlVNmfxzD
	i4nxDcl5GIuFK61YNO35xL9cOU7CEJhHFTBACoiVVpWoFFPT+/jU8aqpHu1zJSd8
	2QVn53UvPpf5uU8i0KR0AWDIybF1s22LE4A==
X-ME-Sender: <xms:LtrcaNgbeErnAzbROZVluzAxlKMO5TtxWVGKocaBwiVkPOOtLMUfaA>
    <xme:LtrcaJfiGUskfsMooLLaMSrmt7myA0xWc6BHXP2uCUSC4zE5LEz1RZ09h44rkcknl
    gNwSrC-nA5Igr58SmK40IeTsyi8ffwMWzYH_VzYqZmhLiaoIe2pSAc>
X-ME-Received: <xmr:LtrcaKcsS0X1kmRPpf7Qm254AvoZSnzP-_SUTOEzSF7tboiDUam69A7cmmfn3YGP-e8SAMkjtOCcOiRqCzhIY1RgO9ykiNlOjxkerrKgIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehlohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LtrcaL-Q3u_YPPbcL50FJl7k_X5bGXEDvWIZn0AB8m2U7U-AcsHrrw>
    <xmx:LtrcaOm2RJQcH24SLKRgsyV7oGogMH9_CK6ojyzPjhg1UHVJYibEiQ>
    <xmx:LtrcaF-49JT4Gs3jT9rj2CIfaGT-HxF8SoBToedufPrQy5pPrMmqiQ>
    <xmx:LtrcaEnkPhGpgsrM2M14c3K1hHMQeGVMz-g1rDo6PpDk8zhCOpdg6w>
    <xmx:LtrcaBqRnMqdqasqomsP9Mwen29io7DUJl6LciV6EywxUsccyWhNaowg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 03:37:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6632c1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 07:37:15 +0000 (UTC)
Date: Wed, 1 Oct 2025 09:37:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Lohmann <git@lohmann.sh>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/reflog: respect user config in "write"
 subcommand
Message-ID: <aNzaKAuuzzX1xg6I@pks.im>
References: <xmqqplb750f2.fsf@gitster.g>
 <20250930195320.23825-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930195320.23825-1-git@lohmann.sh>

On Tue, Sep 30, 2025 at 09:53:20PM +0200, Michael Lohmann wrote:
> The reflog write recognizes only GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL environment variables, but forgot to honor the
> user.name and user.email configuration variables, due to lack of
> repo_config() call to grab these values from the configuration files.
> 
> The test suite sets these variables, so this behavior was unnoticed.
> 
> Ensure that the reflog write also uses the values of user.name and
> user.email if set in the Git configuration.
> 
> Co-authored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Michael Lohmann <git@lohmann.sh>

Thanks, this version looks good to me!

Patrick
