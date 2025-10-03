Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6051DE8BB
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518784; cv=none; b=mzeSkuvi9qUS832cjtmdXWsNMW+iF5VegQ/aph/afBPNWamhxVg33c6rz2t1Qr+Quaj+3c557XLRN+ZLtGTek1YgvW2XNGb3VZZWmLXpol2UPbs78l09Ss6qqBA9JwB5h+R25YtC4ZNOJcfVryxezVFhMQfn4WzoVitxSOkhZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518784; c=relaxed/simple;
	bh=HCxAb4eZd97DuV9vtWqt63LLThv+NDIaTmZ1/EQFQJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrE/ETRjKKclvEcY5PdnEoqk64o6QXEKu42e33p3I5A0LZucmrfxsoS7bhDCb58BkQnXEWyYtWIB9oK1ZLmZMM1I+Hn3Aguy4H+3BIN7lTZ6VWMfPyRAGKwhoalo6RCh47XirfZfIptkDFnGvBNp6XGsTThbUbKHt9q0zSO9h2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eby03bTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHksYaGn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eby03bTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHksYaGn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DCDCAEC0073;
	Fri,  3 Oct 2025 15:13:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 03 Oct 2025 15:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759518780; x=1759605180; bh=HCxAb4eZd9
	7DuV9vtWqt63LLThv+NDIaTmZ1/EQFQJk=; b=Eby03bTPwjVKZ1uzI5EZOGPSU5
	Y7E3MpWnmGtYcBv9b3ezD7MHDXty/0V8w8f5YfqRmftrcdyQ5pvd+Gh6VdTI1saE
	ABgtJhE66ryMB+TlOc8WTp/SlQtNLwqDzR0gW55M8Se7ZUrIfAOLe1F6zmG//nPv
	Bt3OR1d2QiNRr15SJ8oigxw2Gxq9ax4sWicqd+tXi6UdYDbzACoKKqE+LtGJTkck
	kzlgjNUPZDTY80y2ZGRkMbnLt04d4P/0noXbN1SshwePOLOg7VSnYjCaEcEdUjKW
	Mj52tVCFGBc6cQ1TPEDwooDqnD61D3D1XYUGfwPpXEXi5QQHvUN5wYaSOe3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759518780; x=1759605180; bh=HCxAb4eZd97DuV9vtWqt63LLThv+NDIaTmZ
	1/EQFQJk=; b=XHksYaGnx5kKoU+j1+lFFI6nHLUzBJ/oOIEw0hy6Q2RX46H5CYg
	qKLToBo0R0raILfeOaA4O/2QfP+uAg3DhT94W9Rv8jAipvf8i0il+Dzv7m34jThM
	irZpsxbPVenePZ96JUOQK8+3K8nM9hzWhsSy3lF3cqvth/v3OW7JxTDhVRqbkEWF
	PUFnxW4tjOAj/hT4wk6j0kt6V+xl5Mqwp1in6mLjfKc7oiOS99iiRJ87nDz71Xfi
	20egUH8ixeMPZA1Y4fuiofdOuSxQ4RC2v2AZ2BAb4t7maCvSNJoJN0TsquT09SFI
	1MEOaASB5n+iZya95mzp8x9yg8n9KG1v9pQ==
X-ME-Sender: <xms:PCDgaLSsq0sG6JoPQaoyYgPOjIm-SV3hpxqABlaJlz5h7RgWxnK3Mg>
    <xme:PCDgaAeCo7qaQ3_YBJtItcGbyAYtHUMNRutfF6Vimg_8EdThDqqPCo6Xy8xhnGKSl
    23HNKkg0suLKQcs4dkaksooOtmFBsRlortQforKkr7wsSTY7NwYjA>
X-ME-Received: <xmr:PCDgaKoBqJeYPupQrg9fxAp2Yj3y580zlbmWCqp5TXSItMBAHjSlaXw0mKIAZPPeDHoBfoc66bqIEigoNED9KxcBTOKZcqwyLvk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:PCDgaB_hrFymdbhYsKMEpVGSp8uyVmNcM20ZowF8E2FC5RL8SW-rAg>
    <xmx:PCDgaGeD55gPQl8w9UVVtKoOUpt5RmzQqJcu2TQk6DeZIFoSapGGOg>
    <xmx:PCDgaLKbxR455lV1Q4V-koK3mUuJvZvtiVTGW8kOR7utLkoWmlCJuA>
    <xmx:PCDgaGitJZbUzvheTgMS-m1rd0EqxxB1H4Ycml8Ii_MDByOKNx83mA>
    <xmx:PCDgaE3OKZdVnw_O8X1Rou89hPMYFOzbGbneuuYQb9DIvSot9Ba6n50t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 15:13:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <a5757e8e-9b9d-424c-a576-1e70af3b7795@app.fastmail.com> (Julia
	Evans's message of "Fri, 03 Oct 2025 14:23:38 -0400")
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
	<xmqqtt0j33yq.fsf@gitster.g>
	<a5757e8e-9b9d-424c-a576-1e70af3b7795@app.fastmail.com>
Date: Fri, 03 Oct 2025 12:12:58 -0700
Message-ID: <xmqqldlru7d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> My best idea right now is to delete the mention of `git branch --track`
> here if I can't figure out how it's intended to be used.

As we do not have to be exhausitive here, it is a good way out.

