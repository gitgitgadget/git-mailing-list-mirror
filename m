Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F519DFB5
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777666; cv=none; b=eNdeWiIRbe/ErWLRuO22b/V/XYmadzWOaph/WjBZzBIyKn4gaRFKgKff5K8B+aRki6Ai4vJr65nyvOcMCwkiucw8aObE+MkgFJZ1mn9QdtjGsLJwDmOwsbsq/VgKHZUile966ND/iZvD4F1Sq8tZQb3cl9/1Lj74X+uZHhiJ750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777666; c=relaxed/simple;
	bh=cgFxC//PJEg12P02Ev3ZxKMv88ergrmRHN63Z6gmo64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N43jomEQJkV2mdeaDIlMZ5F2GEpqNXHNzv2vevgCv2dGarh6tW5B0OBVp1ttN6W7SuJB9eSLj6+T1fftJOCb3/F7iZC2n/IfGaj7XKRM0gPfWVbRP/442FjnIVBx6c0b8Kq2i04JvMApluvOpj9vj/P3sSPoN1neQxi2GOo++YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XMcMd5EU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBSY/U5d; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XMcMd5EU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBSY/U5d"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D2FA31381D5C;
	Tue,  1 Oct 2024 06:14:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 01 Oct 2024 06:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727777663;
	 x=1727864063; bh=7QB0MH8yhuLH+8V1oPLIfymIZYlRqVRji0OEYZm//xs=; b=
	XMcMd5EUie8pn0ty6enRe7lQwMmgnGM5DJ/JdHI1V2i4qS8vnIaMl87nPkQi/5sL
	jqk859zI5Yohgr8Gs3r2Eq/MIMtkz0aIBNxYPj3K6U/x5dAU8xQSfqbCN7rnou4Y
	y7gnekF+2Piv2Dtkvaj8GZV6HrA4EpPYPyyK8Kjf3fSUM/QTseFzj69SYdLRJdTj
	JaNM1vOBW+2BM0yV6qg2sKukecci9TVCEJZfh+FHqu7oX+dFSFjndl8IkRA/THIK
	HWH6bZaJ5EqCGvERzPVHGdVmbCOgX73OoVKJwpn3VRMNv7Yz/gL4zX42dy/i1Wu0
	GZK4d16IxblNVgtGcWGw+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727777663; x=
	1727864063; bh=7QB0MH8yhuLH+8V1oPLIfymIZYlRqVRji0OEYZm//xs=; b=f
	BSY/U5dsY6Bkm6TUR60pD+7xhf+ysqq5gsHNniTSuRlSqDi8R1YTJ6bGyVPI6uRf
	xzWmE2CdDkIpyV8E7zbjruALyoNjshj9RcWryVsTBF00i2N+WVL89ekFMeXDKaXO
	36RL9c8X10TPOHkKQYqv1ZAqfeh4Z017d2KNhOLhlCB3d276cjvH/iaYzyVHM2gB
	88H+ZP/det7oDl+SBqEQqMrOh5CVLxiE5y98G8YjRdWioCg6xkpVmnkyltJ9Lvk4
	tyTXxDJV+8jvoAxqBEnRxIYwTI8MX9a4mBnpOSXLIz217k1M2tLLVJeZP4aYPpgK
	UseA/e/yP2RPXJUzsKYTA==
X-ME-Sender: <xms:f8v7ZssXUOUmac4YBEW_oCTCFEMuVy3_PBtVZvMSP1WzfqjytOtrRw>
    <xme:f8v7ZpeflNmqgsuDrQO7Ts_6y8n8VBawxW2tYCDauidtfgcls5uzy7JG4zcC5HW0M
    H4XhwdKF_m4q6PhLw>
X-ME-Received: <xmr:f8v7Znz1PTSjXi7UhjIEwcS8qpKvk8Brl2nnd8gQP6cTfGvEF9wXvZNybp5DvJxcVBDFcDHr-3WMlbMOc8Rux3Y-ORwVnLRuufx3ekTWiJWv4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdp
    rhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f8v7ZvNZIgQBt6Z3_nz1an2E_Y_TzhabZheyMzaEAvabxeLoZSODXQ>
    <xmx:f8v7Zs9iuIGobvQ_iISDcDz21mhlyY3rjf2C41EHOOrFiw4pemNhUA>
    <xmx:f8v7ZnWoAv5HuBQz9gJDlIOCKtEWeQKoNLyj7wr8LpxbblA86AXNfg>
    <xmx:f8v7Zldp9L7Ru4EJkEerMRkp1t-t02hf9EYNcGif5zoZ1xSg-Pz_hw>
    <xmx:f8v7ZgQ1hbP9wsQ4Tk8iaGUesZeuZmmJna__kLFosN7lsbC1GNDOJfs0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 06:14:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95030ad6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 10:13:34 +0000 (UTC)
Date: Tue, 1 Oct 2024 12:14:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Message-ID: <ZvvLeSikNpyrsDA-@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g>
 <ZvpZv_fed_su4w2-@pks.im>
 <CAP8UFD1yK0vwHYh+jVNUEV0mRnbjyDTOrRjuwjOwSCn-fngVzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1yK0vwHYh+jVNUEV0mRnbjyDTOrRjuwjOwSCn-fngVzw@mail.gmail.com>

On Mon, Sep 30, 2024 at 11:17:48AM +0200, Christian Couder wrote:
> On Mon, Sep 30, 2024 at 9:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> > I think chipping away the problems one by one is fine. But it would be
> > nice to draw something like a "big picture" of where we eventually want
> > to end up at and how all the parts connect with each other to form a
> > viable native replacement for Git LFS.
> 
> I have tried to discuss this at the Git Merge 2022 and 2024 and
> perhaps even before that. But as you know it's difficult to make
> people agree on big projects that are not backed by patches and that
> might span over several years (especially when very few people
> actually work on them and when they might have other things to work on
> too).

Certainly true, yeah. But we did have documents in the past that
outlined long-term visions in our tree, and it may help the project as a
whole to better understand the long-term vision we're headed into. And
by encouraging discussion up front we may be able to spot any weaknesses
and address them before it is too late.

Patrick
