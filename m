Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2D3F8DE5
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051226; cv=none; b=AFHV4PAwdZxjLE3RmmqrKd4xUKcPn4Nu22k1+ulpk7xWZnNmVNDoSpQSqBirYN1YJYLgSJMw+VrPQR/dAmk+0i07KwwKVHKsBv91nPZc0Qz9weD74Dl2Y0JAPNcrBVfa4fQqR4ksm98Crpn9C7GBYiGU/Ldp4o9I4OcmNMNJbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051226; c=relaxed/simple;
	bh=A8ahYoMlz85aLrEzB5+edeXKPWAOmHt+F5I4MJ07JMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3MC6qISIj25797JtsuRC7sGyYj3CzVToey/YmEYZnGYWR7j13elypvH1Kss600PtEc9hAbrCpJVCetOQjMeBggKC4FSyhgOUq0maQv6vOl4sr/88e6rFa+S1ectwXuC5iVnODMAJYN1otZlMAifCBuqu8mMnvVYUYEW4i5I2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sBJ5aOB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tt8LW9j/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sBJ5aOB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tt8LW9j/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66509140033E;
	Wed,  1 Apr 2026 09:47:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775051224; x=1775137624; bh=Ds7A9c78wa
	Pi3pyF6hgjm4C7czX2MFPaO5JSQGOwy04=; b=sBJ5aOB5J1fr6plhSGQr5zrgp1
	fEt3CmDB0JhTxcs9VVHboiVcDKPpruDG5Axgj6+1DIwZ+5KDM4J34S3kJ39l21D+
	v3Y1CjLaYcaZFE8ZCwwuf/LXAMlgdONwZJ9fEAj+ClxHWGFPeuwRWTDTJh2U06IQ
	eEzwL540wMVftIncLvBtMvqfV634qVACdBa2FWK4oDbCEgWd63pwP6jL67gIp7hF
	OvaLukiUVT719y7ZswRkJy5TqytXHcH38tVE79sD2RnE/JvnJbBIpHBbO15+4EUk
	ejEHoDpRrp/q2IABJQk+lvdW8IlhXHjK8hOBRPCOWmnuiXu7TF3zwZ2KY4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775051224; x=1775137624; bh=Ds7A9c78waPi3pyF6hgjm4C7czX2MFPaO5J
	SQGOwy04=; b=tt8LW9j/2JbuhouKjxVmUr8WrFbojqEXW0ycG52zGXKiZyuK+lk
	A/7Ni64iXjknMc2uAmgSU7xgAGi8oEK+lq0iscC0S8hmolQJDL5RzIzDitjaTvcY
	CVaIpL+EFYTlisDoi1RwJ30CBwBLK95DCovKNGuNoCYE8X28KiY7teq1XiXljsR5
	Iv3oK38H4lUwpSOLjP/X4X0GrTstxDDiEId3sbQ1YLN6bGkwrmvUb4EAZ38Y4LBd
	urGHe3nw4XVmcaftzGSlftQakOF0FhuJBI24Tf+nYNG98OY8ZtiOvlBnNcycu6US
	EDEmoq5d1CfZlX3EuJHOHBFI438pzwwF0Tw==
X-ME-Sender: <xms:2CHNacJg1yQOPSePBoQvdtUmcHasCqF-i-y98G2i_gjWGm6rMITNvw>
    <xme:2CHNaWuMZA3QlqypC1rDJGEZD4XmTjAulMoyDEL8qrya-xWyK9p02u4clvjNWvupx
    0qdGq_FAmVOuFnYn89Qo3jmxCIVXchnxac2MeqE9wxpiQeiY-ne_g>
X-ME-Received: <xmr:2CHNaZT5ux99foH2oVjeTADwCsrBdNBwZzO1Bh02lkFojRmRSVHUgljSRoyE5cmfrFxxP4I45Q91moJs4pqV6WPXQ-CGtFOTp202RE7lE7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithesghhruhgsihigrdgvuh
X-ME-Proxy: <xmx:2CHNacNx9X7x3dHxYp_-foTIzLRHp-QbVD5ZfpEhTOR7JgaCezmszw>
    <xmx:2CHNaebvENtNtTog6K_LIF8WCa7pTMLvNsv5za0byHDcgmklpiQRUQ>
    <xmx:2CHNaWzcsaEs2Mw1P_KSQd_8qYYSGowYPC7elkPAfwdrBBXpJHactg>
    <xmx:2CHNaZLIgJtgWD1h4hphbsWPW1XMc9LiNej7l4M6cwQKIaivKZlgNQ>
    <xmx:2CHNaauw9qt8B_rQh4m5YoPIGR7OltyANvSltPux3xNkho8dYqZwRpkh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 09:47:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06d55237 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 13:47:02 +0000 (UTC)
Date: Wed, 1 Apr 2026 15:46:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 12/12] refs/files-backend: drop const to fix strchr()
 warning
Message-ID: <ac0h0xwqLdX5u51v@pks.im>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235341.GL2328529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331235341.GL2328529@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:53:41PM -0400, Jeff King wrote:
> In show_one_reflog_ent(), we're fed a writable strbuf buffer, which we
> parse into the various reflog components. We write a NUL over email_end
> to tie off one of the fields, and thus email_end must be non-const.
> 
> But with a C23 implementation of libc, strchr() will now complain when
> assigning the result to a non-const pointer from a const one. So we can
> fix this by making the source pointer non-const.
> 
> But there's a catch. We derive that source pointer by parsing the line
> with parse_oid_hex_algop(), which requires a const pointer for its
> out-parameter. We can work around that by teaching it to use our
> CONST_OUTPARAM() trick, just like skip_prefix(). Note that unlike
> skip_prefix(), the function is not inline, so we can't just wrap it
> using the same name (otherwise the actual definition would expand the
> macro, which breaks compilation). So we rename the actual function with
> an "_impl" suffix, and callers will all use the macro.

Fair. In fact, I was a bit torn with the other commits whether it's nice
to reuse the same name. I guess what it buys us is that you cannot
accidentally call the wrong function without the guardrails. Even though
that's quite unlikely with the `_impl` suffix.

Thanks!

Patrick
