Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B954652
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876187; cv=none; b=FELffzf9T6zdqHTigDrwZODxexD8IsQGCnrCaABFn8Gt8+QFTBMWQd2XBPgw3yVxMG9POtORseiLUaibGCtQRiuvOYEluCHuCD6R1VBoalF/j/QvpBGE3JSf5QKLFnwe2eRDgwHctsSEqAuCyf1ETrkaojx4DJVocbz6uMhHZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876187; c=relaxed/simple;
	bh=uvpJDGTN9QtXPpl5LYyg9plZLO2KT2fXLO3FFB3hJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUjhaBTe7+ekaLLRx2SCHQz+j2/U0CpEnrW9Kto82k5B4GjBAh+6h+m3GYNSlXP+QaWOvlaEbeOOcHyUfU7ipk2EBRXYlJoKLfdpNr2YTAlYp7P6iGC9Xq8atiB3kPzt5vTx7aP3H3wxxmwW4g+J3FFs6znW59KAEPJEx8oW/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nNEw6Qmt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwHxxUN7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nNEw6Qmt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwHxxUN7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B40D17A018B;
	Tue, 16 Dec 2025 04:09:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 16 Dec 2025 04:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765876184; x=1765962584; bh=CiVTriSYyu
	YGAJzjgvfmOwTwVBjJJnqPKZIbXxbGu6E=; b=nNEw6QmtRR/yZwgWqd336/+lN3
	Rw0/0hrUXmxmJdiNPQYhPPSB44l1dq4DD2UqeDfzDSBOIXCpXO8QcKLIdkCMjKB4
	4KkB55EbhELdCjreCRx/hGvwlnO6EvSdEICCgs3WKZeTGWfERgzE4XvXsymRcUne
	xe3veDCqILZlyJG9Ja2pQS9y8kHr7650Mjt1hTvQOgk8MXTSkzudnVr4cth422z1
	vJCGRGkDBWXGZfrHU/cUuewL1vrvo9yUaikDaUQ1NeyCA8X1WdtLWCbJFePTtRp1
	w0xHKGIRpQbLrSUsVQgV5WasQNFW07r7jSnpMLaEt5dnI7ZSlBIp/pfmgWFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765876184; x=1765962584; bh=CiVTriSYyuYGAJzjgvfmOwTwVBjJJnqPKZI
	bXxbGu6E=; b=XwHxxUN7IFqkAvtRY9oc8wldiO36T3/lqSwJvY/AAoinmE88AxL
	MbKzNsRLYEhPXE+QkOEUxJINVekYYHhMULEbJXFP5YmT/duWs/54WWnqNNb/um2T
	zHSB6piF8duyYSqyqu23M1VW+LLCDa+56XnWZ18sGwLFQTOaV11UhC/h5I2vY4jk
	20F9b5x0F/egIb5RusoxMj8X77/M0V39OK/0KSuOK6cNwLDKVh1kyHnQXIssL0Js
	ymh0QJ30anPe8a7dSM7ELItogHZOozW7cXmtm1UYBS25cTe+VMQflFdrQ+BaKQQP
	KoRHEUHrdn5y7gc4rGjJqHA/XnL4x0sB1uQ==
X-ME-Sender: <xms:2CFBad3qmMBxvLqxacCxWxzj5feVddzr1QX1Yi_ar8gcy1U7dANPxg>
    <xme:2CFBacSeTFA9KHAElWBiRuA4NkTQeKh3Em9FlDif_YLOR8zIiVeGjae-XX-rA-th6
    ARVtJzVG1FkZ84hcMhq5VIDbEMq0svZfNXsEJ1cHOVIEzvOjV-ltQ>
X-ME-Received: <xmr:2CFBaZdzbuW49BrOIlhnH-cVeZEZtdgv22J844LHJKvRAci9HR6AARX1fzQEnB49lFIsVoSTQQq3N6jWy3dB4Daw-waS7XYjizsYEgMS0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvmhhilhihshhhrghffhgvrh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2CFBaVdnjc-4yfEWq4y_uekrIvCtEo_ABeQfgaNRk4mxJXEXGfHdMA>
    <xmx:2CFBab1tjxe26RSN3P68p0V1COpLJTfX7UkF4p5CMB81xkI-_52FPQ>
    <xmx:2CFBaV9ayutx7gDJS2aWB2DcBTxEJIk4iBTT01kESwLNXaqtuCfm4Q>
    <xmx:2CFBaY7vuLMvmEejgIaXGniimHHFHwXU6zEo5epY47EtZLdtd-hlvA>
    <xmx:2CFBaSVbxLIPl2um3U2AigIXZymUsx8RkrEt2MqMcBr7_YC3MPAqK0ec>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:09:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84f7dd04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:09:41 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:09:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 02/10] submodule: always validate gitdirs inside
 submodule_name_to_gitdir
Message-ID: <aUEh0tqUra-Y_yZd@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-3-adrian.ratiu@collabora.com>

On Sat, Dec 13, 2025 at 10:08:08AM +0200, Adrian Ratiu wrote:
> Move the ad-hoc validation checks sprinkled across the source tree,
> after calling submodule_name_to_gitdir() into the function proper,
> which now always validates the gitdir before returning it.
> 
> This simplifies the API and helps to:
> 1. Avoid redundant validation calls after submodule_name_to_gitdir().
> 2. Avoid the risk of callers forgetting to validate.
> 3. Ensure gitdir paths provided by users via configs are always valid
>    (config gitdir paths are added in a subsequent commit).
> 
> The validation function can still be called as many times as needed
> outside submodule_name_to_gitdir(), for example we keep two calls
> which are still required, to avoid parallel clone races by re-running
> the validation in builtin/submodule-helper.c.

Yup, this looks obviously correct now as the sites where we remove calls
to `validate_submodule_git_dir()` are all sites where we call
`submodule_name_to_gitdir()` immediately before.

Patrick
