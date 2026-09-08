Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716418FC80
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830225; cv=none; b=HFcof6o7A5+EZd9J4LlRdLLeEgGepQPqA/1fTAw173J7R7njNcowwuhsqCq+PvrfA3HXv/6+ALxfJBx8+K03cl78Bj2dh+DV0B8yNzB3Hrcknzq3D1oAi/6jFHksnhqeVm3sZ5j+gET7Zr22h7LGeva3x6NmHO+uFaE3LcWFTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830225; c=relaxed/simple;
	bh=GjWSXCnJy+AR0n2tPLddBXHH7PW0mW00VmNveBekMes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0hi6L+BQBfAsIYy8w1jP5PyFwk+1i8rZtn4RJ3KFgTbK5WaLnHg0bzjaamDCqtvojSqQBv6kEl7qAS7P0ZKGH+YimXeFT8BTM/QITF69I3KSFc3Oahq9gk8ZExpiZpJhxiOfBqZJEwxGOFyLWDJEqsJppGDe8SkViF4GtiFMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=unDrWn0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZEfCUEv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="unDrWn0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZEfCUEv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D2D11D00087;
	Mon,  7 Sep 2026 21:17:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 07 Sep 2026 21:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788830223; x=1788916623; bh=m7lKp9HGBf
	oGAlhrkMVH1e7iNbG36FzSFxRGzQzyk1w=; b=unDrWn0iMYpb0bAUhEyvXTUc+H
	BdR5T60bE7hUiku6WfEim/twKp/N5nJ+CXtbAqg9KyoQfO1yMmbpM7a3wSCeDq8G
	frrycQQ17mhOyiwUlF4s/YS/PFb1ywlKlhDlFOJTr3Jd+cQjwniFJrxJHkQSYJm8
	vxIVYhyK/feykn+sMC+vLLW8kto7xEhGzIw6A32tJY1IiqFqgfjEGTuGPSD7i/1p
	5FqtBXGmRmgBT7FoNKduVuuwtnA6+oDxIMBQg3rMLCAbdhbo7/WRYXpZ8b41dZh7
	BIhPOI28qJG9vJkhC9IiIwR2JB06YvqKAwcSxxWskcR0d1yO/nBTPN3NzEvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788830223; x=1788916623; bh=m7lKp9HGBfoGAlhrkMVH1e7iNbG36FzSFxR
	GzQzyk1w=; b=sZEfCUEvR+1e5hATQa3AsSY0NXiZvJVQPjpdRpRKf90xoxwaN4b
	PVLRBcan8nxX2wSKBaAXTG4+UwRskKFRioXV5cdDfCIwASST11oPwKA82NzgbUKg
	8VD0pWaDs6wjH3TIEa/fWeSanRSjBlwnzR9IBusGWO1czGUhsZLFnSwCXQKgkeRJ
	vz10AsPKDEeVKx3fyE3af4lu5Hlr+znSMi5xWIXl7AbEHuPrw2oK11K6dNeIGUyJ
	J5wTjc5fquKhIAeM38hqBA67CzaJlt5S/uWA8o9Bf18yEC623i0Jclk5Tw2WKvSE
	YVa/RqlZEbtqJu83gdXZbg730mBFa/aIT0w==
X-ME-Sender: <xms:DmKfakyJuRl3J56JWe3N7zgu-fL3F05GwY_sngZKE7s_xEU1YRiRJQ>
    <xme:DmKfavR9mIK6e1AaHsUWCbrEwgTxFnqiHfA7GVo2YDCMNhCN9NIeUCG3JM-0yNyrr
    tLWysbe9xpv4kh24Yj4TqUb_2XFJ7cQ9uORf05DDNo3bN8z_aXINA>
