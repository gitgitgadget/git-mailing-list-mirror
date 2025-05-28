Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D94685
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748475248; cv=none; b=MEMLBDJALE6j7f1SHaNDd20HQgnogRE1uB8Y+rBa6qOLoTRUGC2MipW6WVok4zlJ+SLSdpWHYfzO5MKeNFvLkSzrIPHv1FtjX4hnPGXSm6saUFB72opdDK7UBIbR7ZvQLlDJxH+WEOkzmLjXrlcR+BdER6iqzvp9376ySdnrdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748475248; c=relaxed/simple;
	bh=ttqZvkoBA9ifV4ic8f2J6Nv2mB2AwSPN1g5ol369Y+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TAkpzyC33Bdj+UnMnPi0PX781AhJWRb+jQD2TdQdKoTGAGnPp1FQAZb38KJ6Tb2LfAbDj7KuCJDzuFi+XIN1QI68gUlOcXxnsggOtLE4epJ+QqZckAjmC73BRexvhJtWAcSeQ/GtsYTY2XjiW5htcO2BLyGJ9Wjo+pf3lkrwOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vmiGS7xs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XoY93iN8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmiGS7xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XoY93iN8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08D4E254011D;
	Wed, 28 May 2025 19:34:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 19:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748475244; x=1748561644; bh=0t3j4mHYz2
	oN4MjEwfiN1Qchqs8Da5CIzDgkFrlfaIU=; b=vmiGS7xsY8tBRIoHac3p9K+TMi
	0LaTHh91R4q4t9UsKFZ+sxD9951bxTUevuvizM5cF8HuIIN2haWZiyL7vaalhoR6
	g2PBHPYckGS+Lw335MMqfPCtwYBrQ9SkLd6Y/r0wex3PEL+IsLxsF2uAB5QBfmJO
	mjDUoC6IoozL5rOjKdoaPVrDIE6xn2MaTsuYkaIPbYyhGK1cZqXNvnIj5HOsKTN5
	79XzVUCB3FwAduGGu3h/G1yVRvmrvXN1Kf0j2Rgnq3mqXBPgi2QxlYSQ9dt9oC4l
	RrErdBRypWxcpIcTZde4DceQB3OldnJ/40knAhiChAmODbpyxmQZc9Q3XIhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748475244; x=1748561644; bh=0t3j4mHYz2oN4MjEwfiN1Qchqs8Da5CIzDg
	kFrlfaIU=; b=XoY93iN8WYEWQsKVYiLj7lDoYiQtiK5iyxnBnn9NkYXMUEN2y6g
	ghYIvCJvcEGBnAwq9t9/91F+03iwSXy2GwQuyRPXI10i0nFgT54dAD9qLCvP8rsd
	rDc4vnxvGiEIF9iN0/pr4hiRTpL++Elfcx+ohwoh3Q0ZYG2axNSLFecBJgROZyQ7
	bCBIgsoXphPcgvj3Yv3hAsgC/YGzUgZ/K0uxGna8i0KL5GpQA7NgRJ4dlhuxXva2
	g4+zr2iLQ5KytGRp3NZYIfBWEMIGDL+K+hkwmu6aPGteelbhfdC8QMpcexbnzAWh
	Q/O3LSVSAZ/CVtWty/LhRshpgHgZBRHRmPg==
X-ME-Sender: <xms:bJ03aGsofzrAPSxohQVznBJgz7ql-1yKraf1XY8xaSszTy5JEQxmcg>
    <xme:bJ03aLdzDnuOzfXuTmWr2EBKdRf_2yVfeKENijRznJOpAjrUBDg0bw5WiOgDIdyn8
    21u6XDKPMTL5E78nw>
X-ME-Received: <xmr:bJ03aBwHMrdkbRUQ9k6p6J-W5bcmWBGh0cwLNBjzXl2_uVdDoYOL2QGjRw6KyGQIWaU2asirXVQVFrBpvcRH7UKb6MX8IqWOwI7BMg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:bJ03aBObYw2VbB7ZeN-FzSwJMJWo7rPpcCVjqAvzbbGf1jaH4VPgcQ>
    <xmx:bJ03aG_dg9wCA49lIuJotbY5AprwHSloCVpZTOpAxs2dhv7681g14Q>
    <xmx:bJ03aJWeUULMvY4eaGMBfgxiuGCl_pSAx9dmTbetJY-HCdBuVhEJkg>
    <xmx:bJ03aPf0M2ukb-E7dcXFRL5qX7pDj5UXuN2weGw_ARxvubcFKTsZsA>
    <xmx:bJ03aNrilk-rsqXQKcCuJkY-kG1dCxEPNpC9iiycdEuFDOkyzw9bCtjA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 19:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jon Forrest" <nobozo@gmail.com>,  git@vger.kernel.org
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
In-Reply-To: <09518eac-948e-46be-9cd2-64304e78af81@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 27 May 2025 18:43:10 +0200")
References: <1014npb$rbl$1@ciao.gmane.io>
	<09518eac-948e-46be-9cd2-64304e78af81@app.fastmail.com>
Date: Wed, 28 May 2025 16:34:02 -0700
Message-ID: <xmqq8qmgpaxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I have also not seen anyone really recommend using this option.

You mean "git commit -a"?

I actually do to anybody who is the kind of person who concentrates
on a single thing and completes that single thing well before moving
to another task.  It is a perfect tool for the job for such a way of
working.

Like when doing "git merge" or "git pull".  There, the "single
thing" that the person concentrates on is to complete the merge, and
with a reasonably written pre-commit hook to make sure there is no
leftover conflict markers [*], "git commit -a" to conclude a
conflicted merge is fairly safe.


[Footnote]

 * There should actually be pre-add hook to make it even less
   annoying.  After you see conflicts, "git add -u" happily adds the
   contents of the files in the working tree, with conflict markers
   still in them.  You can rely on the pre-commit hook that is
   triggered when you run "git commit" next time, and then use "git
   checkout -m" to recreate the conflicted higher-stage index
   entries for these paths, but if we had pre-add hook, we shouldn't
   have to know how to recover from such a mistake in the first
   place.
