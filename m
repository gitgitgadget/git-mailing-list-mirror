Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E38176AB6
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651617; cv=none; b=jWl00Fpu0WUn97nji5lpkr7ctZDZKD9h/AVTKDZedNk/AbZnGxeomg0aUMt/DQVLFlcsLjKyxMJKZXz1xVHT9wFO2Xz8chbYXR3VgZgOedHbdu+4yovJ9sEqLAgcz8qAVnq1XbfVG2j9Uc5rSEJYnA1Z+moFJC70Mpwoz9szBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651617; c=relaxed/simple;
	bh=/TLJO2bBoSCsJ6FIiCEKO066dOyVaQlkYktoCcqwW+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pTHeveMHPM4MFNmrgTMXx+nzt7PPWZvnyTeZrvWSrFTw84PVV+x8AKDkkdRIMyUz39ie2tnv5gi7r9RMFjSuTw1jHnKeQtUGZmEVm+TJceS0k8UkZ0APxLpmLxCxbhkCXrUGgZ/U8zXpLcRl2yoD+iJ6k5ys6TBzkXfj5xl5l4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=sqCm91k5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hipf39yq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="sqCm91k5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hipf39yq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 60FBC13802E9;
	Wed, 18 Sep 2024 05:26:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726651614;
	 x=1726738014; bh=8yY+C2JYearXeVT7qvP8kKgdbR67kk5/v1vp0YskajQ=; b=
	sqCm91k5E/I8JWnSkQ6Cp9kBPz8PdiFGdJm1u+F8loj47qGec5S2girKe665H+Rw
	RIAYmzxygV1uCVT0O2OmgGKwsKOiypbySoYA2dYetq4+hhGXPUKh1nYtHh2Z7EJM
	H6aKGwWvvbuVTsx9KrT91GjZzQIgA3d9QEK2ckBziQRYH0y4DhgiSZPphDFaF5RF
	5NKLJ09XyoA7bRw1CXV5PkklkTYdtvw1R+SIebmKdnO3tDcg6AZ4YWVfvz4eyI8g
	xvY+lC6NHhU8CWEAbwEuWV8MrEcZQ5KfoCkQb/T+Dvt17Bj3KfG4kip0c5BwCizY
	EX8GbOj760O6AGrLiEGgRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726651614; x=
	1726738014; bh=8yY+C2JYearXeVT7qvP8kKgdbR67kk5/v1vp0YskajQ=; b=H
	ipf39yq1d6mzxMNvww3mZt9+murSSHxYxHG7MwThY7qgWIp/bDEGAJULB7ElW3um
	123f2yFXXjVdFXfcIolq6xU/s2a6ZS3dOA9vvVtawZHlmTeS6ayG9kh9dp2neP2F
	qaY2DU/iHLXskl75IqbTDj7HDDTMHM4YToa4m1lCw1SzSeSn0u47xfwb1Iuv3Vkc
	iKoRx1d7gjYuMMKIBJI9k8aE4es3rO3IK0++nWlkLD8e3BMYklNzie9ik6mzEWqJ
	IqzooyxdiqRx+Ie/9Smj5e/LTaHkG+jDM/ciVEwnPBUs8yuuzPTuS0YBc04TSKQl
	PIptBZ8fyYilh9qCT8zXg==
X-ME-Sender: <xms:3pzqZlTrx9NYM_MPhEfpCV5tyRB5bWg9zjGDQAj8AbZ3biQVGkqhwA>
    <xme:3pzqZuzG8trTChpGwCXFU5M9DYZ8i9K7ZFplqoI0ifG88muHJ3YS0boFrx0fTk7bH
    m4xKmO523frXyCCzA>
X-ME-Received: <xmr:3pzqZq0SB1lhtJE6QT645MUXdKbGaYit9lFclgJEklGUmLVfcezdaIkCnIcT6MaC2DCvRommt89K4Yhufr_I74s6gwm_wRvw6NBWu1Xr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepfeefgfduveegfeduveevveekieffhfetffeukeff
    fffhgeelueekieffhedtveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:3pzqZtDNKcU6CcXdciyI9kxs5VTT7JCZ2AeTtuC89V3Ak0KYvCkntQ>
    <xmx:3pzqZuhFudk6tZ4XH8WdnUdd7HrlgwieWKOexUBW5K3xSszmee6tOw>
    <xmx:3pzqZhrQd0ubrY56rjLYkvLsTIlXYj6WbvdcrVtztWLsnJU0Tvza3w>
    <xmx:3pzqZpiIkJ0G17J66SehadsRwNtQsqfa12bGQa-xkX4zPKDgDr4EKg>
    <xmx:3pzqZmeSYY-q7HuAOE91XxsTv6LGNpCN07DaxUh-cMISTMYr9qa5M7Ga>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:26:52 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 19:26:49 +1000
