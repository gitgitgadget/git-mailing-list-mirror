Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6372617
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243399; cv=none; b=UpK3cfFjVxzmwb25hk/fVtwUvJ69GA12x0S3H7pOu8ePdtQHDEH+zK2IwR65vDBj8OKL62omOPeejgDvLtJi2Tj/SFO2OdwVR4trAu1GWSqQr40M/h4ItNGOF4lWREOATzMb2IbQHVO8j4LJCb/mXobv2KnHBFsS5HXYR1Piop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243399; c=relaxed/simple;
	bh=0kjKy9zFTQObP7BB3zIlCnOT7QfHqr45T774kdBkMfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjnEFKsizR1ZhlgSh0Plzq7XrSH7ix5EUD4jXszBpe0Nab6V6ojFL/F+bWLfRaFSG3DU30Nrv9k6UScsBhbZfRhQ3zR6b9caPtDqzy+hELfLq1tEHDmbLux1cGbQ+JK7Tk4wuf6XKarVe6DHiKccBM8fuT76lxgMRyQ5Ca/tdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=So8UrvGi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kd29Mvk2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="So8UrvGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kd29Mvk2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12EED1400197;
	Tue, 30 Sep 2025 10:43:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 30 Sep 2025 10:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759243397; x=1759329797; bh=Y/urzzoy3I
	h+Rd1FB3LTlNqVLjIWhxnovKT9ZU7aIg8=; b=So8UrvGienYEUC4dTkgxdxrv4Q
	E+qPd9Pos/Z3aMdQgxibZInpxtvAACZWzniPfrlhVVcTOA/waQZ3UuR4bpGDDJpl
	s+jEsiWHdMnJQleQ4LootxfR46D5tp3h6iEs+uAKub1TSlNHTJIhus4FKy2JQIJn
	kvPUd6SKqW5bGUu8FP+oehHE1cEMdPl2Y2NBvnHH2WxDGFUzLCp1IwMCoMDUW9oc
	AmR+fVUtjtVX/M+yHHXa/DfGdeegh47GWlHhk67rQejny3uOKTOfXOqJRuhxi2p+
	zNqJ3wBOcdkXFnKlk0nYCGgVex1KZdv87s79frgr1GTYqFmPaG+OiPJu7yiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759243397; x=1759329797; bh=Y/urzzoy3Ih+Rd1FB3LTlNqVLjIWhxnovKT
	9ZU7aIg8=; b=Kd29Mvk2p9HDOJ2N91dDp7ezhLlVBqxegq0n+eQryM5j8OiMfn7
	pC46c3IBojf4+HbjLYcYYiWreZ1sswMMOkI6TF2IIWiRZZ1888MjXW6cdpC7HByN
	LwaOTmewfqC3/3DkKFWKSqGGqQJZVSkgbwSeca9Dd71DeMTyHnLlN3c5Z+HVug/N
	/0xdoE4HAInJD3Q4VJRchObiJ+nUyx08ElTQSpkOC5lYbHRBNCUfcUw1H6AxxEOC
	IP8C6/tOBqueyr6FXiX7CA7x0WbZA7iwi/kndj+o/FOzWep1PUcYhcNCaTNSTEv6
	+Ch1EmKVgRjss+AtZQBBIeVtrqZMWnEaBnw==
X-ME-Sender: <xms:hOzbaEv71BoWvUoNhMCeEyCVyUwzbb3AmWh1QWq_MLFpnkQGBK-58Q>
    <xme:hOzbaI5YaivGFLohfkd19IYwFFdnrS61PK1HRbqenjIQMJz9cR8_CZVetIrvmRZee
    GNF5FNkwdBKSvXX0oD03TKg4UkjqJyL68cG5JpxEfiBSCPPnY3oVw>
X-ME-Received: <xmr:hOzbaNJQPQNhz4i6hTw47q6xUsZOkjDgnqNBs2lkNZ-EN8VxopBmKHfENI3V4XD-nwGk9tWnuyTVGm08v6QkXWC3WgiXPrTy6FUH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:hOzbaA6ZGv5iUb6fiX_bpQIoXIA3IFSMeceIXYBreafG6Z2iEqFeqg>
    <xmx:hOzbaIw6H75WQplbTyiHAUXvEEQsQWku-B_stnsGbjKc2dE1qxa5IA>
    <xmx:hOzbaMY2h23RKmUnwLbK3Pdp37TUMiCwHZhmP_Xb9mK5mjIrpM4U1Q>
    <xmx:hOzbaCRAI77M6yS75oVKHuJfflXUZuEHFAjSHVll1DrVjVWXumUROA>
    <xmx:hezbaNl64WiTN2ljpLjfj4cmDfLSBLkLElJ_z9rG8sTigihs2eksOcLy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 10:43:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #11; Mon, 29)
In-Reply-To: <aNsQ5UjjbqJr8_Ik@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 29 Sep 2025 23:06:13 +0000")
References: <xmqqv7l06gwi.fsf@gitster.g>
	<aNsQ5UjjbqJr8_Ik@fruit.crustytoothpaste.net>
Date: Tue, 30 Sep 2025 07:43:15 -0700
Message-ID: <xmqqikh057cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-09-29 at 22:19:25, Junio C Hamano wrote:
>> * ps/rust-balloon (2025-09-24) 9 commits
>>  - ci: enable Rust for breaking-changes jobs
>>  - ci: convert "pedantic" job into full build with breaking changes
>>  - BreakingChanges: announce Rust becoming mandatory
>>  - varint: reimplement as test balloon for Rust
>>  - varint: use explicit width for integers
>>  - help: report on whether or not Rust is enabled
>>  - Makefile: introduce infrastructure to build internal Rust library
>>  - Makefile: reorder sources after includes
>>  - meson: add infrastructure to build internal Rust library
>> 
>>  Dip our toes a bit to (optionally) use Rust implemented helper
>>  called from our C code.
>> 
>>  Comments?
>
> This looks fine to me and addressed all of my previous feedback.  The
> cover letter incorrectly says that it's only wiring up Meson (which is
> no longer true), but we're not including that in the series, so we don't
> need to fix it.
>
> I confirmed that my branch using Rust builds fine on top of that version
> as well.

Thanks!
