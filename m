Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FF20DD74
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403809; cv=none; b=WUM1+Uztcp4ZDSN6C8NDtDaJLLKsrJluEjnvJntWPWOMTtB1wGbpwn+7yAhT18ZXgwuYdxNk+ECNF5xS6GwnCYKf+j3XXZX+rKeEdpvHvt8/VNatX6IyLYfoUoiTOqgZ7JGmiD9FTZqTbaUtuwHG6pq+sqw3YdRgVzVvXlBLM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403809; c=relaxed/simple;
	bh=yxGpn0ISMb872ixYHy0CL2vZub04WDuSVS352cRe/Kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mgm6oEC1MNoUJx1k+ZUElc1XsAa+qhB2u0I3ktbWNNhyEJmjLSsxWDMOHa5WJeSDgbTD1+/QcWU/NVqoKMZUEfIpixFjn4a84p5xmiVQSkzLI7CzArWAxnFjWxmnnolz+aEeLeGowJYJ+FC0yQeBp7zDGbfwkzFl/w7bS41HQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EzV/NtdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUEEyOZl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EzV/NtdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUEEyOZl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2D6E254015A;
	Tue, 12 Nov 2024 04:30:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 04:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731403806; x=1731490206; bh=yxGpn0ISMb
	872ixYHy0CL2vZub04WDuSVS352cRe/Kc=; b=EzV/NtdNnlRQUK0/G6+w5dehTn
	esWBXd6GB3acJxpE4p8b3RSH7TyNwlZky5Fd78MOPLiS+tioA7EVbvTCfi7lhhVh
	JWKB6linq4Xyhqf1TmW3AuQONI6CoQltMuGp7QUrrzqE88ftUgT59jKKck6m6wy6
	CUpGoGDqU59rdDU3dJYATSj5WJabJcSAHhmqh6I54grknokm20KsrWp5njeMtsHH
	tzA34qmMFJEF5HjObRFFXdfIOiCf3t+6Pdr2/9IwzYdPK5v7SKhIyJJgB5xfKSYv
	VP6EBQUXPtdamT/N6JLAhY4GX8llOWB/v9JAn0P/2vduBJzOIPvvyDuuALFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731403806; x=1731490206; bh=yxGpn0ISMb872ixYHy0CL2vZub04WDuSVS3
	52cRe/Kc=; b=UUEEyOZlJkT18UERDa/6dHW47LVlBoJAm5Lx+kO3Vg59F/Ngx44
	PH+PVJbWCXtYDFfbr4v5/cgIt4Bt3kBdWtl8riAljBDxMph0qD8INcDYn3fHtChr
	13M8bHx0DdfQW34jkFRO0by4epEqkCqZKpn3+OlUTo2oG/TaXVSBHom0isXO6y2+
	/5jvNYzG9TmtcwWPKrXnJ1RG5685ztiVnzrk1qRjpWkYPqSIEK1xhX8plQZyVmnb
	jtr98ZIBUOHaNpemLg1yomXb4lqR4XV6KxV0z0BbTCYaed7pIQOTmxTBs3ZKNoOz
	GutkEajRQDdMe6Way1aMqSFvDV0e5JRML8A==
X-ME-Sender: <xms:HiAzZ0gNLIa50y8GEm4bFaUvzta4oFas_gotPT4LG9VixAdmvJVXYg>
    <xme:HiAzZ9BzBqvRuz9D7uoXvhtyjfJtb4nWhIVeYfOB26PiB_vKmY5mYOojtN-QphES-
    aaPyWOYYj99AANsJQ>
X-ME-Received: <xmr:HiAzZ8GH7Li7W8JM7dZ__RduUDembdIJMERx7KB1fI3oZqwkhwyVidNK1y3hI2YTFUuMGZmWUR_TtJkxNlan62yq9UVdT2fdqv5F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepvghrmhhilhhlshesvghpihgtrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HiAzZ1SffAexehhjWS_U5ErX-2qiHBRpqtyLQjHpOGEVRO5lj9xeTA>
    <xmx:HiAzZxwT6Rzt71MJkG4jbM6jfp-vb7Tyidq8PRnkRpvBcpmPXIIapA>
    <xmx:HiAzZz7nHh1w6YThm2u6yDlSmvknux1ga4-_bO48fsdmilDv98-mbg>
    <xmx:HiAzZ-y6r42j0OhCOQsg10d89ikcqEj-BBLF4XFwNykmPMFkiDfJsg>
    <xmx:HiAzZzs7zVUbjjMefmBi5oy3GCFryO4h_cCZX5pd69G8_sQKCZYJmqqS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:30:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Mills <ermills@epic.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] refspec: store raw refspecs inside refspec_item
In-Reply-To: <20241112083937.GC3529122@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 12 Nov 2024 03:39:37 -0500")
References: <20241112083204.GA2636868@coredump.intra.peff.net>
	<20241112083937.GC3529122@coredump.intra.peff.net>
Date: Tue, 12 Nov 2024 18:30:05 +0900
Message-ID: <xmqqttcc4x5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The refspec struct keeps two matched arrays: one for the refspec_item
> structs and one for the original raw refspec strings. The main reason
> for this is that there are other users of refspec_item that do not care
> about the raw strings. But it does make managing the refspec struct
> awkward, as we must keep the two arrays in sync. This has led to bugs in
> the past (both leaks and double-frees).

Yeah, I was wondering about this while reading [2/3], and it is very
satisfying to see that the concluding step for the series ends in
this change.

Thanks.
