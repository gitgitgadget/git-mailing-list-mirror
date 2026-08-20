Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C62D7393
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204501; cv=none; b=kL4GHJOg3DXlFhyzl6gtWBFZRvnGIDKByBYpXDBz3RXS7uLPj0dQHfnJtKrYbdo7V1i/63QS+ZBPGYlhS128kafx0PUmzvm3vTQ1tAhUeivwvBiN/qUeD+ZSqsYiRFbD0m/iqiKZcTARimPWHUl7jpIsoGLVsbyucynTKM7H8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204501; c=relaxed/simple;
	bh=new2Pyi5JSEwgQsPy7xzEn1os/7+g6ATTQVRcwWYLGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+lcDRG9jiTXEzmfgVK2RDf01vYyyCoysxExftghxbPt2P8o9TJXefWAHgV29E8mLEieIaKLfhDtaCZx50iyWzZzjYXdjQx5H0zX1HxyzLIIN1KnPmTIlp8Ols4h3/YLsZNBe85/Kc70MRu9RcTPUNWA7IJFg1iM41FHUSWhPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a1SI+eCG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g00aHZcY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a1SI+eCG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g00aHZcY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 574C21400069;
	Thu, 20 Aug 2026 01:41:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 01:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787204499; x=1787290899; bh=pilst0IZel
	j8p//rROyPGQ0bsNG7anQvd5mP12/hpVw=; b=a1SI+eCG9QSMKfpYO0V3NN7wHC
	BoIiBwDS9Z9uud3JchARBM1wMaTlbK4Zp2uaY00irFPkutIje/oiwjjKyQMA6Y/T
	FK89a9R9h/OvR0cSIzK5n9vbz2L+UGqLbCMlyI0tSbzVtrzF5gChDx8dN3x8Ym9d
	PnJWmNEmnnRQXLK6yu2V94Z2gH9q0/eOtKNsxHOtVDc920udTwJBVp1CWyQNMD9F
	3OP8GEsuyUauoxV5JUCTRRfeIJiPMLN6pUlm5SEfveINUbGQdXr7o4ygKXRSv+Ua
	EZfh/AaaJVLhzcRNFT0YgN/FTGDzXqG7Y1YSlpWYUdObfeC23dNGBBASIqFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787204499; x=1787290899; bh=pilst0IZelj8p//rROyPGQ0bsNG7anQvd5m
	P12/hpVw=; b=g00aHZcYGq8hOUjlELSHIFprhIk/Vkiy5uYsUohX4W7x7GOAwq0
	n1eHo72KAV3y5/m+cU27ECLw89NmhFNbvrrdgZs1QXMhbyjuLk4VQ0GWyXO5KRzU
	r8PzrvuuyjOl18/dXQb5qvck4mOszBoFbCg9lBuVnTgKJQmdAj9l1ZuYre02GXrP
	QIsEEcJrsZiN+viuo/BZrUANZh8Nrs0KpjVQRDq8p4jQCwQj4sRNG7Afg+3PveI6
	HHXztnWeSxX2ufJjay47riWP35ut0x2vvIHvyOMpMVbBKEX5dKMu/7fnLGfhytqN
	g+tJ/zG4802fZWyyrlC7T0BOSMcAtwjeMaw==
X-ME-Sender: <xms:k5OGaguPnSJTS7IEBlBPG4xoR--bQEOS7DYYuOhKvrHKuwiXoWH3nw>
    <xme:k5OGak7Bj2WdwEbKDpMNfURNU0Oa-MZlu8lzET3op9n0KxhnHQFLCsccJ8OUozN-m
    Dq7l3hryRHqHOjV05QlrpYeVlMNL064HBvkdQvtmlsZqUK64u5xxw>
