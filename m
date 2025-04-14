Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652015575C
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667314; cv=none; b=i+HPSmzJmaQ90p8ExcjVmdkYAPDXsnDckg99aJ2Lzf1ABcnaLG1ynST1fszpFgkg6mbobcmupBXbl43uFiayvXMAIomIa1sQ/muRGc8+XJmXhtl4wakVAkpK2UleobhjAxjiQL1dPKrXT6iuirxOhMgl3U0ppBCSHHr1ULZByj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667314; c=relaxed/simple;
	bh=Ux+fePJ4Ym/cDcOQaXlzLc6EUyy5MBfR2WGauP/Ht/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwyJ4it/5OPsjGsaa8MEYWfwN76iIkJYiAHxLpiHTr/vhTnFCsfbgDXGM6hcjU438gc0E12bvPXbsPaHNEik5nDSBNN2M9UFWr7uE31APIDP7eKxCUPQqYcwPKSfrJYhuN/Hcc1FIbYLepcCzqIgm+7UKeM7dRwmUbyv0G9eBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AolPKkbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IN/b2CKv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AolPKkbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IN/b2CKv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B64E4138076F;
	Mon, 14 Apr 2025 17:48:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744667311; x=1744753711; bh=pMMjbmJYue
	RNhMLQMFNm4YhO/Wi5yoJIpdNX9Qpb03w=; b=AolPKkbLeU1CiC7dohXDy59czW
	KNbLwSg8CV6ZkP+vdcChK7ayNz+W5e1AutNZ4YumwfjfQb+sYsOwnozhOTKzieMJ
	qrClQ8cPOaPX4vT2NE412GddckzqbeRtbYpggtVTCeuROaTXpOEwulxm7cNdE7ER
	o2i99w09RLwi05pv8YajDuA8Dyiz3feTQJRugNY7FdBrkNWVnJ201nVaAuxX02+2
	si6wZ2hOk3mkFuvjbwOx4UGYUv2Zqjq/xkmg/osujBfMAYbbszBsCRkTeEYNWoSS
	n9S2zATbTyyzRu257woG+4gGZhmc9KfZk09zQgoLxsUvi66gVh+edwlKumGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744667311; x=1744753711; bh=pMMjbmJYueRNhMLQMFNm4YhO/Wi5yoJIpdN
	X9Qpb03w=; b=IN/b2CKvmFmNrKhMaKHScN5lLO9gOOg4Z4+UybBKsiBOrM1SD57
	YOgyLDdviopGvQFCgsL573PMSmPH14A7ETIaI+yZdFvLCMxzIYxHXTlP6m8PyJ+V
	Ld5dzeZnm7GM1QO+aC2ajxr3512Lhv+X6+I6eMRIK73X3XRm0fgN6DjUFKlpOaMf
	PrvsEcft/hLCxH8YX9yF4FL9V7rKJMDYeT3Wcun0himAlK3YxiNo5ibytttCeQWU
	9s26IE79Vnrd9bv3lGA6eOwXXhgowXfDZeGl1MeoRpTcQg75m82T59Nr38/CUV5B
	pYyqAyPPr1Rsf+if3APRPk6HBqM7P+Qp1Ug==
X-ME-Sender: <xms:r4L9ZwsXfqXKxb6j2JE7YfbTR8vlN0IxnOt3LqyOVS8BazOHgGkCMg>
    <xme:r4L9Z9fNfc9NMWytNMnSezmfJUUEjSEyz-y5fddf--ZJd235G8ZUnZkVVJwK7kXGy
    XzQpVAlecsY8e0oXQ>
X-ME-Received: <xmr:r4L9Z7wmFIsMoHazQmjLDKp3FsRwrWhzl1IwUMbmiCDoJtFE7NklYTT2n04rnMaatfXbY2BdHmvPwIzFi6x_MR6moQx9ldC4Rsrn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpth
    htohepnhgvvghrrghjshhisehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r4L9ZzPSlFRcE_WSru9z7hJ70lUq4Wz1a-SOnwqa4fRWlXW33Tno9Q>
    <xmx:r4L9Zw8Wf_V5V7wucVS1dMP5tsMPhoBPvnpP49pb7ocuUc-dAqRb5Q>
    <xmx:r4L9Z7V6qI0pxvqEKfjBqhuRUY8PC4vG0W-8T7qMyK1b7mYGToKYqg>
    <xmx:r4L9Z5dudDYEiRozwLO7jeteH46B8W5b13m9aBaY7GynTN9tNVpflg>
    <xmx:r4L9Z0HcpyhFs7hyxQKoWPTXRgyMbbfgE5ym6zAYZuot-XdeOq8Be_Wc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 17:48:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>,  Neeraj Singh
 <neerajsi@microsoft.com>,  Patrick Steinhardt <ps@pks.im>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/3] p7821: fix instructions for testing with threads
In-Reply-To: <abd146b7c2a62aaef5c22269cff155387f33fe32.1744481732.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Sat, 12 Apr 2025
	18:15:32 +0000")
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
	<pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
	<abd146b7c2a62aaef5c22269cff155387f33fe32.1744481732.git.gitgitgadget@gmail.com>
Date: Mon, 14 Apr 2025 14:48:29 -0700
Message-ID: <xmqq7c3mpg7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In 7b31b55db1 (perf: amend the grep tests to test grep.threads,
> 2017-12-29), p7821 was tweaked to test the performance of 'git grep'
> under different number of threads. These tests are run if
> GIT_PERF_GREP_THREADS is set to a list of thread numbers, but the
> comment at the top of the file instead mentions GIT_PERF_7821_THREADS.
> Fix the comment.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/perf/p7821-grep-engines-fixed.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks.
