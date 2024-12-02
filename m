Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADE1F9415
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126066; cv=none; b=a3YpIMXwUs4e9xVKsYSybp4EsC4/6t9bXV9nBe9DCXD7jYDxkC0H0DIjkPENh9983nEK8oCBegOiIbaFhHb63LRL1sFZMNFKdD8lxz9r4Vl01N07vZJ1YZ4+wX9IGLZ/UAJ8T7pYMFZ9zuLgljD33vOqHtMTfQqc0IfU61IJlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126066; c=relaxed/simple;
	bh=Y/83IONusqlVSJxvp5HI+nasCWx2zqozMvDfGqaeRig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQEzIlYX1bClVO5b96DjYGwZWPnMUS1hOz3a7gt50QzupOgd2IjlFotJEFrGvOpyjnfJD/krjuL6EPBPxQBYgIjR29l3WlHXl5agAycO/VwukN5rRKeSWmLlWzfqOsCgwc+lFRFPXb7PFDo0q8l59HuhiKFMfE811Dx8coTCbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kjOW7uTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCjkquyy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kjOW7uTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCjkquyy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46AED1140136;
	Mon,  2 Dec 2024 02:54:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 02:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733126064; x=1733212464; bh=ABDKuQV+KQ
	588rXR87S3bqLXTxK1NGHHXRD9wflGwt4=; b=kjOW7uTrMl1xYXudKwsM4GzIht
	w/BWQaEeb30fBGA1vzBeso2u/hcGS06ynEy/u8jO9MKMsaVKQJu41fvrr9Kd4GW7
	ZUS+c6nPG/fNufDBH785NUch6atPNW0mUHk9tDLSJHsH7MEeHrVdaR0oPVJ+Ak4e
	ZcDZgZBhVrpAL89+ygI7+vYORLQ1AhePZaKYzoIwO8JtU9knImPmRbzF8m2igj+6
	e/MiijNuMbrCdVolzFsuZvNZcySvo7Hf5DChIIrbtXkYzTriHNI4FkwzmP8RZn7O
	7y8JvANaslrqVuORlFKdbouNodLYKEeorktZ5UHblH8gG/9L0Yt4ylrtttJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733126064; x=1733212464; bh=ABDKuQV+KQ588rXR87S3bqLXTxK1NGHHXRD
	9wflGwt4=; b=DCjkquyyc0GK4KtWURjwgfE8z2/tLyvchxnhw2BHkQ9oaNdvIqr
	lZN4OKhmZQqaM67zBartXk+G92R8bXDpHMnmE9/n9CneJMf9QG8UwNr8bgEcbji6
	aB63B3kCGT8wreFqcMeJry0dsknCiP4ntjQHKrvZMRuGtzBdfqigJ0k4iflWU2fc
	hAGEo5th+P2wEve2vjS+TAh3YMF/xtPaAG+t7vsMMtG+EoP/3ip45bDyo3a0/m+E
	UAA2fNZ4oLsPKWxmSoWIN+kzvwH3SKrHsrWVanDJbmPjo3eqc5zVU6f9pE/kDZ7z
	0SKKGeVQ8VaJMIBdaK/NAWcHYNK6I/dyIpA==
X-ME-Sender: <xms:sGdNZ8hAe6HGGZNFKuvCUbqHcmDkZ-um3-WWSXzYskUJGW8s26GpDA>
    <xme:sGdNZ1BhBO4-Y77FwtNyanZd71RA_gdhXijUEiKkwn2tUoPXrrCajO3cyp1gGi8ez
    T4edMgVjjCkzA3tqg>
X-ME-Received: <xmr:sGdNZ0Gna1R-pz9Ov2Gwn7wa1qjO2NWMTPju9od79peCHUE1t_vYQZ69Uc473KrhLhyo8vvhT97BEVnjkXJcvvBPA-yHdzYbwzHT6Pum-GtoPUUDpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:sGdNZ9QI6nxLT1RXVtbtIiSQ624EoYAh28jfiDodHwk0Z4KC1jlWoA>
    <xmx:sGdNZ5z-R6ub6g4CbrLhAA7-WKgPQvRXJs8r6XJSmGa25c7IFvYpZQ>
    <xmx:sGdNZ74sHh3qnSekw1xdPX5W1ASac0aRTMI7PPy3iD7iRe-MItGJVw>
    <xmx:sGdNZ2xS0ffUAfIyfh30TTycj5d-W-Xz3tl9Tni_vsehfP9VRVdq8Q>
    <xmx:sGdNZ0_DwTiPzsLOunH3pSdqhKjueOkffC_eAX2KbyYge6w8V6C-8yoG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e50a1787 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:53:08 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:54:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Start compiling with `-Wsign-compare`
Message-ID: <Z01noeL8nHIvEuL1@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <Z0rvKwXh8mUikBeU@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0rvKwXh8mUikBeU@ArchLinux>

On Sat, Nov 30, 2024 at 06:55:39PM +0800, shejialuo wrote:
> On Fri, Nov 29, 2024 at 02:13:21PM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > when compiling with DEVELOPER=YesPlease, we explicitly disable the
> > "-Wsign-compare" warning. This is mostly because our code base is full
> > of cases where we don't bother at all whether something should be signed
> > or unsigned, and enabling the warning would thus cause tons of warnings
> > to pop up.
> > 
> > Unfortunately, disabling this warning also masks real issues. There have
> > been multiple CVEs in the Git project that would have been flagged by
> > this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> > the vicinity of these CVEs). Furthermore, the final audit report by
> > X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> > that it might be a good idea to become more strict in this context.
> > 
> > Now simply enabling the warning globally does not fly due to the stated
> > reason above that we simply have too many sites where we use the wrong
> > integer types. Instead, this patch series introduces a new macro that
> > allows us to explicitly mark files that generate such warnings. Like
> > this, we can adapt the codebase over time and hopefully make this class
> > of vulnerabilities harder to land.
> > 
> > There are a couple of trivial conflicts with kn/midx-wo-the-repository,
> > but I don't think it makes sense to make that a dependency of this
> > sereis. Let me know in case you disagree and I'll change the base of
> > this series.
> > 
> > Thanks!
> > 
> > Patrick
> 
> I have read the whole patches. Only left few comments in one patch. The
> others are looking good to me.

Thanks for your review!

Patrick
