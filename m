Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0552D7DED
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497618; cv=pass; b=XXNvHGARcHMa+KA42BU1JErwzl6kMi9wxZz1hd2WNwzgcSpilcrjb6GPmNd1zka5FfqEhlxhPAPi/Oa/11KOKYqCTzFr6oJuObTqPPt/z7UAy/iyiLMolpOc2Pd6kv1i5Nus/yzB2+9rgjkkjoEOqsRDoPLRSIlOS0djBq3BZlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497618; c=relaxed/simple;
	bh=g+ajSeCMFZt3FnDlUCZ9i0B1iuNm9kx159gN7e04pE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IntW1k4BWmmBf9UpW90k3U8q1iIACAElQuvf9jhIzixeP4Y+HD8capEbAIw/QtaPZOAg4IN4A9q6FqWCDGuzAYZsEBQnlpPrhP4DzsIkaE6zcgHYePK+E4ToCDGBgIX8/BHSaR9pjIWEPwntmgGNaXovefUN7srbyp5hpSVI3Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=S1NdUmcV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="S1NdUmcV"
ARC-Seal: i=1; a=rsa-sha256; t=1768497598; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ECwZ7tnQRC3EklTLbgI4RcqictMnLhCyhxd0DE1iRmsxRTKDV6OFGj+u5rBOVidKiM1ti7NZL1GCFR1QN1AUKT9PUqfK/JD0FYivGAMTWDPQ1xGfaUF5Q8eVLEGuHYEGjCyegOXJM+NOJSl0ddcvQ8cSi1z03TYb/ZHJ/Lm0auo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768497598; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DksmFQsrRBLXEGXuJrzXsi7R/hz9nwcW0EYNUA6AN5M=; 
	b=eUUcS6l70AO2CJaucN6AZ/1Y7Y6Grrm1zOwiEdH/w6eN5xKS6OCRiyQAnEg05XWHmoYnxS5QCpwrOFG7ZMjtYq03MpbtiF2gCg0ckjqXXpTzS9AR+1JZe33GkQh3Mkl37hW17Y2LIECeCIHzJY4F5A91Xf3YODImeQFVVeQiHBQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768497598;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=DksmFQsrRBLXEGXuJrzXsi7R/hz9nwcW0EYNUA6AN5M=;
	b=S1NdUmcVtu1TucwNUqcb+msNdxdlwdUBMtlx2+EOe6Bg84m9XvBRJ/rA54UXa4Qn
	E4B4U71bRd3zYDmSpS4zvLj206rncFiXNrsB4Aws6WpKT3SxRVyKPSnhGrck4nNywu8
	I7+sKYi6fDrcxe2Y1GWmFRDY32BBQqlvvY8P7vsw=
Received: by mx.zohomail.com with SMTPS id 1768497596774294.1564777530467;
	Thu, 15 Jan 2026 09:19:56 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Jeff King <peff@peff.net>, Chris
 Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <xmqqpl7bc68b.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <xmqqpl7bc68b.fsf@gitster.g>
Date: Thu, 15 Jan 2026 19:19:53 +0200
Message-ID: <87o6mulrnq.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 15 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Hello everyone,
>>
>> This series fixes 2 regressions reported by Chris and Kristoffer,
>> introduced by the 'ar/run-command-hook' merge into master.
>>
>> Based on a discussion with Peff on v2, I do plan to revisit and
>> rework the server-side hook I/O polling & batching logic, however
>> that will be a separate patch unrelated to these two regressions.
>
> I've read these two over once again, and am inclined to say that we
> should merge these in upcoming 2.53 release.  Opinions?

I agree with this.

We can't let these two regressions enter a release, so we have two
real chices:

1. Merge both fixes to 1.53 or
2. Revert the 'ar/run-command-hook' topic merge.

The only remaining known open issue is the potential deadlocks in
server-side hooks highlighted by Peff, however that is less severe than
these two (I'd actually be surprised if anyone hits in practice without
a well crafted use case, having access to those hooks).

So I'm inclined for option 1, to land the fixes.

(OFC I'm working on the deadlock issue in parallel, just addressed the
user bug reports first).

Thanks,
Adrian
