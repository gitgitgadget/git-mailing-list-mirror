Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFC3128C6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097675; cv=none; b=ev/yvH9yj+F6fg4+OX0BiiNMwtM63ObfukuW5INbzGgyzhjzkUmfI6r9sVrWnqpPikn3Cp7WdasVh6lOZYCaV/AkygDi1zPszxUUXW9jJqKDZcLqSnM6fcA5S0AQHRXSD4KCZOhQ6hier+YVc2wAY7Vi0rRm9eIIqmnk1cmeXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097675; c=relaxed/simple;
	bh=6g0xV/EN+3gJZ8z3IPQLwvWeeQEzFwxhmmrmvLeuO/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlYOCMYVnr0iyKfuLSji6emqdVsBENDzd3iqCrwNLQigH7hyt57fi+B4HuOOBN4H8iedVa+iqYjMpzTfrxJcR4mceIif5saPHH2QwHKYbnfG4A/dj0ii+EodeiFG0CW3APvehs67c2AgYQa61afCCi84Oj3HM0QFxEigJr6aKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MCjvlr/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4WiwzmD; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MCjvlr/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4WiwzmD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13B3B7A0104;
	Wed, 15 Jul 2026 02:41:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 02:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784097673;
	 x=1784184073; bh=7jZKWhUlRaZSP/GT96ZXLniVOANGYqY0LGRjr39v2hg=; b=
	MCjvlr/u2A6vx4wEU4/rGFiTGDMaif04z3+G8cngZLyuOj3kj9FypXHSM1vEV1J+
	V9flvb5hVobEpE3qfG5nl4B703AVue26Pov+8bWClae3JhntW+ZhrL9E5Uot1d7Y
	vIJZ6jjpUt0d99qTxpxd2bsV3KdV1o7tEKremT/DWOPgC9J4Y//W24ZDy3XRe2+C
	o8OeFrzH8TFovJl4tdgqCEdckEHNIWLgv5zPXnSAWWF+T3p1DcY9zxv7HoPwi3uC
	8zanr8dY7jAeUa2gpaFtYvK6IRKENScKTWFsmjoqJYgXGFOqsYg0ZlgJP8Cnxi1d
	UasP5owYulbm81yvHE33hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784097673; x=
	1784184073; bh=7jZKWhUlRaZSP/GT96ZXLniVOANGYqY0LGRjr39v2hg=; b=Z
	4WiwzmDmODRNg7cuEZWvwf3mBD+fuIgcu3I6RubsGz6dSGZYh37INGJNkrSJU/Si
	PZ6pSLmn7ollcRVjla2v8avbEle9zJfsoNG408jqYRDJEadbYzMGsM1fgAR97Rux
	z8mpWtd1Hinu7rOrc5Gn7Mprjwt6IDsWsOzn+RY0w5+tCYaig68kL7YcBY8Cxqwq
	O8t8uqxceV4LWBVZlMu+pjL0V1BNaUJ7rDjC2jueCZWzpz3APraJyKljK6NkMQiX
	kUb0WtmEZB33fY6khBcUCWXa4wN7UocVTmYHOxtcHcnMIcbovsB+lndEwtRPeTpj
	W5uT7HDMOX0wSi6rVBtGA==
X-ME-Sender: <xms:iStXajjKmtqcGkHYYsaPbTKUNG0kaqKGrSat4XynXv-hMCCnNwRDgA>
    <xme:iStXamAJyvlmdKMMTaZVCnjBrMpYjJ4xW8Q5mANPT3EAb_3duLd6SASZH1kBGQttR
    PTgzwpEkc3xq9fo3fzBxVWHygu0P_7F2w-BdRg3VSWMVzXDyr3eIw>
