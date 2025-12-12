Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E930BF78
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510556; cv=none; b=W4SO7kiGMUYadnmhSBl2J0BW2EbA99aP1EJK9Mo6h1Ur88KZI84x34MMTOO0UM1Eqv5dTbPm8OUSTLX0zJ59xasDhQLgM/ejmHwYnu5v/FCFVVX5cOObi7dyy3PwVQW4KPtIKrMYM9rXRR5iq7Aqi4r1V+4QNdcHpIKeTHYWjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510556; c=relaxed/simple;
	bh=I9xfDpijpz6uMIJfwT4i6rd9DNnOC4Gi+JSib8g4Ho8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NczJMKO7WCkGmp8fNWWJe/E5tqgzYQ4Xpc2F/GnotgWXVc+W1vUYQhVSgPoE0dCfSZU3+bAk2oZzBulevoms6EfrvoEUUbXhJku5i8rK+8kHbvORjmto6mCBUosyXmLvAdP7aMh+/PftKF5cwK+enmjDHU6ELuXl9pdZGp6UcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W7oYvAAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=poBx+qOj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7oYvAAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="poBx+qOj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 947C8EC03D5;
	Thu, 11 Dec 2025 22:35:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 11 Dec 2025 22:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765510550;
	 x=1765596950; bh=Hvcc9rFEwhUgN53fM6MJOCdLB3/3id01KyxbC9YZDxo=; b=
	W7oYvAAzusCWSBl0NVEGMcigHz34FQNPx2HmIZhPXzp3euKP3NOyrr8v5haaWpeS
	pPrqUsqzwK4mXaSt0bBP0Xa5VH5yi5yC+hAo7oSUZ22xd2jo8YOPe11V9m/EDX5K
	6UmbSbUz7tmPY/yMNqDptBY+AKzn6fE0q3/UR4WnkispjuqYShuj8BimuzF9ssFn
	9jd0WC/MAzf4i6e3acjFnXxfsxozaOnJTtt4aOpfMbMHe+dzkW/pj258l+gCGJ0r
	tysbLRaPUE7TrscvuqRbybYgaDyMXVhIRGXBTCHt2wP8cHLMPZVNcdDWmxeuduv7
	VuwLibtFXfsYAxqhmVfG8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765510550; x=
	1765596950; bh=Hvcc9rFEwhUgN53fM6MJOCdLB3/3id01KyxbC9YZDxo=; b=p
	oBx+qOj+IP0TMavKfk/nFjVUr6AhyzrPpV4I1cbF8rG4JItkiwrwZZDh3n090SF3
	jqljBk3GtWJVE+f+SIOEcSLNKT5ig3jdyGWkabsCK/7DE6O5MLgXHBBdUB61RuqW
	XsFC0KAv0qCZtnir40UUO36lcr2mKTMT1hU1kmeBbe7t/HjBVc0gB6m3y6fZyPfU
	TFtfdzGIVmb2JXeTzDtwd+sKW0yJBDpqFnvHTAYqGlQDFu47CPCPM3TUqIw0KWWf
	4thttPjSyCfB/dQN5cpeDJLtJpASnmWdYEhLVnoXmZudIVrcAiA3UFxy1y+8X6uD
	w8Di+q8q1QhYoh4K5G4og==
X-ME-Sender: <xms:lo07aZqSv17wqXiKjXbu73OwTlmn8TVnSsvmIZETq9G2GIzsDs9yhQ>
    <xme:lo07aSiubEIGoKF-KnxHCszwGgzRNKWN5PQ3ZEt9O56StyIn5JvWqbmEf1jV9cdjS
    s5q70LT0qhuW_mkVHfooJXgcpfpjpkBp8_8AbZxzmSJmbaG6FOt>
X-ME-Received: <xmr:lo07aeipsMz9cT-Scr93QnRoo6bNfcPl1wuJHnvLquQBeH_X9TWKpjEqMg-0lqkM-kfNgN28q9I62p9t_4I7gi2gL8LosyQpUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfffhgefgheeuffejveehlefhvdfgteeijeeuleehffefvdelheehtdeukeek
    tdfhnecuffhomhgrihhnpegrphhplhgvrdgtohhmpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhes
    ghhrvggvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lo07aQjyXzelzRelCHzQDdc8whwqIc29XA79N-EYMikb2UeexepX0g>
    <xmx:lo07aWL6wgs5oJ4ytRl7cF8Qm9Iuj_Ky6Z9lOl8w-C0huGuSVxM8LQ>
    <xmx:lo07aXEBTQGxZkOyMNKYrE0mbxLpXI3iQR_f7eIR1J3aKa_QvIu8tg>
    <xmx:lo07aSRremVZacLeUDJEj-F1HgY9_AP9UqPfp8HFwAVRlDaUpeT2KA>
    <xmx:lo07aX-Uac-zCSYeN91Sk-uG7KQiEjgN49uruBeDLX2DWETGjQoXextX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 22:35:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <5308d067-6c3c-4694-a30d-86a561704e6c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 11 Dec 2025 15:34:00 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net>
	<xmqqecp1hhi7.fsf@gitster.g> <xmqqfr9he3v7.fsf@gitster.g>
	<5308d067-6c3c-4694-a30d-86a561704e6c@web.de>
Date: Fri, 12 Dec 2025 12:35:48 +0900
Message-ID: <xmqqv7iccqy3.fsf@gitster.g>
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

> On 12/11/25 10:59 AM, Junio C Hamano wrote:
>> 
>> Does anybody know if a purely vanilla installation of macOS, without
>> any third-party software collection like homebrewk, is supposed to
>> be even serviceable?  That is, if somebody at Apple builds a version
>> of Git that they ship themselves (they do, don't they?), can they
>> untar the latest tarball on a vanilla macOS box, type "make test",
>> and expect it to pass?
>
> It seems so.  https://opensource.apple.com/releases/ points to
> https://github.com/apple-oss-distributions/Git.  The latest tag is close
> to v2.50.1:
>
> $ git diff --stat -w v2.50.1 Git-155:src/git ':(exclude)*.git*'
>  Documentation/fsck-msgids.adoc                   | 12 ------------
>  Makefile                                         |  1 +
>  attr.c                                           | 11 +++++++++++
>  builtin/help.c                                   |  3 +--
>  config.c                                         | 13 +++++++++++++
>  config.h                                         |  3 +++
>  generate-python.sh                               |  2 ++
>  git-mergetool--lib.sh                            |  6 ++++--
>  git-svn.perl                                     | 30 ++++++++++++++++++++++++++++++
>  http.c                                           |  2 ++
>  perl/header_templates/runtime_prefix.template.pl | 25 +++++++++++++++++++++++++
>  sha1collisiondetection                           |  1 -
>  t/t4014-format-patch.sh                          |  3 +--
>  t/test-lib.sh                                    |  3 +++
>  usage.c                                          | 20 ++++++++++++++++++++
>  15 files changed, 116 insertions(+), 19 deletions(-)
>
> Their top-level Makefile sets NO_GETTEXT, NO_FINK and NO_DARWIN_PORTS.

Thanks.
