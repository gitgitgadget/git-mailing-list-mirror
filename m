Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D321714B7
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759073707; cv=none; b=dFhPW79KxotyuYqLZ4YG6iAZIuJt7zF8KYXS/WgR9UoFzZf+d0J8HoUBazKr1QA7lNy9kqRwACwg/ulTTeuqJpfy68yI+NF/z6GXu6ioSYu/Yx4zoVAc7HGK+GA3ye/bNAToSgZWk1Yx0Bpm9aqGklgqtHeoEIq+tyqmZB4ASZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759073707; c=relaxed/simple;
	bh=Po86VjOWW9dD5O4a3dS0+cj9liOTZJ9fSs1ktbCQK04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ov28fQrtaVPFINpL9QohRICcdKltZngARzMhSBTZQf+G/oa1hDS0OK5nv9Mqr+WEH7JOWZ2y3gbsS+6bgjA7WFW6H4U8uJKeUMkDWMEHgTEG0hpOSpUdkdkgoHoU/hvi0hwEaidBvdV03bGi/q9KbNAgWXt6r0bgOyaOuyjmvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8IQpccZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KM9tzh/f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8IQpccZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KM9tzh/f"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B4A01D000A5;
	Sun, 28 Sep 2025 11:35:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 28 Sep 2025 11:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759073704;
	 x=1759160104; bh=Po86VjOWW9dD5O4a3dS0+cj9liOTZJ9fSs1ktbCQK04=; b=
	M8IQpccZo8DpdtzgSp54M6Slq3IkXCE9QmK2ctrfB5+6ksK390EfBNkgKM3DxHFa
	Kd3nfK8mru+G1OcmKi49gdinyQHIyciM2r3DXMbJ7GUxvOPOa5jD9koYScFhvP51
	xIsTtSsbuYtAlf8imPkK7nAnf80XTn3FBlH/8nH6oWJbayDxjbOFDwTJP0bqGWqT
	lZDdTq0wyWkZSt5LClevYcBdRhN5x9CevM+KZ0gLMEV8Zw7E5KklAGmEHh7HO8JX
	neY7KHPjbVtOrAl/fdwN05qyb6OXYyCze4rGc20iBZKK9nZL8FOLgTPNW8c8kIV4
	LJxgxsIo1WE1zFgAQRc5/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759073704; x=
	1759160104; bh=Po86VjOWW9dD5O4a3dS0+cj9liOTZJ9fSs1ktbCQK04=; b=K
	M9tzh/fId+9Y/sI5CbokGR/IXKOsbvy55nyKDa32tfl6WzbAcGUOc7i0zptHhXDN
	Y/qyhEA7ZOsZGuspo43Y73GzURGQPRecNDj/gUKjqGKpjrp1JXVRGrR6a2N45Bgt
	Ot81drEP1px506dFYjrhSpc68jmrs5Pqm7kz5PD+GX5r2pgSTz3LUF2piIs+ga3t
	Le8oAG8ndIO1GZtuojP9Mac3kCPc2oaOx+bEVcHPQRRn5eh8yJj07vGxobYXxARg
	4xRMtkS+MtZAkn78ZrRS6QsKweUlYNdZFHYUL0HhvWlYdortvlMxZeSfJRK7UqrP
	FXb6kvZpEPPuTerW+hPkA==
X-ME-Sender: <xms:p1XZaLRpPaXGsKMBsBsGNYhUpsIaH7a7SJkU9EzGz9FbGNzFzeuK7A>
    <xme:p1XZaDqgOi2Z5xOIcIzbcOoCGAmuHjQUmG4qViYNrzGusOEF9Kxt1cdfNgyn4JTJK
    F-qy06_P19BJwaUapb_zgeF9dc3r-_IdDbtGFFZQVMxRCWRjJ2c3Q>
X-ME-Received: <xmr:p1XZaJLndJJGVnZd9ms5hDJaWizjbPVEEM5PT9WiHOsqW65QFcTjBJmyUiEcBRbjvSCp4N-pIR-FeSHqcmH5b6tV3gitWy7JbUWb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvfevufgjfhffkfgfgggtgfes
    thekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgeevgfeifeefieffhfef
    ieehheeuteefjedutdeludekhfffueeghfeiheeuleelnecuffhomhgrihhnpehgihhthh
    husgdrtghomhdpghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhl
    rgesfhhrvggvrdhfrhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:p1XZaGrvDADY0CGG7wPty_dfnwvdgX0H5oRul1wgFc0XXBYc-rKZuw>
    <xmx:p1XZaBzpaHtbwONFoXSxOHhMVXcRLJPIlwlEi8WKLVY4esDCMtX2pQ>
    <xmx:p1XZaKPC5v6-lNcChNesZmJjk09-dTF8lOMh2dBFZJWJn31MCtGT4g>
    <xmx:p1XZaG6ZnPl3asYCZ56W4irITteB1VYyKh0P-vceKi-RRA-uTjpvPw>
    <xmx:qFXZaHyI1oe-elAMJPcyAOK56Ec7KqVyV8bWOmg0s8BXtUqzIJYOk7FK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 11:35:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
In-Reply-To: <20250927195032.37223-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
	message of "Sat, 27 Sep 2025 21:39:45 +0200")
References: <xmqq5xd5aqa5.fsf@gitster.g>
	<20250927195032.37223-1-jn.avila@free.fr>
Date: Sun, 28 Sep 2025 08:35:01 -0700
Message-ID: <xmqqo6qu7fq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> Asciidoctor and asciidoc.py have different behaviors when a paragraph
> follows a nested list item. Asciidoctor has a bug[1] that makes it keep a
> plus sign (+) used to attached paragraphs at the beginning of the paragraph.
>
> This commit uses workarounds to avoid this problem by using second level
> definition lists and open blocks.
>
> [1]:https://github.com/asciidoctor/asciidoctor/issues/4704
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>
> Sorry for the straight/stray confusion. It is saner to remove it.
>
> The first occurrence of the described issue is a few lines below where you
> looked at:
>
> https://git.github.io/htmldocs/git-config.html#:~:text=+%20For%20historical
>
> also see the second one:
>
> https://git.github.io/htmldocs/git-log.html#:~:text=%2B%20%25(decorate
>
> And big thank you to peff for teaching doc-diff.

Thanks!
