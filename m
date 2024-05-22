Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356213D8AA
	for <git@vger.kernel.org>; Wed, 22 May 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395023; cv=none; b=O6v7w8hMwGfoIPhEv3SQLPkulAVUowEZrwD5SH0G8+7gG0FMgd+Ngi4BdSFQjJKe5hZUaNl9xamhhZ8T7Uhp57F4iNjunUQSIoiXzgNKePhJ1E8OybPVXOUbqeHPtU7fEcBqXU4lT02e1neENg4YT8pAfREV4QldETiyvVxalJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395023; c=relaxed/simple;
	bh=VgTQM6oD/G7ID38o1kkmcJ93r1VLNPGpb9QgFeTSA0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tewKtocXPgO978JIvm1zJGxFX7Pa2CnRulR3Ev7QKB2/B3CPTfDO01WjfLZWL12HzqS8C/23kctGJvfL62TV1ARhpsOBho5rhqAJmlW6Ud9cHcQewTPcas/EEW0WTung37ZbCdTu7ewG72LqvRqTUbqKMZT2xcHghpus/MHuzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JZ6IGUT0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZ6IGUT0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E433D18309;
	Wed, 22 May 2024 12:23:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VgTQM6oD/G7ID38o1kkmcJ93r1VLNPGpb9QgFe
	TSA0o=; b=JZ6IGUT0sLPXRMyTtTH3qDXOja84txywzIlOa+ztf/UyMtz9unqBJY
	8zYBq35d5uO8YOKp2QPLN6uEV7k6O8qC0J7jBcK/I2Cd2UoLfZxEONuRAh8aBVZe
	98VvjGr/IQBccBMqVjbK+WqdlStYwbnjbfJl1uESptLCfh5ArMR6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC7A918308;
	Wed, 22 May 2024 12:23:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50C9C18307;
	Wed, 22 May 2024 12:23:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <fbb9c7d3e7c2129bc1526dfa5a8eca0c@manjaro.org> (Dragan Simic's
	message of "Wed, 22 May 2024 08:40:47 +0200")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<fbb9c7d3e7c2129bc1526dfa5a8eca0c@manjaro.org>
Date: Wed, 22 May 2024 09:23:32 -0700
Message-ID: <xmqqzfsh6cjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A226FB08-1857-11EF-8EDF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Hello Junio,
>
> Please see my comments below.
>
> On 2024-05-22 01:20, Junio C Hamano wrote:
>> In an "git add -p" session, especially when we are not using the
>
> s/In an/In a/

Good eyes.

>
>> single-char mode, we may see 'qa' as a response to a prompt
>
> Perhaps s/single-char/single-character/

I shouldn't have been loose in the language.  Rather, we should say
"single key mode", as the knob to control the feature is the
"interactive.singlekey" variable.

>> +		/* 'g' takes a hunk number, '/' takes a regexp */
>> +		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {
>
> To me, "s->answer.len > 1" would be much more readable, and
> I was surprised a bit to see the flipped variant.  This made
> me curious; would you, please, let me know why do you prefer
> this form?

"textual order should reflect actual order" (read CodingGuidelines).

For more backstory,

    https://lore.kernel.org/git/?q=%22textual+order%22+%22actual+order%22


Thanks.
