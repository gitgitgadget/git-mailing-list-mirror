Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4219307F
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542726; cv=none; b=d2ZbIyPg0fsggVOAgBhVh5H6KSYXbWiFK+s7uvkpL8br0uvjMJH4jLB+OdC/VgFEnHa5F+36E/rWKcRtOTG1maRSqzlOoRGKMKiL+0XhTSty/lsV3fxp8VjJbrmOb8Bg+PnC23SSLUy/dlBwZtAlfv4hvvINeK0ddSplqJIJx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542726; c=relaxed/simple;
	bh=7tmnC/adcFC1HrBXPrHmI6EtdE/P/MNcNqMfZrChqSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6hjutiCHNiODxZS4IKYUbNpbOxy1oWC8b2J2Xai7mkzj5uv5lOJSQ8xVk6wdL8+hcTFAHjZQqk/8iEVLvk5Mu7lWwm5dST8ZYrg8UAs3C3ioYXRpL6MeNBpJeeXuE2pM75CIFEb7xP0DG2G0TZ42bloCv0OhsZQ7gc9UFcMZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G7qDRkMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SM9Bzs4k; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G7qDRkMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SM9Bzs4k"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DAFC71380507;
	Thu, 10 Oct 2024 02:45:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 10 Oct 2024 02:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728542722; x=1728629122; bh=I9FJ5cnov+
	/xCfM3YMSYMNLOLLSDwTcMQ0y+0WFNuFE=; b=G7qDRkMx/fwROTLU5dAFzoH4ms
	FNE/xyiIGOP3EafQ/2Bm7w6pAsdUynGXeq3tPie6VyZzsAMSj2xPa5TwNjFC5fyG
	knkOor9doJxz4ehqCxtqemNkkSmHuvLU872S9iiA6TAhsNK8VoNcfkKkTkRCJYaH
	c8KATm9mWjJLzND5s+XEk+D5CYvPennUr+RY6PLfbfURvJqYLJLSxC+ZybwrlhnJ
	NfZnRE/6Y63Lg5gMBGHzRkjAloBT9VpTzKqJajd26+VmrxtIXGBxrSGyPvj+8A9v
	bNgPaU6rn/oTi7X272N9ZrjHrVMheTtV86akfVkmMdseQIyjDgTXiN3e+BXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728542722; x=1728629122; bh=I9FJ5cnov+/xCfM3YMSYMNLOLLSD
	wTcMQ0y+0WFNuFE=; b=SM9Bzs4kOpzEhIRx0oQSrWvCN2nYRLVGtqpLySxNtmo8
	1XMsjZiuKI+dc7yR27ZrhXpQYpOx+kWxArbYyM+y6DHgVUKKKoH5wlyHFJE5dWK+
	Tsi/kYZXXxpEF7fcxfSFixXMww+yubBFdy/dF3FSKWrBc4BZt8w8u2youJQpXihZ
	a9JloYozmndKEM7tglhoxZNqVzv0dGVFBFvEXSi0+yZYMBl+ZsfKpgWNRQbhlnSU
	8hgzIRxLRh09kr9tbpdZd0Hv+P4Vv8MezvP2EvH5v3b8sNf0zRys+/bIUwECsGst
	NHRnz5doeDyvx3Mg6Jixs5YNA2XupQ2Zm8dchmjLoQ==
X-ME-Sender: <xms:AngHZyyG3lKmnTh7WV95in_i5GJcQnS75UAPyt8g0ZUxtu813vlbVw>
    <xme:AngHZ-TE0FVsCbf2JTAupT5g_k94aoFdWLq4b-90VkIzT-9bef_Dt6luoLifd8W83
    63HUvJo1hGjRl8vLA>
X-ME-Received: <xmr:AngHZ0UFWUzft4pSz8s2URMvALjHcve36mMkUFBAkr_PD2ggsDR4zPjM-uLj3gk74ilcT2sML7hkYdmH7BQ94tfDyZ-pn1uaLIKZe6DtUCVATZbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AngHZ4ioInP_c1oEj4CxjqjIQd1P4p4jBL2X7KtwyBp_ESe6xzKwEw>
    <xmx:AngHZ0C2z7Khh1OQpY2m1hmVgPz58WE1FKvFqkacpFo4nXFnqomskA>
    <xmx:AngHZ5K1FMRfWKR61vLpRkE3QO95MSODF3Z-ocn_np1vRsS_cUsgCA>
    <xmx:AngHZ7AMKIlKH-T26BIDdkXyYWeFlkmEHW97nlTFqwpZhG7tWe6GPQ>
    <xmx:AngHZ3NLA-MSjGpMluU8gD6c3xLPl6a4B--EhTaI9ptRLFE8q3E55i6C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 02:45:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b743493b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 06:44:15 +0000 (UTC)
Date: Thu, 10 Oct 2024 08:45:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] loose: don't rely on repository global state
Message-ID: <Zwd393AHNAGQ_zAx@pks.im>
References: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>

On Wed, Oct 09, 2024 at 02:58:59AM -0700, Karthik Nayak wrote:
> In `loose.c`, we rely on the global variable `the_hash_algo`. As such we
> have guarded the file with the 'USE_THE_REPOSITORY_VARIABLE' definition.
> Let's derive the hash algorithm from the available repository variable
> and remove this guard. This brings us one step closer to removing the
> global 'the_repository' variable.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  loose.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/loose.c b/loose.c
> index 6d6a41b7e5..897ba389da 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -1,10 +1,9 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "hash.h"
>  #include "path.h"
>  #include "object-store.h"
>  #include "hex.h"
> +#include "repository.h"
>  #include "wrapper.h"
>  #include "gettext.h"
>  #include "loose.h"
> @@ -142,8 +141,8 @@ int repo_write_loose_object_map(struct repository *repo)
> 
>  	for (; iter != kh_end(map); iter++) {
>  		if (kh_exist(map, iter)) {
> -			if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
> -			    oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
> +			if (oideq(&kh_key(map, iter), repo->hash_algo->empty_tree) ||
> +			    oideq(&kh_key(map, iter), repo->hash_algo->empty_blob))
>  				continue;
>  			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)),
> oid_to_hex(kh_value(map, iter)));
>  			if (write_in_full(fd, buf.buf, buf.len) < 0)

I've already had a look internally and couldn't spot any other things
that'd need to be converted in this file. So this looks good to me,
except for the whitespace-broken parts.

Thanks!

Patrick
