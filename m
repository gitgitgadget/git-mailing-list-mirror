Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732119CC28
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768727141; cv=none; b=OwQRYDgjVVYVIjkz8XyMotRIHUX3OgxDZUlQlWomPw8tm4DB4VHijNTa3FIELEPqilPLBShSTg5RnKn+XRKjuTK2TCGs+LYWGeitMLxasNiY3DrpY9TXLizak052a7jPMTSofIs07sR2Be/8Pv4ukWxk9a6EeVm6CvtCGJfs1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768727141; c=relaxed/simple;
	bh=Lw5fiHfPUCf9PhcEF6SVppgBPoybpo5FaSSJdq8bHQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIGMofKRRqqXAheYbuDOvm7cZ+Snakvf472l/cG/MjH3ajQ1dX7N9YRWu0mD1h+BnnSQq5MF6bmaDRnoGD6UNAsPbWE+EyfM5XG5gYSECFbVC76o1ZDLz9wwARNnQKi9wRci+KD4/HU3N9hEG9FuR05MsKUKnGKtrpyYGC42Y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dv73G2qqmzRnlL;
	Sun, 18 Jan 2026 10:05:30 +0100 (CET)
Message-ID: <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
Date: Sun, 18 Jan 2026 10:05:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
To: Derrick Stolee <stolee@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 18.01.26 um 03:34 schrieb Derrick Stolee via GitGitGadget:
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 453ec59057..f0d2ab32a9 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -444,6 +444,10 @@ The following options affect the way the simplification is performed:
>  	times; if so, a commit is included if it is any of the commits
>  	given or if it is an ancestor or descendant of one of them.
>  
> +`--maximal`::
> +	Restrict the output commits to be those that are not reachable
> +	from any other commits in the revision range.

I had to read this sentence three times to understand what it wants to
say, and that even though I had a rough idea what it was supposed to
mean. I tried to come up with a better wording, but found it to be
really hard.

	Restrict output to the commits at the tips of the
	revision range.

is all I could do, but this isn't a lot better, I am afraid.

The option name is too generic IMHO. How about "--starting-point",
"--topmost-only"?  It's function is somewhat parallel to --boundary, but
at the positive end of the revision range. Perhaps we can use that as
inspiration.

The option is listed among options that affect the way the
simplification is performed. But is this true? Isn't it just an option
that changes what output is produced?

-- Hannes

