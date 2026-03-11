Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AE4A33
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237222; cv=none; b=bjgQwVpEvpFDbNxmneXqUZdpwT6I9YWIu0koi9SJR82KXlB1t3KewoWsi7LGWi+uQkxIJWeksRKtM4HrsTfLjgzlf2xTP+BYlFaHtrogtu/1HdraMJkF09/TVRIuuO3EM1KfL47VISWs64ajzaZnaMAKbUR46lzqlKzqHDXw6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237222; c=relaxed/simple;
	bh=RisrU4zsi+IdLHvfhdPojrM9cUWKs/hFAc4Xrnw5IMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtaOh9J1hMli+ktzYdNbEVNeX33EcH3MdxNnZR7zer5hvWEOpo6ZBYdBiohY3uZxQuN6iKgzgKep79zLCl5aw9Te/eqzu7eugZ2L8f9wBp+p8md1UyjzUv+KMefy+/2FWWlsE5cN2HTLxEJFL/YYuF/FqEkxqZHPrCKvXup8yeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y76D/9+f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ti7or2wK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y76D/9+f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ti7or2wK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBFFB7A0114;
	Wed, 11 Mar 2026 09:53:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Mar 2026 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773237216; x=1773323616; bh=nPIIeUliNR
	iYj6yDmzY9uidMKS1OF5z7Vkxurnk8Qak=; b=Y76D/9+fuhYC3BWe/p6O7zq2hx
	KVrbjl6/OaHetIN7kfXHpeZNyz3XiRPVpZW5phF6TL+IH9HnfgYZwivBVEJEkBiK
	BhvS/oG6Bhw/0/03JFzq2VIJtgb959TIcCXD8+qPmqTlFLV4kf3FFeZV0WcEWSJ1
	T1fe2O4kVKk86ikpDwf4eGqivXG+ShtX7uRflnJbvM8Msw89M0x7TrNToJ6bfC5J
	7ZJOx+79m/7/AaXu0Q0pLRXeNfMkBWjZ03qTuOEK9MgJqVs/srmFPLsgV30TIX/T
	9ldL6415q5jl5eMaFgKxbmKRzKZXI0IvE4Fgb1AyYuotBQL4VLMhdcZ+JpOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773237216; x=1773323616; bh=nPIIeUliNRiYj6yDmzY9uidMKS1OF5z7Vkx
	urnk8Qak=; b=ti7or2wKy2vlPE5YyPyBSLEY4R3k2Cy/TgmG5tFYkgbqvxZqqQU
	xsueLrH9vB/EnNONpKv18zm+a2BMe+yVfH031O37NtUX3SLFxSoNdo6SjOJpqlBp
	zJzrtIQTWJ8lKHkoLOekOWnB0whCtSGcl3CaA1XHu6n6A9JN0McfznFHpa5EoHyY
	NYdChS0QlQ91MFRrDL6BNFddTU13/oFLJ9Yqz5dygmkqgtqDiCPFDUeheXEj+8jv
	acvdkM7XfSZ9MtoD/wfYMhM5U7eH1F560c1HgWkq66/yRkt2Il2htE8X1tsBW0Rl
	heQ3TiOOry2HcEbcSC9NrjMH+NOmr4WtSsA==
X-ME-Sender: <xms:4HOxaU7HL02H6mS7JAMyJ7-eXIoX6nGgAhR2M995V0XRgRl-arMIrA>
    <xme:4HOxaczWfEXLXiQ6nOiWCOjhpyw3_Oix2QkoH4TzLnP4kA4nIWL4ToWhiMxDfqM-d
    tg3u09o0DH8PjNBaFXONDMceCd8SkIDlJeiuYatJqAtRchj087pvA>
X-ME-Received: <xmr:4HOxabxPRU4Rl9Lj5stuaTZyGnNYVVrLHRAKUTT7eZlj8m7JJ-SbCXGrVKZlxDwD_iqHaqSZfNDUlUifG_xQMC6CCB5s6h0n15KJx09Mpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomh
X-ME-Proxy: <xmx:4HOxaUwFF6iTHjNYopWx_3WqDfdpuo64TQ2k70e88gBFTT8DvC2xnw>
    <xmx:4HOxaVZGtT-hB4FQU1oiHPymW36LiefR424mKqLNKmrHw4GBl2Ds8A>
    <xmx:4HOxaVWQpGzQfUZJ8JCtK7C4d8YCscKKd9B4Oi5OMyRNN9pfRXf-6g>
    <xmx:4HOxaTgaUzZFDIh1oq4LjfEk7xWl1tUbZjDy2L_oll4c8HMZxhqoHw>
    <xmx:4HOxaamKk7JQbiF9EXzC5Y0W8iLegkgsQIxUnBYRK1XC6WhOoc4i3Hvm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 09:53:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecc0aa0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 13:53:33 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:53:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/10] hook: show disabled hooks in "git hook list"
Message-ID: <abFz2sav7FLv8hOG@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-11-adrian.ratiu@collabora.com>
 <abFC6pEEmicjG6a9@pks.im>
 <87eclqa70x.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eclqa70x.fsf@collabora.com>

On Wed, Mar 11, 2026 at 02:24:14PM +0200, Adrian Ratiu wrote:
> On Wed, 11 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Mar 09, 2026 at 02:54:16AM +0200, Adrian Ratiu wrote:
> >> diff --git a/builtin/hook.c b/builtin/hook.c
> >> index c806640361..ff446948fa 100644
> >> --- a/builtin/hook.c
> >> +++ b/builtin/hook.c
> >> @@ -72,16 +72,20 @@ static int list(int argc, const char **argv, const char *prefix,
> >>  		case HOOK_TRADITIONAL:
> >>  			printf("%s%c", _("hook from hookdir"), line_terminator);
> >>  			break;
> >> -		case HOOK_CONFIGURED:
> >> -			if (show_scope)
> >> -				printf("%s (%s)%c",
> >> -				       h->u.configured.friendly_name,
> >> -				       config_scope_name(h->u.configured.scope),
> >> +		case HOOK_CONFIGURED: {
> >> +			const char *name = h->u.configured.friendly_name;
> >> +			const char *scope = show_scope ?
> >> +				config_scope_name(h->u.configured.scope) : NULL;
> >> +			if (scope)
> >> +				printf("%s (%s%s)%c", name, scope,
> >> +				       h->u.configured.disabled ? ", disabled" : "",
> >>  				       line_terminator);
> >> +			else if (h->u.configured.disabled)
> >> +				printf("%s (disabled)%c", name, line_terminator);
> >>  			else
> >> -				printf("%s%c", h->u.configured.friendly_name,
> >> -				       line_terminator);
> >> +				printf("%s%c", name, line_terminator);
> >>  			break;
> >> +		}
> >>  		default:
> >>  			BUG("unknown hook kind");
> >>  		}
> >
> > Hm. This starts to feel less and less like an interface that can easily
> > be parsed by a machine, even with "-z". I guess this partly comes from
> > our insistence to reinvent the wheel in Git instead of just using
> > something like JSON :/
> 
> Yes, I agree, a structured output format like JSON would be ideal in
> this case.
> 
> Please see my previous patch suggestion of mirroring the existing git
> config --show-scope by using tab separated prefixes. Maybe we could do
> that here as well.

Yeah, I think doing it similarly makes sense.

Patrick
