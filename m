Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2002F29
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877130; cv=none; b=Z509QzOgYmZsWK697mmJeL3bdpUJn3Gv6S5G44YvY/SxwpNVhJbLUGuFvZ1YuXdFQu9wI9iK7iIfBZ3Nm+dnlnBC24Kh4m+w/xGqp3X+xIi0tTvDs4/dlDJa+3ibV2W6PSS6g2c11ZdCiuqZn71mD159lrCO5Q/OQ1m4lXI4ykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877130; c=relaxed/simple;
	bh=aYSnowqyK318+Mkn56fKi5iyJZIpjgX5BFMQEsSln2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FU01yuWpr2a22OTanBqYYEa8QX0uuJCTYy/WIaiX0Do0S3N5bUjwzfWzFqAzs/QEQ33b2FVz+Sg5DvH3e4cFamxtG7bZRmPC9yu8wk3gF7D+DnqGxEvo2JWiHZkSXkGhskZUZM+GGvqAq6ncuTZ8SsV1LYc/otzP6gBSN7SIuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MP3X69Ju; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MP3X69Ju"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D76482CBC4;
	Mon,  1 Jul 2024 19:38:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aYSnowqyK318
	+Mkn56fKi5iyJZIpjgX5BFMQEsSln2k=; b=MP3X69JuF49e/D1PjjhVpE1rpDJw
	XH8fWcVmjOu4fPLIsZOGeSkoobX7u/YLA8TqoeZ3W+qgBrJUpMnFzPoc7vzgsh79
	CmpA721y33LT3ryL9BB7Bn+QAeGmYK+8o7rW7jATYJjeyl/B4tUe/M8CBLTTxqa8
	18plkMmWLP7Y5yA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF2E12CBC1;
	Mon,  1 Jul 2024 19:38:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C33B2CBC0;
	Mon,  1 Jul 2024 19:38:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
In-Reply-To: <20240701221019.GA20683@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 1 Jul 2024 18:10:19 -0400")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
	<20240701032047.GA610406@coredump.intra.peff.net>
	<xmqqed8cx6q0.fsf@gitster.g>
	<20240701221019.GA20683@coredump.intra.peff.net>
Date: Mon, 01 Jul 2024 16:38:45 -0700
Message-ID: <xmqqcynwu1h6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0FC9834A-3803-11EF-91C8-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Mon, Jul 01, 2024 at 12:17:11PM -0700, Junio C Hamano wrote:
>
>> > But I do have such an "EOT" patch which I've been meaning to send ou=
t,
>> > since it makes many of these quoting annoyances go away (though of
>> > course it leaves the indentation).
>>=20
>> I am not sure about your "test body comes from the standard input"
>> (not saying "I am not convinced it is a good idea" or even "I am
>> convinced it is a bad idea"---I do not know what to think about it,
>> not just yet).  THe above illustration does make it easier to grok
>> by keeping everything in one place.
>
> I just (re-)posted it in:
>
>   https://lore.kernel.org/git/20240701220815.GA20293@coredump.intra.pef=
f.net/
>
> so you can see the improvement in some other real cases.

;-)

The shells we care about (and that does not include the /bin/sh on
ancient Solaris =E2=98=B9) should be OK, but "IFS=3D read -r line" someho=
w
makes me feel nervous.  Maybe I am superstitious.

Both steps look quite good.  Will queue.

Thanks.
