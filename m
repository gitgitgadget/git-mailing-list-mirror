Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007C1865F3
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460658; cv=none; b=eTzJGaqk+uT9RY7BtsMucNkDxJFd0t573Df7i14cOycv5aNtHvcvLp1OhFz4fo5lnPdC8ZCh9lXWn0t1nkSfwPFaUsmMXJzYHHWXPf+FrvWlZsbckiose+nA1v6msBidZLV7GPikQjepALYaGZ8qgdSPYduo1F4pWoHN7+bXN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460658; c=relaxed/simple;
	bh=ymEFejrbdfbRF3Evb4CmlWhV3+c+45oE3iNfXn13RuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4+U0UNMuvHQmci7f3CnMGH3FWXsKozs4vthh/7jZzM1j4A5N3FifBc4Qa69Vzwyv20QiPsHKI4QGfquHwj2Ws0qTv0BMECDovCDywpR0wVSow0fEeDOgUPpDqSCjiu0CwQZ6kqsPxdZ1hV3iPPROQjqVFw//DzCTVcZSzbfWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjbDkkz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrAlA59d; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjbDkkz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrAlA59d"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3CBA114016C;
	Wed,  9 Oct 2024 03:57:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 03:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728460655; x=1728547055; bh=ymEFejrbdf
	bRF3Evb4CmlWhV3+c+45oE3iNfXn13RuQ=; b=fjbDkkz91VoBK14T6o0FFaPLa5
	T8YVyYQt3AR/C1qYcah0fdTLRkzS/1/IZ30HjxVfSbIzwEXROn/xjls9gwxUUyOR
	KbdoOJXqFUotS3VLcvKKOoCXbFP2Zv758ASvr7rtBx47I6p4y0A74rX4NVCMnSeg
	nuxFidWtRvRwXXplufkt7w4zBDCJnp7Qq8g7okwfRwKLkr1Jwcq5rEoowgFA+9nF
	xNCBvIqCZJ/ictKHcOYhJaGvMGpq4GqsabiIHU/HkS4vBfpRQmzNgMICrkKb0D1+
	STn/a45JvELSXfN+Cj1/EWAC1sAOdgp3WHEiIb6Wp7cEhJYIll9JLsSapDeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728460655; x=1728547055; bh=ymEFejrbdfbRF3Evb4CmlWhV3+c+
	45oE3iNfXn13RuQ=; b=hrAlA59d5LWitJU9F/e5RC0YBFn3+Mbnwwm1Rm6sPJ8+
	jExCHBr3WOErXBiBwwl1IQULanMdzHwyAC4EEIWV0RuFdP3p9eW0HHYRhiAtiT0L
	zy0bQF0Vef9tY2ddHZIgbYeilbd46hEnrneIXwl1fFr2N/I9sE/PsvpC6xH/9iUt
	cnL4KWQHW6rEAyU1gAYzPMm5mqTEuaMe28V05ufvgBIITK61TFhsD61YhpJRyOOY
	WheCs+WyUZ3Vl2jpPGyV6D+HWremMKgFeAtuhWmnNgE+7i5WLDu+JeAZikpJWpb7
	nI3tVpX2XDOewEAC82Axz3cS0Okm9FZ1uZk+Eqpkkg==
X-ME-Sender: <xms:bzcGZ7evbxoQmyRZSbdgW_DRuYxpor8r1SHHrfTnB9AW6NvJNg8znw>
    <xme:bzcGZxNXFpCbtrpMuXeq08GA9_Yp0ZCK87LKkL1N-rCW2L5A9UxJh-yrTCnVHdvgz
    lnYJZ1clUlwIjGXHg>
X-ME-Received: <xmr:bzcGZ0h9oiIa8rS9mTvHDxAuudzm8QLXFXpqsRBlzKx6n4mSbjksnycD0gHDBiKnO5jGvF3aMKhLWv3hmN9KS_1TuXAEA7BV32FmletkOUcZ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkuc
    futhgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeev
    hfffjedvffekvedtgeduleeltddvkeduiedvfffgudekheekffduhfegudeigfenucffoh
    hmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehnrghomhhirdhisggvhheileesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bzcGZ89zAe942Omv6oeqlcsYlKqdpS3l818s9_Z28ikrcFrNt4QxGw>
    <xmx:bzcGZ3sNwpKwCjIzAqA0I4AeOfoIM00zOZz13Yb1VIIwVRIp3zTC4Q>
    <xmx:bzcGZ7HbBm0F_oFmAEswsN0_4xi1mHowjHko-JfKk_fi9AoA_VUu5A>
    <xmx:bzcGZ-MhFg1YrWFhfsHzDkUcfyPg2L_QXXMrDprtfAV7BLUnX3FiPg>
    <xmx:bzcGZ3KmkuVl7VojlZBC7uT-35CRC4aWqp9UVG1_iJnKf-9Off2jFt6L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 03:57:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85c29baf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 07:56:30 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:57:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy] Indication Of Interest To Intern At Git
Message-ID: <ZwY3ZtHPBWWHU3wP@pks.im>
References: <CACS=G2yH+k801G0z4BO6T2Gc2c6vVDieSr=2B6kT_1P-j0smZw@mail.gmail.com>
 <CAF+8dM9k=z+KR6xd_1jhsM86e=BOwOKkxdJDbX2VUYeu8yMkdA@mail.gmail.com>
 <CACS=G2w_rUUntaCU2NXYODUNfh+kDRPiftCRg04TPapTM_KPSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACS=G2w_rUUntaCU2NXYODUNfh+kDRPiftCRg04TPapTM_KPSg@mail.gmail.com>

On Tue, Oct 08, 2024 at 11:04:05AM -0700, Naomi Ibe wrote:
> I have trouble finding a microproject task, I know mentors are not
> going to assign us tasks but I can not seem to find a microproject. If
> there is a link to available microprojects, could someone please point
> me to it? And yes, I have read:
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/

Hum, true. I expected that [2] would contain a list of microproject
ideas, but in fact it does not. You can find that list at [3].

Patrick

[3]: https://git.github.io/SoC-2024-Microprojects/
