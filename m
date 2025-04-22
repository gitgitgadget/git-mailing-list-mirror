Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5603238C06
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305055; cv=none; b=L+MUfV6HESesHIZKJ1I0Q/9arzguUAkFUK25/xjIBpmRVMlDv5N3wtfP9LVt2XppmrgWx5YQLnKv11G1j0Kulr/dB2pJzFkk/J66yBHySsdGUAcKJ0XGZ61hbuVMdVsKL4/LSQDOBqfqCFat6S6Hv4UzCRiB0PcaQEMTwHxzu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305055; c=relaxed/simple;
	bh=66mdQmAfzx498a71Vtl24H9vmTFj0CwCMBOxQujx26I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeLa7v+rhHTBIf5zElaTiEZzXMHP5vx0sfw5ZdWW+WLxvj3pJh3JVj0xCpDf+tUS0OM54xssAd3/0dVF500bQUsf9Vbrq660rP+pQtidqsJOfgf73kZZs/ghF4CxcPzxepehXWSgF8VwjtpKz3ehF5js1Ldy6pgEljWQKNTWREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fVlE8qia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqydC0YQ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fVlE8qia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqydC0YQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E6D541140189;
	Tue, 22 Apr 2025 02:57:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745305052; x=1745391452; bh=0ky/qiSGiF
	xU+OORy9/4Qks622/aS3Ed856RrvLPf8E=; b=fVlE8qia81FwFCYF5lqVeOLXfb
	LMq3ajbhL0+6G93NpIBRgwPf1OG5+IgfW9R9U73O9Caps1QwHEmizD8DrdHi7tTf
	ulsUeQ9GCQ6itoxIBoauoQCqzaTBTEXHUVADVxwYrHTQ+9w/dub6ko9Tk/8QNRw/
	FUxg/3LqgPxxtexekVFYbdlxm/7ILpTI7nLa3YqFmOSJDW+LcqJdl7Ga7+YDstFP
	GBwDFp6iuZ6lKe2GpsLLV7UOtMuFDgAMOCwO9FQLQvGiMe6Wk4pdxsr4LXUwFDyN
	IAPuUxEpHdiuSMn6FtFuKERwnwZnpBBPHjggow988L5rjkEOxc5kZNWd3NgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745305052; x=1745391452; bh=0ky/qiSGiFxU+OORy9/4Qks622/aS3Ed856
	RrvLPf8E=; b=bqydC0YQ5gQdqnnn2kQmdFuIeCkCbv4iQmR1WrG2+SmqnLBSotM
	WRqociHC2ybjUJQTWCoInx9Cv8oWqQUByER20C42/zIteYUKsWe/7OASUnwlr1rU
	T/ymQRtRjQ8yHGwtNT0tCeN5QNZBLtfVzNoXXvK8fuD2L1Psrxj4VxbTdfLiMPoA
	Ap5uhob1yYHnhOi5aCMeMdJVbvKlt40ROS2+NeMAbvwFe5bMLrWF6vBo8hV8naqr
	d/MIxRPhrV0+G83zKWzwHxdrb13khu6MxIg/CHnBpmfu/+u2NALhWWgdEaLseFVG
	+Osy4lKFil3geWRHmCaDaykaf/8C1IFOxLQ==
X-ME-Sender: <xms:3D0HaHsDKbhhX-uXJXSbxP9kDCjZYR_aad5vF3fUcMRK7QLwrcWymQ>
    <xme:3D0HaIcZ8WmUMTej-x1OJbmcyJgUBKsuNBT0wX-u7wMIsbztq9t08m2ESYQ3e39PW
    4oS6ck7d8ZAexK-NA>
X-ME-Received: <xmr:3D0HaKyAa0rN_crf8OWN6EjRTy2yCt3lbetjLBXVn66pZ5XAzIgY62IVvfrPjB3ncdvvNoUnEZVZP5eqLQa50W6WXc7VGDDoFzpMaFnxnm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:3D0HaGO901D0XRg6Cbs-bv_TLwwkSrV8Uu2K_Ilr1n-C6tJLX2oH5w>
    <xmx:3D0HaH9Z1lNNkkZn6SszjZwNsl44tqU7ZJKw_vcUMwY2T-kXRbEz8g>
    <xmx:3D0HaGXRpmrS1MlugEz7BZbni0VwYM_C_LpBSj25K6x6ilgpse34Sg>
    <xmx:3D0HaId34VoT5ee71Wl_muUlBcZQ3H6P4k9bL3IsM0sk0JyZ-akQMQ>
    <xmx:3D0HaIfB2DIvllB-qk8JLxYSdE568WCseJgNFTBeB-EjV40KCM3jP7cQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:57:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7152650d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:57:29 +0000 (UTC)
Date: Tue, 22 Apr 2025 08:57:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	toon@iotcl.com
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
Message-ID: <aAc92C53K2y-ijxA@pks.im>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g>
 <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <xmqq8qnt7c9w.fsf@gitster.g>
 <3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com>

On Mon, Apr 21, 2025 at 07:54:16PM +0100, Phillip Wood wrote:
> 
> 
> On 21/04/2025 16:41, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> > > "git ls-files" is complaining that there isn't a git
> > > repository. Looking at the output of the checkout action (reproduced
> > > below) it appears it is extracting a tarball rather than using "git
> > > clone" because git is not available. I don't know what the best way to
> > > fix that is - I guess we could run "apt-get install git" before
> > > calling the checkout action.
> > 
> > Interesting.  The use of actions/checkout@v4 is nothing new in
> > Karthik's series and we haven't seen this issue come up.  What's so
> > different with this particular series, I have to wonder...
> 
> Good Question. Looking at contrib/coccinelle/meson.build which is where the
> invocation of "git ls-files" has been moved from it starts with
> 
>     coccinelle_opt = get_option('coccinelle').require(
>       fs.exists(meson.project_source_root() / '.git'),
>       error_message: 'coccinelle can only be run from a git checkout',
>     )
> 
> I think it is probably fine to skip checking our headers and running
> coccinelle when we don't have a git repository but we should ensure the
> meson build can still be configured in that case by skipping those targets.

Agreed. We should from my perspective just disable those targets when
we either don't have Git or when the source tree is not a Git directory.

> The Makefile falls back to using "find" if "git ls-files" fails which is
> another option.

We could do that, but I wonder whether it's really worth the additional
complexity this introduces. I would expect that almost all users of
those targets would always have a Git repository available anyway. It is
very likely that for example a distributor of Git would run
"check-headers" or "coccicheck".

Our CI is a bit of an outlier here, but that should be a comparatively
easy fix, I assume.

Patrick
