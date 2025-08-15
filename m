Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD3201113
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293469; cv=none; b=h7nXPLk5eH/bHDI9L7WQIicfUOKxilqngTJxT6L/6ZGvCTTkqBQjFbaGcD0xOshyDqC/9h27mguY+6oK4exADUCFhZSYsOhy/C/svqvmXOnQe5jrGN3upDhIuzIE4cBx8n+Up1PmLzJcWhQMao73GlUZguRUwMrrBjdJgRl8O+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293469; c=relaxed/simple;
	bh=eYWbWzeQ2s8K7FfXZnxDu4+po8NROZ97phnYBdERHW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I32I+OhZJ38dA4AfWSpXJubAbbpVnpHzg2r+n5zKdWVDFxTmiFXnso5n8RvKiTkCmrFc89jniBl3/1rbRDj7DKUOAcTzcAZ0vcud7QGC3HtBBywuoYoV/rvJw3I3oBvy8AU/8P2eLlpv4fuxSpuUG7ERkiRFNgJzJM7IBJV/df0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XbwqFifh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMGSNk6m; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XbwqFifh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMGSNk6m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EDC2AEC01B2;
	Fri, 15 Aug 2025 17:31:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 17:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755293464;
	 x=1755379864; bh=0G6DQdNprAI2W8ehNYIf68B5Z52lLBXMhr6oWXdfPfI=; b=
	XbwqFifhM3xbi0hu2EHfMgZMZtnqwNCBuEAAvbtb+86iutG1BHmpOJEZEu84G4/p
	DhoLS7n69fUDgv7u5DTkWtsoOFsT3yaQdoX1lZlwEG0pIM/k3MY+RkO/JU3aUczN
	/0QItWUCLpwnjsejjXM29GyHryMmcAHm9gMkK12+K5xWzRvxSpsWfozh/HvR6Jjg
	TLDtgj21M7geGmH2R5UdnCwFBA3Hz2TuxkVkhI669eKGyVuLOiAyzSivjSLom5cV
	zBIkeKYOuL6NhdNcTman7zzX/s/WfHkjIaYbGEyFzd4TtWBgmIXPfaQmYRuyqWpA
	pcJozauTWBc+RMTK3BJbTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755293464; x=
	1755379864; bh=0G6DQdNprAI2W8ehNYIf68B5Z52lLBXMhr6oWXdfPfI=; b=W
	MGSNk6mNimeuXcNBX+tkf3KrwTbzm5cadTMql81mYmHyBn1NBMcQJwF+AsjdGvR+
	o1VJ8nYpI9+YRUJWyP4dTJNQRXVhz7ny3v1pgF8/rsIOJNQILIx1pssyDNmfRlwU
	Q5i7afkZXB7FksFVNiBgznWbbZPj3tBG24DxpzxAep7ZyYiLLLOPiqbvEUtWaNx8
	A1inIxZdQxE2QV5fTyP4+3EDq5JKQyjoGBdkb5dhhTCzF7BgOWfmP2zP2N+LtMWV
	rXSahtaZeoRA8jebg7gci34uWQJPkxBdTfCiBYwyi6y50vUce4p1/9bVZj2qGJ1y
	BaVaeiTKKJtKCKYKFSVGw==
X-ME-Sender: <xms:F6efaLysZ2bldRfGDo4m6PhtSrIl253FCWhQbM7WyoU4J1v_Hj7ALw>
    <xme:F6efaIyTRE9vfwj4yu0-n00V6rcohksGX2YTGT99lTu6R_ij1QfOocTDJBjkv-gnh
    GIRKZZWYg0EPJXxHA>
X-ME-Received: <xmr:F6efaNox7Sv0PLyJauh5SZJdUZUql_C7kDrzaID_OdcSjrWlGoldpIbvQnXrXNzQpR5ZgimoQZg5qoVErvCplPcAzxo5NSSH3UmvR1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhhrgduleelfeeslhhivhgvrdguvgdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrgh
X-ME-Proxy: <xmx:F6efaDnVdmv9f38Ft2SUMkazKPxpmGjPYlJfca5f5qEPIT3ITYUfOQ>
    <xmx:F6efaOy1rIcMbpNpjhYXg-q3eEBIKqZk_YtiZJCh_y7zSUfZz2dt9Q>
    <xmx:F6efaA2HMWPCBUfgX3he443F-_YjphbPfLxVJlcGVkwlErpm06NFyA>
    <xmx:F6efaCCMS5Yfh25o0cp_C_KvR3uGAx_1YmgEhleYDrzJbVyTU6xcbQ>
    <xmx:GKefaKyZAQ8IEm6-idDDvBJDlELcxpBAJwUVht0PecctkPRqfSrUB4q2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 17:31:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike Hommey
 <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 01/17] doc: add a policy for using Rust
In-Reply-To: <DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 15 Aug 2025
 19:03:17 +0200")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com>
	<DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Fri, 15 Aug 2025 14:31:01 -0700
Message-ID: <xmqqcy8wnuga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matthias Aßhauer <mha1993@live.de> writes:

>> diff --git a/Documentation/technical/platform-support.adoc b/Documentation/technical/platform-support.adoc
>> index 0a2fb28d6277..42b04b186105 100644
>> --- a/Documentation/technical/platform-support.adoc
>> +++ b/Documentation/technical/platform-support.adoc
>> @@ -33,6 +33,8 @@ meet the following minimum requirements:
>>
>> * Has active security support (taking security releases of dependencies, etc)
>>
>> +* Supports Rust and the toolchain version specified in link:rust-support.txt[].
>
> s/rust-support.txt/rust-support.adoc/

Your review is very much appreciated, but ...

>> +
>> These requirements are a starting point, and not sufficient on their own for the
>> Git community to be enthusiastic about supporting your platform. Maintainers of
>> platforms which do meet these requirements can follow the steps below to make it

...could you trim your quotes to relevant parts that is needed to
help readers understand the point?  It is a bit brutal to force
readers wade through 200 lines of text only to find this "you got
.txt suffix for a document with .adoc suffix" comment.

Thanks.
