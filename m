Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A0199249
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674330; cv=none; b=K7ZxDSXyFkDCxjLSPWBVjWynviB9dDWSAV+f12aHPUsG2aXPaeSiU44qSDAYulN594QQAEzr5wm5H/2HipRIl3rl7xF3kiA/MkrpMKbE0GluRA+6uyeKkKkxH5OKCbrcyZWcQNa/jaKVnyD8fBuBQncss5Y+EPxM3JtNYnas5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674330; c=relaxed/simple;
	bh=e6oKYI4yA8Okc6AmPUIzn6ki9FU/lplv47eTrh537Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZNnqvpQG1NFipeTgcY023OyeHh1/8q1M5+n9RX/kbOvORgYfpPyBeIFaygSAyBe0SSvWFfeLmXP2+xO+fN3p9iMllU29IfhHSPf21Y8fK+R3v1ffPQZU58DEncqw8D8c85Ft34sHy7A1v7EH1srm4geU7c/dtn1A38isOVEouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f1AdEODN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPC8fyQY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f1AdEODN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPC8fyQY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB687114019B;
	Wed, 23 Oct 2024 05:05:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Oct 2024 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729674325; x=1729760725; bh=AwvpaF9UcE
	8MpPB69XSd3HD95oOCATVeAYOvkfD0k6g=; b=f1AdEODNRSSzEXIf32/G0v/3rd
	sch7FqxjhSyQn42aOZof3eovw2AQLDMpxzkYDTlUlTXTCxO2qQlOQA9sx1aYroTr
	oXSizjawsrEvqhvffpvlUcFMnR1gNgPPkF/ged+nAiYWFP5IEUQ025eLG6ptWK95
	IQ0Ll99bIuy2K88ElcxQJ9M0jF20MUiQfyNubDvwQvNOW6oh4Am1cDbGysgXTKgl
	qu/ra3CRSM+AicDqljSyEWxGvTOGPhOCbnO0k2otUd/4rLxANrryHXB2dQUrWxFc
	QzzLqK44Js8M/XwoofaDyP1iEKCuc0h+cxk2vo3fv1AkuXjIjY6qwMi31DMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729674325; x=1729760725; bh=AwvpaF9UcE8MpPB69XSd3HD95oOC
	ATVeAYOvkfD0k6g=; b=WPC8fyQYGlJUh32Cs3qDg6eev32MTc1wXnbnWzNmwkyA
	5ayqSo4OmYk11BTyajPoQP3Lvbb13iNCZMvqKGUgZ4k23xktSP/Cmp8Sq0iIUnTk
	Vkwist1v8GEfHsvJHXV4gSQzvx6XoNpo3hbFw7w348PjZGtkuCh4jwRmnMF6r/+b
	RPQW1EIxyIPebxkmVFZzJSzXsp0bf4NQq4MJ2LVqnCTfN//IYcof8roG59abZs/m
	4fL9Ump3/U4YUKrM8/AOhbO2Dp2I0kNGGKbAoqYO579jRpqJlxIZqO/ImtYII0gU
	qJ2TGc3cQ23q9YnhTcy11EP6xZPApSSXPebOfVoi6w==
X-ME-Sender: <xms:VbwYZ2IL0sC9cAububVPuqeJa5zHaNitxrCcjqQPv46SkHtFpJxfTQ>
    <xme:VbwYZ-IA95FDteIplwvvq0ORDvdQUfDhpOCEwzADTBZpQ-xHsLodJPy9JS-u3Mi5C
    pS-Ri6h1N6sIoDxpQ>
X-ME-Received: <xmr:VbwYZ2vErtSJjJmm3TlsdpbHkZxpcECrjfD2Tchi0X_QZ1eNgTHdMMn7NHuBkQ9lpst8DXuoJsliJ7rXAeykabRclg_OSx-nYKaU1C7fXR_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VbwYZ7YvabTAJOrdoaj9mR4vWM0ovF8bugbxjRbXhvLYlHQ2psHjbQ>
    <xmx:VbwYZ9aYsl1obCSTrb1nNmQ9jy_BtthUHhdBry4Sd0ei6wgaHb_mjw>
    <xmx:VbwYZ3DziVSdn9hokwlJxwH53MMUkFF1qk8pn-L5UhMvNoA9d5Jjbw>
    <xmx:VbwYZzbYUO2DEvvZbNN-J4nn6iRV8aPKe8_2_OHafZuotLtJn5ZaUg>
    <xmx:VbwYZxFX0zi1owjaoBwL4-mKGzPxoG0BRSwEfLxzwYWYz7L3sfqTwbgp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:05:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b230bcc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:03:51 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:05:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] meson: fix meson build on 'seen' branch
Message-ID: <Zxi8T2BoMX8ltM0E@pks.im>
References: <12325bcd-fc3b-4d2a-9ec5-20fa2b50297b@ramsayjones.plus.com>
 <ZxbPkU+P8HUwVUDj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxbPkU+P8HUwVUDj@nand.local>

On Mon, Oct 21, 2024 at 06:02:57PM -0400, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 01:54:47AM +0100, Ramsay Jones wrote:
> >
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > ---
> >
> > Hi Taylor, Patrick,
> >
> > I tested the v3 patches on the base mentioned in the cover letter
> > without issues. In the interim, I noticed that the v3 patches had
> > been queued on the 'seen' branch. I tested with make, as usual, then
> > with meson (on Linux). This patch was required to fix the meson build
> > (just in case you weren't already aware, although I suspect you are!).
> 
> Thanks. It would be nice to have this folded into Patrick's branch.
> Patrick: thoughts?

Yeah, I'll pick these up with v4 of this patch series. I'll also try to
make sure next time around that things work cleanly with "seen" and pick
up dependencies as required.

Patrick
