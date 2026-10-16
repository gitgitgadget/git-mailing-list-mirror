Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B24494268
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176772; cv=none; b=VKRs19rAQykcDtF8w0NAtyJtKcrNk1rnUQgjMDdwBzJ6Vd0uKwB/qbsk2cqWOgPGMRJv9SKFlk/kJZbNzLZRpKaViq0Wr61KIC98nZ93i8puPqXBnrR8hO+IBkpdlsyacfcCInLa9Baml+kohQryIn6y7eD74BVOOHyNYqm0k8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176772; c=relaxed/simple;
	bh=7vo6X9OjnFLbTreGv3kGRCjfb9ShGOhrWCVtZyjI2p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iiSaNOcOl2iH5EoI+ZPsHYdp3GIosJosOhlxvicowBt3FkI9p36Nd/P1DGjS+W9usKT7E+FzpD8aEsAJQ2kV4klZ5ZLreSXMwrgpKAPsmDUTrXyWM/9zKSdUxXYZWJHGKP9lfxlJHN6Jf0aOOUpdYnhLd5g0+qEZSw5/MpxBZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KSSIoENp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LE8tPWUz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KSSIoENp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LE8tPWUz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BDF1140008F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:52:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 14:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792176770; x=1792263170; bh=7vo6X9OjnF
	LbTreGv3kGRCjfb9ShGOhrWCVtZyjI2p0=; b=KSSIoENpUyCTQYSX/sOq1PBAdO
	5BmrvaaNwNJMEtLpL+Zwf27nkYC9z/NuVlh9lSQ1/Ofw/DTPbEQjs0OiU/G9YBVj
	NzLxEAxPJ+EuAsxA8dXCJmwnjfd1QQd64T0R5ytT85EO/NCujCZ7hcf1l0Ls2eaK
	UaspH3c/ph778jvfdifN+uPm9HpOiNj+OnNKp6cEvbL9HojhyX3noVygOIyU5U4Y
	tua/7E6++MRjQ9RfUBlzPrp8cr0AbY6v6uxTrcb/glLz1zecxsKnbhw4ioMCmskg
	chH+9n1UN1mF2m2tsPTLXpiZI0MjVrrKtYAuAv+J0drg3o3xpShurnSe6lnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792176770; x=1792263170; bh=7vo6X9OjnFLbTreGv3kGRCjfb9ShGOhrWCV
	tZyjI2p0=; b=LE8tPWUz2ym0uZcqzt+fk8duP5HRnKX6FdrrxO2jNMsrXGKsSK5
	ink/KxylqWYlBP0CkSZXEcHq9torTBt8oPy4w2+aaw6GDfqrMrr9i4lPEzSV7kMc
	rjhLXdmnLTi3TbPofF9JwI8/H2QAClMOgPuxUWYn06JNz4FNt/PKcEY4P1sc0r9K
	mj1APxwUNwshRRRqNm3F8W0QSVXLmj3r1GewGLn5GD8rpBjVdSf9imP96riwQa/X
	sbNt7T6QFaB/qWlf/3vzqGxnW1tgW0Kq7DiQO4qjnT0B2U+qlq21uc0P+s5hhTJw
	41ImAHB7leRe6Ox0qsWbYKg+ArRckjcK9TA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792176770; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Gk9RzW1lBc0xtZ5NJqnPi+olL+Q5Ck8d15LhWPX6i5KQ6fn
	DzfwcrEuvR4BP2jmmEzLKbNSogo9wlaLZGDsxm1h+SXKkM1ocjfw7WhoIeLYpcir
	R6OgE6g+UKu0EQdeluFGSSTHGtEJ7rszw16NO45BBjl4pmU6l631/4CgyrYueHle
	7ltxX/R3Hcxy8i08jbunx6lZShYX6k+3NRGN1NN+TIXfwZT2SlIrpgBJ8Fmw+cbu
	xFPNA1INQXn1sR2RlppeSf89I2QH5jgsjbC2q04sqxoGewUkIHEgv8U2VkpXyZJA
	r8nldI0/klZRSvzNE5XJmUfgvYYUj4LC2KCXtOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:o0o2NgqPoq43Jr3UKuB+6Pmr6sgFmOcmg6lRy4zkoE8=:7vo6X9OjnFLbTreGv3kGRCjfb9ShGOhrWCVtZyjI2p0=;
