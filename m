Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1625EFBB
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203763; cv=none; b=ABp4IPfyY6tuPiTv6TNc2UjOLjZx+gD4NcgGxefiMApvdoiBSiWei2zST74fqcDQaTvqBLIkPEliW8+9BLuL07E6l5baU8tfEoaGrNssAbXOkK4NMT4QvQud6u9OxPQvbinoaUo6UNlAMOfwYWk/WWG9qhIF4H/47gdJwSlf0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203763; c=relaxed/simple;
	bh=D7Isg+8pj3YugzRZsNVZqfv2mjV7vZ2vTr63EVSy7QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqT0+7Ky580xUvcd/bm5DV+afRM/gPdB8Wjz4IFYtyq91lzRo9tXo8ZgqDaxQHSJnSgVC0myvLU9GDSQ/ZeRsMGxGjEwehyDqO3I1mEHV8US0h4pMPnaVoUCAj2Rdg16DUX7p/vbz5/2wk6AkHsKKhMQIhx7+kzOZlZ6lkgyLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cxGv9gA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUKRGrt6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cxGv9gA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUKRGrt6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AD8D2540182;
	Fri,  2 May 2025 12:35:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 02 May 2025 12:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746203759; x=1746290159; bh=M2JbPfx9uT
	31PQfST0z2Mz3X+cmV9nX0BJCzatTNpMU=; b=cxGv9gA0LmcPgaocpS6A/VsOoa
	Z4mhbJdaYCjmgS5KmQqI46Ix7o4X7jSvkXLluKKoVZPwsYF0hbvbio2Gx6fydmn8
	cvMyvbVYNyvz2lFz4GpPPC95pGPgz8GpWWttqvTpnbxlY4DHadSobcZvF5d/Ew19
	SHBXzXm/vlj7ABXNpmo5xdb3wzroGzAtuhwnLugD/z9NIkjiLZpVo93za+CiVSi8
	WkbRqv0i1sMID1kpcE9Wyd7i52A4kX5Zc74wdeVnEJhzM7U9pqQELfrfUFS2oagl
	2cOdnu/1DdQUT2T91cywqUTRlFwlAq0F5jkkLRsDkwWuw8yujLOZhwW5tWVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746203759; x=1746290159; bh=M2JbPfx9uT31PQfST0z2Mz3X+cmV9nX0BJC
	zatTNpMU=; b=SUKRGrt6vl8Z8cV86eEKvCb70dgsKvgEwL2Cq5afaMs+9Nm3TBD
	1gpP1psy0UHlEqZsslFfweJf8BqbeB5LfE86EsCWfVV3fL54HppwSkHVSJWRkp1W
	mtvBzNcAfwun4y5cdBmZ3uNqPA6eE5MXvkK3hIjnCLIxP0Y8xHJy/Tf6m4rUVWnX
	Yi2+IboDbgjWaltfOm5slIlSC3Gq/kGxhaNHLRmu7iYW3UXQQdM/aWMXR+dUSrsk
	ldkwple6BziKMyHWuDrVQ2vCt9GS6zom9AQ5vm57Ut1bPdn1lKzrohZzOyPlAvT6
	bKwonC+kjWh9DGf8zp/qo94g4IhrH3to7rQ==
X-ME-Sender: <xms:b_QUaFH-xp0dg7X_qA_6EPTShKw1ZB4B_3zSy3n52-OF99QOMqbHeA>
    <xme:b_QUaKUq2e76ILn5a5BYISJL9VB3rYttWCWuo2tUhztd7jS34lQQNivjTkf35HTta
    3BhFdiuu6jScbkoUw>
X-ME-Received: <xmr:b_QUaHK-Qyw1oL583je-Ad8n58KUVLWwn5TVayn35G9Fe3YSMFYQwIg4DNcjFLtBvh1wBv1zDj-7cg8_fBmXOwgug-23btXNctCj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepveejgfejkedvueehjedvgffhieeuhfff
    uefhuefhjeelteefgedvhfettdekvdeknecuffhomhgrihhnpehrvghrvghrvgdqghgtrd
    gruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b_QUaLHu7Wdwlw8CLDEuWb1jnPZUoMCpQ_ZzmO6Fi9z_PginZvbWBg>
    <xmx:b_QUaLVrMcotYsWPElEMI9dHPIgT6W1OQ9HZ0egZHXBPB5SuHKTUtA>
    <xmx:b_QUaGMWkj_kSU_858ICxneeTX5ArlD5UkqhOLYI-Lq0GycKomgtWA>
    <xmx:b_QUaK0LMkF8oAObRIkaqdqSLD0JmDXxltsPGXweHwrku_12lWlMbQ>
    <xmx:b_QUaLlC7jXXWM5fcfLQMzF2QXDUyH59YT9YE9IpQL-JqpJwQXLqfhSl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 12:35:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/8] rerere: provide function to collect stale entries
In-Reply-To: <aBR9R3PxSCuLON6G@pks.im> (Patrick Steinhardt's message of "Fri,
	2 May 2025 10:07:35 +0200")
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
	<20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
	<xmqqy0vh1t96.fsf@gitster.g> <aBR9R3PxSCuLON6G@pks.im>
Date: Fri, 02 May 2025 09:35:57 -0700
Message-ID: <xmqqwmazug0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> And if my suspicion is correct, all this change does to the plain
>> vanilla user of "git rerere gc" is to have them pay the extra cost
>> of allocating and deallocating the list of names of paths in string
>> lists.
>
> Yeah, I think this concern makes sense indeed. I was a bit sceptical
> myself whether this is going too far. Maybe a simpler solution would be
> to just count the number of directories in ".git/rr-cache", without
> checking whether those actually are prunable?

I dunno.  It is not like you are guestimating files under
.git/objects/??/ without couting all of them, just to see if you
have too many of them and reduce them by repacking and/or pruning.

Having too many existing rerere entries does not correleate you
would have many prunable ones.  If your development is nearly linear
and you do not rebuild the same merges over and over every day,
majority of rerere entries may be created and recorded without ever
getting used even once.  On the other hand, in my tree, where the
same merges along master..jch first-parent history are recreated
multiple times every day, the picture would be different.

> We could also adapt this to be closer to the original version, where we
> only verified that ".git/rr-cache" exists and contains at least one
> subdirectory. This can even be combined with the above approach if we
> set "maintenance.rerere-gc.auto=1" by default.

But wouldn't that be like always running "rerere gc"?  What would
you save by checking the existence of at least one rerere entry?
Cost to spawn "rerere gc" as a subprocess?  Wouldn't it be a better
use of the engineering effort to libify the logic of that process
and make it internally callable in the longer term (or are you
already doing that in this series)?

>> We need to see some performance measurement to show that the we pay
>> for collection and counting is a lot smaller compared to the whole
>> pruning operation to justify the "auto" thing.
>
> Hm. I guess ultimately the answer is going to be "it depends". The
> performance implication on Windows is going to be quite different
> compared to the performance on Linux/macOS.

Yes, but we need to start somewhere ;-)
