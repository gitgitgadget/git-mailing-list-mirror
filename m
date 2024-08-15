Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760E38382
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747711; cv=none; b=h0+gA9Uy8T/vOuRHvlFWLVTmFbm0o6k9tI2qQb7R441lDSpTNqr+qwIrgbtESQkfkha7PV4aaCh5CW5yRLdbDfaQhc1SLYIiRZCq/J2cnzvos9fUYDXloFzYMJvU2c3zo9WUK+f9VKTgEAkudPzBt5We66A1OGR4bBjs/mQAZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747711; c=relaxed/simple;
	bh=WXBCTatIIgYHT1jL8hi6Jin1pwnv3PZ3yFi9gh3XIpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ogTSXyPAq4nWgNYaIyjUGYwQwDZRDaTl/Mm4JBljPEcfGW+DPZzhhOeq8LTjhKa9BSiJPjk4hqGTxB5UvfN6rccMgxKnQ3rSF97TVxKOw3bUcAOrOMW3h9xOgDD0DoDD0Sx9UmvhiPogTybPNoihmT8mX6Qu6cyV0dOHv64r83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dMups2N/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dMups2N/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 034A824566;
	Thu, 15 Aug 2024 14:48:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WXBCTatIIgYHT1jL8hi6Jin1pwnv3PZ3yFi9gh
	3XIpw=; b=dMups2N/8eG65YeVuuLjckHJFvsYJJDyi7ljwCVsQnjyHsHuApyuOH
	LID3Z8+LPaWmGX4ivnjRUgpKVNqCLbOGQB6mmkcb5w8eEP81aJNo/nQ4s3lK7T5l
	G+gQ5xRLKakZMiQtp4joh1jpm8MeeciRuQ+gT9LE9+9GyjZ9F4aNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE9A424565;
	Thu, 15 Aug 2024 14:48:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FE2E24564;
	Thu, 15 Aug 2024 14:48:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 0/8] git-prompt: support more shells v2
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> (Avi
	Halachmi via GitGitGadget's message of "Thu, 15 Aug 2024 13:14:05
	+0000")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 11:48:23 -0700
Message-ID: <xmqq7cchtyfc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F38B6AAC-5B36-11EF-BB37-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This addresses review comment on part 6/8 (git-prompt: add fallback for
> shells without $'...') which requested to use one form for all shells
> instead $'...' where supported and a fallback otherwise.

I've read the series and they looked all sensible.  Will queue but
I'd appreciate a second set of eyes before marking it for 'next'.

Thanks.
