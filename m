Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F542D543E
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765582786; cv=none; b=PHWdVDpikNsGhETJ3m+LFld8YRshRAT8qzHFrYgMEbCA/RnKkd2YYjxnfN9zu1o0YxVZkuO+JwARLjjc6FKccFHIL1NZrSB96Lh+4CJjWRdJJwnnEb6ILhX0+RA0VrbYoUwle+9serNBziQga0aJC3xEh5o8RnrjGCmlROt4o2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765582786; c=relaxed/simple;
	bh=jlvVEx0nZFZjYvoEJJYIblTt9NIPbSDMwL+JDs/d4oM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8gG5gwx8n6dDs4PcsPWDFlErTZ5ZdUjiu4/S0yNutxMieskTUgr5tYi8NJ5ti0RTHC9sxdidMil5BiiO20MocEacq37h/ZbSRU2/J1ESwX2ZPYQ3R/H1ivKZLIbn5rQ+hJco+EOB/9L914DZIhPMYZ/Q8D0JkdjAVrT+/X3OdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iV2aTRHu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZ0Y+gKp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iV2aTRHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZ0Y+gKp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CBF6E1D0009F;
	Fri, 12 Dec 2025 18:39:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 12 Dec 2025 18:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765582782;
	 x=1765669182; bh=dEsAh3nU3QfMVuTfhPJT8OkTOeC7BR55I+ORwXHQADI=; b=
	iV2aTRHurE6zQwlCfp/j++ZvqnFKzl3Ro0ktZ2r21cTid9ojoFcp5unCpvVhj9KM
	c8Aam8mPsry9Th1zkCU8pcWrrncno8escemDm2vrLMxfl5+gEew8IPnkvA+2gqP+
	fJ83lY3lYUXvKTKveSWkM8yphoLeFM/EuwyehbBSlmpJKsDBXwUEG8vx4ZPOiAd1
	QPkxhUh3IkOQCA3TBPIapzu9vXy34MQBOQfTizsmMS5cy0xwoenfIwAY+dv9ueiH
	dJHhzxKb4wRV3Jtpafva98kkoxNWIj1ezHYGrHmm23SjlWJ2ox0r2UVViVDL4oyd
	054+5NMXxf/PIZy1Q6XdkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765582782; x=
	1765669182; bh=dEsAh3nU3QfMVuTfhPJT8OkTOeC7BR55I+ORwXHQADI=; b=S
	Z0Y+gKp0CBgrvSw7i8M8AAjGm3S5xAyDEagMXqipDx8tzADnkhBRb9zbYWObUFzn
	t/TJAoqlsYB+D+EED3Zep8TsBVVJdkxWIzjVLx3pbUjzRYJM7H0OrZQAKWJv+TBm
	Fqj8arEQE79j7eR2awklb6Qw5modi97gP6DnvZVe804/wxP2gGlhxgVXB52VJkg4
	g5viA73QmybNjPVsMAYaiYvmX6+v3IlLa/ScCvHeX5Y7CutAkE7ymA/mVh9umszl
	TpTAfbCtFXDNP3qlDEvh5nf/7FFhKfACpy33xV2PNSG13+mbMAiYP86WJiuow7Iw
	R6MCKy+wOoMOQ2n/GYH6Q==
X-ME-Sender: <xms:vqc8aQN4IW2qrNwO2m4QuhgpRGf4JDGMqAvX9MCouvPkVz1kcjrlJg>
    <xme:vqc8ad2xA-GSdYowpkZsBQ0hRnEF1nyulYQUttdiw9itHNzM8OZtz97pdALOSAms8
    SY_jc2PVpk0KLfBv74gWQLyAXP-L6rbU_TutXzAOxAo12wklSWIjQ>
X-ME-Received: <xmr:vqc8afnbLWGgLMWb8DXNKjKC9nbYipIRZXrxLcF8rBONIl65ua2UEAvpD7gjNZM8qKiwIAOhTU7WQglG0T_Ldq5vpPUVpwLhZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepuddvveevjefhudelhfelkeffleehfeekvedvjeeltddvkefhkeekleevvefh
    leetnecuffhomhgrihhnpehfihhnkhhprhhojhgvtghtrdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegt
    rghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vqc8aUWJVdFi7BP8defBqkq5gGJpXyZRWrt5Ut0vlQN3vtRiu1WSmA>
    <xmx:vqc8aVstcZEMpE140Edmm-Kj6OklbV4IgSX6txaqoK1ymxxWBLQNCA>
    <xmx:vqc8aXZr0Fk8J3ci0p_kde_ATs864wJ5j2KDYtax-7MlyJSKwUBhGA>
    <xmx:vqc8aUUNSznTgpcXtQdP9igR6LiOa2E7SmISyBNenVApGdfvIDN3cw>
    <xmx:vqc8aZX8xmUCS8icY30Wz0eiXfga_6vUr15R1YavlEZ8KrG3Frnimguh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 18:39:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Git
 List
 <git@vger.kernel.org>,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <4b752020-036e-4f1b-9963-a54f361ef0fd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 12 Dec 2025 14:48:04 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
	<1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
	<xmqq7buthgq4.fsf@gitster.g>
	<vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
	<xmqq7buse906.fsf@gitster.g>
	<3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>
	<xmqqms3nc0mj.fsf_-_@gitster.g>
	<4b752020-036e-4f1b-9963-a54f361ef0fd@web.de>
Date: Sat, 13 Dec 2025 08:39:40 +0900
Message-ID: <xmqqikebb77n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 12/12/25 2:04 PM, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>> 
>>> Fink uses /opt/sw
>>> (https://www.finkproject.org/faq/general.php?phpLang=en#why-sw).
>> 
>> Perhaps they have a symlink or something from /sw to /opt/sw, then,
>> as our Makefile only talks about /sw and /opt/sw
> Hmm, they changed that in https://github.com/fink/fink/commit/db958e12bf
> six years ago.  Apparently we didn't get the memo.

And apparently at least to us upstream Git, they do not matter;
otherwise we would have heard from their users.

