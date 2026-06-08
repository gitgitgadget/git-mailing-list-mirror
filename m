Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34738BF7F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901332; cv=none; b=YLEyDvhKxE6U7cb/TTzErFQT6XFtJ63dzJ00fYmlaiNaSESt/MJxfMhAio8jdTru3YZikdlrbBfLKr9LKGTMGTcb5Ve2DvCR5YYq0SxEnA6M0K/zgzqJwegJ3pZOt/hBQTJnwHet+zjTD+gp7jPJx89VzrdItvZ2qZZkW/j7YFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901332; c=relaxed/simple;
	bh=mh8tAFKOA1BOqNS2UmVu1kDhy8Wn7cg8MjWGIeKOsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv/ryylexLh/vVAfEkXw30EUHnBw9ossUntebHYGAzzjy7BVsq9ctwGsIjPxLxsakOJVA0hUMNkHRiGdHQdf63YZpuqvGygCHmDik7IQyw6m25GEor922Bi9XT9gUlEK7oaay65vJ9QwTnCkUWBSKWzzbRScqxi9R8YHpflBoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uQOGtrRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnBJx2Z9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uQOGtrRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnBJx2Z9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE63E7A003F;
	Mon,  8 Jun 2026 02:48:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 08 Jun 2026 02:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901328;
	 x=1780987728; bh=ebIsKI3h+oNPxHfMECHB+PIHF6Rr7z2ReyhVwttJW7k=; b=
	uQOGtrRCY/jEe3BmsX0KGISviU3s446AMx098uv89E1oBTdgosiGWUKD/oFwludW
	9Cimwv5nV7SAJ3j9YsZu2cjQv9vKoHR8azYmf/e/aw6/Eet5I2hDKeOzBM+5M+s6
	yQbz65PaamM1ZnMA9xoU96K167c1AvxQeKnSV6iCnCvT8d1ElgEPw2M2C+5h93d7
	lyqbx7+L1On0DJoUF6ff3vOQJlIXBFe57LoVZQNAUwf63liwnYSWu0EJwuDTXS6g
	Df2+WthbodGQlCNnnnKaSPta4vRrdTClJwLmzUf5uS/E6j/33JMAibjIXDpIoerE
	/UHJc1f2keXg5Kwl6/uCZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901328; x=
	1780987728; bh=ebIsKI3h+oNPxHfMECHB+PIHF6Rr7z2ReyhVwttJW7k=; b=d
	nBJx2Z9kzOHYLgEuFFVltXn7pmfndQj0zsL/LltLGQhZVqs+sEMw5Dl+Vb59Zlnl
	WQ0xYxcHe/C19cJHEIkX4SFncig9ErpeXLthSHk04b1sbUtGXV7pvJvLK4IQoWL3
	V4OZpyf5YIjOFX6KJ1O2LDEyc7/A+zAENFb7/rUwfWW39rlW/gk1Fnnl2/NGh8/i
	H62xglPK+Jtl2qy4eNmHcd1V1O+FtRvt8sSUPfizlxL5UNuvwUOqKnNl4J6sZqFF
	q5zRlu2tBEhnSX8aK0zwSDcHTMw7jHFr4HUlcsi8O5hUfXrvwV3h/iQUBXRyVoQF
	cu8EhQHYFX0+85/424w8Q==
X-ME-Sender: <xms:0GUmajrppMeQD0WP3OY9Bp3lswQzbOesCu_fHubMl0C2Gk-k86kSyw>
    <xme:0GUmakhQZpMtt4AJm0XaZP-be7Rwy1M3vo-5zwSxyfX5x2pLT9f_hwC_hfsnYR7gq
    3T3Ar8mcHLICnoJnQsd9sWAAYmDCB5BF-HJOaQ6P3-RmAGuR433yuw>