X-ME-Received: <xmr:DmKfarXm8L4q_0yGMlg2h5uRFB8GdSjpmTgjbmnF_U_ps-CxZ5JGrKz-iDbmln9xaFQqggwczdcHeSXekUaTKwpgs29WaJ2s0Miw>
X-ME-Proxy-Cause: dmFkZTGSSVZht23Dxm9N7O4V2416WbWE3OnQXvlJ7N0NiA+Bve9oSWtshhGfb1raNEnCT2
    OfJZdo1OGG0vq4OkUruEoGn86hztcMKmQclO6p+aRqEXYvHHessnzHwMEhwf8d96gQTHqd
    jesZscFc6+jiO1RvBJl25PBYfUJ7vq7nqCJO4HM+lEzZXYQAidESi/a0OXd5bAblLcyshD
    9sSx3Qa8m/nExmYrYeVeXOvTy9+a/iFkLct6nf9JGfhwiCfal4LXG8tcG3mykQr2kAAxnH
    zNUIlRTuB41DmxHw0TSp3q5TFFO5mLHR7xjhfXKP+vq+pe/+TQRMwjQ+eVwLOJ5RMWJUpX
    0VOJjSbSN4RAIwHUbdGD4M8mRKQXCtXnFQgwA8kEMq2jrbvsj3hYMEr4eiqjC73RMASTAu
    ZeDp72jeWI/8H6Mlgnj8AvUron+gq7xShAyoO1CNUDippCkMsGHc+ZNmylbgQc/FBbX2qb
    VEWYPs9Ne1JJY8q+e1Ij1Ih3EQ85m+Tije5EniW5WgpGjNLXhkFMH3jrhpweyz2aTP3Uvf
    EpQSG87U31qBXUohpsQBj1DkL6EKs2PJZ0Au4GlFTky3oW0q4utDgnwSWrKUwBNa2Vq4xU
    Qday5rgnJImgbsnTDWhc1HjZQq/4rueIM4LIVG+b2KTvXr1UlpSafsSNFVxQ
X-ME-Proxy: <xmx:DmKfahbn1DnXGD1Cho9WTfAp33APamnHnh0RTgjxPcPpgh2_iajewA>
    <xmx:DmKfah1ezbCbTUpbObDdhQcsp0eULTUuxkiM-vvsc7q_OcbiDFpyIg>
    <xmx:DmKfajhuUQGjekbzKddxiSf2y_AAhh2MuTy0lpA_K4NOPXm9AxZigA>
    <xmx:DmKfalZRPWzT9-y6uUyCgdhcesQno6Asns8RWlL3XgvvLuUxq6FEPA>
    <xmx:D2KfanSZTSoMbYUtg4kL9FEYEG1sRC3PKkH2usXd58LOy3Yz-SYAuBPR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 21:17:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,  Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 2/3] imap-send: don't expect an ASN1_STRING to be
 NUL-terminated
In-Reply-To: <20260907211210.2621693-3-dev+git@drbeat.li> (Beat Bolli's
	message of "Mon, 7 Sep 2026 23:12:09 +0200")
References: <20260907211210.2621693-1-dev+git@drbeat.li>
	<20260907211210.2621693-3-dev+git@drbeat.li>
Date: Mon, 07 Sep 2026 18:17:01 -0700
Message-ID: <xmqqwlswzgmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beat Bolli <dev+git@drbeat.li> writes:

> -	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
> +	int ret = 0;
> +	size_t len = ASN1_STRING_get_length(asn1_str);
> +	char *pattern = xmemdupz(ASN1_STRING_get0_data(asn1_str), len);
>  
>  	/* embedded NUL characters may open a security hole */
> -	if (memchr(pattern, '\0', ASN1_STRING_get_length(asn1_str)))
> -	    return 0;
> +	if (memchr(pattern, '\0', len))
> +	    goto out;
>  
>  	if (pattern[0] == '*' && pattern[1] == '.') {
>  		pattern += 2;
>  		if (!(host = strchr(host, '.')))
> -			return 0;
> +			goto out;
>  		host++;
>  	}
>  
> -	return *host && *pattern && !strcasecmp(host, pattern);
> +	ret = *host && *pattern && !strcasecmp(host, pattern);
> +out:
> +	free(pattern);

There is a code path that increments the "pattern" variable by 2.
Running free() on it would not have a pleasant outcome.

The pattern we often employ in our codebase is to have a separate
variable "char *pattern_to_free" and have it used only for a call
to free().


> +	return ret;
>  }
>  
>  static int verify_hostname(X509 *cert, const char *hostname)
