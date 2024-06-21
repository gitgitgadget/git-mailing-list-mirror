Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7DB65F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719012108; cv=none; b=VUfcf8FOOCxgqTdkVPA9jBSA4z4eIRzjW8RiCoqw83rcz3vBKeUWb4aaJMQrfCbWNQxjZwLRTvpfV7Y9btJvCSL+RioE5tUmLM4QfLjW6L+EF5gHEP5a0tkzUf+tQNQXrpkmt3+NemuxjkoCj9RAX3DdZxy+AU7P0fiessyisKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719012108; c=relaxed/simple;
	bh=jno0eeU0k5NKTZ9X8/9Q6BekbV5ozm3JAQH3laj8kRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx3uwr6I7nMMAZFgNM9l5nkKn2lJr1OI3xciGXp156uhgzWMXj3KQOxFqZU6brItO0q8azWXMyrIq4kBSC18+yhqTQIvHcvN2uJPkISJW+JjCYu4oJtVP3/KaPALEewmwIZVvsjJah5y5cbcwlpGiWWlHfUet7ARNDoa11mnTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QysJ/9NU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QysJ/9NU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 052FA23CCC;
	Fri, 21 Jun 2024 19:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jno0eeU0k5NK
	TZ9X8/9Q6BekbV5ozm3JAQH3laj8kRg=; b=QysJ/9NUvtExvx3j4eoam+cLwQ+F
	yMp6Hg2ThB3dY4tK5nrflvQd1K0H4wg2wV448VIIgQifYYOJ7Ysr7uLerw3B0wvI
	fJ3iynzE/3VxjMKCHsh6MxVyAMBLxAKteKpQAvQY3S+C+ckFxSVohXOqT6241wO8
	4lbybIPbaYTgKT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF89A23CCB;
	Fri, 21 Jun 2024 19:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33B0723CCA;
	Fri, 21 Jun 2024 19:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <ab50c9e6-e43a-47fb-b64a-136d6a768f75@gmail.com> (Phillip Wood's
	message of "Fri, 21 Jun 2024 12:28:10 +0100")
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
	<xmqqsex7tp0c.fsf@gitster.g>
	<ab50c9e6-e43a-47fb-b64a-136d6a768f75@gmail.com>
Date: Fri, 21 Jun 2024 16:21:44 -0700
Message-ID: <xmqqed8pkhkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0678E3F2-3025-11EF-959D-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 20/06/2024 20:04, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>>> --- a/pager.c
>>> +++ b/pager.c
>>> @@ -137,7 +137,7 @@ void setup_pager(void)
>>>   	pager_process.in =3D -1;
>>>   	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
>>>   	if (start_command(&pager_process))
>>> -		return;
>>> +		die("unable to start the pager: '%s'", pager);
>> If this error string is not used elsewhere, it probably is a good
>> idea to "revert" to the original error message lost by ea27a18c,
>> which was:
>> 		die("unable to execute pager '%s'", pager);
>
> Either way I think we want to mark the message for translation

Given that none of the die() message in this file is marked for
localization, I would strongly prefer to see this patch not to do
so.  Possibly as part of a larger clean-up patch series, but not as
"while at it" item for this fix.

Thanks.
