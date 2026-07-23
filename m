Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025542F693B
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850505; cv=none; b=PUl08l+ccKCeFaoA3O4Hn4RcDHQ1AnENjcHDNLteEAzH3iJnVNfdV9S1OgS9CZlEuLcLRr+0bo+xSdb41Qx0ZtV6Af+onq3waJN0dl58baKBn0d270MgX1SpowQVESJ3ffGmngKtBeOFOXoNpIZlLczaELDLVbqJk0vh04Naq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850505; c=relaxed/simple;
	bh=IEBIa/TKQPw4rFR9p+N1N28aRJ20doVFU0Z3BwOl1ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9y7Tc+EuC9R1jmVPKiga1cyebwaIsfi6luIixJr3QG7rpevcHhR4sWukY8ihz3jOId4SBCTttvdG9GgohJ0CPFYsbzYvDOeJC0d0S/iFxgXRaJfusFVdUco5OukAJ/DZ+GyLMcAHbeMwQFy0D3oprv9yiTBcxDprj1vTD6SEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iOvW0s7a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jsm/pb+m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOvW0s7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jsm/pb+m"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AF971D0000F;
	Thu, 23 Jul 2026 19:48:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 19:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784850502; x=1784936902; bh=yXgUOc5NXY
	Qr4oi4uCPGDxjqPqz+4KO5WyLIeuPesuw=; b=iOvW0s7a3FJga9jJcjKfI1kETc
	9foCPftrZeGLKkO4y6/51VqyOlsYFoawWxC2V6dCTUUqbosh25kf0bUe5h7t/7IU
	t+DeArVTfarUu3f6eGWUbSBACxRMoAzMQyTw+7r7t4YmC1VOiDB4jzFMbXVrKSEI
	eXIHBVuIHKpWI3B3v4GruyxRgGEjtNBKE5LOxGaC406qRe1aBAdAPlD+ont4qthn
	eszUlhlroVzxwRg/q0JR0poKxG4tUE6NmreMibwozssSyoWbhEospYyshS29FJgU
	8iLzqDXwm+9wNVn2k0lSKoXfI2zgvZgkckqgvbJKbbkXCqQjQTPfF8I8lpYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784850502; x=1784936902; bh=yXgUOc5NXYQr4oi4uCPGDxjqPqz+4KO5WyL
	IeuPesuw=; b=Jsm/pb+me2zTuuSt0AvDVhaYXCqyih4oIdjmZXO8Gd4RLt6jZ+p
	b3c65dtTSJfVkrEB17lN4GcFf8qQbhNl82QBEKvBdl5AHb1QemavgtYQpYZ23bvf
	8JVWlQnltb9bt1rsPKLXgEDsNvsVDj4DHsvwVTUvIniHwqr+OHyNm8HvJFvUTBXg
	KRumrKjTZcEJbZh8dDIDBI0PhicS9gvro74BHDLVIdcSd3dpTb0Il6Q5bmwlWYqC
	w+dXpVgqMnw04Jh/v6oeUf9vJ/h+yeFReGSBSNfkxXqzS7uAo+rv/mIxZTfqVmY3
	Q8MB59d7qcgh2O14JB4ElgkiklT6QTbby1g==
X-ME-Sender: <xms:Rqhiao-eTf7krlXv1pfPad6tDnOhOyNjaK2IRKdhVXKm_Sp3XdCGoA>
    <xme:Rqhialqy4T56VWzVuMjgvT6fGyvnlcKBDdv3vnRqP8CYbKBVlwAl5smKuK2CAKN4N
    zDlSwQl-dtkeh-fmMS3bGOnmucNSGwvIyMNDOh-NW5LajmC0X4hLI4>
