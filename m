Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856813B7B7B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499298; cv=none; b=hupkdGS0B06S17bla4zbZ7esNx2iUlxBkRGiJA3IgiO1H/MkZWawAtsnkzMhk9dzXNF05UsiKfyXYDYSUoxRo5BuXFuc7Ha0lVDdtRxkFV0DYk/b13QkV6B3kmGxIFEAWCfcCM037Y6uSnpUUb5/4AkMqJfuTPihASCTUgSiGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499298; c=relaxed/simple;
	bh=Zz4ltyPCy1zJd6h55rbqqevs9HBIS08jrXIVvhTT4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl8u/en+BT0n7ExNTU1iXK/i9uInHFb0/7iJ4hrpVAT+L3ay2iLcRDFTKgdDHz3CxD/oT6gxEoi5/JH+JpRU38grRzmHDrUpkN0mhD6kzhwBEQG40bpnBz/hfqCLJbJVh75MeZirswgEsWc5aIMEXaNypr2lUHJ6MLz9qySjl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RHSEcyAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wmzHAVZo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RHSEcyAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wmzHAVZo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CB5081D000D8;
	Fri,  4 Sep 2026 01:21:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 01:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788499295; x=1788585695; bh=IxJiCX+9TR
	lQaDWT6g8YwYFFvdvxKvfvX/bvCF+H3uk=; b=RHSEcyAHvFX3ySkfbdnUu+kWFt
	H8lIw5P6SoVmXb69417CLfqk/Ft18EH5zv525TN2Zy/tv2Rr/enPiheGjkuJou6m
	/7TVKLY9S2RPBWVx4n/Bjha7ge+fJU2RtJ9HY0ZYFW+yWrZ8Pr1cKGt0tAZOquzz
	CpUznwuU4K2yUbGUD3ng954TCOA53SJI0Uli3Q+ONzqkOo0rGuVdb5pnhl85qTRf
	Jy3G/C4DOvPFJSOuIwnB4YajHFwM461AZnxyN4bRXbLK4+mFKieKXt7zs8/hvQ+i
	k0HxfKJfLzmDPbGcEhVOYQmYw3WbKSsTydo+vyUKBmX+2RzWHYhTu/wWUbGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788499295; x=1788585695; bh=IxJiCX+9TRlQaDWT6g8YwYFFvdvxKvfvX/b
	vCF+H3uk=; b=wmzHAVZok0f9I+EchP6uLVGYTN/Ug5qLCCRHhf5LgawfQd72BcF
	07CbCbwuhRdh5lXFuKzyidxKfIfFkdCOeOBYzUN4YP0JxfrE9ri9aNWxUGnVeeOq
	JiqUvAONfDMK6NXTkQcXheBDdaW6g7oQEF+1pp35IHDUo2cA4lAj3PW13rZZ08dD
	7fBxVHpK0YRWV4zG06KWpt2+YC1lu1OzRW+UryJdzdnHoM8vSwpzfrFCd0FBQTZO
	lc2z3TgnF5wAb1I8qNWuWrcN+luVNpUEtY6LNSkIf/Z2eLqzNYAXjJhL3HHUKTfb
	40N1H3abNKQZi8D6hPMHacntUcCu2zZssAg==
X-ME-Sender: <xms:X1WaauqD3sPqnSzk_h9H4zK_h8vWEc-xmAynNtjJR7lV1zU2dFgy9g>
    <xme:X1WaamGcO4UqcoN2xaQ8ehg7EiCuNJVxZWJHZV1-J5Wqort3y6MVj3IOQmtrFv3e-
    4UtO4CvhFFErLXQ6SIyJzE_IQ7TcCo0gFT6bdNvnXwf18whitspXFt5>
