Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8D1C6A8
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354586; cv=none; b=tHDscFKerQMqCijNMbYC1rucO5eE5MGlURLMQnWtoEjsGgi3QfEIyUgCukYSIv3jHmvfAAvTOJ6qQnLLzAyZSpUP3pNei3wb0Q8tzcvfT+anUfxCEONNtY1Cx8kfZU9iljYmPvPNKG3tVLDJzDOHRJr8V9VAQFIz/WvCv0aUFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354586; c=relaxed/simple;
	bh=p8quWmahFrD9HT9UCiJKS4K5xi4+NUOX6xbgviyoxVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2lGV8rzJRIBWT7GHe1BNZvDTCbA/SQSsJNv4iER7ofpKjpcFSoYgO48TS/XtQhzWg0OV5G4bazf0RQDNY24z/oZsDs3pL9eH0JRtr6tFJFChl43M2Fuzy1KFez16V1coFNAxTLFKMAgz0jZhGrB6GBZQqR/CmdKarCRbnBWmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VBCCj11Spz5v6N
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:02:57 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4VBCCW5CxvzRnmN;
	Sat,  6 Apr 2024 00:02:47 +0200 (CEST)
Message-ID: <c2154457-3f2f-496e-9b8b-c8ea7257027b@kdbg.org>
Date: Sat, 6 Apr 2024 00:02:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] userdiff: better method/property matching for C#
To: Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jeff King <peff@peff.net>, Linus Arver <linusa@google.com>,
 Steven Jeuris <steven.jeuris@gmail.com>,
 Steven Jeuris <steven.jeuris@3shape.com>
References: <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
 <pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.04.24 um 23:42 schrieb Steven Jeuris via GitGitGadget:
> From: Steven Jeuris <steven.jeuris@3shape.com>
> 
> - Support multi-line methods by not requiring closing parenthesis.
> - Support multiple generics (comma was missing before).
> - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
> - Remove `instanceof` keyword, which isn't C#.
> - Also detect non-method keywords not positioned at the start of a line.
> - Added tests; none existed before.
> 
> The overall strategy is to focus more on what isn't expected for
> method/property definitions, instead of what is, but is fully optional.
> 
> Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>

>     Change since v4:
>     
>      * Better matching of at least two "words".
>      * Better handling of generics by restricting commas within < ... >.
>      * Allow any spaces around commas in generics.
>      * Because of stricter use of comma, Johannes' identified failing cases
>        now pass.
>      * Updated tests to cover all of the above.

The proposed patterns look reasonable and are an improvement over the
existing patterns, so I think we can move this patch forward.

Thank you,
-- Hannes

