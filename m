Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFF3112C0
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678345; cv=none; b=N4tY+F9ANVR1sdq/brlCWgTGpVZbZLWH+qHj7UcX3RvktbltsUSAGTiZAilfDcdzfROGCQPQZa/5NqM/5X5bv+Pmqy16oqznuuJqY5i9Z4mXfFhr7TTCyyn+ShVlOrx/XVKE1x+HW3iwDerU8yEx42tifxI9dfduOIgA5StTxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678345; c=relaxed/simple;
	bh=mq+uptBUbcrPrQblu5MkhNJqJ5st+PAiDmay+AiaYeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgqR+NomBfm1TwhvgtCfS/IcRFOIoTqwiDHBKC10sHPSL0gKXGdnGc2PhFd2AACWyb79RFwtNOL4N/kAhDrgT/1RMc5jzcGPC28BxIyBD7WTmXWtQ3+ySVWCWdLdoki2c6PeCKxr8uszsu+hPKuXFLp+W+dRhOmFfUco/h+/7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KDlvwqv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdw82++m; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KDlvwqv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdw82++m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C251C1400334;
	Tue,  2 Dec 2025 07:25:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 02 Dec 2025 07:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764678309; x=1764764709; bh=mq+uptBUbc
	rPrQblu5MkhNJqJ5st+PAiDmay+AiaYeg=; b=KDlvwqv5LkiSDc/6GlhmquOPL4
	e5gtm4G5C04GkUbMzGOFEP+re8xQwGlVkWUD110LQBiQQVHhhKk3LkJUP4O1Txrz
	msGekILUQ1m8WmECddFPHcZBGOtYEpEdyD50JD0qDFl+dyZ9ADFdTaW6iY/VzQBZ
	GwoL3DPJL48VlXhnleAwYU+zOSqElE9KGuKmNexzAE/sSOg72TKkUqlut5XzVSXB
	SnZ9NQmYswQBOtteCyemqxxvCOckFfMz68t0GThvwCK4D6+xKrAIG7mhtTQbpHSa
	lOSuGVRfwdbwjkD+f00/chdkMXUvMWq0oAN4BY8kuJNbhJYnrhw1yvirzZNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764678309; x=1764764709; bh=mq+uptBUbcrPrQblu5MkhNJqJ5st+PAiDma
	y+AiaYeg=; b=wdw82++m8zkcrCIEqEetb86W0fzVsaIUQ5kwsAbwUsn8LUq/nEx
	q/17LSfMuggchA4qZ/OW65yYPqoWQWhV0M08m/rNLjiTDxaJCtNXGjEep1+SBEMk
	gkS90zpTuYsK8Qu6A7byJCBx8kst0cWH0/mY8Zukis28D6ug8MdtfYXKS6mb10R1
	YSNTnrGsU+wfbp4ZDKeXsq3bcjGhQyVXli4QaRjLpHDaOnOd0ClfNntoZ+xmtmJ5
	scBI0KdRtUcGmoUtlJ8Bb2tMxGZqrolPBmwn9CVAzDpX23qsFSJv2EqMlC9fquVM
	+4pxFdxBtFaRifT43TysvMCVHXOUXXrtbpw==
X-ME-Sender: <xms:pdouaZSIG1OdUxe9WakZb0w_x4_PKXMm6fR1LYIqHoTQdU6SHXhs0A>
    <xme:pdouaVAjrF4AXMBgdRYGFTfRAU2NVkrZqU9RDlB02l5Gh2ap-Ns1jQHQNz85IM0wt
    cGtEHChgyCvppBYT_FIcHxiTAO0M6h3cm1BRfaKF-eWhNhtmWI1Bg>
X-ME-Received: <xmr:pdouaRHFCNAYgL_G_cFTxLtW3-4DjqNaRXQLzOmuHXgRhRRQ7LQTAFWzWX_Yj9uY3torYDRHJsOeh9RmG58fXP9aipH3lrzWHC18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pdouaXCcJG0TZJrqbCin0ZIwYwrKaIgY_AYuXkmWT8DOZ3MrwidgAw>
    <xmx:pdouaRUQGPzUDFaZWidwLKBUl0w9xn1OcQfT6KfQByJ7nXtXoewBVw>
    <xmx:pdouaboWW1DvPehgTBZ2z03o5AoVwjPjk0oMXR0eJqZoQtxU2GezSA>
    <xmx:pdouadQkhsBlgPGRpwgIj-TthY6Kq8vg0nQpX7-0Fo7wLuGmTV7mlg>
    <xmx:pdouaX235cXCBy7rEU8d2_zCVGaZIy9HGiTMPBsdTmG-IMfJ3-pGhyd->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 07:25:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v7] doc: add an explanation of Git's data model
In-Reply-To: <aS1OXhBcx0IegwRw@pks.im> (Patrick Steinhardt's message of "Mon,
	1 Dec 2025 09:14:22 +0100")
References: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
	<pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com>
	<xmqqv7j11nkc.fsf@gitster.g> <aS1OXhBcx0IegwRw@pks.im>
Date: Tue, 02 Dec 2025 04:25:07 -0800
Message-ID: <xmqq345t840s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> By the way, thanks a ton Julia for all these improvements to our docs. I
> highly appreciate them and think that this is sorely needed. Our users
> will certainly appreciate your work!

Same here.
