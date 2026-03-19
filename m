Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A33E8693
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938850; cv=none; b=QxpneC3mSv4/aTt+wZLXv/M7AEnPHovlqBjcSNrOFmJUM2vpSU0sl4DYk956D5nErvCAfXqvC7MGxYdO+Rvn+5K9URrXTEOKOcqpvYqdBD57mZzbCltwt/W8RhV+2H8Ldgtk1rYQTBdOlENszZpvqIsOXGOQYNlCfOsMB1uAWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938850; c=relaxed/simple;
	bh=Hptj7CnpCSTTKZs8ARFBPcRcOOP37ahmzHGs6EXzFcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ8ZdVZoawa7uLQZ/wLaPsZMxGRzMuqFldfsgDr4p/zALEFx2h8jX2IBmgUNNbJ+xz6aTTYxBWFTfgLLwGlf0DH1qHnVQ/3rGGQLkZdWg7Q+6WO0Qy5sQdrHLhdA1zCuK/OinTrbrRqQYRnSHy7D0LuQq48MJZnuGqGPQLkS1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pQronl1o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQronl1o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SaIdvHZ6fBt2ooAB4nxlXsKZK6bxbHLEE2YuQyznKZQ=; b=pQronl1o5DEoy5VU9iKO2oeksL
	Ej/QUbIHzogYdjq9LSAz1pT7GSSLCu3vAQxkIRVL8y1yPZuqPQuE3mmTgAfvExq2tltwcnT5kGB8y
	72ZGz1swKH7g1pVrHrP3TKOQBLflF//W5eGx7a+/4o/+zu+K6B5pzWJ9zrCcbyHlLloLDIIKYj4Ch
	E7G4gPZiJUjljeg3hJRrsQ1EOXdSX+pls605KnnMh7cX+DMyStqS33dc25/oAU8R50inTH3GPxPpn
	vd4JoVE+5uFaI3tWNJ4Wo7dRX5ZFJnRHxaNZRQd7KjlFJcFp8HbSTLrwle3Ha6DdZKUtNqclyHGiS
	epQE3/5Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GWr-0000000B6qc-0YUt;
	Thu, 19 Mar 2026 16:47:25 +0000
Message-ID: <7e8159fb-f7ff-41f0-8955-5ed2dd5dc7fe@infradead.org>
Date: Thu, 19 Mar 2026 09:47:24 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git grep failure?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
 <20260319003829.GA3530301@coredump.intra.peff.net>
 <2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>
 <20260319155326.GA3611913@coredump.intra.peff.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260319155326.GA3611913@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/26 8:53 AM, Jeff King wrote:
> On Wed, Mar 18, 2026 at 09:42:23PM -0700, Randy Dunlap wrote:
> 
>>> I applied the patch and git-grep does produce one line of output (the
>>> instance added by the patch).
>>>
>>> Two possible differences:
>>>
>>>   - are you sure the patch application succeeded?
>>
>> 'git apply filename.patch' succeeded AFAICT. git status shows one
>> untracked file (the one that is added by the patch).
>> Do I need to do 'git commit' also?
> 
> Ah, I see. I used "git am" to apply the patch, which made a commit using
> the email as the commit message.
> 
> As Junio noted, "git apply" by itself will not mark the file as tracked.
> You would need to "git add" it, at which point git-grep would start
> looking at it (since it only looks at tracked files). And then "git
> commit" if you actually want a commit.
> 
> But at that point, you probably want to be using "git am", unless you
> don't want to use the sender's commit message for some reason. (Though
> even if that is the case, I'd probably use "git am" and then "git commit
> --amend" to tweak it).

OK, thanks to you and Junio for explaining.
Just a User Error.

(/me notes that git am and git apply are different in this regard.)

-- 
~Randy

