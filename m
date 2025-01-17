Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28F19992C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114175; cv=none; b=f52KeaN2DP63rtyUsjVdv37BYpo223Gwu2UopVeEnshj+Kf8qrrRiPmPLvnmuk66TmZEnu6AX6kCCE75+rcCEWQhkdO1kwILiuKFkS5II0DfOJPeIuRpaASk6XGGmqyfEA8vVqXGgG6cEQfwqJYfg7v8ZRr3IC+KN571ljyWRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114175; c=relaxed/simple;
	bh=xsJVZbZg+vN0gJNP129xnVBJoWdfmWnx2Aj0sUSBjeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgKrh7iTyFSkjtVKRMi5nbmgEMVHDyGAZUMTTSoaSEhiQ7TyEiql0+AO7Du1FO4HBi1/8PwIL7Ezd3MRe4yg1pxX+GDuYVHBsRlZQ6w/nA9t4lktjoSWdkf3T1w0bf/s9Xnd7MGxJ/2HojRpdXXHn5iyp3Fd6rpFIde1CV2F4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L481wcEc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L481wcEc"
Received: (qmail 21617 invoked by uid 109); 17 Jan 2025 11:42:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xsJVZbZg+vN0gJNP129xnVBJoWdfmWnx2Aj0sUSBjeY=; b=L481wcEczxmp1fAeSbGKjSf+uXKMxATGc01KBjx2Urkps2dLaj6SgAeWjgKXoVEfKmDAZ3c2AxYRyljhQCedGx1r3uVzJVyqDuJfUnf7FBFUDcMoaXZ/u5Wu0Ziz1FTJGPznWVwgxYaR9otUjkJt4V1LUvdVQWRMsjNQcsyxFl9bMLGliVFVVG+KsFuJ0E6Kt1BbeTCL9aRRBPmPq1Qqxg0XwfO97CPLaNIwLbH7asy7Aw4LrFY36NteWd+8tRtzr+zrR6MzYo+Bqm6AzjZGZUCc2HI2z5da9j2o3CVWejJ8m6zER+58rCk9u4yuPoViYg0hdT91qr+khANhAGyx9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 11:42:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7421 invoked by uid 111); 17 Jan 2025 11:42:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 06:42:56 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 06:42:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] builtin: send usage() help text to standard output
Message-ID: <20250117114250.GB2356746@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
 <20250116213553.2563751-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116213553.2563751-7-gitster@pobox.com>

On Thu, Jan 16, 2025 at 01:35:53PM -0800, Junio C Hamano wrote:

> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -257,14 +257,8 @@ do
>  			export GIT_CEILING_DIRECTORIES &&
>  			test_expect_code 129 git -C sub $builtin -h >output 2>err
>  		) &&
> -		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
> -		then
> -			test_must_be_empty err &&
> -			test_grep usage output
> -		else
> -			test_grep usage output ||
> -			test_grep usage err
> -		fi
> +		test_must_be_empty err &&
> +		test_grep usage output
>  	'

Just a side note for the future: you wondered if we might ever get
bitten by insisting on an empty stderr here (since it might catch
warnings, etc).

If we do, I think it would be OK to just drop the test_must_be_empty
line. Now that we are capturing only stdout in "output", checking that
the usage message is there is probably sufficient.

In the meantime, I think I prefer keeping the slightly more strict form
above.

-Peff
