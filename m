Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D34CF47A
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177522; cv=none; b=qY59/7oZcHRA7EsQQJ3en17Sg1tqU4lEYb4bN5N5vPFbdsLlZ+MwG9+KnjrKyNZbhUPn0nTPJvPyFozYHtZ2C+aNjPKWPwryGIlc0cSb6g1iTl0wBccQH8fppYzoqI4DXSrxlAxMdEBPrrATueLxTUpwi8AB3xtMtEcAC5zYIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177522; c=relaxed/simple;
	bh=QCF59NSOWUPITlFP/YmwlmC84F5aObsTAsNPC46K+mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqizyJvPAy7h2044aUiiaXp0tCDNk4XXjKk8XyIW1VaFTDo3ooyOocRtNUaRlT/hWMCAPr7zFXgg4IQn8ERhb6RwbA9685A5TNdiWIk9YqPxMKTlJY4uU4T6nahHvDzN0LkPyFtAswU4pd9GTw/Jc3dbXSTDG8CUW6MJRCCYS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQNyLLjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ECc93iI5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQNyLLjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ECc93iI5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 251AFEC00CA
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:05:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 15:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792177519; x=1792263919; bh=UgKotxmG6B
	Gnvqk0RGn78fvYr8GS2d7KxxpJFomJMxk=; b=AQNyLLjLbP+GhCHvfeh1wzv0CU
	nrj4G+AHVLkPaNDB4j5GasELATIudeXwaUM+I6Xs/7A4q3cKGaghac117eVR0Myc
	etHIBTQDruYBD6WvVIy39Nd3Hgiohhmr8KW16SpLowZow5VS/YpImDM0usq0oAWf
	Ps8cxPptG93Xeogufd1ZLGfHqcPI6v20e1oQ5+UkW+rPldPeqOMdoO3yXMF/nQms
	FphSXDY1h5lsXpdlD95CAi+Ev7BLYqqeHUNorBn9GsS8kourSVzh5ZUIT7fJD8/X
	AMCby/O7te6U4BiMj62QLg+MNN4K/BzNmnPJJKVK6+b3AveZrSQMHRNQd3jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792177519; x=1792263919; bh=UgKotxmG6BGnvqk0RGn78fvYr8GS2d7Kxxp
	JFomJMxk=; b=ECc93iI5Ey5BH1zB3wFhH+G/VOJW/LEGkgzmNzpC1LJXVOd9OYY
	anooUm77ph9BrM4AZE9NMiu7KW4kncnqakdBWM55TnL9ElAi6g73EKmB8VPIek/J
	3OlrI3QotNLmki4jjPFBbz/HsgHhBd/SLaKxmJ38mJFCAWpz9RAaRcpBEYZoDPU9
	dLDiRcdoGOXxCkpdj5bR51K68Cr3omw9cIX0xggZIY3mL6TVJQ8dBrKwQ2cYXNUd
	zw8dPNFuVbrvXetFg7/S0k99lg1uuHROTwh1iVwxp4Xy4uT9N7n8eQ1yl4m1M+/v
	tY7zT5dTMHFGxWPN7+xCLwrEnhsnRJFi0Ww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792177519; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QWnn472AMu7FrklzYfTlspSVF9HPxUXUY7bafoVsq9CDRZd
	opvuILvMxydZPb6JKdmxkTDrnkLanSEEbfi/jJDJJ3IVqO4Q5X1h69tXaJuSK9k7
	ANQoXhB0wpmaiKsW4ilh3wTV6dSOVRWH6ySDFTPqhPrwE1EyS2f0IvHndjfssbHp
	V1+uy8dz85ONbeS2ErtiXTDQhd/buxzfeuTFIQsV9RQUYWcMGIBMmGC7K1VIYe9l
	cj8jtdkdGMC01fcqWKvcsn25xlaIr+KX2ip0YIwePdG0mB0pz/WYfzFgkcWfc4Tx
	omCk7usssaDSFCrEU5cahQyWxfBjV6Q3/iVgQkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qb9Tsl/7hRVtHtkvEQq7LPo0KT05bTrQeJwJPwzB7mA=:QCF59NSOWUPITlFP/YmwlmC84F5aObsTAsNPC46K+mc=;
X-ME-Sender: <xms:bnXSakOIcvMvZz6L_wzdQjQg3Vhvtfm0QzeQI56Cw4rLmTRo7tUjow>
    <xme:bnXSah0dIWE-cKJG4C_GcsKD3s7UyRx7NF3my19iyELRl5sqoSHwO82rFhrHWmLCk
    OF8OR3m1tLmgdhmrZaaO8INuvrb55m5c-0rTf9lfwTihnBRa2ubSJM>
