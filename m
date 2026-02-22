Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341E35CB8D
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771800001; cv=none; b=WYRlLTFMPTHagkGVSp2Yc8zRDnqVhFY6akoO7TdDWLLYY4ARy7FP2Sdz0HKJp0aZGRCtYPTdIsMK0oFT8Mq5RfudzHhkpNoFGoLqQjBse7BfQ+3w7IJrJUzHpMFI2G2YI7E9uUtvnzRndYQ0TM2WKEi6E/IZoj97X9J4yhCwA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771800001; c=relaxed/simple;
	bh=0ON4XIn80rQ7cIFaO/txBkoZ/B871wJovVOrdABvnfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjs9RCXocpDzrU8VLjocM4VYfqFhLliy0u6NP2Cjlnz8A0iRSH1OffdjMNKg6rPzuWipFere0FYIJ9/JWgXC87YxxMEsUpMcEaEFLG/bY0SUMXOIfEdGJNSlPR/H7AvS/4wGBgt3RF8dnxNjPUiRgYlsGf5JlDj+6U6wtapkbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZewtfWGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwinXn5T; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZewtfWGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwinXn5T"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F14A71D001A0;
	Sun, 22 Feb 2026 17:39:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 22 Feb 2026 17:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771799998; x=1771886398; bh=VArwpE7mTH
	xu/gpVrQsZYsKKuvlx7XHkihGpqfHg3Ks=; b=ZewtfWGdTQvCCmXLtKahZuklBA
	vO2EzRbAo+dR7kqstPHJYPLSaTEfQcaP7FQPScCyaGK09EC6C9Er8spOs/TS69/y
	Ynp6GCGKFUh6IFU4eSDviR5E1o8G/jtpsQ1d/HwTcrxsWSq8nJVxYR587KrQlpA4
	E0lYFW4zEGsZEhDn1opaUS80UzGLUFNRXFrXls4TdatPN3cLkkGROM4+2Myj9V8S
	U6eSI4K+Zzy3FBrWvKR0Zy6niv59jqFq2pZ5iPXhhqRKopFlOUx/XjmAQbT30N+j
	v5SlQXPSGR+Knh3mfsOQcpq4ttw9E/FPkum61CLLx8AyMSZgbJPeLXqUwIgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771799998; x=1771886398; bh=VArwpE7mTHxu/gpVrQsZYsKKuvlx7XHkihG
	pqfHg3Ks=; b=SwinXn5T0oyDFOYSCz9FLnHQbsvqZaXcgJU/NszsDnIQaBwiaAP
	U6f9wCkLV3Xe+7QwUT99g6Z/+j/hxVTC5HCVaMPW15RTDhrYUKU1bFd+FMW5Akza
	kficB4JhgkNx5yNMdYn+QXJVjcFeThw8rbKz4DQqX4q/mv3pUShRDTAtYdP+FE1S
	N0exu+uzEozf5XxHhT8B7k6NJrhED7jkTrZW7xzpLtVEo6hbS1ohrRO39CMuDeOH
	Y/Cl69SrxIzxEic1v6cGaWMjGI/esSrYCoBER6FfrPhfOdTySYrQ/nAzA71Oim08
	zLNloMmrO9WOP89vrwo3gGqUVCOGnxjWayA==
X-ME-Sender: <xms:voWbaRoxdc4bNog3vlNSYW70K6q3WqCiEuA-2ihEtAEqU2_KefoKqQ>
    <xme:voWbaaoEKmVeEMVsVBOOKdsANNRVTzK5iEQfQHUBjYyIEofJxvwlvc4SLpty8OjsF
    Sr7taNoJ6TY1_W6pOmpMze34p1qopzUcJVnoIl6t_7VOe7GMjhq_lg>
X-ME-Received: <xmr:voWbaTPGtvlogG4xhZNbKusiyVfCpP9Hp8yReMBjwnyxsafxb1UFdvvNow57jX_AMSQeHX74L7StWQVK5WWkrZPRHTOlf8tiWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:voWbabxDCFN-IcIAONPW4HGN7hZXbLZzn8iNYomL9ufFobaHGsBQEw>
    <xmx:voWbacv08O1s8izMy1trhylhlbHzVJH-7GfSgZ_nLCmNdQa-eqJ3cw>
    <xmx:voWbaU7qQM_-0l2EpVGH5hTiG-SlCagDcexIy58anH_RPZ4VJkOl7Q>
    <xmx:voWbabTq-LzpYR07HYjaEQTU_aABDuzJVSCbMZOnRu6KEDDdRVbGvA>
    <xmx:voWbaRzAbUGetc4hMw_8YqvpUoreAjlSTYUkFTihCyJD5bteNGEqyV9P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 17:39:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
In-Reply-To: <20260222183710.2963424-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 22 Feb 2026 18:37:10 +0000")
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
Date: Sun, 22 Feb 2026 14:39:57 -0800
Message-ID: <xmqqv7fopflu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 5be273611a..75e75e627c 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -160,6 +160,10 @@ test_expect_success 'hash-object' '
>  	git hash-object large1
>  '
>  
> +test_expect_success 'fsck does not loop forever' '
> +	git fsck
> +'
> +
>  test_expect_success 'cat-file a large file' '
>  	git cat-file blob :large1 >/dev/null
>  '

Wow, this is a fun test ;-).

Thanks.  Will queue.

