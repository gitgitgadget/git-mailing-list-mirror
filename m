Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474033F39D7
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272975; cv=none; b=Cg6vM78hqBHMsA89yp7DY0kDSWK8O3Q0yZIgZwW/gqOuDlbWrv0RFjyc7e4ixfzxDPrT7lY6/auO0p4IekcX1FDPXQ5aTzrefRDRisj8tc2kNf5F9RzLAgnRuBDK1wZhb/+j7HlawLApGiRSVyA9o87c8m9rNiNvZoSeJrLog6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272975; c=relaxed/simple;
	bh=RsnIP3AEzcipDOzg0WpeF8KPou0MwieL4jY66o8H2Rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEcdolkYILfNzSJ55qw6I6MKb3KFU9CMgMgra5IslD5iGFmomWbzNWcY1r9XacsN4JHt/zZGC74ytCMoOLergl+Sfwzi+bmJYNcfWI6xVwiKPqLjaF+r5y+HvkZuljHgz3ZgcAz2pAV4qWci85M5Zw2A64SuQkmWddqIVLIR3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r1V/5hNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVxhVUmj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r1V/5hNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVxhVUmj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D04BEC003B;
	Thu, 24 Sep 2026 14:02:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 14:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790272973; x=1790359373; bh=HW54LM0WlQ
	6rMuQXw4t/YDxLak+10eOx9ZKMdAlc3GU=; b=r1V/5hNFBsV+jhBZotpWYK7HCD
	+oG9EMiSJkE1N/1AhhyVSTM7qv4ui+a312d2mAQx/L7+Dn70XZ3n39k0/lbH472k
	wqSK2TaZm6Ft5jHFf8x50DAN8OYV83s8WxNsmVLRASXkGqKOlKXU59pVYTWINVGY
	pHnqPxjy70erNcdsPbLfwWJbQHo7OlmTRr2BZ810502Dexe3PG6NUWH3zUxaaENL
	Vf2/zAspwkXaZvRmamI3h9HVENv3Ef4SMeKvuRbszB1mroUVDD5cJQGa/swWCyVI
	42pVIsPqkFKOQhelgsRe9szCHTrrXiXe8BrFaOxUTKhTHT0XKC4X1DYFaDHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790272973; x=1790359373; bh=HW54LM0WlQ6rMuQXw4t/YDxLak+10eOx9ZK
	MdAlc3GU=; b=eVxhVUmjLkPh2n63pJYLnB/+/sZ+x+5zsTUC/ncwdNWNCSHccdT
	KFCZrpGXCmQ3mudwiTsOUi7Mg8DTyao8mJGIuB4is5MkWOWhk6zmQiFdRQpmedsG
	RAdQymUvuIcWcujmtq89DFyr8YxM9vjflZNIxwrtVlWew4IGD0a58WNoMBB0Is/6
	Ujsd+o0hVqvgy8daMBrF2fWGcPpHMk2u7zhuBvVafqRcAsn8VrEnmEEuN4rd9wDx
	/dLVu7J7IKo6i1/hPGzSTHh9PP75vD1owjIcZF1At7Bspx6duaqFwvIBCl9VSgdi
	hhQpzxL292Ipp57sdzIEpTYdu58+zMUUEqw==
X-ME-Sender: <xms:zGW1ajdws9B9JCHIZodOqeIVO4BHDzh1KMSll6PS-OO3Vh8XkzxE4Q>
    <xme:zGW1as5yXS9R8i_EAXGeMSp0WoUydDThGvKbL-SKrS25bUtn_2xm14evV4Kc9WYVW
    RkQZu2pi7jq_1o72ecFjoTuEKlVo77dDBm1BEs2-mawuYnI9WdqLA>