Message-Id: <D49AWUZ2NCNC.11D23I38TRE0B@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "karthik nayak" <karthik.188@gmail.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] reftable/stack: allow locking of outdated stacks
X-Mailer: aerc 0.18.2
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
 <f4be0966e17600602b1057a6ae219711994df128.1726633812.git.ps@pks.im>
In-Reply-To: <f4be0966e17600602b1057a6ae219711994df128.1726633812.git.ps@pks.im>

I just want to check my understanding of this test, since I think it's
the first time I've reviewed anything using this test harness:

On Wed Sep 18, 2024 at 2:32 PM AEST, Patrick Steinhardt wrote:
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-st=
ack.c
> index d62a9c1bed5..a37cc698d87 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -271,7 +271,7 @@ static void t_reftable_stack_transaction_api(void)
> =20
>  	reftable_addition_destroy(add);
> =20
> -	err =3D reftable_stack_new_addition(&add, st);
> +	err =3D reftable_stack_new_addition(&add, st, 0);
>  	check(!err);
> =20
>  	err =3D reftable_addition_add(add, write_test_ref, &ref);
> @@ -292,6 +292,68 @@ static void t_reftable_stack_transaction_api(void)
>  	clear_dir(dir);
>  }
> =20
> +static void t_reftable_stack_transaction_with_reload(void)
> +{
> +	char *dir =3D get_tmp_dir(__LINE__);
> +	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL;
> +	int err;
> +	struct reftable_addition *add =3D NULL;
> +	struct reftable_ref_record refs[2] =3D {
> +		{
> +			.refname =3D (char *) "refs/heads/a",
> +			.update_index =3D 1,
> +			.value_type =3D REFTABLE_REF_VAL1,
> +			.value.val1 =3D { '1' },
> +		},
> +		{
> +			.refname =3D (char *) "refs/heads/b",
> +			.update_index =3D 2,
> +			.value_type =3D REFTABLE_REF_VAL1,
> +			.value.val1 =3D { '1' },
> +		},
> +	};
> +	struct reftable_ref_record ref =3D { 0 };
> +

Create two reftable stacks that provide a view into the reftable tables
inside "dir".

> +	err =3D reftable_new_stack(&st1, dir, NULL);
> +	check(!err);
> +	err =3D reftable_new_stack(&st2, dir, NULL);
> +	check(!err);
> +

Successfully add refs[0] to the first stack using the transactional API.

> +	err =3D reftable_stack_new_addition(&add, st1, 0);
> +	check(!err);
> +	err =3D reftable_addition_add(add, write_test_ref, &refs[0]);
> +	check(!err);
> +	err =3D reftable_addition_commit(add);
> +	check(!err);
> +	reftable_addition_destroy(add);
> +
> +	/*
> +	 * The second stack is now outdated, which we should notice. We do not
> +	 * create the addition and lock the stack by default, but allow the
> +	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
> +	 */

We try to open a transaction via the second reftable stack, but the
this stack is outdated because we've written to "dir" when the previous
stack addition was committed.

> +	err =3D reftable_stack_new_addition(&add, st2, 0);
> +	check_int(err, =3D=3D, REFTABLE_OUTDATED_ERROR);

Try again, but supply the flag so it performs a reload internally. Write
refs[1] to "dir" by committing the transaction.=20

> +	err =3D reftable_stack_new_addition(&add, st2, REFTABLE_STACK_NEW_ADDIT=
ION_RELOAD);
> +	check(!err);
> +	err =3D reftable_addition_add(add, write_test_ref, &refs[1]);
> +	check(!err);
> +	err =3D reftable_addition_commit(add);
> +	check(!err);
> +	reftable_addition_destroy(add);
> +

Asserts.

> +	for (size_t i =3D 0; i < ARRAY_SIZE(refs); i++) {
> +		err =3D reftable_stack_read_ref(st2, refs[i].refname, &ref);
> +		check(!err);
> +		check(reftable_ref_record_equal(&refs[i], &ref, GIT_SHA1_RAWSZ));
> +	}
> +
> +	reftable_ref_record_release(&ref);
> +	reftable_stack_destroy(st1);
> +	reftable_stack_destroy(st2);
> +	clear_dir(dir);
> +}
> +

