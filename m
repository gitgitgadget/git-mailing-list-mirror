Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792E337692
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797289; cv=none; b=s7u2zTtaGEL8d84JduFIjpxpO/uyBZOtG+SbPBD2B5rkOgdvIqoKJ1UMJ+pTjwVXkXi3cARbzsU/fKQoRsji9vsk9/JLFhV7YFlZcRejclU2ziJm5RFIe9H9PXmTwpFg60vMijD/pknkqX+d684NZj7YPrbU/DCoeldgzuOfp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797289; c=relaxed/simple;
	bh=QnNcEA2E1ofekoZY8H2HsZFsq5DEfLnYomIJryaPytw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaMbuGOVpSBOY0s1ZDGcXCOyOkLv2XCEXAfFyLs+zUL9OcmHUXBJLYB4FaS2IUMb/hXMfHwjdiTAXw0sZpfLLy22TisP203wbL9wwekRhwhp+Dck7RVsLz0/vkxt8jmFPyAM5ue6qKUbzaO1Sx/X1M5vBspqSfFJcVqyNShZRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yor5xxfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8LKXQf8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yor5xxfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8LKXQf8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DE8E7A01F7;
	Thu, 21 Aug 2025 13:28:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 21 Aug 2025 13:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755797285; x=1755883685; bh=plj4kbo+Mn
	m8KFaGNXezK6YO7nV9AoZ1MC2dISi/bmU=; b=Yor5xxfImwpQREwJkQhB+x4Usw
	YTtedNtzAspjk6OGwu2RlukCGPbehR3Hg2M6YjbZYUT5Fobgyolz8szkx5alC32g
	voSjOuX4ehXUqtzmpNHF1I9kff2e55GF6vlAdq7MOxhlOCS1KAu0DClcqrhiTdql
	rjwcVhv6dR0RRKC0xpcty+rSz2SDibY0HHOhoNrimZsQbNliXtllJONxz6JetU4J
	yY3B9/ubBAswcciGGE6v2wh74IoVipnrNWXRLrQGFue4ONdNqUjxMyJ0LLE4Bq4p
	5kVgL6zLyhXLu0l+nU7h05cGcgOxUco4hpM5kdgcurQ8kCLgQV05WeJL0pXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755797285; x=1755883685; bh=plj4kbo+Mnm8KFaGNXezK6YO7nV9AoZ1MC2
	dISi/bmU=; b=I8LKXQf8r2pnDKkRERKmfHxg3BR6J5anfNRsVEMgFqogaeR8l3Y
	1rVdWcJhmdo2/X2O1UIi/BwQx9nULPwScrB4cgbn8c82IWE6lLWPSjnyDLi+zOZ4
	e/sLKPlSf3h6nK8ZRlZmxRpIyD8Q7FXjY0DvfO/Kn3Y5zFQjdJ2lDZtENZiWE26/
	L8jrF53HKYpnhUxEGDfHd/EE+44Q+d/bSo+C2/W7Cjr3uIUft9if8+PiMtyCm2SN
	dGWKwDQzAwiPxup5+c0Sf7WwXgf7FlhSPab1Yj6R/+C9jY9itih8eKS6qPtm21bL
	FOoSCbBRZguiBPEQrEsrkfNVBfoGXz7P0rA==
X-ME-Sender: <xms:JFenaJgIYyhVItzbsy0CmG5fhCIu6jMaYk3kcasN-pQJ6fVdYBKYAQ>
    <xme:JFenaPhipG0X9uOjyoV_u3n0dF1wqfyF16wdYMm6z4XO8r-ar_ADbBR0HBzRK-k2J
    xxr1qK3ZsEjI_v1Tw>
X-ME-Received: <xmr:JFenaJKwnuGmrGES7JiZ7LVZTKukxhePt1cyZ1zSKZ6vi5pyNWGSo7BcD1wJyA2cIDNTwY4Pg1StG0YTfZLzO8s78Z15vKf7ypTI-E4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluh
    gtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JFenaOGzyAmo4kM80-WeYQfL0ppGROIqA4i-hj_vnN8yBWztnYx2nA>
    <xmx:JFenaNQEtsNSMJhsovtsp7rhVHVAbn6xfs84Lkr8dLC5AD700vApxw>
    <xmx:JFenaKfHtx_vJgTWAtOzmHYtu002_o1_pxvCbMSjS2qBeuKwuGuj7w>
    <xmx:JFenaMpmV8dh1wfpfm3R3XcnFV61rdIGjpB5ZCwaL3Ii48dC3mv1EQ>
    <xmx:JVenaJxxm1NFK3XFLNAZpMHsLl_zcHsXIren0mNJhwdOAAVjUHdnvMWq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 13:28:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
In-Reply-To: <2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 21 Aug 2025 10:23:29 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<aKb1AfeIWB_SfJiI@pks.im>
	<2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com>
Date: Thu, 21 Aug 2025 10:28:03 -0700
Message-ID: <xmqq8qjc37q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> What this cover letter doesn't mention is the base of the topic. I
>> assume it's v2.51.0 with lo/repo-info merged into it?
>
> I was assuming next, but I'll make it more clear in the next
> version.

Learn the way how it is usually done by looking at:

https://lore.kernel.org/git/20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im/

Basically you would want to say

    This is built on top of <commit> with <topic*> merged into it.

where <commit> is a commit on 'master' (or 'maint' or an even older
maintenance track, if the topic is about fixing a bug in a released
version of Git), and <topic*> are topic branches in flight that can
be merged to the same integration target ('master', or an older
maintenance tracks you chose <commit> from).  And keep the number of
<topic*> to an absolute minimum in order for your changes to work.

Do not build on 'next'.  You'll be taken hostage by all the other
topics and have to wait until all of them and the merge commits that
drew them into 'next' are merged to 'master', which will never
happen.

Thanks.
