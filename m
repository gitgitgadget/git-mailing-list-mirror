Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F682D0275
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564108; cv=none; b=IhmiBRaCcXpkpubORe1o/4rcymhgJ9ZaQY+XIywa2yO7QR9Re3yk9kkmlWOC166ZcDLcmkvlM73SQcE6+w4Bn0i+ooYH+RZ0gY+oq58M40uMVDJj+oX0rK84bbuGtUGqA39PSIB83ASvDEe6m6kgfcCHdlX3x6H4PHawAKXW9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564108; c=relaxed/simple;
	bh=9kg45B1HlULVbOqjrmBmsrI1ROS21o8KggepDXZk4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKupU07MSrWMZUs/Pbnd11M1iFLC1ZM4+6A6RJdJE89KtXeoUMT9ars/FNDYRO4yD37uqWLm6dFY15fAMk0/XgQSy6/QX4NiFQQAKT8rpUpFl/Owornx9zmrrskr/iC1mgGC8zNzFIpoKtwpKb0ptSbRBBFkh9FK5gL8WXVUFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bMkxgYi1; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bMkxgYi1"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-633c1b740c5so96796d50.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760564105; x=1761168905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuIp28pzfhT3hh9BjAJ+zY1EVkDY/6Zf6OrH0xDZ7Io=;
        b=bMkxgYi1ey/syW39h4ST/+dqCKvUAt0AeYhd9aXdU+cEGna3lZa7ciV2CnykukL3+e
         KGT+yi/OwqC10Mix78cIAELiVw6Itedn1rY3hJFcMcFSD35olVA7gxkEFCG1qTdmgqSJ
         l6Z0sEgNQhBkBZqamvwWNqWGDq6gKUEwnryiyU4ri+fpHEsKhSfcOppmpg3zbDHMsI90
         c0Cj4X7lI0XEj0ufpM8l5gW4010NoIGqYHOsBh23PAiFoYl7Q3QsddEPElg798MUjI7q
         NVg6XDlNubQdx8npXn2gSeiz5yqX/qFnj8SYxztaVyv9V8eS6tiXALblcoisZiLB1fwg
         DJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564105; x=1761168905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuIp28pzfhT3hh9BjAJ+zY1EVkDY/6Zf6OrH0xDZ7Io=;
        b=ZYSFa0e45AKBRhD//Y+0KcQYvoKoYMthBOHVfulJHmHSsigCIOB3YmlRjE4+SgbloE
         fLE1p0D5ewRQH1s9lp59MXi1/aV+9HEGgf7CveU7UzrJE3IoVd2yxoDSbPwcpQh2Q6Js
         oqT9jpDcC5+x7MBDmk0UUgWppXJI41Sp9ASrvdfhn+kCIDeLK/Z/jPZ5lusLsg413JxG
         fFyFMt9PqjmNda5OeRgevrjX2LtQhAgySj/h/3mr5Ut08RCIMJAJW0ZVRtGhsX6teK/S
         tsRAX5BiDqivexnx8HMka4sm9bpXEEMcwRtgX4ywSBv7OZYFA1cbZFtf7oL6P6gBQko1
         a//Q==
X-Gm-Message-State: AOJu0YzpOirjpu1YT8R+RwbmwDsZZUGwCCbXSVwrckJ64nvIvGgk+Avj
	fZAPsN4WuUp9g49I5n9AhoexPJr+FMyAexddKyDqcG7j1tH4NGBCmZuhBbHrHAc/pZI=
X-Gm-Gg: ASbGncvxpb2C/hH66cJV3llDPnmmI6IjPQL8G446LyNcBCnUYW73KRRZ8kDkSOvAlS2
	zh8sCapogKM5bFqV0mp6M3lJAfR2Bq4HA/wRm/ukp3ErioQA3/eyvwbScWVrGEiwe4ed8ZJOb2d
	m2xLLE04XGvypm05j5JkV+OJlxALQnELvCWKyE8A26G65Iop6ceofjNN7Dec+shYkCeIQVxb7MA
	x17Q/RRrx7Pcmjgxl4tSRlnkRZdfVm8Bmjwgcmn6Xg7MgKRA1S9uTQZqOetaMp2UiscnC31YEVW
	/oPesRh2l/udp9P7JBj8OsHQfmGqsOwVk4upIo685LlOW8hObZ1uOP0tDa3gTxBxV2Mu5pXDMuA
	faBm9U0VqrVUKhHlT+n+tsmk+A42TLXbkSgR+vtSWf/hkB7HsESNxsiqn089O/GSqNmxjhBJHR+
	35bwZqIISZe0hMxwgUsch6bWtceHqrKFjDdr/+3Jz9crqvreAhSPPnBML8NU+fidRhDowg7cLlw
	NJuyz5B2+yGLNI0/Q==
X-Google-Smtp-Source: AGHT+IEauVCAgHmk+PTJQIALpJBqYkaNtiPgrt6zxeQP/Xiiain3kmTdxLZI0Cn0cv/2KkbuH3vWkA==
X-Received: by 2002:a05:690e:1a10:b0:63c:e3dc:bfa with SMTP id 956f58d0204a3-63ce3dc1538mr16002594d50.52.1760564105183;
        Wed, 15 Oct 2025 14:35:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd95160eesm6005250d50.3.2025.10.15.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:35:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:35:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 44/49] builtin/repack.c: pass `write_pack_opts` to
 `finish_pack_objects_cmd()`
