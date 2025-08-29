Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AA2E1C4E
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485240; cv=none; b=Hzc8nVLKnr7GHbfJN0i7LBANtjzahku1CEyDtNlPzgSTevQDg3fILNcEun6LigAGkTyzLohneRkW2HRXVlrBBOSVLzgA42kFI63B98lkU24W2AtOgOq7NhcKx/c3NCMpjmYvjS8Fg3PE7afD4nV3P5BJv5Z+RAGOQwoM+QOFLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485240; c=relaxed/simple;
	bh=3C7ZUHtMxXnBB3YcPw3Hqwa9ps81oTliqyUcZe4t2pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y573CPF5OfVRfEkJzier7tbUVo0djrr8J2KsCHyfQ+MjsH86SSxpfDnyJpYClAT6k754wh/fOw7GZPwBw7G4B/gnno3qbgu5XmtyPEkXOhiC3vUi/QgQWSzNWAEq2ITbcqdYuQTLQUTo4lhUO1Cy3SHYRuV4xtR2kKqDeN+KOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0KF3e+Bm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PT1IU/Y8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0KF3e+Bm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PT1IU/Y8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72E1F7A0162;
	Fri, 29 Aug 2025 12:33:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 29 Aug 2025 12:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756485237;
	 x=1756571637; bh=jbdXxhm4tnLwAtjFz/xVsO91Ea984WLv3JXWSxE8gjU=; b=
	0KF3e+Bm1iFTQgW22AgcvJsWeZRXgATWH65Hmtbaz3gqwTEW1lImkgYJ7L5KXNEd
	ew12IgknXVM+i8USrAiIyeZ6HBb79C0Usy2jjOSCnDP/6uTpIzgPXM9GIjUSPQKd
	H6h/sx7Xrqo0wBtW/F6NFE+XSNLRU5TQOxoVVxCZ/euqLV+PCT/2Q4kRyMEld64O
	mt7Yjmc25c7q0S42J1n85ozqp6yRWaCik0GllA371OkLnD3p1Oz+b91A/CWp1n2h
	Fz+8csU+XknwDu0eRbQ4XoIEZYy0kKJUJHOLK+YFUAodDELq4+W8M2j93d4dp6R3
	Yo1QIkZpH5P9SbfvGbhW2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756485237; x=
	1756571637; bh=jbdXxhm4tnLwAtjFz/xVsO91Ea984WLv3JXWSxE8gjU=; b=P
	T1IU/Y8xElZy/jAZ0iH9tVi0WRET19M1ww40/79Kn7c5qWZUwopQ7E6ep+QBxeVx
	P1nMEkxnwf67j+DcAo95ybipVIoL5RdSjp1WeMqOHH2X+cvazTI9KUOt1oDg/LtW
	NiLNOtUyqSMFkzoHzrv6UYIGxH3shUlCJduyQ8sebv51SJWjq2qRCQCDZ1sd0Tsy
	stidxLSfF7pBvOI2orelLk1dJsVhvH2GSaYtf3UnMt7jmWBnJ7g7P7d3+0baMXKf
	K/jlgrSBBW6l45e3jg4uMMUgQ2hy48p475MeUxYrSrO/RFwGl4HTwPmEOlbL3eu/
	lfzFFQCb5VnL5y9LRUxFQ==
X-ME-Sender: <xms:ddaxaDyVvnl973Q7vO2QzrVKSyjY9xn_ngwFHIXD0qMxZJwfeJ9r1w>
    <xme:ddaxaGwFnE7AU0UgzY2JCewrLV6-lISxd_3jbrt475RQ-0AAlYaBat_mtI0ASM0Q3
    qjM-3gfo7ycRHXM6w>
X-ME-Received: <xmr:ddaxaDyBftInk8w21ixyGsLSJ8Nzd-NihI6mlobQ-6hESUNgA0_Zo3WMcFmBwkrR4TI-fhYTLnOY9egydeXf-sGUve7jNXm9XpSpYF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ddaxaIarXqgMLsnk1oQJhh_MbS7I9-3lJqiVEd6hxhzlZAZi-AWSfw>
    <xmx:ddaxaMXF7RVa85GDz2uzkau200NUXmDQrsgkt763yMPWGXPILiNJSw>
    <xmx:ddaxaOh6wXOGaVOzRmqgRa_QH16Z7JATE7OPfJ7PV7tQuPc3QwSqfw>
    <xmx:ddaxaCsGH5P6UVQud1inb0vFsHcfRnFsFPcXd41zYRAxBBkaqSHgQg>
    <xmx:ddaxaHxQHhU6AH4bsSw47lATqmnkHknR1u9nlrDx5zUabc_iVLP2E6TS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 12:33:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v3] range-diff: add configurable memory limit for cost
 matrix
In-Reply-To: <CABPp-BHnCHiTFNKCrnpKF5STkeGNQWMxdVMZ_v-Rp2judZVEgw@mail.gmail.com>
	(Elijah Newren's message of "Fri, 29 Aug 2025 08:21:24 -0700")
References: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
	<CABPp-BHnCHiTFNKCrnpKF5STkeGNQWMxdVMZ_v-Rp2judZVEgw@mail.gmail.com>
Date: Fri, 29 Aug 2025 09:33:55 -0700
Message-ID: <xmqq5xe6nl3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Fri, Aug 29, 2025 at 4:00 AM Paulo Casaretto via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> -
>> -       ALLOC_ARRAY(cost, st_mult(n, n));
>> +       size_t cost_size = st_mult(n, n);
>> +       size_t cost_bytes = st_mult(sizeof(int), cost_size);
>> +       if (cost_bytes >= max_memory) {
>> +               struct strbuf cost_str = STRBUF_INIT;
>> +               struct strbuf max_str = STRBUF_INIT;
>> +               strbuf_humanise_bytes(&cost_str, cost_bytes);
>> +               strbuf_humanise_bytes(&max_str, max_memory);
>> +               die(_("range-diff: unable to compute the range-diff, since it "
>> +                     "exceeds the maximum memory for the cost matrix: %s "
>> +                     "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) available"),
>> +                   cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (uintmax_t)max_memory);
>> +       }
>> +       ALLOC_ARRAY(cost, cost_size);
>>         ALLOC_ARRAY(a2b, n);
>>         ALLOC_ARRAY(b2a, n);
>>
>
> This still has the same wording issue that I commented on in v2:
> https://lore.kernel.org/git/CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com/

Right.  I overlooked it, sorry.
