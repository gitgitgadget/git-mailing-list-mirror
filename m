Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F045560D
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769946; cv=none; b=YcudHWMNZ39ceYUIJUm5pSLR+7GLwuS6KtyhBEzvFk802mcaP1lssXa3NJ0uHjTYoaau5tJZYg22+gqFigDwGQ26IOS2cOHzyva7L6/L7ULfFwC/7buZ0TImgh3z9zq2PUsbxbk4cvI/IXJm7S5b7YMnxUOQJdGu69c4lBjqjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769946; c=relaxed/simple;
	bh=oX0Wi7CLt1UoCnNbgoo0WWw+THA/XDDwaY6hoHp6agU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siuiRREV2p7um4GTVkJNkJM73SE4k7aKzXnKvKkUYN7GPvbOTwpoVDBTjOtqcTp09aQXs4IbjJwea3NrkX0hcCh7S8/kcCupfqjUVNbhOD1k78xaK2n6X2LjH1U/tq6AKZLVST6v4rCF+r5iwbaM6nxnmw3KSwDb+/iJq2h8IrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NIcdmAEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9lngfpE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NIcdmAEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9lngfpE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55A5414001FF;
	Wed, 30 Sep 2026 08:05:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 08:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790769944; x=1790856344; bh=0ReZTAlb8/
	0skU7RaXaPxuSLoTpt5IBr2kqWklXB+8U=; b=NIcdmAEs5yKxqe+gXUDpeWEbzt
	vGqHrNXiduD3kiWOM/nQYTT2cC3v1t8vwB4Z2Zu6FR4fBmowZwgXoDJ5dmQdowlQ
	UwpAur2oBXuXfU9GBQdq8oXyvijLh0eb1In439zoSYJD/sE2GHxG7LCiIcNe1I+T
	/61ozx3htJDj6+Y99gT+/OGlZAdooBAkmdxneCdSCfxPxJoBKWAwT+Jhtgpl1sV8
	KoexJMbR1F6fi62DuPCAQmPZonQLR6b4XgRWR9G1+kh1iMoWPCmb0yV3MPs0HK4y
	nSq5yb6iHRMA9bFG++01c76yxYZYv2aSlZyW0lHUi7AsWG1Us0d+dXTiS3vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790769944; x=1790856344; bh=0ReZTAlb8/0skU7RaXaPxuSLoTpt5IBr2kq
	WklXB+8U=; b=o9lngfpE1HqwhO96srGcEaMHQLye9/7Rtt6pvbVvpNziJVJCaH2
	c1bP97EaGNegFfB6LwOQ6YehoR+tabHxwPq3kGh7nLH7Q7vDJ0q5YkPvAX8bU1bb
	K3gNdmYgpmO9XTWMQU47Pu/e/uEdG5b4cvjQke/tYo20dXE4yBcy3nC2aZ5MM0Xo
	RItZOOwLiSAi1kMzDXmCCTGhYqCnBY5+WKnMr6Kr56t/nkw5GOZnL1/G2EdOVJbx
	Go9f/qE8fx7pQSloSEELb95o8MnzoiDd2JHMvrE7VHv8OvkdMls1qg+VjX72V8tT
	ANZuGkm3Y5MeRWyK03HGQOZi7tt3e3HD3vA==
X-ME-Sender: <xms:GPu8avzZ5Y2N8aPXGalrqFHhj0p2C61DOzk9c2g8LgU_8P-c5Rffzg>
    <xme:GPu8alFGJkLOc3Iyek6z43uIZV01WY-oLXK-P1bMYmmRiTezO2Ip-UmNcjQHYsZ8L
    GPnrIIpnzCpn-k_NA-7LhEj_0JyIsexc6zVd8P354qa7AUby463VZU>
