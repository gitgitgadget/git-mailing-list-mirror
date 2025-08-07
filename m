Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73E1E1A3F
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604434; cv=none; b=WQkIEBmtBYW8lPTjhDG9SQX5nmF0rmg/jjIOPBE8ZgBV1wCKB75hu7l6+/dgIjhMHLWB6FDwjUd/Evbt5/5qJX2BBGbTObaxtBsWUqEigZhPpSAGrhAN8wHuU7nIG1ehyVnsPmLY+mFYRRcbt/A+/rlnY5+/sSQkNsZOWJzLzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604434; c=relaxed/simple;
	bh=4u1SdEEv+uXRJdisrgU8jD4TEq9S3jlBMM64F+x5zrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqa5YrhpmM681XtKQNnj7MJmNOF9yM0OE1dV81HTm+6VaH6BdQCbRloEGgrRjMQ9+4cw6HRYD0VQwOsZOTz+zVXVep0ulwNxiKw0pzhKgZV/rRX74F21JW9AXAbIGBoqTjvwEtjd0zFe71tKD+2CSox5u/F+NmaJRnDEMz9e5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fyHsiU+d; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fyHsiU+d"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e5328231e6so1211245ab.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754604431; x=1755209231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqEHVi4P0miiFm9LEd5Xo4Ck+aE9j4xgX6C2UzAN1Is=;
        b=fyHsiU+dVpfXIR3Mvw73HjGA8Vo4L2W1KlJefNZSgL31izWA2GXqtv6OjiNkSQ1acC
         YXxFsweHOsvWMK+G6RnQpJ9n/Bw/sZefU58lxamVlneNHUvvOtPa0+h17tJCUzI7HkS3
         uC9q+7NALSqK4t/YGTCVofM4ubZld9WYT8NFqo4yK+6ft1VmUZGsWzb82PfksRbddbya
         US3HlRdhvFytdsBjYeQfwZvTvO7KbF0nFJbYC6L0z0l24exUBRGKLARrW3hT77Sl8DDo
         HF1urjZtBlUuK0osMI3UVoHkwrDgGNz/X23zYubdu1f50j+Z016qn6L6BgwQjqm4BSFh
         Pl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604431; x=1755209231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqEHVi4P0miiFm9LEd5Xo4Ck+aE9j4xgX6C2UzAN1Is=;
        b=PEUiQbK9NU83Z4dvm8ezA5eqpbxbiBQhaAvJ1VSrrjYFdtJu0KuhAc4Ka1SxRnPMMb
         R//PpSZNgt7GvLLuomp8bl70vCpjcmC6SZlpajALYsWswcvvW9AVzLGglCUsGQgiNVwF
         GaHB+ED6/BZLkUI/xH1PwhCgnomDkt/0zIgrGwsLh1dYu7emMLBwjKgGPLQC5qAjw/3G
         d/RCF9gkQy0mm6I/4hvNQ2Dj52iMZxBaVHBpVlK5ZmASuRhvHVmgR4Rc7ixUS0+BSc3N
         w6J4OSMHAPYNGHzFBJMxgWc7+fQd0NAqdBWCt/Lax8UL5vU3yDkBqDvEN18U0wxwr6mp
         mA/A==
X-Forwarded-Encrypted: i=1; AJvYcCWtFn/GQ2jPM0PBUG80DAxExQAonLXgAUsGcNPpZzXulnW6sOVzXb4dfpXzbC3b57z5KcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JkXiCX/4seYsTa/0PnvrGYb0yE3xtCqQ14TULzxVbLK1nkZk
	8QouH9Wh+cBZBQyc7itP61/IZKw+wGU4x0wjDxOvNRgukFEz8NY3ib69jD46Nbcov3o=
X-Gm-Gg: ASbGncszTAa8LMv5S8+aTzXu+eYJDE3DJo/x4j53XI9ni3ih9nC6F59n73fZ1DrbCUX
	hHc24lt1ZK21C2S/sZfsD9jQZiUNY3EIMS8iDbPxmwo465d1LmZeyv4oWnSWbWbWco6yX7YBtAa
	DQ//QPU9al4k/Kg/LOGsmC4qLODJMnOoe1ZtJ9cnI60EBMKomzSJz32hlijr/+EGdpuzVFNKd66
	NNvhQLpM2/R2s7Sq2P09Tv3Vh081oEXtK0eIp5I5135eFcgpunj1k+A+8P+JWvhVsHUKdSI+of3
	mXiLMVTSvnfeu/t1VkWLMKz+1F9dS9ZfVabeBFm3IXJWNqVKFZQ50tntJK0dT4Ls63Q5+pPX0AN
	HmSbFF2Pb+g9+g057hv7I4a7xoxi3jWykkYuNzIbQdMCD7nL/57HLDGPtgmZqCgHY2cHpbA==
