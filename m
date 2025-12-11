Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CF1A9F83
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420581; cv=none; b=HpBoTmrn7UF42XswO1C8xj/j8ZLg3RWwlEcn684drT26+LLLhsEk/Tj38ekhdomut5/by9CvJ7jv0iEwk/xjx7NImA1Y/M3YWwUDkH3ygKRFkU6COm+82/5S9FGVZB7AeE+v857NJvqJ1Qhjof5YKANqq4GC2ycM483kNm5apvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420581; c=relaxed/simple;
	bh=3dBSiKAusFfuXB1G4EFJ8I1fEDvosOSMUvd0dRH8ZBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o94MYbWpDTcCkq6OuqjhcRNE/2j+iTD9hx2xq5zRFXlvTIM4poXTpXNhSlVyFUaF6+s1M4I+oHv8k7NFD1VPb+WLvgYRp6bwNNFpSTclIUHkeUO6IV75LQo7BzbPduzs+zeY2XwkJtl/G6k0FR+j5ftW3WC2suyOxkLx7E0MnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f9Mo4kFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3B3o9Qj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9Mo4kFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3B3o9Qj"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7698F7A0083;
	Wed, 10 Dec 2025 21:36:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 10 Dec 2025 21:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765420578;
	 x=1765506978; bh=k8LC8b8AIy9+Hav0SMPFkyd+Lgiuw5Xxdf2ej2mnOM8=; b=
	f9Mo4kFBrwqExyK/4ir5gB8j8ANM+WFVjlFfFAWxQ7utmOnYEcVX1XPQ91RVWmEY
	CAT1JXpPPJk0i1kZnpt+mFysQzTtrY/exQdWzvbeqOKpuCf8LxJQalctYh8yBlY5
	SwLEYtSFNbMk2zhtcAYFwtZb1BJ5qczs1o0prxQq6OU7pwDjEbZBOWmq2OQjC1hB
	VpIS9FMcDzWhgbiQD7I0JfPKh6hGBp6m+9/njVxQ5Id+VFakQG9K4gjy+2R6laCM
	6EsUNnydDbGx4hvsuaEnUbpRiUvgP04SqVC13t3pxr/XkW7sRTJAs5KOpZ9ljWSo
	nHDuHb9Tws8TImA8NU0MQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765420578; x=
	1765506978; bh=k8LC8b8AIy9+Hav0SMPFkyd+Lgiuw5Xxdf2ej2mnOM8=; b=B
	3B3o9QjIBtZ0RfmjHkTRbg8y+PeUkwUQRRb4iojPt8gRCFf04gPTr6wht8Eae+vy
	xL1L9hyQnqyPRgnKQHdgX7NZTAz2ZKGrgJ+YBjh24hatxNfwXSqVU+BYwfMYkPQo
	Bhwbv7xDLqRE1rAKybm1qQpjLe3t7hZKAtQ4a9xt754u1zuRQWmg0sglmZ/HcS5a
	2z8phvw4etKcXIHwkmh/a/Yb3lXM1GHr1VwGr5UMd09Yq0eCMQ2L7+uaR0kd1r9V
	RjtCXFAD1FI3uLRr4Pftj2B8D26XV6g1NSjDpCqHPcYEEqbOTmj52ixcU/c+OV2c
	5FrNv18XqLghRsyq8MBhw==
X-ME-Sender: <xms:IS46aXsjdyIAhxnX03mYleerfnPOP0UvowzavqrUGTj9AbHbeb5jQA>
    <xme:IS46afWDKzEliS3hssY2ZTdr6NalHAKb4rl3-Qna5AGAVRzNWX3RLM7K9pgui2bkJ
    ziBNdPJvt9MaiFeCxSIJ615Ztd4gNeb_mF4EgVQ4l_8cdJ62BVZv5M>
X-ME-Received: <xmr:IS46aTHgA8ef2XgzaUfPzYVLxgLaCzbjYVk3G-ZQUHoRFRXKeyXgGE5AuRVBDDrrxBmwmxc_LnlYE-opJKe0PABmPfnfJfmDGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhjihdrnhgrkh
    grmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:IS46aR2l3-jVNRwRCL8Xo6sjNqWbBozp4VCt2QUDRqNZgnt2kRYg2A>
    <xmx:Ii46aVMYY6f3es5A9vEdoIskE7H154DqJ2lUB2EJf3aWxYUahD3qMA>
    <xmx:Ii46aQ5HjLfwHuAKw7g3Bh0uOtdIIjs9lGz3GqLMgsz13UCHVPLXCw>
    <xmx:Ii46af0csinNhwlBnMRgArI131kMJvQTehIlsxSp8YIAUEiL40LUJg>
    <xmx:Ii46afzeQNOaotkDhjV7_jyZ41LdaOchYqjdUlwTviL9YmITXGQIleSo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 21:36:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 10 Dec 2025 23:10:19 +0000")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net>
Date: Thu, 11 Dec 2025 11:36:16 +0900
Message-ID: <xmqqecp1hhi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-12-09 at 19:35:34, René Scharfe wrote:
>> The library function iconv(3) supplied with macOS versions 15.7.2
>> (Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
>> ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:
>> 
>>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>> 
>> As a workaround, use libiconv from Homebrew, if available.
>
> I like this solution, since it means when Apple ships their own Git
> (which doesn't use Homebrew), they will be incentivized to fix the
> problem since the test fails.

Well, their build without Homebrew would fail with or without this
patch, no?  It is a good thing either way ;-)

Will queue.  Thanks.
