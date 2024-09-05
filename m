Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608B193424
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520512; cv=none; b=PiU3bmB2myThHA7pMTDwYvRy5cQ0yzz++zZ44s3KKrCQmWWhLBGpQQTWNOhKroHDy9QEmCQteyw4xYY3bc8lli1XlFkQBjGDRO0uCvjt5Gp9ovO3vFq8Oa1KcLH0iktO3yXpKlTWmtk9Y7UMtO9Y4vlsZjU43TdPZstihiGyQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520512; c=relaxed/simple;
	bh=A0twAoBaR3iLv+r2x1cnfm7eXNTsKn6/KU0BxNee3Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTWjZK47s76uRaY7KufB2aZf1YG3eLK7B6Yv7ZAptPRBdhq2zZi9oyTU+58+jSFUjhCvyhRks+PnKJzpYgku4T60Be/5CUbL+H7o2yPxwLpOyPUQvwsAgioS4ZCZ13NznHBo/17/4YGRTzx7MS+Pv8B5d62J1yCGcXT+Y51QUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cDc9Zvpb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxF+nDqR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cDc9Zvpb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxF+nDqR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3077513801E2;
	Thu,  5 Sep 2024 03:15:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 03:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725520508; x=1725606908; bh=EAxR6YdqGS
	1iIN0VQlWUoE5qVn5DiX42UIN0hjeo1P4=; b=cDc9Zvpbaf/iG3I6UOfMSBe/lp
	z1qM56Rje6V6Z+sprRCB0l9cGAaV3oogyb1zZ0adX375fvSZOiMICnMb+DOTUXVz
	2X86JVsJtJ4Zle5P0TPv2OGaAkVcp2ozQyQCP1jULBqyPaOImsrKBUbTAqMCXimJ
	QVVsMkTyLiDnAbsTqwtzDTNWH/C/aV1mR22B6AsmJ/Q5+8IRpNXqjSiJn3WnN9fS
	1cYVz9L5bxY+ETFMKtIZzgOnWoqLHH3sjMsRUFAPbLSZuf+9Y8UBjrt5c6zOp/Gg
	uepHxrPWebQCutwzLB2RjvTguMvpxpkcDcZ4N0VhFYbRpc/IXoLpopaQDPzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725520508; x=1725606908; bh=EAxR6YdqGS1iIN0VQlWUoE5qVn5D
	iX42UIN0hjeo1P4=; b=VxF+nDqRTRDq++KQl+N5ZUdKL/ptCRN60yLvr2Aan4xm
	XPr/vQFinCHRpndJg1IR0MB2M1njcWC0HCj4SZbDrrEet0LGm/LGMsfT3Liq8ZnA
	0p/X/EnYqJNrM8iAYXRF1f/IU2Yf4CulnCE6oRAhMkIxtokLyvAWjKg/0QEIhmpV
	Jycnlm53gFQJjS/kXI7uHHyQuOfpCeY/vh1f5DUw94OjoL6cLiXJeBZ7iwG65NSm
	9IwH6Kw7joEaqD9/mwGfKSfm2tabJw7iwqdB7mcpSwmm5MYgOMhSijWgNcOHPoxB
	Xay8EhdyHPEtWO2LnN0HIr+YWv2TCIaE9c+XUPIS0w==
X-ME-Sender: <xms:fFrZZmku0jm3ZT-5eo26jEjKFMQFjC9da_PQ6jHcQHjAXLOAnmj33Q>
    <xme:fFrZZt008pJTvvRGihgkugy6KierHPhZb15xneK7vQU3CBYzszIKZRCCjOYyvJ_XX
    J9cdNNSlc2okWqTKw>
X-ME-Received: <xmr:fFrZZkpou4X6c9yKZGGDKNgTE1HZ4IhpSFYSh1cxFGfkCXvNwdqAs7gvlYWGkO1wBYngABgOMFmoQZhf648--zLLPiuUafvqwffWawXy51teLQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvjefffeejvdehteelvdffheeifeetfeffieellefg
    geelheduvdeghfduudelkeenucffohhmrghinhepuhhpuggrthgvrdgvmhgrihhlpdhuph
    gurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fFrZZqlPmeW-rec9TNHTR9JkEpzTt8dLJnt8l7snZNz00p_4ZO-o1Q>
    <xmx:fFrZZk2F6LnwJTHwTVWuykC6eiLO8ZXeeV5nc2HzHf8UhUK5scJMyQ>
    <xmx:fFrZZhuMpjliMTUvtD3kbCzETjo8TW4UTgq8BmgAn6MnfE7ZJDKJfw>
    <xmx:fFrZZgV7SzM6IaNYlXPoJjcPTBmSJu-rgixpKehdw0NddJBlNL0bMA>
    <xmx:fFrZZhw6DMqnvWXMA9aMGRr54H_dD25inyrgbaX1GekWclqxVn2_zSEt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:15:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a440888 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 07:14:55 +0000 (UTC)
Date: Thu, 5 Sep 2024 09:15:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/6] t-reftable-stack: add test for stack iterators
Message-ID: <ZtlaeQ-SqrCPP_SA@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904150132.11567-7-chandrapratap3519@gmail.com>

On Wed, Sep 04, 2024 at 08:08:06PM +0530, Chandra Pratap wrote:
> reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
> as defined by reftable/stack.{c,h} initialize a stack iterator to
> iterate over the ref and log records in a reftable stack respectively.
> Since these functions are not exercised by any of the existing tests,
> add a test for them.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-stack.c | 80 +++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index 4acf07ab0c..e209652031 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -544,6 +544,85 @@ static void t_reftable_stack_add(void)
>  	clear_dir(dir);
>  }
>  
> +static void t_reftable_stack_iterator(void)
> +{
> +	struct reftable_write_options opts = { 0 };
> +	struct reftable_stack *st = NULL;
> +	char *dir = get_tmp_dir(__LINE__);
> +	struct reftable_ref_record refs[10] = { 0 };
> +	struct reftable_log_record logs[10] = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	size_t N = ARRAY_SIZE(refs), i;
> +	int err;
> +
> +	err = reftable_new_stack(&st, dir, &opts);
> +	check(!err);
> +
> +	for (i = 0; i < N; i++) {
> +		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
> +		refs[i].update_index = i + 1;
> +		refs[i].value_type = REFTABLE_REF_VAL1;
> +		set_test_hash(refs[i].value.val1, i);
> +
> +		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
> +		logs[i].update_index = i + 1;
> +		logs[i].value_type = REFTABLE_LOG_UPDATE;
> +		logs[i].value.update.email = xstrdup("johndoe@invalid");
> +		logs[i].value.update.message = xstrdup("commit\n");
> +		set_test_hash(logs[i].value.update.new_hash, i);
> +	}
> +
> +	for (i = 0; i < N; i++) {
> +		err = reftable_stack_add(st, write_test_ref, &refs[i]);
> +		check(!err);
> +	}
> +
> +	for (i = 0; i < N; i++) {
> +		struct write_log_arg arg = {
> +			.log = &logs[i],
> +			.update_index = reftable_stack_next_update_index(st),
> +		};

Nit: Let's add a newline between the variable declarations and the code,
both here and in the other loops further down.

Patrick
