Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64F272E42
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028534; cv=none; b=ggVHUzYUDoMMF3JrIi1suV5G8uJ+3ffcho0uRXKWy+/zAipIEYXHIRm6qDhlLyol+yD5cxsxuxeJv9JtcHVJeQoz9gg5V4iWN9l6s0hw4I950fespDFaXCVa4qFiL5FO8d90Dj4e283xwx3soHqqPqIrAxv+PjcrHsqWHmE/72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028534; c=relaxed/simple;
	bh=bfyWO1ALWtHtV7CucUaVvNa3ag0IM9YxSoHbAVxfR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO7pGw0g+RDCMT4eHNj6oy0pTvfQdpj+l87bE3yd7W58eVXIVuz9a+RtVvtKWf+msqg3Czbz65htElQI/Wn867aD3UUJVyIG/LuyZXpAhK2SAi51SMK8bE6OYETy5rRRoo3zezEDAxLchusMu/nbmAcM+bEe/KiEz5Fmm2TMNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X1avWJva; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X1avWJva"
Received: (qmail 92120 invoked by uid 109); 24 Nov 2025 23:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bfyWO1ALWtHtV7CucUaVvNa3ag0IM9YxSoHbAVxfR+0=; b=X1avWJvaMHQSQstRCv/JhD6M0TJ6sz5bONFTdSpCWriA/EePQys0mEZ5PEdNkC/81g2HZ8Cn7tC1Jzco/I5D5WF+D0PxUuWQGueIOgNrU451LdZ6e9NMgA5JBRnwx7IoPqwlPv53nNJ4CAxycUNSzXINSAFYTmTPH92XjnzVFbmpAXlLlwsZYJT7N74qQF0xeJlvPIQH+8ZqfCSMQqch/txKnChngrI3AIsCgUymigAOBJ7c2bF6hjU9vBQquyxz2uwYU8j6RA1bwcR8Aphrh4mPE7O0DwWPxjuUb9jgWFcMEUqyKvUYJkqGI+18BCqwW7C5sD2xfKHS09WVTTR1tg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Nov 2025 23:55:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157064 invoked by uid 111); 24 Nov 2025 23:55:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Nov 2025 18:55:33 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Nov 2025 18:55:30 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org,
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
Message-ID: <20251124235530.GC2051672@coredump.intra.peff.net>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
 <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
 <xmqq8qfvw2lh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qfvw2lh.fsf@gitster.g>

On Mon, Nov 24, 2025 at 01:19:22PM -0800, Junio C Hamano wrote:

> Hmph, as documented in "git help clone",
> 
>     `-c` `<key>=<value>`::
>     `--config` `<key>=<value>`::
>             Set a configuration variable in the newly-created repository;
>             this takes effect immediately after the repository is
>             initialized, but before the remote history is fetched or any
>             files checked out.  The _<key>_ is in the same format as expected by
>             linkgit:git-config[1] (e.g., `core.eol=true`).
> 
> I do not offhand know if the option really used to behave as the
> original report described, but if
> 
> 	git clone '-c KEY=VALUE'
> 	git clone '--config KEY=VALUE'
> 
> does not complain-and-barf in the first place, I think that is a
> bug.  The above option description clearly asks the user to give the
> dashed option (either "-c" or "--config") and "<key>=<value>" as two
> separate arguments on the command line.

I was surprised that a single "-c foo" argument would work, but it makes
sense: it is the "stuck" form of the short option "-c". So:

  git cmd -cfoo

should be the equivalent of:

  git cmd -c foo

whenever "-c" takes an option. It is just surprising to read because of
the leading space in the value.

Using the long option as a single string, like:

  git clone '--config KEY=VALUE'

did not ever work (and should not), because there is no option of that
name. It is only the stuck form:

  git clone '--config= KEY=VALUE'

which again makes sense from the config parser's perspective. It's just
funny that the first character of the option value is a space.

So I don't think there are any errors in the option-parser side. It's
just that we were overly lenient with trimming space in interpretation
of " KEY=VALUE" itself. Which has now either been corrected, or
erroneously broken, depending on your view. ;)

> Interestingly, unlike other long options described nearby, we do not
> seem to even list "--config=K=V" form, and that is a documentation
> bug---other options like "server-option" is described to use "="
> after it before its value, and to parse the "--config K=V", the code
> uses the same mechanism.

I don't think we're very consistent here. Look at --reference, --origin,
--branch, and others. I don't know if we have an existing style
recommendation here (though we do recommend the "stuck" form in gitcli,
which perhaps argues that we should be using that in our documentation).
So I don't know that I'd call it a bug, but it may be a good long-term
project to make the presentation of options more consistent.

> Also, if the user writes
> 
> 	git clone -c ' KEY=VALUE'
> 	git clone --config ' KEY=VALUE'
> 
> and we behaved as if it were "KEY=VALUE", that is another bug.  As
> documented, "key" is in the format as expected by "git config", and
> we never allowed leading or trailing whitespaces around the key
> names.

So yes, we did allow that until recently, along with:

  git clone -c ' foo.bar   = baz'

which keeps the space in the value "baz", but otherwise sets foo.bar.

I agree it was certainly surprising. Despite the real-world report that
started this thread, it is oddball enough that I do not think we want to
continue supporting it even for historical reasons. It is not quite at
the level of https://xkcd.com/1172/, but especially the form that the OP
showed looks like a mistaken invocation that happened to work (and would
not work for any other option in general).

-Peff
