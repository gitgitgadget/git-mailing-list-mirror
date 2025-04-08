Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A018BC36
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151436; cv=none; b=K6nWhKM0vL5RTtPJzaxiPhWJY7y84AHAkrSg3rCNRCKYxZQLPjE6SB//3W59gmb8h+Is5ECz0d1OrUW2HLyg2W0P+NhQJUYtPRxivNfOgMZ7G3lQ1d8U+p3msDdXVZTLSKkMYqGI+uvT0fCMG9Eq+4APTvkWEKDZx91mKKBEExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151436; c=relaxed/simple;
	bh=kfFYQT0EOZ60XQjY4iacbK2p4j6qesZoND1q7oLf3NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSdFs46NspPSIO7NcxuRuuunvcrzpXj2vfbDpbIr7anLfx/fq40Ut8aCK5a8hzKwbIMSnEBlGlmOG8wR3QPYhJqCzys0jSWBC/Nb1UES1CFLfxrEhCLDFJu/QTPG7fgMQzMt6N4ZoqdakPTu1Hr4dIcTYGP6KlHDti45FpgwrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UUm3J4mv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8SG0Ixv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUm3J4mv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8SG0Ixv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C703114016F;
	Tue,  8 Apr 2025 18:30:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 18:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744151432; x=1744237832; bh=aTk1rR1cDZ
	WsTO+15MdzJ7csIEe2+DwNBiclDGb3LA0=; b=UUm3J4mvZxXaMEGxxr7v8AW/C8
	RM1w/jhhQxW5o2doYo/+yoxpxJom9XmWmwrxmZFWUs1fMj3hcUClw7ksXfd//dkr
	i03DDEHRw+vjaH8k+Yv9KkAdQryyxARuVbWwyUX0BbJYHQD1VKSPdo68VfhTjpDu
	LzyBQJmjoH4qrqDXg3nlZZ+SElFlNsOFS3NyQ6olXIzDp+JOZz/7UxPdhAEt9+W6
	UlKk96LPF6dDUPnh3/LYCMBko/p1uY7GLu+98XjhM5Ozxr3mlVm1h4djaOaUnnZX
	klCsfwT6/gX6gg1SFTnKTV6zqd19c5TcGwCER8vUOs3Um1GSxlV6GQDC71VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744151432; x=1744237832; bh=aTk1rR1cDZWsTO+15MdzJ7csIEe2+DwNBic
	lDGb3LA0=; b=a8SG0IxvPAHchRYLN8kGYo4klrC7jdjgelLG9F+cSd5NYgtgpN6
	pd+7qWIACsSZzLhycmEtxBX1dM0HrxNG+IPbN5hlgDJmSHhaFM+xi09aGdmZETCy
	smN5U5Bt3pJcpazz4yVhfUIa17VoBs3mJzaphbeln6TUew/J9R7jGk/4zAr0R5IX
	8tdM0hxbcM+7be+tgudArhc0pQ2y1fXm8JlWkNEXtktiLFG8Er1BZ9kHXGWdtByO
	d/feJlF4xqB2YUVD5k3TiTTXhyKhvtOWIH67Ji9ZsKZqHR61VptfI99kIQ9sojdu
	cM73e1x4kPF91Yq4gyANJTa/2VQ57LIoeWA==
X-ME-Sender: <xms:iKP1Z1ZP9CD0mnOm-5X7zNX3mOSOl6JcYmU145e9ABX0RqD9gI8YdA>
    <xme:iKP1Z8Yni4bU5_LhgqXIKSSlZcAFFCa93htO--id3LmmVV6GdFdu1O0nbJA9atn76
    f-WB1mphos3FuS8DA>
X-ME-Received: <xmr:iKP1Z38r5KT5VZlfdyxj26AVXOCWXCGGzPMScA8mYSVQzCZUFPmKFOQNKqLjZXMERF73cNBciDasobLrIQhYhIW3RQJO8nFYR_-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheplefgkeffueeulefffffhueeguedvleeg
    hfehjeelleekheeghfdtkefgjefggeffnecuffhomhgrihhnpegriihurhgvrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:iKP1ZzoLMrS8pVN9BBXVBYl_umQGE4rki55QuBoiuHRPUfGbtMONsg>
    <xmx:iKP1ZwqoIJGDQ_RYKgCTftututXQf_8dx5xeJP465OTLSHdQuP-HvQ>
    <xmx:iKP1Z5Qk_ze7zqA1TtRH08MolZpIuxEFKuRWi1Yd1amHKia0_H2llQ>
    <xmx:iKP1Z4ocjZXpmzdF8qL2qjTpZtynNen864VvNeW8F-rFpt5zb0Aqww>
    <xmx:iKP1Zw7avKbydpS57pN58hZqXrotxVZQTPZUkUAUYtDG7OQuWBIVtXi9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 18:30:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] GitHub deprecates Ubuntu 20.04 Actions runner image
In-Reply-To: <Z_WagT6zeeQGNa0k@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 8 Apr 2025 21:52:01 +0000")
References: <xmqqo6x6wgs8.fsf@gitster.g>
	<Z_WagT6zeeQGNa0k@tapette.crustytoothpaste.net>
Date: Tue, 08 Apr 2025 15:30:30 -0700
Message-ID: <xmqqcydmuvzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>      It appears that Dscho (CC'ed) is futzing with the generation of
>>      sparse package on Ubuntu 20.04 and 22.04 and getting affected
>>      by the same 20.04 brownout
>> 
>>      https://dev.azure.com/git/git/_build/results?buildId=2396&view=results
>> 
>>      so probably I do not have to worry about it and let Dscho take
>>      care of the whole thing?
> ...
>> @@ -457,9 +457,9 @@ jobs:
>>        with:
>>          repository: git/git
>>          definitionId: 10
>> -        artifact: sparse-20.04
>> +        artifact: sparse-22.04
>>      - name: Install the current `sparse` package
>> -      run: sudo dpkg -i sparse-20.04/sparse_*.deb
>> +      run: sudo dpkg -i sparse-22.04/sparse_*.deb
>
> I don't know how these are generated, but this seems like a good start
> to try and we can adjust it later on if there's more moving parts to
> fix.

I think mails crossed among three of us.

<77f82414-261c-d2bc-f911-ed3d4b06c86e@gmx.de>
