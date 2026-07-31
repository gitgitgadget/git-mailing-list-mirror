Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E78C1F
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483500; cv=none; b=NvatTUPOFglbdomhhzOxcePPAPBU64tFkg4BMLc7ujdpY+tfi3UKD+t9pRJ7mqs5qpQzpxHZZ/6kRNhI+wK3YH3CCXPrZ9OP6u3Ch+Tl+Y2Zp1yk3+9BrO4PhXrT1ZyHCs9RggDrcVkjXpti2Z2v8YLS4K1jqINx0QZKprV658Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483500; c=relaxed/simple;
	bh=OaEdsNzE8xIJMKTTxcR/guZhNn6VR4GaLfIG+tPP3pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGekNIwJsKJ6dZWuy+uXmmk/KN8rphzE/Cu6qleY4F6WJNgmZKfKWuFexksR6LLKU8/122uaFFo0KMld5dbUiAdKPzMZ3h/Xs09AmA69+WeubLaSMf4RLOzzwObM6FIxBJavO2AiS4j9HVjFaDSsR8M6vFJiob0AdwI4GBbWJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rVyucbLs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZYj2DUOV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rVyucbLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZYj2DUOV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 702C21D00154;
	Fri, 31 Jul 2026 03:38:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jul 2026 03:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785483497; x=1785569897; bh=Oic9UKf3MV
	gKbbNYy315R6NrpOwiDPJWlXSckOg5dfA=; b=rVyucbLst3QRDlg9k3pGj2fJSl
	unuk8babyeOQUp2rkwFZgYRLya+6ZM13ecqnLHN2Y21xc4IkM3HAtDKu6qML3lvN
	0qu7Tb3m7wLvOdR28zsOXWoasLsXle8dXiDtuB2ZPADoHTWifNeEbAcPOhbW9Y/u
	2h5A18wCCTTv4UEUBj/zL5eEE4U5BHTYHWMCeeg1KtAL32WCcxmV6XssXsAjq0iP
	UmuJ3xqT/pDrWTLeNYHvqiQO+riAv0M+rWU3Qy+kuOMUjY2M40TL7maEnY5FqE67
	ijr1BdrKzk4UGiiKw2IEn1IGpiffW30ATAO2If6OlitFORYMIKy/EvZFep+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785483497; x=1785569897; bh=Oic9UKf3MVgKbbNYy315R6NrpOwiDPJWlXS
	ckOg5dfA=; b=ZYj2DUOVgOmYLBCZR+L/Y5wAqitznqro5aLmEF3TZuOVTdBhPpd
	B52zBV4/WJ5GHeTzPo8Dnp1515Q9BK9ZR8FYx5Cz4qYZtNAzkR0J6WE87JfBnnwb
	esNsdg2ST6LrzhkiZgakkAxBjyYSbDYl2Fd3aTtEcrAlPJUTIYU6KnC+kTwJ22M0
	kYangkkQsu8E9ySZTp8vXvzcJqkcE0mDDaioJr30NRveBt7cen4Gh+HsArhTRiBu
	+5w/UB+9KddaYjV5spv50FwuWfc9djsUuSIy5ZdFN5BdhM5tPPv4g1UWNdUAUq72
	oOrur+cZ1ZJWkFVI7AIv0MYYh0ZCeFrV/Qw==
X-ME-Sender: <xms:6VBsatCpe4u3ulfY90kv7XxeKBRtG3UTssk9UvKfG7Y2s2C9xtQ4zg>
    <xme:6VBsai8lyhuS7RY-m5ApcZjwBhs2FYc8AwtTDzykeOshALAul86ohY0Xne1GmQXoZ
    XIYQS2Npf-jWmzuGQP0Wl1FkU9eYea3vexBAl1nqMoRal11GXcrRw>
X-ME-Received: <xmr:6VBsal8XTLAqUlPIJmKPOGxM-CLbOkfPGvQq1sHpwbtYHrISr3PYA8WpcrCb9s93v_sCVEQyx7lRKftjPX3BCZjYvMIsRYgBpA>
X-ME-Proxy-Cause: dmFkZTGj0GTUdTl6CIQp35mwmzM361pUXpoawQ1bW7EvrP6j3Wo1oDhVoAgtB79lyu4MIk
    gJPI+tyjQG/oXb8iikGSCvUtZDgZGu7DYME+6kQ9ITYtmEJ4ZV8Yvgdp3hbf5+E6yB4LDS
    mLsp4+89zPOjOw3W5SlnN6rrkyDvnEe6rZaFdfeSrKg9Qyb2thgMs1sPTsUlJA8bokxFie
    3DE7I+7PgM35eoif80rZ1sROKtfxdB+klOHdktsTglqClaV5uf+4YZzVExN9HgPemeka8W
    MqCrqR7fH9LJdxcsfJ2KuV0FOXAF3rlIyOttUASNgHldSOmPu38LG9VnZxAw+R2CIMhpHp
    hnyvTQRdRaXzB1b1SEExwumOTh/GI260VGCwocQMp2qWS/w32w1N+gBjadlYdiTM5Rwk6h
    Ady4Pb9QnGkLuEonMX7H7GQB8a0TdR78FRZjvBVi4ueuIsPuYyQoE4vYuBn7lXXNVQpJoY
    +d36hqzLVdUidhiYNLDJDlqbtjdroJYjMaeAbXTK7ypRsr8rVS/ZrAuVqLhf8k8Xx3y5xE
    uCQbHzf+j65aN6Z4+/+YeVYUcSBpoK5DCEX1vbyAzRwE0XT5QHbB0JZf4jkrf/mlFG7riY
    a+pFhXLMfK2C59sOMHrAxa9oHll0a+dzSMWP6BjDdX89pDTaXOTuaWUxE+aQ
