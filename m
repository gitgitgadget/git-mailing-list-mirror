Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649D1993B9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732990; cv=none; b=tgQB4IvuKooVu+pV79dYSo+se4XFuKiiukVzATwReM6MKUlrMDPdFrxXShNmekSpPbg6TlKXiSsfx4Vndx7QLwhJLN0wlO+Kz/jkwitCsdpvWyUkITtT666FwKraNkr6zPR7nm9nrIuiseim0D4UVlGPFZbVgPxcWa2mDqokq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732990; c=relaxed/simple;
	bh=R5iz0hUHC/u71deZnOetHxTuR9UIZPCeKB/iFUpj0W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USAakFSb+pNSeLnxEsxnrnFHGAa6grMCVeVVKHIBCc3I3UTyQTVT/k8ubWMzue9Yhnqrad/fW7GoUjVHbYgbO22ZsCIiqS9KMQOQ4tYxrJ6paVnBfyxRPCZQrVG7uG2NZLn/4XXe0XYc4j/ScrjFY4L28XCA6PuO67nv9mq9fCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VfmMmngN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VfmMmngN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D28941DFA8;
	Thu, 15 Aug 2024 10:43:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R5iz0hUHC/u71deZnOetHxTuR9UIZPCeKB/iFU
	pj0W4=; b=VfmMmngNYmvmOzv+G4h0ubUQQ35scasLFTd3Ct+j9Uo+cEOktvTZ9z
	UpNLTsnwmdj16u8deaxG7RPXNh1jWSGxLO/9Ylw0ok4e/wzaWet/JeUfBMAy4YQ7
	mqhihc3FZQaqJjsnZ7BSNc+789eO9IutTgRucLFaS93K7PLXMnp+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C47C91DFA7;
	Thu, 15 Aug 2024 10:43:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 112AA1DFA6;
	Thu, 15 Aug 2024 10:43:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
In-Reply-To: <0882a098-eb07-41b1-9527-04bdb77fa0d4@gmail.com> (Phillip Wood's
	message of "Thu, 15 Aug 2024 10:51:54 +0100")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<20240723021900.388020-3-gitster@pobox.com>
	<5332f244-7476-492a-a797-2ef7ba73f490@gmail.com>
	<xmqqbk2ljvty.fsf@gitster.g>
	<5e4906be-2cbe-44b5-b490-593ee5a42b95@gmail.com>
	<xmqqh6bnyqjp.fsf@gitster.g>
	<0882a098-eb07-41b1-9527-04bdb77fa0d4@gmail.com>
Date: Thu, 15 Aug 2024 07:43:05 -0700
Message-ID: <xmqqo75tvocm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF569D38-5B14-11EF-9F25-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Fair enough. I will note though that this change makes it much more
> likely that "safe.directory=." will match as it now behaves like
> "*". Previously it only matched when we tried to match it against "."
> whereas now it matches any directory.

Unless you are commenting on my earlier unpublished draft, I doubt
that it is the case.  

If I did the code analysis correctly when I responded to Peff in
https://lore.kernel.org/git/xmqq4j86g948.fsf@gitster.g/, that is.

There are some negative tests added by the series to verify that dot
is really "current directory" and not "any directory" which is what
'*' is for (and as I always tell my contributors, we should really
get in the habit of writing more negative tests, exactly for things
like this where we do not want a "feature" to trigger in cases we do
not want them to).

Ahh, if your e-mail header is correct, you are commenting on the
implementation in v2, which did not care if the input were absolute
or not?  If so, then your confusion is somewhat understandable.

The things changed before the final edition v4 happened and it is
slightly tigher than the version you are commenting on.  We refuse
to match any non-absolute path, except for ".", since v3.  But I
think even with the looser implementation of v2, the negative test
would have made sure that "." was really "current and not any".

Thanks.
