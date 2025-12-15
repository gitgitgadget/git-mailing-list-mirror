Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE831B117
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776813; cv=none; b=BULFykmaNPicNm1Je3TFmt0WlhG24HLip/mxE8qc13Rnibofthj5ha5OYqUNv5S/v1ASjuWbWBEEdp4q/Pz574EFBoOHYhPEMlAHJxeqacy4MO7W9O48k8uVZojsJYK7t2pDDutqXFqYJvda8pf4jO1cqUoRSxoON2InMxUIR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776813; c=relaxed/simple;
	bh=JZgW7fypU0Ql/hzeBg20EeiadUN6GlWB+i5wphF34wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5EmqNXppnCN8aY1UtT3inFcSBCsPuc6S/0hfTOPBGwA8mgxPJASqBkl2nigZJyoDUkoDVD2Eat77KgKTbxGlA/l6O1ngfkahRC6K8LN1agrg4ek+xkMBH8k2Ygoa5tEi3YfoSjv/nxEYxbuYxWA+8OwAEUbEXEbcLO0PaOL114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rR/8Qr16; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mG5+8xb3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rR/8Qr16";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mG5+8xb3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4E5C1400186;
	Mon, 15 Dec 2025 00:33:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 00:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765776810; x=1765863210; bh=3DHwjGxiFm
	YemVgVNHn/B48TejZ4c1n06a+105oFxiY=; b=rR/8Qr16LHlZG59jp0KwoFNdIp
	YchcRUqZXZGp1Ud0S1M3AEb9HxOmT4awmgdE78Y3Aj2K+cq+kySxtzYa/2fDHPTK
	oWyM/HKsMWCeTqxUa0p0jCMLDYxyG6oZLpod3OxVheN/OjowKQ0BqVKl4Z8UyGXR
	EU5QIiXgAjAPJUmMeHpvGIuW2rJaIicGUPNwNGcTyQ1IR5VV2FR9LGQjB1d4y7Bi
	wJv+1yPvQl0mNRqrWO8IT8T/vlbkyHa9E1TbH/TQlYzqI4QfiWOGaaJ/S8byoXSE
	oQGbGSF9r2a4eSat0v68caCXNQ7m7MtZbdrnweNWf0kQSiFHTxlozWdZKPGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765776810; x=1765863210; bh=3DHwjGxiFmYemVgVNHn/B48TejZ4c1n06a+
	105oFxiY=; b=mG5+8xb3aessTw0I4zT2VhE+XOTXkX7V3GCzGr1dK2ieNbiBFdQ
	4v8ZEhZRp9wLsscEwwbQZ+dshIOgFJRBKmHFgb73BPTYvVfxuCc2J6u47SNXfJ27
	YcWKonHthVop/XvLv/RYRGBvoeSo32bW9qK2v6D9YitBo4+g6wCcZWnoDtMja94F
	4jGwn/5itwNbzxINxhAjGOPd1k1TYvzGuJ0uhRZIzqyqzYNWkUlNVkBGI2UTvFBd
	Lh4qjKjuV1YHKX1achesVfESJ1wfbCuqGDeIgjbw3OWzfKxhG2ihyYWpqxybNaya
	rKoD4pV4Kxm2+7icK8qCtgO3bHXRjXh182w==
X-ME-Sender: <xms:qp0_aUrQ2RmvLE-Moa1DIp_HR79w7EbbWUTvYZPf-yZbqIGUqrm4bQ>
    <xme:qp0_aSEj6pS-aN03QTs6Hh0AA_moLyz2Bv49deELzY7CUIpkksjZ0YogRPTVnbfzw
    g6g7p_y2BLYelBxZElTNtm7VunB5bhGV1GowvrEu3LP07QKLu0>
