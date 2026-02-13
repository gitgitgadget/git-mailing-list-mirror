Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C883570DF
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981968; cv=none; b=QjmhKEYG6+hK3nQgEjtwqQGr+6+s2AEch5yzH9qMVNcUYnq3nl1DS91UpK8D+KPhztFTEtw3I9vX4siPzRNSHzj2QHxMYsDV9LEgzMfRHln9fmuw1YojPMSF3WVygVUi4/u0EOEAfsiwT6WMRih3/IxmhqwL/+fXJCc5qyVMcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981968; c=relaxed/simple;
	bh=wkoQA8bnCC+VAWPwFEyEcyca4eetOTPGYr4tIjRHnHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuTuzGqwxNfCjKr965imKierqC/uL/SUar1fkX44Me5xm/Z/8zg3KhgA84GOzdLtXrGzn0dFgYscwuvxcynxYhLhSXp4jU+8pSP9U22vSdRJsjFT5MKwCcl6LBjsKVKUSY6U5trohJIcIV5w2PyuxWdVpn6OuPjt+ndjsaItCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=krxla6sK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDsKO/Co; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="krxla6sK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDsKO/Co"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A86C140017C;
	Fri, 13 Feb 2026 06:26:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Feb 2026 06:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770981965; x=1771068365; bh=VSMqx6Q0BV
	Q8Rw/pSh0CU1CqJTGnm/qN/Qcy95oDw7Q=; b=krxla6sKZ7osvZ9cz+YXAX9HSU
	mrEq1YVOJiT1BODU6hN3A3EN4mfRlHaXNcc4G6kp9xw6ql+eD8trqzpgjYjMYJWC
	fWB7HZBd5zn2sDJwCHesREdVkffMCDijPXx6NQFkRKfmt1+t6tjfadtMOr2PBh0F
	e+R5H0qrx0MlK1ZfWGBQCyOfgsoVCI1mVfMKkHkRlSOja38gYc+qRHzvyZFz0RLp
	zVs3DJbMjcm6gXdFmhW+tyi8gJbXCVz3dqslwUY63x2t01MXYmSuwLSLzAJ6PcLh
	U7tdwe3ViGHVPNxMq8lKGcnfjy/y/6FmHKmRn2/zwLm7UPP8tfomcqcXNYig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770981965; x=1771068365; bh=VSMqx6Q0BVQ8Rw/pSh0CU1CqJTGnm/qN/Qc
	y95oDw7Q=; b=CDsKO/CoSC/i2F80KooFGu4RuCBUzY6DhPbhMEGB9D54WAHLM1a
	tVf/IURGDcSTK1cipHSM30BU7Cu9hJGAcSFQrRZX3/NGP7FumWvJTdP6T0ZCYOVe
	oetLOkYK+pIJrg+2x/Murls5xW1/HkwF+dn59JZfEA7wNl3yRIYLoSYf8yB/gBJn
	BB3tVA1jIJHU7Zzgg14T8nLwusgBh+kuRtZDUFkck5bPy1NBhIa3/BW68L3mKNcp
	/ZOq7zyc+B5m3wCHiIq0OWDIefTcyLqNU959FytuBm/vUDp7CiboCH0NF395jn1E
	cMEXJznHpm9ls2OFjGvEFCocpbbhkfj07/g==
X-ME-Sender: <xms:TQqPaSkyT199AxPbAPP3rhQ9uVzO1MDEZP4cAG_LX-T03qcxo6804Q>
    <xme:TQqPaY4s_hX-inMrAPp6SCHU55CukUlkuYZiElaXjEEtCOjLwNdDNBtON9GZRuxYM
    yhDDB9XbFJppIcaAh5MU0LVeEQBfrmMRgWzDgeFRQB2c-1wMVEpOg>
X-ME-Received: <xmr:TQqPaW1KtYO7V2eTmBCVqd6sNWQpqBOsBvMyE4R7G_jVdjWEwhe1Y1F5crMD5rUyO-jx79Q4FWLphhLED57mFqeH9soIT3EIbVsZetDQPgSj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghvihhlrgdrjhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:TQqPaTG8c4zVO273vONML-ERt_VG2vccvZfJHXCiKZTvHiZszVdb2w>
    <xmx:TQqPaVi1xetxoI8H2biFhh8eLkNkJytrdDzlD3MgOHKewF8Je5Kqzw>
    <xmx:TQqPaWBE82HbJZZZMyOTsrXhRNrqg62dK0zc6zTMv2YNt-wAOZpaeg>
    <xmx:TQqPaXStRQ__8y5BCzeTe_yA_jenYtxSE5gJbAQciDRJHn12-440sA>
    <xmx:TQqPaQmADiV8TUIBIR96ao7mxhYtD4NO2Tr04SZEmAtaS66WTNkJLOvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 06:26:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c49974fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 11:26:01 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:25:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 8/9] promisor-remote: change promisor_remote_reply()'s
 signature
Message-ID: <aY8KQvozKx70O-aw@pks.im>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
 <20260212100843.883623-9-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212100843.883623-9-christian.couder@gmail.com>

On Thu, Feb 12, 2026 at 11:08:39AM +0100, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index f3bafb7731..96fa215b06 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -920,25 +920,27 @@ static void filter_promisor_remote(struct repository *repo,
>  	}
>  }
>  
> -char *promisor_remote_reply(const char *info)
> +void promisor_remote_reply(const char *info, char **accepted_out)
>  {
>  	struct strvec accepted = STRVEC_INIT;
> -	struct strbuf reply = STRBUF_INIT;
>  
>  	filter_promisor_remote(the_repository, &accepted, info);
>  
> -	if (!accepted.nr)
> -		return NULL;
> -
> -	for (size_t i = 0; i < accepted.nr; i++) {
> -		if (i)
> -			strbuf_addch(&reply, ';');
> -		strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
> +	if (accepted_out) {
> +		if (accepted.nr) {
> +			struct strbuf reply = STRBUF_INIT;
> +			for (size_t i = 0; i < accepted.nr; i++) {
> +				if (i)
> +					strbuf_addch(&reply, ';');
> +				strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
> +			}
> +			*accepted_out = strbuf_detach(&reply, NULL);
> +		} else {
> +			*accepted_out = NULL;
> +		}
>  	}
>  
>  	strvec_clear(&accepted);
> -
> -	return strbuf_detach(&reply, NULL);
>  }

Okay, makes sense. This directly addresses my comment on v2 that it's
kind of weird that we do all of this only to discard the result in the
next commit.

Patrick
