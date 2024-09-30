Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426319F10E
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727207; cv=none; b=KSEygf0Za/uCr8uCmv/2hB8MLwkkC/YVKy4WoR34v6gtcmT6IQcrYcs17cuCZOAH3fbnhtAQ7PbKk/6lhJYRqkstM8TDVFm49d6TxY/PDt4+hR16QAituEY4mN3bsUPONYcut1FWFNSOs4t3csYiTwnzqoOANkMDW/P5jb/rFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727207; c=relaxed/simple;
	bh=6yyeBD+iy9MaItQ5BQQrm/uYMbl3r+nyNW83voqrEyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nehHsdjXQ45zQoKAmSfD6iPvX1iMglg/WhMx4hMIcHj3bw2xSUvwsRFZSUvI561DAlc7Bd1syMuwhpwy1d6TNrH2ism+TxnaYWaF47WEo+GZYM37TTVB7Tq2JLtcnmaLyThAmqPwnozf7TK1nvjPeUW3vNWP6Cc6LaR3+ttkS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sOLz9pZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDaQGYo+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOLz9pZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDaQGYo+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 44F701380787;
	Mon, 30 Sep 2024 16:13:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 30 Sep 2024 16:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727727204; x=1727813604; bh=nWCLRQYIKe
	OAPcPm+efXBC3lK3kp+AbVkRZ5riMXko4=; b=sOLz9pZJ6Zfyfd5JnpYANVFpNW
	udBhUujfwZMLgMmIXZr367I66M9NCfzaPKjHtY726lf5Ugjr9IiKicYj0hl7MWZE
	3xCiN+x9h1pQWGYn8SaO24JHxc3nIpUqZtHUYjkFOfeHKoxrX56grL8hsa0DaPpE
	4osbApZjmsKo34+ed9JEGaqfMoVcFFvb5ltvwuF5mn8TtgFxXCxy6ywkSaDIMKYt
	AuvwXMStutZS8jYXXOKDCYnBMHUKLa2356Tc0oKcnpHjvQFPM48TgerASEPkDZjh
	4MN9fq2MeflvMwA5eJKTYGqlvoHUw+w+X5Am3OEkxsz0raTGb3ZL2pAU/xAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727727204; x=1727813604; bh=nWCLRQYIKeOAPcPm+efXBC3lK3kp
	+AbVkRZ5riMXko4=; b=HDaQGYo++5e4w4lGpQZACc7s2UY1jXY/YjtL6i3l8Of5
	udc/r2zTsa14mW9KbQeGnn/JXkOO4XSH1EYMqcArcemUWUz7CN/xHNr1Rns3bC05
	q7MIzH7XEHLqs4XzraxT6KNu8p2l21bAtBRQoHb3V8eUYUsqBXhXY8bQtjHNbkXV
	ycTJe8eEKUpxBfDifnB/4z8BT/+0yuLb4GuEBhsL/cgg4qEDzE7uATNPgZfkG0Es
	sSaUFMJa/3hXEP9Fn1AEBiiXJ534OHzCHRuu32DC9zvVpMe6T3PIw/33b5LeCFak
	jdNOjk/KCp/nBRc+09KVvprSyrBvEXn7b2u9/Cl3tQ==
X-ME-Sender: <xms:ZAb7Zu80eBdbZjyVg7_ueflUx5VLJC5cHvSxPVY8fj6BqOXXzix2pg>
    <xme:ZAb7ZutfB1QDTt_oyu3cMM26k-KH_NX3laJrdf3S9G9ZKYSi9bGrugpQB2WhQK9tk
    ojzXQ_yQxExllVEtA>
X-ME-Received: <xmr:ZAb7ZkBRVZWMBJtkn85ICd53_hvXYDt7WBy_tCgshMyDuwb2taV0JQBpsT8IBlXyLOo6qdQiM-0Oq_ZKrr6SrVDFYUQqcZ_YttIDxmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepte
    dttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZAb7ZmeENujwmvfaLf_Glornz7FVqR6mAAPda7X6fLoGt14KOhFz-A>
    <xmx:ZAb7ZjOuYndBkBCJMi_PI93v43NmrpTY5yBd-ANqVGnGYFYRM2V04g>
    <xmx:ZAb7ZgmacM-wuRjNf9nNfI_DK05y4TLdGke7ON_OaWeF8A838aNNLA>
    <xmx:ZAb7Zls9P74T0dH6rlhgaEaxikTyNQ5zAkIln8YQppL-LYD08760wA>
    <xmx:ZAb7ZsrXJG3KVriilQ8eFOMvpkJCV0ICnbDH14Zg4Cht4vQvmCGfbiq3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 16:13:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs: mostly remove core.preferSymlinkRefs
In-Reply-To: <20240930192826.GA1803946@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 30 Sep 2024 15:28:26 -0400")
References: <20240918232825.2627999-1-gitster@pobox.com>
	<20240918232825.2627999-3-gitster@pobox.com>
	<20240930192826.GA1803946@coredump.intra.peff.net>
Date: Mon, 30 Sep 2024 13:13:22 -0700
Message-ID: <xmqqttdw528t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I noticed these because I had a similar proposal long ago, which never
> got merged (I don't think because anybody particularly disagreed, but it
> fell through the cracks and never got picked up again):
>
>   https://lore.kernel.org/git/20151230065343.GA26964@sigill.intra.peff.net/
>
> What you have here is (modulo the two hunks above) more complete than
> what I have, so I don't think there's anything else to try to salvage
> from it. A little bit of the history in the linked commit message is
> interesting as to how we ended up here, but ultimately not really that
> important.

It was useful to find out another reason (which I failed to mention
in this series) why symbolic links will be misleading: when it points
at a ref that is in packed-refs.

Thanks.
