Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9C1FAC5C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776033; cv=none; b=To7kTRTOcu9bYh4gPkLsd9yaYOAW9T+SllLNgGHo403Mm1lUCBUs3ml8PXZcEyqlI2AbNzViyHgHZ0GeaeXEHeq3bY7bbKq3Rn76v8ofm+l7cc24fM4qoABYAaJR8tqfRPv1woj+WiFDVgnw/LreoaeyxBk4SY4oGMDr1OropOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776033; c=relaxed/simple;
	bh=D9bkowcjAcC/I5uH2LDbSgnU6sMG9ZNvkAXXXJa8Bpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXCU+46DWgNfIZfHbr3lqHqpinrjD7q7hhj0ONctjjSKyo2gSdPDnwMBHNGnLuFXlpU6Cgmi7AFP5lf2w6ZsLtrk30hAsY/C0n17SJU6WHjhu1arhIsMyg2HnZ9KEe6pYoah4p+kEunshUQXeOR4DE3Lcg6XRdzcSbhoB6vX/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9dkNNHb; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9dkNNHb"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2a01bcd0143so4677296fac.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738776030; x=1739380830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2UC/H2+UFOa07SWXyNJtN93yLOH7oPKmxmwCIYrIMo=;
        b=I9dkNNHbZnyJnJgCdhlDfoUUAwK1dQreu6u3hkCWQ3YyqahThYdDD+hC77cgMHuiFT
         HGX5GkmfIxqPlq8ZzHigQkf9qFi7T//lBPhbmxregxi92eom6RxkqGS7jkbOshAz6V9o
         5sFkivw2HjJVVSyb+SH4u6b1lsIyLr7Fxqxbi9t/DuM2UsLsO5LSGGybS8fjfcUDOmKm
         M/C3mMr/3xSCE3ycp1lPTJk+Vh6urUrlu5BXjyUhX8P1u37K7WAWMp6VxG+bXQrUK/BK
         mGgoduvhbdRgtUe6DP4Q6jWuwK0jaz9vJ+TVXKZz2DNdHSAeQbbO+ITvE+mHhtWLl6K/
         I9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776030; x=1739380830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2UC/H2+UFOa07SWXyNJtN93yLOH7oPKmxmwCIYrIMo=;
        b=i9pXi41scHjpGdsZlZf6mZVXa8Z/8jyabnyWpeeILcTBXexOKlrBhyPNlYbeI8l65/
         SojsWpFqunpEP+hbHVv2XgpU7U7ZIajrYnUt+oRIoxB0lcgo35AlJks6ZmeBkQNmY9bY
         cFE3ClMx/E8/qtYVdvIa6O9gUK9QlWN9wvxp5uU0BogF5Cd9cBnFBL3q0CU5GW26KnNn
         wInZ079zM29omfiPApRQKIyfq+d5krJwojagT0VBTyvE5dH1+cx3qthXxXawXHFVO5Xi
         fHNxGEnEJPz0EmeijAWrobZh3F6ADUYotPIy4fnmxjhCYvAeBEN3S3mFQ/UaSWlvAX2Y
         8CIA==
X-Gm-Message-State: AOJu0YywrCks5BP/CRq47dTrZn2UUgEk48KR5ZuY6Hu/9dKDOqf+vZMm
	sRJHSjx7BKP2ivLgQZFmaG5xXKo82+kEC8Zd5jXuYyJ8N/rZT2Xo
X-Gm-Gg: ASbGncuPgSblslxsXa2DjtnUi5tiVXhRJOnzHdf1gl+FzWdWcXtAPONCFW5wUR+DIGI
	n82AwUgNdOaX1Sj9GPIgab/jsY2/R75sV/klCIcsCcnVklJEhnKVBnnAGyIQlffyptD7dW0udFp
	vufodnkQ/7BulNqEfhrkKgNIzYIN3tEG6xr8Dh0B1ni1Q5w0mU5yojqReZi5IlhJwnEI87lNcbZ
	WL4GGJ7Evq/Wa+yolRfavwn4VfEQMSuAamZrfhPweAQs3IXn5IRucxSp8PTeEHl5mAwpODi4dxa
	YeppV1T/
X-Google-Smtp-Source: AGHT+IE12P//mgFEbx8OlGuuOKTDdRZYwoEKQOlBUWuo0U5fuBw8z68RppFO5CXU3UOnYJ4vKnB53g==
X-Received: by 2002:a05:6871:600e:b0:287:4904:7125 with SMTP id 586e51a60fabf-2b804f4f99fmr2258013fac.14.1738776030520;
        Wed, 05 Feb 2025 09:20:30 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-726617eb64csm3995814a34.37.2025.02.05.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:20:30 -0800 (PST)
Date: Wed, 5 Feb 2025 11:17:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/2] rev-list: print additional missing object
 information
Message-ID: <4peozlz56kmdhziyq6uhsvm4t7atmwtbl7divyuqqb4l64wgom@z3adjdx7v5x2>
References: <20250201201658.11562-1-jltobler@gmail.com>
 <20250205004147.887106-1-jltobler@gmail.com>
 <xmqq5xlor0la.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xlor0la.fsf@gitster.g>

On 25/02/05 05:18AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > One concern I currently have with this quoting approach is that it is a
> > bit more challenging to machine parse compared to something like using a
> > null byte to delimit between missing info. One option is, in a followup
> > series, introduce a git-for-each-ref(1) style format syntax. Maybe
> > something like: `--missing=print-info:%(path)%00%(type)`. I'm curious if
> > anyone may have thoughts around this.
> 
> Would it be so bad if we said that in -z mode with --info option,
> each record is terminated with two NUL bytes, and elements on a list
> of var=value pairs have a single NUL in between, or something silly
> like that?  The point is to get away with just a fixed format,
> without any customization.

I agree that some sort of fixed format would be preferable as it's less
complex while also being simpler to implement. I originally considered
using NUL but realized a single NUL byte to delimit between entries
wouldn't be sufficient to determine where each record would end. Using
two NUL bytes next to each other to mark the end of a record would work
though.

Since even a normal rev-list record may have an object name entry in
addition to its OID when the `--objects` option is set, maybe we could
introduce a `-z` option that always terminates a record with two NUL
bytes?

The output for `git rev-list -z --objects --missing=print-info` could
look something like the following (no LF at EOL):

  6aa71444d3d41315509c3f2cfe2d45d86cea20d7<NUL><NUL>
  f009994f5d7fc97c1e87b4dc7ad69057a07e85c4<NUL>foo/bar<NUL><NUL>
  ?f10f78c60046b2be841c9e2403960663439296c3<NUL>path=foo/bar/baz<NUL>type=blob<NUL><NUL>
  ?ead43a34efd775b58d6b3e86db6bc71bbedd2c1c<NUL>path=foo/bar/baz 2<NUL>type=blob<NUL><NUL>

Having two NUL bytes to delimit between records might be a bit odd in
the common case for git-rev-list(1) without the `--objects` and
`--missing` options since we would only expect a list of OIDs. Having
consistent `-z` option output irrespective of other options might be
preferable though.

If this approach seems reasonable, I can do so in a followup series.

Thanks
-Justin
