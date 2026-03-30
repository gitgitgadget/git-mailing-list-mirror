Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF03C6616
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870818; cv=none; b=cQqA+vMRF2QoMoFifv4cL0MoeUcFwP+zM3sM5XpIyat5n2e4dx0GJRTEN2ZNlxViZtCEEdeaBGwYE+vZ1ufUbDJR0rPpOO7IjOs4WcfmsH26b9Y5LDl8/PmLC8I+Vj5fbXYet4eEK5X7EpXijYmtVoSf7F539JL7GYRpUq233CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870818; c=relaxed/simple;
	bh=I5/UD2zJ42PA0mbDjvqUONwj6zn2WrLIX/5HPe8pPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDytK7ThU3jb2SEEQ/5uyYYCoY95VB5RbZ8FFU1gahX4nlnpOtTKeDeB3mwi+Ra6lHe3969Glb7Tl+FmLQ2ltCbPyc9JPreIB+O0A+qRVFfRRVMuwUcab8AikVSJYbdnvIzkLw6VHk8zM6nwkasQCpsc5v0Nxz8zzH9fkUOOw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YCKqWzZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1QbzvUXZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YCKqWzZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1QbzvUXZ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 673487A02CD;
	Mon, 30 Mar 2026 07:40:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 30 Mar 2026 07:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774870816; x=1774957216; bh=IKzqU5xyCp
	mc+KBAPMPpdV/6QGlEloPOCnGtCCootZ4=; b=YCKqWzZcdjJxIVY0E5DKqdojVx
	DWC59G7NYEQaviaKXzDFoVNKiPPQ7AIWy7QuMXEb6Xwwz1XywI9/bc/spJ2za+VQ
	UHEBqoTr0KcUBfiTzXYDtPNO/4LrtElejfrzovRvxk0Wtj7ZxhmhSBHlvyc83RBW
	bxL/oQzprLMTwykEoJLEm+Tz+DcaXFVviZmVo0yQuwstkZZPWjOVDlOjpwZXg40j
	G0ooWbyM7pb/iYAMQJRnLyIxSCmVkmtkZJhOdelmnAC1K+EPshVBTo33MX82vUKL
	ltzMh1QoXBtIs6i/Wwu69TxaK/s/RYgx6rvR4bBbBPxhBJNnsCOof5k+Gk2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774870816; x=1774957216; bh=IKzqU5xyCpmc+KBAPMPpdV/6QGlEloPOCnG
	tCCootZ4=; b=1QbzvUXZsJzARCOP19GwlV7oDK/3F9zpAXVBJYE52iAjtxl/wWy
	kdAzPs56LidA58juPfr3RzjWCn3JPlPSjf2KgLwR4dkkKnK3gshL+RK5ngRIG57Q
	/s9ZaWuHjxfzORh0C/ErWWyHY4wboXAMo2Bho+1cZecxuEqnUmsz34DBYZRK1Xze
	lO9hWljCLR7fEc7JvyelMd/69FdijJ3wZ8t3qF+7z4Q8FP1KoRyfkPOnplAwAp4m
	NpNUkWOgWGQp9J2ThCqUAjJNfQOHcWH3lCDuvIliOZGHNZhaGtqFCVmZ5A2bZQB6
	xGmcgAUD1068hr5THzaV3stvRSQ/irLG9NQ==
X-ME-Sender: <xms:H2HKaUiT0XwDUzUnI2J2s-7CQb8tc1ZadZVdJ4PNa2ty7zb46LkpsQ>
    <xme:H2HKaT5MG8G2x2SBLJ97C92gONOwLeqXFO9S_axkR9pbS6Jsr54JqJsKJmAmdCHJv
    Vikz_1rvviD6Zch3XEavqvGDN41z_o69Yxb_AlkZ3YmpeYpwF67>
X-ME-Received: <xmr:H2HKaUa9WW8fA-lqfFyn0guDgmpzGQtXrMB_c2v10GmUFPykyquTzwcx6z7A8V9IwBBwTx0fbXPBSdU6oQfW369-k5HczEIlnD2rZBD_U-VCjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprh
    gtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:H2HKaQ6la78IKV3DVxgiAuYulGBD18w3LxpFXfIjS1qhXuXflKp2IQ>
    <xmx:IGHKafCXHblRqx7y8l66i-RhTVVkFKJqJJslP0lyz9TzLb6TD1l_Qw>
    <xmx:IGHKaeeqV50irRdNEFs7irdlecsCoI50QGZjvEMwKRBMvFdHsZqt7w>
    <xmx:IGHKaWKWDPdkMx6VKpuBpsGZAs2Rl7DgLxe3xvUK0rz5Cbe2vrscZg>
    <xmx:IGHKaYVSr0pz0EK6o1GS-53O2e-NG-bdrNTFh5sgFujQY1jP7OfX5KJV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 07:40:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 121b53f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Mar 2026 11:40:12 +0000 (UTC)
Date: Mon, 30 Mar 2026 13:40:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Paul Tarjan <paul@paultarjan.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v11 00/12] fsmonitor: implement filesystem change
 listener for Linux
Message-ID: <acphGnG9uX9C6dvx@pks.im>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
 <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
 <aakyzGksiC2fhhiD@pks.im>
 <xmqqwlyzsmq7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlyzsmq7.fsf@gitster.g>

On Wed, Mar 25, 2026 at 01:00:48PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Mar 05, 2026 at 06:55:00AM +0000, Paul Tarjan via GitGitGadget wrote:
> >> Changes since v10:
> >> 
> >>  * Reverted pre_exec_cb callback back to simple close_fd_above_stderr flag
> >>    per Junio's clarification (same as v8)
> >
> > One ask from my side: I would welcome it if you slowed down a bit with
> > sending out new versions. Sending three different versions within a
> > couple hours without any reviews in between makes me pause, as I have no
> > idea whether the current version is good to be reviewed or whether I
> > should expect another 5 rerolls.
> >
> > So please take a bit more time to work feedback into your patch series
> > before sending out the next version. It's totally fine to wait a couple
> > days between iterations.
> >
> > Also, could you please clarify whether the patch series has been written
> > by AI and if so, which parts of it are?
> >
> > Thanks!
> >
> > Patrick
> 
> The topic went totally silent after this message; is this topic
> still viable?

I didn't have the capacity recently to focus on this patch series.

Also, I think we need to be extra careful with merging this patch series
as it's written mostly by AI as far as I understood. So I don't quite
feel comfortable to ACK this series by myself, as I'm not sure to what
degree the code is understood and reasoned about by anyone.

I'm not against merging it in general, but if we want to merge it I
would like to have at least one more thorough review by somebody who
understands this area before I feel comfortable committing to it and
maintaining the code going forward.

Thanks!

Patrick
