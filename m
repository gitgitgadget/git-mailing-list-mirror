Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253152561A1
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151718; cv=none; b=bTQaiL7nx5v2aC5JEgRV3A903Sn+Uqa4W5gvcy/JmekdEQW4dDaqZ4RaByEG4Kw9rg9+DC++cD6wZWCP54VVF118NYwUidVVywWtEFxJBzKSIEEqujkgaFrIYw2UTbb02F4h+wmAGhWCoYLdAiYik+861O68TqGtgqQdssBSI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151718; c=relaxed/simple;
	bh=RMeYxR2GDh/VpYmRmrxCDqXwIXPS4f/flCTbnwfshK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc39GfzhdftsMOwNET93Ph/+MGmbbcJEkqVXBInuLQ+3mwabDkwcNsP/9REpYMyo6tsGiEFfu4YROXF4M3aWFGTLKd7lS408MqsfzF25LSAYwfEBKVunQ+un7rZQG8tf1TcuV/kfKogstuieYCpoMv7RHJVfDIU8/G73T+c+sNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TkBgVb1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nea1AvJ+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkBgVb1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nea1AvJ+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1748D2540195;
	Tue,  8 Apr 2025 18:35:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 08 Apr 2025 18:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744151714; x=1744238114; bh=gHV7kpiGi4
	gaw96RjfagcjIhw9J4hAQkn1Zg00EW6FQ=; b=TkBgVb1o8ttG16I2EkeU4YqYAn
	WwkLIYvUOGoThXLq/hUFrb9AFe+H+jDncW9tWQYoe92lm7cO7KFRPgwxpjzg+xez
	pP7j6/x1hI9ibpPCDDDXF2alYQEVI5J2zKHYCTp1o/pmNOJYN0URPpn9CimALDRn
	oiBSaEEieft/YIEpJWAksKd1ENvGLBPvPkaY4wKiHmBoGVg+oBb2dvePALQTyKPm
	84W8Z2KxzutIMmiwT/BSEEUgkyXrs65raYxdYyhDSKPcZYXPnFG3og9wKboYIQL8
	hq7Nd5G5svuw9AOcIowFgaFXF3y4nazRMB/598FnPbzB/g366dzoEGqK70YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744151714; x=1744238114; bh=gHV7kpiGi4gaw96RjfagcjIhw9J4hAQkn1Z
	g00EW6FQ=; b=Nea1AvJ+ypFVTJwlWIbHJugyo6OA/oxgY/H7aOL6XGI7JNIKvPu
	s1zgaBUuMHtWHUAyyjorGGZuF4DSXK+i1qNr1CTavlj3bwtNDkv3Azjs70W4BdDb
	Q8kXHCYqj4h2d39JA1QJCJnO5M8dsy0IEiciuDT2AZYnXHIWWytDEaoGrGecUtQ5
	gO/4dfTE/E6VbrwH1s4WfJ1wV9zYL3YMHQhLmJoW2UGcJy8cK2itmPpE3GEKsPO3
	/HBttJRHU8XdfYN/P8JGsLGvlbjqBdHqrR4U07Sm8STWyDbhJ74KMr7S6aWosRrq
	se8gcqynFgheP2kJKzRWxpFjmtnH/ulmgAA==
X-ME-Sender: <xms:oqT1Z-z8M8ghYC3v_DBzEjjjJiHzDp8YTZ0ttiGeaoc54B6i0rYt6Q>
    <xme:oqT1Z6TU5AzDtuppEyWrQcjmD4kAIAa0JpnPqivL81Dq0tZyOgjDxPQe6IqLbOzxU
    rOWzSRaIMnTnpxJOg>
X-ME-Received: <xmr:oqT1ZwU6Ckt0nTZNzpMOf94CPZrBWkmkdCFvwZ-e7cCuqpkf8Nox__VqBQ9lKorsgKIGiFcH0ruKB2DZQe45thULdNQX65vLub9a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephffggeefheektdelhfeggeetfeeftdet
    vdevvdelleelleegteffueeuveevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgpdhusghunhhtuhdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegtoh
    hnghgurghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oqT1Z0ie-jri5a9QE6p0KZqv0FxKEHZDQ3s3haQK0mismx0sOOkDjg>
    <xmx:oqT1ZwDZjd3EhVjF460vyjN2bcn_Zxh8lJmvi5ftC9PJHzHs_3nmKg>
    <xmx:oqT1Z1IBQlMyEoE9L01QjVtymW5ZaCqaCHxTSyZ8cO_D_HHXNfEKfg>
    <xmx:oqT1Z3DNf4a8hE-y7GMUTqhn_0b0C1bsMYYHGcDbK6A_SNDClwWJpw>
    <xmx:oqT1Z6ue3db0y3OpHST5e0F3VWGfaGo5nSjDFl_PQbbVWX5ooCRGNX8N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 18:35:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <77f82414-261c-d2bc-f911-ed3d4b06c86e@gmx.de> (Johannes
	Schindelin's message of "Tue, 8 Apr 2025 22:56:33 +0200 (CEST)")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	<77f82414-261c-d2bc-f911-ed3d4b06c86e@gmx.de>
Date: Tue, 08 Apr 2025 15:35:13 -0700
Message-ID: <xmqq34eiuvry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Due to the brownouts today (see
> https://github.com/actions/runner-images/issues/11101, surfaced e.g. in
> https://github.com/git/git/actions/runs/14342895944/job/40206357016), your
> patch came in handy, as it is required for the following fix:

Good timing ;-)
cf. https://lore.kernel.org/git/xmqqo6x6wgs8.fsf@gitster.g/

>
> -- snipsnap --

Does mailinfo consider this as a scissors line?

> Subject: [PATCH] ci: upgrade `sparse` to supported build agents
>
> The `sparse` job still uses the `ubuntu-20.04` runner pool, but that
> pool is about to go away, so let's stop using it.
>
> There is no `sparse-22.04` artifact provided by the "Build sparse for
> Ubuntu" Azure Pipeline, but that is not necessary anyway because Ubuntu
> 22.04 has the `sparse` package: https://packages.ubuntu.com/jammy/sparse

Perfect.  Will take a look.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 11 +----------
>  ci/install-dependencies.sh |  2 +-
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index ff44c0a8c067..c9455246269d 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -449,20 +449,11 @@ jobs:
>      if: needs.ci-config.outputs.enabled == 'yes'
>      env:
>        jobname: sparse
> -    runs-on: ubuntu-20.04
> +    runs-on: ubuntu-22.04
>      concurrency:
>        group: sparse-${{ github.ref }}
>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
> -    - name: Download a current `sparse` package
> -      # Ubuntu's `sparse` version is too old for us
> -      uses: git-for-windows/get-azure-pipelines-artifact@v0
> -      with:
> -        repository: git/git
> -        definitionId: 10
> -        artifact: sparse-20.04
> -    - name: Install the current `sparse` package
> -      run: sudo dpkg -i sparse-20.04/sparse_*.deb
>      - uses: actions/checkout@v4
>      - name: Install other dependencies
>        run: ci/install-dependencies.sh
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 0df74610d063..8700c0f2924d 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -119,7 +119,7 @@ StaticAnalysis)
>  sparse)
>  	sudo apt-get -q update -q
>  	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
> -		libexpat-dev gettext zlib1g-dev
> +		libexpat-dev gettext zlib1g-dev sparse
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> --
> 2.49.0.windows.1
