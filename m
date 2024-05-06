Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E813DDD2
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015869; cv=none; b=pI2eREl83s3Zs+T6QMG3GXElmmOhKPjM6TFgTa/aHi6MhCFHin9tx68q7e2DrGTSPGZx7Ghq2f5XTtIAjlAU2bPv+XocRZC9FNkmCTlnMO6ifv634YnRU32d06L/tVSwCtDriLQCENMDGJrOJC0UBENezL9EIPQGn2oIIAkprt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015869; c=relaxed/simple;
	bh=j0iLQyEXDMdfPd9jUcH8HmRwTcz54/Cd1KscDHbgK70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+J74Py3CJaKY8wVYphuXwGE5ndPdX8fyXF82NRbrs9zbcjT2kAAWsE8yeSwg3dLdBJlAXQW0JBFaUQM+740awzRFpBlagiDV3Lie2T857QH9BQt6fogqhRHZsx0lxeDu26fOEtCIzAkmKAro5Zqg7ayms1/h1iHr5XXnTDD8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DTosXTmX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DTosXTmX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D03A3EB36;
	Mon,  6 May 2024 13:17:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j0iLQyEXDMdfPd9jUcH8HmRwTcz54/Cd1KscDH
	bgK70=; b=DTosXTmX0m45yh+dX2NhQNMJySz0ayi424A4Ah3Kfx9Fab4BAuA8WI
	i2TlrwSkrGEzsPe9M9OfM+913hfDljgiOiS6xPKTuTD0h+LC+R2VFKczjLNUBSgJ
	54HKsKiWiNUg/wTHyWkJKMo9VzWTtdZ+Dyo3VlKPmGd/rH51tDx1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 947C23EB35;
	Mon,  6 May 2024 13:17:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07A2C3EB34;
	Mon,  6 May 2024 13:17:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
In-Reply-To: <Zjh-3dCL2-MnV-PE@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 08:55:25 +0200")
References: <20240502193840.105355-1-jltobler@gmail.com>
	<20240503172110.181326-1-jltobler@gmail.com>
	<20240503172110.181326-6-jltobler@gmail.com> <Zjh-3dCL2-MnV-PE@tanuki>
Date: Mon, 06 May 2024 10:17:39 -0700
Message-ID: <xmqqle4mzwp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B53A21A-0BCC-11EF-BB9F-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +check-whitespace:
>> +  image: ubuntu:latest
>> +  before_script:
>> +    - ./ci/install-dependencies.sh
>
> Do we actually need to install dependencies? I imagine all that's needed
> would be Git.
>
> Other than this question the patch series looks good to me, thanks!

I am a bit puzzled.  Is the proposal to check our sources with a
pre-built Git (which by definition would be a bit older than what is
being tested)?

Not that I have serious trouble in that direction---I am just trying
to make sure what is being proposed.

Thanks.
