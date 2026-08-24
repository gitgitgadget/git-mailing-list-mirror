Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B933822A9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595825; cv=none; b=PEgmbnlRGwoczc9nZGcZpccvRdOHV1GaMWjttOg96nc/vt4Zwr1FykG4/kX4aZSbjvRElCSigpYPae2jK++o1lACPhQk6lzUkCXd4q+fpDwEa/CeeyTIA/frhn+xHMBrdZdgkhBwGb+YMgVPR3M9DTuG/8judGaZIfPL5OHwZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595825; c=relaxed/simple;
	bh=X8LZMgZnbwCQzEnbdbfs7pI61vPWb5GFDd7HLsswswQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kK+JfnOvzc4MSWOxoAig30KvgXm44vrpJCYeGtUJM6Xw8wL92Qd8l6AOcNrip8CRpuKDtT78o4E0YkdconyJkb155svhbrx+nbR5TiY4+QrFjhmHaKG5w2JrpfghVz82a62/N8oH5v7EOVkz/7EcqQnqfC8r4AOcNlvymDNV6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AIOUTBvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ih9N4ii+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AIOUTBvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ih9N4ii+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8863114000E3;
	Mon, 24 Aug 2026 14:23:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 14:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787595822; x=1787682222; bh=uBmr5UVkLU
	606mv4TwUgtT2mvKlXQB//mfMa7tCK0cI=; b=AIOUTBvuHwbaIygn0JB8ZQ30Yl
	VKUzCm9bo9p5LI+pgZckZ/cknFOqARrcCaOatzOfRh4JCseu1xjBfiHbko7WHvQA
	ei3gaerbBqNaHOrZDe8db0dFQxeXtG1Ifry9m26VhYxbI4/A/xk0/KPojF9C2nUO
	CuxUskgSj0gAzpiwjJvl4L301QDGzzAAJoeMbVaDE7mvpWcJ+1j1IL+aTtjQx6LB
	/qndXVLingmGRJ9Um5GZnISN3RMQp8WbL0Ns82XoOuQzjKgCow9RXkFplsKO6YVd
	RH2+SJW8GXEXhuxzywyv8WM76qiCaxiJdmAyY6t+5L2XCRY66/ZMz23jaXOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787595822; x=1787682222; bh=uBmr5UVkLU606mv4TwUgtT2mvKlXQB//mfM
	a7tCK0cI=; b=Ih9N4ii+ynqx4FZxD/gjZI92013VzMgGTBd+L+cgcQ9XNFdirrT
	PZK7qQARt2XsfKCeQ0Faj55Le+JGFLxiC+HeVKfimJu0nUF0pAI+qxcyCLYFlwo5
	j79LxNckhpn3Km0e+mAkCec9ikEgzUKDGNnvSRyzhjEkyTXqIPI6NdPr7XdAbrUv
	hrsAlcdRcjsrIx7edU2wDLOyuRQ/b/9giLO/a72PeFVnNeamfCkNwa1NvzgzuzYQ
	Fwa5eFjwqd5MZB6ykXX3s0MZK+nd6XoF2cRDqK/1MKovWoCX30vsDB+29ZxPWtbh
	r+5qGcRxFNuzPkgcJavO+Vcsrh8amc4uweQ==
X-ME-Sender: <xms:LoyMaqux1Pq2NwuidbtjYsfmvGX1eg8jhavblcG9VYDk9byXCkwL8g>
    <xme:LoyMamUuABNwObTKeMB7khDBekiGW0Z3S-Rrvdmp3BXtgVbkCEBX9NkYW7hPNQV3c
    IO4eBmjs7Qror7XEcXRMtHjnZW-U0hTrGeIpDY-EW3_M2dKe9o2hA>
X-ME-Received: <xmr:LoyMauER8T48pi5qkyEzQyj7CegJLR460FiYXg6PzLqQQzjGpGNLVVq4rrkeMJgLYTswy9JWAfSHIVh3jMnwPAwKWYIi5ZwE2g>
X-ME-Proxy-Cause: dmFkZTGDqR2vT6oWyrxZtigzFywvMXf0TlhHebLxEkM0gLgJM7xmrmbHMomA0Y9uxEEYQ0
    DfK5+1F8UV6GYeYDHeVCf/F043uh7z80sqCBe38ISzhJp1QBwpo7c1MV0sW8+vZUdSERWj
    I3/27xEdVUw+C/E+/rUMGlsiahUpCt28oLM7l3mesTMICOUQ+p1MGo4kme34EetcPKmwZX
    y5zZszzd/2MJrTbgTgNZ20n8prjf3j6FyQjyuxoLVvjwxbUzNvPzGv/kmDWFrEr8f6Y8s0
    8Ibx34dXf8t/ict2BHAzKYTh3GypiRf99lkSuGXcU2DLiKaL9vFZAGhoOfjnBsMXGz/CUo
    jFkzXg3OPaSMdMIHQf3U1u9dGaz+2QhW0hsX7PHuSQW8vdVSKQFpooWux3WMdkDLdEV4B3
    fN5teLFeol6+71hp3s8Rg6RJQXn/OSnyi8KJ/N3e7/iRXkZpuM/X+NFy6ST+Vl+tUF09eY
    EpshJMDQwxw/ExWTJdlQj5aACNoJ1fYDtwyO5QHRU9rIYlPW6gm/ALtNP6QjE6vkOUjajE
    tK+l73oCVvJqKEjHhGWT919FtH6P9mQwjOs2fgAX2Oj8qk/zwyLLjOKWebGk1va6Iw7xgK
    QIau5km3bNwfo+dB0RsZsCvJ9lX5nzsyIU0kr5K08L4eJgSMUlmL6yvMIHDg
X-ME-Proxy: <xmx:LoyMag3twYEDWAaAwFRuJl74icq7zq79tiAe-5pomN0MLKxt9mmucg>
    <xmx:LoyMaoNZnX2vwbERYIoTgU4FzNHMLUisdbuyQOSjKECThE0nEp_OIg>
    <xmx:LoyMan4oK_0C7xoR5IZ24V-7mnNvsfFg7UMCcBoW6DEZGMleDump6w>
    <xmx:LoyMaq25IoAVo_3CErbj2L--an4lBLRS0arg0Q9d0A6leuPZfafJ5Q>
    <xmx:LoyMaoFBeTr9mwoPOCvLdwgsY5t7KqsHGnNTxOgiue_jkJZbOd6itQtQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 14:23:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet
 silence
In-Reply-To: <aoyBxOCdAq3qeAvW@pks.im> (Patrick Steinhardt's message of "Mon,
	24 Aug 2026 19:39:16 +0200")
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
	<pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>
	<aoyBxOCdAq3qeAvW@pks.im>
Date: Mon, 24 Aug 2026 11:23:40 -0700
Message-ID: <xmqqbjarqswj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm still not completely sold that this difference is intentional. As
> you mentioned elsewhere, in one code path we use `exit(1)` and in the
> other we use `die(...)` to print an error message, which returs 128. But
> that to me feels more like nobody noticed that those return different
> error codes rather than an intentional difference in design, so casting
> that behaviour into stone with new tests feels wrong to me.

I tend to agree.  The choice of 1 would have been more about "we
need to exit with non-zero status" than "we need to use something
different from what is used by die()".

> I'd suggest that we either:
>
>   - Continue not checking for the exact error code.
>
>   - Adapt the `exit(1)` to instead be `die(NULL)` so that we have the
>     same error code across both code paths and then verify that both
>     have the same error code.

Both sounds very sensible.

Especially the former to avoid overspecifying what does not matter
in the end.

Thanks.
