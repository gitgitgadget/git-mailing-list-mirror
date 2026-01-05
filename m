Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DA2DC323
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622758; cv=none; b=Aenh8eb7hhsIq1QxKFBJAwpO+XDo7solPHU9L3DutcTz7kb4y/YVQyBZsvbzHW8qcU3kLCYHUk+8EUVp5wiBDcwQXcc9BiXQHjN/pcGnVBHfXTcE+iRB0zDU6USLM8nCoK7aMeb3/+37um/IA9MNE8LhGGUuGRw/HzkssThiAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622758; c=relaxed/simple;
	bh=w9Up3Qoo7rH8Yaj8O63JnccwFHgNakPpJDHnQ0wbMuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAlKQPSG1F2SemQxict+zdznKZtYcJFzu2/NxBTfA61WUH5mJfoCdJturuwDbPzQgL5U5bOoZSl1wLptG1mOacquTHumc3mn0cdxOhSE7fCpPtAFMiz37AzoKedl9X7pBzgG/dYDOtn2lHBr0/bd6ISvCMHI713iybr1BsY5+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GZxsi7D/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuYc3wPy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GZxsi7D/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuYc3wPy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B91997A013A;
	Mon,  5 Jan 2026 09:19:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 05 Jan 2026 09:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767622755; x=1767709155; bh=9+SuoNCwqH
	GBNoiYaejaylkEKYTGQQEamT4dWsXM8yE=; b=GZxsi7D/MMSUxyhGVIZpQVvfji
	b3f3ZjJScPlgkNX7ZG5Uhrbs1OQICinAfFUzPmhAVkvbJnbl6ksuq1S6Lq4zUn+Y
	I8JFrSeUp+ttfo5CUtia2xMBK9yn7cno176gSn0MkiyySZBYMW08DMKmQ9vWrkS+
	8oWEqhLs+Tn69Le5BrCzFJ7xw3FbnS88KsQauXzhHYAyxYYiZZOw7mjjDucOMGAf
	w9elUglMdaGGVsFNYwoUQKLv7xThVqfVoKcxSbipWrY/vjz8ydVgZ7qBG5uGtv1n
	yjjvxXZKYQowKsurwowaP3KPbLrRJ1U6Gw7hIkNCZvzmPpBA4L65iDUYXjZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767622755; x=1767709155; bh=9+SuoNCwqHGBNoiYaejaylkEKYTGQQEamT4
	dWsXM8yE=; b=ZuYc3wPyOOxiz9vYAqXRztolRW93tBf+GkfCOEPrXFAABRx/UQv
	CNchpTL91tAm6nzP0atgDd5ItPhGfpOWQBNsP9FIEvo7QAP7aPSf3+RGtTWYI0Zk
	NZCj/2nkWx3gg1PSEkzoyzIIISDsDpk/Tw9Tcno9WtKHcI5XwABRLorNjrkFQtKY
	B0bkQJpiSsYtdFeL8qhBZQRGooDErYAUrW65sghf4gNqTu3yTd1Mz/nXEbhppXqB
	n6ep61ics0BAuHwgpWayNEbSomYz9LyfmbQoWk5KJxQD8c38iJyE0yF2gWqx3huB
	bh1ne5h6ZIMNF4B5IQpQVGTr9GnaTqqup/w==
X-ME-Sender: <xms:Y8hbaQc5LSN3ljr5oKo0oTG2scK68gtPyXISc2ki7jw5KgCdZMMJZQ>
    <xme:Y8hbaZqJw_Gi4EajLQ_m_Td2m1gaS--aSX_vglW1FKJTbnFGun46ekBd6O_vllVco
    LPdZ3saZ_meknRhBYOhnPk0rX7eBoZ4kDArlH8z8G4ED3UhCGAJrA>
X-ME-Received: <xmr:Y8hbae76VzjaPC-_Tai8CTSG4mWydsdj6wqgYodmc99FF1gMKbhNV7IY0OQr7u4dy3LINkDqYO7C67CimwER6ODj2QJb8nrhgyoraIol>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohes
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Y8hbafouGqmzn1eebnp3EMMKt3wJJ2LmWb7hm4Yx3V-lhdRdVeo8EA>
    <xmx:Y8hbaQgYNAu2_rlJZpLT4wIBIc_wY52qe5QFcz9ktBSakelawOB3HA>
    <xmx:Y8hbaZLstrTFcBPwrP7q2HwHQnpcNuKps0g1t4BusxJIq6Nz9rbtrA>
    <xmx:Y8hbaQDw2Gq4C805J9WJL00IPtX5vZqr5Jr613Zp93sKmZ18H9Z83Q>
    <xmx:Y8hbaVp4ScrBvIFrnQ8bTi5cVJnP6_Q-S_uA-pEfPRFVCQeELfsl-13G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 09:19:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e282def (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 14:19:13 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:19:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] repo: add new flag --keys to git-repo-info
Message-ID: <aVvIX42uh2L4yIO7@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
 <568D8DB5-AED5-4A6E-88D8-890F9E11A00B@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568D8DB5-AED5-4A6E-88D8-890F9E11A00B@gmail.com>

Hi Lucas,

On Mon, Jan 05, 2026 at 10:57:23AM -0300, Lucas Seiki Oshiro wrote:
> Hello, everyone, and happy new year!
> 
> Sorry to bother you with this, but do you have any comments about this
> patch?

no need to be sorry, I lost track of this series and didn't have it on
my radar anymore. I've left some comments now, thanks!

Patrick
