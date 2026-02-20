Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE83101A8
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577509; cv=none; b=JvGVNAat97jnaOfvyR9GSJCWIpU2XmCbNc1aZnzwjqE/EbxnqGpAF93lKEjJUU5q2H8NL2XTQstSpSo3nI4GBW/9qVFSnCEbE2tnwtvIXEz7n/b+RlY1amhFX5WQwuSmlU3ef4uv3beSQ8hyvTw/atJPwADkj0d0FBkIsuQb8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577509; c=relaxed/simple;
	bh=hCHWn6E6xWkUUpfey0v/boHSupCwT55mCXOZStgjtVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXDfjHjBVJEzS5NVPfVdRnleoegbHLErp1DSo6sMekttQc7rOORLqx43H6ojZGP4Qz2PqFKqUVT8BV7eXoHxC3zS7mTGaApbXDvzxbs9NUngnomsc4dljgooQOoA9fFoI2qoDongoFn2y7AfQxe5jCzkIicrJ3ZHvZM+ttnrU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhxzEUcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3Nx1ac7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhxzEUcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3Nx1ac7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F41CB1D0002E;
	Fri, 20 Feb 2026 03:51:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 03:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771577506; x=1771663906; bh=hfjMjHUVb8
	HVzrkVXtgyl3KGcCnucvgH1Y165+hQX2M=; b=ZhxzEUcbe0MFvVeFpyXhJe0UTV
	EDEOqy2rMSM1unkNavYhjXJapRvP2pEd0aVtKBUXytTXltdyxD02+Ml9G74J4osB
	JyzlvFiGQbEiyc1bEukNW6dbm66PrJ/k2S3YupIzd6oZftij0l/asHC099dgnsMI
	OmQyAzjfpLUMJ/BW/ulIN66b73tYom/2zKYrcFFn6BpZqa5/Z+IJmXicu8ze0CGT
	IOXN6sowKl5sQnTSGre2+9jewc0ledfBbLsNMwg+FpuTEgqObeqLnvEONCINKJip
	O6x4cq+DOCLK9f5AWuL4wx8bfhQyByJ8dvBsYIYGmj/CmyFiQnjCq2YetGPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771577506; x=1771663906; bh=hfjMjHUVb8HVzrkVXtgyl3KGcCnucvgH1Y1
	65+hQX2M=; b=c3Nx1ac7lZ1jRFQSXA+P8Gb312Kjj3Jha4j4+kIVCy1KQHIpVX9
	O6leEQnVldFKuYtaqAqQ/PEJESykTKPdukp6zPZ+ymO2p2gBjxde2nMkThm6mUh2
	dKAxOYIKEqOGQDdCb3fx0uDKMV+4lsG1dBryOFhyrsN1ZlTz2OCWaYHOM3QVwp1W
	Wn2D9uh+QWxM3OZ6o9Vx3k2HcagEyGAYIt/pJkrW+uqB5qILBLEaaYRbbefkrilN
	Cuv2amaDMPgEeSlKOjhH8t06/WMbdnRwGi+h8nRRKfOzJrAJrVCZXKeUe5bWl5NU
	5D24wbJryvmwavnkbOvmUpXFCdWaWx0BBlw==
X-ME-Sender: <xms:oiCYaR9RWqNziYE0fm2RvddXYbAvdagbCp7eQhcPk2OONpYztn5vcQ>
    <xme:oiCYaZalW1Qs__lhkBZtM6OJbiRLJ8tNlm7NEQeJF9aq-OW02E_zZ1vy6yFqWpbkg
    qXdCUvbMIV2Z25lL48Gxj459ffJxlM61yrholRzySkSxf8T1CQq6Rk>
X-ME-Received: <xmr:oiCYaY2f1URIcIy9X88Iq57IGVdIup--h4QTx6Vqf-Wx6L4PSMhRkcuB9Pi4F2gaJ38fD9DP1PxroZRvw2EeB4Fx3JY8k90sZJsjPLQgav8V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrnhhivghlseguuggsvggtkhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oiCYacYMN3wglllHyj2tZ9j4mGuAmlHgTwFNIGNVmVA1OZJsZYFTqw>
    <xmx:oiCYaYIj6Dki2hwSWvgxAb2TXklSPpOix5QbkKPb3GTcT9VZrUPLwg>
    <xmx:oiCYaTEJxj5bPxmVPSYeTiNHwieZyYDYzos_6tduXeEoHQ5ytNguSg>
    <xmx:oiCYaXtmyKtYqEKSzy5A-QZtMryABDxUyHZooP8LBg42LmyWWSuvVg>
    <xmx:oiCYaauS1cmidNE1S4Nxmd9sM1RSUhAbdGbsav7EyYuVJlKvejPNzEsM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:51:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97dc8fc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:51:43 +0000 (UTC)
Date: Fri, 20 Feb 2026 09:51:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	"Daniel D. Beck" <daniel@ddbeck.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
Message-ID: <aZggm7R-4VohiCYm@pks.im>
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
 <aZb2acEvAtNmt-4j@pks.im>
 <xmqq4inc5zlt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4inc5zlt.fsf@gitster.g>

On Thu, Feb 19, 2026 at 10:59:10AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Feb 18, 2026 at 07:32:39PM +0000, Daniel D. Beck via GitGitGadget wrote:
> >> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> >> index fcba46ee9e..e15cbc51f2 100644
> >> --- a/Documentation/fetch-options.adoc
> >> +++ b/Documentation/fetch-options.adoc
> >> @@ -234,6 +234,8 @@ endif::git-pull[]
> >>  `--jobs=<n>`::
> >>  	Parallelize all forms of fetching up to _<n>_ jobs at a time.
> >>  +
> >> +A value of 0 will use some reasonable default.
> >
> > Can't we do better though than saying "some reasonable default"? As a
> > user I would wonder what this is even supposed to mean. True, we don't
> > do so either in the documentation of "fetch.parallel". But arguably, we
> > should update both sites to reflect the status quo.
> >
> > Going into the code we seem to fall back to `online_cpus()`. So should
> > we document this accordingly?
> 
> I do not have time to dig this out myself from ancient discussion
> threads, but we probably had the same discussion when "git config
> --help" described the fetch.parallel with exactly the same phrasing
> and decided to leave the exact implementation detail out of the
> end-user facing documentation.

Doesn't look like it. The thread in question is [1], and neither the
commit message nor the discussion around the patch mentioned why we
don't document what the reasonable default is.

Dscho, do you remember by chance why you decided to not be more specific
here?

Thanks!

Patrick

[1]: <pull.369.git.gitgitgadget@gmail.com>
