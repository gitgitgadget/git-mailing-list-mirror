Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B4215F6B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296524; cv=none; b=rDxirfSLtYdL1ibEiq1MYtshRDoK7XYUpTIANwQz8K+YCAXFmStDRIEkdWZI+vq7GlfOOkD/mkzX7pMkRGNA+8bmuT+6HHkCWb8riq3xkgmVT2qnaHX2BwAsQfIYEKPZ8n+zZveur6u5VFj9Ski6sK2iSKoFjznehV3S4dCc22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296524; c=relaxed/simple;
	bh=jFe4D8guUeEcve9InQddHxbIIgTQ00lTtxpnXyry468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTCJorJ1NFiVMGwQSxT90DEDQgwT3xlwAcncX6bmr5lPmS3sp5Ryh07XexCn/2Xpl+O404fN7SQyQ/T5hDEv1Hz0gCwbmOuzKjFamDigecLy2fnLzMeMG/5VjXTN+dpm/eM6dl8x2HXRRfKxEO/R+Nw8ORw2kMTKfTaVf+UgAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fwbdOM8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkHs9Zvd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fwbdOM8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkHs9Zvd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D41B1400031;
	Thu, 12 Mar 2026 02:22:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 02:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773296522;
	 x=1773382922; bh=k5kXuZA66dbt5s3rZ8lDqwo9m59kN8m+x02Vk6JP3ys=; b=
	fwbdOM8EVFvfJnYBktSCQ31J9hl86Uwpf9bMe8v5apeQos1YL3wnSamOS5cQX5UV
	nMS4sYeooylOYEHw6cLBlwM34UXATdK8TE7BMIVKsEOu9pEfnvw10hxXogPs/mpc
	hsIHVWXJ6DIvEvHMOP1vtp4lL7rzoQGk/y0kjEbTN61/ZdukXJN3pwTLtizlvlqV
	avEy09cbibPO+zOTGidUnK4AcJOMHil5/3TCM3czNvkEAzWmltV0R+yZvRGLs1Zu
	IoWKpYeCf+3KlOIptXEXtop9hAarc1qdD3P0gi3Cf9W3sskNHLsILgZM3AWeA+0e
	xln82eo18/Py5q9h0KhC5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773296522; x=
	1773382922; bh=k5kXuZA66dbt5s3rZ8lDqwo9m59kN8m+x02Vk6JP3ys=; b=T
	kHs9Zvd5PrDfOe/pcN69kJihsv9x4eE4t32akMhMhBah2RQc1Hu/sI2aBiZyPZB0
	VXfhd+LdJVqPzFsOY5vZMvrg4JOmM6aYMf5/wZ2FJFPjuTlWA5yIVbNZxoFAOpQA
	vIPBR+mx/smr6kVlA+M0l9I0ZiCaFVH9cW7TM8jZANhiDjIopzwoPy0lrCV2XC0S
	qXTNtJ+WNlbzsB2xxZWcMJHX1CWjx0ZFWeaK5LDPhbnQnWAfRgq2u/hQwTAlKfJw
	6PJw40lPI7kM0AzFFXb8J3OTspCeiaa8JRC+zEZtl1BpfpcoL1frP6qvqBDUEJ7/
	nWW4Uv4lE88R09Yq5HEvw==
X-ME-Sender: <xms:iluyaVAhKggvIZZVOvn5y5fd7EIhgiVombzQBrlqepmhC3Cz34yYqg>
    <xme:iluyabSSaFLN_xu4FhJYKWbdlZbPO2pC4az_IBiWIi_LIGA8WadbGwxH3pL60cnKP
    otxQl8_Df2FMqmm7GmJWujWCFkHAhv1obrJjBeUMMmznUrnaxm1rg>
X-ME-Received: <xmr:iluyaTqqpcpcKHcH5ON2eGOFpjVKUoBEP-8GjqKEv2f5o9OJDy46-tGRNsYTbv9Ng-C1PCJdQG-LKs-H5yaMTb9oEGCXiRJxnAfD3Kng7ykc-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptedtueetfeeutdeivdegvefgtdehjeejie
    ekfffhleefieehudfhkeekkeevtdevnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:iluyadwXg2OTM0N8M-bjJCeVVbpi_pUSIToZSDRtzcHtnaY9P9_sRQ>
    <xmx:iluyaYLa41phbdIG6BUPRKxk0FW27CuOT_FZo4vfGaYntTy03AoCZg>
    <xmx:iluyafKVW_jTbuvITHeWFCcpXmxad9OmvfcparFcOwn6dcnarPeNQQ>
    <xmx:iluyadtRuIzcpysRIXjAodQMEn9etzCp46XcipgedF6lRebnSU4hzg>
    <xmx:iluyaYLFPJJqqIaoompbHihD3UmDD3rAnQwHRlMqiqoaxFhdj-VkJFJr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:22:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf1cbc81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:22:00 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:21:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abJbhQwc-X0T6S_B@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
 <abH6dayn5tJBMY9p@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abH6dayn5tJBMY9p@szeder.dev>

On Thu, Mar 12, 2026 at 12:27:49AM +0100, SZEDER Gábor wrote:
> On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> > On 11/03/2026 14:32, Phillip Wood wrote:
> > > On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > > > In the next commit we're about to introduce a precompiled header for
> > > > "git-compat-util.h". The consequence of this change is that we'll
> > > > implicitly include that header for every compilation unit that uses the
> > > > precompiled headers.
> > > 
> > > Is that a meson thing? I know it defines precompiled headers on a per-
> > > target basis but does it somehow force each source file to include the
> > > precompiled header? Looking at the gcc documentation it seems like the
> > > precompiled header is only included where the original header is
> > > included.
> > 
> > Answering my own question the precompiled header is included via "-include"
> > on the commandline. This is necessary in the general case because a
> > precompiled header cannot be used once the first C token is seen.
> > 
> > As an aside in git we could probably get away without using "-include"
> > because if we include "git-compat-util.h" it is always the first thing we
> > do, or we inculde another file like "builtin.h" which immediately includes
> > "git-compat-util.h" and so it is included before the first C token is seen.
> 
> I couldn't find this in the GCC docs, but Make's documentation states
> that "you cannot include a precompiled header from inside another
> header." [1]

I think you must have confused something, because the link _does_ point
to GCC's documentation, which does contain the quote.

But yes, overall there can only be one precompiled header, and it cannot
be used after the first token indeed. The use of "-include" is also
explicitly noted for "projects not designed with precompiled headers in
mind", which fits Git. After all, we still have the ability to compile
without precompiled headers, and I don't expect that to go away.

Patrick

> [1] Second bullet point at:
>     https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
