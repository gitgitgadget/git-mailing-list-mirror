Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB129B76F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914414; cv=none; b=o0lesY2naLQPCpaS9D3Cx+zjWk6ADC+SpfWSK4kV6GqH5G+xrsHeGXZcxlk2Tuy7DnDwjmVkxzCpJ6g7iV6/ApfJZ8Gwqpd22W52g7xPGSXFzHQxvtybwXd7B0ZNr71YFqIvdysnoD4v2bALEvD818eFlAqNnawaZaweAOr7+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914414; c=relaxed/simple;
	bh=4ep6CHok0noF4HdmaNWhCVu7OAq2zreGwPaJ6sCYJJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqt6WI9ctZJTqvPIxLbua5H/PEDeWlodl90K3JdljlngOMG3qdkJKBHRzGKCWYl9g9coysZXsyY77kwuSefFTsWt9U90mvU71bubUJ7TuZCTNIPFGFGV2ZVYhhgj8jPp3ZjDZWHzQIzBzqh4EN9/RkBB+CGTdfKOuk3g4f2iOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z1hDc1jQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJHfPmWB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z1hDc1jQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJHfPmWB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3B5F140019B;
	Tue, 24 Feb 2026 01:26:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 01:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771914411; x=1772000811; bh=0u7eApjV/F
	lPPhdAvqubWxL61AlvOOmQbRSfJxSkFJw=; b=Z1hDc1jQ8vcGxeTKvfBjl7myGZ
	qjAkug8ngBov+CvPzvlr5UynT0jFouqG7yqmdTb7SBJIfkbqB/GwBqUNsixU12Xx
	4bjj/FN3ODIUc32AgD3EOLm5f3KF9Ynlm6eK09AWqNN8+n94TKk4fLQU+bPN23Hc
	oteczsLa4w6sbWebTqLzhUE0ITl2H4+F+dUPtdjrzYz6jHXvHb4RL89eF/2W3L1z
	Lo0Qry0Cj3qhZkOJOPcj+uz6NrJbxzGwEd6EkofMda1dI83FL/09NdV9F8J2zBM2
	rM5WVxL2htAqI+IWvpQDbnhiiIy8gL44a+ntDkzcTBYAGDd0WPYYpBnGv+ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771914411; x=1772000811; bh=0u7eApjV/FlPPhdAvqubWxL61AlvOOmQbRS
	fJxSkFJw=; b=MJHfPmWBAE5KklQDOeq4GXx0azlGaxSrgv8O6yk/xKpqH7NWYNh
	JngWlrFXcapqYDYfcknadK94Dh5PLrlp3jLrWLuZqwXJxvx9JIqm+looGeHSHRn0
	EjbWpTzGpHxkSdBf0FrNYfu8VQCD3Kd7qa64c5l501RlWcwbGz1gGRodI38pGSHU
	kxzrVlQG587vr/0tgzXztoSc1+718voo7m9+uZVvQ9Iuu2qBGpV/PNVKbutG/IPu
	7qybLDnofnM2TAKBx6DLOpTUB0XClmPx5QIJKvswbpZJ7JcZrBdyWi1cwwSYLINX
	qep7hS43GEcSuQGo4TXDtquQtd8671OCuaQ==
X-ME-Sender: <xms:q0SdafiFMcDeESDgyMznHM-7wA_IFi_5z-bAk0T2qw1jgwVhUr_hwA>
    <xme:q0SdaTCbQUdoe54Gb4x_IKo4W3S2VQawzZEYXqekjMC_x7FYcwcBC6TUN-35PitiZ
    Uyliey3Kbmv_Y99_nkTa2BpvzLbS8YaM317psIWc8TgFdMxOdeb-ow>
X-ME-Received: <xmr:q0SdaUFBhma3rPq7gcJ3t5tlxh2HMZ6KxgOTY1Ksk_1DvBWwj1ItriYJM2o0unyZ8sd14yPDFsr5HsIT010Ykp41ktCtFgsooLFFCrdx9goyeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q0SdabI81qTHqza_2tYXIkhiQuKhm2UidVTlQ-do4Y16N8_SLU_GDg>
    <xmx:q0SdaYn5GKesvJmfy9TCydL298bt0dtEF_AgaYHjuHGst4IiXFYF7g>
    <xmx:q0SdaTSjtbwCFNpKJkdyL4IrlU_aEIUVogegf63t30WVrVDbdhSkZQ>
    <xmx:q0SdaaJI0p3Vm74AVSd0P1bp_iT8KbfoAaKQTF_xUEqhe-TjYa9srg>
    <xmx:q0SdaUnJ47jZ6HC2KqDRu2C4i25Yv0LWM799iBjuQ_bYcIpeDdAbt6sn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 01:26:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24f107b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 06:26:48 +0000 (UTC)
Date: Tue, 24 Feb 2026 07:26:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
Message-ID: <aZ1EpbaPfILWFbcT@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
 <xmqqsearkxjv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsearkxjv.fsf@gitster.g>

On Mon, Feb 23, 2026 at 12:35:48PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Fix this bug by creating the object stream for the packed object
> > directly via `packfile_read_object_stream()`. Add a test that would have
> > caused the infinite loop.
> 
> Curious that we have a completely different test.  I've locally
> applied (without committing or amending) t1050 update from brian's
> patch and with this series, fsck there does not seem to get stuck.
> Of course, the new test added here doesn't either ;-).

Yeah, the fact that the test in t1050 hit the bug was pure coincidence,
and I wanted to have something a bit more reliable that also allowed
myself to prove what exact circumstances cause this to fail.

Patrick
