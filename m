Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8B438FF0
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238071; cv=none; b=jBfiafZE4T+lIO9B5vHjEap24gS5SN7V185MCx5JrtkxdPDUPUF6oZMFkBtGzcpa76N4VYW6N8Y8vyHm6ziH0PZhN2a8WjBVnOLmykOIxrQeFTU89LHIzKQB6G3xB+naRE6I234NtjYLpY+WDYoeJiVePOlR3RNeTIo5IbHpFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238071; c=relaxed/simple;
	bh=PyIKWFm0KlEpwW3C9cQOzq7JI4gdqzoyO+xdGiAIOug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jiy6cOD3s3oNiuJ2DmqlKy6+4VUEOdtN4NcM3UYFhGqHLS/8sOfLQJAQ30S0eZk0KcRVTignhDD+QzesNnBsf87nNK9jz2bVYGNJEwWnp53Lz8KJL3biYgAY+WSsHUTGqR3v63X/BltBHCJ1rLypxuHTiXlweNE9lYVGUr7/cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AyZRcdrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYX1aE4W; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AyZRcdrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYX1aE4W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DD9D1400075;
	Wed,  4 Feb 2026 15:47:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 15:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770238070; x=1770324470; bh=Dn6rIh0Oui
	bAdIzZbB0DLaDIsRq19AZ6VDvOqw7dBI8=; b=AyZRcdrb5WbzZkW3eTI7FJl5Tw
	Pv+6N4V7uuD+fo+cAhORsz37xG1pMAdZ7bJsBrkt1pRzMNZe8H1ElbSXC/GWNY9J
	SuwbZTNiECU5rnt2ZPMfs1OGunFvFgPVNfRFEEvNV9yJC3jGcjMx++EwzJrNt7Cy
	lSs66b69MAHL5ysWuMaIFYFcJZltqIBiDCXg568iv+cQm32hhfRrpXjkEoyuHtF9
	YaJvB27pPeueReExJ7VUj5Y6SIRkUQt6Tql6Myjz0tb6s9r5WMcBBEHplTjyiOjm
	9+mTVjhTM6hO4DJoKmAEQ+GfEOUqiVKHOhxRZd2ZEUU2bUkyuYdpCDZ29uYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770238070; x=1770324470; bh=Dn6rIh0OuibAdIzZbB0DLaDIsRq19AZ6VDv
	Oqw7dBI8=; b=eYX1aE4WWAlsKgRMCLuH5zb9/dla7kq4mBw4wJQCgpLnLKmulqF
	rtYLdcE28ySndTXu0//iKC/w3/V2uchJYbsuIHDrqAEU0Ml4zUevoHLEbTKLaub3
	1wLTkc7HbkrQeVy150q3OWejdbqwOgDxF4gZwDhwzfAzjGShjuxFJVa8b6T5CgjX
	uKRuXsmXGu59wl3XCDyqUf0xhxG1bq1mpxS8SVnIAmowM/uAuQ9o0yM+1yfSj5UQ
	FbGjJ4f6g0FLzV1IaB19BIncHfU+0hHynEhZZ7yxDXCSRpjE10YExbEPtuZVHknT
	C34Akyggx6YPIaBSZ9Y0XlSmFIXlpdYNJkA==
X-ME-Sender: <xms:drCDaY2_JkPz8CSyawgcPxDHW8HJediysVRBgq4sw7RPz4pMr-dzBA>
    <xme:drCDaaH9wqZpJ7WKEovgkNruOvb1e8ElGDY_0uY2pamaZAY-B1vDmlqcPWgNMlr64
    JFQPnimho9RYtLckZT9v7C70zTvprbaWVDrjubOaqgSXbeoC0RD4w>
X-ME-Received: <xmr:drCDaV6xOg0HaP43JkXCmUhm734U7BZCPQzWPK2IpcJNnFJHJ0NvZMqLSfrAK4RuxEXqyuSalgRKl62l0hWBJ3QknAwmry4lqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehonhgvqdgu
    qdifihguvgesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgefvddtheduhe
    efgeduieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:drCDaQsHID1q4IaC9CBuRSEiDwVhfbu3qiMD270vop0JHxOqjAUPHQ>
    <xmx:drCDaW4XXIKLNvO3YbGACmluYyuidXEXL0skrhmudae8dkRwlLCmYg>
    <xmx:drCDabUbQYqLCbk8iIhkvNuByvDKBYF1qQnLvN_mtiFxIswGZoM5OA>
    <xmx:drCDaY99ZGV7th-jewcw_4F_wk6dsaPRfWR-e9k8E8tBCB9h8MYrRA>
    <xmx:drCDaT5jiAqS7GJKGcKKIez38y8HAQCghh0X_pT9-xQz_s5EaquFIY4U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 15:47:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] fix git add :!x exiting with error when x is in .gitignore
In-Reply-To: <24VdqZCRHE7M9q7Rp-IH60MmQrEOW5lzhtd1-SUNqEhV_OTzGiCUkVDL5ngVJbyWRMDZ2GlWCJ9wkMSJLsJh8QYO4gRhDMGyzhfuGAODOs8=@protonmail.com>
	(Remy D. Farley's message of "Wed, 04 Feb 2026 20:11:32 +0000")
References: <20260204132747.1564157-1-one-d-wide@protonmail.com>
	<xmqqo6m4pi84.fsf@gitster.g>
	<9c5be231-f340-4a97-850e-d43c78b2c889@gmail.com>
	<xmqq5x8cpcrd.fsf@gitster.g>
	<24VdqZCRHE7M9q7Rp-IH60MmQrEOW5lzhtd1-SUNqEhV_OTzGiCUkVDL5ngVJbyWRMDZ2GlWCJ9wkMSJLsJh8QYO4gRhDMGyzhfuGAODOs8=@protonmail.com>
Date: Wed, 04 Feb 2026 12:47:48 -0800
Message-ID: <xmqqikccnsln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> This case is actually already handled by the pathspec itself.
>
>
> From pathspec.c:
>> void parse_pathspec(struct pathspec *pathspec,
>> 		    unsigned magic_mask, unsigned flags,
>> 		    const char *prefix, const char **argv)
>> {
>> 	[...]
>> 	/*
>> 	 * If everything is an exclude pattern, add one positive pattern
>> 	 * that matches everything. We allocated an extra one for this.
>> 	 */
>> 	if (nr_exclude == n) {
>> 		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
>> 		init_pathspec_item(item + n, 0, prefix, plen, ".");
>> 		pathspec->nr++;
>> 	}

Yes, that is from Linus 9 years ago plus a bit of my work, in
859b7f1d (pathspec: don't error out on all-exclusionary pathspec
patterns, 2017-02-07) and b02fdbc8 (pathspec: correct an empty
string used as a pathspec element, 2022-05-29).  No wonder it
sounded familiar ;-).

Thanks.
