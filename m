Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812F3750AC
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068138; cv=none; b=jnb1mmIThUPLXrdPPpScKp+ZGQGCn1Zq99IvhjiQQV7aYiZaM3woepAwe99crBOu2ml4GYPG7wNb2K6q3tU21NSl/SbwlubRgx75nNdq4TRWRsawGZLIVeGTEq9NlSH/ttqZjO7oTkfBW0LT/Dpl+c1S4GhyeWiKLVt+5ptYCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068138; c=relaxed/simple;
	bh=Xu6u8ZqxHOcifdqCqYnn0X/QiE5skjPIwalpfUOm3iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwSR5TknoFRTOyZcXUfmNOSUUBexhLWLZnSY0bjj2DdZWkS4wSNp5pPV1yTvauYUgxEEgp97OFZEOQDiDcE9mX+T+FCH6NgYWk/CnecaewXK0PkvVUi/CFIC1anilAde4UqmAMmD3cfpYr3vSQrW7QLInu1pZB6RJ9bP4j6Owfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pz90Yfjq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IvWiA08E; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pz90Yfjq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvWiA08E"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76E1F7A00E9;
	Fri,  3 Jul 2026 04:42:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 03 Jul 2026 04:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783068134;
	 x=1783154534; bh=uDPPG2v3KRwRm820fC5rmGs6L1eKyliVWM+VpB4K2OM=; b=
	Pz90YfjqkspCD/iiSvru+NfnKi9Q6FoWMhn20tdX5tx3Zmthu6xo76qg0UGAt4fR
	HdhFQ9mFRQoGBgeb1pHZrhz2BBM3FMldkcDl/Q8LmPlyabW0xRZae4RLnFQ83+fi
	cJXIguxLSZXlrY/ATgm2DTLbIunzHzyErgoQ2Je7ocmn4FvRMahiOP1crnyKCQJs
	JJdzXAwWLVC051p8MNhnqaYK1O3fvZTPgyWrWQvWOgcViu8zxzbF/I0SA45xzrmu
	jt6G8VxKWcsX+NQxG52GWqmJ1sT9N5PX5FzXI1Zb6k1DamR4FCrNu+XJazwqLdkp
	zQQnPjyggNcGlBjS16xEPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783068134; x=
	1783154534; bh=uDPPG2v3KRwRm820fC5rmGs6L1eKyliVWM+VpB4K2OM=; b=I
	vWiA08EFp+s4vGs/nIDJuHEm0dd5Fdyze7i/jXu3kVhbhsUpgy/K9A4x0n7a2O0Z
	m7beZFYJOQBRk02EtBZkZ8gT0N7Gikx3nPpEPuajTagALl9MOwyHK7hvjDDEsVn9
	7pQ+pr6aBJJwtorL1xQdjYtkMpVRt07gRe0DIRnFZgj7JArnbNpR5MBG333oZPbz
	RLbQTD7LV71R0V3H6iSAjj0KsQtfn1njIptlwfQlGq8C7RNCfH+GbaWWRP3t/s1K
	CxnoTYCYWhmvowyqW20cTtDeRxGkEK7O9mJutlm/Smok3VVEbfJaMi8RLog21FgJ
	QL1Xa+XSEW2iRNXUQ+Elg==
X-ME-Sender: <xms:5XVHauJyC5GoouJ17dCX8A-dmSlgExwZN6KpzQMD_6XMgZlfuYYJtQ>
    <xme:5XVHap_KIzdFfKTOEwhgMX6QFX5fkpBi831oRLp0croIRTD5UBrq9pru2i_CDE1er
    mEQoEP1qc1F_ZdzcRKmEg3BJtwQceP1n8rOPSWsRC0oYasbL7uWmg>
