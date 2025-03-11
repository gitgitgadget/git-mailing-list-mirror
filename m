Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DF241673
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697846; cv=none; b=I9tJZOW31iIDyQ22j/acpPEAZYjhDv55uCGwGrzaOH2HBKnXVe5gYPCd2/j0eIldy6HaL3tIsQl/QijoEL9VBaoWwZEpMp+Jqk9OUeKPEnUzKJW/exiFoALP1H0MX39Go2/UINBxL8Xu/oViBDfYXAX7C4yyTu06REiupX7Keck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697846; c=relaxed/simple;
	bh=NpQPcf+pYf5s+ncEnNqcNnZVviNL4JDTBKcst4tJs7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4A91EGrnAAIM6Ma2CqNWQ3B8YOQuRFAlsc/zW+7xBUTxipSl3v0DKfr+u/GQX4iiwMxI8V9fRSDikqmZApUAh1QRFnbv77o9ZidNcdFFIzc5j4/Dvf7XEqceBq25u6XGcOiUeNqz61dv9AN+Jv7cmEd7H25z1MOJMu5Sg1WxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fghpiGqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cnAo8WVA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fghpiGqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cnAo8WVA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DB4731382D3D;
	Tue, 11 Mar 2025 08:57:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 11 Mar 2025 08:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741697842; x=1741784242; bh=xzNw+3OQkg
	ob+eDtRmJ1uOyzcsnfjHym+z7vQBOHNd0=; b=fghpiGqMthg0/ammQDH4ULvh9e
	z1Wked2WSxS7HaRo/yEnY0V1bJhAzdtvV9HlkWJJOB7kF/bj8y9X1dfQDzgrnVtL
	fcJqvxQcGOWVck5vUBwkCHSqGZfl19CYolUdbtAuRRVOxrMS+9GZdtbTYzyKk0p0
	9pDq9UkS8nBcp4uHfObb+9xdZUOI+8iDx8UcuChFwPfAGvzwVg0Pyd7a0qNaVoCl
	RQNTFoRabA/RKzbIo+/Ddu1ySnPdUizULGGZ7MuVs8imVdc7+mNPcr7kT6dEpIgz
	ChRS58RvlaLeSTyzPrWVLQ0tPFGEOdC6o+x2BV10eUp278tLUJ9om3zxNw2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741697842; x=1741784242; bh=xzNw+3OQkgob+eDtRmJ1uOyzcsnfjHym+z7
	vQBOHNd0=; b=cnAo8WVAODYF9j+//P2+1PfYyluqLL9IxnnOTE8HKiPHYVkN8JS
	rcwQVYQPEyBWNN0LFz2HZV5Ul+WFxZhK3Pdnjxw9oO1fi1z4BHIip/UDeQNUZXXS
	3BFGbFpXLsU9XKeMR3igSZZMSsf0M68LmUGmCqpEWN2KgowzvDBfWgORlGkf3rib
	H9CFYmrO5+APT5fjDvb3/6p4oceQgfwV9TiQKDWsj5xBgtVhGjzVF11IQnCxRTdN
	68USNlvTugdk4prva6FLi0/BjUIhpCLZcg+ZDz7TGxRqXgaVngcW9gkzapiGtbZl
	dknoDfDTp3asPSUwPbSVdiICvpOJU10N8gw==
X-ME-Sender: <xms:MjPQZ_dm9vrML99R0AlF3-JVh8NV4kNiNRisvp2WhD_ITMxXxd4Hzw>
    <xme:MjPQZ1PdFaHDLGgg0N0Ctel1w8FuITuJG3Bx8HpqsUlPYLzpn7mJTG2Oclpyxn7-M
    udO3tKAf30RHsAmeg>
X-ME-Received: <xmr:MjPQZ4gmDDUOJF0eDdO3jE-VVcdx1fiqOjIwdTEL6O9E1wge3hybVQMD7nZrg0Q_bJevB5R3g4HhjSJY4ZbxhfaMn4LcCkYdcnYuRx1gNQAvGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:MjPQZw8EDjtjG07gtNYh7si3yau9IbioFGIP4UdzaFhiDLTSyGVZEQ>
    <xmx:MjPQZ7v4tLgTivTh4mQoD_IQ6uDMreyNHSDccly2_Hc-147QWd_Lsg>
    <xmx:MjPQZ_GF0DO4iCQIv31UWnYqP11sV4a6qsXoeuWtevljmXZvKd3YVQ>
    <xmx:MjPQZyMf6VLmiYLACU4zT3JwC_r2pM9GeP8zmWNyfqSnu55U29FBbA>
    <xmx:MjPQZ05Cogq8cAAgXz2gKH7g4Z0IpBUB5J_3Vc4IB3wuC_Wz4eyv9I4D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 08:57:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f2d5cf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 12:57:18 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:57:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/4] t: introduce WITH_BREAKING_CHANGES prerequisite
Message-ID: <Z9AzKoWLeOJ63j_E@pks.im>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250310231652.3742490-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310231652.3742490-2-gitster@pobox.com>

On Mon, Mar 10, 2025 at 04:16:49PM -0700, Junio C Hamano wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9001ed3a64..12fe82f660 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1862,6 +1862,11 @@ test_lazy_prereq CURL '
>  	curl --version
>  '
>  
> +test_lazy_prereq WITH_BREAKING_CHANGES '
> +	test -n "$WITH_BREAKING_CHANGES"
> +'
> +
> +# DEPRECATED; DO NOT USE THIS IN NEW TESTS
>  test_lazy_prereq WITHOUT_BREAKING_CHANGES '
>  	test -z "$WITH_BREAKING_CHANGES"
>  '

Do we maybe want to state that this can be removed once the next release
cycle is over? I find it to be a bit more actionable when stating hard
dates after which something can be dropped as it allows any drive-by
developers to act when they notice that Git v2.50 has been released
already.

Patrick
