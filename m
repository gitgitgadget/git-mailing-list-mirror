Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FE27FD75
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774416371; cv=none; b=RKeWluqGcnNhq5IcJYu8gWOMVWjgAda7/PQ+Dg4Blr3NwgwUXRhVlxGumagq8Tv/E4O+ywaRV0mtEu2MkBzv1y9n0qHVHJApZr7IlH1Aa4+ObWoFiCOgpVYKsYd+9sIvONg1XpQqW1ZFLHhnr0fHLbSU7PswRmgBU2+amsyJUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774416371; c=relaxed/simple;
	bh=cfaWBgFFPbhW1jT9eIlcBkdKO/C/MsHGuZeFsRkUodM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWKPdnntFLRqYYRmTPmorz8m2DOq3WAp7XzqgsxCbaJ6sUchhM9vuTWjdXMfEih1J9sXuQ4cixk2+jGHRrdpZ3M3gxEtO37+ZK1u89wXtOW96f083MNxQYBxW0r+PuVFfC9gC/G8uppRmbh2lGw3ZLU9nIavrtHSp+sliUVh0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MvlZ+I3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKIVL93W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MvlZ+I3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKIVL93W"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB4871400221;
	Wed, 25 Mar 2026 01:26:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 01:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774416368; x=1774502768; bh=WRO7NTBEWK
	eqOZB/72PUnF3NFlapKR8O88Vas8UpyDo=; b=MvlZ+I3SNTP05Klemyf2gY0Xq/
	Eoka5G41800Uiyfh+4ZgixgyUofFfSIMeb/Ad2Q+6YnVzDRCZGMw846qz8HD7PKP
	xPDHnABEIfJmJrns/wgSPVFSnTJnwCib530vQrEXGJ75pEnO7BU97FRBlUHwtBO2
	E3Hhz5YquK2nVBaiFWMVuhIrGjhSaynykQmBI/DiBZCKTCYhDaY+5UCwdx5nuqw5
	dd0kQ07ZUymo+0cQ1pg/4PsIZZsBH2HHQockpgZ5d0tYfx951EdoiX5kr/09YTlJ
	sU6w9G4Myf+koWdYvWVmp9kpEMkcnxfw+TBlYsy5FaJ+LOua1bzPsJFz4gPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774416368; x=1774502768; bh=WRO7NTBEWKeqOZB/72PUnF3NFlapKR8O88V
	as8UpyDo=; b=dKIVL93WQ8LLkccS6/xQDPCirZC6MupCH4v0ynO1sjJAeKZe0Px
	4RxFpDhujPsDUGjV+Qj245UjF4Wg8FworCb3u6Xf/54qoab4xeYt3d+mura1J19p
	sBiilCXicQPv8kncuUOwsOOQajJZgnkQlSurHQeX3xZ/6Cmk+RuP2rodXqUyNElq
	CnDPodEd8Tsx0XTVeuefvHovqTfhU2l+0aihiPixZ702ATpkz+oDYakQo4mGtv1g
	shQiA5sfH93bZ9msGvtpsI25ei6cqPm+iIpAAxmBXxT9AxcOcpFeNn63U8jU1b5f
	2QRyAeeQMgKdK4GssC2L7942YMT95fzLZZA==
X-ME-Sender: <xms:8HHDaUPUYp1vOOnMJird7OcffDUiMO0NiGVDfh46SN6ISTDue6oRPQ>
    <xme:8HHDaR15ubDMQMi8talxDI-gTpko3Rhsuvk-7sBUi-h2kBl5ywlmEDGDJ-fdf6Czb
    rpv8YX2tMYSF_oMh6xenil_j3UiK7YVG7AESqkp8PAH2yL0urvISw>
X-ME-Received: <xmr:8HHDaTkyl1EQzIYc9A6kENiJRIpTTiUKHTaI_ni7oBhiCqEuVesXhgUGr6QEr05UBl8_eqLsZOU_ZnosSN5F_9O8-u-SwYl9XRsu68ir-3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrughrihgr
    nhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegvmhhilhihsh
    hhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:8HHDaYXCrNSkxDYf1BL6FBVchXIoRxG1UR-GmLUsOudiEAzUKGGpxQ>
    <xmx:8HHDaZsNBKI4ubvLv67vE8_PuJ_Yvb5B7hzyHxs1iOuwPGcyemZabw>
    <xmx:8HHDabZm05i3QFPNTEJ2VqvjNmiY88b-2YYPZvQvqQAeABC6zOe1lA>
    <xmx:8HHDaYWHS9rQv2CiPmTkUNDz9dmahw4nPqcYJfr72f6vlQDiFPzxQw>
    <xmx:8HHDafplQSxSFfY80lkwn2WBwhPe_lZIB61t6Od7j5rbUbhF57I0eLzc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 01:26:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b1a1096 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 05:26:05 +0000 (UTC)
Date: Wed, 25 Mar 2026 06:26:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/10] hook: replace hook_list_clear() ->
 string_list_clear_func()
Message-ID: <acNx6pDjOMQaMsBr@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-6-adrian.ratiu@collabora.com>
 <acJNYPgOSO86hZYq@pks.im>
 <87bjgcdfim.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjgcdfim.fsf@collabora.com>

On Wed, Mar 25, 2026 at 12:33:21AM +0200, Adrian Ratiu wrote:
> On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> > On Fri, Mar 20, 2026 at 01:52:06PM +0200, Adrian Ratiu wrote:
> >> diff --git a/hook.c b/hook.c
> >> index 6dfaa7e9b1..f6bb1999ae 100644
> >> --- a/hook.c
> >> +++ b/hook.c
> >> @@ -52,8 +52,14 @@ const char *find_hook(struct repository *r, const char *name)
> >>  	return path.buf;
> >>  }
> >>  
> >> -static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
> >> +/*
> >> + * Frees a struct hook stored as the util pointer of a string_list_item.
> >> + * Suitable for use as a string_list_clear_func_t callback.
> >> + */
> >
> > This comment should probably live in the header. I also wonder whether
> > this wrapper isn't a bit too specific to freeing hooks with a string
> > list. Maybe it would be preferable to expose a "proper" `hook_free()`
> > function that only takes a hook, and then provide a small wrapper
> > function for freeing in the string list?
> >
> > If so it feels like we're going a bit full circle though. Maybe the
> > original code wasn't all that bad in the first place?
> 
> I prefer this new design (suggested by you), because:
> 
> 1. We use the generic string_list_clear_func() API.
> 
> 2. Each struct hook owns its data_free callback, which means that callers
> don't need to keep track of internal state (e.g. when to pass NULL to
> skip cleanup).
> 
> 3. The hook API itself is cleaner for hook.[ch] users, because it's
> always string_list_clear_func(head, hook_free); regardless of context.
> 
> So if it's ok with you, let's use your new design. :)
> 
> I'll move the comment to the header (it's already there, I just forgot
> to remove the duplicated comment in hook.c above the function
> definition).

Fine with me, thanks!

Patrick