X-ME-Received: <xmr:k5OGapJqR3IWIhmYyow67KY1EO45QGZeD8JNshmNhMeZfKC8cbOQUOifKLL-PzZqAZybhP0eoZQucKG3PwtKl1KJCybw1nSyOfYu6TvgSA>
X-ME-Proxy-Cause: dmFkZTEjNBMVCRV7Xo0IyjfcW0iwppblO0l7Hf08deI56bw8XqEnpOsD0HuAvhmc9mSwiV
    M5MxU+wUGSx6WiPYFZPlqBZ6bsWsspaVTsYMlq28C4VPkN06kqcK/HSQAH5uV2Ih+552lu
    HmC4ISpoPjMLNk208yLjlJsCvZjEGVIX1pEXENLJyGUktiQwkS7mm/2xQ+7KsYXBs5nxoy
    oqCqNhc1N3mVxZBp8BEZrSfOvddHBzBhlxifMeAXiO+SCCy4x3ZToEOgc2JRghJ8qjtOeO
    zeBRvhnEutGGmfMS8GsaA3L68uv37kr6CNrzLxKbqgU66q8I1tpXrDHvjFk7FcGPFUMHIZ
    Qh1TU1diSRFqhVL/l9+JsbAR/+P2Ytul3hakmjkW2vecmoXQKlI67ZMuxB8i6tHT04ei/u
    EiIoU97MKamA9oUIp/HxtOhZlWtvgQJJ7cjyajY5jNw/9l4h8uAAMlwCmmRal0yB9pPjTI
    psYtaxlYKc2w88yV4B/hzseHkcds/tKeAVXqakd2QTeNI5l3ShYqf2ozIJaHJXUjYfOcyG
    8j2VdTYo5NRzZvkB3JXIFbmhw6JFuIaF4abhbgLocvkhthMY0RfTGtxIOuUgVaLz3g+zER
    hDCoEmoNURCYnfe560YIcRzhE8EsdqKUH3ZgM5aC8GVOruaVyNGn0OB1X+tg
X-ME-Proxy: <xmx:k5OGas4PipU1Clrk2qL6pf7RxSV_q8_n1AZSrPODS2ISjQXxGveVZw>
    <xmx:k5OGakxKRVan9WOLpeRfw_GMCyhEG2gyvb8o_iEe7Iz6rH4Wqy9yMQ>
    <xmx:k5OGaoZr4mxE5CrLQzUB1SjthWl1yQtiU3z2o2_lLvf9dqWSPBaz3g>
    <xmx:k5OGauQ1XYpJqF1bmnWX0vQh94LHLaqsM61IkNda8jd8Q17A2uUEUg>
    <xmx:k5OGag7ZcHLrHgBra1md8X85oNTfboSPTZdwKnVjqlZnKLtspF1J-afu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 01:41:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5a70bce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 05:41:36 +0000 (UTC)
Date: Thu, 20 Aug 2026 07:41:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: friel@openai.com
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
Message-ID: <aoaTjWMSO8og_iFw@pks.im>
References: <20260817233914.8740-2-friel@openai.com>
 <xmqqo6f02q2f.fsf@gitster.g>
 <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>

On Wed, Aug 19, 2026 at 04:28:10PM -0700, friel@openai.com wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1ec5b6f206..252530172c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1389,6 +1390,8 @@ static void write_pack_file(void)
>  			display_progress(progress_state, written);
>  		}
>  
> +		bytes_written += hashfile_total(f) +
> +			the_repository->hash_algo->rawsz;
>  		if (pack_to_stdout) {
>  			/*
>  			 * We never fsync when writing to stdout since we may

I guess the addition here accounts for the trailing hash written by the
hashfile. If so, shouldn't we also use the algortihm that the hashfile
uses in the first place via `f->algop->rawsz`?

> @@ -1510,6 +1513,8 @@ static void write_pack_file(void)
>  		    written, nr_result);
>  	trace2_data_intmax("pack-objects", the_repository,
>  			   "write_pack_file/wrote", nr_result);
> +	trace2_data_intmax("pack-objects", the_repository,
> +			   "write_pack_file/wrote_bytes", bytes_written);
>  }
>  
>  static int no_try_delta(const char *path)

The "write_pack_file/wrote" event is quite awkwardly named, if you ask
me, as it's not immediately obvious what exactly it's counting, and the
second metric may make this even more confusing. In retrospect it
would've been preferable to call this "wrote_objects" to clarify.

I don't really think we guarantee any kind of stability around those
traces, so we could in theory change it here, too. But I don't feel like
my argument is strong enough to really warrant such a change, so maybe
we should just leave it as-is.

Thanks!

Patrick
