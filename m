Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963333976A0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957759; cv=none; b=XWHlipfkxL9011K6zcJPzvwBfupmhb5/TJ3GJ8mMIdUANpgvN10avA4/akRFQBez3FwcFcytG6KS0m+ODP/pALwH+XdDdRwMYoHEUwy4AW8F7n9eJeNIpeGtqWEAK3TODX9+E5nI4j6x4CgiEuIuN0dwA70eEehHs8htIJVhKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957759; c=relaxed/simple;
	bh=iBep1ZnlU3L8c2zU0KoBZscGcIqCv5ModbeH6HiPfu8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfd6uMYfJr3Vtpgf+FdFHb9g7LsC6jfS6pd7v1gd4MGiVVzHWNrwkqE5ogm+4ehTxLIycK5nkSuilkuM9HAh/J4ZKkytfJIF9G53R7PA5FtRugatjXQ7fYDBkPxLh/5jOwiouc+K8hKOTlJ8w+/AWroF2Z2QqQUj2RWN9v53C7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qxBv5y2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCJAviTG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qxBv5y2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCJAviTG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC7581D00098;
	Fri, 28 Aug 2026 18:55:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 18:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787957757; x=1788044157; bh=+fxmN2aRfD
	pS5UZdkyZtapy56TTeuG29UzSFrn1dEX8=; b=qxBv5y2G4Y2B+cG6+STnPgrMqV
	gClvd8DgLqiJ2w25LBGrqOzeEYKc2purvkqWyW5Z7oJFSs+dNHardlB9/EzfeVOD
	jgEEgx+ev3vF3Vtr4pAdHNrZgR/JU8lg3l2ef1ji/1SLyvmEuXNZNDIOs0dcIXj1
	YDNuJS+Kv6jfAo0TVQRldOQKgZP4ZSGOdNc46jXyjtCGlrUaEHGq+gSNizQ1tob+
	JX1l97OUvKGRo2oHn+RexcvC40fA5UaiZmVW96f/wa0CJadWFXfyq/G4dCZn3l+c
	Z7RhK4JVvEsbOR3CRPA1p0sVdCeXn0ZKcY4WjwPM59wGs0PSLwb5B2LXBC2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787957757; x=1788044157; bh=+fxmN2aRfDpS5UZdkyZtapy56TTeuG29UzS
	Frn1dEX8=; b=gCJAviTGev9MYgls3/qtn9htTTlBHx2gR6qXkId5f2dskNPb0FI
	AIfz/8AY1YKA7jo9OVkKDiWbeyIASQ4iXMwvz3gwnmot0Qf3Y7yNYYS+VRyR0VHs
	9I9py8spxwPRuZ7EUv//O+GFSltqaN2dnbAtv5X7kXwg8M9EKxUpbxV9CSB2p9jw
	7/AvmxP0/Pk7WHJF0vrpw/BSLiagVyj4GMMEf5/QeEcufVzStG0GB5jlpSkuZzLM
	Sm8fIPNmimaZeB37DhP5YsvPW8lryGCLWDiwPoS9h7IWHltY+dGZ71m1j3CB3IoS
	6DIcveNKD9xf9JyGOK07asafzRiebav52Kg==
X-ME-Sender: <xms:_RGSajlMqhwbnAufIQwLxwVF0VrVev1hrlgVskwdYQe445osd188mw>
    <xme:_RGSas1JHcB-Md7SZU6nvxg9LSL2wOfoyKQjrZd17yh1BJnV-QCG--ha9hwb433S3
    qBxqdlvVrKMnTY25FhRKtZv1yBmx5SmLF64rWlDJzCBLydUWcrFu8k>
X-ME-Received: <xmr:_RGSanSQCyBZvg-g8I68zQqwkr7nzoIR7KOBMAT1B_DKKj9c5WqD_jqYMhFvCDHD44PmNiQm7vLzs_TeYN-SC-4rJMXOdZ76sA>
X-ME-Proxy-Cause: dmFkZTEVOAi6cMMUEFRKe6v8X6mpAghs98DTCNi8Z/txgrjnNWfFi0Atzshd08Hk3tmlWD
    MWwV3+LrRxgtpacw24HsPl42mFvICXjDLi602Aw9r8WxoU7XRTAZmGYZ8U/IsDpp7U0Xpx
    H/OROW1h8jD0b62JluQdDm1U/u5k4dRBH5u6I4zhWfv3OG72qnDqQEvJINKLhz94cvK+EH
    0xa0YwN+eTepFIz+WxA37UTfmK7Iuf2lYWTzzHn6DWAaV6EQeBMQAFlJbskbY29Ir0wSu1
    QUu04x3M0oeKjygP731Ju+imBcz52R8h5Vbcv7gbzmsXqMeqYH2nY/QI6/v6ffZN3eIqmu
    zbtez6ONBZ8zF0psMLZz8CFlHCXxhaNBsPFUDjUAasJJgICPGBEp4xxobIjmhV1H/OHzeE
    qRN8dr8+tbTpT0sajxvlTDQ4Tz0s3WtXdP+cH1+t2coorTsw3oX1SzIbA/YyHX2kQEc4PD
    4KoBqfOQ4onrpn5N0t2zIDpWRqphezy6uBWdh99we/zSGYpBMY1kMdcg8JfmPDed7tQ65a
    SxiKGd40nVtyL/NTdFP0ye04DhrePhv+lzmlXz+ceKtzAirgNOumuYp3DYpULU9o+WSlN0
    +G5pq+3siFiVYXuBntES3jsn50vYa7e2LjCeXrSMrG7sXygpKm0JURHWyazg
X-ME-Proxy: <xmx:_RGSamsCf_N0bxMrfOVjcINw_1c9UwmEEzuWZd782VJdMnFJi4uFAA>
    <xmx:_RGSakanqrdzQ06S1t7di-_Qpivz2864fgF-jztpsXEcigBKNLlADg>
    <xmx:_RGSajsIEgw03OyHV52KVPDTWMtfNLFR_y53Dp6ZRKYXM_WEfcY4Gg>
    <xmx:_RGSauE1C_N8mkoA8URJ0rerx9gsflhJkUYuIL6Co7Vqtyp27A9LXw>
    <xmx:_RGSau_q3vBaQLg97AgwV7JiZmQtOt5DprMInhsb-TGvWuy43vFj0j6_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:55:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 7/8] checkout: wrap overly long lines
In-Reply-To: <20260828225206.310500-8-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 28 Aug 2026 15:52:05 -0700")
References: <xmqqh5kd3lm3.fsf@gitster.g>
	<20260828225206.310500-1-gitster@pobox.com>
	<20260828225206.310500-8-gitster@pobox.com>
Date: Fri, 28 Aug 2026 15:55:55 -0700
Message-ID: <xmqqcxv13ldw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So far, the patches in this series have tried to leave the original
> code intact as much as possible when moving it, to make the
> refactoring easier to review.
>
> However, there are quite a few overly long lines that are hard to
> read.  There are also several manual checks for mutually
> incompatible options where die_for_incompatible_optN() could be
> used instead.
>
> Now that most of the refactoring is complete, tidy up these warts to
> finish off the series.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c | 54 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> ...
> +	die_for_incompatible_opt3(opts->new_branch,
> +				  new_branch_opt,
> +				  opts->new_new_branch_force,

Editor slip.  This should of course be "opts->new_branch_force".

> +				  new_branch_force_opt,
> +				  opts->new_orphan_branch, "--orphan");
