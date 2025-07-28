Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC91C5D7D
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736021; cv=none; b=C8AI+wKvvcJLpQ0eH0sKLHJOx1lrL6vDp0einiAYsJ5Ph+438ZItR69Ds3JXXkODgnEXmc9p/g5Wacxfs76J6DnecLWXTzmp9XHGta8zB3iAQ8JxjAYhrThGpjLqdCmTmZBdqRU/khcnXOu3bntUQUdz7iLg3KPEoz6QwQyqfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736021; c=relaxed/simple;
	bh=mVUiSzPm8gKRKHHTMJ8DzF0qSY4/8S0AAZOhT2jaKFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJOO3fB7eX15Z7jdtXuOz+Gxxf4NAVUWYEoQM4e5A88+K4b0byOj+kjads6h4pk1Iw0oYrgcA08E+WffiIvOC5xvXrw6M28KbUmYoRMZ4b4RVEIECzrYcqU/TsqRZaYg7/CNjoJ2JKJCjlZ81t6+N6KU7p+2Y/jECI59c851Hpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AA5m8SR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxdRHKFD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AA5m8SR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxdRHKFD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 147E71D003CB;
	Mon, 28 Jul 2025 16:53:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Jul 2025 16:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753736016;
	 x=1753822416; bh=GQePkrazt9zu7BF0sW5XIyaZtINKDxX/vYmFvhUoPuE=; b=
	AA5m8SR44aAT8IMO5iuIPQz/sixV7eTSFcnyrB9zITPxAdfH46As4AYypNnyeNXq
	oKqOvD8wYYinMSfEJKBG4CSEaNCi1dPCfKmPOUM4WMYTWqmYDpK0AZggn6/HMpIG
	8jbNntcSp09FxfMz8QcOBipF64m8r46mFOSGR+tjNcaJvATYtl0KfpqEzsJkN3eD
	fLwx3hK2EXkroOKHbrvDlREN+WeBL2Gh7XvBtGwHNRfy3EfFEvU8U51B716Dnm6H
	m7O558GPWKdV6NN1+emD5z0swNoZGRvEJGgKrINwgHycDsjcOTZAqBnwx0U44yrv
	R1vw2UJZds5TCqVym8QWdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753736016; x=
	1753822416; bh=GQePkrazt9zu7BF0sW5XIyaZtINKDxX/vYmFvhUoPuE=; b=Y
	xdRHKFDk8wRotkXVFTkOjSSCqy/Mh9U4MdUsWbA+2dofxjjWLHhZrjjzM3XcGAjQ
	0hfIf9K6hJBVIB5vyzl/Xufa1ukvkbk3Gbhahu1exAC/Whz39+/CQz/ADoFUsPXC
	FMOeBhw+wpK/ojy9JQHg8q/xYo+AW5D6zAxrUAjt5S18sIP9p7Bve8wDupQiw9SE
	m3atTSsTjIY+slb93TdfBNKCTihHI2OEbEIbW0vfahcFZcbgW8rDD5WF4Qt57soF
	7GF9OZ73rCDip5gvs0rLTunCjNfuXRDZS7HfRBeq6UkWNbm5LiEaIFes9Ejzz9LL
	P2ptSJq8Xc2ZY84MvLIqQ==
X-ME-Sender: <xms:UOOHaGNnsEhJKc2A3OdeJKdzAClURNZBMAShqk-VmAZp9DtVfSYezA>
    <xme:UOOHaB61zyzGGIWVr6GjjU-j9viP3kWqKWa10TLQgLcwmoOcsIp1Odao41_WBm4Pb
    UBKYmAprkqbRBUjlg>
X-ME-Received: <xmr:UOOHaI4vuiHwVfr2aPG2k2d0mmj6qW7B_xaFo4VKDMP0Uu7jXEVldySKhWb-twoDn5vFBXqrg83GBZ2rqMJiPMXIxTDdIybJOB8Tp7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UOOHaPFhJsZmS4NWm7X7H16t284hRzg_hmhukqEiP7carBRAgXwIzg>
    <xmx:UOOHaIU3OgPgGgWhNAcPTL1XzQFSSfrVeL0uK6gIHOwxilGjsIxaMQ>
    <xmx:UOOHaDVyCrXelQaUmFIS3vJYGLEuHeSvkwG13bDjU4g_mDq6mbNeYQ>
    <xmx:UOOHaOIenung1VAy6J2ox-azP0Jn-lcH9UV6DZf92IoCoU_5ecIEwA>
    <xmx:UOOHaPEYVDa2iM8L4lbWxu_3Qw5fqShFk90N9d7Ig0NkMUVKMVWhonTq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 16:53:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
In-Reply-To: <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com> (Phillip Wood's
	message of "Mon, 28 Jul 2025 20:52:48 +0100")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
	<91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
	<CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
	<a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
Date: Mon, 28 Jul 2025 13:53:35 -0700
Message-ID: <xmqqwm7st4ts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 28/07/2025 20:34, Ezekiel Newren wrote:
>> On Fri, Jul 18, 2025 at 7:35 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
>>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>>
>>>> A few commits ago, we added definitions for Rust primitive types,
>>>> to facilitate interoperability between C and Rust. Switch a
>>>> few variables to use these types. Which, for now, will
>>>> require adding some casts.
>>>
>>> How necessary is it to change char' to 'u8' so long as the rust and C
>>> sides both use a type that is the same size? Also what's the advantage
>>> of using these typedefs rather than the normal C types like unit8_t ?
>> Rust defines char as 32 bits. C treats char as signed 8 bits. What
>> git
>> really means by char* is treat everything like a byte string, and u8
>> is how raw bytes are handled in Rust.
>
> Right - we need to use u8 on the rust side but I'm trying to
> understand why we need to change the type on the C side and why do we
> need typedefs like usize and u32 on the C side when we already have
> size_t and uint32_t?

Or uint8_t?  Ah, eh, that is "unsigned char" so it would be
redundant, I guess?
