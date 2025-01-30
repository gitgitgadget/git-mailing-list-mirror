Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757F137C35
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263743; cv=none; b=eQAmJvkBgxNhmTFqCOFoaEJSPHuJ5W+H/YfrMux2Seq/JnfhvsdI9VPB9F41Rc5CBsUMXvZxKI2dsbQv6I2pp1Ue7+enlP1EaLNA8ZLX/ZJ9o9zRIodnAGAoLgFzpFuW7me/vJtaW+Vdzw7pJ1P16/tqYpq4ZLjpnl+TFvX9wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263743; c=relaxed/simple;
	bh=eeCXPVUMJXPeODMj2KsbGHOGf2De26WnUl1z+FeqayQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+PNO7VhdjiCTNN1SlLwDbGl0Gu+vD/OgUbp2AZpZl/AX9f6ncDRtBOi/1GXUvNTZmt/SLwmrWVmroLlgKgpqizTX4Kybt7TCTwb5dMwgREhydQOy5PMpVvrVEy/ssvbe5MGmnZ18g9PPYNBkLiLwNBRFhMtO2GOkBTAUPAnqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jq8Gt7Es; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKcsZpQ0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jq8Gt7Es";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKcsZpQ0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2B231140151;
	Thu, 30 Jan 2025 14:02:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 30 Jan 2025 14:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738263740; x=1738350140; bh=WgzF9ftOYU
	YngwKzAEquisZfmXXsc4ODtunjzPtMGQQ=; b=jq8Gt7EsssQnP3SRK6lsOqBbSf
	E+S6nC2Ry74zzV2VerQq0QbjFU8Yy3uQ6pwlN7UBqw6JLQLOT/Ge/P7coM0Kbp3s
	8dgVJgZyCTIX9J0qQYjL7uJUj42hBjkf8XHQqNjdyOmX8Ey+ZQ+Mu+pkkBJo2yem
	b2QSO7dnO8eQHBbTmzf20eaOpNJXOABZfWHd+touzbcdzpR3vLLLrMlCnYXAo0va
	F+0Q57wgB3B1Mx5aGYNuokf4IZPUmFS0IE4wQxa2CME0LtHHy8d5BBZcmbciJsH/
	BqmQHOYrkkoBJCXcbu7LQf3T0pvzE1VwavF8tXCA+Jkq2PapGQSN13Y3H0hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738263740; x=1738350140; bh=WgzF9ftOYUYngwKzAEquisZfmXXsc4ODtun
	jzPtMGQQ=; b=PKcsZpQ0mIds7aeC+1IKzexenPmFsmx3ktuNi6f/5b5Sw9KYI1l
	J3A3Uq6HIMCjD69Wq32ihiRsVNSmg2IGQYTvSVHebIBgkaZYh5qZyApRS1dHF+GE
	aWB8QabAwp8BjpFon6adIXxBck+f0URa7UGlyE5idKeZaxlBgm+kkWSkd0cjJHYF
	VJvDKWHGXoSFFhzFTuamwus+3KXwsbHTSHSSn1ywBX052X3Gb1sFFhZwq836Qm3T
	D96LlM9jiA5pE8ci2vwYqJ1AHfNDGGBqaiAJbBGGTWxNflbUvT8jxBSBIu+XEGBu
	1wTxZ3Den8tV6/pJosa71G9TlVWUtG+zOxw==
X-ME-Sender: <xms:vMybZwGVzT9Enpyy75Rh-PTZm-ZNAULF7fLweL15Vt4rfms0Txy1eQ>
    <xme:vMybZ5VzSWFKugTiwc4cWKYtgnMlCDh1rT8EDkSQfrCvZXC5gLvCKVfxiqYuzvWGQ
    KlQIN4ihMqal-UcHA>
X-ME-Received: <xmr:vMybZ6Js2iSAvucC7dU3dy6XjF0oxKlEi5Rg9v7E_iFLMDO1K6t-d7qXV8dnl0pDDJu_wGQzL1UFvsxJKoDTCxymGh4KHqIZEOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vMybZyE51dS8GXwWG_mY-USugmhSoP_NCqQHEMz6H6BlvXh0oZO6XQ>
    <xmx:vMybZ2W9zLQLytboILaY7DhtoTur8PifXlxqbFtbrA8wfiK7VeTHLw>
    <xmx:vMybZ1P-V52ntJp0BsGUYxgfZ_4vlP7kUFJJD7li9TPMk8GcZ0wkvg>
    <xmx:vMybZ91sF-6J-6gtqgUZJXfbMwz634ZDp3Axc8Uyh5N6U-2sdzg33w>
    <xmx:vMybZ4I8Pl626PN8yZQ_gpckdKRkFmDrnj1PvXsyHqFr1PmdHAj6nsyE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:02:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
In-Reply-To: <Z5r7KvL1bvSO4UQY@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:08:10 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r7KvL1bvSO4UQY@ArchLinux>
Date: Thu, 30 Jan 2025 11:02:18 -0800
Message-ID: <xmqqwmecceh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> We will always try to sort the "packed-refs" increasingly by comparing
> the refname. So, we should add checks to verify whether the "packed-refs"
> is sorted.

Do this _ONLY_ when the packed-refs file has a header that declares
"sorted" trait.  Insisting on a packed-refs file that does not would
mean you are stricter than the runtime contract allows.

> +struct fsck_packed_ref_entry {
> +	int line_number;
> +
> +	struct snapshot_record record;
> +};

Not a huge deal, as 1 billion is still plenty of a large number, but
the same comment on the line-number applies here.  We might want to
consistently use ulong for line numbers of files we read from.