X-ME-Received: <xmr:zGW1amVQmuLGe4UBdxnM_Bkg7wo65HiZQ7ZANPg-duuqDJwRwPUDe8xp_6uqGPo_0AciqQkbhvt8FI3fMVvcmhQsUz7QP8x9VXRv>
X-ME-Proxy-Cause: dmFkZTElEYcPuHd433iWjPkOba9fwSC+BiCCaOWBUfyvWI1LPhGA+FzpiPdVNMLz2HF1Ix
    HOK83vVncniBzZf3sgFIn7c6XnQYJO8aCXMF0ehQ9eznoPRq9QyPoWSiq0+oBb6RTHr5dD
    7upw5cSX43rcEbuenB05kBhy6sabt5phZsnlehYyZ4DIHJGilA5jzqLTjspVoPGVbcFCOa
    m3Mw9imtozmAr+uHzYoKv+8+VqSQHNun11ua6dMV4ktl9Jfb3hOTMhPX98joFe5BjUqE++
    xDMY+tHZvlJBsAoG/LFZFE5VlzjJ+tSdpS3V8yRehKPzwz0Nxxxdci+EvQ2X6Tecj6vOVi
    r4W3qnUPcWZnsCTgz9WU7QZf60nHWVjnLAcy/qjQrg/3OtVHIDQjbwVBRnQS5Fy4451ScJ
    zcn5K4G5jw6CmHpgWN8rA+jnf5lpLYgI2TP9yJxm/Ly9xYTe5wbqfv9gBCLIGhKcSLEk+z
    i1HnrWbs+bGmi7MywPjCCw5osPvDcddD72uDQ3m2QmJhv7udUOjh+mqBPP7kwq1SvGo8ZM
    PnYor+GnR4Dzm5gopN5mknB0tQyOi4OZnFaI7Cjn+mAMze6Zo5F58Pqrv7vM0NLilRoYLh
    dBSmrmh9196IBVBc9/D16Mx1eY1AhcekKTJZJhEHhLY1V9j2u+iINqhPzGcQ
X-ME-Proxy: <xmx:zWW1ar5o-LZra_TC9s1wagrKAzsgha-OT-6juIfBIYgWt0jkolb8_A>
    <xmx:zWW1ahocfc8XY1fk4NVVL0zGsgEvIK-T21aPT8ZJ72GbAuHTtTHfMw>
    <xmx:zWW1aulxrMJiiDBzNdmiIDBBDMX2LgpaQr8uGXPJ43ZJCqlhLWXURw>
    <xmx:zWW1atNMmPADeqHGZPLmXLr-yTuan2AeQ54nQwDsEPH58R0SqjHPXw>
    <xmx:zWW1asAk3ziTJNEgsZ5xeWfdp_TLg8a7_zh1ZiSEC3egvbWm5ZQ-mybq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 14:02:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
In-Reply-To: <CALnO6CA5b7mpia9tkiOENdOKcOHF4errc31wuF5n5-=rrbHxVw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 24 Sep 2026 13:10:47 -0400")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
	<xmqqh5jhfbyw.fsf@gitster.g>
	<05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com>
	<xmqq5wzwc76w.fsf@gitster.g>
	<CALnO6CA2DXvyOO+fu04sozg2=E0JoymAqyhs_heHzExgRSEzVw@mail.gmail.com>
	<xmqqbj9nagt2.fsf@gitster.g>
	<CALnO6CA5b7mpia9tkiOENdOKcOHF4errc31wuF5n5-=rrbHxVw@mail.gmail.com>
Date: Thu, 24 Sep 2026 11:02:50 -0700
Message-ID: <xmqqa4p634tx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Having said that, I suspect that the fact that you have the
>> shorthand 'second' (i.e., you have "[remote "second"] url = ..."
>> defined) may be a good enough sign that you expect to keep
>> interacting with that repository, and some people might appreciate
>> it if
>>
>>     $ git fetch second main
>>
>> created a remote-tracking branch "refs/remotes/second/main"
>> automatically.
>>
>> But we cannot suddenly start doing so without breaking people's
>> expectations, and without a good transition plan.  We need at least
>> an escape hatch for users to say "No, this is a single-shot fetch;
>> do not write the object anywhere other than FETCH_HEAD as we have
>> always done".
>
> So anyway, I think fetch.<remote>.refmap is the right thing here, thanks!

Ahh, yes, if we introduce fetch.second.refmap that makes it pretend
as if you gave a --refmap argument on the command line, your

	$ git fetch second main

will automatically do what you want it to do.  I didn't realize that
it was the implication of what I was outlining while preparing the
response to Harald ;-)

Thanks.
