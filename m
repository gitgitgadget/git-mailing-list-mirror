Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFC1E521
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053965; cv=none; b=ZJQ6jlZQlbjViVjEEZVfg/foJlIOPtkxk18sOdDSgQK8TajnLUSUwyl6jZrWePcikGqtGpAIsAKY6QLLLhWcZUkQ38WchvKuFIjYZ+H4OSkcPSoyccEL7z2sM33UVTRMxcw80IRntpOyjxo91UbzarGN8JFu7ISqdXLWeBLO4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053965; c=relaxed/simple;
	bh=RFlWMpWcVc7v7Su6pgiFEVrCpQOCaIVGumTkA4zbCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDL7/vdAno6/x9aIFQsb+gRFoZEw6a5E8t33N70X6VEF2Aayw9N6VZZqbOtUddEWWGCc/2VnC2R9HTclyU5QCfeSdDQy6enWPYgSjy88mzAUn6FW4BiGVQHGW6CYBuMGweVJD6wgSnMUW6StL2bZni8Swo+ZXZylwCyseIZb0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cEpX21kQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3sFm6/n; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cEpX21kQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3sFm6/n"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4083254023B;
	Tue, 28 Jan 2025 03:45:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 28 Jan 2025 03:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738053959; x=1738140359; bh=snPvGoTI5M
	IuBy+LBt6qXFE1LxHub++lFqAXFRaMzvw=; b=cEpX21kQ/uYPpK3MLI6JEe+KyQ
	Xw/vLYX8rr34g7Zs/jKUDSIYWCnDIt0uhYTerOOebH35mKe62o2EJP60KyqOu51K
	7FKlM5wRzVYpZ8KO43DDAMvC6fqU4FeV4ob/CxPOSitckZpPqMY5sUBLvo+yjLZf
	EOK/gZ31HwdfwiDMiC0XxCbKGo45VNXHJ08rq05VpMH+FYZ+FEvR/UqSuBywXpzv
	Y6lpy6A9yJWWRVnikLlpTIUyL84DW4Phsm6kXqwFXe2yoSQJAunBuRsrVKXx4kxv
	bVhgU1yS/wEEB04q4dKy0UlYq25ccouHkTOPL/VyQjEeOCMP4XeH9HBjlz4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738053959; x=1738140359; bh=snPvGoTI5MIuBy+LBt6qXFE1LxHub++lFqA
	XFRaMzvw=; b=L3sFm6/nYU4xfaSpsow6U29TW8RZ3gcv+zCACsL7iM45D5Hkv7z
	WnhvWY6lXeccyKyYzvJYPnur8JKSd+E08ZeHhcn7WuRBTLDW1n0Hebft4HI4cfl8
	hVgVHwIey6kvryTNM8LL2td5aDKl39NbT6/AFlE9MlzmBq2+CBMoqxaT5fRorDh/
	qDqxk9kqlWNGn0FGXb1I/D6h1YqTpRUUoyQEg2fQOBoB8gAJJdSgBayQHRbiBku6
	zBwu3ISam3Rl1WC9EwvE5qG55yoPL39x6h0FNpaBPVLt2h8uOqfkFSsMGznidwHt
	UAdINnVq1VHcu/2Y6YeIbylHm54Pp4+Iw8A==
X-ME-Sender: <xms:RpmYZziUbibRsrF9Eaq0yYp_Nb5Qnp_NcXeBiZODR2uEJqLjTqGUEw>
    <xme:RpmYZwCI1TFXxeKJh2fSSpxk6YtLBGR2q78FKT-lmgYVPk90vhyImv2DKqJxLUX21
    fgOzZ-xQei5_pcp9A>
X-ME-Received: <xmr:RpmYZzFAe2fmp7Lgd7bNqf9t9WeiZ1qAXSdhaiR4PGdeqJfV_kOxglL6jApbkaiC4Fh2S_33R6rtGI9E87yIBqQTwuEtXW8Da8PpOzNHsng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohgv
    khhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvddtvdehtdduvdeiuddvheeifeek
    rdeftdekledquddqshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:RpmYZwTHNbttLu6sYbNIBCiB_wfH2HwTrVqcYvq-c-MRupeop0sEdA>
    <xmx:RpmYZwwZpzL0SLHgKgfIvWVEVr5CogqFoZNhEu2vCweQ1l5qjInhDA>
    <xmx:RpmYZ24OnbGQ5FsTgGpZGwMhZSr78ypXW9prt-33F4Re8Y_DBYfI0w>
    <xmx:RpmYZ1yK294CSEHPANmCa4iTx829t6km71pdf7VJUurHclGRY7Amow>
    <xmx:R5mYZ3l3CXTomZuBEZEyE-TeWKATl4e1CBdJOYeZNWAHtNRnqBtq1IDT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:45:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30638343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:45:56 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:45:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: 20250126125638.3089-1-soekkle@freenet.de, git@vger.kernel.org,
	phillip.wood123@gmail.com, sunshine@sunshineco.com,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 2/4] date.c: Fix type conversation warnings from msvc
Message-ID: <Z5iZQ3-egivQOcJp@pks.im>
References: <20250126125850.3195-1-soekkle@freenet.de>
 <Z5c1F7oqsaPrHRiT@pks.im>
 <xmqqwmegutbe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmegutbe.fsf@gitster.g>

On Mon, Jan 27, 2025 at 08:15:17AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> diff --git a/date.c b/date.c
> >> index a1b26a8dce..0a3fafc8a4 100644
> >> --- a/date.c
> >> +++ b/date.c
> >> @@ -1270,8 +1270,8 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
> >>  
> >>  	tl = typelen;
> >>  	while (tl->type) {
> >> -		int len = strlen(tl->type);
> >> -		if (match_string(date, tl->type) >= len-1) {
> >> +		size_t len = strlen(tl->type);
> >> +		if (match_string(date, tl->type)+1 >= len) {
> >
> > Formatting is off here, there should be spaces around `+`, even though
> > you simply followed previous style. It would be nice to point out why
> > this change is makde in the commit message.
> 
> I think len-1 here is perfectly fine, as there is no element in
> typelen[] whose .type member is an empty string, and no need to
> touch that.
> 
> Besides, we already have this one in 'next'.

Huh, do we? Oh, indeed. I guess this patch should then be dropped from
future rerolls of this patch series, shouldn't it?

Patrick