Message-ID: <aPAThyMlw4oNEBnJ@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <11f78993f1d2d56b204398788780b30318d83afa.1759097191.git.me@ttaylorr.com>
 <20251015110155.GF2250228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015110155.GF2250228@coredump.intra.peff.net>

On Wed, Oct 15, 2025 at 07:01:55AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:10:14PM -0400, Taylor Blau wrote:
>
> >  int cmd_repack(int argc,
> > @@ -294,6 +294,7 @@ int cmd_repack(int argc,
> >  	struct existing_packs existing = EXISTING_PACKS_INIT;
> >  	struct pack_geometry geometry = { 0 };
> >  	struct tempfile *refs_snapshot = NULL;
> > +	struct write_pack_opts opts = { 0 };
> >  	int i, ret;
> >  	int show_progress;
> >
> > @@ -560,7 +561,10 @@ int cmd_repack(int argc,
> >  		fclose(in);
> >  	}
> >
> > -	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
> > +	opts.packdir = packdir;
> > +	opts.destination = packdir;
> > +	opts.packtmp = packtmp;
> > +	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
> >  	if (ret)
> >  		goto cleanup;
>
> This looks a bit funny: we are creating a write_pack_opts struct but
> only filling in some of the fields. Notably po_args is NULL. It's
> zero'd, which is good, but as a matter of API design, how can a caller
> know which fields are important for a given function and which are not?
>
> I guess I could have expected cmd_repack() to make a fully fleshed-out
> write_pack_opts up front, and then pass it to all functions which need
> it. Rather than making a custom one for this one function.
>
> But I guess that gets a little weird, because it really has at least
> _two_ such opts: one for the regular pack-objects invocation and one for
> the cruft pack. And really maybe one more, for the filtered pack? And
> the conditional blocks for cruft and filter_options packs shadow the
> "opts" variable. Yuck.

Yeah, it is unfortunate that not all instances where we generate a pack
use the same pack destination, or even the same set of options to
pack-objects.

> I'm not sure if there's a good solution. My inclination is to say that
> po_args should not be in "opts" at all, and that each function should
> take a separate po_args as appropriate. And then we could just have one
> write_pack_opts in cmd_repack(). But there is another snag: we sometimes
> override the "destination" field with "filter_to" or "expire_to".
>
> So the struct really isn't "here are the opts for repacking", but rather
> "let's marshal some arguments into a struct for one function call".
> Which of course is a bit verbose in C, hence these extra shadowed "opts"
> variables.

I think that only solves part of the problem, though. Among the other
spots that call functions which take a `struct write_pack_opts`, not all
of them use the same destination, so we'd still have to create multiple
`struct write_pack_opts` instances in `cmd_repack()`, or pass the
destination separately, which feels equally odd to me.

> So I dunno that I am really asking for any change. This might be the
> least bad way of writing it. I guess if we could avoid the shadowing
> like this:
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ad60c4290d..4e4519b180 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -108,7 +108,6 @@ int cmd_repack(int argc,
>  	struct existing_packs existing = EXISTING_PACKS_INIT;
>  	struct pack_geometry geometry = { 0 };
>  	struct tempfile *refs_snapshot = NULL;
> -	struct write_pack_opts opts = { 0 };
>  	int i, ret;
>  	int show_progress;
>
> @@ -372,12 +371,15 @@ int cmd_repack(int argc,
>  		fclose(in);
>  	}
>
> -	opts.packdir = packdir;
> -	opts.destination = packdir;
> -	opts.packtmp = packtmp;
> -	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
> -	if (ret)
> -		goto cleanup;
> +	{
> +		struct write_pack_opts opts = { 0 };
> +		opts.packdir = packdir;
> +		opts.destination = packdir;
> +		opts.packtmp = packtmp;
> +		ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
> +		if (ret)
> +			goto cleanup;
> +	}
>
>  	if (!names.nr) {
>  		if (!po_args.quiet)

Yeah, I think that is the most reasonable outcome, at least within the
scope of this patch/series.

> That might be nice, but introducing the extra block is kind of ugly. Of
> course you can get really fancy with a compound literal, like:
>
> @@ -372,10 +371,13 @@ int cmd_repack(int argc,
>  		fclose(in);
>  	}
>
> -	opts.packdir = packdir;
> -	opts.destination = packdir;
> -	opts.packtmp = packtmp;
> -	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
> +	ret = finish_pack_objects_cmd(repo->hash_algo,
> +				      &(struct write_pack_opts) {
> +					.packdir = packdir,
> +					.destination = packdir,
> +					.packtmp = packtmp,
> +				      },
> +				      &cmd, &names);
>  	if (ret)
>  		goto cleanup;
>
>
> But that may be a bridge too far.

As much as I'd like to use a compound literal here, 9b2527caa4
(CodingGuidelines: document test balloons in flight, 2025-07-23)
prevents us from adding new instances of them in our codebase for the
time being.

Thanks,
Taylor