X-ME-Received: <xmr:RqhiaiT8zYRBpD0r97JiRJjc13JbOc3YGD8DMs7Gg_5q3kCaPS6OGe9h581oA-8m9-Dc8vQSkubbit6e1FJW2WzzTAyqf5hKAw>
X-ME-Proxy-Cause: dmFkZTG0971/8VX6rzZZNDAUAU8hnvihNZXXdGJNnKagYmsH0oXG9bFOo8rdJuvDg8qarQ
    qZSA2oc/bZJx5dkd3nUMm73mgPRZxnpkgFlUZRRfkwSgB2yioGSHtQ/LQH8+i2WdCWUluf
    FUDpsLVk3sulyYozShb0BU1c3GisUV2Ez8n/RpTa6CfVnbg9Y7Ul82b0es98e/nls12P29
    NF0ocS8clKvGdpZZeRCUydQNi84rekMKrQIS1kpAFYak+NwNXLoxt+eI82qcpK8uJgH+bA
    9W7MCNFL75En6kESLVXraGWmmBp72X/fOq2v+fYwZTjvKKoklDj0Py0LY8x1Id+PJYSbeJ
    lpHVM0dtc4aNRem2jJJLk/7WOomPteOpLx055tv94Bal+Nsr4bR6FMbVFBY5b1Ajzt0EJI
    4mufoy0vt0bWGIHBcTVX2TzCP6ZZoKB7PWAT8p/iqUHi5hxsfRRKvjEaigWymaf6Uu7bnL
    ZkpKbI7Av646KLeYjPJ2XsUkNBore/ZwsK3DRRes7jhHYXYG5sSqg/B65inTxzraZDJ1GM
    0n4DTD15jZs4/vYl3K1kv0DzIDzR0tNnNGqak/Vtr0hV+3Gghv4fiyzGM+Q69pkc+ycmBu
    /9arXN87cJW+PqqfiQB/SrqznHjcFAYWslnAMitqWi4IXY4N+IcBYwFawiKQ
X-ME-Proxy: <xmx:RqhiaoNpDldiNj9eTsagOhfjTFoaOqGj_AaY9O9JxPtNW1FYnEBQog>
    <xmx:Rqhiagibuatmya_TejhT-tQdaKrGyzMF4QjjK0sIP-Hyo5kOTIZ6mg>
    <xmx:RqhialkZfDJvLc8nIMym--bqSC2PjEB2tosfOZsIdFQZlGMSBsIUFg>
    <xmx:Rqhiasj5Tv0osV31QwQw03zJK55D1mWOTePGMGLgrYJtlNPpTO7ZqQ>
    <xmx:Rqhiaj3_s-7AphbEfjyZ8yWe_SBxZktdXbQfYa02jG6CelO5iSO3ooAa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:48:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v15 0/2] checkout: --track=fetch
In-Reply-To: <pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 24 Jun 2026 21:54:56
	+0000")
References: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
	<pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 16:48:20 -0700
Message-ID: <xmqq8q71clob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Extend checkout --track with a fetch mode to refresh start-point.
> Changes in v15:
>
>  * Reword commit message to lead with motivation.

I was reviewing the draft of the What's Cooking report and noticed  
that this topic is among a handful of stalled efforts going nowhere.

>      +    Forking from an existing remote branch without refreshing first often
>      +    has consequences: you start work that has already been done, or you
>      +    build on an old version of the code which causes big conflicts later
>      +    when you pull. The workaround is two commands ("git fetch <remote>
>      +    <branch> && git checkout -b <topic> <remote>/<branch>"), and when
>      +    the fetch is skipped the checkout silently starts from a stale tip.

Automatically updating the tip of the remote tracking branch also
has consequences.  It might be fine for the current branch, but it
would also make the other branches that forked from the same place
go "stale" and without the user realizing (e.g., "git diff @{u}"
while they are checked out would show what the user does not
expect).

As long as you keep calling this "workaround", I remain skeptical
that the merit of this proposal would outweigh its downside.  As
this topic is about to become more than a month old, let me mark
mark the topic to be discarded in my draft of the whats-cooking
report.

