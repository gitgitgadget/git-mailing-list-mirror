Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF611A6830
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331562; cv=none; b=SxnasLOYZrFuLo5sWWVQsQ8495P/JkYnkVWWOXlgFdnfTCqZcKH0e2WeTZOWH+dq69+7EYIaIMaHYK3h1DwDtqVioJ37LuzvjU7dXEMr+Xfy9RxiPbHF3Kq8QhOgs1E9ActG6lHV1SKJFN7AV1MdYtdt75hmlJHtzDJmM18K0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331562; c=relaxed/simple;
	bh=fTaZOqd1xJu998/VsdYAvJxGkvV4SideVml2qqEpmP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEjHVn3XR4zQmpdiCBIcabZ/k4H7EyVI06HN7eX+jQGCxrZCnW5LOCo5HYfcKhKy42jCw4oJEiraVkojZuf0YeaeXfTNWLqJDovEnDa9cLweiDuOBb2zU+ftGjqz2i7RafNstNaqWw+hiG2YpbuP/M6FXANtdccSrMowLdaEKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVE5ktzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isF/qlCs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVE5ktzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isF/qlCs"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DDAAA1D00133;
	Fri, 21 Aug 2026 12:59:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 21 Aug 2026 12:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787331559;
	 x=1787417959; bh=fTaZOqd1xJu998/VsdYAvJxGkvV4SideVml2qqEpmP8=; b=
	wVE5ktzyxgPM4v5SwQsFO76JDCNShoMHFntdwudDp3IRbiZO/e3gzjQlxvlVINf8
	j2VfA4n2fJm24Z88jqizQfePhW05jOG6H32qdxUphmU06jrhyVxY8a35ZktdnC0B
	ABU3AGyaf+5LRSKPRjX8VjL7Meb7jjfxqD8VdqIJ3DxR83i9efm5Hpgyv5+gecyE
	TH0ZKyFhN/l+HAxUym83+vd2EuS1u7xLMbwmvOFsCIM6ze2F851fyKRQm/p6e+4q
	mHqsInKYj4Bgh3EvWNz6NMZYkRbJ9QPJvPf/3fJrMl0i4loqeoK8WzhLysT0oQn9
	RJPMQ1cs2s2PfOMbXbnBpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787331559; x=
	1787417959; bh=fTaZOqd1xJu998/VsdYAvJxGkvV4SideVml2qqEpmP8=; b=i
	sF/qlCsl5e/0APa7aaUOZlMWKOYRtsPAYtEUmpUSv1ILCX+ZmOQPV2nvChkfRdeL
	BJ5l9em6lTXaQ7f3EYUOeDHuFYKrRj13aVEcLbSR3jIRugs8jz6mnx3/2743xm9b
	ybT6U6kCEhN7VNjiJOTf1hZEmwJ/kWetq9urWKdw5QHPezXZtsxsRYbyroyI9scK
	HYdA+1YnfByLww1WvAM2Jv2kmjfdsPT7EueS4zO4JxIjQ2CXCl4BhTd24CHcVxe3
	wdl9i/Gp78aC4mMPbO1kq+phW32+Z4uE6QpK+f82UhDqvdm0WvGvGkXXGVh9Q3xi
	FkNbsecZk1G8uTixgc1jw==
X-ME-Sender: <xms:54OIakWbNNw5ChKuoAEDS0H23Xi1WJyor9CXN6fl_BxnP8TyOo8qOw>
    <xme:54OIavcArxrgGObUyII8Qwda2mJ_y83Ei1TWBhYCuvb6UmW9v4OL8vBx_ieKpgKnc
    neKnriWPC2Mzg0NoaTl-i1Wa2dWDt3Bv1woPE6uV_6XNUhijFgO-EE>
X-ME-Received: <xmr:54OIagvmJ1AvuQXarqzgmoIggcJf-S15bPXGFGKgZL0_k_DyCxb9rDk5HvPDRvowPLNMOnCNDOOBo9gE76dhxEvBzswuIA3vKw>
X-ME-Proxy-Cause: dmFkZTE08QciQFd5PBABAZxSBbp7BeljzWQdBQPvg9kf5QOp6i2s2UrabVDISne6nfSecf
    gA5Dys9QjTPR6UPh4XSyf4Z5XlmzIYLCSiJKTHcqpNfpcwPS3c9dv0jX//qXtkQM6EjPG1
    bb2ReW1ybZdEV6OpCu5BAuZMeEHbr5zWbhaUidNVMshQl83WIazfb2ZYiUW1F80AqbJ+m4
    pkdr23ibaCPdSaUZQ2YQifrHTnxwGFyS0kEm8N8jq4LIT73XK7yGveuTFb9T5VohaugYSI
    fttWoOv56ys3CnLjHMpf9C41CNQLp69CiBkxFarnWKsO14t1j6N7CDLXI/iXcT6Zu/bYdw
    4wU2VT1wAJEwK71bIx7Br19z/H4Yj84PvVMT7ECwv2zwVLt5oIPPO+s7mCvHFduypPdAtv
    XjPXdrDEV7nsum90TtT7eQVPYVMypyJQxugINF94bV5nTY373hJhK1NkgQyxsStwEopK62
    iY5e73/EEJdoBubnEfX+zP3vCkD/WvQxMEJw246k7DetRCIsmiSgeqFP8xdvG2dqgAbxwQ
    j/FbsM3XeQ6Dih/dh392ITtsWy9A9YbFpkeh+230paykaR6HWfI9dKGYpRHMERh6rcmH0Y
    o2Q35Gy7rGr5e8STuM+O3YSaeQmqIyTEt72LbSwvvHemLlzyBvU/LiN86+3Q
X-ME-Proxy: <xmx:54OIau_-bxsmLt_Tvh04XiIzubiQsXtWR17LhIM_5rwfqfvjCMHkQQ>
    <xmx:54OIar0CJMnxTmjkA3PoIQ5g05b7SE1RBYvHzKtGA8zADD1NJ86Hng>
    <xmx:54OIajBSA28msFlby_CRZskCO65573VwyVd-Y5F_9xNzq25b44fu2w>
    <xmx:54OIandmuvqERE8j6PgHFq9p8uETsvx_Bb6ngn1PS47HasD1Mv6HQg>
    <xmx:54OIauPBmbDEukNmEsfDHjwcZ1VCqKuci4wHfilnHIWUEehN3rdfvagz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 12:59:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch 0/2] add unicode support to git repo structure
In-Reply-To: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 21 Aug 2026 19:23:43 +0530")
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 21 Aug 2026 09:59:17 -0700
Message-ID: <xmqqse47pfyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Currently, `git repo structure` always renders its table output using plain
> ASCII characters (`|`, `-`, `*`), regardless of the user's locale. This
> series introduces Unicode box-drawing characters (`│`, `├`, `─`, `┼`, `┤`)
> and bullet points (`•`) when a UTF-8 locale is detected, providing a cleaner
> and more visually distinct hierarchical output on modern terminals while
> gracefully falling back to the existing ASCII formatting otherwise.

Generally speaking, Unicode box-drawing characters do not work as
ASCII art components as well as they should, because terminals often
do not agree on how wide they should be rendered.

So I am not very enthusiastic about this change.
