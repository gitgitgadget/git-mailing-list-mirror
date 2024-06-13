Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68231748E
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249390; cv=none; b=GmqA4oRw2gSo71Rj0pJTleNZf5NhCIi6PmD05aQuDpPCCL/qs1/HrG6zOjpcGZsPi6YE/a+mMiMi4GlVw9N1dseCK1sR7kGkAX0NlVGrdtcYjzDt1/YlM+6eepCCbkjo+5uzD3AzdmVHkmLonchVQUoE9N5R2PbAAJME2MHgaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249390; c=relaxed/simple;
	bh=mfi15EoD/llQIEMpLDPqlcznl5vbBBo8wMx3ehQoG0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdpuwFphXFD0RYXKB64H3ac1LR3atWu2RZms50nO2CV8f2pMNvPO6G/PJ1n0Yzu5ILchkD3Sgkwn0rXdEAdU8BDKITTZTrFIdL2tRHK1HFM7c1yyi01r9M8J5+hv1P4ZGWd6lvwWl+TEAEMvGtuYzOUXTFnAjTK9aKtp5x5jTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=RrZe3xfE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qs3Lq6Xb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="RrZe3xfE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qs3Lq6Xb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 45C871140219;
	Wed, 12 Jun 2024 23:29:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 23:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718249387;
	 x=1718335787; bh=CUCMk9k31p3zPEnaXLg2cqKVlzqY8koSrmzBGzPXAFY=; b=
	RrZe3xfEsvjErx7hte5TKjRqy1L8w3Z/6pW4pcr9b6o5ZVFtW/qtSrhVsW7o0Lk3
	fvZGXcJ8naTej1yxHrlUiAzWotJXK8LGZi3h1HnbCrGI4d92Su5+na24ZIVsWWk/
	Mryumo3zbUrp+NnTD2r9bXzGouSLjYRzjbrDoXYv69D8z51J2CCAKs9BRAxWTrn9
	wiif0DtHpyVWiqH83D9JSS1K2S8OKLWnZ+td4czWetRm+0zs/C4oFs5mRuYx0BUg
	qwV5wB+XJzV0UNJ07dCXZ4K5r+GtxyHtO+Z5ShaThZCWPpNKgXiVvHiB5R+8xPN4
	7ewVq++7T0AjDPNxNzR7LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718249387; x=
	1718335787; bh=CUCMk9k31p3zPEnaXLg2cqKVlzqY8koSrmzBGzPXAFY=; b=Q
	s3Lq6Xb+0bA2wGfyIj8vZkvPkJBz1NkNL5aIP/LSb7cFsDI4i7f+ZLNTI/ap0IYF
	G8uOKhNYsvIeDoKB8OcnB9DrAMNyvS5YTocyVTWP+nZM8M5Gi/JZe10AhQdN6W9w
	Rt6wXvfwM5F/cf5y7iOIYcVEhIIzTTHEnLLDmPzVbV3zScEcVAGEPkZdWVYM5Yob
	AOA88wDaCjKPrNkZYIR5T2ch9J5Ofljq06P1Fd/omwO4BH6NxhmzBRWRdNJkCGH1
	qWD2i2pc5dDGIG6cjLSPrtpI2lN1ObhAR3EyfyLlVwjw3VcwQucnixgooFMlaxZ9
	bEpJYtDtLUhAGsxyiOMRQ==
X-ME-Sender: <xms:q2dqZscW7XNtpBl2LcnAO6orzfG4J-lCum3wFIojMsyKpZWoHs9FsA>
    <xme:q2dqZuOY0zdMYmr3TQdPou4wPNnHMm_8CzVQugp2D2PJGEyDhhDfmn5hZ28tlEbi8
    WSuoIg7DO0>
X-ME-Received: <xmr:q2dqZthiGKPOoc1W7BjJen9dkSu81f6h7yzQWcYNZyvDB9GOuKj5Z9X0VlWGZo3I-i2nzJzw-cxj3mJ28Z7kDSEtRBKD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttdefjeenucfhrhhomhephfhrvgguucfnohhnghcuoehfrhgvuggplhhonhhgsehf
    rghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpefffeduieefgeejveetkeeuve
    evleeggffftddttdefkeevieekhfdtiedvffdvleenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehfrhgvuggplhhonhhgsehfrghsthhmrghilh
    drfhhm
X-ME-Proxy: <xmx:q2dqZh-SMw7zKmz7j-Dy0N7X5NyvYJxSaSiy4pExdLobTKD8WpK31A>
    <xmx:q2dqZovVFDShw1yVSdqlzwtqjA5a8bU3lRthuSQ00yAMvtFRkC7aKA>
    <xmx:q2dqZoFqxMu_dizQ8sg3MzgMNWXxOjSyv0Ca6Do_5U-YUfmZ0WKhag>
    <xmx:q2dqZnPQ2rluQ9ihR_JD6F7scUpTGT8mi18t82TIUijbgXdQ5CprSg>
    <xmx:q2dqZqLaPL8Fsm71URd0TQI75_lMrAuvqbWPTcuCpaOINhqt1ErNXmQ1>
Feedback-ID: i08fc41ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 23:29:46 -0400 (EDT)
Message-ID: <fbe6ae6c-a89b-ae71-2474-10ac3afd0766@fastmail.fm>
Date: Wed, 12 Jun 2024 20:29:47 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: git fetch --prune fails with "fatal: bad object"
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org
References: <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
 <20240606011453.GA623737@coredump.intra.peff.net>
 <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>
 <20240608112033.GB2966571@coredump.intra.peff.net>
 <5247e0cc-ef0e-558a-7e06-5a7425a52329@fastmail.fm>
 <20240611073134.GE3248245@coredump.intra.peff.net>
Content-Language: en-US
From: Fred Long <fred_long@fastmail.fm>
In-Reply-To: <20240611073134.GE3248245@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/2024 12:31 AM, Jeff King wrote:
> On Sat, Jun 08, 2024 at 02:02:52PM -0700, Fred Long wrote:
>
>>>     git for-each-ref --format='%(refname)' refs/remotes/ |
>>>     git cat-file --batch-check='%(objectname)' |
>>>     perl -alne 'print "delete $F[0]" if $F[1] eq "missing"' |
>>>     tee /dev/stderr |
>>>     git update-ref --stdin
>>>
>> Thanks. Here's what I have been using:
>>
>> git fsck |& grep "invalid sha1 pointer" | (
>>      while read err ref rest
>>      do
>>          ref=${ref%:}
>>          echo got $ref, removing .git/$ref
>>          rm .git/$ref
>>      done
>> )
> Parsing fsck's errors should be OK, I think, but your "rm" won't be
> reliable. If the ref is packed, then it needs to be removed from
> .git/packed-refs, too. Calling "git update-ref -d $ref" should work,
> even for a broken ref.
>
> -Peff
Yes, and your solution is better than a newbie like me could have 
figured out, which is why I have been arguing for a simple documented 
command that people like me can run.

