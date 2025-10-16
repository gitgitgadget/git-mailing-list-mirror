Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DB32AAAD
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631793; cv=none; b=HbyAwz+T7MgvnZQ0J6ncpvgioQmMfTzinY+Oc9RtqPcsaGqOGfXhWYh2hnEmtD2Ddx3mWCggIC6WdGhdZoZJlNO6veDqHCTnXCwvWIIiVU7yPBJoTjlANTqeBWnotQorDN6BFagXXRsF4Enk+NOxHFOufZmSYI5wHI59Q0seMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631793; c=relaxed/simple;
	bh=F+mM/VexKmoqHNRtTU+RiPaMyMgwyQOi/q4hdXPq91s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugBVhd+cV+uOylQjm9wqTtYx09qHL61SwBhEOqK/ViBGw6cxooUPOuqF+idSW4R3qLchVWTugNdfjxgUCzMO9k8e0nc/of1/ByLILI9qchS6W5Q8P309EklqS8xgw7W24sRQK4Lm194ggJJOEUD8zN6mh2fCHzh3jjatWgQpK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aqnOakNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wve1Oib4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aqnOakNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wve1Oib4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4524B7A009C;
	Thu, 16 Oct 2025 12:23:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 12:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760631786; x=1760718186; bh=r95dHw9GgB
	/IDbavb+Ure6IPf/Eh7Ev8HaYrVoDHw5w=; b=aqnOakNSHuSTFlGzDdA3AsN0f7
	r9bQ1CxLZsuSnIyRxdAWpMShVFVYIf713x7PBplmt7wvBQwjdVnfImSl0P7KOA4M
	4R87xM74356l0Ld3VQInyhJLaAhN5gSPELo0hO6TEepS+Akfu7nE221x7D9O6C/6
	P1oDQri0H99saDIctmHNb+1Ovm/OAB4pV+eXazC/f5YJSRU+w2wOn8kFllWDyjNE
	MLZyqOELkiYawJYRNPK04HS5WrNQqhwVyHQvHs5ZA0Ek0liiU9O3qa47R5jq6GHH
	ppgP8Duvn4HOmbpZlLlkLTWmNQsd6Q3+G+r0zVRXWRveN6Rzyb1f8UpUFkPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760631786; x=1760718186; bh=r95dHw9GgB/IDbavb+Ure6IPf/Eh7Ev8HaY
	rVoDHw5w=; b=wve1Oib4Vk202w++r+2cmSwR6qatKy32OBviHQaul3WiJuz3Qxc
	0WK8jWWqipHIMdLsDU7X+lztd+J9MsVyhrKZ1r+yjlajRp8RhDTJPDAUGrVByfgR
	+X9mL7wosCry6etayPnJPVjcP5RJb1UfK4NBGAycmPH0po9q6AeL9dU0lxGUBZ/T
	W66NzY+OlKPaNyrsLh9fmvQQWXjoABj4cT489WM1MiS1xTMWOQits3uDcB2scbhp
	usHOYJ5Hqh7UYxgrwCkQ/TOX7BRYr5Of/bpXvreUan5n18BX5+ccw0a9wwS+yjDO
	cMJhHa0crGY0H0PVifDwNb9Qy4sEryDRKKg==
X-ME-Sender: <xms:6RvxaP96mBF8lgfNwrZpbm6P8Ny7iKqaihsmfTeUKTKCCHU7adVbtA>
    <xme:6RvxaMdH92f6QQytHOBYxVuyvbL3uhetZH8_BRtKG6eDDOGKNp1_vtz6ueOmIqhj_
    b40WDScBmync5ERShcx8GyUMHQnDUXUq2eMDAuUTNLlUJQ0dVBW2Q>
