Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383191A23B0
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544586; cv=none; b=ZzggzfDn/OC2GfBuLYFD1+ubyUj6GRewqURU4s/H1crnnmciDR82qyhwvpCbWnWMkfiYc5MfJeXkC+Sh1us0+bFTIpVz7aMsTHp9suW9FHbyh9I/7v8U6+MilY3TaGdj2M35ATcnN/KZ31dm+kT/C91Fw3ARiejnyVWhc1ny5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544586; c=relaxed/simple;
	bh=PAsJ15uQoaseji5f51OztWB2Z8Kg0oTaVzJladHD37I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek1LS6IyW4FyDCWfkGbzX7o1UNKHSbXJ8PRNr8/P8G9mYVaEPBXDIU8TyOCgWSHacxp/YkO6RbO3IJHk/E7zxE54EtuUKgNbFbmx2fRPmDj0KfRMEiLZOFbpxmVD8VsxcbiGKzWJhMzavUuXrl/YWtl+qGYt99210nDYP/6u3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=U9lNOFfs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U9lNOFfs"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3560162276.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736544583; x=1737149383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fvTbjaIxIOkmfqUHt15sNEllHpNe5MaO9nXI/wIB9A=;
        b=U9lNOFfsPiPNQfUznFM7o1ds5VJ8d/vXsNXF6qi7h8120dzV0XzCWZggU3l2lWaSY3
         z+M0SK/247ixWauC0rRi3HMc77mnwbgk6Eezb3yg4XBObBMYVebZkjjgrqrSooXxzHJ5
         O/um0wmNy7oWiXS1LuGW0SDXUz7PNPFeuVcw5PZ4x/u8jhXWQVsM8ElXFF0/TYBva8nn
         XVeOtsH8+mq538htlJQ+kfDsR0wXZjJ2cUSyAvSTmJTu2tQ0sTZA1rDOIn8o2cuHKivt
         TcrtlPAYFGLGrTmQEPUfhYNhpTTW7WFIl0TL4CHsYWsiGEQ3oS5xAknIpssAIKL3eyI+
         AGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736544583; x=1737149383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fvTbjaIxIOkmfqUHt15sNEllHpNe5MaO9nXI/wIB9A=;
        b=pkRg+dUWmQmC8MFSOFgxd+cyFi7AxwmiKNw57Hd8G8L/e1Mx+i6ORq8bD5Fv5CQTZo
         TOBitwPKq6PF+iWg1m3ngvZnIvp13Sqw8qKrVlN2Mn4WVs+WoeokxmildfX2g1ZIbvur
         o08g1uUXW21DZzTEKAUdY2I3+rKvzuzKbX2yoOgRa7O7WNn6rklXlQsIhcrhpW17fqil
         nPsn2EeKJtDVCUHGHe0EwmLvV5xXeKaV/Z1meMaZ5+YUVeONxFCh+BlzsiSPXtUrgt+D
         Mic24WuY7bl+AiMxHXkaWycnjarGAXAbRLMKYv3iiWUX+HKfydEK2NZjuJaco1sl1/h8
         8r2Q==
X-Gm-Message-State: AOJu0YyjZtw8oi7dz8yChSmmd0l4DT348zBbkipFwUpoKmSTBcEYmyvU
	jRd7b6Q67CvysLPOeJ1sl8Uhwo8Pcv65I0lY1jZDkIwYbWu553MQJxdQABy+WaI=
X-Gm-Gg: ASbGncs7xUmYZMdczk8702F6lT+FUNqNABOAq7YGcl0vv1rR3BRl2TA3edygX9BWwFa
	bOvK/a9ugCYYSPTmHwWL/nKGSu3TPDTthFuYjPEDB50Yj2gyggFnW5e213jaAQMvZ8wvAc0C12d
	oV6ai3HkYgKZp64VzUa2qJ5Fr6/iXUP5WkduT8CUxEVqedGr7x04FxjNKH4ZjE7I6/2xUZDEni5
	+IjeVjelLc5at8M+Vbvpmolo+lxKwuGckD5DCOAXj2kJRGG5GYf8uai8YtD1+DWWoD/QhDEwy6D
	Yg4uthwfjGA+jpxS0RrQ3TLJuS3v
X-Google-Smtp-Source: AGHT+IHdPVaIp9dCKchxMUXJPYyo6rnD2Ksbnr0DC4vjhMyngHnqPMVh3yK4n5fzU8zNJRpozUneig==
X-Received: by 2002:a05:6902:1024:b0:e57:397c:37a6 with SMTP id 3f1490d57ef6-e57397c413bmr229214276.20.1736544582976;
        Fri, 10 Jan 2025 13:29:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55be270423sm482447276.57.2025.01.10.13.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:29:42 -0800 (PST)
Date: Fri, 10 Jan 2025 16:29:38 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <Z4GRQvAIsSIeQuYd@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <20250110104106.GB1014709@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110104106.GB1014709@coredump.intra.peff.net>

On Fri, Jan 10, 2025 at 05:41:06AM -0500, Jeff King wrote:
> On Wed, Jan 08, 2025 at 02:14:29PM -0500, Taylor Blau wrote:
>
> > (This series is rebased on 'master', which is 14650065b7
> > (RelNotes/2.48.0: fix typos etc., 2025-01-07) at the time of writing).
> >
> > The bulk of this series is unchanged since last time, but a new seventh
> > patch that further hardens the hashfile_checkpoint callers on top of
> > Patrick's recent series[1].
>
> I think that new patch is a definite improvement, though I left some
> comments there.
>
> The changes in patch 1 look fine to me (I still think a generic
> "test-tool hash" would make more sense, but I'm OK punting on that for
> now).
>
> I didn't see any response to the review in round 1 about the pointer
> dangers in patch 3. What do you think of using a separate
> git_hash_algo_fns struct, with the one-time conversion I showed in the
> subthread of:
>
>   https://lore.kernel.org/git/20241121093731.GD602681@coredump.intra.peff.net/
>
> ?

Oops. I must have missed those messages; and sure enough when focusing
my inbox on this thread they are indeed unread :-).

That said, I am not sure that that direction is one that I'd want to go
in. Part of the goal of this series is to make it possible to mix safe
and unsafe function calls on the same hash function. So doing something
like:

    struct git_hash_algo *algop;

    algop->init_fn(&ctx);

in one part of the code, and then (using the same algop) calling:

    algop->unsafe_final_fn(...);

should be impossible to do to. The benefit of having only a single set
of functions implemented on the git_hash_algo type is that it is
impossible to mix the two: you'd have to use a different git_hash_algo
altogether!

So porting the above example to your and brian's git_hash_algo_fns
struct, you'd still be able to do:

    algop->fn.init(&ctx);

in one part of the code and algop->unsafe_fn.final(...) in another part,
which doesn't appear to me to be safer than the current situation that
this series aims to solve.

But if I am misunderstanding something about your/brian's discussion
earlier in this thread, please feel free to correct me.

Thanks,
Taylor
