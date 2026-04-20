Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9C27FB0E
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667283; cv=none; b=Dx8IV4HPZ1Grf6SiEjwSOrgMwz2Qcvap5MrWZJ9F3KvZgLBoSB/ORfvOMsq+lityQKupKY+we2fJlEhLoh5y+ab9t7rugPu96B8fdFRRu86a44SxOkMCrdx0XU3KZD6lD7BL4jtfCNnQ3kxcFOiuIn9NqXhPsmzstzqGlImZ/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667283; c=relaxed/simple;
	bh=nUUsODGiPfW9TyeEY/fTAlb6xNcD+u+DXgN/YKEIhiQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdoMCPcE5AhYSbkKyXM5Nr7xc1zvULFR+MAgQG5qiM3SJS/xy2HUHRpJJEjA0vZd1mw72k7BV/FR4zQi2L9RaZckzZznwDYYiWoGRdtbX8tmnAJpJQ7RtK+BB5MYkIfpOfvf9sWYmDBNkSLs7U2iDqRxGuAPzfFegbpXh3AgaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K/NrQZt/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tb01sqZt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K/NrQZt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tb01sqZt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6DE5140004E;
	Mon, 20 Apr 2026 02:41:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 20 Apr 2026 02:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776667274; x=1776753674; bh=4Z2RCPbz6T
	OqV2+E5iMm8gBZKHdudw2Cjrip0CCQEKU=; b=K/NrQZt/wKdpQ4HKiOMPybkilh
	wHSjZfgXEOding0+E9afY5/lOVdnAKvE+1rcMdl6l6f86Kp2E8SdoSZETnuE1Shv
	VLeqQRvT99pWQk/636e0ZX3/aIiRxtJX2o6DREOUdbaBi0Jl0chLYwJ401bwBfor
	R+LDNNiPcWJVK/iMdNPMJQEaS5wIW8RRY6DsChf9ZbusyucCbvgBc/uNuq3bJW/+
	1+M5QNal3JRU1lR5nTPM5zxdSJWdQ56vgAS8LuDvo3RJpSbtXYUZgXFvtWtvzXqw
	srmmAI6Vipinqz/6nWm3q/j/GK2HD72NOpqeMaktCq7a/rilH4Pkn0EZ9vzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776667274; x=1776753674; bh=4Z2RCPbz6TOqV2+E5iMm8gBZKHdudw2Cjri
	p0CCQEKU=; b=Tb01sqZtiRxsr6dCKQDZDdOfHe0tllskG/IY4ClekR5Vozkical
	iYN1CCPHjeDzolQaA0Xqa/KuAfXm5gSyzU1YROV0BSurgAYF3lW5H9qS8uAwb8sP
	70B9xIKlKJq9b3AgzGzQOcz0Z6nr0DnrFZvpi5jEks+Cc27d7vyTdvDNRRCY+a5T
	bHqNtznMxJMTKin0bNMmGjca4N0aZKZoDf112rC1ezolg9Iyac+4/k7DSc9xMVX0
	I47t7x11PRH38ZEzKGqJ0IYhmUSu08HAIMJFI1wX+3BnTFypxSIEaecqiabzUPuu
	YyGY6aMyNIh+i7VC7GIEaBZcQctG/7HaW4A==
X-ME-Sender: <xms:isrlaYnu3fUwSm4U3GGx-inOqIhUf_iRYf1ytvaUTyvJL96OIQkPFw>
    <xme:isrlafSd63nwlN5lQwUuPVS_z2h4PA3ffp7JTjbYU04OfpnxAmPSyvkq7l-AQpo9Q
    HwKU97xHdGzEedu83QK87_We9yo_V2-6y5JP609qO3cd_bmrvSZflU>
X-ME-Received: <xmr:isrlaUCBqQIIUkpwOe92EjIL9_l3m08ZRr1z1QMj-_Q5qnTGa-NXoZxAj_NOx2ir4utNJRaIVkefctufMY796cfLss_UoBdjAu3tUyOsx0Z5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejueffle
    fggfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:isrlaeQLFvxX9sP629-2xQ09f4VMqnLsd0arw5iPwiH8LgYCwgaumQ>
    <xmx:isrlaapjozyhu810Bl1yVT79mZ5aVELBYY8sGeqZLZOa38w5oGaB4w>
    <xmx:isrlaYysZfRbRvvtVzySLUMjFva3E8qroM1QkgkIyx_48vfmwKf0qw>
    <xmx:isrlaXJJM09se6UGjLtTEZQDrgd5BUulF8AvrLZb6CzT3lKLYzcz4Q>
    <xmx:isrlaQ_YyMmntrPgiYky_vaBq2Dfo4JdxBf5dJHKecIs4SkahkGl6Lkm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 02:41:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1ea9d79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 06:41:12 +0000 (UTC)
Date: Mon, 20 Apr 2026 08:41:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aeXKf901jbfmEOVk@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
 <aeKHhHVPUxqMa18L@fruit.crustytoothpaste.net>
 <xmqqfr4twaj6.fsf@gitster.g>
 <aeKrXwdnHjhsVQBI@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeKrXwdnHjhsVQBI@fruit.crustytoothpaste.net>

On Fri, Apr 17, 2026 at 09:51:27PM +0000, brian m. carlson wrote:
> On 2026-04-17 at 21:18:37, Junio C Hamano wrote:
> > I do not mind a move to thin the set of regular files out of the
> > top-level directory.  I have forever been annoyed by my buil<TAB>
> > no longer complete to builtin (anticipating either .h or /) and
> > it would be nice if build.rs is renamed away, or builtin{.h,/}
> > are moved away, to restore the convenience of tab completion back.
> 
> The `build.rs` file needs to go at the same level as the Rust `src`
> directory so `cargo` can invoke it properly.  I think Patrick had wanted
> to put the Rust code in a directory called `rust`, which would move that
> out of the root of the repository and fix that.  As long as it continues
> to build gracefully on a variety of platforms, I think that would be
> okay.

I don't think I was the one proposing the `rust` directory, but I
wouldn't mind that direction, either.

Patrick
