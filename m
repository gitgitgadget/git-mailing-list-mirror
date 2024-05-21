Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7944C66
	for <git@vger.kernel.org>; Tue, 21 May 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308468; cv=none; b=DddleeZx5BdmCRe5gL7MvViRt/fzxkgZIf0RG8ObfAfZpzTwdsDF02s9PhpQDlplPc8+RERW2G8VJ3WpJ8W65pTTkqOIS0op9xYu2ESr7U0Hs/SuX/nXtpMTXweVt89Sp0TWJu0tSjdrcfR73d8ZD1IYyR4ryiVcwjvC9yoPOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308468; c=relaxed/simple;
	bh=kITmObpj25Hdd2XYYruqa+/dk36TIq9bZGebwQTrL6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRYdHknE1vpWsOowP+CuoAwzOlhPydGTGvBTkoNRTEJEsb9SgDGpJuRAhYC1ygDufzjld4FOReypso0ObkRE/uGLt9pguF4M1wPBtGamw4y1L9wz0pwYoObXvyO2WC+10k1V5hZoxav6/YUIGm/AmzQORexmKwMJ20CUQsEij8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8WWl346; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8WWl346"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6DCB2FC67;
	Tue, 21 May 2024 12:20:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kITmObpj25Hdd2XYYruqa+/dk36TIq9bZGebwQ
	TrL6A=; b=b8WWl346pjQS3iL+apIIqflg3tH+6YIH0AijhfZsVAEEj+q5Kibp2p
	8um0/1990mafm+eF6rvP1nX8njGK3IBSDVyXFCKilqTeymTXiTpX4VWktrk/0Igk
	tUPD/pxSLpHYfz/xWCrVrC6xz8mPqJC1T7IrGduZD06HLE09s1I9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFB12FC66;
	Tue, 21 May 2024 12:20:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 483212FC65;
	Tue, 21 May 2024 12:20:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #08; Mon, 20)
In-Reply-To: <Zkw5yDAVAnmy-cg8@tanuki> (Patrick Steinhardt's message of "Tue,
	21 May 2024 08:06:00 +0200")
References: <xmqqwmnoca35.fsf@gitster.g> <Zkw5yDAVAnmy-cg8@tanuki>
Date: Tue, 21 May 2024 09:20:55 -0700
Message-ID: <xmqqfrubb0go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A2366D4-178E-11EF-A230-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 20, 2024 at 04:55:26PM -0700, Junio C Hamano wrote:
>> * ps/refs-without-the-repository-updates (2024-05-17) 17 commits
>>  ...
>>  Further clean-up the refs subsystem to stop relying on
>>  the_repository, and instead use the repository associated to the
>>  ref_store object.
>> 
>>  Will merge to 'next'?
>>  source: <cover.1715929858.git.ps@pks.im>
>
> We've waited a couple more days now, and there was no additional
> feedback so far. I'm happy for this to be merged down.
>
>> * ps/reftable-reusable-iterator (2024-05-13) 13 commits
>> ...
>> 
>>  Code clean-up to make the reftable iterator closer to be reusable.
>> 
>>  Comments?
>>  source: <cover.1715589670.git.ps@pks.im>
>
> There was a round of reviews by Justin on this one, which I've addressed
> in v2 and which was acked by him. I'll try to rope in more reviewers
> internally to get this over the finish line, but I'd also highly
> appreciate any GitLab-external reviews here.

Yeah, it was just me who didn't go back to the thread and update the
topic state.  I think this one is in good enough shape to be merged
down.

>> * ps/reftable-write-options (2024-05-13) 11 commits
>> ...
>> 
>>  The knobs to tweak how reftable files are written have been made
>>  available as configuration variables.
>> 
>>  Comments?
>>  source: <cover.1715587849.git.ps@pks.im>
>
> Same here, I'll try to rope in additional reviewers.

Ditto. 

FYI, the ones labeled as "Will merge to 'next'?" and "Comments?"
were often already read by me and I found nothing that needs further
comments by myself.  The latter tends to be topics I am less sure
about (not about implementation, but assumptions and use cases the
topic is based on) than the former.
