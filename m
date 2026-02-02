Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B875809
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998427; cv=none; b=P9LVcyI4cOKxZ53pF8PZaY7rQIb5lyqvIFulbGbu69fhoAo4n3E3yrrxSMJ0PuQHqGIR5dzGOf5ccPZKxBHrbA6gaPF8l1stNYftgvlZzhRjADgauHZBIz3Gezyj72qVlzh6kEZnx/3PNNA96CNNtVQfvCtRHWMQdKGu+hFQqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998427; c=relaxed/simple;
	bh=fpBzdgQwOPOxF8sa3LYzRNpzVeLX2a/ROxvEa6zV6ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXoivgjVvmnnyHhHpI2GAlRvriI0E05uf3FxtrKcIw0LynYHEaFT22l8UWivDiM5Bh2vOYZWV0wGrpDLAvNaxa8pY8g+ABYqMzQ17mu2O8+9HSd1/ugvgjFiIWpCN2PuHypQZIz1HUmHX5+em+wVeft8QL0JeF2DMa6XRLwkxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ADNwBqfy; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ADNwBqfy"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794d4f11a20so3958117b3.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 18:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769998425; x=1770603225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTP2ab4PF33jwa0THmiH7BpBhkXN8J49PZlSFTOdHjE=;
        b=ADNwBqfyANchGBo1s9a9VXGsddKBsiU8LDLInPRVhgEWSdVwOOqS/h/rVY9hItM9tj
         OUNsoEceGDDx0e2PiDWDsROhRPzE6bZNx0eK9hWbI/bNfIYwE/jMZvRRG98rovRz06uu
         au+byzb/gtBefd6i2XAoQaruko7IDHZJRBSTamYSa93rtV3ZNjZMUwEdnAL1UVSgejyz
         VC//ueWyBvPmLJEOCpg6+c6g9OSkmz0+YUYIy5aZt8bSX+wMfiK/3w3mHIgINsuSnMFH
         POO/TiMi+LdUVu+gCvUYkwP/wk4gEet5bqGgg/9DmHw/TlbkLMnPXUlxXkXGVAx1cNTG
         y1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769998425; x=1770603225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTP2ab4PF33jwa0THmiH7BpBhkXN8J49PZlSFTOdHjE=;
        b=fklMrXy8OvCePhN3ned0CUSHaWZUx1uIdYpNCccM2dS3o4Y6YNAF9A8DDYpPnPuNMd
         3CvuW/DltTmeaA0ImZKA/9tlw8u6RC/EWhJTLp4OaFLaVkFifdw/a329X7vPL44BC9Ni
         M56nDLbn1Kzt49L3Ea/2+uDWXICo7wtZLAYuyorCj7T3UULRbTl7viZ7EubdZs0Xzvjz
         1b5hJ5l0hfF05TzSiwMQ0N0Zv7Xs3BH1Pf5QIJE0jKU31Bkc47fLXgyJd8FfYYVxwi13
         wsrVPlUWRNJAmvORyxE2jM5RiuU2d+fn0E34l9bAP96fb8Sf5UqhRMYzq/amTKwVTk6p
         r+DA==
X-Gm-Message-State: AOJu0Yx7iCSQyQiQj0in3MJ4SXsYyk1mVpqdGBkMk3w53xQ1lp4uvbbS
	awIB1CUIg8eOgr4TiEpRUOPJEFwWK63l3kMGHHkd5MfBb2E2SCH/wty5NNIXcmO+v/k6bshmEZ7
	/fEkKmO/kzg==