X-ME-Received: <xmr:bnXSajkGELu6nnxllwyUzvgIHimu_eoWAMgdVTh5aCMaC24snf3Kzw9-jFsebP0FpkRKQHgAd1w7vH4urI6BakdjCgSdti01Psss>
X-ME-Proxy-Cause: dmFkZTEcPh1Vzu9sAs19zj+ruluBTBGcwIySYTcaehb1Y+fIT4ir+i7OpYqtk2tmqwuiCm
    Un7nXXhWozV/6x4ExfYAcaOlRnRbRKs1iCBD1KSj08etswAlUVjXd7JC2f+VwVZ2456ahP
    iTE7mGOJojHkxZfvONTF4ej37QCXUuwp61ISSAhzOGqP916J7efglTKsoEX+IBvgS5BBzr
    NZqcvntuFHJH8nnu6wy/QWBYgHXSHSL/EiWsJbfibA5/etjfOh3++8EWuQioVhlO1omYdT
    eQ5UO8WhYZzUTyNbYAIPzUGgtUyRAzkbEtZjaHt+2hhwUZan4rXbhD1SdnGn9dNKfzajr4
    RKyzLidt3dz0S+dZusVG+RCNPHFk8p9DrKNyEXBz5I+0XvfwyByb8MhvUseWnTP/Uk3fGD
    54wiBZE63Cm+Hz/o35NXMKoc/gX1gDKh1oCqpjzq/pgN25nu1GEzvJYWJRcrlOU0nN/lpr
    YbHkTv3mYqxEa2CzGysAseJaJwZtDZYwIs+9/8KMpHVx8tfX1xvs81gDBA0I3HAHZCc6tT
    JiTcweHyLxrIOw7q/R+jG1tsqe9aau9iiK/P+gonW1a+tyHpFao5NkTH3nor/gEyxNaPTS
    TKJu34OZUO+bTEao6zR35P6Eyt80wEOvE47hIQqEb8qdDfdzFtA88/ct31pg
X-ME-Proxy: <xmx:bnXSaoUGl7ttdjcamdFZW1KAIwsy4pEuM3xKw4qqO7AloHICgGmEPg>
    <xmx:bnXSapsB2xzDrHiaSzbUkIIuDN88UrmrlXUskmGWRt13ecflD253GA>
    <xmx:bnXSarZKkfU_ZwbpRXJ6x9Ybhki-9DZMDYtVv1G6zplkYOei6GV8_g>
    <xmx:bnXSaoWb_SERZGn3_BARt4iXJE4QZqNn3E83WnMgMhk58FT2O0tt2Q>
    <xmx:b3XSavngpzPo5HY8iuMYcsSRO1Rqr0Nu1Rv9jcB9ojxa4WtMFugSSuTE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 15:05:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <7e888746-4220-494d-b8ab-00bdd5da5876@app.fastmail.com> (Julia
	Evans's message of "Fri, 16 Oct 2026 14:35:19 -0400")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
	<xmqqecdqk2qr.fsf@gitster.g>
	<01232f89-6f57-48d2-b6de-d51c91b6fdb3@app.fastmail.com>
	<xmqqzewdfuhm.fsf@gitster.g>
	<7e888746-4220-494d-b8ab-00bdd5da5876@app.fastmail.com>
Date: Fri, 16 Oct 2026 12:05:17 -0700
Message-ID: <xmqq33u5fouq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm not planning to test this version on readers right now, no.

That is fine.  But eventually we will reach the point where we
have something we think is good enough to show to test readers,
no?  And I thought you were asking for help to improve the draft
to reach that stage by sending the patch.

> Here's what I wrote in the first email in this thread:
>
>     Often when rewriting these explanations I go through a process where I
>     ask users' feedback on the old explanation. Here I didn't do that
>     basically because that process takes a long time and I'm working on a
>     bunch of other time consuming docs projects so I did a quick rewrite
>     based on my previous experience explaining detached HEAD state to folks.
>
>     I thought this could be a nice quick docs win on a topic which many
>     users find quite confusing. If the changes here are too controversial I
>     can drop it for now.

After a long process, you may forget which suggestions you chose not
to adopt by the time you are ready to show the draft to your test
readers, and those who spent their brain cycles reviewing it might
not notice that their input has been forgotten, either.  I was
worried about that kind of waste.

Thanks.
