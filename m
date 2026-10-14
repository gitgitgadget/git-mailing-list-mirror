Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AC3AF66E
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980741; cv=none; b=SQZ2fbcTEm+g70h6Lbb2owvnVsqUlA4t6+iVdUFTVNh4MIy1dBxH3fAJqgixDTd+qiEbEQc/ja6wzElvb2Yxa5/sxuNp6kv3Ex4Gp2Yote8L9D/y6ugAp3FDc6WJu8pvrqfRSHwXRgV1HFZ/qBJ8YsiKu+MxPyn8mbrLufH8NAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980741; c=relaxed/simple;
	bh=EjPmWn/3gB9OV6FnF8C4re/3JyU8bKKnvg8kP/aJcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUJi5dkAcI/av2TksIrqo+5hiUUVr5FGA+sNhftLCQto8x9DF5mpcDp+xkKvjeu5bJkAXQEXA/M0Ck8y9587VB5N08C9dxn4bmopHReXOn4RDQq87AiLXcLoMvR6hLASfURemVmRZuny6xxxNZZtGpZCOGtuzmuqETPoOeunEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qjqy9v92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UP8y5skI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qjqy9v92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UP8y5skI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CE0F1400103
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:25:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 08:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791980739; x=1792067139; bh=ue++zGQQtL
	qlgoIbhKpleSe/90KxKEuUomWu6mkwod0=; b=Qjqy9v92x1cF2+B4Hus1+tWkKd
	qW5G1liFG5zGqPA1YztKhkq2azUuuveXI0Kp7dUZW8WZw1JVQ4PgBfoPlVNE/qq4
	mQbYla+rT/u5HwcMD1sc/ifRznl9iiE7Z0+hl15yvmMASXjnXx/D/3iM+o5fm2eR
	ld754GEnrFHsCrwIrE4kl6wsCOdwf6R7sCmlUarljLQUTVoDnKb7SJ1vrF83CnpQ
	+v7hvxX6lXDBGJHyVvyF9vvUfKvklMQFZfxMZXrPZDx4sNdyGmGjpzyY9SqCo/MC
	ZXNxpjeziVqArT0bpcM0YaoZqP1Xfx8XC5HT/eU3S1C8g20IH5wj5G6M9Aig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791980739; x=1792067139; bh=ue++zGQQtLqlgoIbhKpleSe/90KxKEuUomW
	u6mkwod0=; b=UP8y5skIGF0rZGIlfftdvBNmVPktHv5MrcICnZFzim/KtlTXHvD
	k78qCi5TW99IF8+CdNxMtf0OqRMT11WoV8+wu6oIE6nsVToFki1YrYQr2EU281K8
	yvUGSGJDPLFCF4DVE2gmP72CRIl+oiSOQj63mYPGB+wz2EzOYtJDaI35DveSliZ4
	RZ9NrQN9crSWdJXohuYbcZZwL/AqsZOfW67ml4Z2XDhXceog6GYT5yijAZDb2wzk
	W6LMrKuzqlYiQwDVMB+DZLhfwMb8X+vZAUtMSrNMblObCv4pEgwSR3y/vETipWha
	x2HNSaom4Wm04AfIEf5WIdTvnIhpEBn13Bg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791980739; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:t6k5rq/Bxl2jpXh+ZkKgC59DauqQcOVQV0Xv+u/ySMKfJsA
	ciNtoCsTU5GTbJgd6lTbSPT1P0zuNIdFT2myMWh4AmXLT0A7VqaEbQJP9Y8KgdEu
	z0V7bQGgL340Qim6z2b6GUbrYa2BnJj9d9AKjcqv3iyXj0bN18A8GScbwbRpBq1G
	dErnh9v/WKWDpuKzmoNDecEMwtVIjueCAgwUbZBKqWJbgZmE0Tbu9nb2DxpYbl08
	eJ/YwlCJpPosHzqNrIhwvjB7nfSin+FRsNQM/ius+EO7MFJI8tqvG2BE6wy0ZfjS
	j8j8x2XmVQG+QPPFyaQ72kIznqB4RJgCqJgHc7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Pn7YIN6VEi4QyvAymGU+mog1spHRb9KvbCx0J6scbkg=:EjPmWn/3gB9OV6FnF8C4re/3JyU8bKKnvg8kP/aJcqY=;
X-ME-Sender: <xms:w3TPapat5Gl8FoQ-Y75IkU71Ss8xZegkWkShzwZ_TSuI-OYOcI2keQ>
    <xme:w3TPamZMLn2r4U0bMOkh5W3Yoml4RXPRkUtaPIli5kKBqpn3dmfMtG_uX3j0vDLTg
    ihxF9bk-NIl-9ORJIR8x9QuEQMhcjwD9pNeuB_DyxpOrZVuo8wlYQ>
