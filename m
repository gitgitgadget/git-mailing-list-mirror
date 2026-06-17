Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7C3BB9F1
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681216; cv=none; b=JEp01F4EMO19tIHtc9ocbiBfmgdxEUptZ4YoLEL05wThQyVWVghjgCYQ1zWXmmeuIE/QRtLatioT/RtqoGvgX6o5Zxd6F65BRIa59wwCwRMt4wGzb8fgI/HQ7RA4BjaRAjGYYNWksabOWMnDUbfMYQfrDMG0k1QqTzNxMd0YHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681216; c=relaxed/simple;
	bh=OSH0P0hPM8/S3OABkCn+359nYnx3RnYIbiLnPQayNH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byoKBp524Of5HA4f2U01WyxnHCd8mG6pvehU3MrjHrCJIbGn37ypPa3g+EGJZI+ZNMV8e/8Jud0kR/oLhX5Phm3Pe2MWb6x3L6rPNY2DXk6uoJB7+k8P2rMxsLX4bWazP/opCd+BwxdRlMCofnmXNrgOFLzT5BrWn13kR3F46z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PelCg/Lh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMZPGdHz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PelCg/Lh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMZPGdHz"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC6D57A00A1;
	Wed, 17 Jun 2026 03:26:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 03:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681210; x=1781767610; bh=jLyUCqIHAb
	6/dXu/wPFgKJ22rV8Bj9rBiDPOxMEdAeo=; b=PelCg/LhqtuGfdvgGf8mbP7tRn
	JD8j1CgPR43nDd7pnQNUcVE3npfzZkMXvhNAf3Fmwo4mCpLDwjjABm1QdF4UH8AX
	TOjqoRl4JvDKhfi7dEnSyL5MIFVsOIzzFlxlIWhGRlnlJ6IZSotv7SvFMOL1sF2y
	BaqsbINXdbglNDPRx7/gDWocA2wmvALPuyiSzfrvjljQwLcxrbJ4TkrAOAzAih+d
	E4fm6WaI6DfEwLOLfE1bDjV8SQP3F6j8eEcrLs0aVrFft37LzkhTu7bKqopW2D+k
	xmTP1J7Sw5tbhXGKcOVb/cECZSzCkfLQ930vN0M4HBmnmutvEpH6IKDweOjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681210; x=1781767610; bh=jLyUCqIHAb6/dXu/wPFgKJ22rV8Bj9rBiDP
	OxMEdAeo=; b=EMZPGdHzhP4gjsnLnLBA9Cky+7Bio3VcZOujoWWjVwhXCOLrR4Z
	OwFMuQH8ycOOLsAICK2esIWaSZgY7rI2sSsKVUjolEYHqVjS3pydRkS2A8R31qSv
	4BCHZ6ICEEIwUwSxNW/vDsi9tCaNv3+FTlGTSkEHR+5WP5Xc6UW+FyE9w2bsxOiO
	FyigYg/oPGiNTt3k0sbaxhQR2zJG7DbJdwJIQ4KqO8NAZKnxzNoFMarirel5OpE8
	Lfji7EQi3hbqVdlbE5iuXg//9Ei58SChjYOTwOxhwdLTWOkhSn+jkfysv+aXp9NK
	Wt7MchXRUMLUedEoGHJB3ApHTAWAufYbJpw==
X-ME-Sender: <xms:OkwyalHq_cfbXEeebogkAyhE8-wFU7hbbUpZxOkAsolMQaGGZGxn_A>
    <xme:OkwyahyCHzpQhThDaH-OHoKNg0oEO_GsugeFqGOHtw0iwcRnqCyMcXgu8HB0yGC9K
    FxNVlZTWMOaDLo0BM0CE5wCPH5u62EZNSAGGfIu6fufQs_3-77fXQ>
