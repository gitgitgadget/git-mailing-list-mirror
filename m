Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157491A9F88
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323355; cv=none; b=YjAhk3xyAX74WkJtmPczYj+jG6i/JhQaXwohbwus8yDGlWASHaVZ595BNCZLoTek76PUAaHw4Xd3lyrVtE82SAL/EdKVAS8cvB4IY7uMpWhZdlQGzPWzdX2AKwdTBvxUUntA/Y0nDmmYSA3eA9VYmxbcuz3JVVe95fklifeCRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323355; c=relaxed/simple;
	bh=WWvmVAtKS6bqaPsV+8v8p/cwa89qCLXwDCatG1lQNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUVhG0JdsIrYni7SUIx7h7BuNqdKsRYUp44kP2AakQ1x2pSfX+czireetcwy33wOxPeaCSE714OShGfj3OVBaUKseGQiqcCK8btPzX+16bx2lx+sy11UPNuHm8TqhQTQtvuzR6q+L9BAqDGN8iKmcrXL/doOJoXP+KEM1eNJJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p8WRl0HK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKGYoEAq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p8WRl0HK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKGYoEAq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CF23D1D0009F;
	Tue, 17 Feb 2026 05:15:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 05:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771323351; x=1771409751; bh=MQCYC3to5R
	P/1VJW0iw1hLL3amNccNmzT3fBgv+ZKPA=; b=p8WRl0HKMjtOHy/8bhu9nmfSMp
	m3b24skC6DAhE5xdKt67JCNZI+eooxTW2Yn/LCI3jQXHCM9bhT8OgitV6ziFcB/a
	kt/hSHMcklSnurXLBFtR+CpUz/kGQ3Yaer+8Wcun5VZNP+tHKn0gf3II19T0A5B1
	ttfTe3VPoBwWamaby7opBcoBSH5ize7xN5HF+Ut7JgpX2rW6I3wb7mEOmt9SkniY
	Ldf68K5OHG8Vw4mQmazh5zgTvtp8XNOLIrIL5bDIvFwKU43x1HhZE+evOY6/ZGyW
	DpcqbEmKcQNuhFG7fTtvpNRhwQsuFfy1DwvltN0q3MLQXsX38+kse4v2L5Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771323351; x=1771409751; bh=MQCYC3to5RP/1VJW0iw1hLL3amNccNmzT3f
	Bgv+ZKPA=; b=HKGYoEAqgoTlUiGw4mPWoKaL6OUNFMAFCeqCi5anBT4dHLFGmXc
	nu7ZKnxKvTd+YRCeSgC5J4iFuKeMZVWOKvXBPFiFzRHZJ4wiQNDXHajuov8nEWZi
	XpdmRMDd3XosIGR+bCs6097FXDnxRIe6vdUNqe8NjtFTpP1egPiz0jkxE84rShX1
	VD2ph+HGs3OiVo+8Ee3qKL170LWub1/OCi1o/wOtYu1Y/GXmqdA/uRlr9JPJO5BK
	zomWU98OYMokyu2qNKilNM82PWch7CVIbSBHgNobbm09e/8M49/wMVz1n7984KHc
	bXf07jcOcxj4KqyiK/mKha7qZcFh7kGqMCA==
X-ME-Sender: <xms:1z-UaXRHLFXi9gkOy09YE_UU2T0zIHNFS99FhHK6SPc7x9a9vwaxaQ>
    <xme:1z-UafxkK-ZQDF5OOZUArLdLKu2ari6zFdX-gxWY9tqQLeREXNNUsBtYZAVg1BSbq
    2P10p2M0Y28dfTpEp2iahUgtCTmPWi73XzaZMwqpe3kYbqPl4lPDw>
X-ME-Received: <xmr:1z-UaR11bgs8ky2yGEeAL7Q3wKhq3KwlsvPDk-JDl_BU5_rQV6J4EMEaCIBRJvlLBc2COhSC8MPWaPm0kIUcB9o9-pyHjmALlGiOKKPqrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1z-UaV75GxE5TteVMSMQ_JyxoVvLEXr7VX90NaWZU5_e1ZFNSFS5pA>
    <xmx:1z-UacXW3H7VmNlrHvVBHegHbFu4ypsInbI6gGMeDF9bB2Khq9gNOA>
    <xmx:1z-UacC9Lo8Hqz7nT2vSZGqA3uwUa6hSeQOodQo8bqZCClCBbg3m8w>
    <xmx:1z-UaT5eTOo_k80xwgIHugv48zM-7L6BOQC9Q4lwWe9KVQumw_O2kw>
    <xmx:1z-UaY1znByof4IJepXuJPvLCDlQhhd9bKxgA8bSaO26JIbSwDnKuJ-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 05:15:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 292d0970 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 10:15:47 +0000 (UTC)
Date: Tue, 17 Feb 2026 11:15:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v6 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Message-ID: <aZQ_0CaQG4Hhceby@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com>
 <aZQXrRuX3nsnuyEw@pks.im>
 <CAOLa=ZQFOLh6ixB4=ukPS44uE9k3-1Zw1U2bCYf+TsKyHEqLiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQFOLh6ixB4=ukPS44uE9k3-1Zw1U2bCYf+TsKyHEqLiA@mail.gmail.com>

On Tue, Feb 17, 2026 at 03:32:56AM -0600, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> >> index 9912433b8c..b743c03a59 100755
> >> --- a/t/t1423-ref-backend.sh
> >> +++ b/t/t1423-ref-backend.sh
> > [snip]
> >> +test_expect_success 'initializing repository with alt ref directory' '
> >> +	test_when_finished "rm -rf repo refdir" &&
> >> +	mkdir refdir &&
> >> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> >> +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
> >> +	(
> >> +		cd repo &&
> >> +
> >> +		git config get extensions.refstorage >expect &&
> >> +		echo $BACKEND >actual &&
> >> +		test_cmp expect actual &&
> >> +
> >> +		test_commit 1 &&
> >> +		test_commit 2 &&
> >> +		test_commit 3 &&
> >> +		git refs list >out &&
> >> +		test_grep "refs/tags/1"	out &&
> >> +		test_grep "refs/tags/2"	out &&
> >> +		test_grep "refs/tags/3"	out
> >> +	)
> >> +'
> >
> > Should we also verify that the refdir contains the data and that the
> > repository only contains stubs?
> >
> >> +test_expect_success 'cloning repository with alt ref directory' '
> >> +	test_when_finished "rm -rf source repo refdir" &&
> >> +	mkdir refdir &&
> >> +
> >> +	git init source &&
> >> +	test_commit -C source 1 &&
> >> +	test_commit -C source 2 &&
> >> +	test_commit -C source 3 &&
> >> +
> >> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> >> +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
> >> +
> >> +	git -C repo config get extensions.refstorage >expect &&
> >> +	echo $BACKEND >actual &&
> >> +	test_cmp expect actual &&
> >> +
> >> +	git -C source for-each-ref refs/tags/ >expect &&
> >> +	git -C repo for-each-ref refs/tags/ >actual &&
> >> +	test_cmp expect actual
> >> +'
> >> +
> >
> > Same question here.
> >
> > Thanks!
> >
> > Patrick
> 
> We can verify that the repository only contains stubs, but to verify
> that the refdir contains the data, we'd have to add backend specific
> logic, I'm not sure that is the way to go.

I mean all of this very much is backend-specific, but I think that it's
sensible to at least verify some of the basics here. Otherwise it might
silently do the wrong thing, and we'd never notice because we haven't
been testing for it.

Patrick
