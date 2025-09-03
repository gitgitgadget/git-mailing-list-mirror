Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531302356B9
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894516; cv=none; b=iIbCaF6RC6fHKmg3igShKiR3JLKr/QFybboHWgb/rwV/PrQNZU6g6W+lTQipv3w8M5rjISjm84OhvbgcvI0d+YdsmbjNYqC31egJ3A1Tc7e4ULLFW8mXpmtkF9v16B5OAF91a/rTp7dRg263xDGsMjJxox3mIPJSddTEilK4ZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894516; c=relaxed/simple;
	bh=bYwLxCMIjI2U1uQv5JefOzN7iEfCj012zGiBl3BwzZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMeJ3/612MYcClbJStiPzPTupsGQFQfBz/fGI0pT9hGsRLOk92EXWEoFm4SDEDl9n0IubIGIRaUgqK12NtfPvZpdk3z/JurghigZBZ/fxCZrdfLStBqORkH2XPzgUCnirVrV6Xhbc4V7lXGkheeHQIyLIe2Taj4fTjWSuOSc6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rvoBKucH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ki6L1a0h; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rvoBKucH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ki6L1a0h"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79E851400415;
	Wed,  3 Sep 2025 06:15:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 06:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894513; x=1756980913; bh=4gt/WSa28Q
	k62uldsiV7VwrReG1Gk2SLUru8lhhj/OQ=; b=rvoBKucH01LjjpK2KJc+zAIB2V
	EcfGPwgfJu9IDXU7uLXabvuW50JV3aSJh4rpJsXjq3mfe0UWb4y04/irJUkH0GTW
	rJhRLY/5f9K83pWtgD2WL5T3eZEi7VRSuxypRosZaMgS+z9jT01wcnUEFX+HHxjo
	i1P0Wp621dZLKpIgAOpeIgVc+LJ8xcj5io7OOqjhYPkyJI6fZ3lcHltpcwLe4nRH
	e6Lyq+Lf7KX3bfZ43h0zGrQpKNvMUc7wJKqt5Q6g92qU6coK0s/hzOoutZ57sgF0
	cJQSFCkLbaQ+rMJVlWrFJzWtzKGkVVkfFMOXQ0W0mLyqRvhgZFPphg+nuvZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894513; x=1756980913; bh=4gt/WSa28Qk62uldsiV7VwrReG1Gk2SLUru
	8lhhj/OQ=; b=Ki6L1a0hLgPXI/l9PFqapiYVoKZ7juYc4gR6Q2QwECSzOZKuNF9
	0oA57ONnVobSVFNv99WsSsTWRXxFfH17q5y+J7e3WPL2MfY7Um5dpck9t36AuzGN
	a8b+xk25T07BFIQL4zTQ79vZ1u2fpWcvZU8lCPs73KgM8/MrqpNt4ZKtjSd+Kkb4
	tDWE00UCnNhgQuNCBWQXc6TS6asYsmPAfZh9HAEy6qP2NaApfoaQVpSOJ+EAl3av
	hETJZx98GgqfvXWl3a0ygpfgLflSDDS8L4f23i0Q/lGt/aj6WS+5lnTOG6gpg9pm
	lQaWEyQCfQVaMvZXI7oT553qVUHgdBENyKw==
X-ME-Sender: <xms:MRW4aFN95qJO6apP_iq0oYzSAfJQE-Q67iDC2lHRpFLAsdq5u2KMCQ>
    <xme:MRW4aDeBUpYyg35_5bG7dzGDqnL9IYhLvZEZit0y6t5D3G5RUDgxVwISLuQZlPmaY
    r0mgRMFy591hgH2xw>
X-ME-Received: <xmr:MRW4aKuYjXdmKLyQpy4lQSl8dAgyItFoXs5d-Kp2CTfSzv7pbz2E0C9eihY5wgDBInkDYciVn-s3dzrir1Cunz0_Sg-_I4D59eILTYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    dttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MRW4aMlfLVstHfqPDrC5NWi_pySIA40xM3yu9KnSegTZWa7Fb_l1Wg>
    <xmx:MRW4aEy4qDVOxeDvRVlrpTEoWc__6RsQw6nKMNbSGXEEyhXCzoJdGQ>
    <xmx:MRW4aGMItJKpdpH7kdafR5Gkdlmm5Pezy2EXLj7RXZf57JL2RAV8Og>
    <xmx:MRW4aIrF5cLamOjrU5SEF4hh6mRJT1ndiyvUURfFE_dwThEW02UpyQ>
    <xmx:MRW4aOj5BlC1lpcUhfVfw9xIGBStjI34CmvFlIxhDM88DSncxBn5QaUe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1aef7c69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:11 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:15:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/6] midx-write: put failing response value back
Message-ID: <aLgVLMnbGiUAviXZ@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <a1dd3ed87437322e298bb192fbfe4a9641d1356e.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1dd3ed87437322e298bb192fbfe4a9641d1356e.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:23PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/midx-write.c b/midx-write.c
> index 070a7f61f4..0f1d5653ab 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1104,6 +1104,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  			m = m->base_midx;
>  		}
>  	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
> +		result = 1;
>  		goto cleanup;
>  	}

Would it make sense to also convert this command to return negative
error codes?

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 49705c62a2..008e65c22e 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -1100,7 +1100,10 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
>  		mv $idx.bak $idx &&
>  
>  		mv $pack $pack.bak &&
> -		git cat-file --batch-check="%(objectsize:disk)" <tip
> +		git cat-file --batch-check="%(objectsize:disk)" <tip &&
> +
> +		test_must_fail git multi-pack-index write 2>err &&
> +		grep "could not load pack" err

Nit: this should probably use `test_grep`.

Patrick
