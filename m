Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDF35E1D9
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148399; cv=none; b=pUhzMSAEvN02pZeVU1tOEZ4AJSUEuKWLRayGOJvY0k2aR1WT2fSCQUkSyLVmLESoFjeghKIHpZjPyUfIqohJmZgX8M9dXsuK9c3mglOPT30IEZJ5K3tnWiqRjsU891TPHL9tt/z5fG7gvcEXhFUkghcmG9AHZ3SojEMqYv4bWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148399; c=relaxed/simple;
	bh=f3X+3mJIuSZNpVkBm+r96dgeLu/7iHdimY1IHXXu2+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJYtE4AiRNS50m0401Wr5zhnv0aFwOeMR3RQIHAeXtz9MaWCvPyM6aHpmkI5BHaREoSSbkoNZSqkbY2kaLRlZtVbb19JuEMJfwCuuu19//LT2aa53MBHyOy/hKPQGUBLdbTTpP0uqCDgbPSpSQ4YBgy4QepIqFqYjYypZu9I32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oqUsmO7/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JA6w+lZ/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqUsmO7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JA6w+lZ/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 716BA7A01A5
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:13:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 04 Oct 2026 17:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791148396;
	 x=1791234796; bh=R6SLWwjbEgBMTGzpeYlf6NEbZ8EISqjCliM7lmjIFcE=; b=
	oqUsmO7/0rwduz3a/Yx8QKF5VQncgy+iZS0EpF8oNQbTgs2lB982B7Hx+4kjiUd3
	pS+roF4a7vSaGnMQ0cso/6LwG18jd9Q/43L9Z6oHbDi/ia0lsE4sfi3ZAfWBSxe7
	Xv8tvWCLo1mc8DogPl1t2qa1J3dIBnCfq2ZxTNRop90LG3LGj7pounBU5zHzsbbj
	fJYQ6lFGgTMi1lX89v/1Qi2q3SnJha11mLJaloBH7LY0dD5tP0ZO+Z/CWlicqDqW
	lv0mdmsP3KwMSnONqyTGQSumL3RhuLVnaZM3nvCUA/9FfhlGE0bhfs/AagSnLVJx
	dwEnEAgCF5tTJkfvESgA5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791148396; x=
	1791234796; bh=R6SLWwjbEgBMTGzpeYlf6NEbZ8EISqjCliM7lmjIFcE=; b=J
	A6w+lZ/HrxPeS433D+/iGxZNmMqfFlLAyT3GA/aNBUnGIBYIt3HIzusFNtmOPNQS
	IIB7+f4R6w1cPoABMxq4htNWvO+QHMHG/ufYANdq4YmGRJvVmbViIBBrDJcFtrXs
	6GYxe8Q2tIWSGKioJvzMVkuWeXwz7NAyQpPfDyUioWseOxs9Q3tjEKycnU0sOv9V
	4ZcigXtshWlxw19hQzce7Ko0xDA3OH4DoPAo5gpgcnRImDef6WRlKV7yTipd3Mfk
	CgMrjuSrzdi4DH9sE6sQdOynKFhC6CzFpz5cha2Hybc+UDte+U8YtfsLG4/sT88a
	F9djVV3b3YqT2t7irwMVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791148396; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bjC8wu6IeP7GcquC2FCgGZFUSJCr9ggZbHaMdalCMD0Bahs
	9KWhWio7wqHacbCaKXManrz3hD34h4cv3WdeiINosUB0BAZYTr9iGwdk4phTZUVv
	m4bUynjXGcrMn1xA5dFH03+kd+KvlRgEi2BuLWlHsUYYubMVAWwxueAH1aVfzBbt
	CyBse1/v9Yk2WnENg9jldLPo2RYmu8qBqejyaGNFoGiKRJpV9lbVHtW1XKgi/LhH
	FEpNGQoQ7flf3UIyG8YOYsLIYeSDNQgQo+As19yd7xJ2wmYFd/BbOwnkvuT53FAf
	W9eKezk5QGplmlNR+9mMoGGyqJlpntxuNijbcTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:CB6ojJSIGAN+bDOPrErJxsjAmkX3B0lV1iU33CFZQTw=:f3X+3mJIuSZNpVkBm+r96dgeLu/7iHdimY1IHXXu2+0=;