X-ME-Received: <xmr:5XVHanx_KaG1mgsbbo0lE-Z4IOXz7UckRDGph8Wq6pbdMC3t3yDPl4SiHbmtlH6s2Qh7Hi9UrFtvKFKCaT3_710Ag72z_ZCDU172JAB7wA>
X-ME-Proxy-Cause: dmFkZTGTKWiHBRD46/wrumyuTOlQenHbSMP9Lo8L91wfl/nMOdK2fkHDuR0gLrqqAjt6Lg
    VUekQF+4ZplMact3unBeEDIPHS7d39Lk0FDF69vOt2FsT9MckyGHiJkwXhEOFN7eFUxoP1
    XlDIsY/U4MbOq+yNCqcpCA53jwtmGbc9e3NM8LqlvQbWQ1+RY5u3Z3aRAFVwTn7rR15E/w
    oZidsQvy3Mql7jyKEK5qeUsOky2YqNViu8Tidsaulwi76B68kBIHlLdGEgGnVHxgXgwl53
    uaK1WkxEZkz1lX9i9oXhn5ITJ20eH5WYhKjTQPQZdyqpfm5OqIxriGDvr9avf3Dwm0GctY
    /ktTk/5wkioRlJMrz9O+nq64JGHooZb0iaIQ2QuDwbn+qFfQZBDTUx146hXWnoVGhvBP95
    8XQ/MbqdHQNObHBah697AVc1Q3MuZDQg81p2VlOp4wsmksY6tF5OXpkBa9HTvWaqqJ5jDw
    yQh68jilrfcayxg1ZL33p8qfxpIk0vlcWdgbfHTl1HTlWh165QciIv4arRxldoYpY6iact
    hgGGiA7lUrNl5w9Wj4h65PU9H+lDqTz3Itt2dM67sssEG+5UZ7FbIiljPcnY/9a85A6sRq
    Kw7C2ZuvSe6s+3u7uvAnneWFjTCnGliRUxzQwttsGq35M3dksuDSFWwc39aA
X-ME-Proxy: <xmx:5XVHam4LX2nsXv_zxZInqu19LZWnG1AhiWXQF-8fg30l4PDRsfnqOQ>
    <xmx:5XVHau-sjb3wPz-Dfor5AhsiRe6IJEYLhPJ7g5NkGCF1cf8QbKLvwA>
    <xmx:5XVHaroZkkBi4qqSlcwte0LFLRkTSwsDh1Bcy1DVAes4hgen8VoEyA>
    <xmx:5XVHavotszkjt0tP1k78f4hfMgfQjKJrdP7I-N_Gi2CNaSEhskRtbw>
    <xmx:5nVHavub82xREBfI489VhULUDuRY-juiEkVZtm4-3WOJn1wB0dYbLWTD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:42:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42551204 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 08:42:11 +0000 (UTC)
Date: Fri, 3 Jul 2026 10:42:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 06/11] reset: introduce ability to skip updating HEAD
Message-ID: <akd14OKLT9lAMKTf@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
 <20260701-b4-pks-history-drop-v8-6-19b5cdf1facd@pks.im>
 <CAP8UFD3RZv=PGC15xms3xZZkNQsGLpgq_ogt8P9ux-8p4HwW6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3RZv=PGC15xms3xZZkNQsGLpgq_ogt8P9ux-8p4HwW6A@mail.gmail.com>

On Fri, Jul 03, 2026 at 08:59:30AM +0200, Christian Couder wrote:
> On Wed, Jul 1, 2026 at 1:35 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > @@ -113,6 +114,9 @@ int reset_working_tree(struct repository *r,
> >         if (opts->branch_msg && !opts->branch)
> >                 BUG("branch reflog message given without a branch");
> >
> > +       if (update_orig_head && !update_head)
> > +               BUG("cannot update ORIG_HEAD without updating HEAD" );
> 
> There is a spurious space character between `HEAD"` and `);`.

Ugh, indeed, well spotted. Junio, is this something you can fix up or
shall I send a new version for this?

Patrick
