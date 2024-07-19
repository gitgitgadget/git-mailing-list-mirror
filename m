Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D061474A2
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413519; cv=none; b=CZqplf1GKI5xT9CA8wWL9+tfXYbTvFyrAfqxlYuWeErMfgxM6wykpJe/S6BeDKd37diDJV97xSU29RiF+hf1klEEulW5jTWxtKUiUVA13jfl8q083EBuo5CidAI6BJB2afgXoNd+3wiJevBxmcX+NDTI1Jmmx+frMGwfcZgeF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413519; c=relaxed/simple;
	bh=hNz35c/66fyzdXPWa4HGEA+USg7uUANvkKjVXqyO+bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LaMdB4Ik1gR5pJ4eEw3M/nhUuci2g90oTtyT0WFhIWuS0fA1n8wQ468xiTPTP+jGK+uUmm1CZt2ngSfAOUWue2UEXcTzPsqZhrqFF5HgD1dkTGEWZm9fsatGH8zrJAcl0sUabF5TKhn9A08b7kFs7xbPj0+jX1F2QHd8AiGre+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xu3ELlpK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xu3ELlpK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D61D9301AD;
	Fri, 19 Jul 2024 14:25:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hNz35c/66fyzdXPWa4HGEA+USg7uUANvkKjVXq
	yO+bg=; b=Xu3ELlpKL0HGpYFkVPnHbza2S6kfJss5ydYqxd5meTpDbteNr93zyf
	50ApXVdlSN2BxIQpYsOX0uP1oRMrziLoCR15Vz+ADPHialr1kiMQsMOLA2chqx7b
	yUbvzk7dvgEdUIFKHIIct6dMBTLIHhLgJlrF8/h35aTn3uVndXLMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B591C301AB;
	Fri, 19 Jul 2024 14:25:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBBE0301AA;
	Fri, 19 Jul 2024 14:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philip Kaludercic <philipk@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: Best practices for indicating what address to send patches to?
In-Reply-To: <87msmdmfwc.fsf@posteo.net> (Philip Kaludercic's message of "Fri,
	19 Jul 2024 17:48:51 +0000")
References: <87msmfrn3r.fsf@posteo.net> <xmqqh6cmzspe.fsf@gitster.g>
	<87msmdmfwc.fsf@posteo.net>
Date: Fri, 19 Jul 2024 11:25:08 -0700
Message-ID: <xmqqv811i6ij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B2B78CA-45FC-11EF-93CE-BAC1940A682E-77302942!pb-smtp2.pobox.com

Philip Kaludercic <philipk@posteo.net> writes:

>> It would not be an improvement to add a mechanism to make it easier
>> to find "here is the address" to a reader who hasn't even discovered
>> where these contributor guide documents are.
>
> But is that an argument to prevent projects with mild or now contributor
> guidelines to make the patch-driven workflow more difficult?

Projects can actively refuse to use such a "feature", if it is
expected to encourage undesirable behaviour by new contributors.
And projects that do not care can use such a "feature". In that
sense, I can see a future in which such a "feature" exists but not
used by everybody.  But introducing such a "feature" that is not
necessarily an improvement and can actively harm projects that use
it is tricky.  You'd have to document the upsides and the downsides
to allow projects to make informed decisions if they want to adopt
it.

Stepping back to your original question, you asked if this is
intentional and if this was discussed in the past.

The answer is this is more organic and not with an explicit
intention, but in hindsight, because submission address is just a
small piece of information projects want to publish together with
other guidelines, not having a mechanism only to give the submission
address would *not* have helped projects all that much.  With the
explanation behind the answer to the first question it should be
easy to see why nobody talked about such a "feature" in the past,
which is the answer to your second question.
