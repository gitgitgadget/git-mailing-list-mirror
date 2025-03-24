Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EB250BF1
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811014; cv=none; b=cWHNYz880VKBUsdjOaUvAXs9OerqPzUSRzSpb4IRhsbkpB/Kc1Ms6kvV3KlkQKFGKCoHvHUTNZJviGMQIF1/jYM21kSsGF8bL1YmVb15Ic8thnKJOH2MEholWngEkX6d93WM+EPt1M0e99Wj2AaU3xvzKmvjqFcWzzXX8ieJXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811014; c=relaxed/simple;
	bh=HZ3KpFVSuU+BYOZ8RnsW3+Ndp/gEuNaDMQ+M3/ImGgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Inc4J4B1k0JP3K0X5Bc///YkoVerQLSTSJSHca5dIanv5VXTnGT94HMIWYEgL11rvSq5jOf9xfdbMHrtR0/i6kRad74PMMs2/uWvtizKKgrY+0bvHV1hp2Oz6iu77VXTiFQGs7GZ4y+MqlbUEjWdBVpIABoLPW0KlJ/9dXslBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HcaUDolS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSQyARWO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HcaUDolS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSQyARWO"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id F32061382D2D;
	Mon, 24 Mar 2025 06:10:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 24 Mar 2025 06:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742811010;
	 x=1742897410; bh=TwArCWQ7YCAjaG8boNCxEDzOsK6u77rYJAm0vX4NQkA=; b=
	HcaUDolSsClyx8dVbNaqFPVVg5SMbMSxRalF2JcLr/4tI5eemCLNTuzatmzWakWy
	TZj3h/5Ga3Vqv3c+VDl3rRE5JlzFJdrtHbKipG0aRG2fQRcfTy70Ivb4QH4tefTH
	7JYGgVkA9UAt8/zpg90qznS7NXFoKsTheob6ymnAXmLF/W3jStMG5p/U7ZdpS5/5
	tDc68Q58bo9+PI6xgZ2e4TZVCylXYCRJjvzfrCl7/acSqcMMxiggOGGefi0nHYUt
	wniO0NOgHcGyhwwAiMOyoAIKjupbcq4IzpGd6ke9lenK+wORJDr1UYTJI6CF4fgk
	nXGG5LfZLaetOFrhAEPjXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742811010; x=
	1742897410; bh=TwArCWQ7YCAjaG8boNCxEDzOsK6u77rYJAm0vX4NQkA=; b=Y
	SQyARWOQdHMPVTBSZkczJ1wxPeRSROsUVZ3bK50uU+gKrI/lEWUOAxSBvbYpye4c
	m2pX7CyhErx+6EN7UMM1FqBYXQ7ek8t03MKZ8ifaAhckiJIaxhTbkvdZ1B8+q+6i
	pjwh7pqURIzhTwGKJ8iEyjZoSP+MAZlQfBelqDZG6bbki5l9MwxUD4iLJ1ghuztn
	GDaVSP7qhKZ+eG+TBwppBwcurcsp+i9+qPSvIwCmwwSQ8Hzc1iyQK19G3BhjEAje
	PDjaPwd8vQKjr8yq0u5K9JEbjToVqctgsfFOU3FDh4VBD1NRhyHD7sLIp5yAA3T1
	ygbtfCxfXmgUvXzD74MKw==
X-ME-Sender: <xms:gi_hZ263hw0ntoZ_dZtFLPkb34JcfhMQcH3pUr86g76_NsDXOUEUbw>
    <xme:gi_hZ_4J9Haz2k7p574u_g-AISY2VKK-rrGhSCMYxDPU8AHw3dnAQTj0t06hRp8Au
    iwgnyJ4Sg6JeBDZXg>
X-ME-Received: <xmr:gi_hZ1fNalhkearGJ_AX5Jqe_mw68ok7HCCpw4eEth68R36ALA9borWbSrEem4ARYKfrsgF_QO8_tpRxdd8wCFv2VIeWsoyYU5WNsFxUvyAJ4P0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gi_hZzIEDZ279-9H1ZsxOl54Gj0wYDr4fuRDBMNPN--rIEuLYMRJig>
    <xmx:gi_hZ6J5qwacC-zMRjQeoi2eQt_2YSBFk_NI40Kf8S7U20CPrL00uA>
    <xmx:gi_hZ0zyiAQv07B5n-aTZ67jdmvXzUDKDjiOi8c-DUvJU-Az4Ncdcw>
    <xmx:gi_hZ-IDrbDHvDY4f9OjePteZuOJT-MNicKf7lHWU2eZXKpi6BVVrw>
    <xmx:gi_hZxVZ20vP1GBIfQHEvPeeOm0njoot3SxxKba5Av44RaMq3m8JKIHS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 06:10:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80b46570 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 10:10:07 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:10:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] pretty: fix parsing of half-valid "%<" and "%>"
 placeholders
Message-ID: <Z-Eveqmb7Et6aHrO@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <7d6b62006ecaf7db159e8db0c85455ed58027ce6.1742367347.git.martin.agren@gmail.com>
 <Z9vdS4bxY6spILsc@pks.im>
 <CAN0heSpN-k886+RsZ0+djLd974Mq57B4quZK1yKXRMxCnOvzZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpN-k886+RsZ0+djLd974Mq57B4quZK1yKXRMxCnOvzZw@mail.gmail.com>

On Thu, Mar 20, 2025 at 05:11:09PM +0100, Martin Ågren wrote:
> On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Mar 19, 2025 at 08:23:37AM +0100, Martin Ågren wrote:
> > > When parsing a "%<" or "%>", only store the parsed data after parsing
> > > successfully. The added test would have failed before this commit. It
> > > also shows how the existing behavior is hardly something someone can
> > > rely on since the non-consumed modifier ("%<(10,bad)") shows up verbatim
> > > in the pretty output.
> >
> > Ideally I'd expect us to die when seeing misformatted placeholders like
> > this. This is way less confusing to the user as otherwise things _look_
> > like they work, but we silently do the wrong thing.
> 
> Right. I can see how it makes some kind of sense to print what we don't
> understand when it's something short and simple like "%X". But for more
> complex "%X(first,second)" it's kind of obvious that a misspelled
> "X(fist,second)" isn't something you want in the output. The whole "if
> we can't parse, return zero as the number of consumed characters so that
> we can print verbatim while looking for next '%'" is a central piece of
> the design here. One could certainly imagine a "strict" mode.
> 
> > That being said, I have no idea whether we can do such a change now
> > without breaking existing usecases. As you rightfully argue the result
> > already is wrong, but with my proposal we'd completely refuse to do
> > anything. Which I'd argue is a good thing in the end.
> 
> I can see the value of a strict mode, with command line options and
> config switches and whatnot, maybe even a changed default behavior at
> some point. I'd rather punt on that for now. TBH, I'd be afraid to do a
> hard switch from "0 means print it instead" to "0 means die". I don't
> disagree that it would be a better end-game though, at some point.

Yup, I fully agree that this is a bit more of a risky change and that it
doesn't have to be part of this patch series.

Patrick
