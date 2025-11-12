Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82E313E21
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966297; cv=none; b=f7VuNr9BJCYHwIROGBwWxlTp4+ninpYrOLNFao3vPBWb8EuKRR4E5hL5Arub05/sgB6DdZhMaeu3YWySyZBHAoL5cDapN1GVkl1gHI+6r7cGO3sksYcKQolU6aXNGvmTj0G0iO9zs35CaDwKU69XKBLfkXvuWKOMFMh7Wzr5YbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966297; c=relaxed/simple;
	bh=R/Dwf1yZzQOsRgGaz0/JdwdyDHt1JVUBX78YkNovlNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sjH6CPhBmVNTkqb+eUofPmAdEIyLBTIogWProq9/gtEQGjPWL4K70EqRzTfT+eyBKSRqJGMdMW9srV2KQcOeQ0PB4tUQwb37XmFgug6qKLCQ87P+JafAModQ7JnsV7ZWom0kUN+cuvkV30eqPtMK8VjGCO+sufJTG9JMwjaN0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mrCIAed9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlO8q5jK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mrCIAed9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlO8q5jK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53B497A00A1;
	Wed, 12 Nov 2025 11:51:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 11:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762966294;
	 x=1763052694; bh=POSChanV77U7g34LCVz1W/TmilX9wLjfV8Lpsdj8tNc=; b=
	mrCIAed95pcIMqZbUB73G9d52wKZb6XI8OlL+9Q8fs1Kzl5NKYx6xhrjEchYHSxY
	3m+0wD/yQmvd4sEs2Nj6BGdB4s2j2Y3sJL0QBSB6RiEGlulz4mfKNPdNwKnE8vPj
	fd1We2QvEX7LTIECiB9sOhZo8moHgerN+pj6QVqqO9htakIvR7hQVKUchApx3koo
	Nb2j4GgozF0681r5lgYqdiNU6hD1DXYs6Zmoy179SasVHVG9rSuJyqk+LYYJy+1N
	B8hDvRijN3i87eLX23cv6H8Tib+LIIaNiO2HjsJIARTF759C9eFnHPq/sBfZojyr
	+xwfgiBEELxo1h3R8HIZ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762966294; x=
	1763052694; bh=POSChanV77U7g34LCVz1W/TmilX9wLjfV8Lpsdj8tNc=; b=T
	lO8q5jKU/T3eedYAN1P41r2cv2Su1Moksc6RXoXbotIaD4s+M7ziPKksypKuwftI
	qeXPq51B/9qiKSacYx6QZwYLgN18Kkwb8N3QLO5Q20f+jyNPFnQNN9TP8im8dNQA
	6/4939+JK4SpPRMrrgpZm9NetL3NRnNPG584NKozE91DmQ6WILn2/uQI5W/UXuDI
	hzgMqSVtxgXD8PBrz+wvLf5jl0ZNY7OxzUHO55dMQjW0S5YJDxFRpqd4JLY9JmDN
	8FjTF/CE16j0Nyx3qQyGkNBCwqGxWD8dRjA1Uwo/xx0c74/FDTcyipqLwnrcdomY
	s2ecBLHwwcQ+YmxBBxQOQ==
X-ME-Sender: <xms:FbsUacWugXRtPbfIanTxpiW7eDjoOQu74_XAeVs1QyajEYGpZk-YgQ>
    <xme:FbsUaTJIjET8NW7fWPiYkQdsFACF0HG8FRf85Hnpo00ZbNowA4LgU5SEgcxrL5ZaH
    n3ENB9iBgtYZK8eSp5WRGhKudbdoorvkM5TMMAzcOb9W4KR0FwGsw>
X-ME-Received: <xmr:FbsUaUB-zakRZIYkDlpYZsbMFVbca3y-K1tEsuTIFQ1kNRzqED7tRB4YHqIr9L7oUYxTlGzpbwb-Z5NwQwfiu3wQY3NyjqgrwDeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FbsUabf2eNySe54gdZtp3bZoGfcjQvuAIXiQBVz-1jHLn6AVFSQmaQ>
    <xmx:FbsUab2lXTHD_s72XNrCqugdkBSbdlKtWUKwRexGSja5lnDmRpaUFQ>
    <xmx:FbsUaagVpen5nKmDWayZ7SInbJkfa3CCko0FEBgC2bwh0cSVCLrOkQ>
    <xmx:FbsUackkpjxRe09ZNaiWCvkC6ce1dk56HYRaI27wGFYeQaj0EHL6-w>
    <xmx:FrsUaXHIgO-kwlw_sDopl9s8qKc0UrJ850ycxz0kpm7E41zYntQ2m5Ax>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:51:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] fast-import: add 'strip-if-invalid' mode to
 --signed-commits=<mode>
In-Reply-To: <CAP8UFD3G6kn-n1_rXJgcZf1djUE4Ner5xd1YaNr5tz5h8d_Ypw@mail.gmail.com>
	(Christian Couder's message of "Wed, 12 Nov 2025 08:25:20 +0100")
References: <20251105061918.3688870-1-christian.couder@gmail.com>
	<20251105061918.3688870-4-christian.couder@gmail.com>
	<xmqqjz00e5ns.fsf@gitster.g>
	<CAP8UFD3G6kn-n1_rXJgcZf1djUE4Ner5xd1YaNr5tz5h8d_Ypw@mail.gmail.com>
Date: Wed, 12 Nov 2025 08:51:32 -0800
Message-ID: <xmqqms4rry7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Nov 8, 2025 at 7:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> >  t/t9305-fast-import-signatures.sh  | 118 ++++++++++++++++++++++++++++-
>> >  6 files changed, 226 insertions(+), 28 deletions(-)
>>
>> Unfortunately all these tests that assume that explicit-sha256
>> repository as a subdirectory exists would fail when the topic is
>> merged to 'seen' and the tree is built without the optional Rust
>> support.  This is because brian's f6581e23 (repository: require Rust
>> support for interoperability, 2025-10-27) changes a couple of tests
>> to require RUST prerequisite.  One of them is what creates the
>> explicit-sha256 repository.
>>
>> I do not think this topic to preserve or strip GPG signatures
>> particularly cares about the dual hash interoperability, so can you
>> rearrange the tests in this series to avoid crashing with the other
>> topic?
>
> I will do that in the v2 I hope I can send soon.

Thanks.
