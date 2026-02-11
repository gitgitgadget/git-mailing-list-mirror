Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841234EF1B
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807301; cv=none; b=JbQnzJBMgLncQyi/OCnjr3qyFfXqHlytek63GHMeCtnXxztGG8GXpwwM0lUr5P0P302xFZd+Pmrm5VKxx5T36UtmXCr1s3c374C+qnd0EVPpTdca+CGjzUybdNaWCnCzb4bTFnaAcT6lqrGKo3foKfizBLOsnmCPkRyVJTJjYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807301; c=relaxed/simple;
	bh=xHK5tr1BkqXmYTFj+4ygpY4+Ie0Kb8vsZ8VNIgzZE10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGzPigyVInxLe1SBwPSEmtzgqZBDf7cmhSZw3glf/t2LkHVlJOS1t1cr1xMjHMWeYqsbCkUQQ5f75Aq+oWjAJkq1cdD05y9sl/8ILtl+zreVz/1FXZQntfvKaMnYIpv/cBIwhHp7aXc6Mzm/v/X7y5UqxP0PrYvNzSBD2fC0+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mJQxl7JK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpUjV4Lc; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mJQxl7JK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpUjV4Lc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B42071D0024A;
	Wed, 11 Feb 2026 05:54:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 05:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770807299; x=1770893699; bh=uODeng8ECp
	IxgScILNJOEC4H6AKaMFBzeOkwghsEjVQ=; b=mJQxl7JKHNDY1EfkQXvqVWZk2W
	F/AHgK+Dxxls9oMV6EVgx1tqKVqNA24VuIRotSoHnbt7DPa9M5sY9ORjVxfCLsv4
	8O18zjnd+v4Nf0Tp1B7ywuwdqn4N4JpIWQW+kcerBV31PnUS73tbTSdh0IxEaIZs
	/in/RIAnFUZXI9i7AITu/y41wPKHbM7Q55U8df5FHeplBUwiIYBHLRg1s9CAOvqx
	/EH793BBy5LUIuRSe0N+jFlz74ZWAGS/FdThQSNtUTEEB86yU3G9mqKecUX7UcTe
	0mlgkzNZ0wh0r0eaPy3PDirrYDsmJetnbXvmZa+nZmjCF+8wGgFrpVNDg9QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770807299; x=1770893699; bh=uODeng8ECpIxgScILNJOEC4H6AKaMFBzeOk
	wghsEjVQ=; b=HpUjV4LclB8A3mgxhO64J/+4fzZtK0E6fX3VRKYJmcec22MPTqs
	wGqPGgv5OodF0WtcsVBrHknkZz99qBE2cCoc1WwDtr2aoU+f2rM5JrZ/9E219JOm
	2rRlRCkv3aT8PP5F562pmmIvTmiGloxOfwPBvGtGNH3ZsngQvsci3Zwcz4a0Cnyk
	YGyS1obm3EYFyc/zlYQ/mlUiUQmgMDqxyzFDlL3AyrTTgwdIRApvoFm6yt0Vo304
	nTDXiW4s+Ix2Al6yTmpBjiLSDnuGkNKb+ogku3iTEFVLoBYpshYAvc1j/NjSFNJ/
	GOFGSgO47n8sxQvT8Lmbs4TbyswZsIOJIlQ==
X-ME-Sender: <xms:A2CMacxBjgTpPLyr1N7XXP43hR0AezW2shGicPgJtVp_o_6xKfBq0Q>
    <xme:A2CMaXQM7rLDs3pNDBKowpDcn5dMWEoz1rzGITThVuuln6F5JeeYGLEH_o0qFKszo
    pdX9b7udPIMkYO1pTzxKYLwsS_0tl2HnAjm8scmepCbj3tXGVhg1Q>
X-ME-Received: <xmr:A2CMaTWTZY-32yNeUdZ01IkgB2oj-cuwilX_kvK9SeTSqP5bpfH40b02cqHGBwTjsJRTgN35XxuImr4dQ3ZnJ8Dlf_RDC9gat27UNMR1DIk5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:A2CMaZZZfdQkbuuzgOn1QEyyNOw1AGqRvRBspshZuC_arRYCfR7BPg>
    <xmx:A2CMaZ0eZW9nbqItDQEY_rJU9c12avt0KxoDVN3Dn-q9m_t8hL7hiw>
    <xmx:A2CMabhk4fQE6LqPpEqwC006DsN6EJNBM751UvtCxOCudqP4h-Meww>
    <xmx:A2CMadZFALbu72bqRLLgzLc-MF0iEq7VfuS_b5uFsmoIM84SLrNIdA>
    <xmx:A2CMaXgfBVIqQ8R7jiAFEz6N3cRtngO8Uq2SXM7aUD3jGa27EcXH_SqY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:54:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3a0b598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:54:56 +0000 (UTC)
Date: Wed, 11 Feb 2026 11:54:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Some assorted fixes for GitLab CI
Message-ID: <aYxf_S-tkgESckEN@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>

On Wed, Feb 11, 2026 at 11:34:26AM +0100, Patrick Steinhardt wrote:
> Changes in v2:
>   - Fix syntax in GitHub workflow.
>   - Add another patch on top that fixes win+Meson tests in GitHub. Those
>     tests didn't execute at all, even before this patch series.
>   - This uncovers another bug in how we set up MERGE_TOOLS_DIR, so this
>     results in another commit.
>   - I've now tested also tested the changes on GitHub [3].
>   - Link to v1: https://lore.kernel.org/r/20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im

Oops, sorry, I've screwed up this version a bit. This is supposed to be
v2 of the series at [1].

Patrick

[1]: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
