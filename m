Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDA256C61
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685486; cv=none; b=gpq+S81KypFNSxCgj4ZWIJV/IrQV1a6qUeKlsmQnTV9l5HiiekcMe/uKM1+OA6aaZvxbH+ydmqYSS19HBPpAta6Tu+TfNSJlZgnV3zlf59a5Le7apHLubJkVcw9Y1fRuP7XJ9QJHBPtOdeeHboP3UsUZ7SKpTkCV5lmJ3u2DCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685486; c=relaxed/simple;
	bh=Cg8X+9Y0eH3/YxrfWgzQjm+h+7xYq+K3o1Dqpa4Ic+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTf/9V5ET/Eqvi5UpgkWPZSlFIyRrwv7Us+PqdMeWgKKd8WmeqcWCoHVbdMhIRT0Yhu9qu2rve4FZ97VROj3h4oSRmxuwi4xPONNXc+d4q54XZBUuTPoj29U7OwoOFlW5uJi0fu6PvSPgsVLshk7nHh7qcjGQxDCHKj39HDYick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mhtnc/L2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1XtGzOk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mhtnc/L2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1XtGzOk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB1177A00F6;
	Tue,  6 Jan 2026 02:44:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 02:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767685483;
	 x=1767771883; bh=Cl2uKKHaGZK9ncQiUDMVENUpSqXPreHRm3oZXApDw94=; b=
	Mhtnc/L2uXhTomFFTTmQYXOgvdNBGulOaCYyFnAPRQ/QEKejtJN/yUTAIyhr7QO0
	NSXFSDhauFb0d0VQLZxUbjggpwUew/wPJdAIbbHRADukKVG7s/WYc/WJVCbcdm+2
	H+hpBAS5fDSlvarbtjaPH/WtcS+5nPkQkAJ3S9B8l5d6MbdKSON6brf7gf/wBIxW
	cuQ8ppofEdIduJ3MuVh9vqjcy6gGSgFn3ZLesV6jQ41XIFfbnyK8Y48pzpFCtq/P
	I6rHY/rnmIoEaozLGogVUHEqSW9GNAyr2uO4i/WRHkEbQaPnz3k/gD5mlJ5PMp2g
	UvecyhaV5m2jC+t9gReSjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767685483; x=
	1767771883; bh=Cl2uKKHaGZK9ncQiUDMVENUpSqXPreHRm3oZXApDw94=; b=Z
	1XtGzOkvXnaRMCxtakFSheJEwsOPlIMxrKBNLq1bHUFLU2P20PSCq9RX1uLfLQJg
	Hj4rUzhuznxV2Ip2BfljDw0LCIAygDjwZqm3uqzo6270SpJC/+wuRlyKpNf0xSGo
	OqWqQiAfPqO0OvYba0ruivfCTzvZs1A9nmC2K/d/DVyLEXqCRtNs4vAkzPpk507X
	sTqrDx12IgBPd6Xa7xaTCtzFTKBR1iPBm7p9G22GfMHixhilF21rtsJw1X945LTJ
	hVg+rBqWbnnlrHLfKLtQvNQ3SdaicbdDPvP0QyEnu3C6cwF1aWWfB+k7jQPETDok
	s8oEQo3eZWMUeUM8vVKpg==
X-ME-Sender: <xms:a71caXg-Vycc7sA6POx6fah4Zh2bb_89CuEzKOAztkUphqt_wag_OA>
    <xme:a71cabdgt3rMb0EuGYYeIzMlZA_qIwSLRKA85XYspEYxHmC6DSl2HwCf9Td0jxFo4
    HEWuscSLsiWkI6_aHGuoz4BA34w8vH3MM3m1MxHGkeHk0p3KC88Tg>
X-ME-Received: <xmr:a71caUegKhAGhd37Iu1jhUv7UDcZGBL216ykmWVAQJzbw7Z-9q73jHvqJ2ymrIjA-sVTL_SbpbEdgZaIevTOBPMHmWgjE7qwMnyjdPUK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrmhhopghpohhgrggtnhhikhesthdqvddrnhgvthdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a71cad-LZGoZJQeHFyJk-uaCLoVwshHBy2uo-5V-kTi9ODwL8dqcvg>
    <xmx:a71caYljb2Cal_Ei7cXDrIWdFcuiGTm27dyCe7SCj38wgFJbmPCTNw>
    <xmx:a71caX_4t70bQDvZYeb3yLsC5XneKqNWtTVVd12aVZw_p9zuKfzKUw>
    <xmx:a71caenxfbURfKqbHIWNl6jj3fojSs7JzLELTD6TiNvvljqjrwMe5g>
    <xmx:a71cabd1iTY4kGvVRlPmZzLrPqUgn-PnhddHwYUb4FSpjwG6xKzFsejw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:44:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a083412e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:44:40 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:44:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samo =?utf-8?B?UG9nYcSNbmlr?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Subject: Re: [PATCH 1/2] shallow: free local object_array allocations
Message-ID: <aVy9ZveUOg3yum2X@pks.im>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
 <277c8616a9fc365b76b2f4ab458cd927834f9e0e.1765303880.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <277c8616a9fc365b76b2f4ab458cd927834f9e0e.1765303880.git.gitgitgadget@gmail.com>

On Tue, Dec 09, 2025 at 06:11:19PM +0000, Samo Pogačnik via GitGitGadget wrote:
> From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
> 
> The local object_array 'stack' in get_shallow_commits() function
> does not free its dynamic elements before the function returns.
> As a result elements remain allocated and their reference forgotten.

I think the elements themselves are actually fine. We have the following
loop:

	while (commit || i < heads->nr || stack.nr) {

So while the stack still has entries, we'll keep on iteration.
Furthermore, there is no `break` or early return in the loop, so we can
sure that we actually pop every single element from the array.

That being said, what we _don't_ do is to free the array itself. So I'm
mostly splitting hairs with how the commit message is phrased, the
change looks correct to me.

What I'm wondering though is why we never hit this memory leak in our
test suite. I guess the reason is simply that we ain't got enough test
coverage around shallow clones. Have you seen this leak in the wild? And
if so, can we add a test case that surfaces it?

Thanks!

Patrick
