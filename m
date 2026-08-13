Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42CB369D5E
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627029; cv=none; b=Pr7YlFrrfu+I2oJhLrY9bv4aLe+PSOq2BsbUEEedP0M5AB/Y/DRJXNAGmDugkoAV3lzNH9YIfXBw2YGn8JxOEmgFbA1/rJfx6Q6yKfyBQSQyGqqKF7Hrb4MGLeDlrejSineHwkmE13weffIrbzke1+zR8gTcWwaM5bLFBPxuGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627029; c=relaxed/simple;
	bh=dZo+bBEND+PWFb2rQueSm3HzlwTRSVi4LJD1+q0/o/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHE3TAzzDOVUF3vOwiOHc3E1FmocCZyqVbjUXvjk4I5PDNDwgw2Gen+FMweWflxLkbn6p0FkgP1hulkO75lDNnr9kftxc/0J7oaBLBo1mZcQlHvjiWF1SAu0qTwnbp25YbKZqMe4c0Z/xSJDMwVLB77h/o3T/8Si4/bCE409paI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hQIQS8TJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=govqFesE; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hQIQS8TJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="govqFesE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EB911D0007E;
	Thu, 13 Aug 2026 09:17:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 09:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786627026; x=1786713426; bh=X+NnK0eQlH
	TMpqsOwsnIuqXVUHtWliI5gFaSN4o/CWE=; b=hQIQS8TJei1nxTzJXdiS0YDEij
	dXdSLWZDe7WFxkjaoXuodUGNMEFas09WT1Le/8WeBXumpKb1ARKUEXV/icGEFbjV
	alRGz6s8a+SwfM1esJMlb1e9ouq7sresFroNDZqX3S9igDFHjtBfkc9IjYR2d/e2
	L9gecv3ovPwCyQPaBEXGftvUoS6S93PE6GOh6rKG/AVAx5wYN3imSC1mztwasPqw
	8oTA8l4It0PMtt/1Q4+T6b3pkJRzDf5sm9AhvscdGmq/P1EqNqt6j12r/k+zKwIS
	3p1GIdaqkWptuFEbT4UCYK9ZmBaCA6oRjcTtD+MjIp1jBl1n4KIRp0hY8RUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786627026; x=1786713426; bh=X+NnK0eQlHTMpqsOwsnIuqXVUHtWliI5gFa
	SN4o/CWE=; b=govqFesEZY4W2CXJw4leyC1ziUNa1TaMUeimCaXJ20ns/BmQwnG
	951Vnj6kLDgiryaSP6yDbWO+n7RfoTuHEc4EcqUg8a3zy0a1qo6kmTKwPzbYJ09I
	5jzREaSuymZRGI7gtM2AcU2phOKbMxn4+WpVYG2yfiz4ifbBnNfWGOSH55YYbgOA
	E/7TDTVRIlo1nqLYmqzLOz34iEyvIwNeXdoAvocdTUmPr8GhMNQQfGQLXPLFTooX
	Toi/EyPLVw2L61GeFg21h//3ZIZRapS2SkfabSaRgbaHEK6xx22CqcIpDk6gNMA3
	uwdjmwXx4FtkNlX6xrBEwJk7ehy+3jmDAwQ==
X-ME-Sender: <xms:0sN9aox8El4aZONIcPSpWAh66qP6ELG-z8ngZuMP-Pua9mi96FwfGw>
    <xme:0sN9ajvHppS0eeSlYslpsvKbH_dmTRQ-WnE-mN8t4gI1CsdkBrcCirplRsWS39evE
    XoeaB73U4qbpM3HXW0fuybsPZsL51LfNOnDMlQkO0juJYfQuo4WcQ>
