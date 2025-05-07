Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15662144CD
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601612; cv=none; b=UkQ43hSamTcsgBmkM6us2AyUEKgnJf/LQntGB7DyHevouPIwUgXQt+MLRSKPyeKileVo6m4/j9v/zT7hVUKmtqguLHIOvwgjBigE1gFxHPDeiYEDF/FQKaRxuXO3RoxM2Z8NOf8SLCoKVRGmug9z0Vfl6jCJ3hNdW99sSABSRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601612; c=relaxed/simple;
	bh=5VDwoye0sUndFuFB0Oy09gfPp/0y6emMkguKiU3Z21E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTJfuCpcBjs5F1d3Bxvoo+Ttty43qJUfiXi7gapm8xc5f6sTsgyQpEHKgPNzO8GlwMDFEKhBUG654WDacrJtJDI5NeqMogfQGed/1qA2ROlXw/qBH/ydIVUltbn/B4E5X+axLqyx5F4BAXs8aKsd+2c5FboqiqSFoJKvWa+9d78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ahPanOjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyg/loTO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ahPanOjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyg/loTO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDDEA25400F3;
	Wed,  7 May 2025 03:06:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 07 May 2025 03:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746601609;
	 x=1746688009; bh=uRTgc0LwFO4cuiune9uOo8Q7ctoZ84VVYH/v/DK9PBc=; b=
	ahPanOjkyT3vw4WsONeH3jjsTEfAWj5G5Ez+9ULunZaQ/nLQCyPmYat5NIRmLArj
	cBG0bl6tF2MYQcFFJTm8Rz0JxalRJknsjYLOSKEsrW0moo1enPCWsMHqnn7p/6Ev
	HSTXqnWTCB5LD1nCMHNLdvtEw7nayE9NkiUdKpQF4D5QohaqR+T1h7KDUkndHrcC
	tXLLCcf7CQcBRk24mmT9XyYeLOekTlwyRzngwKqVT5qPOUYaNY6posnewgIN6qjk
	bWgvWanPl2TdV4D5vPrswow8VSx96EcFYMbvJiB3F5v7gWdZOkpCxEWTJoh4PNTm
	a8ChNru5KCZOSJtlAR3lLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746601609; x=
	1746688009; bh=uRTgc0LwFO4cuiune9uOo8Q7ctoZ84VVYH/v/DK9PBc=; b=d
	yg/loTODUHjPKgpT56J5YXxlRHV0I3TCCIbaEMeqf172f0HQ1BnI+Lalq8Hjo0P0
	1QONRJ90/9vRh+eccEpY4zUXjp7zc1XpdY+wpAlGiWqNiCFNJwI2+w+Zl1K9OroQ
	8JuDm6dYbt72iJVIqvPuuBNJ3imz6E25lCCyPuvYdJ4ZgD9HR5C9p0SNeV1DpcqP
	kmswSpSl1SDmp3gytsTwpCEELnKN8/poKVdyMrQSKAntryRGkCwb2hXn47+1Glzx
	lk8pPtQP6qFGsR5VQ4PiOX/WI8gKG3QrdyktgZg0MdtbteKgfz4SwHhttZZ8ZjrH
	uGgoxItXkGfljN6jDQLYw==
X-ME-Sender: <xms:iQYbaC4o4lpVFcEtETDeb-rFV6MiYERv6fUHbvsYL8QpN59nxiowmA>
    <xme:iQYbaL6LwhjIQbdzrhVyErAPTVm6F7ySGBmFBMSU2qv3lea9jg9Z4VJcMF1fjqswN
    wO3dLgmzc2fQghPUQ>
X-ME-Received: <xmr:iQYbaBeM6uLFjLr__0HBfc_QqXpnPkXc4ytk_TT89ykHJ_NHVU25oyp5vRAcAOX1zLDf9jjaLZ_VISJ9nQCG9EQwXfmIHjN2qol33RnZyXubjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iQYbaPK70bPE6H_o7ey2QQSO7-YyH3JtxIgFLIU0tD8UHMcWhc1UfA>
    <xmx:iQYbaGI2hFrmbbPrEueOZAjS34Z0vAeRTv6b4c_oDZ3djgY25U8sWA>
    <xmx:iQYbaAzQZfLcJqW0-nbTA_dZTK8mbHTrtrpklFntruuAN-iThVt8bA>
    <xmx:iQYbaKLu8VMTiGtyrzpHP0rR2IetqMDLtV5XHKrH6Yj371eR9cuNZQ>
    <xmx:iQYbaJVPbm3FOh0Zcia-LvsEPTh2aJSR0NdOuTB4HqyAFimHLg92Q-i5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:06:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 821b7c48 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:06:45 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/7] builtin/gc: remove global variables where it
 trivial to do
Message-ID: <aBsGhpiLaYA8M351@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
 <20250505-pks-maintenance-missing-tasks-v4-2-141f4df906a1@pks.im>
 <CAP8UFD2BDv=kp7W6w=J00iRAj-Jqz_EjHGfH_YpNTEWC2a82QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2BDv=kp7W6w=J00iRAj-Jqz_EjHGfH_YpNTEWC2a82QA@mail.gmail.com>

On Tue, May 06, 2025 at 09:44:03AM +0200, Christian Couder wrote:
> On Mon, May 5, 2025 at 10:52 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > We use a couple of global variables to assemble command line arguments
> > for subprocesses we execute in git-gc(1). All of these variables except
> > the one for git-repack(1) are only used in a single place though, so
> > they don't really add anything but confusion.
> >
> > Remove those variables.
> 
> About the commit message it seems to me that it's missing "is", so maybe:
> 
> "builtin/gc: remove global variables where it's trivial to do"
> 
> or just:
> 
> "builtin/gc: remove global variables where trivial to do"
> 
> ?

Ah, indeed.

Patrick