X-ME-Proxy: <xmx:6VBsahfRw0MTsXSB6RALeTeMJvxwV2fSQfcuK7v8pn3qAYQRvtJS1g>
    <xmx:6VBsamEs0OVmKr0n8kTjfDI0oQ1yLyn_6Jk3QGiEsNUAwinCtE9wjg>
    <xmx:6VBsaneMf_Ou1onJqdtuLuNHOrU3w5A-MlBe11NhqyTQpqAvsahdtw>
    <xmx:6VBsaoHCCGOSX8NL1hMgOI-eUTJta6rpNQ3CnmbFVlODY_RqQYk_FQ>
    <xmx:6VBsavJKWqv3yoaiEBUZBLCMj915_Q_UtaebR_3WceAeo6A-dHlnHOnX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 03:38:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] hex: add functionality for lowercase-only hex
In-Reply-To: <20260729233215.398654-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:10 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-2-sandals@crustytoothpaste.net>
Date: Fri, 31 Jul 2026 00:38:14 -0700
Message-ID: <xmqq4ihfip7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We currently allow both upper and lower case for all hex values in Git.
> However, in a future commit, we'll want to change that to allow only
> lowercase values in some cases.  To prepare for that case, provide a
> table to convert hex values using lowercase only and an enum to let us
> choose which we want, wiring it up to the hexval function.
>
> For now, keep things completely the same by specifying only the
> variant that accepts both lowercase and uppercase to avoid changing
> behavior.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

In "some" cases?  I wonder what other cases there are that we MUST
accept uppercase variants.  Obviously the network protocol where we
are willing to talk to reimplementation of Git by others is one.  I
do not think we historically produced anything in uppercase.

> diff --git a/color.c b/color.c
> index 00b53f97ac..9015d0faf1 100644
> --- a/color.c
> +++ b/color.c
> @@ -72,7 +72,7 @@ static int get_hex_color(const char **inp, int width, unsigned char *out)
>  	unsigned int val;
>  
>  	assert(width == 1 || width == 2);
> -	val = (hexval(in[0]) << 4) | hexval(in[width - 1]);
> +	val = (hexval(in[0], HEX_KIND_MIXED) << 4) | hexval(in[width - 1], HEX_KIND_MIXED);
>  	if (val & ~0xff)
>  		return -1;
>  	*inp += width;
> diff --git a/hex-ll.c b/hex-ll.c
> index 4d7ece1de5..fa85e91827 100644
> --- a/hex-ll.c
> +++ b/hex-ll.c
> @@ -36,10 +36,45 @@ const signed char hexval_table[256] = {
>  	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
>  };
>  
> +const signed char hexval_lc_table[256] = {
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
> +	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
> +	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 40-47 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
> +	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
> ...
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
> +};
> +
>  int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
>  {
>  	for (; len; len--, hex += 2) {
> -		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
> +		unsigned int val = (hexval(hex[0], HEX_KIND_MIXED) << 4) | hexval(hex[1], HEX_KIND_MIXED);
>  
>  		if (val & ~0xff)
>  			return -1;
>
> diff --git a/hex-ll.h b/hex-ll.h
> index a381fa8556..da1b5239b2 100644
> --- a/hex-ll.h
> +++ b/hex-ll.h
> @@ -1,10 +1,16 @@
>  #ifndef HEX_LL_H
>  #define HEX_LL_H
>  
> +enum hexkind {
> +	HEX_KIND_MIXED = 0,
> +	HEX_KIND_LOWER = 1,
> +};
> +
>  extern const signed char hexval_table[256];
> -static inline unsigned int hexval(unsigned char c)
> +extern const signed char hexval_lc_table[256];
> +static inline unsigned int hexval(unsigned char c, enum hexkind kind)
>  {
> -	return hexval_table[c];
> +	return kind == HEX_KIND_MIXED ? hexval_table[c] : hexval_lc_table[c];
>  }

It is very welcome to make sure we are conservative in what we
produce, but be liberal in what we accept.  In that sense, use of
HEX_KIND_LOWER goes directly against the Robustness Principle.

>  
>  /*
> @@ -13,8 +19,8 @@ static inline unsigned int hexval(unsigned char c)
>   */
>  static inline int hex2chr(const char *s)
>  {
> -	unsigned int val = hexval(s[0]);
> -	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
> +	unsigned int val = hexval(s[0], HEX_KIND_MIXED);
> +	return (val & ~0xf) ? val : (val << 4) | hexval(s[1], HEX_KIND_MIXED);
>  }
>  
>  /*
> diff --git a/pkt-line.c b/pkt-line.c
> index 3fc3e9ea70..338075558c 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -378,10 +378,10 @@ int packet_length(const char lenbuf_hex[4], size_t size)
>  {
>  	if (size < 4)
>  		BUG("buffer too small");
> -	return	hexval(lenbuf_hex[0]) << 12 |
> -		hexval(lenbuf_hex[1]) <<  8 |
> -		hexval(lenbuf_hex[2]) <<  4 |
> -		hexval(lenbuf_hex[3]);
> +	return	hexval(lenbuf_hex[0], HEX_KIND_MIXED) << 12 |
> +		hexval(lenbuf_hex[1], HEX_KIND_MIXED) <<  8 |
> +		hexval(lenbuf_hex[2], HEX_KIND_MIXED) <<  4 |
> +		hexval(lenbuf_hex[3], HEX_KIND_MIXED);
>  }
>  
>  static const char *find_packfile_uri_path(const char *buffer)
