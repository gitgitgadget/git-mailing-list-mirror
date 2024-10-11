Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB29198E7A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671756; cv=none; b=oC7WmFLLpJmkp5HN4B87QmL4pgA6zxvle90+jtbalf3/KmJ3/d2lB3nMOrZBKA8NgJo53dK0c0xGRCk87Ee5Wiu8JDxnnV9yKRkQwoIPSfvchS5w85bokTZ6msDDaVLGzZiwoWTQAPXHza6Akw9MXJJCLIdvUp0m35+EFI0Q9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671756; c=relaxed/simple;
	bh=qGwgBcDvvNpkfTPvk5g4Elyt0kVOSs5wFtyt5VIWvns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTv9ewCprN1e0lG9O9aWQ9a8sQohvf9qUW0raAX5kMzz8D6FmeJNzeEd1slmnV2kTxDQSta4SS/efEJy5FAkRo/KcDWwezhRCCX7fv8FsmBe1a2qFTAGOXXMmRqY/y7g2A41fewBb7OX2gWArM9yH/AnDA15K4J8Qt8vtjQ+WkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hWy49G5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STuSHoQ4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hWy49G5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STuSHoQ4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD297114014E;
	Fri, 11 Oct 2024 14:35:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 14:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728671753; x=1728758153; bh=hd7R8ysBMv
	4siZP5EhDymsnF8RlwG2pvnv4JPbuUYqQ=; b=hWy49G5v3iRY4U3HadM6Z+uazU
	W1suZTgPZQMwgf9Ax2T7bttxYy9hdP6c6u6rSR/336fp8wIr9bnPR0MlADHnS7GY
	ehoZ1gy7tZx0tLpzkJwxcrDqeiAoGYWyOYTjQQJu2eMbc+cN4cssVicFn2y4DG9p
	FDyIdd/beRoX8MGPym1/E92IjhbjKBJCiG1MQzV+Xyw23qKBR2yDSjMP7XLCev6S
	+HOtqUOGKc+v4jju0sl6eNjrtP5/wius0+hlSiNKp28iOP6BvGeNRQn+dnmquDD/
	URDupG+QR5D14aebmJ0Ibx3nSB564f5h0LsQrtzMZ9tkiIOeIU1j52whimWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728671753; x=1728758153; bh=hd7R8ysBMv4siZP5EhDymsnF8Rlw
	G2pvnv4JPbuUYqQ=; b=STuSHoQ4lEClVtrozp+JjyiWpnsghJitmZDDRtekHmjx
	c3iLlsfhm6tBXHnT/m/3xNW7MjAPuDmlxM0YbouFf2oIKtXBPQZDEbUWoW85ml1O
	oCqSHH3RLi1LrIUCgxqAtxc3b+HWwQUR9ZeinsuXKJtftouuYQpPvKGpuO2/G7F5
	V6yXMSGbdxGm3aH/iO79/P/S+NVPPdkifU2NvjMPf0Ge2S4UY7RF+XVQtuHJ3xnp
	8kmXBN4NddcUjIiM05HxHW0ugm1YtCCRzJo2bMtXBmtxvpxmSAiq4eyAv/u6hBK6
	3TYeHpK5R63W3pICm8lV31ZBXR9F6h/g7FB0JoY21w==
X-ME-Sender: <xms:CXAJZ5sR6q2KMYDXsaXd0c6xXiMW9_z98rdEAMZf3GoH4xrJ0l8Wjw>
    <xme:CXAJZyfdVEVU5H3O0dmmf6okWwBpF2tbeoZFz8I5D3RkuK3BrcumLjelRXwHyRLfz
    7zs7fMYANxNchlHFw>
X-ME-Received: <xmr:CXAJZ8yLJ23xp4NE_6CzkmdEyhxpnuiP4pM6Fa_wqIY17Y6S91eJeiZ93Su_UgWbLOiTXSebPhcduq4bHmoT6HNZvWL2A9T0G3jnxdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghsvgguvghnohesmhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:CXAJZwM6Yw4mz15fp4vis3mQsmdlBbUccLnsOZzBaT-UVcIzJ2EBcQ>
    <xmx:CXAJZ58pZpdZ1uW-vEMP2d-KSRrXbn4A9N671xJaivINGYIkkSyAIQ>
    <xmx:CXAJZwUvXwEnGEsyNy2dzbZibXAkchKIesyRNNFHLpB4kPHwAnigUQ>
    <xmx:CXAJZ6cU_zqe3ygNxE3yFK4d8mthQjyYOUnQYDLtvJSwIjngKWop5Q>
    <xmx:CXAJZ5wTO8K7shNktB_SxVWD5gsDMApsJK92QpbkenAZetZeXnnULNLt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 14:35:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Alejandro R.
 =?utf-8?Q?Sede=C3=B1o?=
 <asedeno@mit.edu>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
In-Reply-To: <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Oct 2024 14:09:14 -0400")
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
	<20241011074022.GC18010@coredump.intra.peff.net>
	<CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
Date: Fri, 11 Oct 2024 11:35:51 -0700
Message-ID: <xmqqttdicws8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> I may be in the minority here, but I'm fairly negative on this entire
> patch series. As you say, supporting these old versions is effectively
> zero-cost, so how does this project benefit from these changes which
> potentially "break" Git for users on older platforms? I see no upside
> here. The cover letter provides no strong justification for
> (potentially) inconveniencing people; the argument about being able to
> utilize more modern Perl features is weak[1] at best and is not
> convincing.

While I agree with all you said above, one thing I find missing is
that even with #ifdef, we won't be shipping what we tested in real,
as nobody, not just the author that touches the same file with the
#ifdef we added 6 months ago is in, but all other developers who
looked at the change.  It merely is "we have #ifdef here and those
with ancient version of the library shouldn't see this new code",
which certainly is good enough for those of us who consider the
ancient platform support as a "best effort" thing.

But that does not, in my dictionary, quite qualify for the verb
"support".  A variable declared only inside #ifdef may be used
outside it, or a variable declared without initialization outside
that is only assigned inside #ifdef may be used after matching
#endif, which would not be noticed by anybody because nobody among
us would be running such an ancient version without the feature
#ifdef guards.

So I dunno.

Having said all that, I did find it was surprising that we raised to
a merely 6-year old cutoff point.  If it were discarding versions of
libraries that are older than 12 years (instead of 6 years), would
you be having the same reaction?

Thanks.


