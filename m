Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76592F2906
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096949; cv=none; b=eExJNnGVjTLRzyJAIXKs0TXvRm9dglLXuMsNlPYz8M63flS8+RUMt3ihWVwKZHSgDfrJGk7Pqjamn+6Iy41yCcASboovhcWq6HLCnlDdUxGx2OvMpudOOlNwOOk/nHzYYOBQP6BKrnph3mnGOK3jTW3qSlvftSF+IQNJ/Inhn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096949; c=relaxed/simple;
	bh=CuuzVh6YM5mbQbC9NdMpYWAouqAg9cFJ3DiT3nkXsQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APNIFKzpOHNfNrfVE0VQ6p8znwnvDFResmLUs2AWIdpjxWkNahjFgonquCQj8GIq6PDRZCWGkOhfBcFtdyzIINkM6sgX3GAXdBgWcrt3Ykk0huuRJ2Iyhbt1wuo483K6aeAuY5gAWHOrFo2VW1S00Z3a8SCreR0UzNk8nabFKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeqRhLmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPGZys7A; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeqRhLmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPGZys7A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B411B1D0005E;
	Wed, 13 Aug 2025 10:55:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 10:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755096946; x=1755183346; bh=Y/6X+ltliE
	k3uIw9c6SPPIYXARNLumR8LGjHlWLUjdU=; b=AeqRhLmHnxXCbTQUfOGhoADXzO
	luR+lFl/oCByrJn7koo3lwKyU+BQya7YwbWU5Ei9AcQho9AuRFDODs9f1Je58eQs
	HgW7AgX7a5RtZWaB2Ox+Ql61CHqNqJOlm7aDzx1YKmi6P2wTj3RKth06YYW6Dy3i
	JTSejVKUF+15lQ19fKFIHcjm80ZXSPOJ5fLhRs7UmMNbOQh9Nn1j2yMOTwJfPgSt
	3NMzjzLuPb1Q8jXW4XOJUTU9sVhxysU4DO4/ouQsT8QvYNsqkOV6R44ginlmtQvB
	u+QwoTkNq0v6ma8lv+6x1+U1CRKS31GUEj8HfvP1yYZmHzf9Nu7UFtl1LRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755096946; x=1755183346; bh=Y/6X+ltliEk3uIw9c6SPPIYXARNLumR8LGj
	HlWLUjdU=; b=TPGZys7AcDwg5T2wEFk1Qy3Vp8f23bsn04aabQTS3KincO82Ple
	r/GxDtd09CoUw7fwdNI9Qe3Gz2vd22+3E3t3xccZQ5nwqmohzcoP26USHBF/O1Gg
	rgboRBCHCOOEt3qO9LQYOGXJ3+su5N36lBjOl6ofWuqnFl0dNpH3jCXoKs9C+5JB
	1LVu5mZ2rUzdmxaPgqGUT5Uewf5Ta8cHmQECAa9FUs9BeaUK5ovXsuhUjEpf7PJt
	pjrVmqOs/qQpjL+s48VftXuZndGxdW4PvnAscrXDD58d4jHTD1tB0Y7SG4XrQ/nw
	qMIq4eUdNzphaihRlpn03k/m9X79j0N18mw==
X-ME-Sender: <xms:cqecaC5U-FLSyeyQBNIX1WwytFegoJosJj0XNEWg_vqJPVKsrpzHVg>
    <xme:cqecaGc5r1uXlXz3iOq8nQx50ytAB5nj5WSpupYfISJQe0EoZNhNy32AukN9iVXmn
    qTgD9nSJ_KxI_Oqgw>
X-ME-Received: <xmr:cqecaOAIQo2fjkWM0199_DxiPgCX-bfnQV0uDo0QM282I35ZxIrPxPy5pYopzrInyrrhoWGIVLolq7IImGzlsJNxWFx0prkK8cCijxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cqecaB892JRqJEONzBuhJcZPJGyg8hxc3L6z92neYT2wKaTE0S_yCw>
    <xmx:cqecaBIuJjAStEvc2soGGNa-nRyqDRJ9lD5YZbyF8g_28euWuCsQEQ>
    <xmx:cqecaCjdKGo9RxkKw0zW475PWwQ4n5-6G3_Vg8FK34kjdDDcyXn-rg>
    <xmx:cqecaJ4AJZbQPOjdekLGPL5c6e9NWZO7KUlpnFFnA-_j5iusMyWyIQ>
    <xmx:cqecaKCt9JDZVzs9fReUo1mlLegUhgOIfzwmI3wU3OwEsfKji93em5EU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 10:55:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
In-Reply-To: <aJySUWSq+xFxhyZr@nand.local> (Taylor Blau's message of "Wed, 13
	Aug 2025 09:25:37 -0400")
References: <xmqqwm79x7ra.fsf@gitster.g> <aJs5Gee3ZVCJX8dk@pks.im>
	<aJtSqgJ7w02Ox74w@nand.local> <aJw5eenXu5CO5z2W@pks.im>
	<aJySUWSq+xFxhyZr@nand.local>
Date: Wed, 13 Aug 2025 07:55:44 -0700
Message-ID: <xmqqqzxfnudr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Aug 13, 2025 at 09:06:33AM +0200, Patrick Steinhardt wrote:
>> Fair. I don't want to spend too much time on this signedness topic,
>> either. So I'd go with either:
>>
>>   - Taking the signedness patches as-is. They don't regress the status
>>     quo and allow us to warn about future unintentional signedness bugs,
>>     even though the fixes are mostly of theoretical value.
>>
>>   - I drop the signedness-conversion patches altogether.
>>
>> The more important part for me is to get the second half of patches
>> merged anyway. So while I think that the first half of patches are nice
>> to have, I can live with dropping them.
>
> I'd personally lean towards the latter, and drop those patches for now.
> I think practically speaking that equates to taking patches in the range
> [5, 10].

Yeah, that is much simpler.  That way, we do not add more commits in
"git log" that people may find later and mistakenly think that the
project had consensus to encourage the use of unsigned when signed
and narrower integer would do fine, and we won't have to see
misguided false positives from -Wsign-compare.  We are better off
without these changes.
