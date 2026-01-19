Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511942D9ED1
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806663; cv=none; b=U+1r3VafQ14mYB/ddPFbG46HA9yERqUeqr6M+cDorOxTHFMHmLh58CgcaxkIM08yOgheD6kM3t7zl7fJYWkBzUbK6OhXQ0e/a/K0qlS7MT2cet0nJE+jy0IzIubSVuN8DCbPe7y5NU/JGQQEs6w0cPnpmYyLiyXKuyK8ChXMElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806663; c=relaxed/simple;
	bh=y9g7U3gxi+zXWDyzxqkkWpN1jlEpP7FyZRs8x3WxrGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfzcoOf5tysahLFisf2qD2eNqIgnnanvLpk1U5sWOK2M7Qxmhf1xKCnrxLIw6AFUQiOWP3MCS6CPR4btCvKl0R6hLDUVZtu/SQyS0hSBH+qX96xw62bW+qx/5wr37fDnR9tFO3IEIxGZ/67IkNm7GdYXTAqwq5J36V3lGxLkc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctCWwRcF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCzIYMGY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctCWwRcF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCzIYMGY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 87D8DEC09E8;
	Mon, 19 Jan 2026 02:11:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 19 Jan 2026 02:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768806660; x=1768893060; bh=YZ9Ly4xrEb
	zYZLSix9MXwJgm8vnCiQBMA0zMHhFJyDQ=; b=ctCWwRcFetBjpu8U2qVcxSmCNI
	RGnV811rnqry5JTmgZyrbc6+87PLXYhszlQJr1q+NqYEVPV8lVUik7NTH9CF56K5
	rd/rHPX9MyuFKOUqjSCz4zhwMthv4hhvOsqcwFdMOCrbwdGMuGe0hET5ccGGYJv0
	qQcMSfSFmuWffnv5DQdetjm/OJo2ftCtHnvREwG0tcr4frldLNqVNeqtPm898MaR
	A6u+4DuoGCqoEZKF3EExUlU0bkaZI7JrRiHby3L0TSakWdMVIyntXiTWjqSkiD9d
	ISl9B++5IxnHlr8vvrW3bPsAgnZh73A76rfv3NDF3GhI9824L2ug9TizKZ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768806660; x=1768893060; bh=YZ9Ly4xrEbzYZLSix9MXwJgm8vnCiQBMA0z
	MHhFJyDQ=; b=WCzIYMGY5trBrkWv3nmxR+qUcAbY3fNQ0kA8q8/IQ9soSbpVCcj
	U6DqEYDJdoajxV4WiewnQKI0P1W3Gibt+OsRK1fIkfY9AbRdw2WCrg6wtcnerv8x
	6ZW+8x83UrbUXgOr7lue0YZUqnXlV0Ug98+rBydjKU84jbZMLFdwqmRhK4fywosR
	OHgKzW60SaM0KjaceynQHx81hmMLPVk65n+QXAVasIBz4iWqPsMYoZOyraiFonCF
	5oLTN/Ef8M6cdznPZi+N7ItEw4JP62+pl6MrbjnWxrPvNusrxdfsI2pblWKl2+vm
	uu2X84K9voNfhrB9n4XDCSYjM8lOFsdDpwA==
X-ME-Sender: <xms:BNltab68_9xtQpPt_Le7d51DfkHN-W4CMNARUBpQsYeO0GDuDXPVQw>
    <xme:BNltaW6wMXgt2NNn3kBJse6fdq0PXxoi2YZmiM04jT7ZAWCFN0SK5f0bffGja8KYt
    FyoeB-sjs9NQGhwTreWKC6i7zealCsxBNiCR5Qifj3fX9iEiXNRkg>
X-ME-Received: <xmr:BNltaQHpWw_UH52QN80nkx0I08CPaSILH255garibY1RhSGut-ynH4AAo8nDconDQe_T8xa92oWLaBXXMcSB53omBpaZcDDAZ8i8s_x0K1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BNltaXRkP_BfxSfd5KuAFVRU7q136ufR02FNtP3SF0fehLj40z2_Qw>
    <xmx:BNltaRt79FtK4cFR78fvWm9gSh4IQTTDP0ZPLhbWhajzLz0CHgWCeg>
    <xmx:BNltaeyXLlIkX_PorRfJqsXZje1sf4I6zkPc5Fak91fg9_QZLwBSXA>
    <xmx:BNltaT5qeWuwYgNcR83u4Lze51FOT8U9UmuADJjvxqg-cCKHzFNXPg>
    <xmx:BNltaZrT42WUpXV2fHucNmxJdQaxQw88Tdq9QmjBDWEyBTBIOfPhAENl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:10:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19204bd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 07:10:59 +0000 (UTC)
Date: Mon, 19 Jan 2026 08:10:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aW3ZATijLwAl7ZT-@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>
 <aWlemFAu9HwKgpOe@denethor>
 <aWniz5_-Q6o0tJXQ@pks.im>
 <aWp5dToSXoqAqiT6@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWp5dToSXoqAqiT6@denethor>

On Fri, Jan 16, 2026 at 11:47:45AM -0600, Justin Tobler wrote:
> On 26/01/16 08:03AM, Patrick Steinhardt wrote:
> > On Thu, Jan 15, 2026 at 03:44:50PM -0600, Justin Tobler wrote:
> > > On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > > > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > > > index 6964a5a52c..7d16fbc1b8 100644
> > > > --- a/builtin/cat-file.c
> > > > +++ b/builtin/cat-file.c
> > > > @@ -861,8 +871,14 @@ static void batch_each_object(struct batch_options *opt,
> > > >  						&payload, flags);
> > > >  		}
> > > >  	} else {
> > > > -		for_each_packed_object(the_repository, batch_one_object_packed,
> > > > -				       &payload, flags);
> > > > +		struct object_info oi = { 0 };
> > > > +
> > > > +		for (source = the_repository->objects->sources; source; source = source->next) {
> > > > +			int ret = packfile_store_for_each_object(source->packfiles, &oi,
> > > > +								 batch_one_object_oi, &payload, flags);
> > > > +			if (ret)
> > > > +				break;
> > > > +		}
> > > 
> > > Huh, I was a bit surprised to see that we are still handling object
> > > iteration in a backend specific banner here. I would assume ideally we
> > > would want to transparently iterate across objects wherever possible. I
> > > assume the reason here has something to do with how iteration is handled
> > > with bitmaps?
> > 
> > Exactly. I was pondering a bit over whether or not I should invest a bit
> > more time to also make this part here generic. But I felt like the patch
> > series was already long enough, so I decided to not pursue this for now.
> > 
> > It's certainly something to iterate on in the future though.
> 
> Certainly not worth rerolling by itself, but it might be nice to explain
> this in the commit message and/or comment. :)

Fair, I've appended this locally. Thanks!

Patrick
