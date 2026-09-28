Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC43ACF1B
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580736; cv=none; b=CpqgIoWQbtnXDkZiyGcZ4c9SBqDdq6Ueg6Zt+58hNA8NS/xqwjBSWlX9G/Ofle/GhRQ5HQKDpxUzH+A1RT3bTrQxTL81mBlnolXnAr9RVDhPIdpMjyffInSsI61bUPEqwjf1bJrkHGl3zLE/yVw4czrtHS9tA9TbSn62qp5btys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580736; c=relaxed/simple;
	bh=UZK52hnHheVf0TRIL2xG77XsJ50jtc7oQG3Qg2Mm2Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK90eJ9wH1kDKgZPA+eWlP86wGEr1jiNdKIYjyg5ka/lJYeIFYvJaOjhyyYjWXCJrMBJyTchW4tLgZUTp/UETFbaMjDywrZxX1sYDLpctsxX8XeMi5bIotL4FBt+dddpSOUbiJP4FMWvgv762TY4JYu6WUrj1/x2+Xv2TnoBss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/dbduED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+022YLj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/dbduED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+022YLj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ECCAFEC00BA;
	Mon, 28 Sep 2026 03:32:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 03:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790580732; x=1790667132; bh=SxpFLlwHAL
	uyqCk9vPjzioNqBwIJzeonWc7SdY7XSec=; b=M/dbduED5BeV47OJe+UQzwxbud
	Gq6KCbBeYvGj1AbdpirJ9Q/r686kU5EOFcWkuI+TeI8Pl/t+AeKJxoYqzCc6AZLe
	aBDgqdRh17JUDceS7zL23pJfR07P8GlCVXWAWd2/O89U//UFLpjYJmKjYLXO42Dl
	/naJUxdDek9D76kuSQfrxBF9biivDIp5AkQjyZ40Ae/6ma3YbA3iFTNGf1TpmZrs
	uC/YUtz0Q67fr9k3Q1Oz81idfGikyoAICIersyvDQIEwgncvoDMDj6ydowTf+5xD
	+yXoTFcjqwFILoTh3qc2hIwXOk25SMjPuGi35EoF1GAouClTQZJY0lTxg72Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790580732; x=1790667132; bh=SxpFLlwHALuyqCk9vPjzioNqBwIJzeonWc7
	SdY7XSec=; b=V+022YLjl8ST5Pg2Vrig/V+RUWYxoW/j7Y942BsvDrSKjyrsWao
	q/b5P+Pf8fCHA9zWAlOESxTTtb5639ge1pS1sD3ousMdufkpyrekLRGyqWxejN8v
	lyIbBkIgOtx9Ug41+FFMLcqJUDgFWOOlcY76GJpjVAaG/z7IitVB1cgAWomZfRMv
	aCPfxkJO4ij88le8rxiPUi7Y/eBQUAhE+VQD2LBDxnABCVMgurs766ygiZo/q8lA
	W6nezHJ7oVvbp1/vl9jixBpuYiJVRSvBN1t4Roy9drpIoriAWfKYkeHLPtEYA9TI
	ukd/J/tS2oYYEYbVGthmtzEH61ZODNaE1+A==
X-ME-Sender: <xms:_Be6ajrkKjIK8KCq6ayOQZDFqLVC7RV62AhyybDPqj6vDI1Op4cR3g>
    <xme:_Be6alFAmUjyJsm9Agwgf-sa3lOAV7iPyXqchIejbmxKqPO6VUT8jkXNJ1229Y7-m
    MRu_FDeC-JeBjAM2B2qfUdB0ppubpIzcyIEN2ZT1vLDyoW09etinsY>
X-ME-Received: <xmr:_Be6atkwM1aytkEba1z7grF3-2C7Q-Q1BQ7dXvxqSoEOQvO-qQYChA>
X-ME-Proxy-Cause: dmFkZTE8ibNZ1FYvSoXUjv2E3lCB0zuB2zUf2K828v4qVg5JQBBAhks0WvzlJiPh+FfC5s
    +LYBVPblav05AoQtvBoofYDy5Ls+wXEI6092HVMc+xV4SfhUFb3rKIQt54dwQupYvJiSED
    mEY4U6+EvvyKKpEzeBouKysk1zdojUbLwV+VLqRIdSbCnttfpZFvOtBvAyHz1K7PNW6ePS
    JmtgbO407YR0FA9KYsWH/ERDr9xBi35g55wIXFv4gPF6zX6e5aNaU/JliVoOAR93IrRsus
    C/iaIyOgchvk6HWzweXAyb51hRNc+A25fW/KjgHU3+IgkVtdmhvpzKB3NcHk5o2hYNOEQH
    lRjeFkb3gzBcPWoRuy0SHSJAKeTSG5XxAEk8P8Hk0w36AtgzNORHDk4fpJnIm/6OeIi9/u
    I687i2OIdA1k8sIQXF+Ttc9d/6qgf2lqpFXP9bCV1+PXUxiTyo46EGdh4atYJS6dgx3XPv
    Mn8oKl6Ign/O0JkYFJm0JLyqLbxeLsF6nsVSIIoKXhffl63kR3hZ/fMXHKOkmwoNbAwJBH
    OEk8XLpIiMR+WVsX6/fw72MOHLbS4hXgAy3NElba4gvvIf47tOqqZXaZuw+KJCd4lLsWbW
    azo6hrKtWTAYRutMcLheNXMMKtTdmGdsl/P9TGkE2ZhE0JiHx2o6fWbOSxfg
X-ME-Proxy: <xmx:_Be6aglGhdAu08nkNnJQqOMsYKabKv8i29YvO7kX1W96EWGasLwYxA>
    <xmx:_Be6amtjWE4cGLKP-QL4SVQBqmrFi8Xpot5g1Be-w_jG8pxUPaLiFw>
    <xmx:_Be6arn3KUDOkbGzE-BjsWIGLrsO4qGRMpDkml4CIn3qwOyVUSs8Kw>
    <xmx:_Be6apu5zUALYkX08nVUV7JgwD7p-2mjlZTooN7dIjlYjlE0VzNw_w>
    <xmx:_Be6atMqeKcbU4doVEcy3uSdKnzLPW8-xfsGdoA8SqGGTPqWqwnLoKEE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:32:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c8ebc49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:32:10 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:32:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] history: sign rewritten commits
Message-ID: <aroX94CD_kOyLnuW@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260912160045.36064-3-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912160045.36064-3-git@5ouma.me>

On Sun, Sep 13, 2026 at 01:00:45AM +0900, Souma wrote:
> Add --gpg-sign/--no-gpg-sign support to git history and honor
> commit.gpgSign when creating replacement commits. Thread the selected
> signing key through direct rewrites and replayed descendants while
> preserving the original author identity.
> 
> Cover configuration, command-line precedence, explicit keys, split commits,
> and replayed descendants with GPG-gated tests.

This is much shorter now, which is good. One question to ask yourself
though is whether there's any subtleties in the changes you perform that
might want to be explained.

One such subtlety for example is that you reorder the calls to
`repo_config()`. It's obvious to me, but it may not be obvious to every
reviewer why you do that. Pointing out and explaining details like this
in a sentence or two is useful context.

Other than these nits about the commit message I'm happy with this
series as-is. I won't insist on a reroll, but wouldn't mind if you did.
Thanks!

Patrick
