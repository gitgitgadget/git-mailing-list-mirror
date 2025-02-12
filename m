Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E320E310
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381904; cv=none; b=GQYGmgOzNhfrCa/NSa82adABviyOCw4HfoD61XZAT31tUcqqF4ifNkOOSYxxAl3r7hrm10XQAl9y+UzQAMKMwEqGKyP4LzNDRTo8aapKk/OraV/aguk+LYe2hhYWDV3EnBqR7lNOWU0yQnTIr5E2Okmh8jEF35BWAtjDyHwtV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381904; c=relaxed/simple;
	bh=qmTuMjcjIYPBagq8NuFgUls8JIMkxA/zavtnifIjhfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob83xa7S0WwZdOIjloop+1auIwILt1zg83E1joqkujRPYBduXz+CWrYCuPmASSgqJGwjTd4heVmCLIoGNUxwxLEhCodzCJqCr0/sCHJloi4IsXuFWHLDcuNPEIgW9223BJa01JuI8BpjmOlDPLfFi2zgBlZTuQUymQG9Sy1CSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUaPu2bi; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUaPu2bi"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fc84b7b971so660362eaf.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381902; x=1739986702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIeXvefNHPckCa8UlOskMtwURIz9kaPCK9b8JLQhm9M=;
        b=gUaPu2biSzhqpH64awqdA/uucKCyepNW4bixPND91d0MHdRnsTE8/E2kM2tlgsnXIQ
         ekNs38vQLnybZmUuTnGt54yzgrGpePpNC3ZYa4XeV4Sd/SQavnr953CtZFnLTmYCCL1a
         +yhxnl5O6RJoits4lxFUNhVYYoIKVeKQw0F7zApyX348iXuR/TmO1dyl6I7ajGtOCSdF
         CLW+Ti7uz+BEFWrLqiy3l4qzKBngMl+qW9Jr0Uy/dcO61vy5/rZJzmGkPMZT6ldIxEoE
         e/nfWCSb71o0BW69G+3pOjwJWX9+Ln/0oU/2gIGTcX9oS88s0nMH3cLSwsVXPrSi7hI0
         Q7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381902; x=1739986702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIeXvefNHPckCa8UlOskMtwURIz9kaPCK9b8JLQhm9M=;
        b=CtlxO6F+DsSjzXyMr9nOV6j4hqb0uxsdY/6i2T0iAqdftpSPD7VTbY9+/Yk/jjNUNl
         R8gURK20XmgfSpCEXIf0hPA59MxHgh2m//F7gipO6QLwlIVtxsk56pqI/eqH8k/e1jlJ
         BlGRKjn0b5vS1xgGuiSNtx+kpAKiJPgReVdaWpShtMEmFZMiOh/V0eSUGpaEoIpci/+t
         Er2AXaMDQunUIURwObRPiX8uzVQdFgV7dsbIDj0dGrfPbG+SeDXcNyLtlLUKJ7B8o/DZ
         757hhYTzY1RYaU/H0zSTpqPRDdap84flZpIRHkAYLfMaAgWlNU3c9Hru3JBm3Pkf/R8r
         rZrQ==
X-Gm-Message-State: AOJu0Yy7LGfLHYeloR9gAYi/sZii04I5TmP/VXFtlNsFBn7KaZT6KYM7
	xzDpy9VJJlSL1t09+zcZuPRmv7+B8Y22kjmcFBiSdtTurFA0K8JfliFIjg==
X-Gm-Gg: ASbGncvYZtqJp3GHEUBMN26wgZpHjVJYTPwbwGvcXDo3vj/g156zfH0zIoeL39JBTVn
	pqQ2xN7sk6MJRkCOJNMYXTfRST1z2Mwys4j1OwtapVZ+nzvr6eUsDTbpIiA3n20KCd4L0DzAhlM
	LDyBLk0zkA6ROGkAvpq+imEEUlxn8s81ga/fEOzoclXGv41TES+9KjckN9zRnmrXTWlnrVBHJVY
	futmBHF3qiALG02/6tNk9btpfliKiot2+DTEVW/LwlfuN5aUou+uY2IU84TrCrYhXREJjrcGa+J
	VRAiQjYw