X-ME-Sender: <xms:gXLSaik5V99su0xV3z7eBGQHiAeaswvyrnMaVIdaeHGs526bcxcQew>
    <xme:gXLSathtu6wkWcAoYjzsifa_Nhjh6lmI37bvvKV_W90t6N_gkUWl9fVoCdcdaCswU
    rj9HAD3YOHhRBe6Bn-SJ9ItRizjkz72tRU8tDhtZMh4gVVxNKaUnIs>
X-ME-Received: <xmr:gXLSaqcvYcx-jHq4jxyURFEE6rlIUY4UU4d9xL9o8cDZRSRWin2rDLA5LEo7zUiLyhCIgguEg2zR_RgQQiVTOZr68JNNrOsuII3r>
X-ME-Proxy-Cause: dmFkZTFvaiCsJx//nL5x7CB1VWuMxk7wJ5JhdlKfvjHuA+r/lxAgqJkIUviYn9a6lodq4M
    ffSx5qXgaOchIF7Q0G1DsljcprpG2WiGiKn/fdC9g2IhJ5F5+Y+VnPJJN5iFZLqORw7m6s
    x2AYyhcJopSWHdQ7nV8o8GmrTy4hc8+eo5dezaLVi/Er1EobCIaEJk6bA1nZyRbILMU9Vo
    HOaLGyzFciOxDncU4nHkTWgyqRv802xzvjVt7JsF6IhSIGr17SLE/+z+h+Nv1kW+Nx6Ct7
    SnI7qCr9S1fIg0zjCv8vZ9z3afQHd2Nn5X8bxEGxmGgiwcQ94NVo2Uti2kptjTa33fsGNo
    EWBatb99FgxXDcGUPs8hO1kFI9fO9rHC0tGD4ChsSj0XIxdZKux1gv87qIBz7EykwiHgSu
    ZOO/pmEWcVzIS93clN9l03xEU4a53bnX8IA5PQ9nGGSbJLmO+E8F5ck/YQN0fEdRY+E9oL
    zYCvhu+UXYMXnTw32VryL5RbzUu0a06n9II05+BALx/s0kug8BPKl9k7E6Cib2NvX8eGdR
    +3bLKO2zJcfihoG3cpWB8IHoFvC+lqCALU5NbPI7YubsdVTpga1D+wuJ/tpHa3PKTQuSYj
    XPtoIQuYWUUBmKKYDeYrqhv6cPzZEO+8z7XFKOfDTWS2thCB7gihiFwrNrhw
X-ME-Proxy: <xmx:gXLSatjDEvrRu4KhPo1ZpoESm8zEih2g5XTuCMtIKNN-qZyTGwNhUQ>
    <xmx:gXLSaixCh5dMit7Bg6sB0pxfbJGJuIlH8uCF0mYuwwBP49cui6fqdg>
    <xmx:gXLSapPTysFr_Up5ETCFYzn9Yje6jTzKQpvKbfO5p5FntsiUQRptWw>
    <xmx:gXLSajWe_lCJPb309IKSmYjHAnE2s0dq04i66cY-OdFlGZRTbikKuw>
    <xmx:gnLSaij9okXyjnrsJObgB5FLDg8IHYSy4m6B4nTiiP1WmSXpwK6W5qTG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 14:52:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Bence =?utf-8?B?Q3PDs2vDoXM=?=
 <bence.csokas@arm.com>,  git@vger.kernel.org,  "Jeff King" <peff@peff.net>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
In-Reply-To: <d7450b0c-89ad-4963-9229-198f40cf72c1@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 16 Oct 2026 20:21:40 +0200")
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
	<CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
	<958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
	<2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
	<fc3de093-a051-415c-b40e-f9df5c914704@arm.com>
	<xmqq4ielirpr.fsf@gitster.g>
	<CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
	<d7450b0c-89ad-4963-9229-198f40cf72c1@app.fastmail.com>
Date: Fri, 16 Oct 2026 11:52:48 -0700
Message-ID: <xmqqh5ilfpfj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> (Besides, the OP's grep also counts uses of
>> @{upstream}/@{u}/@{push}/reflog syntax/etc.)
>
> I set up `git symbolic-ref refs/H HEAD` after my first `@`
> conversation.[1]

That is funny and clever, but unfortunately it does not help solving
the problem that the @-shorthand "conveniently" squats there to make
your use of a branch named "@" hard or impossible.