X-ME-Received: <xmr:6RvxaJJ4arvQlGu731rkG1aqb949fowOmw_YamNClZVaFUMI9F5dQdJjBi0pIp_LP6MMgfN6IWxGx8LD5zndSueaWzLm3cjOpKua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeijeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6RvxaMj4SEWgOG1cw1UpoSZDuspPhjLm4r9YTdKI4gJlM-Z-aqKOCg>
    <xmx:6RvxaHShw9ZcPEwhO4N_2EyqYwXh9qN3ulUyFaGKHx8MX327reQQ4A>
    <xmx:6RvxaGXSjY43iyLSR5u2wcCxH2M2VuzHd_LYLCn6ggoIc8QJoJaz1g>
    <xmx:6RvxaDTBNDddb5hJscUZ4Q9Wq13IDaupgHocJLaxqPPqWSlYChQf9w>
    <xmx:6hvxaDnnrjIUlVDlA5cigag0i8Z2V3_pKVFWrcW-7wB67G3cbJmU-f-I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 12:23:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
In-Reply-To: <8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org> (Johannes Sixt's
	message of "Thu, 16 Oct 2025 17:28:33 +0200")
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
	<d17060d9b72.1759952528.git.code@khaugsbakk.name>
	<601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
	<52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
	<8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org>
Date: Thu, 16 Oct 2025 09:23:03 -0700
Message-ID: <xmqqbjm695p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.10.25 um 16:13 schrieb Kristoffer Haugsbakk:
>> On Sat, Oct 11, 2025, at 11:15, Johannes Sixt wrote:
>>> Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
>>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>>
>>>> This option has legitimate uses but could create a commit history which
>>>> violates the assumption that commits are strictly increasing in terms of
>>>> commit timestamps. Warn against that in both git-am(1) and git-rebase(1).
>>>
>>> I think that the discussion has meanwhile converged insofar that we do
>>> not think that the option has a legitimate use case. Rather, it was
>>> introduced to solve one particular problem case (that is cited below),
>>> but with a solution that was misguided and not well thought through.
>> 
>> Okay if this was the cited example:
>> 
>> https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
>> 
>> Then we can clarify with two questions:
>> 
>> 1. Is the use case itself reasonable, i.e. abusing[1] git-am(1) to
>>    pseudo-import commits (modulo the committer)?
>
> The cited example talks about a set of patches and expects them to
> create the same object IDs each time they are imported. This expectation
> only makes sense when the import happens on the same base commit. But
> then, why in the world would one want to import the same patches
> multiple times??

Only when the person is trying to make sure what they are about to
send out _will_ apply cleanly to the intended base, I would guess.
And that person would be using an unstable implementation of "git
am", perhaps who is futzing with it.  Otherwise there is no reason
for such an expectation.  Perhaps back when such a request was made,
fast-export/fast-import pair was not know to the requestor?

> A mailbox full of patches is not a suitable storage form for commits.
> This particular use-case for git-am just does not make sense.

I would think so, too.

>> Like this?
>> 
>>     Do not use this option. By default the command records the date from
>>     the e-mail ...
>> 
>>     WARNING: ...
>> 
>> In that case I think parentheses makes it read better:
>> 
>>     (Do not use this option.) By default the command records the date from
>>     the e-mail ...
>> 
>>     WARNING: ...
> I do not like the latter. If you do not like the former, I wouldn't mind
> not adding the sentence. The warning should be sufficient.

But stepping back a bit, if we truly want to discourage the use of
it, perhaps we should officially deprecate and schedule it for
removal?  If we are *not* brave enough to back such a move, then
perhaps we ourselves are not yet convinced that this should be
discouraged?

My preference is to stop at describing, in WARNING or NOTES, what
the use case that triggered the addition of this option was and
declaring that the use case does not make any sense (your "who would
apply the same series twice on the same base?  just keep the result
on a branch and reuse" would be fine), but without saying "Do not
use this option".  In other words, the message is "We'd give a long
rope that we do not think is very useful, but it is up to you to get
yourself tangled in it".

Thanks.
