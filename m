Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E727702D
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496962; cv=none; b=LomCv5GYoeswCtDEPdIrW7snw+BFfe5haBDRaFnqLyYdWU6/bdETPzeXgIG92d/1k5vbeknXPV4Rbc7H9kyJIIY0FNvc+9YKFvpOmN5llh2xUonxXUYgTjD9zHp4FWP78iaJk5CYzdDebfoB0WEJKXC+zyljuQ6nM4p6ECXeRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496962; c=relaxed/simple;
	bh=8fi/MjoFkwqKBHjzLOfqXiPTzYvIshIid8Ifgs/BBuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ht798Rw1lCiavKq4ddySVZKdGgSkBcru5+0o0ZVYXiR1wjQGDZmXPnnB+xn42hFVG/RCiSGwj+QbpeStaj8Cbe9S5w6JXtWCwlsMUCYRoWh8siLD+HOL47LSyGpKW9kVrJ5QSHSo87RzThuZBl2ED72enlsicolTdpHer9xVpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yJhVOLAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgNgf33M; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yJhVOLAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgNgf33M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0F377A02A5;
	Mon,  6 Apr 2026 13:36:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 13:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775496960; x=1775583360; bh=0rD+ZUPXFN
	+wkrw7zEFzzTyMkjDYsjmAEh6zjXs4dNw=; b=yJhVOLAPtL1J/Y/wgp42Kyb9AY
	zcD2s07tf96TL+7sbkKgZcmMk2HjTKzlBBPW4fDoxD0l92eK/axLLBlCwnsIfy+g
	dDDIkgi2sQcJF0Tw3wr+HIRIuwa+1gl7XGPD/kqYEgk7B55m0rThPz7DbMJmo/fS
	jKtL+SYzXcfDvdK5Kdes93a8LsB+laNevru85AU8XUx2vrafLOyg7EyVBH2MiJ9i
	x+dt0YcdOAI9pqP9bQkOrV3niRRUujDmI/1FDX+cSXwSVilTGiymSAPiUABRYhhx
	2yhmgVo8vXe9Lmf4ZJ4VavxAEzRVuj+J6v8OIW0yMy2LhCcJeFk2RyoQfCdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775496960; x=1775583360; bh=0rD+ZUPXFN+wkrw7zEFzzTyMkjDYsjmAEh6
	zjXs4dNw=; b=dgNgf33MDX3xp6pI1YkbMsr6DKz63WLaqAwnww7cVBsB1oibFI5
	aGA1rm0KaQh8iwZeK0Nqbvm8qoaQhWpZVvjNrJu+7sX7f3m1FCv1016N4N/riNUa
	SZo2mF6Bt8bzraBTWuO6pvXKr2CeVocSXa3F1COC/Foj9bRVQVQF8JAyaea1WkHq
	hYsIVKzsXjwR5bXyY4PWiYg8JmOjBQqq89ISZmaFGwbhK0Ln3NRLhF898dDFV8/H
	/diZbKOKOYjIO1GylTeYG4/mW4Q7ehMWx6oz3xJajPtAwAZ8qRS7dI504JlgWRDT
	8fSd7/pTGJ5u5kmCs6P30OpDvkNR/ZPfJ+Q==
X-ME-Sender: <xms:AO_TaTQHBXfAUGlpzrJ6OWtVgWogNCsapa04eleahvqBZzWoDtXVvA>
    <xme:AO_TabyJu1Bs-RWIgyemOdXFHy5YOemnGBDWcLxeF9JUJ5KeRuMrDYB9x_WEhUYDi
    6Sx1oPZZ_Sc33C40ZvsrOGNYJN-auNMeeDkbgKDNA3LquOtQnbUIQ>
X-ME-Received: <xmr:AO_Tad2a0kxqv5mzi61iu_Sv9PcNSlttEhw60-0iWNLjHUfDnzqlori5T3XRGCFrY99f1j4Xu7IiaW8ItuJedfX8sxQ2rtIkeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehvihhkihhnghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:AO_TaR6Mqi_ioSmYri0QSzkFIPHl8Fpq7anCXCqfb2ogmSbqWz2Cew>
    <xmx:AO_TaYXSaWI7YJJtxhWXasqnwmL27sksWDZ0D9n0nrrcLHPP76tCAg>
    <xmx:AO_TaYBuZLFyc8e1I-wUrbdVkHyPiLS1Fn9yWB1Xku8EndpIQ0qgYQ>
    <xmx:AO_Taf4f9SiONoA6Lh_uHpofy9AYfLTqYI_CRFnDIioqa_qbiorVjA>
    <xmx:AO_TaVUXtO_qDxpEEdn_TzQwsX6uWXu2J78CeCtoiv7Cc7YkX9KTndgv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 13:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: add --[no-]progress option
In-Reply-To: <8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com> (Derrick
	Stolee's message of "Mon, 6 Apr 2026 09:16:30 -0400")
References: <20260329152443.525493-1-vikingtc4@gmail.com>
	<8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>
Date: Mon, 06 Apr 2026 10:35:58 -0700
Message-ID: <xmqqh5poat4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 3/29/2026 11:24 AM, Trieu Huynh wrote:
>> 'git backfill' is silent when downloading missing objects, giving
>> no feedback during potentially long-running operations on large
>> repositories. By contrast, 'git fetch', 'git gc', and
>> 'git index-pack' all support --[no-]progress.
>
> I wouldn't use the word "silent" because the output is actually
> quite verbose by default.

;-)

> With your patch, I think there would be some extra progress
> indicators between these batched fetch requests.

>>  static void backfill_context_clear(struct backfill_context *ctx)
>> @@ -54,6 +57,7 @@ static void download_batch(struct backfill_context *ctx)
>>  	 * avoid possible duplicate downloads of the same objects.
>>  	 */
>>  	odb_reprepare(ctx->repo->objects);
>> +	display_progress(ctx->progress, ++ctx->batches_requested);
>
> This looks correct. My preference is to not use prefix operators
> like this on struct members (it reads like you are incrementing
> 'ctx' and not 'batches_requested', even though it is correct).

Thanks for paying extra attention to such details.  In general,
post-increment and pre-decrement are the norm when evaluated in a
void context, so the use of pre-increment above violates that norm
too.

> However, I'm not sure that we want the progress to indicate the
> number of _batches_ but instead should be the number of _objects_.

True, too.

Thanks.
