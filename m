Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09C1E3769
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105414; cv=none; b=GeQ4SqfdwpjMGA6R/RDJo/X4LyuvPfyXaFuH0cWCnUegHpdnoZEC0kU8KRBlZLEbOd4DgBvmyUlHjCMowy+kg/dcKfDI4n2bD3mx/utPLfPpi/pW2KKfb6SAWL5gWvnldF7x3dj9RYIh/vb4MOy8mkNzOhZN/ORr4JQMdYRiMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105414; c=relaxed/simple;
	bh=wgPWMCI7fOTn+rjy2ukM7XUQ71Lzp/LrNfH1lSbaNmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5d1+Q2ZzaY5WPmdnOMtX2B04h+D9MXYYM6TVgPYEhbpnKRRmnphqgFAiCfaO4Wq962qx1wPCNad12yT+vT/fRHSBsHrG5Yfydad6Kd4RHW+kdqeAysajXlNkyHNOHlppL3nXmeBgN48thN2iKy1NRNM9d4iczwM5J+wWaExWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GNSS/9GC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZKXVlhP1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GNSS/9GC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZKXVlhP1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F2082540191;
	Fri, 13 Dec 2024 10:56:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 13 Dec 2024 10:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734105410; x=1734191810; bh=wgPWMCI7fO
	Tn+rjy2ukM7XUQ71Lzp/LrNfH1lSbaNmk=; b=GNSS/9GCt9UF0zB8kgofYwqMV/
	zVMkOyrxsAVpLYIuLuZldf/Zr+gua1+3TmrT4aOThI9cl0CDbAj2AQpbN8ZIc2JP
	REOCdLjZYgF9yC5knaZr7VQ77c0P0lHT8r0h6lNN9MrSzenTvCNo2XvNN+7wHdmt
	ltcUZuLx0OYfVgJwvlK/fMaEBDTgcV3yhtoxULBhhsr7dUFNAPgkUlX960HnzOtL
	TWI6zKEJm1BVCZ66qqTUoyEfk2eezTDhoOY1Tg+Qaj7zyZVO3qKm3/HHH+JlEGl+
	72hScHuTltzxFCi0QWI7/X4XFeMJxCDjAnB0aBwv4SV+Zew8Br/6i1GGCpFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734105410; x=1734191810; bh=wgPWMCI7fOTn+rjy2ukM7XUQ71Lzp/LrNfH
	1lSbaNmk=; b=ZKXVlhP14B1tkJTXTg717pGZ8iKA9H7WQ/iNVK7dn8VFOz6pc/+
	WJo5hFP5WXlZwtUkJgYQNn0u22e6wLsoO1JDeA4tT3viAfJNDNXQwSVElrpv4vKZ
	fT3IB/69YiXlR6hExeJcwmgEvZPOb7zyyIOOiBFAJE1Bti7NmIDrJfCJ8US2PUrf
	wsPvpBtPDzlW23hE1T+SKChFHTrxGgYJPSts8V2znU6Jr//qh0jJcS7eMin82nyY
	lYKRbY7NSePxedzSSF/1KYxOlV2zpOfWO1//LFSJV/ZEmIfZYB51r7YfkH/EqVN1
	tv8z0Y2PftWOuMRQb6LbXfNlA250NH0+LnA==
X-ME-Sender: <xms:QVlcZ3S_7X5V81hK1pCdgF4nM2tt_ye6ZsY7-edGt2DQ6swYnPLH4Q>
    <xme:QVlcZ4zYIgR0R6DOLYPy5m7wnSm9GH8O0cvY5Is3Cq38quNzW8d2Prwj-_ZkoMcxK
    GFmvVEFwyA8QiBzLA>
X-ME-Received: <xmr:QVlcZ81T1BHM09Cwj18d0aE1CGKtSWbFoaMXr6U5WEOjkfYXjnFnhAt_haOvcI5RbnqugG72So-scnt-vjxgcOyO3TO1aFEH2WdqgVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QVlcZ3BIkabSf5VGD0JgxrPbvlLwCpGeAP-rwlXsqLhj6VBCUTESLQ>
    <xmx:QVlcZwg8dJaRqLXSzYoFP4Snvz2OFqYDGrwkfm3ZgfTKx-Vx7NHYYA>
    <xmx:QVlcZ7pbs0W7kBu7tn2HaTgb06ds-Nb8Nibw9CNN2h36ELYuOp4LRA>
    <xmx:QVlcZ7i73B-f8RrsxZzP1istcWaM5yEJa-0H0c6uv6btkraeKWKCBA>
    <xmx:QllcZ6ZOwT6rOwXHTOfOCjy1QJwzai36D9k7gEfLZkhLUTKY5wQPibLP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 10:56:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v2 7/8] t: introduce compatibility options to clar-based
 tests
In-Reply-To: <20241213-pks-meson-ci-v2-7-634affccc694@pks.im> (Patrick
	Steinhardt's message of "Fri, 13 Dec 2024 11:41:22 +0100")
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
	<20241213-pks-meson-ci-v2-7-634affccc694@pks.im>
Date: Fri, 13 Dec 2024 07:56:47 -0800
Message-ID: <xmqqzfkza85c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that this also requires us to remove the `-x` short option for
> `--exclude`. This is because `-x` has another meaning in our integration
> tests, as it enables shell tracing. I doubt there are a lot of people
> out there using it as we only got a small hand full of clar tests in the
> first place. So better change it now so that we can in the long run
> improve compatibility between the two different test drivers.

Yup, even though we always hate to see a change that forces people
to adjust to, this is a developer thing, and it certainly is better
to do such a change, if we must, earlier.

Thanks.
