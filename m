Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6171D6DB4
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028809; cv=none; b=a7Eu45xyWmsIDonOvs9ENlBCxKAnSHlYpSWHsCue9QO/3w5ofLz39fuRjTh0ppSnWsHP1vkFltpe0SF6e/K7G0XQYPfxuCbkDnqk8UO0x8TivP/phPt91veqiRfXtYI7CslYJhyjBBlZoeb91K5HJQCW/Y9avLRA59sK6pD7wQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028809; c=relaxed/simple;
	bh=e5ZJmsyhDGgDJuxSujB6WiD2USZ/QWps13OPJPOopRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwMqNF4UPD0uRphW+JR69iK1WKy/DvkioUycYBkNgi2V5bS2ZaRMxeHDLrVUKQ7hP6pAgzbLyqoR9NKYjx1CB+ttnp/E7vQboJO8ZNteFC3o2cJGlrrcXBC3XVSy5Ep/14hY9IU7kTFFlnSocTV40heGaofSYlZhLxDxTFwi1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1ca0GaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sCqlRWmy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1ca0GaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCqlRWmy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53FF111400D3;
	Fri, 23 May 2025 15:33:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 15:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748028806; x=1748115206; bh=nLOXe2nvqw
	Lna/nnNMJEDTx46BFA7unxdSkM3IO41co=; b=h1ca0GaLUYxrl4/ayUNGg3RvwS
	1l/Cw7+sRBF8FO3aT5bgSELAxZZEgAUEy8zNUuUpdYKcMyfXpELROQrli+WIUFNQ
	otQBiu0nJ3LihSDyYMbBenl6mp6W7CxjRs37y/lj2p61x+LJPMTiZNMUgB0XOTJO
	l4hfh2Ub2ivqajHPT2E5dkjSDSJdksVveAKOfTXqF1l0dlZv5OaMKJBtjNxBJ4jd
	TfDxEICVPkooiwcxcRPagsxJrCQ9sqCKttvSQIacQa5qYcrVUJVKuIW6lKbjkLiv
	q5tEZ43UOkx8pxScBfq7bVdVpsVW0TPlgjl37lXVZjVQCP7NP9QrTJLw2+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748028806; x=1748115206; bh=nLOXe2nvqwLna/nnNMJEDTx46BFA7unxdSk
	M3IO41co=; b=sCqlRWmycwfqTJb8UKReNW+gQCJTYhlObGnyIg2X7CaWz45If3I
	9PNu0lOtUnUCTjWOuwoAvvZ7A11E5Q94Z4MHOJjcx1dnSiEW8Ohj1xkbGI+E94wt
	Se7yXx9QO+9ZF3G4X9iQQZK/hh6YtS7aICX1QCojcw3InCzZ9/el24i7ng4/CbjG
	FK1RXellkFGdBipbygi4QkfJB0NQBm80GOf+hrDNB2dkjrdCyQxlKjYcNPdfTK1j
	EpB5Xv0T/vpkuSuio6q4SBPRw/zvutWurf7jRTJSRCwpjzWLtJuV0g4NSQ1um8t6
	myFmulaWlg/RvVvV1kNNadyLv2a6lDnB7CQ==
X-ME-Sender: <xms:hc0waEB0-eu5L4UPkDsGwk-EXBnZb9YC-d03Lzq8YsxGmZ3B369SAA>
    <xme:hc0waGgbnopS5lkvM7xpApjgHqAWDmCON3HMtqfgvCi7VEFDB2wzjhuDSPQ76Mt-8
    d1FUjTZ5OksdcoJsg>
X-ME-Received: <xmr:hc0waHlzMX1iPsHhis7dz_-iVoF7-mU9eFPD31bW5x_P2D2z35EjGXv7_K2i_Om8GmyiA31hbSjeYN5lmq8M_Mo65I1cj-af3c4nB2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hc0waKxMPGIf-zFz314ptMRunexNRW_hbD-JSAaST3sQi0G8E_B8kg>
    <xmx:hc0waJTxYhMi4xN4qGQDty066Y2KMO08OXoDzl1PckbIEESTuzm5kg>
    <xmx:hc0waFZwgrOcdG1YT-cPYKrUOIGuPUbL6xIjXcc6CfFSzj01-1A3Lw>
    <xmx:hc0waCSqXDUvAh-S2ThlqZ9foHunH6KyyEfGUu6OmqOyQc7CV_upHw>
    <xmx:hs0waHr7TnJIgmSooEICq7daHptWVbB_r8jQxe6f-tyO69wQqqf6vYPM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:33:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 23 May 2025 17:40:14 +0100")
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
	<aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
	<xmqqfrgx8xkw.fsf@gitster.g> <aDBH7G-oKKxAXWBp@pks.im>
	<aDCNqRAoGygwnAbq@pks.im> <xmqqo6vjz5cn.fsf@gitster.g>
	<57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
Date: Fri, 23 May 2025 12:33:23 -0700
Message-ID: <xmqqwma7w29o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Question: should meson (or indeed prove) fail the test because of an
> unexpected _pass_?

Yes, it is a very good question.  I do not mind if the answer is "it
should, and the make and prove shouldn't let unexpected pass go
unnoticed".  The difference between the build systems bothers me

Thanks.