X-ME-Received: <xmr:iStXags0O_godRZG9VCUmZpnj14UYfjNHDlUqxTCQH9DALAVOFhIEDn8iTh3S_tnPylc3N6rTLhNLi3fakDKK8xB4VMRBAUxvwkNiE0Ue0I>
X-ME-Proxy-Cause: dmFkZTFShe7tcTUFz8VLzEM3KR6VDkMW+aVfLiOFoo02VU9IjQWLc7rtpxREae78baHMEw
    Ivw2/xCt4n0ZgYwYvukfCJu73W/+h1WgrW5mcAdNU1YgD08K6aPTaY1mEXngJI8lJAwS1R
    5/9RzzQQ2XjoWemcSkmGq0nWTAiyiCjq0q+kvBWsQSDOXd1rIXtpMx2q4slhQciF1kOIOf
    jaDSjBcKOR4u9bPwkWLcvaEuyLYwGClgd+AmLen4ZeoUmvwaK/2Rk5tuGyodcDZK9xELhe
    rEtP2LfOCL06de5cvm8en/FQmRi/d6bByznOSSbNJVrPj+b13UUf+c2XfToci/aNfG1CC/
    +5t1hiLLYwK9UUBkAKtTjf4LrRq6ig+ENaRiqJ6lJQg1/MZs6iadu7WF999Gsozl3Wxh3v
    izilyJhjmzIZ3++FSrHkRhybi73IbCb+ZjiebDyxxJ0JI62yL1ujMKmDur1PQnvc4UcUin
    exqxEKU/vhDC2NeeQs8mn4TF4t1+zCfJ9EkTw5U0NG60aLAqq3Al5Aq1vR1oIQ7OIh4E8K
    rG1G9PFtrfkxTFmwgOxcB7h/0QZLwFmEHv/GZ0+udgiUyZCvMX0PvwTwJGhSQE5ghztQtp
    Cbo5DIf4jurAfO8MZaWpH4vSKHSTDfdr+jMM+KoVmuL6qVDTYdvYkZ3x4xDA
X-ME-Proxy: <xmx:iStXarZT9Y2MLD1yqTtTMPSo-Rz3yRiQg0F054WT8Gxd4_4kRYnXUw>
    <xmx:iStXajWmOMS9NryJ97zKQ5zDo0Sx4c0XjD7__VMwdZFNIxXIXq9cNA>
    <xmx:iStXav5N5j2-lrAkGTAVyDIsu05Ff7A5t_aY1CZ7iBemWmYNMHCmgA>
    <xmx:iStXaugb3kqynUYHAOXy61h7vRz3of15_ShpdJ58iRAlIKVxcBaOTA>
    <xmx:iStXagk1GyNFWBYCoPePDzTQR5SuiY0qrG-rm3m-ZKTE2z3VVxQFYJnF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:41:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23766153 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:41:11 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:41:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: simplify passing of push specs
Message-ID: <alcrhGUCVMCnm2-i@pks.im>
References: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>

On Wed, Jul 15, 2026 at 06:41:17AM +0200, René Scharfe wrote:
> diff --git a/remote-curl.c b/remote-curl.c
> index 9e614c5567..2c35dd5240 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1340,10 +1340,9 @@ static void parse_get(const char *arg)
>  	fflush(stdout);
>  }
>  
> -static int push_dav(int nr_spec, const char **specs)
> +static int push_dav(const char **specs)
>  {
>  	struct child_process child = CHILD_PROCESS_INIT;
> -	size_t i;
>  
>  	child.git_cmd = 1;
>  	strvec_push(&child.args, "http-push");

I wonder whether the interface would be even better if we simply passed
around a `const struct strvec *` directly. That makes it explicit what
kind of guarantees we have, and all transitive callers already have one
available anyway.

> @@ -1353,15 +1352,14 @@ static int push_dav(int nr_spec, const char **specs)
>  	if (options.verbosity > 1)
>  		strvec_push(&child.args, "--verbose");
>  	strvec_push(&child.args, url.buf);
> -	for (i = 0; i < nr_spec; i++)
> -		strvec_push(&child.args, specs[i]);
> +	strvec_pushv(&child.args, specs);

I thought that we had something like `strvec_pushvec()` that knew to
also optimize for this case so that we don't have to reallocate the
vector multiple times. And if we had that function it would even be more
efficient to pass it down the stack. But we seemingly don't have it, so
that argument is kind of moot.

Other than those nits the patch looks good to me, thanks!

Patrick