X-Google-Smtp-Source: AGHT+IEyJei3Xl9rkQZWz0lgd4ZjdxG5LbkGZF5XVeg9qnH0wthZEki650IAwZX7K02YOSAhQMpv2Q==
X-Received: by 2002:a05:6e02:160e:b0:3e4:a72:50ec with SMTP id e9e14a558f8ab-3e5330d8975mr15601975ab.7.1754604431321;
        Thu, 07 Aug 2025 15:07:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae9cee258sm68965173.99.2025.08.07.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:07:10 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:07:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: introduce `count_t` typedef
Message-ID: <aJUjh0Uu3/UU5bVg@nand.local>
References: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
 <xmqqa54bqe7d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa54bqe7d.fsf@gitster.g>

On Thu, Aug 07, 2025 at 09:38:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> >  For C programs:
> >
> > + - We use `size_t` to count the number of bytes and `count_t` to count the
> > +   number of entities of a given type.
>
> I am not interested in this specific implementation at all for a
> number of reasons, but I am excited to see people thinking about the
> issues.  The following is a random list of things, both positive and
> negative, that came to my mind after skimming the changes.
>
>  * We do not want to pretend that one size fits all.  If it were a
>    good idea for developers to express "This variable is a simple
>    counter that counts up from 0 and never goes negative" by using
>    an unsigned type (which is dubious), it should be equally, or not
>    more, a good idea to allow them to say "We will not have more
>    than 256 fan-out directories under .git/objects/ and this is a
>    counter to count them, so I know 'unsigned short' is big enough
>    on any platforms".

This to me is the most compelling argument against a "count_t" typedef
or something similar. Different callers have different needs (the ones
you pointed out above are the ones that I thought of as most relevant),
and we shouldn't force them to all use the same type, or pretend that
one type is best for all of them.

>  * As far as I can tell, the patch does not seem to address the
>    biggest concern of unsigned integer wraparound.  We often see
>
> 	ALLOC_GROW(thing.entry, thing.nr + 1, thing.alloc);
>
>    with the arithmetic "thing.nr + 1" checked by nobody.
>    ALLOC_GROW_BY() is slightly better in this regard, but nobody
>    uses it with only small exceptions.  And of course, alloc_nr()
>    does even riskier arithmetic that is unchecked.

I wonder if we should push more people towards ALLOC_GROW_BY() for that
reason. We could do something like recommend that callers use
ALLOC_GROW_BY() instead of ALLOC_GROW() in cases like:

    @@
    expression array, nr, n, alloc;
    @@
    - ALLOC_GROW(array, nr + n, alloc)
    + ALLOC_GROW_BY(array, nr, n, alloc)

, but I'm not sure that's a good idea as a blanket rule, since it's
changing the behavior away from using alloc_nr() to instead grow by a
fixed amount.

We have definitely talked before about adding overflow checks to
alloc_nr() before, but I think the slow-down made it a non-starter
(IIRC). I wonder if something like this:

    diff --git a/git-compat-util.h b/git-compat-util.h
    index 9408f463e31..22b8701b40d 100644
    --- a/git-compat-util.h
    +++ b/git-compat-util.h
    @@ -852,11 +852,14 @@ static inline void move_array(void *dst, const void *src, size_t n, size_t size)
      */
     #define ALLOC_GROW(x, nr, alloc) \
      do { \
    +		size_t __alloc__ = alloc; \
        if ((nr) > alloc) { \
          if (alloc_nr(alloc) < (nr)) \
            alloc = (nr); \
          else \
            alloc = alloc_nr(alloc); \
    +			if (alloc < __alloc__) \
    +				BUG("negative growth in ALLOC_GROW"); \
          REALLOC_ARRAY(x, alloc); \
        } \
      } while (0)

would be a reasonable compromise? It's not quite as careful as checking
each step of the computation done by alloc_nr(), but it's better than
not checking at all.

So perhaps we should do some combination of the two ;-).

>  * Standardising the names used for <item[], item_nr, item_alloc>
>    somehow is very much welcome (we can see an example in the change
>    to builtin/rm.c below).  Such a naming convention would allow us
>    to write
>
> 	#define ALLOC_INCR(thing) ALLOC_INCR_BY(thing, 1)
> 	ALLOC_INCR_BY(thing, increment)
>
>    that do ALLOC_GROW(thing, thing_nr + increment, thing_alloc) more
>    safely than what the current code does, perhaps?  Also, we should
>    be able to use any unsigned integral type and perform sensible
>    bound checking with typeof().

...meaning that ALLOC_INCR() and ALLOC_INCR_BY() would use thing##_nr? I
do like the idea of standardizing on that naming scheme, but the
thing##_nr approach is a bit magical for my taste.

Thanks,
Taylor
