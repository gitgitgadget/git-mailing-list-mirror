Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC9134B1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244414; cv=none; b=gSAlFJOPtE8/eT3BGVki8n6ieakiYduiPthIMY4rZFkIrtId9wUw8Ii4AWRqLwfczmr8Og0PANnNsoqD3ifq7qd57eqTcd4VpKzK1BuTaMlTLRNdbY3CCfRkNQ5xEn1mMbMuLnATUakQikpvlKHEUMDA2YZtOilsPmrB/G02EEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244414; c=relaxed/simple;
	bh=WXErogbCFI+04BtaKoLtiivgScfWRXELdLmwkxx/KqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OqpSpzsTZuhG8Ke74hHk8/g1pUPJMKbif0Eq6Z9mG+w1rSUydBmpR0ycObpBUPW/72MXeoEB1fq6mThz40cALOUO3gqpcbp4gZgBZ0qEinHSmry8sZOtAifXRLi+3oYn/m3aS/cukmPF8d6iDdt40x/pjx7XfwbJHlYLDJgt4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rwMjfFeP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rwMjfFeP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B19C71D35E1;
	Tue,  6 Feb 2024 13:33:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WXErogbCFI+0
	4BtaKoLtiivgScfWRXELdLmwkxx/KqM=; b=rwMjfFePdxd2cJy4WWbsVEPn99RJ
	BdQDp6IE2l2ZZtU5mo4nuQmlWGZ5rZ/JjFv1YxkRi6gyv+mmjiOFcGSPzYTzWPMm
	W4qIt/c6arHaLL5B+WymAAaVDI1rHVLlH3cWM+hdbWLfPTP9BgFbh1Rbns0S7Cq/
	pdWKqy6Lr47NCII=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA70A1D35DF;
	Tue,  6 Feb 2024 13:33:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0374E1D35DD;
	Tue,  6 Feb 2024 13:33:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0091: allow test in a repository without tags
In-Reply-To: <CAN0heSrX8zQnfk_abtgBreoc=a8Z+7E-jEHHUFmu6740L8p2Lw@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 5 Feb 2024 11:07:16
 +0100")
References: <xmqqv87aabk3.fsf@gitster.g>
	<CAN0heSrX8zQnfk_abtgBreoc=a8Z+7E-jEHHUFmu6740L8p2Lw@mail.gmail.com>
Date: Tue, 06 Feb 2024 10:33:29 -0800
Message-ID: <xmqqeddpigsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A25612A-C51E-11EE-8F16-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> GIT-VERSION-GEN seems to be careful to only use tags on the wanted form=
.
> My build generates a git version of "2.43.GIT", no "unknown..." stuff.
>
> I don't doubt that you've hit this, I just wonder which piece of the
> puzzle I'm missing.

I wonder that too.

I was experimenting with "seen" with the reftable.  I first created
a new and empty repository with "git init --ref-format=3Dreftable" in
a brand new directory next to my primary working area, and then did
"git fetch --no-tags ../git.git/ master" or something to pull the
history without tags in.  After that I thought I was careful to make
sure I only ran the "seen" version of Git (all my other installations
of Git are unaware of reftable, and the version of Git on my regular
$PATH is not from the "seen" branch), but perhaps I screwed up at
some point and the mistake got stuck in the version file, or something
silly like that, perhaps.

>
>> -       # The beginning should match "git version --build-info" verbat=
im,
>> +       # The beginning should match "git version --build-options" ver=
batim,
>
> Correct, my thinko-typo, thanks for correcting.
>
>>         # but rather than checking bit-for-bit equality, just test som=
e basics.
>> -       grep "git version [0-9]." system &&
>> +       grep "git version " system &&
>
> This matches the commit message, ok.
>
> Martin
