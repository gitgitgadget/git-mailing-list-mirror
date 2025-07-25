Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29C239E6B
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441903; cv=none; b=D2NTDDXTl8BEE1oxWtjIcuEMPUTi31X2HkF3I4Y5+Ja0RD+R0g02sCT4NNipi0iVVuh/CjZAS7uuDsEt2vwqLdNTUJFYqGeBdzRO3np83BP1M3OtIrnVh1efqvv8HlHHoqXhZg4qS392Yb070yTlsH+MBS1fmY40DEHDnWKtzdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441903; c=relaxed/simple;
	bh=qVD52FDai/VmVrNRYvPbeo7+dXzEyZ416NmZ8S9DMRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enOtriNY/tIpt9ZlRvVA6d2fsgzcjzN9u16iKqQr6aHkeuOpW009iNqWt1T1vX50qGq24DvN+qymQlflj9Y56gruIbwOSoBtops9/oOFb5YqqUCXq2jWJHbI+eZbN9QggD3Z9MtPl1A/JuSjyu6t7KDl3r8xQHY9cX1bGLIFAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PjMkPE1M; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PjMkPE1M"
Received: (qmail 26172 invoked by uid 109); 25 Jul 2025 11:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qVD52FDai/VmVrNRYvPbeo7+dXzEyZ416NmZ8S9DMRw=; b=PjMkPE1MhMffVQfD9GXt2eU8GTT6d3YcTkOVmmP0lvq+aNpta+JM+oEpHx/+DB/lbmZqiQ9UUrU7x3O/fHGKU3klCQc3xFnPDZYGU3HdfP79mzniI9h3urmSFWCn1oVOdZ1zdvl0UFLGhYXMLvOT2MQLWHoFRxjmWpPWxXNeUNOuWSbNIQ1niAaeRQF/coc1BWUml6d01fm1vvrhsIh7QK9sptap59sJfhzAWP+xWM0PRcCDfyWGhKm6uBp/cKl99IVTy1SL1UAUquISfei8qjkV+f3J+R87FP8AIOghEH+/baW8WtdDtgs+Ef5sk5xWxuaRmSjmT1W/V3wgqfe6tQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:11:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21135 invoked by uid 111); 25 Jul 2025 11:11:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:11:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:11:39 -0400
From: Jeff King <peff@peff.net>
To: hi@arnes.space
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
Message-ID: <20250725111139.GB3014187@coredump.intra.peff.net>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
 <xmqqqzy6omul.fsf@gitster.g>
 <87v7ngstc8.fsf@arnes.space>
 <6A35A7CF-966B-4EC7-B575-86E6CCB68D03@gmail.com>
 <87ldocsnew.fsf@arnes.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldocsnew.fsf@arnes.space>

On Fri, Jul 25, 2025 at 10:08:23AM +0200, hi@arnes.space wrote:

> i understand, and i get why that's useful from a performance
> perspective. but i think i'm arguing at a different level.
> 
> i'm saying: `--name-only` can change whether a file appears in `git
> diff`'s output or not. that is surprising, because the documentation
> mentions nothing about this, nor does the flag itself sound like it
> would.
> 
> my argument is that the non-buggy behavior would be to make
> `--name-only` more consistent with the rest of `git diff`, because it
> would be less surprising. the fact that `git diff` does not look at file
> contents when the flag is given to me is just an implementation detail. 

Yeah, that line of thinking makes sense to me. It's an optimization not
to look at the file contents when we do not need to. But if you've asked
to do a more specific content-level comparison, then we could do that.

I think Junio's response earlier in the thread discusses this, and how
we already respect "-w" for "--quiet".

I'm not sure I agree with this part that he wrote, though:

> It is just --raw, --name-only, --name-status, and --checkdiff output
> formats that deliberately ignore content based ignore mechanisms.
> 
> And I do not think it would be a good change to have them follow
> "ignore" bits.  When asked "has this path been modified?"  "what are
> the before and after blob object names?" etc., it does not make sense
> for the answer to be different depending on the presense of -w or
> --ignore-matching options.

I can see how it gets weird when you ask for --raw, but the object ids
we show do not necessarily reflect the content we actually compared. But
it is even weirder to me that something like:

  git init
  echo 'foo' >file
  git add . && git commit -m base
  echo 'foo ' >file
  git diff -w --stat -p --name-only

will show "file" in the name-only list, but not in the accompanying stat
or patch! If the user has bothered to ask for a whitespace-only diff,
then it feels to me like the least-bad thing is to apply that
consistently to all output.

I do wonder if changing it at this point would somehow break somebody's
workflow or have unexpected fallout, though.

-Peff