X-ME-Received: <xmr:0sN9anve4ypGxysJ26tdFqFHmq5Q0J2q86lDitOrTghgqI6KauWU9Q7l2XqjXfPxhAv29Dj9ENpu-mJIgWdKa4zCrjWhkK4fgnTtM00n1Osp>
X-ME-Proxy-Cause: dmFkZTE8zgjV3FiF+keoFrRByHnc5BSnhWGb6lORA5+GB/Le8yx3Xv4UCkK6Lx27F9ugQL
    Yl0PiwDA4QQeEMZ9tP6THG6+bjuEn3YlZXQKIl0OhWLYFP2g2Vhsw+mHf4ppl9GsvTzcZX
    EC0UN5VWtriHmq++Dl0BD9S1z76nTPueXRbzspYBEwZ787Xpmyd2aCjsnxqDA0f8KM5aul
    KrZIQhXGM98mil9cUT+mCN2BqJIZvnroE7WfRIM1UKnqgQXhLUmjrOQj2Di7xRNjnzf6Wi
    C2N0VvIJ6CiIHDMVJxEFy+3pfpAthBSy46bT45icPwu+OXQQuHegXBf60OGeHYsZRf4edI
    eNCibVha/ejPapmY2yrpHm0xs6Oydd+kDLDr1ckEr05rh9XgpXPZwwxz7ebU7w5Y2EsWAg
    eEY3LNtOdctqkQkuZmDzSa806bHDSDuVAvRxXE4Taf23hPpojN/bfxvnJfeotp+wBloX+8
    trTCj43aUsH1peIJ6LNS6XxXsH5Rv0pxMBeNats2BymUXdFrWkcH5HjWp1KdXTWhcowT/N
    n1H8d20inK6IN4QYp9ZOOb0NXEFYcW4KHbQEKuKLK2v0+a0Mzte558bBpeVzRHrcLXrFJw
    dYt3xPQf/zsND4PzKk7YcsWnUML61olz2giZ2XuqgIh5TmQbzPKjf4gyr7Ew
X-ME-Proxy: <xmx:0sN9agPAFqkMshoPOB_joKGrHEItpsS2VXIJUYhJA0dFUwFXORLa_Q>
    <xmx:0sN9at3uV3a3KbNTRzFsvdxC98Edp1h1Yx6xEWIFIi4qqDjbyjOOpA>
    <xmx:0sN9akPDWEjvY2-IuJ5zRy5JD-RoblqrmPD55nv5LZm9cKNWBvszyQ>
    <xmx:0sN9al1f0Bb4bpcOU0ZiE28dGK0ib_DmByAhX5xEIt-ApBdv90WSvQ>
    <xmx:0sN9ajJb97GHq_1YFZb1z8-fEQ3Olre-LIWTY7xn__-d1IT35uBE_nJX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 09:17:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4890f7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 13:17:03 +0000 (UTC)
Date: Thu, 13 Aug 2026 15:17:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <an3DzPKAFqygOS65@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <CAOLa=ZTsumAT6U8+pJQmNjYL6Rt=JkvTJ0V7KQ7MvLYkThTFYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTsumAT6U8+pJQmNjYL6Rt=JkvTJ0V7KQ7MvLYkThTFYA@mail.gmail.com>

On Thu, Aug 13, 2026 at 05:23:39AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index bd02d8ad54..51da386f22 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -29,8 +28,32 @@
> >  #include "trace2.h"
> >  #include "write-or-die.h"
> >
> > -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> > -	struct odb_source *, 1, fspathhash, fspatheq)
> > +static int odb_source_paths_cmp(struct object_database *o,
> > +				const char *a, const char *b)
> > +{
> > +	if (o->source_paths_icase < 0) {
> > +		int icase = 0;
> > +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
> > +		o->source_paths_icase = icase;
> > +	}
> > +
> 
> Nit: couldn't this be simplified to
> 
> if (o->source_paths_icase < 0)
>    repo_config_get_bool(o->repo, "core.ignorecase", &o->source_paths_icase);

Not quite, as that wouldn't handle the case where the configuration
isn't set. So we'd retain it as -1 and do the config lookup every single
time.

We could rewrite like this:

	if (o->source_paths_icase < 0 &&
	    repo_config_get_bool(o->repo, "core.ignorecase", &icase))
		o->source_paths_icase = 0;

But I'd argue that this is harder to read.

Patrick
