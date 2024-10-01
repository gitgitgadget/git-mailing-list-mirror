Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41761BDABD
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823296; cv=none; b=fpbHlnHYj3wTXklXcJfeDdb3LivJ0/vlbMemr02NJ7rlIBFOsfdili9s/BEM9cpIR7ikGgQlY8dIIQhy8MKAFYl3rm/mrNkkQvMVcG/SefOBoO6QtgNwRWDt5faDbIe98UNHJztuRYioD2Rwbd5OR8Z/KcYmTINMD71aoyzY36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823296; c=relaxed/simple;
	bh=0uaPRYMLRObDPggXU8IBeTgbyaOoMkccV3WrXHmI37Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=daUnWmY/IfQ5IOIllYyxLwufG664M9peIfffS+wWS0oTrLmmNc+lalsJ5Nt42UvRVc+rC9BNrcpUqwJH58jVVbQz2ZtXiMnn3Z4VrlgBkvGXJNE3f2GpPhn+FmKXILA0o1nJKVCd1Gz8uS+gcf6e9Fg/ZQfBkRC/AgfbtOg80kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D7Iv2Fjs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEnzblRZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D7Iv2Fjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEnzblRZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 093F2114077D;
	Tue,  1 Oct 2024 18:54:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 18:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727823293; x=1727909693; bh=TGz1PzkMbc
	dM60ZVFY4YTGxKsiu8R6K5X9+ctGKBz/Q=; b=D7Iv2Fjs4toU1winodMrIArkZF
	n6O+HuyNoIelyd4RSsBSr8fFzhOFhxisGyVz/J2BYWgTzzhN3MX8UiH5VJzImwhd
	awIE7T97tS9PaH8kYBiSc9G/44iaDaVIHGMj4onNuu0To4O+pV2wDaO4juPV2pCO
	ArxOw3mnHovTyuKNiK6j7CASm6w2kPRUlcOqi3Mxu0yPtOIEXlvjjWXRm76ewHrr
	ZV+HHRWhBJN1+L0/W57sIZpnZwAWC9WX85ZhBMcUNAWhc7wfwfA2FSeQg+dZayf8
	0IUvjuGeqcAkJC7HIAyUJ/XyzXmjZYSRBE98Jw5Ex8nav8aayXpbaFJbVXoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727823293; x=1727909693; bh=TGz1PzkMbcdM60ZVFY4YTGxKsiu8
	R6K5X9+ctGKBz/Q=; b=NEnzblRZoFa0EBLg6Cv1qX0VUK/XEaK/WFAXA7ICm9FY
	YZH4OHuBrbrQZwwDGLunUcG+5DJuv0Kf083SVfdw4ylKzarG7+GZOXZLPDRZ4xVe
	29ywxMvZg/LWGoZDJ6Z9S778rkp2DZm4YpIhTGuQ40F8ciF/x3xicUl3jDBJh0CN
	eiRRTd/K/068ep1a5FFForev8VUgnM3YS9oxF+7IrFX3gGse/B0d/spyl0Q5f8B/
	ivZF0Y8czdyLdAZofFhKu0+A+Qzq2u2zLwlClXVmkyW28ePY2KAWxlSB/bAfujTf
	1UxlcYFVUDjGm0uW318wsdSUFwfQ2dEe0qppYDazjQ==
X-ME-Sender: <xms:u338ZjU0kRQZlqdexbJZga3mfooCybyuig1myv2RbivGaxfh0Lu2dw>
    <xme:u338Zrn0jJWz3BjVgHQWQ0823kvMf2QR8ac8F_6pxEfrKrNAgkLJq78nUVieSMdA6
    lW24nGTHgFbggS2UA>
X-ME-Received: <xmr:u338ZvbAzlD1DtBS7hWD1-2dQ96cLKTOyLsOSvfADbcys3LzDKDfhgZVWylKDotlYOollnfHiu1MmG8C9b1xDpZqSS6mFjEei4xxJDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheplhdr
    shdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u338ZuWYEKW0SXbfPhJAPG6jLQ7jP1sIN9SqEVzlBs9WeOHHMFLWBQ>
    <xmx:u338ZtmbzvZh6JYKFWhjrHDL7feyWifLkmCVJsgWljLKi8Ntwc4Ekw>
    <xmx:u338Zrft7xCgQmgeTwi0mzcYAP0_RgfTueTWsrtRv92FTQR8P7zopg>
    <xmx:u338ZnEyDA9KW2FtnTP64uta0Y8awtFhookBIJMiQpO9QUjqgrq8vA>
    <xmx:vX38ZjUf8Uh2OLhepV_TVJJC7_0EK2x1Fs9FO36U5T78BF2BX440_q1p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 18:54:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  Taylor Blau
 <me@ttaylorr.com>, 	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/5] set-head: better output for --auto
In-Reply-To: <20240930222025.2349008-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 1 Oct 2024 00:19:52 +0200")
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
	<20240930222025.2349008-1-bence@ferdinandy.com>
	<20240930222025.2349008-3-bence@ferdinandy.com>
Date: Tue, 01 Oct 2024 15:54:50 -0700
Message-ID: <xmqqbk03sabp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> +static void report_auto(const char *remote, const char *head_name,
> +			struct strbuf *buf_prev) {
> +	struct strbuf buf_prefix = STRBUF_INIT;
> +	const char *prev_head;
> +
> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
> +
> +	if (prev_head && !strcmp(prev_head, head_name))
> +		printf("'%s/HEAD' is unchanged and points to '%s'\n",
> +			remote, head_name);
> +	else if (prev_head)
> +		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
> +			remote, prev_head, head_name);
> +	else
> +		printf("'%s/HEAD' is now created and points to '%s'\n",
> +			remote, head_name);
> +}

OK.

>  static int set_head(int argc, const char **argv, const char *prefix)
>  {
>  	int i, opt_a = 0, opt_d = 0, result = 0;
> -	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
> +		buf_prev = STRBUF_INIT;
>  	char *head_name = NULL;
>  
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +

What does the blank line between "head_name" and "refs" declaration
indicate?  Is "refs" so special that it must stand separately from
all others?

The primary purpose of this step is to pass a strbuf to
refs_update_symref() so that we can learn what the original value of
the HEAD was, so that report_auto() can give a more intelligent
message.  The introduction of "refs" to avoid repetitive calls to
get_main_ref_store() is orthogonal to that.  It is a good change,
but it should stand on its own, as a separate "preparatory clean-up"
patch.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 532035933f..711d6e5598 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -434,7 +434,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
>  		cd test &&
>  		git fetch two "refs/heads/*:refs/remotes/two/*" &&
>  		git remote set-head --auto two >output 2>&1 &&
> -		echo "two/HEAD set to main" >expect &&
> +		echo "'\''two/HEAD'\'' is now created and points to '\''main'\''" >expect &&
>  		test_cmp expect output
>  	)
>  '
> @@ -453,6 +453,17 @@ test_expect_success 'set-head explicit' '
>  	)
>  '
>  
> +
> +test_expect_success 'set-head --auto reports change' '
> +	(
> +		cd test &&
> +		git remote set-head origin side2 &&
> +		git remote set-head --auto origin >output 2>&1 &&
> +		echo "'\''origin/HEAD'\'' has changed from '\''side2'\'' and now points to '\''main'\''" >expect &&
> +		test_cmp expect output
> +	)
> +'
> +
>  cat >test/expect <<EOF
>  Pruning origin
>  URL: $(pwd)/one
