Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86582D66
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654357; cv=none; b=YR66dkK1RBFdZkJVk+oQpUN8EO1TPfgJZNAPU83j+iJvgWhKf5GrXSrtaKCEd/mcIOp8l5S9ff5tgcmKHgYTeDM+4Lem6WT1+ZYQ5Iujf3pX/xv2axXtxJeZ6PPePdRQJ/KeurHndkljErYn5+YnEItk+Jp+86wJXnrE8eAceU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654357; c=relaxed/simple;
	bh=xfgD95vbQgPv6n6LiK2AR57huoCqhSOYMm+eOjkNW70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+jwpRxRqk/A9yCMIXSv8Kv57IRFmIaq3kYznwN7BL7oczzyIPsRtoXd/4+ctSAyIEB3kyU9nNqTvcvf+T5tKLgz0MK61EUB/ZV3EpnRC6OXR81+wvDTvY/ez5pjt/ndHzqP9nhfsG1ZbQBBf25R+/oP/v8S+3TK8wr51j74DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fbd4iM1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwduoW1h; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbd4iM1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwduoW1h"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED2691390A65;
	Mon, 26 Aug 2024 02:39:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 02:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724654353; x=1724740753; bh=U4vsgZqheu
	R7JJuJ+HtXMGZl2S5P7NghRiCTqsdsIXs=; b=fbd4iM1R5c48UsP/TJcXJtaZ3c
	KnEimMcxfoVwyutHB9i9clmKJi63QRq8+bFt6xNQhMGx7JqnSX8V2NKG2SoSnge6
	HwAVpDnurcnuYpIjHbIeMt2Cbz+XA5XE+HuLHBBj6srhLtTlPHli66tXnBr2gjb5
	D+Ew7U1yjJg11iXKzrze4/4JzSq1raSZStPGGZwSM/aAy7hQEBJlUIbvKHIl6bPl
	MTmGzk8p2jf9oYFIMawz8FwgaK1Un037m6HB251uSoC0KlwhxQp3ACLsfQywMwD0
	yVnAEvC1Vx8WTTEOWoFopte3UC7VcM1taI0C8esxBKDLiQCm6YLwqDIgtqxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724654353; x=1724740753; bh=U4vsgZqheuR7JJuJ+HtXMGZl2S5P
	7NghRiCTqsdsIXs=; b=kwduoW1hI9LvZrpomIwfgrGceuFNwMAkxv7G4aEZFXia
	c8z0O53agvaPLylAZF981behRypByP5IyL6BWjE0r2G5oIKdkcP6+HL4Y5FCR8hF
	aix8hnr5A+IAR3HAry7sH2S6SRimDMSCo/0ekifRHzspc7dLeLGaofIhes8gbKaX
	YZzPbQ6JFyUhvMjUTrpAuNsou7HyeGbMtgYOVQEMKXTUl1RzYNQwU3heYbYiJMsI
	PQTUdageelDcfDXm7Do/pa2Lhk5h5cr+7o6ePu+egbIhY5QrCnKLcyvksRRxntu7
	voqp7ke/NNFOQriHSO23JWlM5nIvcUbfmLTkgBySeQ==
X-ME-Sender: <xms:ESPMZnDMvc5487PjHIPVjMcrInQ9fHcX_c5DKfWPE-VDsmZyCvcAYQ>
    <xme:ESPMZtjHsmsMF_aw9_LyGdZecFu0MVl32Ss7hOUqzKmLmdRs3uKtnRbGnaPYLHNn-
    Fnn51XcVz3G5szA-g>
X-ME-Received: <xmr:ESPMZil_K_0OrjtXrPTMVlzhCoKQGoi70lm9LKD16dFpupTwWyO2-b_RLMSMAdzUEJcB-uUI1KHPQoGmdZdsFBRo1TdJk2CCPWq8YKo3iEwBlkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvjefffeejvdehteelvdffheeifeetfeffieellefg
    geelheduvdeghfduudelkeenucffohhmrghinhepuhhpuggrthgvrdgvmhgrihhlpdhuph
    gurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    gthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ESPMZpxmc-zwGr2kQcYg8oVUZgSH5JDywX7n6w0YN6n-VitS7MSziQ>
    <xmx:ESPMZsScZncflMfyL-DdrnPpYihu553KViHm7Bkf-qMj8YhW5PoJWQ>
    <xmx:ESPMZsZzHwVKaI5gT0fYmhtzM8TqUMJNrYq8FmZSl5ayYWQNNGjzOw>
    <xmx:ESPMZtTAjVGU85GVTVIS3iO-92ogB4XrcNjsiEQTyZsW-AB7IN0erQ>
    <xmx:ESPMZidMPM1RD1YtbnSEPRfc6YgzrvzU8XFNCBRuieyo5voHpUUutElO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 02:39:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db7d2088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 06:39:11 +0000 (UTC)
Date: Mon, 26 Aug 2024 08:39:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/6] t-reftable-stack: add test for stack iterators
Message-ID: <ZswjDx5RHvH905zw@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823120514.11070-7-chandrapratap3519@gmail.com>

On Fri, Aug 23, 2024 at 05:18:51PM +0530, Chandra Pratap wrote:
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index 51339a9939..5b1ecacd70 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -550,6 +550,85 @@ static void t_reftable_stack_add(void)
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
> +		err = reftable_stack_add(st, &write_test_ref, &refs[i]);
> +		check(!err);
> +	}

Nit: you re-add the ampersands before the function pointers here, which
basically reintroduces the pattern you got rid of in the second patch.

Patrick
