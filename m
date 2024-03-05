Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C412D1E4
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676347; cv=none; b=Y98XbqY/fwnxsdhWnmx8gHVXWQ603HeqYP9Cg71gyfjTLxLR7aMwfzh07/EgibSb0O8+QvmoKdyamqWNHZb4Iy9cmjwhXkS6V+b3isbWa+O8VAipS4nGviqukIYlVeCtjz5nLnybYb4YSUXJ/Yx6dwJ54lFVlx9nLwmaOFETg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676347; c=relaxed/simple;
	bh=bhb8yKPom7+AWYop+nEeq46uxDzuApzdPf4kKHZFQ2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W2zd318zgX6Va25J/LpJVMkb6uVuOKqyZpz8IRadLiZFbKhnmrc5Idzl64LA+wdyIjbm5GPbP9cv0AejtGcZXqYQaRHjYcr05WnaOEEAB5SomwzAno0wMx8IG465No2F0OVUzSpcGPyHR2Z7T8znZgT1bDTKo8B8SsiDD+LqaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VhdiU3vC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhdiU3vC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC6A11DC381;
	Tue,  5 Mar 2024 17:05:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bhb8yKPom7+AWYop+nEeq46uxDzuApzdPf4kKH
	ZFQ2Y=; b=VhdiU3vCqYrN7RVfYJHiEHmYC9n3tQ7yNgx6ryJuvuLmxQZqDkb+/u
	aNbJRpZnUN6aAlaReGp9liyp1CFUCSxttN6rWQRCaVSouyy27UgC0794znqn+xCg
	iX13zveFSRygkEBB/K5apA8pdssRwm8Rb4sh4wfd7xh6DRfpBVUm0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4CAC1DC380;
	Tue,  5 Mar 2024 17:05:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2706D1DC37F;
	Tue,  5 Mar 2024 17:05:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Alexander Shopov <ash@kambanaria.org>,
    worldhello.net@gmail.com,
    Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [Improvements on messages 0/5] Disambuiguate between options
 and commands
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org> (Alexander Shopov's
	message of "Fri, 16 Feb 2024 11:15:32 +0100")
References: <20240216101647.28837-1-ash@kambanaria.org>
Date: Tue, 05 Mar 2024 14:05:42 -0800
Message-ID: <xmqq8r2wz64p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83426482-DB3C-11EE-BA6B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alexander Shopov <ash@kambanaria.org> writes:

> These are nice to be merged but this is not urgent.
>
> Alexander Shopov (5):
>   rebase: trivial fix of error message
>   transport-helper.c: trivial fix of error message
>   builtin/remote.c: trivial fix of error message
>   builtin/clone.c: trivial fix of message
>   revision.c: trivial fix to message

The first one got commented on with a suggestion to drop it; any
comments on other patches, anybody?

If not, I'll drop the first patch and merge the remainder down to
'next'.

Thanks.
