Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CB158A36
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296305; cv=none; b=I0PL0haN4w64aAtq7CHY7BQ6g3iEIPwhDTSpGRxgkfiYDgfdqfQVjholSKcPugWzfGpgyAFrUTNjCRc1ahiETYxTvogzvzQjJ70qbXU0W1EtiwVq6msbBn4IBwOdpHhIDdkeK+4nALU/cm+toKD7S6750Vavozibkukn42U4QGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296305; c=relaxed/simple;
	bh=zIK2nfaX0ft6ulAl5ZIAfakAdS7A5wcx/bnFKyggsjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghqOxAsdk0cMgzH+ayg2YJzmv/45NTen3YozcA/w7z4tUR8s8DrFuewpYCMqQay7+HjoAMFe01MDc/70YkuV3//Ma/RXY4gTu7kCMqhdN8GZXEbpyPHqjeMtJmnv9sgTJHaipdZnAQsNVdUEmRDFPHHvktEEY1ra6dynzOtUVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tKOpWs0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZr9r2D3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tKOpWs0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZr9r2D3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C2C911400DD;
	Mon,  7 Oct 2024 06:18:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 06:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728296303;
	 x=1728382703; bh=dISM581ncLoyKhwm/2DeVBvsKrPgeC/umx664EChD9E=; b=
	tKOpWs0FQAGYGypB7OGEwLBOTmbw2s7s7jPPUtoSv3U2KuzijgJwSIgCmRxqofDk
	pEQVdRtISDWewrCWsTc7NThsJzEtbvkDuxsSF/PqyG/do9MZl1kUJlUxAl0e3EMx
	2ykykY57yvHjPR9TsEpxwAUebPFktXvwAzoy6yAnUdKyga2xnwOgLOEx76bGYMGV
	qvfxZSXj6ou7iShMhnuDIcI5KwB2Tp6uxzY/J6mz0iN1qah/hVyoIbjTrkMzvZM2
	D5RWK8Ij9JRwX3TxGV7g0uo4Vzy2UmjPK8HclujckXuVmKYrhRiyM+tQ9m2RkafI
	I+Nuuify39YkQWpg3ju/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728296303; x=
	1728382703; bh=dISM581ncLoyKhwm/2DeVBvsKrPgeC/umx664EChD9E=; b=J
	Zr9r2D3zlRcT8iTg+SGpJHVttNCG+MHm78ZGLdu6mlcakXc1tp7Es+pNGkKDFQW4
	X7SD+iyS1AeK7VWAHNltqBsH4OJPODHgxiBrXOM0YZ1vjX6YGYcQW+psqvbj+HsL
	EOIMetwXdORV2gkzdBDd65cjcf2rgyE7aWG/ke8g5a5Rs+yPZqfyWnOAYO+3L1iS
	W/hGVKh4G6498p9BQ2IMdtZt5bS1Gof9nwJMrOE+oVC4ilL8p6VNNZTBSETf1DEu
	VjC+FND0hx42bQhwU1CFs1sWEYVpCHHdBfR8Z3swnjbzNdszlfPeRhuy7/bjtU7g
	uwrwttAubZE6nbGlEdA0Q==
X-ME-Sender: <xms:brUDZ0yEbPiCW3bdLCgbXuBBzX5kf3pWPd0S_NQLFzXNy12ZChn_yA>
    <xme:brUDZ4S4FmuaPQP8BcXwsQvSeGfZwQnu4r4EU-6ZzclXfHAp5WKOGyK658UFvbufA
    KKWz2xi9sfMY0i8Qg>
X-ME-Received: <xmr:brUDZ2WAg4vW3YYm5bHi0ZYVeUh7gbszg0BPgDExqbo7ueVp0u7Q660IW8yUovs_JzUBN3FFZAvN4qKSWpy3vvPPbcWXhW34Uledgl9ZZoBS361PDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:brUDZyjVV8Tu1at5WHwFyrHu0-xVfLOH-tr6CPOaGR7RgjWMocnmGQ>
    <xmx:brUDZ2B2C_DkIRYfKuGLAzld-szdLEXSGRsjav08uKZcRvz1QF0RSA>
    <xmx:brUDZzJDomLz-c-7ZDvGm-LWnHhc19VZ-6UfTu2hpMtG0bZXEAYJmA>
    <xmx:brUDZ9AZK4h3aocS9-13QxpgY5rNTdSKndTA51OUJA9n3c0wpbq-8g>
    <xmx:b7UDZ58SmJKOZIBhPBF2z-LbpBsvtBgpThhFgId9aGCax-ELtoeiy5Sc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:18:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd192f34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:17:23 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:18:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
Message-ID: <ZwO1a6MrO45zGNUg@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
 <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
 <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>

On Thu, Oct 03, 2024 at 04:15:50PM +0100, Phillip Wood wrote:
> On 02/10/2024 22:43, Eric Sunshine wrote:
> > On Wed, Oct 2, 2024 at 11:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > Two of our tests in t3404 use indented HERE docs where leading tabs on
> > > some of the lines are actually relevant. The tabs do get removed though,
> > > and we try to fix this up by using sed(1) to replace leading tabs in the
> > > actual output, as well. But on macOS 10.15 this doesn't work as expected
> > > and we somehow keep the tabs around in the actual output.
> > 
> > I presume this nebulous explanation is due to the fact that the reason
> > why macOS 10.15 exhibits this anomalous behavior is not yet known?
> 
> I suspect that the problem is that we use "\t" which is non-standard rather
> than a literal tab character in the sed expression.

Ah, that makes sense.

> > Although this works, the problem with this change (and its sibling
> > later in the patch) is that someday someone is going to come along
> > (say, for instance, a GSoC applicant doing a microproject) who submits
> > a patch to (re-)"modernize" this test by using `<<-` to (re-)indent
> > the heredoc body. A better approach would probably be to retain `<<-`
> > and use q_to_tab():
> > 
> >      q_to_tab >expect <<-\EOF &&
> >      Qrefs/heads/first
> >      Q...
> >      Qrefs/heads/third
> >      EOF
> 
> I agree that using q_to_tab is a better approach here.
> 
> These first few patches all look like useful fixes in their own right. I
> might be worth splitting them out into a separate series so they can
> progress independently of the build system changes.

Yeah, I'm certainly happy to split these out into a separate series. For
now I'll keep things in one, but will do so depending on how this series
progresses.

Patrick
