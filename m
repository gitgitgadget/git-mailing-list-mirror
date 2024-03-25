Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2F12B77
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395481; cv=none; b=ax6FgYycegzptb+3yjtwf63b3zjg/r7fxlkYl27xOTINtIau7xjqYKgBz3tSanTrOjmVpAXWVL+RNG/+eHiXzK0xi/y4Xwigo4pKk5Mjuxf7+VTlcHXxG+8lUZmrDpt9Uu7yv3eWY4M4ptZu2uLAOshIAJJfYmPUXce5JX7bGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395481; c=relaxed/simple;
	bh=l5rFy6riCC6Yp833Zl2nJpDzYz1k/6iFkr5iXMBEWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y66SDCTKPgOIe/NO2Gnd/GpDn7Ff2tmkiz1D01hY4Mly9vUa1D0EsY5Lkz7+XHeOJCtcjfC61j+CQu5AFV6MiJE+HkQ0IbzlbgprM91JWWDjeXcanCLJZS77YK7xKO+KWWmh3lcGgmLjfE2GtD9zcjkh7IOmlCQNoUEaM5+alTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=vj+Eer6Q; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="vj+Eer6Q"
Received: from localhost (unknown [IPv6:2a01:41e1:2dd8:ee00:bc08:5ebd:9623:f7f1])
	by smtp.roethke.info (Postfix) with ESMTPA id 36DF71E0004A;
	Mon, 25 Mar 2024 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1711395058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V3p/ZwJewT6W74Vs5MC1LWnwlqjXMpXcYeVdIlvZJw=;
	b=vj+Eer6QuuTnBxt/4H9gW9ONVv/FFqgnh1V/VWwOS/D/toB6vxUh8yTuXuy5V9+eeo3ANy
	Da5tkx/y0nosVfycBmllr/30pj4ctZ74H8RMVnUtw+CFuRqoYUTMr5Y+/57X1FG/EXTe/A
	QKEZqOADavCtqMcdAxynD8CxIRm/v6jV9bHDpDQ/rnkDHU+3iKpfkNcm51WbOO2MqyEt3P
	jAfW6uI7NJdc4WQIBNN6QckP6KLohjBPpqc/xLHwWfMAnZHhFtpFJ8kTshyICi6SsKJBvw
	dNFbLkT8Pm8MjhlwXJv6R4K7e2ei/Wci1u34TVCp+8ftP+M/zAoLoQ8FlBxT/2xnAtK4ot
	MDLlHgcLCQs1OtosqprG5VaNRwJ9DfA4QlGYfOX89b8h6VbRxjB7Fz/364TZQdEf81FpD8
	R9YDxrndE+xd5sb9BvFLVW9BUH15kf4YW+2Bjsfe2n0DM3gAXRg4c7gMQ6tV1zohNgi+4k
	/C689Uvs+F1d1Z0ZVFjPw3JRsOzzYs9AO+HjbYXgVt+o/sYtteFCHhDhNpweEx7XsH2Tjq
	3ETDFntIIQxD6rZlbCAigUfRQUJQDbzF6C/3r7Q7Orctoa/DMNe6rRJZDhlVMVc9K5SNzG
	HjFck1osqGLDO2IaoahFcOWb0tKdAFQCsShJnP9MZ4V3jCZ01OJtg=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Mon, 25 Mar 2024 20:30:57 +0100
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
Message-ID: <ZgHQ8YsJxUtRpB8M@roethke.info>
References: <xmqqplvjpacq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplvjpacq.fsf@gitster.g>

On 2024-03-24 14:51:17, Junio C Hamano wrote:
> Marcel Röthke <marcel@roethke.info> writes:
>
> > On 2024-02-19 17:22:43, Junio C Hamano wrote:
> >> Marcel Röthke <marcel@roethke.info> writes:
> >>
> >> > When rerere_clear is called, for instance when aborting a rebase, and
> >> > the current conflict does not have a pre or postimage recorded git
> >> > crashes with a SEGFAULT in has_rerere_resolution when accessing the
> >> > status member of struct rerere_dir.
> >>
> >> I had to read this twice before realizing the reason why I found it
> >> hard to grok was because of a missing comma between "recorded" and
> >> "git".
> >
> > fixed
> > ...
> > I'm unfortunately not sure how it happened. I do have the initial state
> > of the repository and I think I know the commands that were executed,
> > but I could not reproduce it.
> >
> > I will look into adding a test case though.
>
> It has been about a month.  Any new development on this topic?
>
> Thanks.

No, I have been otherwise occupied. But I plan to get back to this soon. Probably this week, next week at the latest.