X-ME-Received: <xmr:qp0_aWmjKvjP-8fWywUhQoSoYmfl_W0W_U0wz4e5Er2WxUH7FFzoOCFXm5rD4qOxiioQm2Y74xNDJ-1R_f-ezYqkgR3lxoRGPvjz6X1y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:qp0_aVltjpSCp6HZnWwH0RvmMXTOxhgvxn8sfVMpSx7Ss8zNlbZRHg>
    <xmx:qp0_aXsAUJ25JMTAhZDswfllf4VWQeQQM73Z3t7GpqrMriFkOlb29g>
    <xmx:qp0_aYk3dAFBJe2uaj1bIS6PL9XI0vb63z90_Gicr33ZlFiKkW9IKg>
    <xmx:qp0_aSvFf3bgpZZfX_QlCsmTNIw5tXqPKwWDEpQeULzIik23cViDeQ>
    <xmx:qp0_aaGgNSriowdWO_X71B8txvE18U9fK4dkpx2IM8QrswGxUESIB3Kd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:33:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8dcef76b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:33:29 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:33:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
Message-ID: <aT-dppZm8TsibzyZ@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212223644.3090879-3-jltobler@gmail.com>

On Fri, Dec 12, 2025 at 04:36:39PM -0600, Justin Tobler wrote:
> diff --git a/strbuf.c b/strbuf.c
> index 6c3851a7f8..1fb47bf21b 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -836,55 +836,49 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
>  }
>  
> -static void strbuf_humanise(struct strbuf *buf, off_t bytes,
> -				 int humanise_rate)
> +char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
>  {
> +	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
> +
>  	if (bytes > 1 << 30) {
> -		strbuf_addf(buf,
> -				humanise_rate == 0 ?
> -					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
> -					_("%u.%2.2u GiB") :
> -					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
> -					_("%u.%2.2u GiB/s"),
> -			    (unsigned)(bytes >> 30),
> +		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
>  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> +		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
> +		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
>  	} else if (bytes > 1 << 20) {
> -		unsigned x = bytes + 5243;  /* for rounding */
> -		strbuf_addf(buf,
> -				humanise_rate == 0 ?
> -					/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
> -					_("%u.%2.2u MiB") :
> -					/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
> -					_("%u.%2.2u MiB/s"),
> -			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> +		unsigned x = bytes + 5243; /* for rounding */
> +		strbuf_addf(buf, "%u.%2.2u", x >> 20,
> +			    ((x & ((1 << 20) - 1)) * 100) >> 20);
> +		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
> +		return humanise_rate ? xstrfmt(_("MiB/s")) : xstrfmt(_("MiB"));
>  	} else if (bytes > 1 << 10) {
> -		unsigned x = bytes + 5;  /* for rounding */
> -		strbuf_addf(buf,
> -				humanise_rate == 0 ?
> -					/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
> -					_("%u.%2.2u KiB") :
> -					/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
> -					_("%u.%2.2u KiB/s"),
> -			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> +		unsigned x = bytes + 5; /* for rounding */
> +		strbuf_addf(buf, "%u.%2.2u", x >> 10,
> +			    ((x & ((1 << 10) - 1)) * 100) >> 10);
> +		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
> +		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
>  	} else {
> -		strbuf_addf(buf,
> -				humanise_rate == 0 ?
> -					/* TRANSLATORS: IEC 80000-13:2008 byte */
> -					Q_("%u byte", "%u bytes", bytes) :
> -					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
> -					Q_("%u byte/s", "%u bytes/s", bytes),
> -				(unsigned)bytes);
> +		strbuf_addf(buf, "%u", (unsigned)bytes);
> +		return humanise_rate ?
> +			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
> +			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
> +			       /* TRANSLATORS: IEC 80000-13:2008 byte */
> +			       xstrfmt(Q_("byte", "bytes", bytes));
>  	}
>  }

All branches use `xstrfmt()` with strings that are essentially
constants, except for the translation part. So isn't it possible to drop
all these allocations and have the function return a `const char *`
instead?

> diff --git a/strbuf.h b/strbuf.h
> index a580ac6084..a5e3ab0cb4 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -367,6 +367,15 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
>   */
>  void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
>  
> +#define STRBUF_HUMANISE_RATE 1 << 0

I think nowadays it's a bit more common to use an enum, and I think we
should also document what the flag does:

    enum strbuf_humanise_flags {
        /*
         * Frobnicate the string.
         */
        STRBUF_HUMANISE_RATE = (1 << 0),
    };

Patrick
