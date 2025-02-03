Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E920B1EF
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600415; cv=none; b=lK7GZCpZD3JIyXNFXIHaYWE09IfljfWFYdmkavua/vqdX+CnGLMFCDW4fRPuowpSlHLw5oAodUVG2TtQkAdFre5tDjBa/CkwfZNcR2rqgdVxkPvBi8aSNLc2SsCq20Ub+w8osIW3xYkIc1unBmRXCcPoAI4CQDlZv5vGIKoWSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600415; c=relaxed/simple;
	bh=wxcz8H8YHoVDJSe1GA31PEtqZmGEDWNM5J+nwDUJ7o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3fyGnGQt9+nukl2BLWyfKAWBV++N7OwQFSJnhhQ3/neti+F+p/G3eJzOiheZ+9IE/OBL9W6pVZtPUaNbonPyOsE3Km2UBgYA35pyxEIn6alRjGdr+w3MnLsHuG8fxESB7JMcEaP8K1Ujk1DmB4oupQDdThv26a0Ccag8npagdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g7n09XMt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0Tm8k/c; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g7n09XMt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0Tm8k/c"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CC3613801DD;
	Mon,  3 Feb 2025 11:33:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 11:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738600412; x=1738686812; bh=j9XTQ+pcQZ
	AWMkNV4t15fwTpdLnCYzf0jb/OWHWKU7s=; b=g7n09XMthGUEa4z8P+ZPYZz+XS
	klRKw1wJ7eEHc2f4JyV6PRQD+HP23u/8+0EySvZjGb85GbhLD9b/IttljUArxG6w
	ifYYvFLB0YxzSxTA1v/gBNN1FMdnRwuB8dtTHiBqVX/zt1JoCDu76HQmZb3WI9fs
	3vojcFjz4Z80Zy0EXLLNPlXbHK4YOxfYtvoxWNYyjIRQW/EbdycI+vLmQn5+A3jK
	4/vSde/rBTKrhEt/EQvuFlxPDeJdybGNziVa3S3u4l74ujgVTaWNXeyVS2DgOKnO
	EZth/OAWOGJJkZ1+aQoO+awUenNcWdd0COjhrx9BIeEnPcNrIVwW5qA0yPwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738600412; x=1738686812; bh=j9XTQ+pcQZAWMkNV4t15fwTpdLnCYzf0jb/
	OWHWKU7s=; b=v0Tm8k/cufwU/A+ZiXeYGXB0YrNu52yNfW65HT81w+SQQckRufS
	OZHvmjF+XTl5JxNmOoEm85SDU+PYGVVVrz3R2GQU1CdMdnKYZmFlvxVd9cBpTPMI
	Q+l9m/ZwBqY6nMmGNEsde6hfktFzIrRStSJszDqmhbbY6t4J1H5Ca0dpH6dj2n/U
	iZNl7qPhpR+agGpFlzK6E/bxN47gDjj09N6Bxcr63I96bIU+zuPVVSUFAfMkp0/t
	mWfHITAf7FWm9ONSsukT6w5Edh2I/SjaCrRzii0fHb+M0SjI+D35My1IK9ED/ETH
	MGxW/wczz3AKSXHFdlNMq0cE4ih+iyqaQVw==
X-ME-Sender: <xms:3O-gZ3GtHNvTdnR0ki0lBTQeldIzKt9RdAbxpG8f8ftlDr4rxQoCFA>
    <xme:3O-gZ0V7KzkEI2A5t-H6tLgnMiPnYC6MD2rFu5so9W-Ra1hLpCvl6qvjuqI96xlKf
    iZGhQ4e0iXgRlXxgw>
X-ME-Received: <xmr:3O-gZ5LSP9lG1wXvja-O1FrJtuIr7WAmNlF5QNvVZtcMIs2iMi1nja12E0gqigFJfAdeIrM81SR3xwqUlkd8pyPmSN1KvtuuUnZK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3O-gZ1FA19bcNGzXqQSTg2Z-85pb55etAIpfRHbncXJfh3f7cG9MEA>
    <xmx:3O-gZ9XsXqLajlGpQ5fyve0gyYFq7WGMY-w_T5gwj6lzInUf8LWExA>
    <xmx:3O-gZwPRdPaLR-yBSH0TGNelGGm7BMbXPlDGzI6OdXKDVJv6RdqdrQ>
    <xmx:3O-gZ81B554NJbq5n5Zy8Jy5br1YY87UcbGMliwDBztktwdVGV9UQQ>
    <xmx:3O-gZzxdQEiZWq_2clK3HYUuAVr4ue4EnAVvfEFqcXzrtersAvQQjh8X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 11:33:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: Continuous Benchmarking
In-Reply-To: <Z6CSc_vyGkn-ozUH@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Feb 2025 10:54:59 +0100")
References: <Z6CSc_vyGkn-ozUH@pks.im>
Date: Mon, 03 Feb 2025 08:33:30 -0800
Message-ID: <xmqqpljz2dk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ... implement continuous benchmarking for the Git project. The intent is to
> have regular (daily) benchmarking runs against Git's `master` and `next`
> branches to be able to spot any performance regressions before they make
> it into the next release.

This is great.

> I have started with a relatively simple setup:
>
>   - I have started collection benchmarks that I myself do regularly [1].
>     These benchmarks are built on hyperfine and are thus not part of the
>     Git repository itself.
>
>   - GitLab CI runs on a nightly basis, executing a subset of these
>     benchmarks [2].
>
>   - Results are uploaded with a hyperfine adaptor to Bencher and are
>     summarized in dashboards.
>
> This at least gives us some visibility in severe performance outliers,
> whether these are improvements or regressions. Some statistics are
> applied on this data to automatically generate alerts when things are
> significantly changing.
>
> The setup is of course not perfect. It's built on top of CI jobs, which
> are by their very nature not really performing consistent. The scripts
> are hosted outside of Git. And I'm the only one running this.
>
> So I wonder whether there is a wider interest in the Git community to
> have this infrastructure part of the Git project itself. This may
> include steps like the following:
>
>   - Extending our performance tests we have in "t/perf" to cover more
>     benchmarks.
>
>   - Writing an adaptor that is able to upload the data generated from
>     our perf scripts to Bencher.
>
>   - Setting up proper infrastructure to do the benchmarking. We may for
>     now also continue to use GitLab CI, but as said they are quite noisy
>     overall. Dedicated servers would help here.
>
>   - Sending alerts to the Git mailing list.
>
> I'm happy to hear your thoughts on this. Any ideas are welcome,
> including "we're not interested at all". In that case, we'd simply
> continue to maintain the setup ourselves at GitLab.

Elsewhere Peff was talking about his adventure with Coverty running
on 'next'.  The more eyes and tools on the topics before they hit
'master', the less chance we have to scramble just before the
release.


