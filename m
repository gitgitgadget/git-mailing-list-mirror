Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D6292918
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324425; cv=none; b=OAiH1RzM1jtmJkKggIT2KHOdarMiCh9zQtbxzmBLSHDftidJI7wq+XweH4I0m/874M3j6iktCKw6upyIta7naYbbMWWt1GDZUsvJoTT9VA5WpcjKoyzh2jwBJNZvTPJ3sNfQGQuXG4qx+qgDsL2RFW8J5M/pVJQoFiedJNsdQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324425; c=relaxed/simple;
	bh=KqpJH7mXOqApdggpMyJCqxDdE7QBrqQ2rhjdzlNWBr0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHgP1p+GA/Nzty/V7nGoonniWTmlKdm3uTsRqUAqD/LFVvkowv/246rtTRO9HWedI/NE72ml/92ib5qAc0hcTvwGqZM7sEA7WefbJUsi0PKg7eKM3wKCVeB8GOjl79Oalp3yyAvs09r5vvZ3sVKZev4uvgqDYnyoAsNS6jMrmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aTGr+U7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdDu9sGI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aTGr+U7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdDu9sGI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 121B81D0009E;
	Mon,  8 Sep 2025 05:40:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 05:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757324421; x=1757410821; bh=54zIsuU4fO
	hm4SVQE33avzZkyI0RPyX7265Q19zDjjI=; b=aTGr+U7Sbgpz7GdqX78gGn6CbD
	4d12oqEL92LWVvYH08wSjfSpINSa3uYc4kdCIX574yVweRJLzNFrUd89kj1za2TI
	ZKu7485fBHrHcD9lzgJxmYXyR+zFPtv5LKvE209Lyx9WB4O9F4EltZPv+9PWTim5
	1/xXVwyDgg+f9btVqxrM+eRVysT59GFrtG4/Z9WZItNTfb3ICbVpBG1Ir/mImQSi
	MRHtXoO2jlr0PKu761LhCJmadeZwMvr9ieNhksEnpE5ZGr5Ng5+5FqUr7isHWo3V
	fguVYaepioZNg29qAuooEx/7HyjsCxRlOI7uQ3sZLHwPnQn22nVm8Pfix9EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757324421; x=1757410821; bh=54zIsuU4fOhm4SVQE33avzZkyI0RPyX7265
	Q19zDjjI=; b=cdDu9sGIOaG4DZbUHXf4CzZKdBcGINO2ata4QVukMXUy05p63HR
	zLufULnHfG78WVIGXUtc8cWYAu7GpnNLaHjbKkntizfBEECCJNB+MPl23evKJcVz
	ddDNElkC5X+W5IwZi0pa/b0+TrFLRtcAnUD1PKce2hEA7iUf28jLrBXmk/GRosHk
	yMG9FVY8csOanOFeN5FxJzf6P7gffBY2Qx8ztln9BQP6pZmG9bJBm1+HJsVHYeEp
	40m9sCz+Pn9pixktbnELWUpO0nbjGyCh/cD8hDV3kvcalnXIbHJ7BwQ7BGJnI4A0
	fUHTBd/CVq7s9Mi+gsyKP/CKO9RzbOXkTOw==
X-ME-Sender: <xms:haS-aFKcoLLcJlG6u59M1Bcto1JY9aN2SurF9QXf88KZoDU4ZY2BuQ>
    <xme:haS-aEZD6sY13VYjj-eNWwAgKUfrOFTpu42OY0wvzgs-aT-hVv171w8DkWx2EmEWj
    k6nIL_gXq-OoyLVHA>
X-ME-Received: <xmr:haS-aHIMgstGK9QvXefQY5LYE1wVK_a0ahzTzZBNcMcESxfc69pQNT78f5QiEvCBLU9pbPdC8OySLwkV5BVeQG0YWmEEs4DWGRxmUpZoyfHL6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejueffle
    fggfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhilhgrhhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnh
    gurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:haS-aCA0Bz2AfUsTgqbWMGPG2wYf1v429Rv6hE7iDLG39cMEV-MOrw>
    <xmx:haS-aMpy90zkGtZb3kxTucgBfYylGrsu0NgDzaNU9pLynHYZTrQYvg>
    <xmx:haS-aNhliIIocH_UHRKXA3Shza3-4n0ojgpUvPSpNet9C2zUjKMwnA>
    <xmx:haS-aJAt4rVVXdKrk2tEqnu5boATyfhoTUesFmwgtoIw0_rzmF2COg>
    <xmx:haS-aKZoe4pkoXGwjc3iLNmHyIzg4BFv1fRpyCKaevNKwoAzSc0EGV3j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:40:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c279ba17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 09:40:19 +0000 (UTC)
Date: Mon, 8 Sep 2025 11:40:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <aL6kevExmhesoEWN@pks.im>
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
 <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>

On Sun, Sep 07, 2025 at 03:07:11PM +0000, brian m. carlson wrote:
> I will also note that the dumb HTTP protocol doesn't work with reftable
> and there was some suggestion of removing it for Git 3.0.  It certainly
> will not work out of the box with Git 3.0, since the default is
> reftable.

Yes, indeed. In theory though reftables could also be the solution to
the underlying issue: the client can be tought to read the "tables.list"
file and then fetch all tables listed therein. The result would be fully
consistent, unless any of the tables gets garbage collected. The client
would notice and abort the operation, after which it could restart the
operation.

In that case there would be no need for git-update-server-info(1)
anymore. The "tables.list" file sits in a well-known location,
identifies all other tables we have to download, and there are no
atomicity issues anymore.

The catch of course is that somebody would have to implement this :)

Patrick
