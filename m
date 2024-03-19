Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D042062
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826657; cv=none; b=T2lUJk3HUnRwLCvr7nI6wcsJmF7sZQr29N08loqdxwoQQ0RkVzpfKplE2k2vVGRcy1tGIcNl76alzT27gd+0N+TR3WdpxvqXwYDsBvKkdFLXi5FGez/zqvwsYy6SuXVfvy4rHeUdpjg6oy3RVVDh3OSgjJNr7L3bWVH3BrWQkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826657; c=relaxed/simple;
	bh=Q8OEmBWxi1u5HjSBGxLm3ss4T6s8eo0D/SUoYRnbKtI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IInBnQHOpipVcSm6u354G/Ri1qYygSyYr8C1W4rKmPk1Gngnr9xwsOc684EA/luPbKjHI2sqetOsT9I6tfM+nZR0opKULwj77KWUXXf2pH9xgcz70MHTCOq0XXlvOBiJJWznqPrQQv65NMMY/Ey8ibRmox5PGFX5y5Q4N4twr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Kd4t9LaK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Kd4t9LaK"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710826653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDuzv7LXtLBwBu+HAsIzW9h+ApBwWjbziBIosAxqlwM=;
	b=Kd4t9LaKFYGZHFxDs/qYRbNI1igVXX7O5e8Mw4+E/0pCpI7AY5hNC4dXyUbZITvV0bA676
	u/BNIoMoxYhaJDTnuxW9mU7KnEspNMxqvgHQht2JQsjstYNejv2JyaFdIcclGL5W79BGkx
	BxX1twVEOcPeL81Rg0XBnS38M3vyBdx8/5vr6p+IR4ASSaOclA/BSOYKCIwqGvqynKfYO9
	aEZtPailol7Ppq4CeY9g3xMfSjXfOxt4DtdZ1dYUM7bmg+fzwpbV09pMByp8EwMljrZ5SU
	POZp7EOG8wykkS2WPcwx7O6Cv+Z2qP4/WFd+rrjhxxRHzNXUYXszonFM0hU6fA==
Date: Tue, 19 Mar 2024 06:37:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] grep docs: describe --no-index further
In-Reply-To: <xmqqwmpzrqfv.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <3e6136028ca3327b027d57c46fb8155ef3c0d6c5.1710781235.git.dsimic@manjaro.org>
 <xmqqwmpzrqfv.fsf@gitster.g>
Message-ID: <c04a2f15bb719126da1b3dec3d9bbefb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-19 01:55, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> ---no-index::
>> -	Search files in the current directory that is not managed by Git.
>> -
>>  --untracked::
>>  	In addition to searching in the tracked files in the working
>>  	tree, search also in untracked files.
>> 
>> +--no-index::
>> +	Search files in the current directory that is not managed by Git.
>> +	This option cannot be used together with `--cached` or 
>> `--untracked`.
>> +	See also `grep.fallbackToNoIndex` in CONFIGURATION below.
> 
> Hmph, this is not the fault of this patch, but the description is
> iffy.  You can run "git grep --no-index" inside a directory that is
> managed by Git, and it behaves as if you gave --untracked, if I am
> not mistaken.
> 
> What "--no-index" does is to pretend that there is no system called
> Git and work as if it were a strange implementation of "grep -r".
> The reader should be taught to understand the mode as such, because
> that understanding will apply whether the current directory happens
> to be part of a working tree managed by git, or not under control by
> git repository anywhere.
> 
> There is no tracked or untracked or managed or anything like that,
> as we are pretending that there is no git, so it falls naturally
> that --cached or --untracked would not work.
> 
> And from that point of view, swapping the order of "--no-index" and
> "--untracked" in this patch does make sense.  All other options that
> specify which haystack to find the needle in are all about git;
> "--no-index" truly is an oddball that pretends that we live in a
> world without git, and as an oddball, we should move the description
> out from where it does not belong.  It might also make sense to
> rethink where `--recurse-submodules` sits in the list of options
> while at it, as it also is an option that affects which haystack the
> search for the needle is carried out.

Thank you very much for your detailed review, as always.  I'll try to
incorporate all your remarks into the next version of this patch.
