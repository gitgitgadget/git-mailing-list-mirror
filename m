Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D91E5B88
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074614; cv=none; b=Db6hSEXvfLf0fRH1quuyL7k9lsQBTi2pWv4tYK8eYmajvazL++nSbsCb2BrhFToCBrkt48Blyq8hVgBDHzk0yyzKRXB0tDOZClvEL4SEQztW0iBR0zaqseUP9e6y4kclKRFHsgzOpkHVbkCEJXu5eAwbibXFWxfs7r+WSFgkbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074614; c=relaxed/simple;
	bh=AKlPmtdpffF4spgNVRRbwDzzLVmNFjB0Avk9QnQw3gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYo4W+eLymy2q//Glm2zuKvDBs1VSu3WpJTAWO+Lz5GxsyxRDyrKWhoEmgT7iyFNVwZI937fNU0s/zz59kE/nEKwE1PRpQQdmJFytklycP76VzmL63dipfpO760a9Vmcp6iPchpHC4U+rF8LC/NbSA8xGqrM0kv4eAB6a7qQlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kA3X+QGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qnqTvsEr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kA3X+QGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qnqTvsEr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EBC1DEC0214;
	Fri, 10 Oct 2025 01:36:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 01:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760074611; x=1760161011; bh=b+/US0rGLs
	WErAOo/tIyJA80q2FEBBvZDK4NJ8u/vc8=; b=kA3X+QGm2DF3HtNyvHTWJz6Kxw
	RRptf1ZfT5+ohmLwPdddNZAfl6Vuf5h/abzxfMauQ2JBYSWe6OMPblpbkkecGvYX
	oyF9GsBFz+7o2kHIlzMol3gyKTzqq9FKVOSYo0GZTVCGiHWHIJiDYC30WSilN1Mv
	omfTuJoN+PEPHjuDxqnGQ4KQQ7sw5/aUYb2COC1Kur746NCkt9WVvtOFl2ltqXch
	db8t4Q/bF+R6MEKLfufZ4r/0ruC1fufJSsxhcvx/ONZOeq34exrDxEkqeuMlOB5b
	HXDdvIKOQmQ8qB2ag4PIG8q15OXU/TXqxC7vaaKoZog8qKtqZcEIRM+o95cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760074611; x=1760161011; bh=b+/US0rGLsWErAOo/tIyJA80q2FEBBvZDK4
	NJ8u/vc8=; b=qnqTvsEri6GfuOgvGvNWvbJBzAlu0K1KJ92xbwJQbsCGNNfmu+c
	KVtsGLPtz79eB+oWBk0pQUXwFafJY9EEBD5hxeSP9axBcsUnADtnuUDHp7vGDNZR
	MSqCpxhHNIUSGnL3CtH8riFRD1/UsfaxnyMfOPGR17TL1PJbb7/MjiIDXUspY1Yl
	5NKsdEWlvyeYU6NKJ1Tz214jC6tBu52ss51dpErKg5hekhkV2zDXz54J31q3zSvW
	oucjDgJFMloxfKWb+yloW4eTNRuK9zGd1LFht8N8vidpTka6sfiRNrrbyNTW32qE
	zKHZrUVTYnWfoDPaFpvLJMerCjAEI/3/RsA==
X-ME-Sender: <xms:c5voaFv2dPgBrcwXZS2i4XE2WLAtKzYYp_eSYBLiMlxAMxzKYeYmOA>
    <xme:c5voaFdnNUjHUkzi_aMVM5poFtvWTRWkF8_61tLgLiaKubXjDgFiOEmqS7fpuZQzS
    JDiB0NSftimdvH7ouSMDQlC7bkX0QKKl28aHAZWyf72rYHRTw81sNI>
X-ME-Received: <xmr:c5voaNw3s90Wgk62EpLQMSQjk9U32pJr_wkr5antnweXij54mNV4igQ5PVa6HYH64GoBCBWHX_9_Svs28KcvMQoZ7eF9R08dfFaR0xw90A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:c5voaLF-bola_bODct98ZpJ7J3FjF2Fj3QU3FPcStXGjFTVCiHbIlA>
    <xmx:c5voaBwtTMBr0RGFHnVtOeFqt0UFvrMyqAaAKizJjiTtnx2vONswBg>
    <xmx:c5voaMuqXH1UeCgHcyVdZPap-qaZ2u4FTG-6C5ATzlv121FApafLBA>
    <xmx:c5voaO0t9qZRHTx7-XwxrtcM-gnIHLgkrgdIyNpM2sjR2kTxxQFlbA>
    <xmx:c5voaLJQuXpgQbZb3Pk3uCqs0kup0gxPNvLGEJvSFNygywT7o7FRlRIz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 01:36:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0eb2f0df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 05:36:49 +0000 (UTC)
Date: Fri, 10 Oct 2025 07:36:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
Message-ID: <aOibbUqe-gfal6sd@pks.im>
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
 <xmqqzf9zddia.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf9zddia.fsf@gitster.g>

On Thu, Oct 09, 2025 at 01:30:21PM -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When `NO_SYMLINK_HEAD` is defined, `create_ref_symlink()` is hard-coded
> > as `(-1)`, and as a consequence the condition `!create_ref_symlink()`
> > always evaluates to false, rendering any code guarded by that condition
> > unreachable.
> >
> > Therefore, clang is _technically_ correct when it complains about
> > unreachable code. It does completely miss the fact that this is okay
> > because on _other_ platforms, where `NO_SYMLINK_HEAD` is not defined,
> > the code isn't unreachable at all.
> >
> > Let's use the same trick as in 82e79c63642c (git-compat-util: add
> > NOT_CONSTANT macro and use it in atfork_prepare(), 2025-03-17) to
> > appease clang while at the same time keeping the `-Wunreachable` flag
> > to potentially find _actually_ unreachable code.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     refs: forbid clang to complain about unreachable code
> >     
> >     Just upstreamin'
> 
> It may not be a bad idea to deprecate core.preferSymlinkRefs now and
> remove it at Git 3.0 boundary.  Some platforms may not be able to do
> symbolic links and use it to represent HEAD, but everybody should be
> able to create a small text file with a single line.
> 
> But until then, this is a very reasonable thing to do.

Agreed. I don't see any reason why anyone would like to use symbolic
refs for this. The reading side for such symrefs may continue to exist
for a while. But the writing side can go away.

Patrick
