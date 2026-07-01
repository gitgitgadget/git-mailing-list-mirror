Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78D313E1D
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944184; cv=none; b=capyzjbdOks+csQ7hUZHFKRk9H7mETvoThDfD4QVwHgghcULRiZbgGHZtNOpkSWwMeF75x4hiYGuLkJkFO6LWbTLGCoFt+AhKxi5FyyjhWzStFsTxs10yieIi1tiV7Ux3OhW95s+t4xn7QKnw8Qi/4f52brs3r9yLoKsN6jMVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944184; c=relaxed/simple;
	bh=6A4+MBvovixmYUNlzSlYFcCI4BCjzBQl9ppeu6A1b50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JcwRbnS01rLC40MgnGocUqVLNiCB1UA1pGEFE0xPkmu7Rx5vRVV4ssTJ8jM3TxWTc3xM5wbVJuBEZCyq8x5HSu/rONn5StjDc3SRFh4Z/8JPGwp00rHJ7rgkN1AKImz90rU+JQeJrdOL3abKFDr8jdu8/AJFHSudSm4UsdxzSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gZ4UAEgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqZsH3Pn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gZ4UAEgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqZsH3Pn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B5197A00AD;
	Wed,  1 Jul 2026 18:16:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 18:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782944182;
	 x=1783030582; bh=p0z0CsVuS6SNc8DSoQfivebeIV2xNOKuUftcANDxoNs=; b=
	gZ4UAEggpHfR+7dDVDXGuYOddOYeduCsCWJA/KgBXUj4J914Hf7axSKFhZXokCQv
	wTa3XJVjZUB//dugc41LbylNtLKfukseL2jWdbP+h37II0kDEj2+590t6sgNtaOy
	GbKSEzp0oktKJvpCcvJta4tnO58S/HzW5fo3dk5fJXSZJxK7QHwsGsgThBGp5X12
	i2dgi7sSM9UxADw877W0LLVZFWrHzsT4hDJ/vHzVqcIwGMc6Ber80cpo13lBLv+b
	xoLeQZMVoGAD6BxV4l+iuOxFtJ90JDJjLU6HjZhJYz2FGkYixWwE3ZNQOXe/+N8t
	sWNozUKOZtlNvDpmh+3DEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782944182; x=
	1783030582; bh=p0z0CsVuS6SNc8DSoQfivebeIV2xNOKuUftcANDxoNs=; b=S
	qZsH3PnYrWY9c/4JwsdxHBV8SAnLqUO1Kv3qZbVV4nisjNZQaXpN7OSLeYu2sNnr
	egCT18eKlveSO8KyjxThV9elNboL975Qe943JzMAvyfX2rMqOEX3+sU2TstzFSku
	hcQOtL2zS6Vli+AUhPsznIP0I0QCPPyNPR0rO7fYaNSmPbOEscagdxFWMOaZ/QL6
	yPN8B10EGZE9kUmkGPPimw+vC7WOqMmz9uWLfgXTgUT7ku565zue3Sx7M8Dtgmtw
	8DkRy8ma0hgz+40lDU8xOwwxEicIv7L5RdmNfVH0deGHt79rGVafFxwN6hPabERK
	vX+n0fc1TQqRRmKtoEK8g==
X-ME-Sender: <xms:tpFFahvwfiY8e5hvsht9o2ZSOH_IMK7acrsv9lJviVXmNP8_IDRznA>
    <xme:tpFFahc-15X5feTxny4yVV7LNMG0S-krgmV-kV2po_mqR4lo5LUbgynKuRbshnXev
    5n09ihaUxaSdodVNaGaa5ItZ7kqliyY5URIVN2eQKqoBZIpv_yJOg>
X-ME-Received: <xmr:tpFFapwnjMtQWt3MpisUv_VHUD7rlYDqBY9VOY-iR91uKG2t7raff_2iMGd-9ILYV1Z6j_W0bkFpX9NYyJQhzR3idU8aSwmEXDLR1gw>
X-ME-Proxy-Cause: dmFkZTFIOZJZtG0w8g455SenqWaAt8m0Y3ayXymmGfEevAO0szbpdIveEakmfduFPd0VQ8
    Q7Ddg0gd2IRD5aSl9jExwwpVcfwsikJXhXSBkXa8ztbURxM9fzSV0qbtQjyAF/jng9sObl
    8ZWizhNszRN1wRiZuBrxX8tyGq8IgZ8P3RoHrY67+DYbfWPGl34f7cr3GdvqxlqDecnOFF
    XyFXQLqC8US1fAwz7y4ZjzNB8ckIZKnjbuTiLHOHo3VY5CB1+AgwPc3HzZwUoQQrbdAasa
    HTp7QBXaSuHWnSvSQAQYN3IeJNrtQ6rfkC0B4ORCQF+s4IuPevrqo247Q2umPZYmQdexS1
    NTTU762bt8Vmcl9yOoYuTIIoLykkZ8TJOh4VYflqTVRWEdhExbiEOanHhlh/Q3Ac6H9idT
    u5+ew4nE5dw5abbLAc7jXb79ZRcN50Mll7uT7E/1U6vhxTI690ohN3fMM1FB9DlvIlKyO5
    HZ9EK/jhhmTYUNDMFfbCJL0DyOVBGMmEU8dXJ4HL4R5kNAhksYhNWZF3hC8ryHOVSgeLLF
    Jllgxbp7J8oL8B9YgwH0QBeJ3M/CMTVhuI+LEUmWHUgOa1O+aVmRX7wwPlKSPG2VY3KD76
    UJRIksV/AQp81PZej5TKev5sSSRJYgu0ZajvvIQaPVqp8RCHh33EHM4c0O5w
X-ME-Proxy: <xmx:tpFFanETMzvtS_FcJ06y2HaWK_9JFgSWOQP-02Cp2ar6m-5IpaSWPQ>
    <xmx:tpFFatwCpK84U7EK1CQuTq0lF7utDLKRixfwMbyDL1O7b6M_yEoZmQ>
    <xmx:tpFFaostzdwBlTopmDX7xznM2aWt2vSd9xOsexp-COF4UEXZ1VbtUg>
    <xmx:tpFFaq1ZVmheUDZf-fzczM6msk_gUGS8mgNIIh__bZ4vbXQ8BfzQ3w>
    <xmx:tpFFaqwv8V1IevlnWLYOA3HHs7SwZf9kt3C_mQg2jq6PRogRVq7ugPKH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:16:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] rev-parse: have --parseopt callers exit 0 on --help
In-Reply-To: <20260701212442.1430084-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Jul 2026 21:24:41 +0000")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-4-sandals@crustytoothpaste.net>
Date: Wed, 01 Jul 2026 15:16:20 -0700
Message-ID: <xmqq4iiimk3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The usual invocation recommended by the manual page is this:
>
>     eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
>
> Thus, the fact that git rev-parse --parseopt still exits 129 in this
> case is irrelevant, since the "echo exit $?" will print "exit 129", but
> that will be after the "exit 0" printed by Git—and thus ignored, since
> the shell will have already exited successfully.

Yuck, but ...

>  	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
> -		fputs("EOF\n", outfile);
> +		fputs("EOF\nexit 0\n", outfile);

... it does its job ;-).
