Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581A800
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811103; cv=none; b=GcmO0FzrhjlTPGXs6x8btgFhCu7y0ElRYoSyBRUrE+KXhXvfwM/Toxug+91YiYSqEuofl7wcuuKzmiW2oYIVfBgWL1yT+pete6LuUtuU7xZ0xuzizkFn91vlPk7VT8ksp7NvD3/brEKExd2i9NeT6n+BCcvIRFUJ0vQFqbUPKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811103; c=relaxed/simple;
	bh=7DpLD0IO2ZFSYg/hS1Es0yDlYb8cWaD8SgdPceBHvDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=atOLVJGG8k0tIJz7Z9+N6DBYev5Pio11sHFme2eIN6ilaFlDj19ajb13HKL+UcloYxoobuMMJJBr9VKZEVhej6ZFNZz18sy8ggimBl+yXcVEcStMtfT0kGTXDxVgOvKRARkPVJD8vNqefE8Y2OTbLuy2oO81sKjRhBAW1/zjYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ne5q1n8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAfNyKxF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ne5q1n8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAfNyKxF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 462DA7A01DA;
	Tue, 24 Jun 2025 20:24:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 20:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750811099; x=1750897499; bh=WPqeKRw0RD
	dGdAqnFeGEG1lSJUUjD2impOzorS5ISBg=; b=ne5q1n8SXaFelBVaiMNfPDlyG1
	ey+Oq0hT2gJyThv3ExeQQG1YSgnKm4i0PJLikeWDBkkbLKtZ1zq8WBWCTg0uhsAa
	ycTNakxc7prKXFnzDvgoihvNTJ/1Rlz8Wzgc44hL+2YNz7kH6GWaxYykIjhUEwH8
	YgjcYfIhOWKYwGrpIZe6Ms6xik9t5D81FkhtUcredJ+brnSCVR9jwJCTbEHkNNyn
	xZTJmYzpOkAXsO2j/LEaPpITsA53xzrQ+vjhmzBC6Qw8aJ0OkkEHAZtX4aF7C5sa
	oyGRAb4CWohK2kiKnZlVtPswwq5qkBFwiMmzdSni8phGEyQnoXATOlK0ZKRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750811099; x=1750897499; bh=WPqeKRw0RDdGdAqnFeGEG1lSJUUjD2impOz
	orS5ISBg=; b=dAfNyKxFefdHZ0jnRXdg6miizs73H73crlis+7tbDgRrzP7dlAY
	2gKO6rKQ07YRGVGXDA/s7vYzpNbFYqUXDoiQhLKTXnQQrQOyHTY6BH9PLeJzSt1r
	uYzIktqBB+vPuR+BUGCak2fXT7CO5oAk0Dv6uHuMJwAMRcqNoGdSdi85Gd6hy2Fu
	i/+JCWbQPNeUkUaHvFyNuRG1m0hKISZHt4UXsmrLhW6GG615fwaGBxj3qEA0LSq5
	2O+j28RnaMFKIKe1a28OUhrMmAesrS1g/hk68mjAL2FlpYGNKcL7N2TRwmd1Sjh4
	hafrjlDhm0kMXJaxkP1tBugVujGso28HkuQ==
X-ME-Sender: <xms:2kFbaCIuhGmBmvYZ91cYNNqMsX3YrDj-gfLNdPUOsLXNEsXgk1Lf1w>
    <xme:2kFbaKJMCPoPn-b8OUCzf0ptCI-wfTLYjHxcCCol737xZSjgHYIbfxAiP_pRHy0IE
    BAjoW9hVgojyz2UXA>
X-ME-Received: <xmr:2kFbaCuFGgMByoLYPXxiDSMC03brDlJFFTU5LVEq0N2mDnrmIEBiGxYqPatGwK7NK2fsqlEe2Dm9Heq39iLb6jtC6KKYOraPMkz0i9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghh
    figrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:2kFbaHbBdnhB5EnyrCxcQgvDH9k09w-2RIVv9nNn6zvY9bSs7Iiq4w>
    <xmx:2kFbaJYnbOWk9iDhzdpxK2qksHaIOWbS37rtjaZsMIj2Fb-sqq04iw>
    <xmx:2kFbaDA7zO1XoBGi0Qvryd0gR-Pld-SP_pVYcgUk9KF37-CM2d-02Q>
    <xmx:2kFbaPbk_19h_m_hc-efdIrXDUR-aZhphcv7zWqyOVOGK0oNECyxzg>
    <xmx:20FbaBlEii9G7Snd6F3be6vGsOgu24kwj3G4GFeIgBpYVjkOvqNNWOW6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 20:24:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org,  Andreas Schwab <schwab@linux-m68k.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <87ikkkk84f.fsf@terra.mail-host-address-is-not-set> (Maxim
	Cournoyer's message of "Wed, 25 Jun 2025 08:55:12 +0900")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250624014857.3748-1-maxim@guixotic.coop>
	<xmqqecv915y7.fsf@gitster.g>
	<87ikkkk84f.fsf@terra.mail-host-address-is-not-set>
Date: Tue, 24 Jun 2025 17:24:56 -0700
Message-ID: <xmqqikkkzmzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> Hi,
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
>> v2 and this iteration both have all messages set as replies to a
>> single message in the old thread.
>>
>> Please make sure in your future submissions:
>>
>>  - [0/n] is a reply to [0/m] of the previous iteration.
>>
>>  - [1/n], [2/n], ... and [n/n] are all replies to [0/n] of the same
>>    iteration.
>
> OK. This means I need to submit with 'git send-email' in two steps,
> right?

I do not think so.  Find description of the "--in-reply-to" option
in the documentation, and read about interactions with "--thread"
and "--no-chain-reply-to" there?

    So for example when `--thread` and `--no-chain-reply-to` are specified, the
    second and subsequent patches will be replies to the first one like in the
    illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:

      [PATCH 0/2] Here is what I did...
        [PATCH 1/2] Clean up and tests
        [PATCH 2/2] Implementation
        [PATCH v2 0/3] Here is a reroll
          [PATCH v2 1/3] Clean up
          [PATCH v2 2/3] New tests
          [PATCH v2 3/3] Implementation