X-Gm-Gg: AZuq6aK/tvMxF8hyK6h+h3HWq2TNOpogeSHMI+jeDjf3dyGdPeoQj4N2APQwZxE7IMO
	oDy5NStlMC9h27Gym1vxh8MVAIV0Kxg0k+dWhq1Yor4qfJKeg7to3nDuYsdGptex53cOS6NMp3B
	c4ojA27zjp021bRMFfzdfQlCN3eMaXPN+I8c5g+dAsVqCpwaLo6JOyoRSqLo+vZn+bScqmcmSi/
	6RHvNTy8tB6uX5whbAYIRreicN9z1RtlneuQRwVLSyTmIujvaYX9XJXU5I3MHcrxczxsuMfFYrA
	1UQW6BajPEVjOvgHu+2BW6VFczDBa3hf9/cHy3b0cIYkCKXO+ioXCB/4kQ5oyHe7qxco1Ixwmii
	g8XbCPSu2PAxa5y2NeY1m84Bome3fNw8gWBBERLd5OsEe9cpjucotbPd3hDBOhfgh/Ve5orXLny
	ttt7g7TPGB8RqukdzcZx9wbBXM2xIHLG5+y7BIIs16+ATEXSKKVLj7Mzzb3LZYqW0pN/asEXMfG
	oS8urbmcTWZrln7rQ==
X-Received: by 2002:a05:690c:c4f5:b0:794:c6fa:156e with SMTP id 00721157ae682-794c6fa23d7mr27728867b3.56.1769998425116;
        Sun, 01 Feb 2026 18:13:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828f9cb2sm74592527b3.56.2026.02.01.18.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 18:13:44 -0800 (PST)
Date: Sun, 1 Feb 2026 21:13:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Message-ID: <aYAIVw5UMQeP3Ilr@nand.local>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
 <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-2-0449b198a681@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-2-0449b198a681@pks.im>

On Fri, Jan 30, 2026 at 02:27:43PM +0100, Patrick Steinhardt wrote:
> [...] There are two possible ways to fix this issue:
>
>   - We can fix the bug by using `refs_for_each_fullref_in()` instead,
>     which does not strip the prefix at all. Consequently, we would now
>     start to accept all references that start with the configured
>     prefix, including exact matches. So if we had "refs/heads/main", we
>     would both match "refs/heads/main" and "refs/heads/main-branch".
>
>   - Or we can fix the bug by appending a slash to the prefix if it
>     doesn't already have one. This would mean that we only match
>     ref hierarchies that start with this prefix.
>
> The first fix leaves the user with strictly _more_ configuration
> options: they can have prefix matches by not appending a slash to the
> configuration, and they can have ref hierarchy matches by appending one.

I would definitely like to err on the side of more flexible
configuration options, but I am still concerned that this change would
lead to somewhat surprising behavior.

A couple of thoughts:

 - Like I mentioned in the earlier round, 10e8a9352bc (refs.c: stop
   matching non-directory prefixes in exclude patterns, 2025-03-06)
   takes the opposite approach as what is being proposed here. I worry
   that users will find the difference in behavior between
   pack.preferBitmapTips and for-each-ref's --exclude patterns to be
   confusing.

 - If a user wants to list all references that start with
   "refs/heads/ma" in the string prefix sense (that is, matching
   "refs/heads/ma", "refs/heads/main", "refs/heads/master" and so on),
   then they would do

     $ git for-each-ref 'refs/heads/ma*'

   , not 'refs/heads/ma'. In fact, enumerating 'refs/heads/ma' when
   there exist references "refs/heads/ma/foo", "refs/heads/ma/bar",
   etc., for-each-ref will output those three references (but only
   "refs/heads/ma" itself if it exists).

I suppose there is an argument to be made that we are dealing with
"patterns" vs. "prefixes" here, but TBH I am not sure that is a
distinction that is well-understood by users (nor should we expect it to
be).

The original intent of this configuration was that "suffix" in this
context meant directory suffix or exact match, not string suffix. The
implementation does not match that intent, but I think there is enough
ambiguity here that I wouldn't consider the change I'm suggesting to be
a breaking one.

Overall, I think interpreting the pack.preferBitmapTips configuration as
a reference pattern gives the user both (a) more flexibility in which
references to match, and (b) does so in a way that is consistent with
10e8a9352bc and the existing behavior of for-each-ref.

Thanks,
Taylor
