Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F157A67
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889979; cv=none; b=YyT1/wJN2Wc8oR3siEODmfG1loimgml7aSW81EdIxFFwbnIhmGpQMCj0I7cGrJnAUopvBE/RIvuw7zdYjftIOWR7LzECgnrej8Y0BvewNsmaimySdpiU4zMgDF2YJAy5Ij0XlTuWDjrFNjpA4fKaRgB1T8DWtz30QNc8wmli2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889979; c=relaxed/simple;
	bh=7ZgfHdsdQrrz4yjcLDVElTn85b4VtTypa8RElZ0KgOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPGpBJQLrqzKjmG1zjePgiJOLILUYl3Bf0sxQ7qFJMavq1j2vHGY/4LVl5nHk/H7O5zUVc4JRGAdC321wsyj9GmDsWS0CVFANs3uqnJ4GQgfdpFa20ianibvG/G3tC6lgQuqZ1p3pvlqvz/a1EVU/aHL9L3UGxwu8LpFiL9PI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IShwnmKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NeDZsyb5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IShwnmKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NeDZsyb5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F8D71380388;
	Fri,  3 Jan 2025 02:39:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 02:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735889976;
	 x=1735976376; bh=b+2Aivm8py9EsuIG92qvlHmYR1t8jTqd2v24miv3BGM=; b=
	IShwnmKJEQK++h1UZ7rWO2vQINXGkJ90t9iNXteOSbOqU2IYmdJwUGGbWPMyqJnm
	5qC9fecpgxQU+e4STYj91i9UoDjKbFb6iA5Xzf3JmJZ5gojtKM6GUbwzYIi2J3bz
	ySX9XaL+gNlwn9QTTE+61dVblNvORbZ9ad3gWMCvmUr46ehgdxR0fQfwoqmDngQc
	qunKRzY5vJDj1AnQv9LcAsav3F+k0NzBd/oT3o5gKZ9OejUGn2NpmmXjAP9SLe81
	IWlPlVtptg4wku3oZbi6h0AemXUDjasmtbT30juXZgwhNNFVjMXbfJV5pjBLR/8E
	c5KvOuTW61T/luSw1ywxtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735889976; x=
	1735976376; bh=b+2Aivm8py9EsuIG92qvlHmYR1t8jTqd2v24miv3BGM=; b=N
	eDZsyb5oP9L2XaAl/J/T3Y+9QUqdT0fa7WXmVbr1brIiXXCTrvhJiIriKwX7xWrW
	pi7PnWXiPLSFD+Ia8NkQmOMsC+8JUKwbxB/cMB+dWXU1jOFIppJv2043e6sCir2U
	4bDIlycCrEaO9nmBqOUkgVCfyzKtVI34FYKcznVvwDV6O3sIjiHkw8v6gI/bGJpr
	6OpGStTLvzB+RHTEix/YS2cyW6BiIP39tdGZLcWbcCdzNtT0fSuHsayt+sqDR1l1
	sNMr/DWTK7bfTlk+OLWB852wjgvbFFjxRPSoDEkyraAyV4B5ZvnS11n+QWyJ8+0F
	0wHKf6qmqjGl5lWZ6WuHA==
X-ME-Sender: <xms:OJR3Z9wuUuYm1Cfnx0df6bzpPskJO_Q4bKDh7rbKo9ogJuZQZK0IZw>
    <xme:OJR3Z9S33Slqc96IWCrA6AgLOo4yC1v9I7-lCAjbi-oqN0Z023ZjzhBlKmdG-mbP0
    fBC9TJCjwLD34Lr2w>
X-ME-Received: <xmr:OJR3Z3UVYE0yF5VGh_4gdaC4Fd7qlMlw_igvIgOjJsvq72ANMaUnBXueiAzm0gK9pc2Q-Bme4rIxxW087jXz9lxOKNqAoWdyzBqJ0N2k5zHAYhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:OJR3Z_is78fc09VyO2h__eytodPH1oNmaouM56cggyqxTV3j4s83og>
    <xmx:OJR3Z_A5VzemNnRtoJUBeiCYg46Zq1oN3NnS-7jirQaorirVI_1dEA>
    <xmx:OJR3Z4LnV_g-iS_hMgBPeUDM2_q6RdwTpIx2OoXdBaAwAXrXgH7ZOQ>
    <xmx:OJR3Z-Dv4VEu41ML7OTHFcJvPHKEXPyOurxuygvfMFWBBoQ0Nyhy2Q>
    <xmx:OJR3Z2P7kLXTM4ZhBTwWVEFrRgdaPup7hS-PrOxGSelZhdJ8402BtpMq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 02:39:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d98fd189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 07:39:34 +0000 (UTC)
Date: Fri, 3 Jan 2025 08:39:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #11; Mon, 30)
Message-ID: <Z3eUNedx9PNPoukE@pks.im>
References: <xmqqpll9xehr.fsf@gitster.g>
 <003619a3-f544-4b20-9685-866fd2ed1ae2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003619a3-f544-4b20-9685-866fd2ed1ae2@web.de>

On Tue, Dec 31, 2024 at 06:27:16PM +0100, René Scharfe wrote:
> Am 30.12.24 um 18:33 schrieb Junio C Hamano:
> > * rs/reftable-realloc-errors (2024-12-28) 4 commits
> >   (merged to 'next' on 2024-12-30 at ebc9625a4c)
> >  + t-reftable-merged: handle realloc errors
> >  + reftable: handle realloc error in parse_names()
> >  + reftable: fix allocation count on realloc error
> >  + reftable: avoid leaks on realloc error
> >
> >  The custom allocator code in the reftable library did not handle
> >  failing realloc() very well, which has been addressed.
> >
> >  Will merge to 'master'?
> 
> Reftable allocation error handling was introduced by bcd5a4059a
> (reftable/error: introduce out-of-memory error code, 2024-10-02) after
> v2.47.1, and this series improves it, so I'd say yes.  But of course
> I'm biased.

I'm aligned with you there. Thanks!

Patrick
