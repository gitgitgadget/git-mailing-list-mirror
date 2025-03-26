Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665D2045A8
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010899; cv=none; b=hXsf6Ob8KBrt9pVh3PZ0E2QXX1nuPnpynJngbHsv4YYMgr/SbXB7hpROrS0uYqEFXTy1efCfrNluZftgz/y3Do+lXgKpIv8oXzahf8CLEhyAqdf+jC27K9McNzV3Mccy0M6hC9TQcdIZ9QUou2omU8giUETjJoWvGjgVTqbBnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010899; c=relaxed/simple;
	bh=eS7SpYGlaDYuWXqKcK1N23v4hT5XgW8KgM0l2H+dFhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U55PV8rH3dUJbJLbBYYSruPseLQbcZMUcLXSFEv+otdYc7OK+iYM9D+8O1e1Ew/yD0HVYR+fNW1c5uOQyOI9A9V186m2as1NoENUq7aMVIvR4QhD5IbIb8/269E4koyh4yvT96J7C50jG9J9nKmODNwAR7qZgvQq1uJDpIRBXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NCLfZO2n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NCLfZO2n"
Received: (qmail 13605 invoked by uid 109); 26 Mar 2025 17:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eS7SpYGlaDYuWXqKcK1N23v4hT5XgW8KgM0l2H+dFhM=; b=NCLfZO2nKPqV5GMR2QQCHPyGTNuxdaVG2mP7bhixhRafcE19Koz467yec7B4tFcfhrHltYnH7u9R82Q7xCNnGV3RZ/uKw7Iw8LbupL3+hu5CdoM5AN98oCSuqQ3wd5MgJAHRcHdgYphBqWxcMX1ZZOdd9QNAtkc/lEzmNsFJNengwFyup17kOULN6yL6DcxE+yX78HQ/kOxNgO1a5uReHf40JvplCh2QnTK5za+rgHFBQ4Vc0OT8UHv5OlRNCYFVYoNR7thKzV6fXKfF+uf6wSkO5qP//VNrzT5X+qjpCD/x98RvWGsddK7Us0S3bhHFtaOnyweQvM3NXPhfD1X/WQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Mar 2025 17:41:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17733 invoked by uid 111); 26 Mar 2025 17:41:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Mar 2025 13:41:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Mar 2025 13:41:27 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] detect-compiler: detect clang even if it found
 CUDA
Message-ID: <20250326174127.GA2508080@coredump.intra.peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:14PM +0000, Johannes Schindelin via GitGitGadget wrote:

> In my setup, clang finds `/usr/local/cuda` and hence the output of
> `clang -v` ends with this line:
> 
> 	Found CUDA installation: /usr/local/cuda, version
> 
> This confuses the `detect-compiler` script because it matches _all_
> lines that contain the needle "version" surrounded by spaces. As a
> consequence, the `get_family` function returns two lines: "Ubuntu clang"
> and above-mentioned line, which the `case` statement does not handle
> well and hence reports "unknown compiler family" instead of the expected
> set of "clang14", "clang13", ..., "clang1" output.
> 
> Let's unconfuse the script by letting it parse the first matching line
> and ignore the rest.

Makes sense. I wondered if this:

>  get_version_line() {
> -	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
> +	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q}'

might be more readable with "grep -m1", but it looks like "-m" is not in
POSIX. So what you wrote is probably safer.

-Peff
