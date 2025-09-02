Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A01205E25
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833436; cv=none; b=gkFzoLkSuYebVWBLssL7tLJs9rjr50O0X2dFiI5yyGXUQsyqf2E0mast37Ds1E2+NHPEUA9sVaQe0tuu+mHOpYPkAoHHLNxk1dJ46UbRKryGfnJUnWPiBNomOlAD3TdbIjcqvkwHamvXgFNAKnCdrMRoyDeQnJsVjMjk4iKKaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833436; c=relaxed/simple;
	bh=TWQOu7LcB352DOvlP+mBmaksyhVK9iSU5fmoPmDnJAM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ayjEIcIQAQtuMx26jrBKoy1x15G+Jf0/HKaNE/xy+gcMRKctSEAlKNUpGKcCjzKBIAg/mVvkDN4FIsnYKZeG2Ff/FjN6bwtYOseE/1gvdlavcpO0AeAbbyAgL7OtGjRx5t/6E9+3RRU5MyvIMOFPhlKnCCSf5mjTKU3032mHEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=iB6z9nW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dD3ZuYYy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="iB6z9nW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD3ZuYYy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5C67140019F;
	Tue,  2 Sep 2025 13:17:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756833432;
	 x=1756919832; bh=563vlCekje5STBT6nGaaHoFzo03ewsSo2FbJRPUWZ6U=; b=
	iB6z9nW10lPDO4DR9pf5AEw7HGHya5rUNgHEIwGDybCoxCVRGuB1xcS+VfZaa1r5
	fyzK4vvXCqRWxpyRTgKK1ioRA3LfTWDIrGO0zr7CEAe/DdiYTmG+7XfDUdD9xQpj
	TkJeRMX8fULJciBSsH9iVvC48eC9VlKKyG+LGfPXcyy6u/WpdjAUjKjMBJysv3LK
	ocoBZIrW0ds/rGQuRMS9IwosvP9lYsh2T78Zsb9SfVPZYsJUGOljVO0hmHFZ0A9F
	O1Vah97+cGjA1OaS0mbAIyRn2dxH+siZMB7piEVsiAugiC84IljppCnGCf5dgy4P
	otRu72Fr9QOBnZ+kQpr2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756833432; x=
	1756919832; bh=563vlCekje5STBT6nGaaHoFzo03ewsSo2FbJRPUWZ6U=; b=d
	D3ZuYYy7d5npRbTCxu9TCQ+dfO6aVHPSJXL8hwjqZT7f3l2THY8VYltPll14xsBk
	Bf5HRJRTz9pHg1DEEmQvG/P1N1VVSYVv6MXgZ2t5hjYU9vFKdADZxqmDn9EfE3TC
	CRiYkKic2OwT7GCr5wm/qU/CdLX1bWwV9faw/3HI3ovsfMEmyImn0ypaVAZoME4i
	onzWAyZQO0KRBvvfbS0e7WdXQedEXI/oFTp8InlTG7oyLVNBJaaAD6VfMYLfj0yr
	T0WKsqNazqRFbuXPptD2nH3jR4RhSk9IySErNC/weHP/uEGRvuCNvSPBz11O0PJ3
	od9DEoI+U8UoY36jia1PQ==
X-ME-Sender: <xms:mCa3aAEUzVCz0sITxr3by4sxc_kfn5gSoLm3-J31zZPPXKrOOPErAg>
    <xme:mCa3aJWGLD5aw2hQi6k_41G3oMhYHb0rgu15y1G2FT2l0NLXCrxvyDXaA-0swcrKW
    tLEtYCSF6yQcC8Vg0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgrucfg
    vhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpefgve
    ekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvh
    hnshdrtggrpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mCa3aNO-oQkQIzueW18oDAcOeUWApQd8IHnlBF2bvpB1AMNfajz2Fw>
    <xmx:mCa3aJYHFf3Ug6gpClfz2f3OUeV5xhukSu2jP-k6b_DmFhRkeLE6yw>
    <xmx:mCa3aL1MowfOB2jqVVw6_X4Lx4DF8exQ1MO7bLNNV8pmR1oJ5Zlh1w>
    <xmx:mCa3aPeNoCOG6DYzhUsPq1RT3IeGRNah9FawuRyCsADUNL36RcUQ5g>
    <xmx:mCa3aF2SUWdjWzw8fD8ndAqxnFEnQD14uWheM_LlWxl-VreUhQSp5oU3>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 774CB780075; Tue,  2 Sep 2025 13:17:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvvqYbK4iQrF
Date: Tue, 02 Sep 2025 13:16:52 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <2b00569b-bdc9-43e1-8a59-540d13c41a7a@app.fastmail.com>
In-Reply-To: <xmqqv7m6nmhz.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
 <23a738981abd2073c70bbb5dd36eea050065e643.1756467934.git.gitgitgadget@gmail.com>
 <xmqqv7m6nmhz.fsf@gitster.g>
Subject: Re: [PATCH v2 2/5] doc: git-checkout: clarify `git checkout <branch>`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> The condition to stop you is a bit stronger than that.
>
> By default, we would not even attempt to "merge into the branch" at
> all.  If your previous HEAD and the branch you are switching to are
> different at a path you have local modifications in, then no changes
> will be made and the checkout will fail.  With "-m", we try to merge
> and this merge can leave conflicts for you to sort out.

Thanks, I wasn't sure based on the existing text what
"modifications are kept" meant exactly, and I've always been slightly
hazy about this behaviour. Will fix.
