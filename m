Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618392040B6
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588968; cv=none; b=V4h1Emw1BbQN0bZ7p6/OUayaFWov2V4MmBwEsOepVJIVrUwfLVeyBSIN3sDL6IDHW/BP4n06vNjx1pbB8Z5N7lzkyvvfiM7aU+9v2qtCdTrZ8RZCto2WBR+AUfZlpCg+Wi2tj6YzwuNzWMITgQ2MQkUFV/d7eFDdwaPg4ACgKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588968; c=relaxed/simple;
	bh=NaEqjQloZQpdVnwsGgqinSRIlSJcWZ6frMFB9kFZB/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYAnjTE9hU8TkSIC9GJZmZdaoOdXcv+ztbahJtwOHNeBsLmRuVEt2lDrAYFeVSOegxBLreu8Or6zXUgwIXmCzuR/+/kEYGYzthm3IOZ6r2zoqdy4+1CRDf4biyg4yZz3tacA1ran5y7vKBOVZhE5ho4zH53xMUnxqRg7iXHWc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rOhEfTib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=we0mUvNs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rOhEfTib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="we0mUvNs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 870471400086;
	Fri, 16 Jan 2026 13:42:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 16 Jan 2026 13:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768588966; x=1768675366; bh=EgrNcT57it
	uOyJ5rG+9AEbWxUInNd7ITo7xzLFHT6RE=; b=rOhEfTibYML09z8Y2akuWcEh+L
	QPoXebkO45mgY3lSQElIvSrgj5cU9vZfWrU0exMJ+E/IyQq7rtTIwKpMAspQLm0w
	rvchbLy9t8jANIFzhUeTc3tDe6To6SijcVvpeXUdRnvkeleNvREbBmimaZbYdWEp
	EM0mcTgTFAztrnGG8OqtYpQUqJAyPynTDMb1ZreVGZe4HuMnNEMvh5HKw5wxmnfA
	hxNlKGq/XYxKvIZp2AW4icCJo+JTpJoVgAme8MwgBt3PIFUpe9pOuZCfFF+EDj93
	cEiKjgCP0wwVyuJ2MF62vGNycDwNx9cPKZohln0HKzpup2VBkhQJ0YQMaU4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768588966; x=1768675366; bh=EgrNcT57ituOyJ5rG+9AEbWxUInNd7ITo7x
	zLFHT6RE=; b=we0mUvNs8TqHkRv2Z+5ezkFuG2MaXkgpfJw0PitYG3pO3jsf2r5
	epvxfGTa+QBeaSKIvr2UOjhC5Gk0tGZPIYmZ00EZpyixrky+mwvs0A3VRcqz2ERP
	rfnerxzvwYbmZeyN/A7ed+DJKud6p1oT7dfi+SMyq13mjX28sWDGdNLhuiq/6BUF
	xpg0s14hnPQeb2O7Qb1+PaAdT7zFJxeUwPihgoKO9wketBXv3IpenU+YKUPuug5+
	z4ZE3eJjTlG8M7H2Q7FX+jI4yVSwS+86wnpKCc6XrlnEEifvsD+MJqhNfGbCuCDu
	kxe6/5YIVfIECxVB/g5fBDOpPdXd2PkVjLQ==
X-ME-Sender: <xms:poZqaVz53eoMXdRM05qJmWlMFq3fmP9Mo_VDs2YAY39Wgl9DdUqaTw>
    <xme:poZqacK6iDJ4cgfe5hSPFWdlbQDYTucq9089GFQsQ7JzV_uGc0oMwzs6XSS9Wx82C
    i153wOVOxpdhEOMNyeaVAiSKzNGX3hj7o8QuY5k7bBwMjEu7PpM5xw>
X-ME-Received: <xmr:poZqaXpj7GXiHaL450GAnR_NWhqTns9dj_cQ25QNQNNW1Vq7nm1oqmeFR0ZaZfYm4l6zKJtz4XRi9t0OWZc4oKFoycMQXPWlyZIfFpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehguh
    hsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:poZqaTIhH82izalLlDmvjR8iROeGWAPJ1UjIjWiVUPGAzl-MKd8r7w>
    <xmx:poZqaUTLQXn9b9R1XFljC2dRPld3AYliFhyeGNPBPRDF0Req-lUnRA>
    <xmx:poZqaav9ThyT2wlPxb0cgLwBV-BugQSv59OUsQNDZMYZihGdFlrJuA>
    <xmx:poZqadbrZn8pM9c7f2zTpG4PvskpARs_ETWFKkAL4WEbz4PnQtR1-Q>
    <xmx:poZqaTmhnRTgS4p8Cc9DOr09jBIDT_2PC7zUMFdv7ko3drLy3gYEXZZm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:42:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 4/5] last-modified: add option '--max-depth' to help
 output
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-4-79e44f2806fe@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:22:52 +0100")
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
	<20260116-toon-last-modified-zzzz-v2-4-79e44f2806fe@iotcl.com>
Date: Fri, 16 Jan 2026 10:42:44 -0800
Message-ID: <xmqq8qdx8km3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> In previous commit option '--max-depth' was added to the documentation.
> To have it also appear in the help output of `git last-modified -h`,
> move the handling of '--max-depth' to parse_options() in
> builtin/last-modified.c itself.
>
> It enables us to change default behavior in a subsequent commit.

This split of the max-depth into two steps does not look right to
me.  If we are handling the option ourselves here, shouldn't we do
so in the same step, so that "git cmd -h" and the synopsis section
of the documentation match?