X-ME-Received: <xmr:0GUmaohxI8TvkqmC2XKXPd1k1Y3x5_A0a53d2UxEK_4LmR8HpJnWzgswYr8vXKbMmyx8e_gZAUx_nmHhSHaLJ2tMioUMSiPeepqAJcKXwg>
X-ME-Proxy-Cause: dmFkZTFCzZXEsCXzswTR0nytCXdJZxtgceGD63V8KNkus82bs0gFbi4DTfVOIwIfG0PqjF
    0MagCdNvz75p+ttwc4AwxFcoP0xy/hHEYIsZzUWCB1Y5nj3DrtP5CR6/IxNSAxmXnH2NtW
    JW5FhrH+aE8Fs3pjCmutFliNk3jJP4JrwhNS5ZiCuPslotpnimBvTyzTSAR1p0OOvmTBFm
    Dm7BZu7Uv2vCiAhUsWZakZ7Nx1Zj8iQZ4UMzTn8t8l1PV2SjnY/qnOO/J3WGl4Ptnrrm+U
    6KKbR5jdeU20dR6iwVY7fU3XhtSpJdk0hvG9bzVYnMfbdpL8VAz1DQOG/xCCfFKr0hnqOd
    ZdGDNv2Il+HZtd1i72ggZ4Hw+VupSlAG1ds7kHJLcj/w7K2NQCCM7F2pjgzW1cFvORiCMB
    XHhOtoZL99eu2Um9hd2CKzKVR/WLPi7c9jQwDfObpedyL1a4/ogw51eXCrBFiECBay+afm
    9E0uyH23qCDMhjY3G2Wv79N84i6zM6FMpuuEnq6PrZhbi+9OkwXyGRiBxZ/S4gVm4UBTR7
    4g7osX/qipKELTH0vbluPlNQ9ZTJrmbk6T0DF+jZHhTpmHNjqh1jgyR/GNG1QLHRPkM7FT
    DoKI2z+gHpVr9H9PP4gu7PIPIksarJ36MTUe7bL5DoIxpAqmc9D2zZ6hJZMA
X-ME-Proxy: <xmx:0GUmaiixGHpj1qg1-JCyvo6Vb3vhX_Ufd5mbcAHu52LhHjymScfQYQ>
    <xmx:0GUmagIbo2Fmg7lWXNnFsyu985HatPhWQ4usJqD2yZA44Id1wJ0zFw>
    <xmx:0GUmapGlisLO51DUCDh5r8hHegB7YyGp_f-Kj9vGQLZ8bSH50ONkfQ>
    <xmx:0GUmasQMrhvXx1WoZzAizx0GqrPJBFh3EkTbE3j64Kmwg-zzvfxNng>
    <xmx:0GUmah7kMV0f3eF2AWdR8IzYOxECoT9nJcmykyJaLfvzD35W8CbvQ2z2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66c9477f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:46 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Weijie Yuan <wy@wyuan.org>, Tuomas Ahola <taahol@utu.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <aiZlzBEB_AnQ4mVK@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
 <aiAK9eLvew+mgWt+@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiAK9eLvew+mgWt+@szeder.dev>

On Wed, Jun 03, 2026 at 01:07:33PM +0200, SZEDER Gábor wrote:
> On Wed, Jun 03, 2026 at 08:55:04AM +0200, Patrick Steinhardt wrote:
> > On Wed, Jun 03, 2026 at 10:12:22AM +0800, Weijie Yuan wrote:
> > > On Tue, Jun 02, 2026 at 08:09:55PM +0300, Tuomas Ahola wrote:
> > > > Huh?  Doesn't MyFirstContribution speak *against* shallow threading?
> > > >
> > > > 	        [...]  make sure to replace it with the correct Message-ID for your
> > > > 	**previous cover letter** - that is, if you're sending v2, use the Message-ID
> > > > 	from v1; if you're sending v3, use the Message-ID from v2.
> > > 
> > > I don't get it. Doesn't shallow threading means every following patches
> > > are replying to the cover letter? Replying to the previous one is
> > > --chain-reply-to, if I'm not mistaken.
> > 
> > Shallow threading basically means that all patches are sent as a
> > response to the current cover letter, and the current cover letter is
> > always attached to the cover letter of the _first_ version.
> 
> No, in Git shallow threading means that all patches are sent as a
> respose to the current cover letter, period.  It has nothing to do
> with whether the current cover letter is sent as a reply to the cover
> letter of the first or the previous version.
> 
> > So this quote is definitely at odds with the configuration I have
> > proposed. It's actually quite surprising to me that we recommend deep
> > threading -- I personally find it extremely hard to navigate as the
> > nesting eventually gets way too deep.
> 
> Deep threading means that every mail is a reply to the previous one.
> Again, it has nothing to do with the relation of the current cover
> letter and the previous cover letters.
> 
> Therefore, we do not recommend deep threading.

Oh, you're right of course. I totally forgot that we even had this
style.

Patrick
