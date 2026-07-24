Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDD3C3BF1
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929098; cv=none; b=taIyzPdo5HjdeaDs5Q0YERoBna4hA2tlFXdbWEroUARPC5AqTIvKCQ3xUhz7uQR9X3g5bhE/S2qXJ96I5+BQH9BtCaBZ3gagjLP40rVT+ylzkNg/R3tQShs7TLPizQNn/lxlpVfGTIgQsQ5eR0veaw2mpuvel7yRIZnnmRj/VKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929098; c=relaxed/simple;
	bh=0ysojLbDyJJx5mu8cRM2MfOrkOqtLlxRWyPiC9Sd5UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpWKStGEe0qmOlLsOhwBNN6CITH1v+Uv5POlhMQVc25CosKByBKVOdg5QDKoAyX0aRVE2DjFiNjdFcWa54m9LcMsu1IhkYeXwY2tZcec3RHiBKBF/nDGV8um4t8abDZmnWzHwipV8bo7a1HRUCtIx3fKQXlToLx2fBSIW8N3qaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FWn8J1MI; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FWn8J1MI"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6626b5ace23so1880743d50.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784929095; x=1785533895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wUH1f19bZb1A2nr4PnRwohrfpfrpzoKGwSpbAr9cN4g=;
        b=FWn8J1MIQIb5K5SisuQFJo3x1IGtNVk3KY8tEedzaYMRa4o6oe3Nc4vNlpnZdZBdeC
         mtYTVRAHRGhM9vfA5yMuJ3eIY2UiUqugGCNX1jXGz1nd7xE7XNRP5ecIjVwP6Flwrjz+
         2T2BnwBd4x5yPjkCXnVqBUGmq/CRzW1v06A/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929095; x=1785533895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUH1f19bZb1A2nr4PnRwohrfpfrpzoKGwSpbAr9cN4g=;
        b=Ya8uLb4lC31+MarfO5LELeIOdE+hcvkKAKDraIMe08qomAvfGMSTDu2h5jvHs1Gh8Z
         CALEzxeWXGkN0LoaIRLWBAVlH+MO9QX3NY7BvfMx0g8ElZAnqr65zgzkTEzN8ckQNbDv
         0WtJhOJdisDZcvP9T5byQYkEJyY6czeZEu0fE1V8CYGM9pQyUhlAUL78klIbj/8d0Rf/
         cQeScMOHe2jA8EMdgDL90YXWK6xlZKIpKm/8dC7aCxBPQQ1PoSEti7zDZnFLwzNay5rA
         5uTKk5oPCB09SUYRBB2vDrcw3OnmY36x9wsf4iF5kp+x+M5ye2TZM7047h90gk70qjA0
         ZiAg==
X-Gm-Message-State: AOJu0YxSLDpBCvp1e+1z/CxNCk+3WbGykx9zm/bCB1o6BfaXO2X4ZZuI
	0VCxHJp50jd8EVSr7/HU8A12brfOGs2YsJwpJinaA2UBVBerXyas5a/W25Ga1NYftjBb0KN9jXh
	iOb4eVV4=
X-Gm-Gg: AR+sD118mPLlt25opUnrDfigHquILts3V3qtxuZsTFZ5pDBrI+KszpbNxYYluHiZRbY
	b6g//A//Cpjm+4jNhJ/G8MOs9ScVSUT22St5pBLn6z/ekQw7YQgN714sDyp7dLnve+mbsMUC2nW
	cTM/0JJgu1htfTW7wC7mHBn3immZwUETEgofxSE+ugbZxI81S89LOJquDJwd6GJhl7VM/lUZxfL
	0rv5xFOFuEMRSjeSQk3ymNPn4ix341bVIiEVF7pMC8zohhQ2MHjkdKYLyW3vQBaQzuUFQIIm4AY
	fqv7gHcZu+HwUKWSt1mw4m2uehv7FHa/KKNUeMKoQmj0fWGCAZx/Cd/f0Bc5NcZuZ1fCelq2PY+
	sF5doy8n/jxlYZVcbR8nSG62tAuwoJnnfLKlyxIJ+f4FHpHNpJZzQ+PYBGIgxA3HfIwLK4QTgF/
	czvfykkEhWq+9kH0FZeR6qOXQKNLZxOKMbYMX89EBtS6Gco9ZH6BXlbd4EKezC8wmf3UBCWmCUb
	W76691bvnOLyQVkj9eGgMdIs5wx628NRrcA611otp0t
X-Received: by 2002:a05:690e:b82:b0:664:ae87:c771 with SMTP id 956f58d0204a3-668c041ba50mr576969d50.37.1784929095525;
        Fri, 24 Jul 2026 14:38:15 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6d61cc4sm59545d50.5.2026.07.24.14.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:38:15 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:38:12 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
	ps@pks.im, karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v4 1/3] http-fetch: correct --index-pack-arg documentation
Message-ID: <amPbRCAOLr-pSWfj@com-79390>
References: <cover.1784676106.git.tnyman@openai.com>
 <cover.1784874850.git.tnyman@openai.com>
 <a6a40b80461377452a0b2c9204c3a659ab60a7d5.1784874850.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6a40b80461377452a0b2c9204c3a659ab60a7d5.1784874850.git.tnyman@openai.com>

On Fri, Jul 24, 2026 at 01:14:23AM -0700, Ted Nyman wrote:
> The --packfile mode accepts one --index-pack-arg=<arg> option per
> argument passed to index-pack, but its documentation and option
> dependency errors still refer to the plural --index-pack-args form.

Good find, it looks like this dates all the way back to 27e35ba6c6
(http-fetch: allow custom index-pack args, 2021-02-22). Thanks for
taking the time to correct it.

> diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
> index 2200f073c4..09b5d675ee 100644
> --- a/Documentation/git-http-fetch.adoc
> +++ b/Documentation/git-http-fetch.adoc
> @@ -50,11 +50,11 @@ commit-id::
>  	URL and uses index-pack to generate corresponding .idx and .keep files.
>  	The hash is used to determine the name of the temporary file and is
>  	arbitrary. The output of index-pack is printed to stdout. Requires
> -	--index-pack-args.
> +	one or more --index-pack-arg options.
>
> ---index-pack-args=<args>::
> -	For internal use only. The command to run on the contents of the
> -	downloaded pack. Arguments are URL-encoded separated by spaces.
> +--index-pack-arg=<arg>::
> +	For internal use only. An argument to the command run on the contents
> +	of the downloaded pack. This option can be specified multiple times.

Interesting. The plural "--index-pack-args" form says that it specifies
the command to run on the downloaded pack, as well as arguments which
are separated by spaces. Two thoughts:

 - I think the "arguments are URL-encoded separated by spaces" claim was
   not true even in 27e35ba6c6, so dropping that seems like a strict
   improvement to me.

 - The new form says "An argument to the command run on [...]", but I
   believe that this option is also used to specify the name of the
   command to run itself. I wonder if it may be worth saying something
   like "The first instance specifies the command to run. Subsequent
   occurrences specify its arguments."

> diff --git a/http-fetch.c b/http-fetch.c
> index f9b6ecb061..601a77c3c1 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c

Changes in this file look reasonable. Likewise, it makes sense that we
do not have any changes in the test suite, since this option did not
exist in a plural in the first place ;-).

Thanks,
Taylor
