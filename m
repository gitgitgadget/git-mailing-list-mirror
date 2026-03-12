Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541143FE653
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337553; cv=none; b=AN6SWDtyfnEWNe6C4c2R8gXTHAG74moEfvJEYtz56fsrdNVfPg+cisL1f4FI7jo5s3TngaEsrQlV4oorjqSx6WKDzJU3FJkrNZI6nX5A59FFHB1rlgFVwrdANIe+LMzb44bDxjRwKx4jvqsxCdc90l3G7uCtCxldSaIgiH0yodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337553; c=relaxed/simple;
	bh=9UA+zCQiWZ2VVssFmUcyvVVw+UroCnvHLhQwggmLLwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHiKXyA5x4aGOTgPpAny/LJrVhqRHR6jbt0CcZ1LO72hwXRZn8jX9TljCi5i7DngqfLyNw3Zeo2sNVRdOTvNHzSsyH5eqWGAvKPDFi5OEQ/azfIKJMUJq9PSokOGXsYcGtLh9EYPCh+LdTTJTWIjKxsAZ8EMQLzvsV0iOwgeno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=DbFURvss; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="DbFURvss"
Date: Thu, 12 Mar 2026 18:45:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773337549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xCXr7X7ij6xe2JRj1f7E9aY+ZZkTeaEpy/WmcklrY4=;
	b=DbFURvssXcjJ2nmxlinzGuIilKkTmfV1Tuw6Po+kVo9gNBfzpQRns9aaGvtRsVTDeW8+iD
	gDx/b3i1dk9BtBovoK/ESjZcmG848FEPgMwRBlg/rKPmcMKWkCwv/+bbfPS+5Nutp6vv0i
	kaxAoUjonh9nMjyi/b9xIGAh5NK418FIJ2ek22Vxdf8xatwWOQiBKyCUheaJeDVPqsNkBn
	aP3YpL209oJkuYvOMY4vbKuaqFnaTf2xYRPvkeWTi/AnpHVFj5M/c9bSqgGgXWSd6x0c35
	/ZYR0Da2ru1LVXXKbXHNwy9edBbRbTkLJnN3cqG8nUtGG2jPRbLie06CzSJOFw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>, Bert Wesarg <bert.wesarg@googlemail.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v8 0/4] format-patch: add cover-letter-format option
Message-ID: <abL6gNTwmVfQsmU2@exploit2>
References: <cover.1772839973.git.mroik@delayed.space>
 <cover.1773331753.git.mroik@delayed.space>
 <xmqqo6ktezh2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6ktezh2.fsf@gitster.g>
X-Spamd-Bar: -

On Thu, Mar 12, 2026 at 10:20:41AM -0700, Junio C Hamano wrote:
> By the way, we have merged the topic to 'next' on March 9th already,
> so it is a bit awkward to see a wholesale replacement series.
> 
> We could revert the merge of the previous attempt out of 'next' and
> queue the new iteration in 'seen', but I think the major changes in
> this iteration are
> 
>  (1) the "log:" prefix is omitted (which I think is a bad change
>      that we do not want),
> 
>  (2) we no longer consider the option an extended boolean "use the
>      modern customized format [Yes/no/use this format]?" (which I
>      think is OK), and
> 
>  (3) the default modern format has a name (which is OK, even though
>      "chronological" may be a mouthful to say).
> 
> and associated documentation and test updates, so at this point,
> making incremental changes on top of what we already have in 'next'
> may be more appropriate.  The incremental changes are easier to
> justify as well.

(1) Very well, given that there are more cons than pros to dropping the
prefix, this change will be dropped and will no longer be discussed
going forward.

(3) Would an abbreviation like "chrono" be better? The originally
suggested "numbered" didn't seem to be very descriptive, that's why I
went with chronological.

Please disregard series v8, I will send a new series that builds on top
of v7. Regarding this, how should incremental changes be numbered in
their version? Do I keep going incrementally (v9 despite building on top
of another version), or should I use something like "v7.1, v7.2, v7.3"?
