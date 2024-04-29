Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4938BE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368970; cv=none; b=jpiUyDbOlKOZhBHTbZIQDsulf7cJUrXGWp1znNVntTtLDhWWyiyLEZq5YK9Scdoe3FMNh8teNZvjKFe7CamVBsCcE+LhtQPKMorNajLSaFq6jEu2XqltwgxBRx85Qn2Jc0EsfeQvej/4vKD53rdj6RwH8Z4UGyNgEBwny2XP83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368970; c=relaxed/simple;
	bh=bh6TSlX9SJjIJiSEKsJl1Jn+6lGCmQgC1TIb3+Io2xE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nzShmP5obl5EVm6e4Q72ENnmNdnPtOWhpIeJJwl0rAu+eC0QVXkVdO6Xoj/Wdx4e3sO7vlGjMIvj3JcPvlwwSvn+tnDxGjbl3rvCr7oJEwmbx5WOIghJV+Gra53QGRi/GOBptLEiMn4gV5i7ZlI78Nw0BzERv8uXtNlzO+cqfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sstPkk9+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sstPkk9+"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714368964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l//bd5XXlR5MTmU6Fh5vcZb7M6KuFyUgWqnAwoTscL4=;
	b=sstPkk9+XYCCq1s9e/tj7vtaYSQRvm5RgTKurGWHbl82pfNTy33nXw5PyVNKyhZJMWPClr
	aZ9wSJD+9O5TDvel9QQaEmAI3EU5ikudHJMayGtCPe5rN6iawD8jynfzOuDRYvXJrFqs9z
	XGgYfP+nr+Ho7l4Wk8uwSHcfXviyL3o/SQVu48/2yf+VcA3S4VDV3jUUSC2BHunClJlYyQ
	mJFmTBdGl4Ai+2cM+4RWp63l8mTLpIHPrgcEK5NuHcBESx+g3VDNsBO2LK7mfSUqOvHJ5J
	s6SIVKqex0xK28EaqWNvqICla5ZzbwzVQAxU0hoGk9z8lJw/qidJZM2aN+Hliw==
Date: Mon, 29 Apr 2024 07:36:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
Message-ID: <809a1452fb18a6c03d9e8ed516d5c9c0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-29 07:01, James Liu wrote:
> Thanks for the feedback Dragan!

Thank you for working on the patch.

>> After having a more detailed look at the Git documentation,
>> I think that adding support for "--advice" at the same time
>> would be the right thing to do.  That option would override
>> all "advice.<hint>" options that may exist in the configuration
>> (and would override the GIT_NO_ADVICE environment variable,
>> if we end up supporting it), similarly to how "--paginate"
>> overrides all "pager.<cmd>" in the configuration, which would
>> be both consistent and rather useful in some situations.
> 
> I think this makes sense from a UX consistenty perspective, but I'm not
> sure if we should increase the scope of this patch. It's also much
> easier to re-enable previously silenced advice hints, so I'm unsure
> whether an --advice option makes sense. We can also avoid the decision
> of what to do if the user supplies --advice and --no-advice
> simultaneously if we only have one option.

Regarding what to do if those two options are both supplied,
it's simple, just error out with an appropriate error message.
There are already similar situations in the code, e.g. with
the -k and --rfc options for git-format-patch(1).
