Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2A301156
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767772; cv=none; b=B6tX2xejekptMzLNNNDdZ0ucdzWT+deANKlP8ViUYMf9Tv8oZSVgYBNxE4yCQmKIVsKAWIqF7AnzKwjANMoO888nb92AvfO3N+pMEicfouL0NzbihMKpzQo7vya0OdR8QCI/FkzfSNtnIIGznW2HF3HNGsm8FAfHLPsrIkj7VJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767772; c=relaxed/simple;
	bh=7EvM8Ugj4ZhWt9iuz+ry0NR95vVi9y1vWQFsuZydXV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvG1qh98lkVIyiUcTn7bq28df7X6096HFUQ0D3ICki2TFOANaRq+QTjDO0irTbakcUQ4FBzMkhlJkey200UeOBmpg3BHFBY8tmTLnUCgZst4l+cgS6FveK3rjWVTFTIxNhDVBNfHEyoKzZbuUAJsV3yJQ+ygIW3VjfyNoeEXpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TQk86TnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jha7+QqL; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TQk86TnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jha7+QqL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 300F27A0042;
	Thu, 17 Jul 2025 11:56:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 11:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752767769; x=1752854169; bh=C1P6cjG7Um
	YuqtEeHmSv3ceAJgY2ctAka/7Ma1qaDOI=; b=TQk86TnZTS9LWptDqEJQCrmZ9O
	pLQAi+/OWLfUZH6Xv3HRI5JAhpRMYaYKTRaSaJKaLsPsj4BLy/3xhSt0cm7hrbRR
	iXvn+jpaouVc47XhdXe0kQDC6zHpMtBxwxEGf+oSV6bhghFu6CPyCjictOdN3Xna
	jIeA3UEY26MhrAulhcSCLX4OUPd/ab7VQE1ByUVkKFG+aSoDNELER/D0GJRNmf6K
	aBscw8wqw1DWpzT5ScosIgJpY3KTOSlB80cmPJgFnjOWf+IMs0N0vqieWw9u98Jy
	ru8++Klsa0oOya9zMgVAi/PTOcYZEblH2QRgUwu+8OZDC6pKZSaW6xpV32wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752767769; x=1752854169; bh=C1P6cjG7UmYuqtEeHmSv3ceAJgY2ctAka/7
	Ma1qaDOI=; b=jha7+QqLwNkaM1Xd20q3nq3RSI+3zSqgo2ZONFpr3KqG1nue4+f
	KL/E2c7vpm9olP2R5llplTucl9+nwVdjJXJvS5CyPZGpu1nidL4cCsQgKX9555F8
	+mF4mMsVQY9U6psNNhvWgpHTxWYeOi9xqCqh5cZ9h/Th+js6sYmsc2b7o575Ss5O
	/RtZ0BqtU4xSILKF1tMl9LuiA2MkBy+yvSXbUJZp/lZLZF7KOdWHBgVjSk5l8UEi
	+v5LnQIn/k79Sc87MJqAtOf4tYye2xc50iQUVupY19ZImluUS42TkXIPGMeJUaia
	VdzfysEtyjpB/fZaMesaJEPtOiLDPO/6x9A==
X-ME-Sender: <xms:GB15aHI3Iz66twHzJyqSdyY6XxqdQJEk6AhbaCnJH4o6pD__6PIIIg>
    <xme:GB15aL7WXHgAp5HTgxfBmDqQF9IE5AFDQEuPAMLynjhbK61yq22EMkKhQeBkpa7af
    OonHxUQbYStMoiIIg>
X-ME-Received: <xmr:GB15aL1BzvJdjZ6R93IwBfohU23ddg7BKJFE5h_DNdX1RL8qe4T6os9VBuoD6sO4gamPfZNGzNoa9p-VkwyV1UnHwYOPgd9dWH2mhMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GB15aBdCJj_spFQefUYm-PG-sOdwFYAnmF1Lor0EIWxYStVmKkFcig>
    <xmx:GB15aBfSrCBqN_89HJ5r8Dyal4u1HdOiYRg5gbIASdje50CLo0CiWA>
    <xmx:GB15aMz5zbipsdRy8lMoSo6OQJUUkdtzl7HJkfnRx8jo7pvwCtHj_A>
    <xmx:GB15aA8S4HzhnlphyOmArBHMRfXZm6Es9XIS3H_XooLB1XQSE9AL9A>
    <xmx:GR15aGGLq7TaO6yQCLYt5DoXGJb1vZ5ZwkqxvWBw7gWy9JifaCaafJrm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 11:56:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
In-Reply-To: <0026a11f-373f-40e8-aa29-9ada050904a4@gmail.com> (Phillip Wood's
	message of "Thu, 17 Jul 2025 16:19:31 +0100")
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
	<20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
	<32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
	<xmqqbjpq1rs0.fsf@gitster.g> <aHY7LYHqVj-ECf_z@pks.im>
	<f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
	<aHZ94u-xULDDBb7C@pks.im> <aHehaghOW16vPee7@pks.im>
	<0026a11f-373f-40e8-aa29-9ada050904a4@gmail.com>
Date: Thu, 17 Jul 2025 08:56:06 -0700
Message-ID: <xmqqecue7qw9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 16/07/2025 13:56, Patrick Steinhardt wrote:
>> On Tue, Jul 15, 2025 at 06:12:18PM +0200, Patrick Steinhardt wrote:
>>>
>>> Hm, yeah, I think adding it to `repo_config()` might be a viable
>>> approach. I'll give it a try tomorrow and see what breaks :)
>> The answer is "quite a lot". I'm now 15 patches deep to try and fix
>> this and am nowhere close to a working state yet. The single biggest
>> issue is `core.shared_repository`, which is used in a ton of places and
>> which causes all kinds of pain.
>
> That's a shame
>> I think I'll stop working on this for now, and would rather like to drop
>> the last three patches from this series so that we can move forward with
>> it.
>
> That sounds sensible
>
> Thanks
>
> Phillip

Yeah, thanks for taking a look.  I think shrinking the size of the
series is sensible.  It is easier to manage larger number of smaller
patch series than a single large series.

Thanks, both.