X-ME-Received: <xmr:X1WaaiwJ494Y2bc2fH212YcpR8NBuqPIIhIj5H9UJoQKqLos8SnyLPJt5hGCmHzA0W3PMA>
X-ME-Proxy-Cause: dmFkZTF3QyCRob4IqRP/e/wuB/IY5aqSM5K5sM7yiE/pRKqX28FANqz4uRUE+QiAxGveTk
    3UURCa8QLFLF908m8MmPNAUQoN8FBkmhKV/DB3BQtijnLjqJr5So75oyzX5B/uH7D0y/Hi
    pMjESOHGi30xg/F2XXF+Rsi5HA86zkFbakfEISCpGBcMIUHs5T/73Szqlvjt3jxkFKXiKx
    DlqAlZdWn811hadLNrnR3v+S/vZnh8IChj8M9uWBMN9AnSZ5dgFJ69sRdYbVndsFLgbpOP
    60WYNdT44cpH4xMXIe9bYDloRwSycSFVksQCihLpcQO1KEecjjsP9C4UP1Btzw4X4p0hqM
    bqjCzKwprvy8BcJek3ARZMXwxNCaum3/1KAeGQFkXboT43tTMu3/khwKTSjcE98iHNh/ou
    O7Jj/NwlrgreS+Cy2yn6XR2PSFZ4TXFvV27lGIFCJSEWbVYEAYP5N23A3BNxUq0CxlxvKv
    2tls3g85JFhTugOVVrHFLgNUBqWNDGLmztMf8tizk8eh0Y/wGJDqvtPHRkF05OafUgro84
    RmsuPiuNTiUhbKqKmixHwwp60paTsUtJVXGHeV3wxJmlb3qaqSUWDYFO9FrDD8FMVa8Pxc
    VzhN6RDvwSSQaY6zP0HIF5pxc5fGhr1Ww8wnJANB60mxbyhtD2bsVEb2r+5g
X-ME-Proxy: <xmx:X1WaajqDYwUx8bUzODKWri1NfTu4wYd3ZEmmQg9y7BQREaqOJeNIOQ>
    <xmx:X1Waakji6ROhRRZcKI3AmuIV0L_IgTPbJQCLq_IQUhV2YtA7aYtahQ>
    <xmx:X1WaaoibVEn7apYUjtBok9EeDhp3bmXul9xmBWOZdHGBIaUEp8d33Q>
    <xmx:X1WaaiiTwxN9IUrrI3zBS5pBgBqqrd8pYHsDbAV1hkk51Jw_e7qs1g>
    <xmx:X1Waai1QlBxKmt82GTBa7xgG0jdH3oWSZ2PAHT3pRq1LsG_D0Xa7ggLg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 01:21:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e08a6b94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 05:21:34 +0000 (UTC)
Date: Fri, 4 Sep 2026 07:21:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Thomas Bachem <mail@thomasbachem.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] builtin/maintenance: improve heuristic for "rerere
 gc"
Message-ID: <appVVYr6oW0fyMRD@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-2-9929c45a9788@pks.im>
 <2ca2b4db-1fd9-46e8-9385-260a12af43bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca2b4db-1fd9-46e8-9385-260a12af43bb@gmail.com>

On Thu, Sep 03, 2026 at 10:19:33AM -0400, Derrick Stolee wrote:
> On 9/3/2026 5:04 AM, Patrick Steinhardt wrote:
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index de2f9e7fed..9147418a61 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -396,31 +396,13 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
> >  
> >  static int rerere_gc_condition(struct gc_config *cfg UNUSED)
> >  {
> > -	struct strbuf path = STRBUF_INIT;
> > -	int should_gc = 0, limit = 1;
> > -	DIR *dir = NULL;
> > +	int limit = 512;
> >  
> >  	repo_config_get_int(the_repository, "maintenance.rerere-gc.auto", &limit);
> > +	if (limit <= 0)
> > +		return limit < 0;
> 
> This is cute, but works. It's logically equivalent to
> 
> 	if (!limit)
> 		return 0;
> 	if (limit < 0)
> 		return 1;
> 
> which would map more directly to the two documented cases. It takes
> the slightest amount of mental processing to connect the docs to
> the format you have.

This also existed in the preimage, but I agree it's harder to read than
really necessary. Will improve while at it.

> > +	return rerere_gc_estimate(the_repository, limit) >= (size_t)limit;
> >  }
> 
> I do like that this method is simpler in the builtin code in favor
> of a method that has access to rerere internals.
> 
> I do wonder if rerere_gc_estimate() should be
> rerere_stale_above_limit() instead, as we are not using any callers
> that care about the resulting number other than "is it at least limit?"

Agreed, the current name isn't great. I'm somehow hestitant to use
`rerere_stale_above_limit()` too, though. I'll adapt it to
`rerere_gc_needed()` instead.

Thanks for your review!

Patrick