X-ME-Received: <xmr:OkwyakiWnXyvgl854_H5ChNVaAQPpJA85988gq51zWYB6ZGy9p1hs4NNMYgKfrZlJZclH9DOtxh8Fil-M7YtNMuajkiYNFKDTA_DizQ>
X-ME-Proxy-Cause: dmFkZTE1RngZgWnnd18l7Ro7hL6I/hsXdegh/s5p/GXQJec3qnYLlFTMeKjTScI6H0UoLs
    FG5VS7M0YQOG9d3yse3aZqvJCOhlP6B/uPfaIMjCXZ2pJo6fB8mLDBcouCLn5oAsu1pIlp
    Z2hs7XyZlRtorh2BTgN1PtpE3xrkpx0LL8A8VvJMYHwoZcFP3cpMjKd4YUM/MBfpmEMUDc
    RlwrTQrn3H9x22mhYUlzCKVsaTyPuItYtMiex84s3Pg4aO2YvcFg9mJfy87I0fr9W+r8Qn
    Fk9JgHV1nPeOGcfrMQzwM1z4FkOM80X5uNtW5Ap9135XIU3NDwMIncZdd1BJ20/AbGXMq8
    M7uSsmem+KY7u8srBoJh4SBAe/vUMS2QxvBH0h/GfBScH+eThXUmRkdPMZXfq1D5eoic+6
    qM81qS6pcH1d89JX/CR1CtbOPxYEWWXXYkLekazzrXdO0ARK55UWKi3cpQJpu0YEfq4mqm
    MvyBayFXxCESu+Q+ALnElOPZ/Q3PZ/0syibkkypMN07K1CtA+GEmlWQvBCY3AyHd3c6pEx
    EnUdU66FGtqoQ0WrDqWhEHpFOAaMYb6rogAmCoA4zMx9VgMImk2AReYSeOg2of73hgZbU7
    Ou9YAxlFI01SkkhJtJ/9igBS12hW/DDsTsrNOJCJI0Mh2VLIOrsplvmQYKVA
X-ME-Proxy: <xmx:OkwyakwwSIfF6y6XlRmUVVBkLJ1-_XM8WU6j5yU_wm0PU_O16IMOaA>
    <xmx:OkwyavJTkk0RtALy0zX8QDDm3qhSFTZQOeH6kbZ9dsORI3p6Fq4jbQ>
    <xmx:OkwyajSrYsiOlVvDJveQ40nlvcJMytqEqpEFtO9GfGhR6JVDEy5Ypw>
    <xmx:OkwyavqmllFvIBQh0gDgILxxGkfEjY6eEwl2AplRVp1JwvLi0igHYw>
    <xmx:OkwyaiMcwTahjYYaOphrWTjhwGVhhrhcWEJqGzle3vr3oDMmLq1wucR8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:26:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a91d9eb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:26:49 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 16/17] midx: refactor interfaces to work on "packed"
 source
Message-ID: <ajJMNk5eMYR0CjJx@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-16-839089132c8b@pks.im>
 <ajHKmbimHJnFV2IE@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajHKmbimHJnFV2IE@denethor>

On Tue, Jun 16, 2026 at 05:37:53PM -0500, Justin Tobler wrote:
> On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> > diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> > index 00ffb36394..6e73c85cde 100644
> > --- a/builtin/multi-pack-index.c
> > +++ b/builtin/multi-pack-index.c
> > @@ -85,12 +86,12 @@ static int parse_object_dir(const struct option *opt, const char *arg,
> >  	return 0;
> >  }
> >  
> > -static struct odb_source *handle_object_dir_option(struct repository *repo)
> > +static struct odb_source_files *handle_object_dir_option(struct repository *repo)
> >  {
> >  	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
> >  	if (!source)
> >  		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
> > -	return source;
> > +	return odb_source_files_downcast(source);
> 
> Now that we are passing around concrete ODB sources to many of these
> interfaces, callers may have to handle downcasting explicitly. Since now
> the downcasting may happen a bit ealier than previously in some cases, I
> wondered if this would alter any error flows. I don't think this would
> be the case though because ultimately we only have the "files" source
> currently anyways.

Well, we'd be calling `BUG()` all the same. So as we don't have
conditional logic anywhere (yet?) that checks whether or not we use the
"files" backend all error flows are expected to ultimately be the same.
It's only that we may `BUG()` a bit earlier, but I guess the user is
going to be somewhat indifferent about this.

Patrick
