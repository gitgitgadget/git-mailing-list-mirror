Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9328F3
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585733; cv=none; b=QpJ14HXn4PrRgP8SLqP7iFJN6stu+fx800n01/hFgiTBztD20f+0nWbKEkgtF0+n83/gsUbkGEsfg+hzxHot1uLL0oTAniOanS9ll8Y+cImbiv3TvPNx1NA5VQ/VWpQ5EIkQY6Or31TZwAOWxmuMpo2uqQ9cndcxD88lo9wUAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585733; c=relaxed/simple;
	bh=u0Dy4gjENu/2+s5XlHDnxS8GQdxSlAUHxAVzY8tBHw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzSKm11b/tFHCRIlWeFXs/7C7BGmzt2szFI6m/l/JNfX3++cgZqBfg2IhoRiMerh5I33G10Ki9D4sPj2365rEXy2MI8SNq0/rd3OmjSUbYtGj5A8hUVB7chIQsHwLPIKjALgeGJoTpf3PubVmIBxnjGQ7y/oVpXyyeqsJImy+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PCaneWvg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mczkPPZs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PCaneWvg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mczkPPZs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B25A6138113C;
	Wed, 26 Feb 2025 11:02:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 11:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740585730; x=1740672130; bh=u0Dy4gjENu
	/2+s5XlHDnxS8GQdxSlAUHxAVzY8tBHw0=; b=PCaneWvgHlp0t7Z4G7Wej11+3v
	NsZ15Q8qORuImBHA8iQaJhsvCzfF2Nt8URK0h2qJS+JjQWNhAmG/GaKCvrVzarQp
	gWLp/kDhPfnMQM3wIGWPLtdr8gGCOKexFUjR9E51MkNJNJ5Ue3Ku2VFYd1NZH5YJ
	AH6bwB6SpN+seZhkRQ+wkPvGdW+n2m4Uc0ClgFyTmhTL0b6MZNf5jZVxlH87mmUO
	v82vOh0RgVhWvv+aXlkf01SQr3igPZkSCGDWbEH8IT0XzUnLRrZ67VXeQVRy3+zw
	Y0llnaNSUawHlGm8pNkVB+nOXUV7y2YoqsxWPVNczgeVlYO1jauxhfn0Sq8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740585730; x=1740672130; bh=u0Dy4gjENu/2+s5XlHDnxS8GQdxSlAUHxAV
	zY8tBHw0=; b=mczkPPZskyodeWuJUgHrLxTyzpFcXht9pqwFIZ9PvlvvyQ3+hEP
	DPyZHItXcirCvlKt0F2bb2M88k2xAeFC4WW/dWS6RyJotR9K7REuHH/mU+6SvXc5
	TbKlqfdPpLTsKQ3nstezY5X6hExOoOwJQ5UucZrzifV30gD9aq3+JTz0UOUOEO6p
	0HhnGlMCW983W9fo8u8U8mJBD8LkiXnURoDKARIK+mDRoqWIVB43jDq72+mZbq1G
	/85rfAK2PFX7f5Cu9QbXoochePjJsEHYHKYugvIUnMqKV/TqTPS2uI4SvOn/Awun
	mw8gIFG8yJ/41ibQdsEdflskMnEC+W5Rc1Q==
X-ME-Sender: <xms:Aju_Z8nb62GaRWLCcW4F5YmnDFBSViZEd60WbOtKWIzuIbcIDLR35A>
    <xme:Aju_Z71GJcwvTu9NGWyIv8CMVql3z4ex8CjBSgD91CN2goqjd4VI_D7KDWXWk6cPP
    hk2AndyXxYjWVxdqA>
X-ME-Received: <xmr:Aju_Z6pECX1RHaS5zox9y6x-Q4l2cqJPhJkG3Or3qnJjHCWakFFA3xCI6aHDM29lJz0oE_vyjvL4EiIJsd6jsGtWLHuvPLiNhv0r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohephigrrghkohhvrdhsmhhithhhseifihhsvghtvggthhhg
    lhhosggrlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Aju_Z4lkPo5n8Jh-t4uoHGDA5YOFOE6d9UlriEnByHDcgaJhEJZCaA>
    <xmx:Aju_Z62oc1dRYwuxe--bc8p3wJLRQ1edWVChru-zTlsp6Adp03BIFQ>
    <xmx:Aju_Z_vbLCwqt4OlP_9Cy82u92e5BZ9iQBuvlNUDybHKUdDmQFKmmQ>
    <xmx:Aju_Z2W9vgTeBoQEaXvan1GET7nHr9I8RK6CVEC8HmIEaCHsJpVZnA>
    <xmx:Aju_Z9SzwoPf55JaXAOHSRPLzGazMag_L5aCWBKv_xp-vE-6MnnTlSlX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 11:02:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
In-Reply-To: <20250226080902.GA29996@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Feb 2025 03:09:02 -0500")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
	<20250226080902.GA29996@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 08:02:08 -0800
Message-ID: <xmqq8qpsg0e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Feb 26, 2025 at 02:38:23AM -0500, Jeff King wrote:
>
>> I wonder if we should consider adding "U" to the default $LESS variable
>> we set.
>
> Having tried this for 5 minutes, the answer is a resounding "no". It
> also treats tabs as control characters, making source code diffs rather
> ugly. ;)

;-)
