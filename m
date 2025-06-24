Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A532D29BA
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781093; cv=none; b=ZwO6f7LXZkH6HI0NNHQbclz9gkJubYuA+mFqaldTP1M+t8p4Cc1ZQsre0sZ/ui59660Leh3qbamHWeVQXmKhQZn69G9AgwZZZY3iF/AjXOw6f/ufZ/+e5pH5/L0Y8YA8M21TOXLhQWFMJdJ8ZnXt2PHNqLFQX09gORIglKhyuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781093; c=relaxed/simple;
	bh=XNRfhRPWmWbIZqyYXx67C4F+yKujgkUd+DiWzmwyGMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wiw/5X4etnRwydqDbbLccRQm53ZPDxMcqozdiAkx2z+z1NyQYodFfFF9hUJEnZgjtFsVdIesvU20PdtcGxSZV1vNxjez8gikd9mH2WDT1wHVyKSQVJJyF1svk0OEX5oMwSd6IIuAKFADcEvPyvhEhtTN9reV6143kJIVpS5JliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yC6W19q0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKHoAmKf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yC6W19q0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKHoAmKf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E549B7A0160;
	Tue, 24 Jun 2025 12:04:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Jun 2025 12:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750781090; x=1750867490; bh=QIooObxMWY
	cVnBYW+q6OllSbiEJsnwOUlJzKOTJg5Ko=; b=yC6W19q0yZQH9iRrE9BRDiVd6R
	NpNkzoNzB8ss6BYPgejAHZ3m5cAJBnvAJwOJdiYD0HcPuBeXu7jaHdcd9/xGPurn
	c+mTM0u4tcOirzAmbhje73TMRLGzxlil58RiB5azq1kyWbP+BtJSBTqztpSd5ILv
	vmaa8hglR9wO82cscENXUo5NEQafQUHAHDEX5m5G8WdiMYsjUjAnYbAYdNqVaSBb
	/7nhO5lFKichA6IA6FcRaKluEuX97PlysWXhz9vlkovCCh+YXLARLIyEg/LlAiLl
	0AgaR8EbQSzjCDd2G9jyGYTG/n/0QcK7J7XrVVtmxuTPCJ7xZsLFZVc+hLzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750781090; x=1750867490; bh=QIooObxMWYcVnBYW+q6OllSbiEJsnwOUlJz
	KOTJg5Ko=; b=iKHoAmKfBU1agDoqhWN5NoSXbTKX3zBiVNdjK4lIbURCDGHz1Eh
	Rk2x8pSXRw52BUmna6bEevkwypOLXmamll+IHBYyEVmsWQkR4kQybcm9GfK+5GFV
	osLBvqazG48s/SbG4qj73mVWW0bDisHqwOy9DMdwypNL9CrpCF95zZ/VWKsDcWmx
	/ukHY8BnuEC9YSyp6zYPd9mIaAn5Szno5nnl6C4Vq6JnmDWUT8zx6qyGbc1NhJ5p
	tf7WIbkoLKSLzpOusQrKcBsAa8Ro9jbdpgRJpJ++RHYmSJHuUJU3r7RsM3t8crH7
	igEgKK7DoZiSCy9/FDI3BX6caJwG36fec+w==
X-ME-Sender: <xms:osxaaCxicmPdb3StqEIQvjGOmt2L-FR_ooKMvAX9YBtkTer0I2KOEw>
    <xme:osxaaORwbQypOV141ixrhOoI0ekJNMuElWxbi9HPv5YsrcLKoVht1VZqdKyPbryxw
    qwecwaEfk53DWZVAQ>
X-ME-Received: <xmr:osxaaEVBll-rRRb6ztrCwIF25J1xPM57Kv3dT6KlDa_fBfmuVJdJOHva8KYY-tUb_Nsok-HiJw2Gq-WWECu9rTDUTAHJEDimlqfgD5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghh
    figrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:osxaaIg0Hfh-kvxW0C7SPI1xW8uKcrN-26DkvclCTqipI6DNaPdBcg>
    <xmx:osxaaEBSRXumCgA2QW5ER59hF9NPYSIOydpl9NiihEYNTLrOrH7wug>
    <xmx:osxaaJIhUJgME_vQlore_7zA0AuRPofn8Ob3LXZ6_xaI_5TSskSQuQ>
    <xmx:osxaaLAIfdk6QkyyE3NwJfy9xU274PHh6FjRAyMoE2w3VQdPLCqCig>
    <xmx:osxaaAvMG_k0nEXzMc88cV5BlxmaPdXvgaS_PoKXgTD7XymAKyMdyddR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:04:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org,  Andreas Schwab <schwab@linux-m68k.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <20250624014857.3748-1-maxim@guixotic.coop> (Maxim Cournoyer's
	message of "Tue, 24 Jun 2025 10:48:54 +0900")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250624014857.3748-1-maxim@guixotic.coop>
Date: Tue, 24 Jun 2025 09:04:48 -0700
Message-ID: <xmqqecv915y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> Most suggestions from Junio have been applied in this revision.
>
> Changes in v3:
>  - rename is_port to port_num
>  - directly return scalar value from getservbyname in port_num
>
> Thanks,
>
> Maxim Cournoyer (3):
>   contrib: use a more portable shebang for git-credential-netrc
>   contrib: warn for invalid netrc file ports in git-credential-netrc
>   contrib: better support symbolic port names in git-credential-netrc
>
>  contrib/credential/netrc/git-credential-netrc.perl | 14 +++++++++++---
>  contrib/credential/netrc/test.pl                   |  8 ++++----
>  git-send-email.perl                                | 11 +++++++++++
>  perl/Git.pm                                        | 13 +++++++++++++
>  t/t9001-send-email.sh                              |  7 +++++++
>  5 files changed, 46 insertions(+), 7 deletions(-)

v2 and this iteration both have all messages set as replies to a
single message in the old thread.

Please make sure in your future submissions:

 - [0/n] is a reply to [0/m] of the previous iteration.

 - [1/n], [2/n], ... and [n/n] are all replies to [0/n] of the same
   iteration.

