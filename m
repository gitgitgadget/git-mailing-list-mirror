Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9522127B
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471047; cv=none; b=J5HlwQjQlvPx+SHTd7gat6vBiocgSOJDZ7beLui0RHEkPnnTXmjwKQk/6/37ARH++3hzrU6E2vPb3bAEYITskNlDY1G1Woyx/dcUDzgp8Ls7OvGUCeOqU0sD6YMMOapXVCBf6fe5lKipO0YXR9D3rlbifQTcahP9gmetAABODZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471047; c=relaxed/simple;
	bh=qr5xvmXRc+SSQ7uD/0BzSi+6OHBuu2zOETWygoilkzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AaCgUpCAs1sWDJNDOR5yuhrswPYOIsbNjZr2t85vTMEJOVO9y+ao9Uuknz7YMM6jodGL1OvppJq1Ur35oor3OLlZspLh7yoUzAmRG8jqzrqXL6pp+vajO9734ZC5eJ/qUmUBOfLrqGVa8ImJDJxyRyg6HlNkM68VejEsBtG5A1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uBW1GrZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iX3fsl17; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uBW1GrZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iX3fsl17"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBE662540100;
	Wed, 28 May 2025 18:24:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 28 May 2025 18:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748471044; x=1748557444; bh=Ij/5vm8NCK
	NP1RLSDEsfo5Bgw1w0uox4pl5o4jJSvfw=; b=uBW1GrZql5m35ktFWmrT0oyIZX
	yVOx2KgAepeTnIstpbiZJVOtoRRsB43YsFw19ZKyDn1dPUTXcFkqmhqPtFrOdVMj
	KzX/mkzdfZmcx1yLs46X7y+U9DG8TxbajlfBgRqsM4OHOckj7wbLmF/MvO9aMZdt
	/hon2xDoxHQSlDQxVaV0waWJ4faTUs67+NUo9WeyNnr+r9DUWxA9g3fOesKkAgSm
	YAHWRnQgxAtpfjb36Q1i2OPaPhSIo3f5U5nvlk5PHzlS8vuOp1nT4ELU+fLBLFLr
	y6dZKGc+ng5ye+kFBAflYGDHwSRsa2/8beDif7mp+f1FkPt3wOLMaY7rSOmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748471044; x=1748557444; bh=Ij/5vm8NCKNP1RLSDEsfo5Bgw1w0uox4pl5
	o4jJSvfw=; b=iX3fsl17lzuzGe0OVAdTFivgEhU6DSMuwBL6vjoxLsCIY6yxlvl
	pPB8QjLVbc4aHKlNH4OTBOLr6+mrtCFi70V+qMk5D1hq+2aXWFUvm7ko1rpZ1GzX
	k3C+L6FTHDkpJ6W/wKoWuTBCx61KJ2TiK7bFa5Lil9ZhJZ1ssxtRS1E+GW65/65B
	MGKsbR4QTZTk6X8sKVGURTeTGVkKDJCK3fcnRKu04U3KwyrL0wkMEz+M3seQQQDO
	uXXPz9GxRLT/neRogB7Ig5BcTALzFY1VPNZAh8KON/k9LDkB4VBy10+n3rYJyHab
	/0YkzwHHk7EWDsagdBprP/AllU7PNBn5egQ==
X-ME-Sender: <xms:BI03aALIPQBIdUtQSsiPUhnO9WdN7DEJULNY1yRo-8sRd4wog7HiHQ>
    <xme:BI03aAIRzgGVI-XpaSYyHVsrrHlt3FLE0QPNMYpZNsBfKwRxFaIyqgX0zpx3S791O
    3ZMEEntxyGzJeXu3Q>
X-ME-Received: <xmr:BI03aAtiPUmUGIMssGFNEjJcdk8UE6aTM4aaApnDgLHXuTxhH0qxX73buTmvIzRMkCq_UvHgJ2MSyuxKa2d6z89LKTdS9iYAlkiOSf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpdhrtghpthhtohepnhho
    sghoiihosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BI03aNYMQIYQ6juHK69wcq9-l4tF0-prMBUrMu9NWgAKIp0GY5o6Lw>
    <xmx:BI03aHZ_WVqIGzurUT3Sn-BVwmB2MJvdwhcMa5MlzqP9of0B22QqgQ>
    <xmx:BI03aJDlTTZmAOozYzl2HmDKyinJJ4ZY-qOEWwOhpG6GKbgQ0808Ew>
    <xmx:BI03aNavxw7n9J07n33z_XOWXmzYZK6fkEbbCzD3adrKcf2ORIQZ_Q>
    <xmx:BI03aKfERCr8p7BKrPOprGbfT5aq2ebLr4iEtbL8CnZTDuuR80CmEqfm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 18:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Jon Forrest <nobozo@gmail.com>,  git@vger.kernel.org
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
In-Reply-To: <aDXo0Enj4cQzKQkK@ubby> (Nico Williams's message of "Tue, 27 May
	2025 11:31:12 -0500")
References: <1014npb$rbl$1@ciao.gmane.io> <aDXo0Enj4cQzKQkK@ubby>
Date: Wed, 28 May 2025 15:24:02 -0700
Message-ID: <xmqqjz60pe65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> On Tue, May 27, 2025 at 09:03:55AM -0700, Jon Forrest wrote:
>> The documentation clearly says that running "git commit -a"
>> doesn't add new files to the index. I wonder why that choice
>> was made.
>
> I use `git commit -a` all the time in workspaces that are dirty.  It
> would be exceedingly annoying if `git commit -a` were to act like `git
> add . && git commit`.

True, but not quite.  You would want your "git add ." to be safe in
dirty working trees---at least some folks wanted so badly enough
that "git add ." pays attention to the ".gitignore" mechanism.

But `git commit -a` would not change, even if it won't add cruft
with well curated .gitignore files.  That will be a terrible
backward incompatible change for those who expect it only deals with
the files it knows about (including the one that is not yet tracked
but its presence is known via "git add -N").


