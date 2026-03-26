Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA63FBEC3
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535269; cv=none; b=S8jJ+uEI1jaEKMGrb69i164M5Y3LTFsYdZlQy7DGrWpQp2KVOyqhLvDxvFjsGsEu4Nr+ADXI+oqcLJM1/OSkey4A92lfp71pYE+yJgwvh+47Ip+RktUuV0190PsUpGJIy+9PzezBRNjS96cQGVBAQlOrUhuIGh1/M/MrCvHhkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535269; c=relaxed/simple;
	bh=sbguhnR0oTokO9xgyDVuqRN5YsSkLOyknnwjk5nu2Rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VX1l/MCNapud3nJ1msh81+H1PsszSSFgc9C5faUcyBAlT+OloCld3cRy/NXHp3ZzRUyPkR6S8O41bdJIYOL3nfHCREsB5LpLIhUKfHmgNhdqfLgATOTfIbWcOpsLer2Ke6HkzKsTRPASCLvk0LhqvNxocJ9C48vnya7n0jlqG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=irXW3Mv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWER/Vi5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="irXW3Mv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWER/Vi5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 898567A02A8;
	Thu, 26 Mar 2026 10:27:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 10:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774535266; x=1774621666; bh=avSmG75lJR
	GSZI5NjY3jRovJv5NzV9zTaTEMcaRNQp0=; b=irXW3Mv55UjkObxI4E5jBqlnjj
	urH1v6XzrRc3zDwEjTSVd3EeQs1TEbkzgcbArhcR7Wcb5k6UEF4BgbjHzib+M+Av
	d50PoLgNJUEkbjTu1eA7nRBZk0dyIOY3s3SqGaD/zCnQSWBsm+r6hGgAks/PzTzJ
	evcLdn+acOeGGtYgpZF51RIwPtpd1VFKkUzyBys9stAnXg4TeK4ab/Uk/yetEAkN
	YNaoFEN3gdAM7QGgtkZvk0e1FTyOYKj9odLBYen7PAAKqVAU0tHqXJTSZyKeH304
	HYRZGBsWf8uwYfevoDqCsiD1Gb1Mh1J6z5XK6JSFA/HZeeF1NhblAFDmZO/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774535266; x=1774621666; bh=avSmG75lJRGSZI5NjY3jRovJv5NzV9zTaTE
	McaRNQp0=; b=MWER/Vi5d3g4Qb6fECv8T6Eudrq6qL0Y8764DwErQb9u5CuDwH9
	uUgA0jl6KOrmuxur/PdMuxsK8vk1upHU4el4VyjA5tS2xNMelow10WE2jlrzz4Kc
	N0YDTnr1MGtjIAmGBkXv3pLKt37Zahj8bcFwtBs/ksK/uYxT0LQh2+dwFRGjcy0w
	+iHxDfy5066eHcN2Y0ePj+AW60qQ0WkhgJXJ1VF2jTXoJmi1oPi6nBlClvHCwCAV
	6wbn4k0kq61qhFvRZhVwz6iyp0DwxqXGoVrjPsFQEggq6RvKLM9t9UA3ewRI/ue7
	//S3bs7PY84NKP0ZNGTuvP/NVeK+CwWghdA==
X-ME-Sender: <xms:YkLFafaD1zYC8UC4sNbl6iAuzN4wcPmaEIdGXu9yQ7kRLGQFv7qtdg>
    <xme:YkLFaV0r7KY0i8dE0ctMWalutpL0xp-1Fnrhlf3AUTo6b2yjTnS9bfDzWS4H-SrS9
    SCMJbu4DklB3H4Wjj8kEBmZ6s7EUkL2EdE4d5XTtU2ppcq69irMtg>
X-ME-Received: <xmr:YkLFafUMvhVQQ6LvMmdY8Td5_BxglTzE1rgaWgc5vEJxLsj5GelEvGi6tnyKIeAXMB3yHOcGnZMQ-RV7WufyHDWoGJfP5HKeLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YkLFafUlNlK2QL7VA5j_wu65u4WotJz5j56zIxWHupM2kMvdCKsutw>
    <xmx:YkLFaefCZYW7pswt6Jo0uA9-moXp-3dUO0x5nnkR2KeRpsJoO8TygQ>
    <xmx:YkLFaYUH9UJucCCIM4c5TSock-Awglrg8xokUM1UuEcIu1kKSo9DKw>
    <xmx:YkLFaXe7hFnYpKOECwyLo4vlCb3W4yh-JU_F7ZTW5lsQ7K_n_FqxVQ>
    <xmx:YkLFacnctU-1Fda3aIaO0mQvN_Kqg05BkX-qzdtmx0rRQTzbLGpNfNr4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 10:27:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
In-Reply-To: <20260326040828.GA686242@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Mar 2026 00:08:28 -0400")
References: <20260325062114.2067946-1-gitster@pobox.com>
	<20260325062114.2067946-2-gitster@pobox.com>
	<20260326040828.GA686242@coredump.intra.peff.net>
Date: Thu, 26 Mar 2026 07:27:44 -0700
Message-ID: <xmqq8qbesm1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
> index afba0fc3fc..0bf1f16750 100755
> --- a/t/t0005-signals.sh
> +++ b/t/t0005-signals.sh
> @@ -42,7 +42,7 @@ test_expect_success 'create blob' '
>  '
>  
>  test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT"
>  '
>  
>
> That neglects to echo $? when large_git surprisingly succeeds, but that
> would mean $OUT is empty, which would cause the test to (correctly)
> fail. I kind of hate it, though.

Would

	OUT=$( ((large_git && echo 0 || echo $? 1>&3) | :) 3>&1 )

do a bit better?

We can keep fixing things one by one as we find these little
glitches and gochas, of it may be a whack-a-mole exercise that
eventually will turn out to be futile.  I dunno.

In any case, the "Add 'set -e' to test-lib.sh to affect everybody"
step has to come at the very end of the series to keep tests pass at
each step, I guess.  I wonder how much better Patrick's version
does...

