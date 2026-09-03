Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263ED379C5E
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461620; cv=none; b=sbdvjA1W9aBTjN6an7YVx0XpFMkcEpkgdATeyFwt6HDpRoqBUeyyv6PWKvEfwuME5mruMs7fF7Qhx+ahsAbSBqX0yongN6J826tc9/U9xs5ClSZW8rnE3jZamO6A/l2lS/CY1NiS25QPefGmAwDBEif/obo+08qV4AA2xsEfVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461620; c=relaxed/simple;
	bh=rGbBF0hQZ6nUgMegudO+sk9QSO+c4gAeh3GT+MFdokE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcuWLzf784EO8q7qGFEDUGn96AwqWtx2Jr+P2sozHC9CjSop1Xyq+QGgIFZh7PyFR3JGUCHCqZELCUjStHwtk3cW4iiKHrl8qs14lBow1AKbLtPLxODuAF2gwKpZ+/cD/N/u0NiExLagF0I+mF/8CJWSN9+MmYDIXarGzS6bF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dtSjpK4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UT41cVxB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dtSjpK4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT41cVxB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86D7A7A0160;
	Thu,  3 Sep 2026 14:53:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 14:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788461608; x=1788548008; bh=ysLUh1Df9L
	5CoX5rlMxauNGVf94ddDNf36NDpCscb20=; b=dtSjpK4LB4E3Zr7cVu89Z0zwkc
	36oWqkwU163uwrbe1mGsXzm9CykmwuEA7ZIz4t5y+1setTrOD10xj5z7sduNLf+D
	d0jDYIj6q0gFRJ6NS7xJzNdUiPwp8Up8NYOzwC7pEK0vL18liaTS6jzPZdTZDMGD
	hkqzl3f5NkG4PNQeQDJJRgoKWpK4MPmeEN708zOfUJqLHAnz2ZsdTfHNxeK1kB9e
	AKJCe1dFaSdqtk+iGMpfwJVdOdecj1uJ4HMfNdCKfaoShxquYfQ0IMWbMUHiCBD6
	P6vdFLWRm4xXX0QL/gJKBOMkljaDeFRUeqohtipQV1a0GHniBdCvHbGWFI5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788461608; x=1788548008; bh=ysLUh1Df9L5CoX5rlMxauNGVf94ddDNf36N
	DpCscb20=; b=UT41cVxBiUfiXud8dq2XWvm0eXrONplAFeREH8MOsfrFqDunV9b
	7wVkm1OEW8tlb1vsrEk1MVtorrdTNEpcoVYFxy5Fftq4SKEMv8wQf9micf/z4q5V
	tRvne+CZUBSYkxa77d5eTzJ9kfpZXXfZLDcBDmIBKtZ4jFtuuPTb5SimUDUcGVKH
	L6KHxLBOHcKrTRpJ6dVit6qZQQ1ySD/1uT/E1M08Jqp8OSmuORFqRBBEHlXc8ruQ
	Fb4bDwrZP3Zcinv5F446G1biTyOQ8GVs90G1C1IdPSeqUi/NlO6vQ+xhZ8+oPwQ7
	cHy3uenX6FaaD2Cpv5SRZ+61WS4lRXtCU3g==
X-ME-Sender: <xms:KMKZaiQfCcL0b4xSvLjfNPAhs5uEh3-vXY180DnXs0ifMZhS9gMD8A>
    <xme:KMKZauqAOdgieLbiI0sVK17KBUKwYu-MbHaz5A23B1Gd-gU98J70JejjZqlgSZh1Q
    nWZv4cktG3aBoeI3f9x4PAFhuGsU7bRJMPHgpJmE_yhdRbQUg9lWw>
X-ME-Received: <xmr:KMKZaoKyGCFnX1stb4fo5iSzWzWU0-ITZ2gFFEfnhbHawzsMBwZGhja6gwaHAlNYhDX_ig5DjdzyQGrEeKuA2VMUn-xdUE5Lpw>
X-ME-Proxy-Cause: dmFkZTFlQNoQXbtyJiznBtm1nxS+b0eC8uMMsNMHUi73j8yh/dcOcrM0/V3ch5eKirDuKe
    T9PVe9qbYbMXXfDpIm1D8/r5VTWXXLU4229/bsQYY4+TXJyRwhG+ZwfN0c1X4EInf5PhW1
    biyra0+CF9DhfLm4ICh2LNRvTtbrICk3ao8GShNS5DnVf9rw4pbn1tmz2qAEHLVnlPJh3r
    o6Pds9dR9nxX0KlunTBgPyUcy1CVpuEuoJmEr487Ekktb7i+36Zr8nFkp9uNL5u66m518j
    chqbYAh1tbRF4M336+CKXhYX3wqn6rLCK0wbnJ1MNvznmNuPCpSjintLLI68JRXyv5vOQa
    j51eT8Ef0sKmbQlfkySxeXlhM9vG0Oh+xTHwYrOyNi1kEm1ts50ElshGFAIEBZ7rqefofV
    ZAdISSUv5+L5kYJTb5ydp93NkJ/dKILPJQ5Qe1HmNtqesIl+1afpPeXn/5yJt7x8ZOH/O5
    3AARNLb00Zd5YlvWY4VyC+pbvOo/fJbBqBUZJm0H0hq/2stzDDM0YCZA5R6BzeshSdwgJq
    FAtnoM83t2sgRxw8UmF2D+YZJ5DJHrVRUfzI7EfHaPIXaO9f9hDC7G13G8Rm9Gh6WykdAM
    OlfEbeGZLTlySn/OyaKU8umdqtGvuki5jFILi7rRpmwjlLedhP3U+QzplQBQ
X-ME-Proxy: <xmx:KMKZapr3XRnzSgyMZbTlNzvNh9cLtns3HhXq6wKE89icrDAqGLEclw>
    <xmx:KMKZaoyFhDzOzGG-Jgifju0QK6JtLNbyYj5CmJDxSnULTOaIkAsy_Q>
    <xmx:KMKZalP-dF3s5G5gTskOaJLIWIudKip4QfVj6iSVPkZAPma5e0DPmA>
    <xmx:KMKZal4jDKz1NKwG9olcUY_mhYkhyzNWYyqxnwMOwuQt6nRcVza0Fw>
    <xmx:KMKZak4e6kyh_YqLBgM2YJN6wdy_ZNVhCGHrtUs916LNn547ZRNAMkFe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:53:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 0/2] checkout -m: refine autostash fallback
In-Reply-To: <pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 03 Sep 2026 14:39:56
	+0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 11:53:27 -0700
Message-ID: <xmqq7bl2b1zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Avoiding checkout -m autostash retries when no tracked local changes exist
> and visually separating autostash conflict advice from the subsequent
> branch-switch message. Addresses #leftoverbits from here:
> https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/
>
> Changes in v5:
>
>  * Improve commit messages.
>  * Create helper do_stash_apply.

Both patches look good to me.  Thanks.  Will queue.
