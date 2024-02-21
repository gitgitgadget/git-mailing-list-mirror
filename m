Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1B20E4
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479269; cv=none; b=pY6F1VQ1IUd2qZ5DYACCDdxUKSLS2cppHhBJIbxpaF6VGnvpMi15o2Zpd2OIf8ao2y0ZeReir4ICgQ5sXIui70878ap8uCHoaKAeMWjBIxoT07GAwxTzpm0WOYkCSsYjsbNwvtLsbHqmH2Hwtu/SesfKDO8d5MEJP1wLIGiNpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479269; c=relaxed/simple;
	bh=AbjpuCrXiDSzp0abxNlUjzAf8SICXsQ2atxYYv3Hp7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZgl5veLdpXw6piOzAKKCyNZBOGtvekNAzRKlguhpxAUYwrlpin2DeueI7XOV6MARqJCXhV+HYLitH/O5lH5fRLwLfvOqwAK2ogWpqGdQGvAUguFMpAQD8hUPNJLxEp2xFc52Cwo/jjc8/CKhSo2tGdEFwCV7hZ7cd9nDSg6nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w253NrMv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w253NrMv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA9032B1C4;
	Tue, 20 Feb 2024 20:34:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AbjpuCrXiDSzp0abxNlUjzAf8SICXsQ2atxYYv
	3Hp7s=; b=w253NrMvc0Tk7ZJ1iGqLwmAnEZwRoBAbhyo9u8g14fKbSlax6kEbhG
	Nw8i5s0DFCkVV0nUSThIdX2rjC6nPzNUtDZXoi1aL04G+461aeFvt0YOtdAhG7iR
	RVZTOiFUeSC4qp2qunQn42Lb92lrv8NN4OlNuPelNX0xxhDz4MwPo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B25EB2B1C3;
	Tue, 20 Feb 2024 20:34:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 561DF2B1C2;
	Tue, 20 Feb 2024 20:34:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when
 --no-format-patch
In-Reply-To: <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
	(Britton Kerin's message of "Wed, 14 Feb 2024 11:49:08 -0900")
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
	<20240109010830.458775-1-britton.kerin@gmail.com>
	<a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
	<ZcSJaRczdHApmnVi@tanuki>
	<CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
Date: Tue, 20 Feb 2024 17:34:16 -0800
Message-ID: <xmqqa5nusiqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5484204C-D059-11EE-AD65-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Britton Kerin <britton.kerin@gmail.com> writes:

>> While this second hunk here makes perfect sense to me, there is no
>> explanation why we need to change `__git_find_last_on_cmdline ()`. It's
>> already used with "--guess --no-guess" in another place, so I would
>> think that it ought to work alright for this usecase, too. Or is it that
>> the existing callsite of this function is buggy, too? If so, we should
>> likely fix that in a separate patch together with a test.
>>
>> Also, adding a test for git-send-email that exercises this new behaviour
>> would be very much welcome, too.
>
> I'll look this one over again and add some tests eventually.

Thank you, both.

