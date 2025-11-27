Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0E309EEB
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273733; cv=none; b=GVcYeIQsDTe4fHC7pWtH/YkEzxa63dpnHjhCSPOTSgiWyp1NveT9aL63besMeWhyvyMQFS/MMgiwkXwWd5m0HlO6/zxH3XjKoqMz5YCK/OPbdoD3NqwcZTwyY/4tEwNLgeYQRfmTo0aMppXluvrOhPierQUSl3EYQKAhpF4NapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273733; c=relaxed/simple;
	bh=QdzVSGGYGtUWwBpCYY7Kt2RtWnurOmdeQIWNGETRc3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wkc9mxXJiiY1pG57G3GoX5TFZ/K/O3kpB3qxLmv51OvDrThSqhIAYM497KvBpFvJbb1OQYbHZDT5ZjSAI6ePbZLWbSEEdMOiAcEMYTMoG7D7Qo4CMAEZTBXJbdBlr9t0xhdLq42p5rjf1Av3px6+dTzb/bJu51++bwoeR2or8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=As/pxSqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4BndCaX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="As/pxSqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4BndCaX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E8617A0579;
	Thu, 27 Nov 2025 15:02:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 27 Nov 2025 15:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764273730; x=1764360130; bh=QdzVSGGYGt
	UWwBpCYY7Kt2RtWnurOmdeQIWNGETRc3M=; b=As/pxSqLhc6Uwipd5O+bzvd+ec
	NzIUUuEgL2m2z18fwg8j1JfEGw/45u+dJ456RGzngJ2omSGM0PIPjXy4LQjlTsDb
	Dg2tS9rcvCI7jAitxJd/ZUcm8u8TJAI9LDLuTawJuqIIpAJUuqmJDU+CKp0bSSgU
	VBSgG5/FlE+w+9rKRXe16x7R8fcyYf+4STtjWn9A9LDNFmZiPLs4N++wag+dZYA3
	6KBwzYfIqzWndmXDyqhY9pbCHZyYdL45O+SzjQmu8tTO+q80WSdXchiBwgy5OJiM
	a6M3Dl16H3AK+XuA0rpUDqrGMd7iXg40A2vIrI9aklAc6tYVLHGpivS/UR+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764273730; x=1764360130; bh=QdzVSGGYGtUWwBpCYY7Kt2RtWnurOmdeQIW
	NGETRc3M=; b=L4BndCaXeLBeMFQ37RuIzDORG0Pm2hwgs2vYW4b8Up01N7R/Ibe
	kf+YOOSwNCehXqNbo+tNdjrxw/jVga6EZwOLQHKPtd+e5eZPvAy39P0R/lsGnDdN
	EL6+/cJljzSOM5MDdjD0SxR0Y8mYBBJAnjGqmJmEJ9pAdKP+l0WLjxNHT4uDUBz3
	D+BhK5KprvElivPLLGj+fTGSKj4vpiU/dGmKIKWARC/9vd96R79OREjwXUScrm0c
	N4+uFTUWpMoQgRExy0N7hBabRuU5VW3d1nPlGecEr5Sq1qETVNgMMvDMQvBA56HI
	0diOPiCioKtzajMnfak3hkaCz11WW62n66Q==
X-ME-Sender: <xms:Qa4oaeYn3iU8lyruiGgiwNffrElc1-HKfbzfqFILkCXo0fPOdHtxeA>
    <xme:Qa4oaTqlRfLvtHWVIngPyZ9Bx0xLp3kwkqJqZdQKE__-IKU9JPdxWALmOEOKUHwzK
    qWWx7pVao7qKfgFmhKgZJzGFtKlHy7tUIUub-844wgpZYN3VU0>
X-ME-Received: <xmr:Qa4oabNR1UIJC6IPMYZaNlLxOjijSyQiQjzesgQZOx-gpPulSOcJZUvflZOhR9Y4e5-3tUZ8sZVQ_Qx7EB_a7NGOT5jZ32NUHac0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Qa4oaWoJ7jXeEhLW3Oce_DASVLyS36ZXdavaICTXOoYhD6LJR8xIhQ>
    <xmx:Qa4oaYcSPLQIYSnGANmt5U7eZ3jP2D5iavFGrIiRO85tYVT7jd3xAQ>
    <xmx:Qa4oaUSN-i5VEcfupxI4s_u-ICYyodZFqBgOW_tgUoTUWIqVVXScyg>
    <xmx:Qa4oaZaZI8L-RovkG1ss9Qi2Gzq6k3zP68zTnM0x50de_F4KbGEvbw>
    <xmx:Qq4oaak0Wo5U-DhzQukiInwf7zKAf6wgOIL7TWJGph2j2mEAw9JNutuQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 15:02:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  toon@iotcl.com,
  sunshine@sunshineco.com,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference
 backend and directory
In-Reply-To: <CAOLa=ZRPYUJu4hVuZrXdJ1vq89=Pkiyw0-As=0B6pL1-cymR8w@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 27 Nov 2025 06:52:56 -0800")
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
	<20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com>
	<xmqq7bvcpy35.fsf@gitster.g>
	<CAOLa=ZRPYUJu4hVuZrXdJ1vq89=Pkiyw0-As=0B6pL1-cymR8w@mail.gmail.com>
Date: Thu, 27 Nov 2025 12:02:07 -0800
Message-ID: <xmqqy0nrjlc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> (2) My understanding of `string_list_split()` was that the `delim`
> argument are a set of characters to split the string on.

Ah, silly me.

> But the mechanism isn't for 'git refs migrate', but rather we want to
> add/update references via 'git update-ref' into the dry-run folder
> created by the 'git refs migrate'. In the broader sense, we want to
> manipulate references within this dry-run folder as if it is the
> reference folder for the underlying repository.

OK, I took the cover letter description too literally, it seems.

If we want everybody in a single session to have a temporarily
distorted view of the world, it has been a tried and proven way to
use environment variables that override the default repository
layout, e.g., GIT_DIR, GIT_WORK_TREE, and this "no reference
interactions go there, not the usual place the repository
configuration says" environment variable fits very well in the
context.

Thanks.

