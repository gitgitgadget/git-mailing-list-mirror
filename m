Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3E28B7E9
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879655; cv=none; b=K/IdiCOb2lH42nKVDMrfomTY51N1effOyYT5xt7MsIDG/vpkdK2X5O79076Wslx+xNoEL9W9noG1Q50ITEZmmh4wFIeQHIEg7f88e5jrih/oY+CEdu1A35gHNyI+c8pkuvKApymFO1CRH2eWhJ2Q6KRyqcL3aIUa4c+TfYGygRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879655; c=relaxed/simple;
	bh=KyeZna6leTmF2JuvDQ4D4QxJSQtMxyI9LnrzsTnRa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS19gGVGyZfz+oGZUgEGQLIaMSHgcSPiHtZyTmz3nP1YZ5H4IxCPAecLU0JwAD+uCdKHrsVfvRo5EVr3ZaSxLfgliuOh/8LXA1geKoK1vGlswnhME3375U7X+sfmTIH1JcUksTlUYAHzrnMO9arwxgE254q1PhCldkFZzzh+jbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XLSgZ2BP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faP0oMqB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XLSgZ2BP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faP0oMqB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A4B25EC0B55;
	Mon,  7 Jul 2025 05:14:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Jul 2025 05:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751879652; x=1751966052; bh=j9hwiUclI5
	IBNWdMY5hNuFNs7brhHovPwqZP8G8AIRU=; b=XLSgZ2BPQN5ACErDnKGQ0ex/rF
	INdwLM1t4RTf43EeVlTLpEnefe5+waOqru5i9JrVqL1VqWZOMnPBwfbIWojill1J
	bFk8K5hvvFBndvnxWeHjleedcjh3QGTy7D772YTcguYKfhVFN5uXPmQPLui70Q89
	l7GCqTcESOsnPcFAAiUfxMcB7MfCWh2OCf8ZoG0RFPhXq8JXg+ntgM+YkMyv+3/c
	n4HwHj0MmKlu7Mvhk8XCDuo3L41g75N/Dra31xjprKsB/PFC8aOrwzQxtl6X4k9u
	9bfYnuys4c4tPAvrsr5/I2XEaNu9mGujv6wRw5oMppFMgwM134egZAeNMc1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751879652; x=1751966052; bh=j9hwiUclI5IBNWdMY5hNuFNs7brhHovPwqZ
	P8G8AIRU=; b=faP0oMqBtCR/wXMjKat6P4Zt1cXeJtsoeHmtZvUg+694o2ssEBu
	gsHY3lGHakrHeQRl8u4T3S5hJWpmTaL7ZsjYU1ZGxwlwIvx4E3Hqw8mkzNfUEn3Q
	ziZ0z7eiTv3s/u8d27yIlJvyBRbAF80vmkF/vT8ABfHhS05LQkQCXHo2og2qP7Jt
	GTsbomW2bLsK8WntHAasggtFZbn/wbWcuLy3eQT0nrqnpGpUqygOQPqjR+C+mJAp
	/acoy3wFbLLjvMqEnfhC8kIvHvY9adCkJZHwNCEIBMnYth0cb48ljxQDYIM83Ud4
	j+5p4P9e6TOciJrOv6I4Kq5T4kOu7LUwBRQ==
X-ME-Sender: <xms:5I9raPVlkvR0X4hcQMCgH2UgXl1Qy__dyPfgiOxE47QmDvFmRSHQaA>
    <xme:5I9raOcCLYjH3KKUgI09gLw0t8wxz-tnRKkJyRRne28k1naOi8d3BQyck7IBk9hvA
    7isYht-y72tPGv6wg>
