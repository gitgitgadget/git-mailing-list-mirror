Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73FD23D7DB
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307797; cv=none; b=W/lbKU4VKoJPjRikesxwurtk0N51GNkerDt5kfgYKKm1FOCmqh5uSqdPc12VtUsf+1DY3XXJusot21QFLqRxCc5iKxbUyp8PkUgpzp5GMOVMftZtCZkuM2mhJdbdsRUxf5xYHPQ60gniV+F+8krzLX+amwLk9T6KUUzjnaEjMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307797; c=relaxed/simple;
	bh=/WlVvhA+BAASAhJWpxuiWbo/uzlbJu2i9P5m1/Zs7sU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mR9M4WH3OWJZamLCwn4uX7iprYV54fjwuuMIOZL4Gdwj9LM8+budQSZnP3HbdyR01PejiFp4M6fQ1ABVtb0OL6pVInEW51rIs/KUbDr6jhQDbzrDTp7/E9hqlLgqCxQ3LM0p5tJvKCwwWt/GapBtSoSdvmcPW4/gDndk5Z45VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7g5DAkh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUkKhgpx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7g5DAkh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUkKhgpx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C958C1400111;
	Thu,  1 Jan 2026 17:49:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 01 Jan 2026 17:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767307793; x=1767394193; bh=hrLD4ZgR0n
	J7nHnEmbbq9rsliH5yMTIY5/msCLW/snQ=; b=I7g5DAkh0R/CD6HpG+PnS24Kkl
	mdBqsrGWKJN2kb24uFiMKBknUQS9ahrgxAF/fvQBc21gGD5mlMQD1t9QOg8smmzL
	JCUEsKfLikc84/c3fb/2Qp2WQFhx+KWbYaXKxW8RX9d5Znu4lKYq/byvrz66DVBR
	0ZbItLi6O/tqKOc/iLCYK8jysk20YvRatCqNxmxbShbPK6/3DOCJT8DZwH0Jqw7c
	qI6yz25GjgkvLNI9ltewfbIFrfU8Y+9ngjIisPFx/5fcjey+CUVldPXVZtf3Ep3Z
	3/TpRfEwX4cZdR9YRXbhggulwFF9rJDmftzZQGAt/HCQazzHM1dG58h9/KlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767307793; x=1767394193; bh=hrLD4ZgR0nJ7nHnEmbbq9rsliH5yMTIY5/m
	sCLW/snQ=; b=IUkKhgpxJEHMiyAJvVocEB2nIs1YBMiZkN2Wj1J1l615pN/kq6U
	TlCdmQmqTm8rDHcqhBN9EJqCNYyzVBXxhLtx6IgwDDrlPGjCg5p8oOaTKrSQuewU
	9oR8bQCy7suc7gF/FuSjIYZ+dCr+EbByGUMeL2fND5LUI8P7Ybz2spQxS2/bkO2I
	uVe1Y2k3r7Uo90cB12aAiVxtC80/kVP8hkpQhh2w3qNjTXxfJi62rln0cyO0TiMr
	++5Sx8wJNLMMsEvYnvR0ujk+v7RoVNo7fCUaLcN6oer89aFJwtpF88LPHQwz1Hr+
	ulKZ2P6oR/ct20T+VFLRZ8mZFOqZCX0WWGw==
X-ME-Sender: <xms:EfpWaW9-9DIZRq3pIEa0nT29rbqzr_In3UHP8hj-_HuSvz-Hf0p1CQ>
    <xme:EfpWadtPNI_oX5I_YaLP7XDcgSAFlUTDXR8LbJMEi3ejb1rQTvNOJSdGlSRde2OHy
    ZeaiRJCT3VDyEqRb_wVEQHPY0gYRY0fTLovztd_-e4yIdqGGVWCnqo>
X-ME-Received: <xmr:EfpWaRDQ0u7LpsWGyFtHm8DU2hE2bOvsmBRdksUVldeoUUaIh1qv6WZwy-oTPv1MChaJU6yx-TQDGnyDS3B5E6Hk6nlRW3DPZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EfpWadUEkZ7HWmD4plGZheVsjRybqnwXzYn0B6PAS9UbehKticCEwA>
    <xmx:EfpWaXCis6WWCoRQzbq92qKkh22OllZJMzCH4svA4cNHnCZuKQJE6Q>
    <xmx:EfpWaY8XQx-RCEQhpvDP3O70cgjWL9s-ejo3kgjAuTaUFP6UAJxb3g>
    <xmx:EfpWaWGVetj0h71HhqWMZ8c7053QEXMN-ZV6tGrw9xCthpQV7YambQ>
    <xmx:EfpWaZBiVF2sxWh-oFuf8lURNuQ0CCLhqKAgv4Ahozs6ODencElRfJx8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 17:49:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
In-Reply-To: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Thu, 01 Jan 2026 18:27:48
	+0000")
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
	<pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 07:49:52 +0900
Message-ID: <xmqqtsx5c5in.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v1:
>
>  1:  dd5b774451 = 1:  98bc88f336 t7800: fix racy "difftool --dir-diff syncs worktree" test

In other words, absolutely no change?

But that is fine.  It is clear that these changes would work around
the problem with racily clean index entries.

Are there things we could do to help "difftool"?

For example, would it help to add a new option to "git update-index"
so that scripts can say "I updated this file in the working tree,
mark it as potentially racily dirty", and use it in "difftool",
perhaps, or something?

Queued.  Thanks.
