Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467B1D63E1
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399648; cv=none; b=jkROvZc3p4CqKaM6FSUBsQItUMBk8dDAF5gAZbEYwqvfqMsHhHpu4iPfOfHzyF3LSG3sDbA7IAVfu8zZI0LtmhEIF/Gql0A91YBXvMkroULqVqnqgPrhbI8etMdn2x+i4Y3t4/WihkyNEJt11/5oIVfLN3wfkOJ6aFj8Z+YyyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399648; c=relaxed/simple;
	bh=0HaYZRJQ2nqqZJsS7IflBZE4oMMBhmE/P84oH5KAMyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DSceGeNyrwWkMbJs9ik7lGu0yoWHnrcSxw2iAaH5ZX7RQsxA+erlcQrkEYJqbsK1VmRG6jaZuPs2JgO0hejD3zjy0tt9a+ysL9fydpqMwmeQaU004qDz0yVzfWCW6BYM6xgd2d3ced0galn6YmEN8CORZ7C6L84Vl5+uWLMvYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s8Ii17XV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MU7cSToc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8Ii17XV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MU7cSToc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D033F1140145;
	Tue, 27 May 2025 22:34:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 27 May 2025 22:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748399644; x=1748486044; bh=UdWGhkS+6v
	kY6JoIy88jl9W6NxbRxO272WsSAhLN6rM=; b=s8Ii17XVz4hdJtsYvBgNqAxCWX
	V1tIknAlZWB758bcoj5ubJk+NPHA4M0Gty7asolkhWu859zDefv7xSW0zcfasNN2
	mpew5ELEizI4oRSnEkJdoeTc2wqGyiCtc3FCRWoVhk5f4gPIcN30AuWob2Z1hhBv
	wszVLBw/121LANU9GMrRk8bKG25mlEzWaoYEL/96EuJBUs3cKIm3qGX0Rfd+d5c+
	q3s8K1I4/W7h9jt4XPpmf2Yn5w0um56Zo3lNSKE0M+iFV0fe7xkNswXXO0DpjcWl
	WhQVt2Ad+eiz3BcONnlDcXWNspSBrbySKLnRXKU58dbEXvO+P0vXiE00T42A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748399644; x=1748486044; bh=UdWGhkS+6vkY6JoIy88jl9W6NxbRxO272Ws
	SAhLN6rM=; b=MU7cSTocLpbfRAsJ6WWYauI6FdDB2jtA4bwIx0Ipzyy88Ce2npE
	E2m4622G1OUvM7O+V2VJ3FtfHzzCcrGgb+SHrjhwNkRJCNI8P8czz6bDsdMPg3At
	Z4rAR7zgWbp5ifRlfXk1H6LX68Zot60RfWfk9MXlgwsl1g4YWtP0xItM1m2hlSJn
	vr2TttOD9X77kHISOEO9HHfHbm2h0RpALLqi7w1ELBvXF/uNL2/2E2uo/taqmIiW
	sTSw3IksH9VvwF2maiNNXYIeH0wV4H0J8l0GYvj/q0jCIVIEG0hwfnZcVhju/pbY
	i5wPlkScGWKHcRPFGtfWhxb/Kxl8/VBMm9Q==
X-ME-Sender: <xms:HHY2aHQldvqIyNF3_dsj4wRxg3fc0qMLn7AX9HmZg9umrmemCDLSRA>
    <xme:HHY2aIxG2jDTpnYW0l-DZpuaN6K07X82mnsPP43Ap3z2PXCiTzM5FsEyU0VhP3WqN
    m-ZrRG3RdL_z2pRnQ>
X-ME-Received: <xmr:HHY2aM0pwlCIOITcKRPlcCcY6HvPLe9yQV7_jbQHvHg7pP8tFrBfcvdFEBi5kzhlTr722pGpHnOw6qtOmo20vAZ3Ax59j3WI9X6EGYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvddtjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfff
    ffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghoiihosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HHY2aHBmGWgClNyV0kOk4zscATKBfqY-hR0oUP1eAKnd9V8grHSoHg>
    <xmx:HHY2aAgCXfBHmjtS-HrFWZxSnbnMgH8jVbdCPIW21WJc8Pehw7KvYw>
    <xmx:HHY2aLqpszcMFzfHy3NEGMF322E61-n5Kjp48xHTksDfn1YSN5mmxA>
    <xmx:HHY2aLjxEVg05V8oYtJfQho2A-rv250l20YoKQDKEly1N9yr38-MHA>
    <xmx:HHY2aEfZvnUBx_GV8ooX8lQWaEYxgxb2WWhwOB4wYIYKwi_Ie311NKKs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 22:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question About Sorting the Index
In-Reply-To: <9befdb3e-ff6e-4416-8735-1eea99dbbf01@gmail.com> (Jon Forrest's
	message of "Tue, 27 May 2025 09:38:59 -0700")
References: <1008ijb$6j0$1@ciao.gmane.io> <xmqqfrh3qe2w.fsf@gitster.g>
	<9befdb3e-ff6e-4416-8735-1eea99dbbf01@gmail.com>
Date: Tue, 27 May 2025 19:34:02 -0700
Message-ID: <xmqqbjrdtqed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Forrest <nobozo@gmail.com> writes:

> On 5/17/25 11:36 AM, Junio C Hamano wrote:
>
>> For example, the fact that the index is first read into core, each
>> entry is represented as a cache_entry in-core structure, and the
>> code accesses them via an array active_cache[], and that array is
>> sorted per pathnames, haven't changed.  
>
> I had a thought. What if the in-memory cache were stored in a hash,
> where the pathname is the key? That way nothing would have to be
> sorted in order to lookup a particular file.

The index must be in sorted order in order to allow a set of tree
objects written out of it.  Hash may be good for looking up, but it
is not the best data structure for stable and efficient enumeration.