X-ME-Received: <xmr:5I9raIVHS3Xtf5duEozhYDhjFjyBS_olOwAp8obaLTrPeHSE4pEkNrlBf2OzJEFYdTs-3zzV7gDRrRdu4pM4g3WW14X-oQLcooDUdKxwSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtvgguvghrsehlhihsrghtohhrrdhlihhurdhsvg
X-ME-Proxy: <xmx:5I9raHf7vUXOhE6cQ-vjydwZg5VgqZ2w5YwhGv3ynFqIGHXEuJpm_A>
    <xmx:5I9raEO8s8iOmo8Z22XSx-fp0V1ysaMsGo4nqHa7fxrJnfAGAvQD-w>
    <xmx:5I9raFhoWQUn6Ljy4ilvYHFrUs_BiZAg6AHNgeO64u8wPUxMjAFM7w>
    <xmx:5I9raH2LEPXpU0ikg4ZHD8aCfGLQ2rYcjdRPPSaKLpcGOV8xegv8sA>
    <xmx:5I9raNbTS3NHafaFZLiYE-GnEzbvm4oiX-Kbk7TUTdogWMRYg9c4L9sG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 05:14:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58f77848 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 09:14:10 +0000 (UTC)
Date: Mon, 7 Jul 2025 11:14:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <aGuP3Q5xykmRNp0m@pks.im>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705185842.GA2496172@coredump.intra.peff.net>

On Sat, Jul 05, 2025 at 02:58:42PM -0400, Jeff King wrote:
> On Sat, Jul 05, 2025 at 12:57:50PM -0400, Jeff King wrote:
> 
> > So I dunno. It feels like a configuration error in most cases, but not
> > all. I'd probably say that people touching the config manually should be
> > allowed to do what they want, but maybe "git remote" should be a bit
> > more careful about names being proper subsets of existing remotes (it
> > should already prevent the exact-match above, I'd think, because the ref
> > namespace it uses will always match the configuration name).
> 
> So I'm not entirely convinced we should do anything here. The answer
> might just be "if it hurts, don't do it". But if we wanted any
> protections in the "git remote" porcelain, they might look like this:

I think having these protections is sensible. And I also agree with you
that we shouldn't keep people from doing weird things by manipulating
the config directly.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 0d6755bcb7..b18730ddb2 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -157,6 +157,21 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
>  	return 0;
>  }
>  
> +static int check_remote_collision(struct remote *remote, void *vname)

Tiniest nit: I was a bit puzzled what the `v` in `vname` stands for, and
it took a while until I noticed that it probably stands for `void`. If
you end up rerolling, I'd suggest to either call this `payload` or
`_name`.

> +{
> +	const char *name = vname;
> +	const char *p;
> +
> +	if (skip_prefix(name, remote->name, &p) && *p == '/')
> +		die(_("remote name '%s' is a subset of existing remote '%s'"),
> +		    name, remote->name);
> +	if (skip_prefix(remote->name, name, &p) && *p == '/')
> +		die(_("remote name '%s' is a superset of existing remote '%s'"),
> +		    name, remote->name);
> +
> +	return 0;
> +}
> +

Hm. Do we have to care about '\' on Windows, as well? This made me
rediscover the following function:

    static int valid_remote_nick(const char *name)
    {
    	if (!name[0] || is_dot_or_dotdot(name))
    		return 0;
    
    	/* remote nicknames cannot contain slashes */
    	while (*name)
    		if (is_dir_sep(*name++))
    			return 0;
    	return 1;
    }

Which... puzzled me a bit at first, as it seems to indicate that a
remote with a path separator is invalid. But as it turns out we only use
this function if remotes are configured via ".git/remotes" or
".git/branches". Looks like we eventually lost this limitation, probably
when config-based remotes were introduced.

> @@ -208,6 +223,8 @@ static int add(int argc, const char **argv, const char *prefix,
>  	if (!valid_remote_name(name))
>  		die(_("'%s' is not a valid remote name"), name);
>  
> +	for_each_remote(check_remote_collision, (void *)name);
> +
>  	strbuf_addf(&buf, "remote.%s.url", name);
>  	git_config_set(buf.buf, url);
>  

Nice and simple.

Patrick
