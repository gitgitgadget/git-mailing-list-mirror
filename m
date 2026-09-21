Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF64EB856
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011857; cv=none; b=kIVntkS7vk+TCF5sihTq6F68kxcDljytq9hQ+XVISdrzm/TrhHNUr3N4DzmWhOqmkzNh/sJWb8wmK36jw8LwIhQGJTPiiDE1J1zqto4jZdrnL81KNUdeJkT5qweJDhdp4cqKUwnRvgbeSruzZPZiLC2siHG9MIVPs+cYDfApQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011857; c=relaxed/simple;
	bh=d0JIUcm8TsZArB3S4lHnOQMbcD4MTF1frXgx3bpMmBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9J+PUC7BoiINQ3qfsogP0PVAdmpsa2xmSjFGXeKXltmJkTO0V87vjeuoMjWJNfG48mknkFt7H4GUbCz2GJV87OnyUFVK+AlwOY0nyuPInrkSuaBHn69xyGcNBoeC/9HLksT/ztj9d7bZ48w3QcMFUyT0u3AFxAHK9yjK0Db1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8QVs8H9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FowfuWRo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8QVs8H9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FowfuWRo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id ED40EEC0283;
	Mon, 21 Sep 2026 13:30:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 13:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790011854; x=1790098254; bh=D/6J9nIXF/
	NzIq+eL7YvOLx68COukpK/owr7bndKNvs=; b=G8QVs8H902/RQPWTp5qDfJZ46n
	6BCe2/HkY0yoG5Tz2hojkql506FfnoBkcQD7DeOJydVZnreHCg0otvYjDj+D3vBg
	IwRjUFyCbUfomNN3c6Q6SJ08esf9QwL1zSaPqtmPhXMaKoGxxcgdJTAaxuZjfdis
	8TeNZ7G/J/FLIOCPzxyaZ/jRsHHDRO6mvlCZzoeztP39r09jomv7t1xL7K7J/t0N
	L4gF6ZwiDHZw5ETm22/RbEtDOP8M3iHxSQv5qrvCheO6482kgCJFVouIglXMwr6Z
	pK6aInZZnmM72kOzZwDWoGX1xg0fT7YLChRxIcUEnyjd1f9rhbbP6wUKzQmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790011854; x=1790098254; bh=D/6J9nIXF/NzIq+eL7YvOLx68COukpK/owr
	7bndKNvs=; b=FowfuWRo4M+Wy78eGl+ZLOBhy/cZmW6QNIC6RZPfqeOKOCMbSJw
	8WIzKu3R9pohQFO5g21jpVpAIO4v0GZwusQNHHhbjmBj9wI0sI6lna8bNVwOpXV3
	4xI9WqLImhEo7G1xeM0PGK14M5p7TD9jFLT1uDdw8PGd4sWLj7y7WJRBKRJv4LMk
	DRuBAnemLyfZDN4wUSrRwHKVwSWfXVQgbkvB2f+yuN2nm5UT6eFfB6Ovb63GpL48
	jwnI/h+8SbyDRZsP9U7JXyH/N+PsRFk3VZ4aYG/0EbOW+6lkCE6ivrREXHu9E9yB
	TwzofKCy63Th2w5gKAlyndctvP4qsvx/niw==
X-ME-Sender: <xms:zmmxao56kWWjz9dolsg1r-F5XmT8SM3wDHqRJd36UyZwreaNzt2Dsg>
    <xme:zmmxatkDZglnfAqg4igg2Er3j24zCFGYB4YhjAp4e4X_7q2-Z8PB3OoZu1AyIwLYS
    dP8Gbe3MXUZrTpePkAPX3B2-mk4YHZavpxNxZ1JLDtX-cxfN-i8aQ>
X-ME-Received: <xmr:zmmxahT0s6r3cBtJE9DC8sn2oTh6Fst51yw66iV-u7CXsfhlYl8fK9rP_lcppRotiuZgQsGnNvBO2qVlUOHI83jLkcKxTTzdhwuo>
X-ME-Proxy-Cause: dmFkZTEMvFQQflfUpCojlqRpLg7bn7pM6+2AELUC2EDIlauDh1u6pYnOHYR6JjCQRb6vG3
    EXqCfpmRmeH9jN+nTgbko4nIZNg2t/m+qz51vxmnKE9//NhBkWiJNvPXIky0BpI+n4Y6yf
    a+p2nCtmefNUWlk11I9ccK3NJ2dpWT5Crqtmwdypw9NedYtYwLUtAfagUSR3eJiT4LLEc+
    ZcyRDMy4PHWJK8hdG4+wauhrL1SAkMfS+js2VGP5Qo0qQH8IjUEZYL9ryz+x10PYHU+blh
    8xck8kBNmc2BDnoNOeqyAv3mA1bMRqJwaas9HKvvsyE6yV/0DSI/INfAHoCTVRMbwqEeEU
    kQwKWrr1DWJlo01QBGE4bywExhReLLbX1J8rL17t7HweVlnuxFT3763VPafPtkVDGnZE6D
    5RpPqNcCz4RI2vkau0IwLLvHS/wy99zG67qyULmGzonnw6QFi/Q96rIjFh9eSVbCOqa9O4
    62fxus81C5zCA/a5zEgEY7jv9eJXVK0RBMYzkjso8gYTH6b3aLDku2y4wheEWQPX49z9pU
    JLu2npNaxzgCVvK6uekSA5/GpMe1wf6rQe/VdKH2dT91+sgMuRYBr5po3W6kzc/JzxnReG
    m8L/goFhNA61ElR2voSm27C4/YhxJRCkjNe6l7GZp9pid4Pt6H0N7P4CXgDg
X-ME-Proxy: <xmx:zmmxakFURpq6-nG4N_M-Yi1cR9UyBgtINcGdaEyCQ-kyHbsNX_44hg>
    <xmx:zmmxauEUBlAxVI1ree8vOxe6-QXbqZXPLOKZTWjeH64ct6bXbCt9Tg>
    <xmx:zmmxaqQo9XXbfQrvh9RknGj2KpcTvmCE8KLbPqdEpEuLWwafFGnxpQ>
    <xmx:zmmxanIcHjltX7WANf-TP1qQZcDTI5Ygd0Z8dvU_nYvR5CDyMXFicg>
    <xmx:zmmxapotYGpWxvRUNkvxmMN0LzCRq1KpAX6zQqpOs2qHvki483XLxoTR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:30:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Nikita Makarov
 <n.makarov@yadro.com>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] line-range: skip trailing empty lines in funcname range
In-Reply-To: <pull.2234.git.1789991377413.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 21 Sep 2026 11:49:37
	+0000")
References: <pull.2234.git.1789991377413.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 10:30:53 -0700
Message-ID: <xmqqse32mrzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/line-range.c b/line-range.c
> index b99f0d9895..44b52d4e34 100644
> --- a/line-range.c
> +++ b/line-range.c
> @@ -233,6 +233,11 @@ static const char *parse_range_funcname(
>  		(*end)++;
>  	}
>  
> +	/* exclude trailing empty lines from the function range */
> +	while (*end > *begin + 1 &&
> +	       nth_line_cb(cb_data, *end - 1)[0] == '\n')
> +		(*end)--;
> +

While the new behaviour may mean well, the implementation falls a
bit short of matching what "grep -W" did, doesn't it?  Over there we
treat a line with only whitespace characters on it as an empty line
that we want to ignore, but the above code does not allow anything
before the LF.  I do not know offhand if the above misbehaves on
CRLF text files, but if you treated a line with only whitespace
characters on it as an empty line, concerns on CRLF files would also
disappear ;-).