X-ME-Received: <xmr:w3TPapkhq_vcxBxeJjU9-igdw3mrZFnHdoW_Q6wlKUO5GzU4amsHIQ>
X-ME-Proxy-Cause: dmFkZTGdj2vQjc1Dswj9HFXEgob6v6G5SQ2WSHsTQHSmCvbXyj6UnmogUUStMS4n+oTJDl
    gDMBt6Vm54EjngsqRLVhUhtFwivv/s5tKZe9Jn+4mOPQBRo46bW7XUbqUV1le7Eva/cGw6
    OMry9X7md5EqiztoKq3WvLS+7CZ+uxnb8IZNihbbn5L9haHuTbd/TTb6sTELw+xrvFJj8e
    0cIibL8mXGlyMHrB+ueXkMU4wHM7PDvDQtnDfcjolKEqPp/kl9iwsFVJ0D4pMv7e28FKGj
    Cp8BKmRuAZtNAt9j13pY/TRKPLrdu0lLb6l6/HE65m3aYif2mRspONAMne5MIwsO0N4cf2
    pMlRutO4KP4QPwQrJO88w7M7h09Os+X2w8/jbetWPAVoWOvNbavrxkttuJYKFrbSzD5iDM
    5zn2mHBFWHjjAsZ9/YXYcmQtMCud5Gr6bk4pp4s+f1PvZAoO1L4K14ApqjKRaH6bt544Za
    Txo46AacAfu7gnjaAHeotx1c27C3e6T5Wdny78opBTLZ47cpyTeOfbvNS+bj/ABTmNG6yj
    lcdLKDGXf51i1TM4Wa6CXPoVILGdBy074YQ4hkl1fLjOjxiA3UJQnUR0an8h+wTLDv39Wk
    BXDFMs1ZXEn7msfnnxr3O4N6ZNcPF/vuy2+7JZZc6lasWvHwwEYidE5svo+Q
X-ME-Proxy: <xmx:w3TPaiwN87ZnJ-I27pOtoxtLMRU95fGBfrGII2d5N7CTiBviNbTEgw>
    <xmx:w3TPanOhqHniBWH5IDkLpwhpsk4tPuWihzs6iteIU8ua5xO5yN1BTA>
    <xmx:w3TPamT7dXvPxa4RZ5j7fiwP4hM67iMRcH7RvBeMTOOwFdUs-RkuQQ>
    <xmx:w3TPalaU3OQMgxL3NnkMwwEd0VrBSTUXIoF9NrlMYYkqkdA49qv9mA>
    <xmx:w3TPavIRombJzsbiYoNsDea3_2rkZHmXph6uoPyi5BR8Rm-uYTNugYg0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 08:25:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id beb810cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 12:25:37 +0000 (UTC)
Date: Wed, 14 Oct 2026 14:25:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connected: do not walk alternate refs in deepening
 fetches
Message-ID: <as90v189oxrlRdX0@pks.im>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com>

On Wed, Oct 14, 2026 at 12:35:07PM +0200, Igor Wiedler wrote:

For transparency: I've reviewed this patch internally, so I won't have
much to complain about as we've already been iterating on the patch.

[snip]
> Add tests to t5618 that check the arguments of the rev-list child via
> GIT_TRACE2_EVENT for a regular and for a deepening fetch. The result
> of the check is the same either way for a complete alternate, so
> there is no behavioural difference to assert on. The difference is
> only in which objects are walked.

Yeah. I couldn't really come up with a reasonable test for this, either.
We could corrupt history in the alternate, so if we now were to walk its
history during the connectivity check we'd hit that corruption. But it
feels rather roundabout, same as the proposed test, so I'm not sure that
it's really worth it.

> diff --git a/connected.c b/connected.c
> index 929b9bd28d..d8bfb3dbf2 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -127,9 +127,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
>  				     opt->exclude_hidden_refs_section);
>  		strvec_push(&rev_list.args, "--all");
> +		strvec_push(&rev_list.args, "--alternate-refs");
>  	}
>  	strvec_push(&rev_list.args, "--quiet");
> -	strvec_push(&rev_list.args, "--alternate-refs");
>  	if (opt->progress)
>  		strvec_pushf(&rev_list.args, "--progress=%s",
>  			     _("Checking connectivity"));

Yup, makes sense. "--all" and "--alternate-refs" are both supposed to
limit the revision walk with boundaries that we can already reasonably
assume to be fully connected. Marking it as interesting is definitely
the wrong thing in a deepening fetch, so it makes sense to handle it the
exact same as we handle "--all" already.

> diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> index 2fb6d549d3..237eaba85c 100755
> --- a/t/t5618-alternate-refs.sh
> +++ b/t/t5618-alternate-refs.sh
> @@ -58,4 +58,17 @@ test_expect_success 'log --source shows .alternate marker' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'connectivity check of a fetch excludes alternate refs' '
> +	GIT_TRACE2_EVENT="$PWD/fetch.trace" git fetch origin &&
> +	test_subcommand_flex git rev-list --objects --stdin --not --all \
> +		--alternate-refs --quiet <fetch.trace
> +'
> +
> +test_expect_success 'connectivity check of a deepening fetch ignores alternate refs' '
> +	GIT_TRACE2_EVENT="$PWD/deepen.trace" git fetch --depth=1 origin one &&
> +	test_subcommand_flex git rev-list --objects --stdin --quiet <deepen.trace &&
> +	test_subcommand_flex ! git rev-list --objects --stdin --alternate-refs \
> +		<deepen.trace
> +'

This is a rather roundabout way to test for this, as it exercises what
we're doing rather than the actual observed behaviour. But as I said, I
don't have a better suggestion either, so I think this is okay-ish.

So overall I'm happy with this version. Thanks!

Patrick