X-Google-Smtp-Source: AGHT+IFA3gEPL3kGt0cukMwTSGj/VyfbIzFEos6pbgBkJYNDDeQoMtyAc8fEOsD5Mty7QehuJoRt7A==
X-Received: by 2002:a05:6820:403:b0:5fa:69fa:a098 with SMTP id 006d021491bc7-5fcafd012bfmr84370eaf.2.1739381902430;
        Wed, 12 Feb 2025 09:38:22 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fc7ecf380asm2889819eaf.19.2025.02.12.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:38:21 -0800 (PST)
Date: Wed, 12 Feb 2025 11:35:18 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
Message-ID: <6we74f5rgmhgu2gfv3x5qi6xdyad3erdgcjaxt6tb4czxbko45@b6b6iq6uo445>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-2-jltobler@gmail.com>
 <CAOLa=ZRssYP8U+kyTYdUY_-WGCLLk4mVxQRbgu87g7AdxPJbZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRssYP8U+kyTYdUY_-WGCLLk4mVxQRbgu87g7AdxPJbZw@mail.gmail.com>

On 25/02/12 01:06AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The `diff_addremove()` and `diff_change()` functions setup and queue
> > diffs, but do not return the `diff_filepair` added to the queue. In a
> > subsequent commit, modifications to `diff_filepair` need to take place
> > in certain cases after being queued.
> >
> > Split out the queuing operations into `diff_filepair_addremove()` and
> > `diff_filepair_change()` which also return a handle to the queued
> > `diff_filepair`.
> >
> 
> This patch keeps `diff_addremove()` and `diff_change()` while
> introducing two new functions which return the `diff_filepair`. Just a
> thought, why not replace them? The users `diff_addremove()` and
> `diff_change()` could simply call the new functions and ignore the
> return value?

This was mostly to avoid changing the `add_remove_fn_t` and
`change_fn_t` types that store `diff_addremove()` and `diff_change()` in
`diff_options`. The `file_add_remove()` and `file_change()` functions,
which also can be set in `diff_options`, do not ever queue file pairs so
I don't think returning `diff_filepair` makes much sense there.

> This would be messy if there were a lot of users of `diff_addremove()`
> and `diff_change()`, but I only see a few callers. Wouldn't it be
> cleaner to just replace?

Patrick has suggested we avoid using the global `diff_queue_struct`
implicitly. Currently, in the next version I'm planning to keep the
separate functions as `diff_queue_addremove()` and
`diff_queue_change()`, but also accept `diff_queue_struct` as an
argument.

> The patch looks good to me otherwise.
> 
> [snip]
> 
> > diff --git a/diff.h b/diff.h
> > index 0a566f5531..6ea63f01e7 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -508,6 +508,21 @@ void diff_set_default_prefix(struct diff_options *options);
> >
> >  int diff_can_quit_early(struct diff_options *);
> >
> > +struct diff_filepair *diff_filepair_addremove(struct diff_options *,
> > +					      int addremove, unsigned mode,
> > +					      const struct object_id *oid,
> > +					      int oid_valid, const char *fullpath,
> > +					      unsigned dirty_submodule);
> > +
> > +struct diff_filepair *diff_filepair_change(struct diff_options *,
> > +					   unsigned mode1, unsigned mode2,
> > +					   const struct object_id *old_oid,
> > +					   const struct object_id *new_oid,
> > +					   int old_oid_valid, int new_oid_valid,
> > +					   const char *fullpath,
> > +					   unsigned dirty_submodule1,
> > +					   unsigned dirty_submodule2);
> > +
> 
> Nit: would be nice to have some comments to describe what these
> functions do.

I'll add in the next version. Thanks

-Justin
