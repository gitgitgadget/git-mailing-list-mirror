Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75761CD3D
	for <git@vger.kernel.org>; Mon, 13 May 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579756; cv=none; b=KGaH4iDe7cxt2k9J+pKlxuubKMkvpuw9HBQ30ac3eHTY6L8ZEel7w53zvHCv73dWxJO7bpvzQ1acmuWd/Z/Bq0p20gNaekWJ8Gd2r/KUHWLnrtQRTbrORkDDSt9e31mxkn/34cnCKL5mpndpUkdPN5b6e2BlbYrKRmoKnFnE+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579756; c=relaxed/simple;
	bh=5IUbkpq34K7Ov/Mf1eSi0qe0V9K3P+hlua+r+1iX5Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=KN0S8ODSu8xHD+NYhXuwtAxJQvabrddFhF2tfptix2y151klSQdz0aJB9hUej4dUwuNrbxRz38NwKSMippYSNxTRhCmojNghWwYSFn6IL8UxNR8EUwuFGGYHYQiCtvJa+Gcjan0n7A+vlvHXrFgaFuBLY4xYhdo3inolj7kmOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Vd7yC2BnRz5tvg
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:55:47 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Vd7y30gjKzRnmK;
	Mon, 13 May 2024 07:55:38 +0200 (CEST)
Message-ID: <8bfa50e3-996a-407b-9c02-a9fcacfebc4f@kdbg.org>
Date: Mon, 13 May 2024 07:55:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in git log -S
To: Sam Clymer <clymersam@gmail.com>
References: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 13.05.24 um 03:40 schrieb Sam Clymer:
> There is a bug in git log -S where it doesn’t find every instance of
> the search string.
-S does not search for *every* instance of the search string, but only
for those that change the number of occurrences of the search string in
the repository.

For example, if you have a commit that only moves a line of code around
that contains the search string, i.e., it removes the search string in
one place and adds it in another places, this commit will not be listed,
because it does not change the number of times that the search string
occurs in the repository.

There is also -G. Maybe it is what you are looking for?

-- Hannes

