Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAB22154F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615303; cv=none; b=V7+qliy3+7D2/CS/EzpTBWjA9zRaubPi8imf1pb6CenPUwJDtu3Zlwgxa91Oh7PawBULjia6ojGshMuZylY3ANteFyBaFblEIMkc2FMQThnI/CXKg6pTm0S0WcrcCpezBiYxoZZdtvehWsPNp9Ci9r/9pALqjwfQqhSP9CecRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615303; c=relaxed/simple;
	bh=qWS22DXiCvFYvXyBCI7aXtc/Poj4Iw1R9lH8KqCa/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE/0J7OIKO9E+wCHqxNw98mmLcgP2FNUWuJgl6Swz7PwtVTq0D7WoP5jOpStORbMYLvW/+QGKbKog4at2WKDX/MWErHZs0TLOiyZDZEMXbB6vL6IrJGtheobs5cHeUBtKqsrXFAxhM8ETRqUTTo9uc5qrb7VJFk9wrjOyabAsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oE8DxcL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n4F0lTo7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oE8DxcL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n4F0lTo7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACC507A0043;
	Tue, 23 Sep 2025 04:15:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 04:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758615300; x=1758701700; bh=+JC/uzfMJv
	mPvcbYtRomecOiQLXQSn+MrJZAcJ1kIHg=; b=oE8DxcL2WvfP7TeJcIb2oWMSyv
	+QDbBuic0swx5yrLQSMwuBK3Pi6o/9DfFZMOmzCtPyXBWs8dPwWYeCOUOO6Jqr5v
	qtrOACxgcNVbLqHJXT8lo2bikCH8DGykrzvABDieNbg9JAjabzKg+jQweAg0ctYI
	Tvn2sPSPYSaaK4URoZJEeWauQcCT6hCqRHxdE4KQo00yFrWZskFhXx0RMepSijA6
	2zvVjhh2pzynkN91bkTSA34P2KKPPV6TmLSrGztH6hYesfZ448V2T3f4jocsOihA
	2GD/0QvFGiRaCTT6A21soROtTAhcf0dg1w3sKU3H23O+yV46U84SY1UR2t5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758615300; x=1758701700; bh=+JC/uzfMJvmPvcbYtRomecOiQLXQSn+MrJZ
	AcJ1kIHg=; b=n4F0lTo7HwFwmAFXYFNIBiHisANx/KzaKOdsyT7M75bB7OZBbq+
	tlSE+zxIgJL3GqrJ7gqShalxwS7gg55tcLb/SDF7+7S3GdJ67K1670umvYeTMBFM
	dxY/TUR0MRrFblOaEQxBmNOXcsXaFLWXZ8LAxVbrZlcdEQ100rt3GagKueHzkZE3
	JerO/xssluj2BbY0J7eEIiyBAMejXN/JDmB3oWDTiDtc7CrQoi+bNHusy391/SBK
	3S6T4ko5S/z/fzYl5mJehHjLT2az3Zg/GwB+8grHUd1gILDY1ik4oT0EjZfCIRpK
	NX5l8LKyp+16ZojZ5uwoqy9f53Ajewm7Iaw==
X-ME-Sender: <xms:BFfSaIzx5_0ui0jx3judjLs3T03L87QxGH8wzITR-muz_gDRs4bpEQ>
    <xme:BFfSaDuYp0VUbvhVOwS28u1TH3Kcuq2F8UU4CsfBKpcz2r0sK9LQlbgHs1WaIQngD
    -2T-BusrC7IzYchQUdb-nhG2B-VTg8rqS3jgDbux_fRhi34SVg9>
X-ME-Received: <xmr:BFfSaHvbAvCNP9bU34iD2vy1-lST0YZJ_0Sr7dI6rlXhwwkziy48Z4lUvLQ8yEy6zSkFZ4JZse2IU1YI2zkqqG6RfnjdgQ0tTtB6aIh4H2FZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BFfSaAN5lqqTRjejLQV2agipVqUkfsoRn_LN0uZE9jkD3IN8CrSy3Q>
    <xmx:BFfSaN2z72UEoOEUmow023yU7Sn81yHftXh9MMKuiibTZSJ684lFaw>
    <xmx:BFfSaEOk9UIVYwmO_yeBZnhJZXiuwhFZm_sovBiv_UH-7y7Y7RKj0Q>
    <xmx:BFfSaF0swinndjEg-Y1DaVmjQMot49VrbPd_TnYrSTU5bAEyXqW7Pw>
    <xmx:BFfSaDu6FIms-hEe9XAdAbz9SY8IeVZo31_VXUv9d2mnYpWddTvtc4fc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 04:14:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9078732c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 08:14:58 +0000 (UTC)
Date: Tue, 23 Sep 2025 10:14:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aNJW_z-BD1eDttec@pks.im>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMp9OtXLfRw7dEwA@ArchLinux>

On Wed, Sep 17, 2025 at 05:19:54PM +0800, shejialuo wrote:
> We would return negative index to indicate exact match by converting the
> original positive index to be "-1 - index" in
> "string_list_find_insert_index", which requires callers to decode this
> information. This approach has several limitations:
> 
> 1. It prevents us from using the full range of size_t, which is
>    necessary for large string list.

I guess this is more of a theoretical concern. We probably wouldn't
handle it well when our list had 2 billion entries anyway.

> 2. Using int for indices while other parts of the codebase use size_t
>    creates signed comparison warnings when these values are compared.

Yup.

I think that the required juggling around negative indices is another
factor here. It's somewhat weird, and while existing callers all handle
this correct I think that it makes for a suboptimal interface.

> To address these limitations, change the function to return size_t for
> the index value and use a separate bool parameter to indicate whether
> the index refers to an existing entry or an insertion point.
> 
> In some cases, the callers of "string_list_find_insert_index" only need
> the index position and don't care whether an exact match is found.
> However, "get_entry_index" currently requires a non-NULL "exact_match"
> parameter, forcing these callers to declare unnecessary variables.
> Let's allow callers to pass NULL for the "exact_match" parameter when
> they don't need this information, reducing unnecessary variable
> declarations in calling code.

Makes sense.

I don't really think that my above comments need to be addressed, and
the other patches in this series look good to me. Thanks!

Patrick
