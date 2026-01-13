Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E9366DC4
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289828; cv=none; b=IocXTLiwcmvl/tAfyq3/Fhxu+zq2sXLXXEmWwuYzQm+3TZ2fuU2IuMFfY5czEo0S98KRZzXJbqoPHTFGN94uSRPRKKHS0iTFAdqVJvyk42kALYloqPxVtgetfzN9sO3TfvhJZ96udtskIyFCqNcnCFIsho+6ECN8AdXq8S0vnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289828; c=relaxed/simple;
	bh=CDVoz8WB/LjAPCiPPsckbZeWGN9oBrF8BjEP5RZke34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxRnTwZTHSqx56x/uJFVL0wKfYb6a0dwCFmnUpZhqFGkaZGApnyvaHbGLUdc/uP6xy3VV/uQc8t8nMJQpjZm5q0UP5kccmd49wUhrsA4zHS8CySlHk6Hq/6PuoSoOlsCRThRZXk4sfXYI+VigCAPUClxlYZrIcfft1zDOpIDdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OaofXraD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cmYc1PUH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OaofXraD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmYc1PUH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 71593EC0102;
	Tue, 13 Jan 2026 02:37:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Jan 2026 02:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768289826; x=1768376226; bh=N8OxYQDUni
	ewOA4ECV+f34RQK/bPfEEfdfLlt2sxSiA=; b=OaofXraDqqqkUUO4epd68oOCR2
	G89X6FdvLPmvWu7I321WCvmYUI1Mk70qjo4MC/lP0YugzwNSUPyzCBWbtGceJqQ+
	ED9Ixb09HzSlZ8pmslZej/NUyk6UVqHWFJqI3jUzPRikF4guMeZflZKB7SHdA6ri
	7axXLHSnG1r2UOTZb+IzcyqGctaqvO4ynad7tIOgeSCIHrNmacXtc+Kftz+2l10M
	8EdFjyv48vaGk/9/RRXGZ8dZnKHi4VLWZZwsUaN8MXn+ZyIJgEwsgVmoG/mDYme9
	mw3tuwEH+p1vgkEy6ixSgpkuCGGyC/kYiPMMsvi27t9/i7fz6I4O8PohW3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768289826; x=1768376226; bh=N8OxYQDUniewOA4ECV+f34RQK/bPfEEfdfL
	lt2sxSiA=; b=cmYc1PUH6ymvgxSKdn2csQZjBzzdMVJ4TBkQQzEro11mtJxdHn8
	mGFHDf55A4H21Ky00Zj7ROvCOUWHJbJ9fBK7obrDdMQB+WJSOpR2OL+PnyPArOm/
	U/er2c+SMyx1+1S6K3wFIM7rxD/QJwORzKU4/OXHtd7p5YngpFM4NEH/5a/ujuTw
	TPV2IOMuzQYSqArhFPKCJvBKVmY7jI9u6jXDlTsz4wn8gPwubAjyVwIVIzUAmUDo
	iiSMDvVUzoko9ZoEvIQfXQ1uDYuu5q5lbaeni2m7bbqcTOsik9W0eWUt6XWhdX6S
	Gkp6q0et8uDpfQeNRpRI0GXJjk5nQZvLZ2A==
X-ME-Sender: <xms:IvZlabmk9EwY_l4QhlL6OsyWZo3WF6CKkIZdjz4H1Jrm_ssdvnaiiQ>
    <xme:IvZlaV0Z4zvA5OOfTDQK9ze1GMU-2FH8lFUYeiGpZbaLi1iS7ywhJiH1epkKmqoe9
    KiNG6Wt8AVzxtKwXdBKsS05FPG-3Kv86sr20iWPHJICoxJ63JHMLg>
X-ME-Received: <xmr:IvZlaWpoIf4Gq6zDDMzz9S9UEcxj7eCAlPWA1Mxo38pBTK_dDAHLWFCQMNFwE_RSvtpZELMeDnVHJdhCqVih9vD3B5Fz13gPZfwh3HWgsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:IvZlaSe_4D4k3ywlYKn5erb3A6B6i1K9HI2TVGPRMQpZYzX5J5U4Pw>
    <xmx:IvZlaVqjo2h0X6eK1boig4iB_b10CslGeqUIaeU7TAc-Ws8H4rE9_g>
    <xmx:IvZlaTG3_YMqB9xlw_3Ds38_8UcZOVYTbE46i9THvoPrH6iPahgzSw>
    <xmx:IvZlaVsZtAxFseFOygyCtMWGD8lyXhJoqzA3GwKZWJP_4ac1O-9riw>
    <xmx:IvZlaSJ3yYo3Oyw4CSlRXyUEpnDLFK3PML6dFFouO1t2Kt67uE93TynK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:37:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76b0bab1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:37:04 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:37:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/t5319-multi-pack-index.sh: drop early 'test_done'
Message-ID: <aWX2HSakgzcfi-CL@pks.im>
References: <cover.1768261435.git.me@ttaylorr.com>
 <9c5faa5932cdd9e570406bc85ba27f94195a4d3d.1768261435.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5faa5932cdd9e570406bc85ba27f94195a4d3d.1768261435.git.me@ttaylorr.com>

On Mon, Jan 12, 2026 at 06:45:03PM -0500, Taylor Blau wrote:
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 794f8b5ab4e..b6622849db7 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -415,8 +415,6 @@ test_expect_success 'up-to-date multi-pack-index is retained' '
>  	)
>  '
>  
> -test_done
> -
>  test_expect_success 'verify multi-pack-index success' '
>  	git multi-pack-index verify --object-dir=$objdir
>  '

Oh dear, this is embarassing.

Patrick
