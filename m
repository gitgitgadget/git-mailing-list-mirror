Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DD1FFC50
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336689; cv=none; b=YTITbIGXBmFQ6kT6D7Z+ZZEyWsYo0ECtCmq7BVCoQsT5XHGFkPLBwK8Mzn9kX2zgJdZCnwJCvJbq2xLpP1PUjC/Z2MAKURh7m0ksjp/Tw+6YYNx3k8nIBkijIHvSljKCatskOkCJL3n7nDCDjObqSm3k55F0xAiLM0EHdwH9VsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336689; c=relaxed/simple;
	bh=z3nIAlBw5dtzCXzF0+pHOKWHXHpyMGvdg+C7kcHrKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLHz57qjdPpqZn9K/GD7oHm3hDVsghHaq/CYeyagOwOBj7AUpIFDmcweRfPhQd/dVxhIV8uVHNkn5C5m/kPA4SccdyR1ni/RBEfIx251Tn63RG/CAal3lkvxklvAQ2j8J0ljcJ+mDYwoOxXG9c5GucaNPunz5sEcxuHwJpD++qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axEXT1u/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+g/QP0v; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axEXT1u/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+g/QP0v"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61A0D25400B1;
	Mon, 16 Dec 2024 03:11:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 16 Dec 2024 03:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734336686; x=1734423086; bh=vUVKn9vCMj
	5Y8XC7JexW9r6Ym60O348GBt7Tdr0FJv0=; b=axEXT1u/KlkSfjdNfiP/N4N+s2
	fTu6hl3unmrllqq19x9d1vc4e30J/gNkWK0npWGUMt0p9PvbTlarnxzoNkG/wg8U
	gKXn7Zdl+6JlnYPciF6DKR9HpPZsaunHz7RCl54GLYR7O8337GL8Sg0bRUQnOnLi
	ERDzA+8ygV6pbnB6vjYk8yRqaXxDqFGuwZtvNHAcAqqyTYJ+DBLKYjLm4Ks3uvPQ
	D8gQDJDOPE1bpaJ45XPZu9YpkdbtA87XDi2sGFptj1pa1eaAaGC0nlDyHetPLOmN
	MgGE9QpaXfacn2sgcjAe9WPuOQ9f8jJym8MJrrjvGiT/qJ4i5BvWV3dUnY9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734336686; x=1734423086; bh=vUVKn9vCMj5Y8XC7JexW9r6Ym60O348GBt7
	Tdr0FJv0=; b=S+g/QP0vHJbrDbMYGNZGLvEYKx0wjzk7RzP6DKmoqYl1oJX2Rmh
	yykx+itRl+lAZNKSBnT0LtYHpLp1ifKVNzNmNu1rowp4fbpKLZ+Ts25ySHPwck/u
	4We2TMEZ5915lLmEKURqV6v7Os1QPxB1wgeTXVNGuEkD5GuMASPtTHZ03E4uF4M0
	Z0Pvh4NNcIKAKm8l5mgvTQgFEAz2xezAJupzPX+9r4DgesKAKk/jvMaflZlFOjmW
	3pN/8jLHCgwD1+IVscVxVo/HoC4mR2Ol+wUHygW+CDMyjfBNSWuktQmlYUstO/L5
	+FD8WD4rq0FkRhoZT+dOvY0qxWD0zteG+Gg==
X-ME-Sender: <xms:ruBfZ4mkTM38xSWP6my8h5szFQOj6hxBq-DGgYup6BNwmj37sfVfxQ>
    <xme:ruBfZ31AtwnAhcAU9QSYDwucagq3IHFkMhKj9yD08hFltxa5phwIZra3WGOyDrKHL
    ziRx9iOfjctPIusEg>
X-ME-Received: <xmr:ruBfZ2obk5d6HvmIuK4Xs7GLU0eQTXDQI6UedC4TfXOy4mr5PSZK7TRjPAPkGDr5VhvUrrlBydVQSIa-o3MZmtV3sV2HE5qtEpKDcN_H2u28JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    rggshhhijhgvvghtrdhnkhhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:ruBfZ0lU3yp4hyVsNB_OEn7FLHlfPL-aFZq-ywEYy2YErKLiEoRksw>
    <xmx:ruBfZ209YCS1R-pB9kc9MEKc54MVESYrwuOSy4kVs3SiAJUqGIPzpg>
    <xmx:ruBfZ7uxjJvwdfOSKCL2C12WwmPFahKDvMGOhcm_RcLSrJXJH0Jm-Q>
    <xmx:ruBfZyVAlxcoKQLxM6sTRm_aqiq0A46z26FGaXOye9tuJp7qCeTGHQ>
    <xmx:ruBfZy_jyQpMNDvSq1pZKqycQ9EzK0U2sKpFpar5FUTh9Y75gHmgAYR3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:11:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73256884 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 08:09:41 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:11:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, me@ttaylorr.com,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v6 0/2] show-index: fix uninitialized hash function
Message-ID: <Z1_gnA2kwRSyCF02@pks.im>
References: <xmqq4j4mv5o6.fsf@gitster.g>
 <20241109092739.14276-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109092739.14276-1-abhijeet.nkt@gmail.com>

On Sat, Nov 09, 2024 at 02:57:37PM +0530, Abhijeet Sonar wrote:
> That makes sense, applied.
> 
> Abhijeet Sonar (2):
>   show-index: fix uninitialized hash function
>   t5300: add test for 'show-index --object-format'
> 
>  builtin/show-index.c   |  9 +++++++++
>  t/t5300-pack-object.sh | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> Range-diff against v5:
> 1:  05ee1e2ea5 = 1:  05ee1e2ea5 show-index: fix uninitialized hash function
> 2:  c8a28aae55 ! 2:  778f3ca18e t5300: add test for 'show-index --object-format'
>     @@ t/t5300-pack-object.sh: test_expect_success SHA1 'show-index works OK outside a
>       
>      +for hash in sha1 sha256
>      +do
>     -+	test_expect_success 'setup: show-index works OK outside a repository with hash algo passed in via --object-format' '
>     -+		git init explicit-hash-$hash --object-format=$hash &&
>     -+		test_commit -C explicit-hash-$hash one &&
>     -+
>     -+		cat >in <<-EOF &&
>     -+		$(git -C explicit-hash-$hash rev-parse one)
>     -+		EOF
>     -+
>     -+		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in
>     -+	'
>     -+
>      +	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
>     ++		test_when_finished "rm -rf explicit-hash-$hash" &&
>     ++		git init --object-format=$hash explicit-hash-$hash &&
>     ++		test_commit -C explicit-hash-$hash one &&
>     ++		git -C explicit-hash-$hash rev-parse one >in &&
>     ++		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in &&
>      +		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
>      +		nongit git show-index --object-format=$hash <"$idx" >actual &&
>     -+		test_line_count = 1 actual &&
>     -+
>     -+		rm -rf explicit-hash-$hash
>     ++		test_line_count = 1 actual
>      +	'
>      +done
>      +

Thanks, this version looks good to me.

Patrick
