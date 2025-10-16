Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FC2E62AC
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652911; cv=none; b=WTNT7mjC6ZMecZ6qEh7btNVKnqKff/vN+F44G9wqcyBcJprS9TJD+Gd0Vwed9gf3jEQyqxnWQwfaBtLcUPJgPJRrTgn/rr5qDA38CEa5BtjuRvS9+hb50oU/rFsSRW+MDu1LJJIEBe4WsUSKZFXHeBWzFgHrJW2p5tb7PMnLq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652911; c=relaxed/simple;
	bh=kbcpn3pOAGUb6lmFTqSkwjJafv0NYjF5AbVjaiU5YRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LrJh6VgepP5YTmeqowG36ftWIguna+fRIkrkyWC6P2RRhOKLU3jCbVeS3X0MQRzWyL709YidEOJIa0xxYP51zqcBBmEIpIK2jNr5RcXsJOXR/az/DSsdgAQMdRRmpyL2U6yxDa0Lqz4PxT4tA3d5ln65atXxAlD3eC1rmTVc6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0urIYkS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+N0dbk7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0urIYkS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+N0dbk7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86D2D1400103;
	Thu, 16 Oct 2025 18:15:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 18:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760652907; x=1760739307; bh=g9ycUZ8YEm
	xP0J3KkNk9Ei6pO4SsSqVpxugxKXMsYnU=; b=Z0urIYkS/2W07tC8vJKVTWMNdq
	UheQD4B94MBSuAe5E+dCOLa0K13IH46k5gh6EVEJmVga5bX1mylEdf432oLxVVN0
	+jGGWMf7cumySUW5KEhRfeV0diWwONqfexdOapBT0r0CFSLJ3EBPyiWqMcOihT4u
	eqVjRpKAsCKuqurgLLYr024KUvu/N6DDH+z6JnzRf6aVLQKm+9dgrFu+YYIxo+94
	DhVd1NuFmgmmnx6/Zp8KrOVYgMdOlDhVrHsLbCcdbMudNtUvwxov8Jlbj6fiRA7x
	ZYILwsoBDf59LKId63xmBqzYRZM/+GCjg0pQJa1vMemlQASiNiBAz8J2/L/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760652907; x=1760739307; bh=g9ycUZ8YEmxP0J3KkNk9Ei6pO4SsSqVpxug
	xKXMsYnU=; b=v+N0dbk71x4fJ9oMxoaUDj/MRtWrPUF8Nh2PzPddculxeHBGfSc
	fq/ficl4DFN8GafXF6EVAThE8Sp1vlmP0rtjieRYpp07Lxk23nwPjC1ZZwrdQUUa
	rjXWiktt5siVHYsDxb3vFHRBhoHmT6JuX3r8+k1hqRD706xN0lx12DyEuaWEfZvv
	b9qa6XNaO3wHyY9ah92jLO3TliMPTFIcd0qxm+WFz1/TZhv73lgDxEnCFnA8yJyz
	+qaCS0whJABR2RDJb0X6O0QIGn/GZpQWFCNLSVbO+ALax3oKPApCoPzfrYFGOzh2
	E9K1kuVcL3wyeAXXqFyg9tM1p9qhiw7zxEw==
X-ME-Sender: <xms:a27xaA3ew364IaVPQyFUtqLPTOBVnfFzo00OfUJO0I8T0xNjR0vy2Q>
    <xme:a27xaCH6D1AG3DSWfUPAo-VHZb02h_3QPeK3PGNFvKIEGCr7NID9knYr5AeJpXP7K
    QRBmTpFPyXsMeeX76FYfgx7bGXTj0ZbbW_mzICdmidsfxa7gefK1w>
X-ME-Received: <xmr:a27xaN4z3RNo7uMEMGFOQed_v5EveN4CVvEOX-r7Xk2mT56Jzij0vlPRshUBSwzg5Dqp0mPwm2yMu5DscWuDeXqJlzAb2UDUyQhC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhih
    hprdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a27xaIuXkF9paThfWtQJmkFBfC2A7ja7JM7liDRjwqppICnH7j44bQ>
    <xmx:a27xaO6dHIRst7QorIoVjg-Ne0WzU6q71CQO-TaRCEo_4INLLolHPw>
    <xmx:a27xaDVgEUDrpFp_TBAl52N3LgdFRjimFsPhjgRu2_EKwoCBjc1QzA>
    <xmx:a27xaA-onBJ95J_ZowqPvLi1RJc_tY8ioa5mPmjhqPJY4Dp0UmRuRg>
    <xmx:a27xaO-dddtXLILwFmK5JS2xz6OvsftQPqeGTa5c1GI1vWJIBZUiQ8kR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 18:15:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/3] add a message-id header to git
In-Reply-To: <2464e11c-32b4-4372-90b4-9a6302390e3d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 16 Oct 2025 23:50:25 +0200")
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
	<2464e11c-32b4-4372-90b4-9a6302390e3d@app.fastmail.com>
Date: Thu, 16 Oct 2025 15:15:05 -0700
Message-ID: <xmqqms5q1ok6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> But has there been a decision that they are going away?  Do you have a
> link to that discussion?  Just curious to know more. :)
>
> [1]: https://lore.kernel.org/all/CAHk-=whP2zoFm+-EmgQ69-00cxM5jgoEGWyAYVQ8bQYFbb2j=Q@mail.gmail.com/

I think the latest is:

https://lore.kernel.org/all/CAHk-=wj5MATvT-FR8qNpXuuBGiJdjY1kRfhtzuyBSpTKR+=Vtw@mail.gmail.com/

regarding the "Link:" thing.