X-ME-Sender: <xms:a8HCapIK0TSScijmxPS0tX_PZxxlmgsi0UkHkEEs_QJelWSJaYzk-Q>
    <xme:a8HCao3tiZ5pFk0jkANMKl3F6Ns3n592J-qeVWSBqCBc8hJzEud6fckT72bg_2BMO
    WBZBRdnFNpEW52UEMcarkAdrkng6mA4-o_-ojwdemqUg_LIL5D8BzY>
X-ME-Received: <xmr:a8HCargt5viSXekKfZdsC4eCY-K33b5kvHnVU2VaYkBhhfPIqmRNRaZjwgrbp5ZA-LK3wkKAMfWjhLgSsKTxIpwfWQBj_AVIPmIZ>
X-ME-Proxy-Cause: dmFkZTFbrEz9MpG+l5LA8xdP0onsv/p8pK3lkjpXXhhCU3FzeYTaSbJjCx6Jn5aOB8mqVS
    yfAMLIwWIenkXEUSCd48FOds3rJwkjyGBOC3knK6nehQ99to9yZ9gq+yV2NDvx98Yximbf
    FZXGAwJiE3U8PvGodqZrWFszQ34iOfH7ZPyAJ3PPXMjX/KQcH147xByCLumPkbh6NsEDU8
    ZFKulyNJCyP2UzdIgUjpVt2fqxev+9TqmSkezg/0pWexQ7NLCLFn+iLjjPHmtRCl1AcU+A
    10omgEQvLkXqgwbca2UbZs4YVRT5dZ+X/rdpfn6WIHFVBcwoN9BMLg3bDTMMJqxb9fm2rm
    A3r3bVosQMiJO4tHjmeXhityzNaeRepB2UjtMB5BZcP6K6GxBq00iipv/5Zwdy7eF7n4Gn
    /3x/rrsnKD3DhpJ8/my1QEolLDKoDtvs9SrZ7kZk6ZznKGUNNK2mvPhEKmoDu6QuqTp4Fe
    llo9rEsevFIijODteuAHEgj9/EeP//BkAbVcWHG+a6+qCgovzpqssNemkzajASHII0xiUu
    a7Ry4VqkLh6qIthfskvM+rVPhZPgnrJ0WJJ0VzuUquQQl/pD4U/h1pj/vHa4jr5TVN1Iga
    Q756qRqxsQi5VEUsH2EjBxyQ0AsReRftbOa6lCMtV068CiN4pmnUwi3LwwSQ
X-ME-Proxy: <xmx:a8HCahU3omBT9ZnVCqdJ1qDs1e3l0A9guU6BKYxDaNRzuQ1S-XeRhw>
    <xmx:a8HCaiUhYEb08GpSG0eBmbjuIMCFVSlJ_xxKE7vWAx5fj6dM4tcqSw>
    <xmx:a8HCaph5AYhKlu2MFJ09-hg04hwnv7miJWGS9wPQmbscw4DGGTKOyw>
    <xmx:a8HCalbMBzLlxAZXmzlOlHZOAtqlmqyZA27_62juNqtqjhs1lFDl0Q>
    <xmx:bMHCaovF66VBr4hLalvj-2_TIXsnBz-ZRNXcneWSUfZOEHdRSavlUTt2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 17:13:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Fionn via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Felipe Contreras <felipe.contreras@gmail.com>,  Fionn <git@fionn.email>
Subject: Re: [PATCH] completion: exclude previous file arguments in Zsh
In-Reply-To: <asIJO3CZ/P/2L4qi@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sun,
	4 Oct 2026 10:07:23 +0200")
References: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>
	<asIJO3CZ/P/2L4qi@szeder.dev>
Date: Sun, 04 Oct 2026 14:13:14 -0700
Message-ID: <xmqqcxtprwyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> What will be excluded in the following command line:
>
>   git -C dir -C subdir -c foo.bar=baz add file1 file2 <TAB>
>
> I think we should exclude only those arguments that come after the git
> command, in this case after "add", i.e. "file1" and "file2", but I
> suspect that everything starting with "dir" will get excluded.

I was writing the same message when I saw yours.

If you had a file called 'add' in the working tree and then typed
"a<TAB>" to complete, is 'add' offered together with other files
whose name begins with 'a'?

