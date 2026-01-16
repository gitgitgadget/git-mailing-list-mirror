Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B812745C
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582202; cv=none; b=u+JOhNiwxYBrqaza+ij/PP0RKQJXiZ01FIhTwD6QnfuOjLfeUt88hevvUg+RvTG7cauQAnD7/1SNS/K0qFJUM2pdqfDQjbUpi0HUuA9iMWzvJ1X54i+ZMW8/XIKzuXPQBtyapSJyqPomorOO8wqhPQh8MGVj1wciOjz6K7rmy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582202; c=relaxed/simple;
	bh=Dle+8kNr8HHjrHYP72gON8mFZ+Jb8COSRikrekcOdrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bf8/IACo6PK59AvjO0sqjwB2VxDa0JgGFEqCB+5tFUVTx/FEenn7ZsmFv5B55RvGr2Ix3C7Tb2uqdarkYCsxZ2RRb/Rl1BPgBb9VfpvoMDo1mi5p3X3s15HIoFsjSFpUMoqlZ28/zAGj0P/AcQ8g+Dql+I+d3b6F2iJgwH3NBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LfY6H04Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBlaA1vZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LfY6H04Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBlaA1vZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3EA57A012A;
	Fri, 16 Jan 2026 11:49:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 16 Jan 2026 11:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768582199; x=1768668599; bh=EN3b2OCGWB
	mxRoh3bJCcYhhhMflojs7yzloeNY6kR9Q=; b=LfY6H04QPfCWG9mnMnxwAD5GZx
	jRmiYE5gXjSijjoFxnuwcuIl1flnO44+bpXQt+cqDLSU/uAmR9xLjsTeXJDDQioR
	ioXrmUAqU+EplSglh2p2ti1MUZzisxs2BM8MqucxFkb7VsKn6kAvlgxwgdNDkO1F
	BY/1rGmtpM8Eoz4N5bi9QNkb/pbJy7A7ZzaPfW5YNRe7XEbWgkGbR3wNoTMtrv5A
	oWnHb1V0YP8OwgFKd71V6/14QMxXucxouLkcwapHljsNjvvvUDolsSSVqw+eNuNb
	LPg11+DGpdX/k1N2BDcjXnQyWKdzsx7FdtOOJoD+B/FrvGf/WqnK43Rnlq3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768582199; x=1768668599; bh=EN3b2OCGWBmxRoh3bJCcYhhhMflojs7yzlo
	eNY6kR9Q=; b=aBlaA1vZCKSpd8PTeEKrFVOPohU5kieLV5Mavf/pHsqMlrj6bUx
	jcEHG3wE3CAC8ULp9RYK7JhrDYfKabdyC3SPHV4u7PCcqGYpWYMBTWTNeQuKWfIP
	1goY/3/cf7ULtPDDhSabBQtMBE//cC6zPiJS7hyHzn9SxCc7MLi/1aKaiYLoMGZv
	3u/5WO4EBCzTq/Cl7i0a9K7QK9HRDuGkZ2yic5DBV2cz8hyK5QqmMHSW6sTcGvwl
	NkSxC7gqTuaD3ZDPySrp9yi0IRn6nvepuDhVqpO+EzducbIJ70AfLKeW6ItK4H8c
	QNRgAlRSwNDWsiiW098jDvZnkJosHV07kIA==
X-ME-Sender: <xms:N2xqaWokuytKCbCw9mD01HRxAzy3L5wfUBRaUL5LZpQBCdgnNSNGFA>
    <xme:N2xqacG07_B_VLqRe3Df1gT9pfcq871lSDZEEHGGrGzwgWvO48rYN1tCycKVMoMRl
    E4jqeMk0mi26zOKt5yiuYwdQ9vp1Lszl01d9-mplSYgUSlYjVlUeA>
X-ME-Received: <xmr:N2xqaYlk3yYuANoTQuy02worttIWp5HGucCx9PFXh4QuJB54lTD8eGjjMpsNBu41iE7seAKGmS6l4brBcRWF9o2an0V5Rsy1biiZMqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:N2xqaflnh6a_HshKVp8VxUQBtYkP7dVn8enJfUdcu05Yqw9EGZ0MhQ>
    <xmx:N2xqaZt2_sCgrevHu_MBZZOyCZnMrSLUjnoesWhb68tCltJyOLQhEw>
    <xmx:N2xqaSlDXZbekn-jb6xraAssQdA10gglqTqZI6flagL2tFpEib8ccg>
    <xmx:N2xqaUt4q7Vgd7OwWQizgsURtiJXgS4yM1lQ99s32RMHxXrFMwqLHQ>
    <xmx:N2xqaUOX0WdCZUckt-LEGFiifIJDW1OcbzBWZ6LDOcJ00c1fnggUZr1Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 11:49:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/14] odb: introduce `odb_for_each_object()`
In-Reply-To: <aWnisVFbgXIG492W@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Jan 2026 08:03:13 +0100")
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
	<xmqqy0lzc7e4.fsf@gitster.g> <aWnisVFbgXIG492W@pks.im>
Date: Fri, 16 Jan 2026 08:49:58 -0800
Message-ID: <xmqqecnpa4eh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 15, 2026 at 05:50:11AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > The patch series is built on top of 8745eae506 (The 17th batch,
>> > 2026-01-11) with the following two series merged into it:
>> >
>> >   - ps/read-object-info-improvements at b7f649ca93 (Merge
>> >     remote-tracking branch 'junio/ps/read-object-info-improvements' into
>> >     HEAD, 2026-01-15).
>> >
>> >   - ps/packfile-store-in-odb-source at 1ff0e42d33 (Merge remote-tracking
>> >     branch 'junio/ps/packfile-store-in-odb-source' into HEAD,
>> >     2026-01-15).
>> 
>> These two commit objects you cite have never been at the tip of
>> these branches in my tree; I'll go by the branch name for now ;-)
>
> Ugh, yeah. I referenced the merge commits in my tree, which is of course
> dumb. Will fix the cover letter to point to what you have now.

I am seeing good things in the series, without much nits to pick.
Maybe there is no need for another round, in which case there is no
need for fixed cover letter, either ;-).
