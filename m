Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5491CAA6D
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432801; cv=none; b=ZqtwgvXRTml+wGLyjiveC67BGq6EOurwjRFlVslm3sy1uqKy0/swOSssdbcKoQAnF6bGeCixliR9qFdt1S55LcIRGb6iE5omVYQtaHPPSgoHEuWDK/8vvev4HZdD49vwwpr5I55wP8pKvwJesHNnFEsuYOuQG42LTxvWLpcJNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432801; c=relaxed/simple;
	bh=q81S+gmpO2W+Ul47a0zJMlEXy+MebVuqjKDPzjkPNHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HlFFIuE9B9f0gXJHuxRw35rdQYp9Zxy+xAPEckZda/a63tExpqghb16YzmI9gpMOrtLQ/SfDdECguZxwDmWFSNlaO+on7FWQKTzERVirgdPIdZmlSzFwp/WIRyGH9efFUjum8FhCo1P6YN2sPmVMjwG2rPTZBGQshKBgwdDchnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O4Ugy9ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hn94a8ce; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4Ugy9ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hn94a8ce"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58C8911401C3;
	Fri, 20 Jun 2025 11:19:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 20 Jun 2025 11:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750432798; x=1750519198; bh=lBvqGiop+B
	43/lk4Ag+OmtO+/yEtblAkjLDWFpFFZU4=; b=O4Ugy9ahC84Z6tDVZfgDSxRCz5
	UkddYxaL8f5i9u8C7ntuKB/qW0m60TFrHJkbLieWktg3w8hYrpT6EBuzitMoKkZ3
	NB1EY+qXlZWGKo3f1Y1yNcRIhWezQDssWRdQMFTvFUCbYe5k8CKn9eAvCt2cyQ5e
	g3ZHC2OrRkY/Sy4TUBgEZX4gdRyWn01PQPDXY24j6PaUj3nvBG2xW/Au8U2MzxLx
	Qx61jX+lUx8KNw42ILWOc7zLg79NdqEBMinSPLrXVpxs6eOI9zT+xdN+OT0SRfAk
	g/PjLs4d+RXfd+l45p9pyRPl8LHOTomvYOjjQsEy6ZVR1T+RfCMcjs6jRA/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750432798; x=1750519198; bh=lBvqGiop+B43/lk4Ag+OmtO+/yEtblAkjLD
	WFpFFZU4=; b=Hn94a8ceT9hzdKLye4lPRv4vLHMvBLjb2P7f63oX1hUJ/WvJRN0
	k6f38tknVqCSyneXnxpr6nk3E2n5URerc8dHHGFHNEwcOoxrYjPC1PIvsZWnyfPG
	XizAzEbK5uKwjSrVQgv5aTMWHuaLwfjfTKAdHNDsI1ZpKOmJ1EI3ofTpT4R82aOO
	R6U+7NJIC/FhAE4VSkfHeMexMTaJ8COve1G+aR/fKL21jsOXHhLWjH9zABbUBRlU
	FovA2mT02BivgOldu6yZ/1JPGKFKMpB1K6DFD8F8TNuHT8ewGu9InMYSGXAwRrQ1
	2zy0XscbG3vfKOECHZx70D7u/W+SPBan92w==
X-ME-Sender: <xms:HnxVaP0kk4YoZzap40-kiQGaTS1jq9uJNQ0LSYe1bvGptNw1jlbTlw>
    <xme:HnxVaOEpFEelxentt318YEdZYR0EB0rLgctLsx4iO9g2EsKxafIjVy0-GJIb5trTp
    kgcEsspyn5xZgmvTw>
X-ME-Received: <xmr:HnxVaP5SAhINSmXZSOpv-ouqYR_Bd2jOmJCumjR-VHnpSLqu1K1aGfBRvmVTpIldLHBxAzNGpkm52K8_qynfpYT5TpCL-yAOJMMm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HnxVaE32mMzzRWbCyJACahD4SpNr6HqCKhuPhYF2dVTRxlZk8XYcVg>
    <xmx:HnxVaCHRqZsaMpjx9uU4lM9yZVTcfwdH9MaeMcUQtH0gkocRUQ0sxw>
    <xmx:HnxVaF9NhMK7WUDtHL1EANiIH1CU-mvFysutzj1cEvodkACPLQw-KQ>
    <xmx:HnxVaPncCdhk70k531viQcVlsW7PpwZSApgKiYxpJxPDqh5BZsdC7Q>
    <xmx:HnxVaHcSxaaA_nudJRgPI62yzNwK-vCW_b1ii8UMeP7SRJ3vua87BbxS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:19:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Collin Funk <collin.funk1@gmail.com>,  git@vger.kernel.org,  Karthik
 Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 19 Jun 2025 22:56:06 +0000")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
	<87msa3quzs.fsf@gmail.com>
	<aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net>
Date: Fri, 20 Jun 2025 08:19:56 -0700
Message-ID: <xmqqbjqi5tk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I still think that if we're going to have this functionality and expect
> it to be used, we need to make it the default, build appropriate
> tooling, and check it in CI.  If it's not fire-and-forget, people won't
> use it.

There probably needs some balancing act, as I already pointed out,
what clang-format gives often do not make sense, and the point is
that they are not about styles (where we can safely say "no style is
liked by everybody") but about how readable the result is (which
sometimes is subjective but more often it is not).  Until the tool
and its configuration is polished enough, blindly applying the
result with fire-and-forget mentality will degrade the quality of
our codebase.
