Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EEA2F6581
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811982; cv=none; b=OwOv0YmRma+YiLK/0NKmHnmJ3eBPIPXLnN3m5+j0KIOcTz7G4Hl/acc+YeciP8oYOTGT7x7XkAxCXIqMZctxTC8ui/KmVoraOanaDfGfFhUlolEGYzeoA3jYoy5l/CxvmtzzEcLjWr6wOtIkCd9aaCYpDFucU3jCKkUykaJs7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811982; c=relaxed/simple;
	bh=bB+IhjgXnkV3cng/ubeUD9VShbDJ4ODAJ04qzrkNSVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5bAknkWCUI99dC0JIFnHa4NQQGZV/JoNCGYpXHZ+JFEN53gMq+rX0+rLSLwUOLryN5xSc5F15nR8F9ZnX2IXF7AbORvBNAJAOWVs0dhNT3Tf582Zmog3nNf0HOQ8g+PwscKoBjavYzF+77nLV4BretrRvg8Yc6aOb7mW5L/3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVMc2YUp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocV2xrtd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVMc2YUp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocV2xrtd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27A671400280;
	Tue,  2 Sep 2025 07:19:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 07:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756811979;
	 x=1756898379; bh=gTirE3WTohGCFEQEWaiG2QayLi4B0LGxLbBjrKVSm+c=; b=
	dVMc2YUp2oXcjPo7NreD17jD4Ux8jtNyay+ddu55y9eFjhrBCsP6WFTbuMdnZ0YV
	Z/+blE0ecVXqJDgblNQMRj1aT0tS+KF0fzAp/35ch7p6mRo2bRq2HKerq4DAyEsW
	fuYq8D1N/Jjwq1FYQr3yLnPYXx0PsHYTaZQK9XhheNlpmmZbTqgLrkOUFYSPU536
	+0MqUrSF4GtUUhFDgMaX88NufN5WxAuLhGkZi8syOKhwqwq0YSCTHc5yveLOiMJN
	uZrmKuTkqtpj2GEwVAsXohzFIRMhZAsD1Rzdt3lXaNQQGvOLpAcWFLylbSJjej57
	H+QYdLYWm+iRJzv/rS21zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756811979; x=
	1756898379; bh=gTirE3WTohGCFEQEWaiG2QayLi4B0LGxLbBjrKVSm+c=; b=o
	cV2xrtd2UeM1X+N/OZBvetcpc26Dt2I7HN4rmQD2kwoZTg9IkhWPYt5aRK2/YpTW
	JXFqpDkLw3fOU88huAfqhrvB1kpn2OVdrvzrOY1K/pdy07qpobGfYTaQ2ioHfwO1
	3qqr29cA/0emuSc568ZsNCxNZRYwfIgkpehFQsCyFRvHNa4wcE9C7QWSR2qdl+25
	Syk7qarQH9dSzthxtmHcZzebPg8nJFeCCVPiesEq/6jGetBLj+pvF2C+c3LrMcxR
	opyWu0LRnl3zPyVs7qrDppN+aZ+qN3176XORH/yz276uphlRmyx8I4JDu1Y/xtdP
	XC/+qlEbW234VTJzwdiQQ==
X-ME-Sender: <xms:ytK2aAAWg_fnzSyuQRDwFefqD985EIQnNAVhZxZ-ryE7AQ6MP-FabA>
    <xme:ytK2aId_hO224iO0-fQtCQ_ZQMRWX8pXy0ks9SWPgauQld8q3NX2eW_dkrGNSQ8YM
    lxF47ZhB2XUYMP9Iw>
X-ME-Received: <xmr:ytK2aAs23zNoLYWAhF8fc6DHkehaKK45TitNKDenkaat_gV7wu3_OUZIuHz8btIfa-KNAU0UxM-PitRimBq--FSG0KunOjUsR0ZmCsAtcLtP0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepud
    etheffgeeutdefvefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ytK2aHjvpZWyrW8HGMU0brDAsi4Sl9sdXEx9knESFmPgPwtNttapAA>
    <xmx:ytK2aAsSF60CIrRaviXrbdbHziQHbYOgznfibIuZ-L4qbp1fmH1Ixw>
    <xmx:ytK2aK9zGhO9nnI8ZLfbI6KlQyx1sSmIhZBxMFgFxyQeqDHJiQ_nzQ>
    <xmx:ytK2aOZuTOto6V5jz-mqeVvFapm6sFhZ3VwMBpoz4BHokLpcWqcnTA>
    <xmx:y9K2aAUz-lqjkLk1DPjp3DEnc3cKEP2fPTu5h85Aw_xDSdofm9YmuOlS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:19:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85b16fd6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 11:19:35 +0000 (UTC)
Date: Tue, 2 Sep 2025 13:19:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] [2.51.0 Bug] Missing singleton objects in 'git
 repack -adf --path-walk'
Message-ID: <aLbSxDenGqOGgEqD@pks.im>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
 <CABPp-BHFxxGrqKc0m==TjQNjDGdO=H5Rf6EFsf2nfE1=TuraOQ@mail.gmail.com>
 <xmqqh5xukrcb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh5xukrcb.fsf@gitster.g>

On Tue, Aug 26, 2025 at 08:58:12AM -0700, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > On Mon, Aug 25, 2025 at 5:50 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> Updates in v2
> >> =============
> >>
> >> Thank you for the quick and careful review of these patches.
> >>
> >>  * The test and bug fix are now in the same patch.
> >>  * Several commit message typos/grammar edits.
> >
> > Thanks, this round addresses all of my feedback and looks good to me.
> 
> Let's mark it for 'next', then.

Agreed, this version looks good to me and addresses my feedback. But the
series has been merged to 'next' already anyway :)

Patrick
