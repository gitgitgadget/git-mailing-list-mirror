Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520C25DB12
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766716; cv=none; b=eT19ZfBIfu0AIGI+JleTZmVgXIpNE5FZfhrU5Nqp0j/tOS0igVyNzwgl6KloavdPSA44jdE+6hk0JRYjTkpGJuNbFBtV5J98KNnXJp9tc8t6z90uYm00mBeefQ0rJI67+7UKbVD2+EaE4DSKAZEO0zj+Q0F1FRaB1afM59nJMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766716; c=relaxed/simple;
	bh=LWaQe9NeFpdwUvoKFhXYF8qpUyN9oJSJDuO+d3t/iks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dpk8VBxZKhhelny1ddWXlTOXa+90eQnm5XOv+jfd8DBYDvKmNRzSMvAKR7TM3xmvRPuSHOhFm2vigvQLpwjFTTV7rIANjldD8qBAV3gpyd/mfTC8dgxzlw8Li52lXuSEHd0ADGn0QJymGsmF35MEZNLWTMCG0MmuEt/lFjrTBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lPJ59jeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKsnYnPf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lPJ59jeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKsnYnPf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 367837A00DB;
	Mon, 29 Jun 2026 16:58:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 16:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782766714; x=1782853114; bh=DZjIBTVY/P
	bTlvQ/9Xti5Hq2ho+4femWLrWNNjVX53Y=; b=lPJ59jeJ+3f7KPMKVy3tPFUPZj
	VW2Xv6NYt7Vm6VyJChn01GVaAluj5f/BIykmQCgi2qwT4lFzrpnZmFfxhMbvDAC2
	FkRzu/7R8QkaPace7lscSNxrWeChU7IME1UfiVhOLstn6MyKUzmt+sWgsRBRH8Nk
	/YNAZK2FU0MporjjDO518gQqbcOgwwZjMwmf64r/UsTA5H83vk0shfB9tO/8dxUq
	P85cCszJn6ZJNBc3IfgXWy8iOYRJ3Y8VQMOvDhh/t73QeTEbcmwvtAEXEpc4qvhU
	wa+Au416C463DSvHGnptY0HBC0Zjt1R4wkwq3CV6ki/esoYtKrn8UU3ylYNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782766714; x=1782853114; bh=DZjIBTVY/PbTlvQ/9Xti5Hq2ho+4femWLrW
	NNjVX53Y=; b=CKsnYnPfjx8KXekWry/gtHN0CEJuBlrURMdn29RI7nTGn5zyBl1
	/evZXeSXHzRgQgjynyAhbSD0LhccjeToTuQWQxf73e/0kp9CBDUK5zhR2jK/k2gE
	drwjHXa6Ji+7zwZg2Vs63xdFjz9ZI+IPSkY4pgPyK44qbggro4dOM5eT57zSn45t
	pvh4eUBa6bHJb8aLut4sCwIk+h+MvzTrt67ckJByr4pAxWXefg4GiD3Zgp9Bod1C
	Pr6fVIm7YV8UdPkXZQGorJL09AHcyDY78qHnm+X5w0j+PyCWo18FINNqkvzBnlZC
	uW7HfmFDX+0q7/ng5vR5G1WEQP6FcHUz0oA==
X-ME-Sender: <xms:etxCap8lmBnaokqQDaj2q-X7Qg0rQX9-G2-Gf12o-1J0gFN96xCz7A>
    <xme:etxCalLW-tnU4VQUadtbE18Lw4x2lhGuktwoi58iqkDbDpvS_0KRNUkcSN0GFMIRe
    nqgKsaLQaTPZNEG9HPqjFa1qImkzfZLS9LZFQUzdbjpvfALbvLhSg>
X-ME-Received: <xmr:etxCakb1cBBNYOllLBkSiaAQTFed5CtQ4k9ZfcBotkuedVEHpE4vYq13kqmcWgINhWK9KLlMl6sKxpxbTCcLrkQQGPd6f0hxQLU5RV4>
X-ME-Proxy-Cause: dmFkZTEI6tlzO4151o6iuwoTlm6UEg5crPzDfxYnErNHFeZeAcTKcVYnY1yx5MtlGloer1
    uZ9KsPsm5E3wtFhpzCXTHBEn8DJOi9ysGwMEBTP4LDaOTtBQNhFQ7PvFCK/VkjZljif1A1
    K7MXEaU5b4TWtQt+rZM2pRHvM2JOeCwZBh0//2yHlg1e/q6pRiKyfi4EmOuthgylXngbXU
    0izhh53++rmQmcyuqetygASuyrmhaiIzwnfFqzpV8ZU/dCnh8vXzUV8lP7ja5Ii8skm42Y
    iJ/PRPiK5taOlTNxoogucTS/NOenpPyhmq2rOKUOMh1KyH8xqkzJXX6vtnsyCX/Idhnya8
    piteqU+xqVAzce453cky/WGdN99qVy0hTl79vmfgMCA9Xrg26/VBHD4ifuz0RBa3H6D0bg
    nwK90838ckb0daG6bkCyfg3M0pxnDIEPdJmncL/m/vFQlNS/izYk+J3hlgQU0G5ZXH07D8
    hUM6Od7jo/G5PhohylrWPDCCFMi5SKxC9j2fFtJQxXD+DHoiARM8cFLjoH3DQvlf3e+TKV
    fUzTikI1hAT/LqKSoaLRB2+kHrH95d6Kxe0427Y4cw7xBtpR8XamBfhuQAuDCL50OXpbid
    aRzJaDCWis+q86QKyRDXnTAvzQaFwz06yEUR9LSC5dVkGWJjMvcxfQNwgu3w
X-ME-Proxy: <xmx:etxCanLWxzUJxdlFj9-Gd-z20c21k-u2u0Z1HMgp-HwzbmPTXSijtA>
    <xmx:etxCaiA2Omj961VUQHlJNNUC67wQTNQDKtzJWuh8nJBPUser67yxgw>
    <xmx:etxCaspMe11a30ra40RKzEezInwbfUG6G65kyoH6wFXkGGOtqoowHQ>
    <xmx:etxCatg3iPjxnznYYFeUYDiz8yISAAVOeaKRBkPSXDVjJqOgwY1rBQ>
    <xmx:etxCaj_bx2j2qRmCrcb5KB770-wfcqRFXWd2yfjCoen1t3OhYpmShn7F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 16:58:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] builtin/refs: add "create" subcommand
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-4-07f3d18336f9@pks.im>
	(Patrick Steinhardt's message of "Wed, 17 Jun 2026 12:16:01 +0200")
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
	<20260617-pks-refs-writing-subcommands-v2-4-07f3d18336f9@pks.im>
Date: Mon, 29 Jun 2026 13:58:32 -0700
Message-ID: <xmqq5x31ukqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
> +		die(_("invalid object ID: '%s'"), argv[1]);
> +	if (is_null_oid(&newoid))
> +		die(_("cannot create reference with null old object ID"));

An apparent typo here, "with null old" -> "with null new object
name".

Other than that, I think this one is good.


