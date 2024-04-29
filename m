Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AAA86245
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410265; cv=none; b=dMTvM71TXqYepzt1BrJ52Z+6e4G81hJbJonQ5knJC5Yi5DYZnVj19oSlYSG4w0d6YPD3uYylbt6Lv7Jt5PZ3V4oTG3RTTl+/FhZde+rb6Aqd4d0bmXFjS9wU5r95m0A1FVr8BofrxzlaGHUvmJv6lGZneWqd4cx4x8OYkyPdelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410265; c=relaxed/simple;
	bh=0X38/j4ZpnAaABx60cAMMFo8Ilfejwv/R8Ke5KOA94s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCknofFM6WhGvXzIuCUJBsESIgIrkQ/hIRkHLF+bv1SyfgK+DEjpThEmYdPtqEkn8hiOr5CRB3f5ngzqd67V9V1G+7MV5gSZEqzwR68O+vBYql69EorrMd8AR7j2G5Py+kjtmN13KgsyfcqQkN9MgBRxvs/egEbXsqaBCO+jRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kXweJgYb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kXweJgYb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC48D3EBA4;
	Mon, 29 Apr 2024 13:04:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0X38/j4ZpnAaABx60cAMMFo8Ilfejwv/R8Ke5K
	OA94s=; b=kXweJgYbpUjLXyAUNi+43S0dIuFyVvKYBRrZySYseXlfsnMHCBmBHp
	2GtA2lRrKZzTjqLwuq9fNhyhjlK3xyD04FKe/OM18WtaeoRxnpaaxy9SS8JCjWjk
	6Mrue5yrszk81hY+kdkaC6MBEF0IZrcoslyZmttWtm9An1nZc/hDk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C5A3C3EBA3;
	Mon, 29 Apr 2024 13:04:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D30133EB99;
	Mon, 29 Apr 2024 13:04:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Passaro <john.a.passaro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  John Passaro via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
In-Reply-To: <CAJdN7Kiep79YeN2GCbjdz9HhHif0nyEDUf51EKcESzR-DOBZQw@mail.gmail.com>
	(John Passaro's message of "Mon, 29 Apr 2024 12:38:16 -0400")
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
	<Zi9DGYwlT7VnW7oj@tanuki> <xmqqplu8yyp2.fsf@gitster.g>
	<CAJdN7Kiep79YeN2GCbjdz9HhHif0nyEDUf51EKcESzR-DOBZQw@mail.gmail.com>
Date: Mon, 29 Apr 2024 10:04:15 -0700
Message-ID: <xmqqil00w168.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83B4C4C6-064A-11EF-89FD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

John Passaro <john.a.passaro@gmail.com> writes:

>> More importantly, I doubt that many trailers we commonly see in the
>> comit objects, like "Acked-by", "Reviewed-by", or even "CC", are
>> applicable in the context of tags.  So I am ambivalent.
>
> A couple of words on the motivation here. First, by way of --list
> --format="%(trailer)",
> git-tag arguably has read-side support for trailers already; adding write
> support seems pretty reasonable. Second, even though not all the trailers
> broadly used for commits are an obvious fit for tags, some still are -
> "Signed-off-by" for one would seem plausibly useful. In my team's usage (which
> inspired this change), tag trailers have emerged as a convenient way to pass
> machine-readable metadata to CICD.

That is a good thing to describe in the proposed log message.

If a reviewer feels puzzled by a commit and did not get the
motivation from the proposed log message, there is a good chance
that the motivation is not well described to help future developers
who find this commit in "git log" output.

Thanks.
