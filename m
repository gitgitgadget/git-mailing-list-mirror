Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9791E7C2E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059995; cv=none; b=Vhf6BnBRQVM1zMkvKNEQYBDsf628c6fzU72Zavg0rR//3ZL1DgkbOnl2qNM0IuEWURTLsMuymlep6X6Ks8vk9rFIGLjqyokek3UAtDZdXrTDu25mK0QB6v1JN2DGC54Ngmt4n6/XH2MPenWzIPNNFGthEBAxQESo+nOYYunQ+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059995; c=relaxed/simple;
	bh=9lTGzwbqKtW/6itDqcCQRz1FDYnpBoKzJ0BWcJKLN8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+oBS42/I9HHR2AGw5ksQCbW6gJdraEHbwTnBimL/oC/pGbKd0vCjYzraw9Ng/ge1Y7bnavBRdqNo5wyHA7nWXh/Loifd8W3ivZLJiJ5nU3bNwf1sAX5R5zLVlt4IsLnIbajmIY5uj07OZdRCLPO3lEYIArt11q+FQYXBYuEB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mYFILPH9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRMMZGCD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYFILPH9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRMMZGCD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 19D8FEC0230;
	Tue, 16 Sep 2025 17:59:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 17:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758059992;
	 x=1758146392; bh=PJXrk8ssQswHBTv8eO8OmekY/0aj2Woxt2TZb0/r8B0=; b=
	mYFILPH9/0iAASZz3BGOsrlhsaVcZSIFH1z3sw1c4CCPZTiyUiei84AaV5cfS5dX
	m4oHrMSaL+FsXakMfqbDjtMzv9IQ8+Zii4SCW9g08EuTsJIbBcCmLYIf/yNb6tkc
	Dvf4/8bFmnDihoc6N+3cUtKE4saAT55kN7E5qJuetaSvmd3PDPrCV8SQUwcTSAlf
	wMaTIaeShe+rKkiMAdIciCra6XE9Kis4Jsc0N3yj4xmXtohiJKhfEvfO6HEGBBSM
	vpyccuy5GGRE01eMsootqHEjO8PgAbtN0BS7r9svXYnYGoJ4yPf9iQA5IDik3Zb2
	hKlXn9PpvAzJE2Y1F0lBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758059992; x=
	1758146392; bh=PJXrk8ssQswHBTv8eO8OmekY/0aj2Woxt2TZb0/r8B0=; b=D
	RMMZGCDVZN+3ELfG6l2E/ja9hx8DNH5DS5bnaoUmcqjNaKs0k+9GJxH/koKdphWm
	UTxvBHNm3ZG3vCrhFuSocC/vEINUy10fu0tlBGPkZS/HJkgMvp34xX3tiJceJObi
	xoEfDLfmM0Ma3ESDfsm5P4wTA7x52+FEAdKvISYJ+VfaaFyMT5VGH1mpeZQSnghU
	+kqJsg5tOaoUpL2j/pAt5ZL5eOvEoLmk6b25ArJmRpTwgzlIX9pAmYrQEBI6oqdb
	THhsWHJwnHp7nD0cKX+EkJVA2nExA2mKiGnCjABO60C6FT6RQd+AIgCdqFT2ZPeG
	RZd254zOrtKxYN7uG6/qA==
X-ME-Sender: <xms:193JaFdJ0UaMDXFKr38EjVQwDfF09UwhZt3SrzWydrC8jFNGYZaO6Q>
    <xme:193JaLq-94WtOdQSwyN1_5V8Zscm5Bdi899FOvhS0_BVSJfRPBq66Qd6VQGX-Il9I
    ifkDSlkYjp1GuAfxg>
X-ME-Received: <xmr:193JaO_APKP-dlid8kFSWwjSBO7paY_xQ33g3rHETfBeelrSyOjwtYvDGmNssbcjvC1So_KaKVwgyAdNDPXyhCzcqr7K8hM61ugilWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:193JaPeu_poDPAaLgJUYc89fwQpY3Y_tkl9VBtubT3_b4DCvZ1KXGA>
    <xmx:193JaAKIhtwX5onj5h3k2DTQSXcDQBXIQ1-akYaU0yzvtOnGk7O3YA>
    <xmx:193JaHgrWu_IROcExkNmTY02H64CGZhsv960SYu87xAzof82NF6cJA>
    <xmx:193JaGRW4A2QzJ5zKAcYjHey5hT_yVeBp4ewYseLxWAdvsLh6DBVSg>
    <xmx:2N3JaLDSOte8w4J4wmRWs1xW_KjQSJc2n1UKmXgzzTLwpw1jqR_Zoaz_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:59:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
In-Reply-To: <884CC5BE-5272-4422-B43F-4C0743ED7EFD@gmail.com> (Ben Knoble's
	message of "Tue, 16 Sep 2025 16:38:50 -0400")
References: <3f9f511f-7f9c-4179-85e1-87d76b748db3@app.fastmail.com>
	<884CC5BE-5272-4422-B43F-4C0743ED7EFD@gmail.com>
Date: Tue, 16 Sep 2025 14:59:50 -0700
Message-ID: <xmqq8qiem52h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 16 sept. 2025 à 14:46, Julia Evans <julia@jvns.ca> a écrit :
>> 
>> I think "..., and sends all necessary commits or other objects that aren't
>> already on the remote." might work if we want to add more detail, since it
>> gives users a hint that maybe they can ignore the  "or other objects"  part if
>> they're not sure what an "object" is.
>
> Nit, without wading into the above discussion: shouldn’t that be « and other objects »?

You could push a tag that points at a blob, so it is possible that
the push transfers only "other objects", but "necessary commits and
other objects" would naturally cover the case where the number of
necessary commits is zero ;-), so I tend to agree that *and* would
read better in that sentence.

But if we really want to do the progressive disclosure, I am OK with
the idea that hiding the details behind a vague words like "transfer
data necessary for updated branches" without saying what these data
are would work OK.

Thanks.
