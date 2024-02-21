Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99E7BB00
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538531; cv=none; b=KISun24ULlSY2eDD+hxQR342S3plLrUnvlOMsqIeVR+YlRUFHviRn/zQXDWXhF/CvD/1vEXb8kNW+1DfuKWiIbPqWMCe2OfUlTGeGcqbn9WiWB8rpoEieUBMlLKeoMT+GQjXzDxH+mekYBkAbY4rbJ4n6gh2ln7xXvk1g2qfLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538531; c=relaxed/simple;
	bh=Z8+gA3m3YPxRA1FI46uqr0MVg1E6mk3r/tf+pMUvsfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NK+523Ib9ylrBkjKMO8mRJc1znWqVTveKJWEcBUX2nMURkkVDUVEs+3Ghp/YilTcyAHAk2RmfAz4Cu/5ogfRPchGSyJFClrrEnWJFV/xWIyQK0+qamdagw9OfJFw0w2YYPi9MMX0ausbqJ+kSanFucvokQI0U9J6R3127ALzZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GY46aSnO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GY46aSnO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 570963185B;
	Wed, 21 Feb 2024 13:02:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z8+gA3m3YPxR
	A1FI46uqr0MVg1E6mk3r/tf+pMUvsfs=; b=GY46aSnOgom7mM83rk2Lh6L7YFf+
	YwdDus3qCA33YX6ydgzv6TCfQURZ/y+0CJ4YunrZFj8lNcmyj80te6VdFFIyzZH0
	x/JcE/Agu0q4fV58Z4i1PHFsrMk6o1DEWwrzeNsTF17nEpdVQdeLJ4lBTAgSDFED
	7Y7oD7vb3/nnOGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 507593185A;
	Wed, 21 Feb 2024 13:02:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE29331859;
	Wed, 21 Feb 2024 13:02:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <xmqqr0h5og57.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Feb 2024 09:56:20 -0800")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<xmqqv86jqc2e.fsf@gitster.g> <20240221173822.GA9696@kitsune.suse.cz>
	<xmqqr0h5og57.fsf@gitster.g>
Date: Wed, 21 Feb 2024 10:02:04 -0800
Message-ID: <xmqqjzmxofvn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 52BC0FCE-D0E3-11EE-BB8C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>
>> Or if it does touch the po files it could as well update the
>> translations.
>>
>> There are changes that can be trivially translated without any knowled=
ge
>> of the target language.
>
> You need to know the target language before deciding it is OK and
> sufficient to just remove =CC=89=C2=BF? from around a sentence to make =
it from
> a question to a statement of a fact.  You may know enough, but
> reviewers may not be.  In addition, it would allow bypassing the
> language teams, which is the most serious problem I see in such an
> attitude.

Oops, "attitude" -> "approach".