X-ME-Received: <xmr:GPu8ajzsZUsaQb-Zj5-2KnkfGDD5ZHpcmPyGjBXc2zQavKI_UzzHIw>
X-ME-Proxy-Cause: dmFkZTF8KMLB2CYzVaLj2MQVgP647qUv0SfqCxSwg+eP6EECo8a/8LKW7ZKAVM0yTYxTkd
    /yMVciE75j7bzULDO1ZlJVSC+YRWyV1DsbK7dKKOYakHVNIsG+bm0fe2vo/SPqyPOzjOmA
    Wlvdv7dUtEOaEbLmoBBbi8m1d2p2WuAapCvUOr+ApG/4NeBKfbxQ/DiBlEEC1l/Lq+pOLP
    RhQ2aFZI5fOq1IcaotukfWyl0cfKbGTTKBfVPq1thu0hIFr63QMxOIN1iWtEZw4rx7ahPD
    vCZv1Hf/uneF1pboZ4UzlFCmYG3h21KKrCNZjyVrIOePH/BZrUgFZBa3UfoJ/AUuBHVKWP
    2FiY1iETOJscfxronWYvlkLuTCurlimK8mj4raixLXfcNg1tAcMRxVBOk+XLAlZPNOIipz
    V9t/K57dCug/CbcYpidxpfSq8UAm4dwQfF+55H0LHBvLJkBlTDK0ml69cVUbwG1GUQvRrC
    GFbBqFaPow5TSnLYpzGY4bzT55w8IEPhIfDY4dHi/3Ip6zJqz/3+Eb1ozH6Iwh2B8VhMjN
    DftnyrX0SZ3w4+M5cRXLHXqwkujrynfuAsaHBgqSQe+/vQhCmnhlxJos3sUVpOvV3Jv9X/
    pAfmwvS6oiH5jyLfGcWCoWhiUebpwtuGwbNjOZwXOymRxzNvph7sdv6orMyg
X-ME-Proxy: <xmx:GPu8amvLicpxUupNJNFS7_ZHie73pT6dB6pTlgbWuYSCDBeZDIExcw>
    <xmx:GPu8ag3S_OFfV_azUPEFpPiHbZw7sQSh0vOn--mT2Sq2hkplX8wA6w>
    <xmx:GPu8ah8EhmIEFqYANSL55I8kpbHKmconoFFJIAXIa5HaiP5DHsh9TA>
    <xmx:GPu8ahMuaqwNm57v_GY10qWuytigaE-dBCtz9R7OKjeZuEyDpws_OQ>
    <xmx:GPu8apLV3GfHQWHXsJSYdx3TF3yx7LvYlnnIDftm2gyaWeLG32vA5jKZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:05:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa7bf8b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 12:05:35 +0000 (UTC)
Date: Wed, 30 Sep 2026 14:05:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Josh McKinney <git-bugs@lists.joshka.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs/reftable: fix on-disk representation of reflog
 timezones
Message-ID: <arz7DV44Au08oLad@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20260929-pks-reftables-fix-timezone-format-v1-3-3df105a95ed1@pks.im>
 <CAOLa=ZQorPk_Kkewkw5k-gdeh=VRVBMcaDA54S0ByJfAswcCWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQorPk_Kkewkw5k-gdeh=VRVBMcaDA54S0ByJfAswcCWQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 04:51:15AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index 35e98b43db..579657467d 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -837,6 +837,41 @@ test_expect_success 'reflog: renaming branch writes reflog entry' '
> >  	)
> >  '
> >
> > +test_expect_success 'reflog: timezone offset is stored in minutes' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		GIT_COMMITTER_DATE="1234567890 -1200" git commit --allow-empty -m min &&
> > +		GIT_COMMITTER_DATE="1234567890 +0530" git commit --allow-empty -m east &&
> > +		GIT_COMMITTER_DATE="1234567890 -0800" git commit --allow-empty -m west &&
> > +		GIT_COMMITTER_DATE="1234567890 +1400" git commit --allow-empty -m max &&
> 
> Nit: it would be nice to have a negative timezone with MM filled in too.

Sure, can do. I'll just change -0800 to -0830. Thanks!

Patrick
