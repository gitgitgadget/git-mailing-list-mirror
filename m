Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD21E833D
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681624; cv=none; b=UyUnZKqu5Bao4vVkfryyPHR4mOHAU6AALl/DIKWGH1pRomEtx5KOkHXQgXXhL3iFJtmlMpe86Opui73EsavFcdasfEY2B1n5YgV4X04x7SUPaBpPlJS7t2ByjL8ym1zqrImmx/+JEZ7UxCIEdj+b7R8LZgQ3l2NEOAdnbxa+cDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681624; c=relaxed/simple;
	bh=p+BNvNGsEGlg57c1BeZANfIdXT7zkBTPmyYytkQFQ3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=imnmcokAD8zRh8/VAS1Nzf4KGHbhUWYN9wPY6qhoZx4/5jNnKdu+COoUGwUhoEkaT1fU7yLHtXZhX9GxV/enFv+jv6ffziBw2pM9LuuEGiw00TcushD+jiiSz70JT2lcC7zVVPpDDpq6F9VNL1QFmMUyOLQGpvDCHic6AZ1w1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FoZsruDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWJOoF1G; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FoZsruDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWJOoF1G"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A372C2540266;
	Thu, 27 Feb 2025 13:40:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 27 Feb 2025 13:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740681621; x=1740768021; bh=X36El6UiiN
	kQcQ49prhdJBqgoFyJkXoVrCjhSwIwLq0=; b=FoZsruDNVNJ3cgFBB4b9nQ7t6P
	tLFrYChE4XLOlwlXwlfAG9ayAzQKSZJyn5KtT8R7LOqB2whbHJY2+4TqYL9ABNH0
	J4iMaQClz/iTofBQQ8Y0AR01aF3RaPsx6g79syFfPQ5TQvALCHkp836IJGllSDJI
	lkaXTZo7H3HTdQOm1TNNRRTctRZhaG2wJ+nubtOa/cTq7AgW5g0Wn4MiKDrBzBF5
	+BQMNO/j2E5zvu5oa8+esf/lbsISj6jvjLE62NZAxjqIwMM08GkfSe4c1x8Gn1lu
	3PDt9IM0V+ZiYljONiaW2o8JMyz6xK3OM7jIo9yFpqOT/w2AAnJkV/azi/6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740681621; x=1740768021; bh=X36El6UiiNkQcQ49prhdJBqgoFyJkXoVrCj
	hSwIwLq0=; b=kWJOoF1GHJB5jjomh+yF9Yfq53b8oOnFudbQ/FbTMKLwG5POX0M
	zSLJVRd6ZXmRkdjjOnQ8qYN4wRW7810KoOc6+L4DkZUc/T43yMkq+wBwg/kbdGN2
	jnShSNA5WqUaEY5WIqX1UOs+LG4HdcdpmhRWuB1f4pClQKYGvJlZKSXokYA8GphU
	A88dqW9byMIVv8JiX0Rxm/r7Y5i4NlhD/F7+UOq+XYePajr8Co1D22ljHT6CkUwl
	AWTv7vkeAMXamltOCDF0iQriBDxoT6G2+ss0m0qEJhEufNRBDi4y/IQBGQf/Ia49
	s5eN9/zN1HYjh5mrLpfHtzfUq3SoDjdf8xw==
X-ME-Sender: <xms:lbHAZ5v8ixpZ_921BapjVu4PiZFuQ76EBztN1UkajCEClPOHJ8NAEA>
    <xme:lbHAZyfsZ6MjyBaYFCHF0i7Ezg4GB3tB_vp_KDOSpSCKdVbMpJtviNBuEeq1Wldbe
    4B4AvuHisgjhBKNtg>
X-ME-Received: <xmr:lbHAZ8zuvm7fPepe1Wq7QKzXomW4kv4Wb1Gl8l9LSdSnBPdi_o2wjiUhbpmHUK5oN8t8LEeA_zxGsGWtl2Z6HDXQ9vUENs-nNaNl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtghnrghrtg
    esgihiphhlihhnkhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohephigrrghkohhvrdhsmhhithhhseifihhsvghtvggthhhglhhosggrlhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lbHAZwNhygKa6K7AvuYDolwki9ZBn3itK3pZJ4XPNKWhlNGa0NCEGQ>
    <xmx:lbHAZ5_EW0gy2GFGiqeZWrW_mO3TvfqI09PIPdVzyFlr3eBCnjsMcA>
    <xmx:lbHAZwUuNOeI_AClzgMVjx6UHrvFJm7nFvD1_2Ebbk--8wG4J8vJuw>
    <xmx:lbHAZ6enyYcsXQbDrmeIn7jNtBc-w7HobX_P2ngVPANaul7QXgttzw>
    <xmx:lbHAZ5y-LRdjxDGrQ3XQDKk4fS_c6TearVhxV9uZ8ReegieOxs9Fo25N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 13:40:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Jeff King
 <peff@peff.net>,  Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: General output formatting
In-Reply-To: <18ed50b3-e5a4-43b3-a543-f9a3d2c309e6@xiplink.com> (Marc
	Branchaud's message of "Thu, 27 Feb 2025 12:14:42 -0500")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
	<Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
	<xmqqplj49rul.fsf@gitster.g>
	<3a58720f-a572-4e3a-bed1-cc7e8f46e3c7@xiplink.com>
	<xmqq34fz9v1n.fsf@gitster.g>
	<18ed50b3-e5a4-43b3-a543-f9a3d2c309e6@xiplink.com>
Date: Thu, 27 Feb 2025 10:40:19 -0800
Message-ID: <xmqqfrjz6xkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

> I have no opinion on exactly how to "butcher" the output for a
> terminal.   I guess it depends on how well Git wants to support
> copy/paste of its output.

Yup, that is a fine balancing act.  Given the current behaviour,

    $ cat .git/config
    [core]
            somevalue = "true\b\b\b\bfalse"
    $ git config --local --list
    core.somevalue=false

supporting copy-paste may not be such a good thing to do, though ;-)
