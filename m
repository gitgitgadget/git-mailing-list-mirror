Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F1204C3B
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624528; cv=none; b=RTIaCT0SxlfsNt3inU1PUZHL1plM19RCfXALxnDR2qpONYiBZD3hXlPj4/OlwPGmrsRBiGfcE5K11oKdP05D8RxgSLBAr7PChRwUxhpqNOxCnT0BgtJELS4BJKSCkivMOmsoF+yoLk1g90zsIpnki1oGBMLOZSR6DgL9xv706sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624528; c=relaxed/simple;
	bh=ArJZhl6ioYwHHvnRFULMT6lGIPDcIvstFZv/8skqK5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYBsZp0Lg7rfqwzp7xTs0RKADk+ZTdRyNtCMUt1ZsWd6LYyB2xYacKMkT/2/GInSOFoZk8VyoEeDPgil1JQm/b5rfZIgQ1dozfpPLuT4C2eTWWBtAbuaO7cb5bcHzCt52n8FqfhE8WtEt5aNdkauOAXa7QBq+QKL6EBNeNc9w7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ch7bNms2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8f0wqmK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ch7bNms2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8f0wqmK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 155B01140102;
	Wed,  7 May 2025 09:28:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 09:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746624524; x=1746710924; bh=iKXclflEcP
	d7ppXJM7xb3c0eCIY7DseiNpnIC+CRPCQ=; b=ch7bNms2Z9EjauUscPlJevTvdp
	wzOpG9SsUdM/bdSSnCELfLRHoMorjwcw86Hpioahp0x8Gn6PvsgFGyTDIHUN+ADc
	gk+h6qGh4f4cNgtDovm4RZiTKPwKHFweRyLDtLXNB89qlLM+wG5fKcN1IPIF/+fg
	jHKERZIHTMaGbYJgKLa1yYuqfJLbHnSIX3gqH0ESYNTLn1jZyDgr2emz+YXn2nk6
	2dVgWIzZRhmsP2GE5Z7ATSxnLTLIkTAuVuOuVxYBKY29KfAq0qcyDhClydhWuDID
	+S4eTSs2VBmIVyOt27eWYOMJ/lRoDomUTmTutHWUU2O+5ngr9VDHYsiB3yUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746624524; x=1746710924; bh=iKXclflEcPd7ppXJM7xb3c0eCIY7DseiNpn
	IC+CRPCQ=; b=B8f0wqmKK8ztwsFF8jNM1LC4TTgFv8fkffD3IXuY1nrVYLOxvZQ
	m/Mnr07jNsCh5oEYoePenDXwyL2kKUQBei1MBNQSfkO7DMZDkH+tNJryxrzOdkgO
	jhE3w6KJ4JSv5qrY/uacNc9Fetseh615lJVnvPmxMDT+/7N/bY5S3Orx/Ja6MExn
	4PAZZapY3/vMNrWFnRxgemlVY6yarBN/wvcM2Id5lWgAYJNYl1S5THv0YYBQFesu
	UOJawui4W5COzit95v3KVaPIDQ1WN1He7sXE4yxJMej3vB6V047dNPAsIQXIviyA
	O91WyZ+Z2yPNxv25HL18IovNUDFD5/HEQsw==
X-ME-Sender: <xms:DGAbaJSAuUhtA-JVBchR_231xV6NreewRSfU_TDm13-Czb2qnYJJ-Q>
    <xme:DGAbaCzT5sjFHwcIbwy0ISEZ1XRFWkoCxOQ7UH_Yu_JsAES9Em8vSXfbF24o-xxBw
    MlB5KhCiUBM2R47gg>
X-ME-Received: <xmr:DGAbaO3J8bfKGQ1TyZba-n2dZWqDk0lQNJ-CVdgz5H2VvsvKe0r-BX6Fz6-0HS-AX-xQ3o7OZxJJlKxNSvJzsDy4Ek7O1fhV6Xsa2OMZVQgvjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DGAbaBBUvX4o12Yb9FGuBaV0Wxzw47nEOZC_w3U0fkX5YCixfWgGKQ>
    <xmx:DGAbaCjvJquBMHhI3zupSOLoIcU2Fq48D_lfltwWxdlKz4UYu9f-aA>
    <xmx:DGAbaFpgOIT4CjlZzQ5aOaAYaprlkeihznYdfm14Diya4N4ziSzSeA>
    <xmx:DGAbaNhzJ0Q4H2bkT0ft9eHFKZgzg1283qqRFrH2ULm61nf4i-Ey-w>
    <xmx:DGAbaCrvWCHN8DmAKx1DmtCqzc25ge__fGS1xo2KOfn80hQix8TjWaKI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 09:28:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7bf67fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 13:28:38 +0000 (UTC)
Date: Wed, 7 May 2025 15:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [RFC PATCH 1/2] t5412: test receive-pack connectivity check
Message-ID: <aBtgCYYKPuowEeNQ@pks.im>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250507030249.4802-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507030249.4802-2-jltobler@gmail.com>

On Tue, May 06, 2025 at 10:02:48PM -0500, Justin Tobler wrote:
> As part of git-recieve-pack(1), the connectivity of objects is checked.
> Add a test validating that git-receive-pack(1) fails due to an incoming
> packfile that would leave the repository with missing objects.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  t/meson.build           |  1 +
>  t/t5412-receive-pack.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100755 t/t5412-receive-pack.sh
> 
> diff --git a/t/meson.build b/t/meson.build
> index 43c9750b88..81066668b9 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -630,6 +630,7 @@ integration_tests = [
>    't5409-colorize-remote-messages.sh',
>    't5410-receive-pack-alternates.sh',
>    't5411-proc-receive-hook.sh',
> +  't5412-receive-pack.sh',

Instead of creating a new test file, do we maybe want to generalize
"t5410-receive-pack-alternates.sh"? Just a suggestion, this is not a
strong requirement from my side.

> diff --git a/t/t5412-receive-pack.sh b/t/t5412-receive-pack.sh
> new file mode 100755
> index 0000000000..190c7d3624
> --- /dev/null
> +++ b/t/t5412-receive-pack.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +
> +test_description='git receive-pack connectivity checks'

The description is way more specific than the file name suggests.

> +. ./test-lib.sh
> +
> +test_expect_success 'receive-pack missing objects fails connectivity check' '
> +	test_when_finished rm -rf repo remote.git setup.git &&
> +
> +	git init repo &&
> +	git -C repo commit --allow-empty -m 1 &&
> +	git clone --bare repo setup.git &&
> +	git -C repo commit --allow-empty -m 2 &&

Okay, we create two repositories. "repo" contains the full history,
"setup.git" only contains the first commit.

> +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> +	git -C repo send-pack ../setup.git --all \

The `-C repo` shouldn't be necessary at all, should it? The repository
in which it runs is specified via the first parameter.

> +		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +
> +	# Replay captured git-send-pack(1) output on new empty repository.
> +	git init --bare remote.git &&
> +	git receive-pack remote.git <out >actual &&

And then we reply the packfile that only contains the second commit onto
an empty repository, which should of course fail because we don't have
all files.

> +	test_grep "fatal: Failed to traverse parents" actual &&
> +	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)

I'm a bit surprised by the error message though. First, why is it on
stdout? Second, shouldn't there be some hint that the connectivity check
has failed in the error message?

Patrick
