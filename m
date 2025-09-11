Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119C7D07D
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570808; cv=none; b=ZVb3ugUSpnfinqMWFz07tZm/KSs0f0j6vHW+xVLlVhsZ02lW7XgYholgMMlaaFlbeWMzMlZ/pKk5dmRlyEQFH9oY/Sp9lOt03PqraYAVPcCfCbivAZ8T6Qzs/kC3xwzRzptyf1Vo4yq3Hm+5kPd6uE5NtWb4kKXrVXyqmmKs/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570808; c=relaxed/simple;
	bh=pRcy/wrXM2KiXJ22KzVJcwmY3QXQatN4BZbJjlEPw1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9GpgWJ9QlXdJfMZz7bAFyCiNIlHGFpUSlX6vz13BqzSLTwX0153f56jRULYl6BEyxafcQ/goqBahYYfATxgY0FAC8sY1GYeI46LSr+TVWPDYIx96YDWVCisOeDOSn4PAxNtqVsjN2/lSo10VVuwqupwwdmAByUIsFfRqRBHCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AUugYXeA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W32UTb3/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AUugYXeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W32UTb3/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F31551D0013C;
	Thu, 11 Sep 2025 02:06:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 02:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757570803; x=1757657203; bh=pawYCOTRwP
	EmkHtWlrve/H/U32U9x0bxpHEaEpkqRVw=; b=AUugYXeAOCDItxh+le7FAh9wZA
	j+N14YIVQ9PgxPw1k9idHY0GOm99jwfj7XYGJvjKbpGn4Dual//4qMfPY9aMoAsY
	Go2uJXQC5ga1k5O380dVHb8Sgoqt7pP4NTea+1wxoR/dHZtxWsLyayw4oxmDpsfA
	bFWXTbuDp9LzM+jB9mbjNpwQhWZIIRMgknAAwx2kTqEchRdF5AL6gd5fQDXOBcom
	f0CGVPZ2Yo7ZEOGI3eLc2YqL+EUmEmLIZV2MZN8pI5h41PxczpyODFZj0BCHm6dV
	IIL8+8FQ4PNxolM9IMJobo/wi33ex41BwEB8eq5D871zMGr3pLdG/DcN4MjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757570803; x=1757657203; bh=pawYCOTRwPEmkHtWlrve/H/U32U9x0bxpHE
	aEpkqRVw=; b=W32UTb3/qznSj6lTGZaOSm5C12zTZM8Z6LInqTtqf5ZAQAAICI0
	X/DjoKtfc/Oxumfme+YLmo0o4ON2cneEZoVHXnR0K4acbOQ4UnQd+LKB40IDiJN+
	W5blW4UWZNzWBC7bHLaVzlWpFjkUjM8QggPt6iX8GSyFyz45LisQrVqM1PzxiDpI
	XvV4G6gXHQb4xEGkmw/bWsHpq87ibdLFidZuX3GX+mE0Ab/iy0iy+IHlur/zdH3b
	/ndktHrZXph4apAu6vx58yG8SXt3sLhKK/9pdCRZP4dkbHA2+9IZfzqtVpP7ofE+
	lqZvznqz+f1Zx3Dze0kGTKNbsw1XpOHHZ0g==
X-ME-Sender: <xms:8mbCaEVAdJuDO-espoI7wEaV7WqUTvs84pYiXQXWItVWe90libRsOg>
    <xme:8mbCaFgZZkuLwEJXb1-LdrBx8kbXKdrW_8pfWJQ3DqK0swroE9N2928azHT9acbPU
    2BcdjVyJDq_EPe1YQ>
X-ME-Received: <xmr:8mbCaED4RvfcbHx7eqGF0MdYTp3u7259bMuk7Rft87k4p-SLCwuV0d0l6H_vI1Nu8SYkbKfkmNSQe0tWIPucO2xyC9LqLNYTPeFSNgq2iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugi
    hfrghmihhlhidrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8mbCaLvBf48snOQUIq3VYmVlnKiIeV_KODGcpYlTStrvO-NHo4sD7Q>
    <xmx:8mbCaId8j4Srf1hZxsUO_MiLRiQ5xnBfKvg5xwMg6YPihzdXQUi2Uw>
    <xmx:8mbCaA-gMLwGFAvvWgbp2zwNWroArJj-RUBUr6FuCuptg7VL4I-OzQ>
    <xmx:8mbCaLSACZMS17K7m655HTznyla3UAR1RUb9Xri7Q7CLq2jY0mPcRQ>
    <xmx:82bCaDVJhVZHuCRQT4eIOnqIgZaO4FNl6tpmYD1czEebc3xkFrjtgEQo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:06:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4bb5eb7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 06:06:39 +0000 (UTC)
Date: Thu, 11 Sep 2025 08:06:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
Message-ID: <aMJm57VmWb3h167z@pks.im>
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910080839.2142651-2-christian.couder@gmail.com>

On Wed, Sep 10, 2025 at 10:08:38AM +0200, Christian Couder wrote:
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index c06ee0b213..3994a8f898 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -59,24 +57,17 @@ static struct hashmap anonymized_seeds;
>  static struct revision_sources revision_sources;
>  
>  static int parse_opt_sign_mode(const struct option *opt,
> -				     const char *arg, int unset)
> +			       const char *arg, int unset)
>  {
>  	enum sign_mode *val = opt->value;
> +
>  	if (unset)
>  		return 0;
> -	else if (!strcmp(arg, "abort"))
> -		*val = SIGN_ABORT;
> -	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
> -		*val = SIGN_VERBATIM;
> -	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
> -		*val = SIGN_WARN_VERBATIM;
> -	else if (!strcmp(arg, "warn-strip"))
> -		*val = SIGN_WARN_STRIP;
> -	else if (!strcmp(arg, "strip"))
> -		*val = SIGN_STRIP;
> -	else
> -		return error("Unknown %s mode: %s", opt->long_name, arg);
> -	return 0;
> +
> +	if (!parse_sign_mode(arg, val))
> +		return 0;
> +
> +	return error("Unknown %s mode: %s", opt->long_name, arg);

Would it make sense to maybe reverse the error handling and say
something like:

    if (parse_sign_mode(arg, val) < 0)
        return error("Unknown %s mode: %s", opt->long_name, arg);

    return 0;

That reads a bit more natural to me at least.

> diff --git a/gpg-interface.h b/gpg-interface.h
> index 60ddf8bbfa..44856cc55f 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -104,4 +104,19 @@ int check_signature(struct signature_check *sigc,
>  void print_signature_buffer(const struct signature_check *sigc,
>  			    unsigned flags);
>  
> +/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options */

Nit: let's finish this sentence with a dot.

> +enum sign_mode {
> +	SIGN_ABORT,
> +	SIGN_WARN_VERBATIM,
> +	SIGN_VERBATIM,
> +	SIGN_WARN_STRIP,
> +	SIGN_STRIP,
> +};
> +
> +/*
> + * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
> + * otherwise.
> + */
> +int parse_sign_mode(const char *arg, enum sign_mode *mode);

Okay, makes sense.

Patrick
