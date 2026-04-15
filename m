Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A253E121B
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268161; cv=none; b=WZrazCXEoNGxvyWCCE/q7I29KZBA5cVvaQgCTYWcEoCfeB88jZZA0yRD56XtHYBp/z57Tvv4mHGbGi/cucvA68IW4/ahwyHBD9Af7mU/6gReFrhq3cUGz1hD6SpKhlFhtAEmsYnRhOWmvO+R90ORwYKWWz+/EW5FuJxBBVoEQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268161; c=relaxed/simple;
	bh=IA5A8ohjaijmxqfg1dZ0y1nJrIscTHXHq14jAoFOlfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uv7j/0URfvgmJnsopw+jP1Yb4BkNjfJvhNIsUpFZlYKcLvlDsyFcoI/ESo9+qZXz5SLRY91/5/NZupmTss1XQzxzY8NUTl5p59neYv5H5mTOI57vRdWPLVSEf419YZxq2QyBsW+4yiURTdijvJG1iQKhf0+iRzQrDWgLy2Vbg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NtFNqx8K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBdTpNK9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtFNqx8K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBdTpNK9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 161B51D0026A;
	Wed, 15 Apr 2026 11:49:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 11:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776268153; x=1776354553; bh=8OoFB1xUqQ
	dY63+lIcCa5yDSmTtnmTtNv0bK4jG0gRQ=; b=NtFNqx8KO/4LsQKtsACT727MMv
	/BmRK1ga8oQ4XJ8MpuHq4VUGr2ZCUvzPskqBNyvKAgYi6qvkjOTS8OhSFJ+fTg8s
	LQGubLoiHGmebTOWPOFeUaO00qkS2BC9QQl9HzAR+AS+nJe20X+QJfylSIXVZ6eB
	sR407eUI9woi4ziCJU6nHDY/tVLc3Kv97l0KV9JUMCzbgS+U8VL3gRRKx67scDjv
	8ALxJqqzOogA+Ee/zMuX81uYsvoUkCTieul99p6SbvksPIeF/QvqNrl5O7FLG6gX
	FLcPkSX2c5x/zHhJ58YCbsq1WBjOcW9etzp8zbhbtJpJ9odXFAoCBRiu7etA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776268153; x=1776354553; bh=8OoFB1xUqQdY63+lIcCa5yDSmTtnmTtNv0b
	K4jG0gRQ=; b=fBdTpNK9f9hZz6vtnskh5Efg+rJVaFuFRsr2lxnH8SpgY7ttCuW
	voNi2/ztm3sfm8Nrm7OU9K4ijuoxXPw8RQWDgxHjUUXf6wBTBD6b9g+ithBQCstV
	7bWJ09S7O2bGfHv7Im6yj9N5lta9R1eBZbuzb2HnaG1YjYP+ImPxPp//OfFEU+Zy
	v6LN/aCPqHRKCJjvLoXKM1mbLyTK11f3FcgD/VGKD6fqxWeWNN+Ops1yXf2LA5HU
	l2VEk57vMuan5tPL9/23PBb54FWltg3tp5cAoll42ktIBLRuRMchIh93s3lF/mEG
	lcYuPmVb7usExFS0c4d0jPDUedyv0sNYFNA==
X-ME-Sender: <xms:ebPfae4r_3V0-OTdXxCdffKiSkFeceiJjYk2tzCXZYbbU6SEgCrqEA>
    <xme:ebPfac09EnD8Xf02o-5cI-PqAl_LDWuqZRCMXICoguwH-QLMJwWyJiz1fPiU_z7oC
    duyH-U5UIwXqNiQvQ8dSOQThfY9P6mv0_OgrGQUMalIEeTnXNcbazU>
X-ME-Received: <xmr:ebPfaRuuxltAGpI5SY6p3EGZyqxjysxpqjte6kk-EoCqPP3WN3TSOD3XG3-yT20QloW1Gaa94G9XSqIdE46JXgNgqZiyDvTv2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgt
    ohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmh
    hivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghr
    rggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ebPfaa4ZipBK_rJP4RXTTNodhp5G_pgJTdQJ-GCRqAfrXq-eODJhfQ>
    <xmx:ebPfaVc_TvdAUv9O7ZOxUJKJLPwi4V7CB8ZLbBE_11PSeB_ZFYEeOg>
    <xmx:ebPfafwIOedpnNClRhLyCE28E66pEBB2KCbcmn5dKnNQfw8L4HgDqg>
    <xmx:ebPfaS90UfWyOzQu1ZvEQUbhLtvIE92VKB_SiNDKqDM8DL1JDgFCYA>
    <xmx:ebPfaeBOA6MuNcqRj4tpqQ2QjSGEIjK_zu4NSX9RUMwFzdCoE0WL2MLB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 11:49:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Olamide Caleb Bello <belkid98@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct
 repo_config_values`
In-Reply-To: <CAOLa=ZT8H3xLXjact9it9jveviztL4Q72KNMk5nxW_ouq0T0=A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 15 Apr 2026 04:16:23 -0700")
References: <20260324123750.157143-1-belkid98@gmail.com>
	<20260324123750.157143-2-belkid98@gmail.com>
	<CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
	<53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com>
	<CAOLa=ZT8H3xLXjact9it9jveviztL4Q72KNMk5nxW_ouq0T0=A@mail.gmail.com>
Date: Wed, 15 Apr 2026 08:49:11 -0700
Message-ID: <xmqq5x5s8brc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>>> Store it instead in `repo_config_values`, so the value is tied to the
>>>> repository from which it was read. This preserves existing behavior
>>>> while avoiding cross-repository state leakage and continues the effort
>>>> to reduce reliance on global configuration state.
>>>>
>>>> Update all references to use repo_config_values().
>>>>
>>>
>>> Nit: I was hoping you'd also shed light on why this can go into
>>> `repo_config_values()`. Does it need to be eagerly parsed? If so, why?
>>
>> If trust_ctime was lazily parsed where it is used we'd end up dying in
>> match_stat_data() which would be quite unexpected, make it very hard to
>> reason about the code, and hamper the libification efforts. I'd much
>> rather we put the onus on patch authors to justify any conversion from
>> eager parsing to lazy parsing rather than forcing them to justify
>> continuing to parse settings eagerly.
>>
>
> Agreed. A note in the commit message that this belongs in
> `repo_config_values()` because it's eagerly parsed would be enough.

I see "preserves existing behavior" above.   Wouldn't it be enough?
