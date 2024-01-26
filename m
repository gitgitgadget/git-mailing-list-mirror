Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54824B29
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301264; cv=none; b=OFISLjMr9ggdITlYEgdGI4sI9S4hSxxaRG1HhJhaFaEhF4xRlS2NaLdCjdVfATg6v8ejCmUTsD+4GYFhkZAkhmnUN3fXGkSHVCLahRNfTTgo+hR8ldp7Iy9Le6inGtLqz30DK+MTarcy2NGatHVwv7rQ7d4XbVnQnbeJuRgiTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301264; c=relaxed/simple;
	bh=ppzPfH95NdxMshgo2K6mryCydfCIIzOeThEJvJO8vpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWaEF0M0ILDoLAi6fEsq/CTtBgyhYviT8ZYS5urO5zhh0KLxM2LxW6634AtWd4bm5xDLoKJ7xVc0HYCqJgWQF6CiTs13QXETpxrKRvBSd3ZZriKV4a0PyNiYyvyk/b/2G+VSxz+wAOO8lpyBE2wu8vMHvQEfpiTRkjv9BiDFiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fVHZ9QrH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fVHZ9QrH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 82800362DA;
	Fri, 26 Jan 2024 15:34:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ppzPfH95NdxM
	shgo2K6mryCydfCIIzOeThEJvJO8vpw=; b=fVHZ9QrHUbnM4qxszu2gHLRrflSj
	379lQmRnN9W+L82WO8ktILyuqGZPWOrHCywHxm3aprK//TRmJwnaslX04FsjjNKh
	w07o5+s4UGUIYtCOtU4wTEr7lyxMaJDDDlU+1tvnwTKhH6QN+wygCvcwDK8YFLxH
	JEpo2tEvmP3eqME=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AE96362D9;
	Fri, 26 Jan 2024 15:34:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27AB8362D7;
	Fri, 26 Jan 2024 15:34:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] completion: introduce __gitcomp_subcommand
In-Reply-To: <48717a57-42ad-4c00-bdd5-c23c0f3ccbe9@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jan 2024 21:09:51 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<8c902c53-815d-43c2-8ba9-8144d8884804@gmail.com>
	<xmqqmsssngyz.fsf@gitster.g>
	<48717a57-42ad-4c00-bdd5-c23c0f3ccbe9@gmail.com>
Date: Fri, 26 Jan 2024 12:34:17 -0800
Message-ID: <xmqqsf2jn8ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 47D60E56-BC8A-11EE-B353-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 26-ene-2024 09:26:44, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>>=20
>> > +# Completion for subcommands in commands that follow the syntax:
>> > +#
>> > +#    git <command> <subcommand>
>> > +#
>> > +# 1: List of possible completion words.
>> > +# Returns false if the current word is not a possible subcommand
>> > +# (possitioned after the command), or if no option is found in
>> > +# the list provided.
>> > +__gitcomp_subcommand ()
>> > +{
>> > +	local subcommands=3D"$1"
>> > +
>> > +	if [ $cword -eq $(($__git_cmd_idx + 1)) ]; then
>> > +		__gitcomp "$subcommands"
>> > +
>> > +		test -n "$COMPREPLY"
>> > +	else
>> > +		false
>> > +	fi
>> > +}
>>=20
>>=20
>> I am not at all familiar with the code in this file, so treat this
>> as a question from somebody who do not know the calling convention
>> used around here.
>>=20
>> This helper function clobbers what was in COMPREPLY[@] before
>> calling it, from a caller's point of view.  Is it a pattern that
>> potential callers in this file should already find familiar, and
>> they do not have to be reminded that they cannot rely on what they
>> prepared in COMPREPLY to be preserved across a call into this
>> function?  Otherwise I would suggest mentioning it in the helpful
>> comment before the function, but I cannot tell if such a comment is
>> even needed by the intended audience, so...
>
> Maybe adding such a comment might suggest at first glance that we're
> working different here than in the rest of the __gitcomp_* family of
> functions, which is not the intention ... I dunno.

Exactly.  That is why I asked.  If it is a norm for all these helper
functions to stomp on COMPREPLY and if it is accepted as a common
pattern by developers who touch this file, then I agree it would be
misleading to have such a comment only to this function.

THanks.
