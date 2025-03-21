Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFC26ACB
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538710; cv=none; b=ns31goNnZvOV4PMm50wxS5qFk6fzfMPwsRNH9mLPaLI9Us/d90L/AgfNLqOJ96dvNflywf+v50+FUW7JB5qUVw+Wga1YSqxsrJWUxNL4S68PjSMOS8p+H7ORnJDlRXtOrVQYI7HIbc3dWL//gZtpTJA6wM3fOA03kOnYLv9rHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538710; c=relaxed/simple;
	bh=YHg97iXsfAyfcfD6OuihboHiYqdAJdPDrYDTkghouCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpmkJE0ibcuLF4fBsZ9NWYGFk1k+5q6S+mrec+kCecgKThYcEfPEklLwEd6JLATQa+t2ZnABL97aeh03Ev081ca+3m31oMaszycZ8GZIeOLiLG5t7b4eTRPwEU59j5IB3jjjswNx9Ubo9iRRh1iWsF9HPYYpupoMPhWRe/53VdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sYFit9Ny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMJ5O6+w; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sYFit9Ny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMJ5O6+w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 245F9114015A;
	Fri, 21 Mar 2025 02:31:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 21 Mar 2025 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742538706; x=1742625106; bh=SHBAzcRJyw
	avVe9lnDgVqn2PxroS2N7El4xD3pMKZVA=; b=sYFit9NyoQ3ENUcM6Q9n/WpVsf
	BzGJ2qMH8bUtRPTRLDOjePAEzY2NJdrjIDX5dYhzlqmRTQw83fNQ7wJHnZL8DpN0
	syMgNybf4QQsdcO8aLQKIXTpHDEYeDEoZ5JrKPsGou26akgf5Wv0KnRO76xdJHs/
	ClacGU3M6NOyzszT9Q1tfcCZBq6pv1OW3Ffpu6Y1KTprzRKEG4wJpftp2ZOUfe4h
	l++jB66gViMysNVXMSPHvRW2EX48f/5evOJV51sleVz1j3pELU4VZoS9P2rr9URi
	F3JcjbwZCE+y0mGqRzcg8XNUf3LQNPPNULooi5aBU/YqGkWzZXukexedbpsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742538706; x=1742625106; bh=SHBAzcRJywavVe9lnDgVqn2PxroS2N7El4x
	D3pMKZVA=; b=RMJ5O6+w6oOAUvhbzKyyTyxHCI+4hqONJ2+HtLitB8eBBsl7Q8H
	rUQLwxqyDsFEULmwveqeZkf2qafdjOKjTxFBwxN4/q4MUa814odh4YQe5ADN3Sjk
	LqgkzPW7Vws2k4SWTOT+YwUw9XRDOwVrrPk3G0nnhW1ATUausW3JjSQnDEykmDGI
	10GzL+N/5NNAkMUpGKKJQKP74y7fbEUrZYMUBZhMjY+rPQFUVB5F+340WeEOhkPi
	QoQD/quGoSY5DYMw9tw+666cLMzHcsWmYwrKGaCKRxRupFcPj9hLslyonPzlmQAW
	QpS1nWku/Awo7rCujWZQGLE1Du+LCBwqaGg==
X-ME-Sender: <xms:0gfdZzxY_gELq30D-JWxYiUs0fZ1FiHIaGAsRwo5slm28MbODXtLUA>
    <xme:0gfdZ7SV1wOPFfvRYYYV2fsI03wq6NjbIJ0of5ANWtuhd75lt29wsuk4Aa_X54HsK
    lHOhgq0WdszM6U62g>
X-ME-Received: <xmr:0gfdZ9XNmmSWXUgUlw4InoVHDxKWFIkq5OfFcu0RQE5WXCeu6-7wpMfNDe--DyPQPYxDZpXbY4uCfSARQkWO_VHptl-hvQy2g8FOcko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgthhgrtghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0gfdZ9htFqY87rGAUEuwr9W-8Nz2Wiy09BOzk135eLtAEYWXVvUh6g>
    <xmx:0gfdZ1CZoK37w43ovnY0XakxT0MDrCUz5d5Tim8qVGHAlS_QWjDV2Q>
    <xmx:0gfdZ2LDxW0gOx5AusDlY8PV57FFJfDNqJcOJQ1TpAYu6bwe4xzCmQ>
    <xmx:0gfdZ0DOs_ex9iSOR1lL8Ng2ekDkIvTE3bJ9RaUCCJ3mg1eAlbI-4Q>
    <xmx:0gfdZ31E4qQYt19xRLsEQKAIP4AhTmfdos1GB1nsml8xDU3T_qXQs5oH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 02:31:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with
 tags
In-Reply-To: <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com> (Phillip Wood's
	message of "Wed, 19 Mar 2025 10:33:48 +0000")
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
	<pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
	<d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
	<e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com>
Date: Thu, 20 Mar 2025 23:31:45 -0700
Message-ID: <xmqqy0wyvqr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Scott
>
> On 18/03/2025 15:36, Scott Chacon via GitGitGadget wrote:
>> From: Scott Chacon <schacon@gmail.com>
>> +test_expect_success 'clone with tags bundle' '
>> +	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
>> +		clone-from-tags clone-tags-path &&
>> +	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
>> +	grep "refs/bundles/tags/" refs >actual &&
>
> Thanks for adding this test. Calling "git for-each-ref" followed by
> "grep" follows the pattern of the existing tests but I'm not sure why
> they don't just pass the pattern to "for-each-ref" and avoid the extra
> process.

Yup, if we really care about a single ref, we should just go in the
clone and check with 'git show-ref'.

> Do we want to just test for tags or are we really interested to see
> all the bundle refs created when cloning? This applies to the previous
> patch as well - we obviously need to change the expected output but
> I'm not sure changing the ref pattern is necessarily a good
> idea. After all the point of this series is to create refs under
> refs/bundles for all the refs in the bundle.

The really interesting case that the original behaviour could have
been "working around existing bugs" would be

 - prepare an annotated tag.

 - include that annotated tag in the bundle specified by the
   bundle-uri feature (whose SOLE purpose is to speed up the main
   part of the tranfer, WITHOUT affecting the resulting remote
   tracking refs and global tag namespace).

 - prepare a repository that uses that bundle as bundle-uri when
   getting cloned (let's call it the 'origin' repository).  It
   probably is convenient if you make this a repository  separate
   from where you prepared the bundle above.  Make sure that this
   repository does *not* (yet) have that annotated tag.

 - clone from the 'origin' repository with bundle-uri feature.  The
   annotated tag would be held under refs/bundles/tags/ hierarchy but
   that is *not* the interesting part.  Make sure that the annotated
   tag does *not* appear in refs/tags/ hierarchy of the clone, since
   it does not exist (yet) at the 'origin' repository.

 - Now add that annotated tag to the 'origin' repository.

 - fetch from the 'origin' repository again, with the default
   configuration (i.e. allowing "tags follow when commits they
   reference are fetched" feature to kick in).  As the annotated tag
   appears in refs/tags/ of the 'origin' repository, the commit
   pointed at by that annotated tag now appears in one of its
   branches, and the history leading to that commit (and possibly
   others) are transferred to refs/remotes/origin/* remote-tracking
   branches, the tag-following feature should kick in and copy the
   annotated tag in refs/tags/ hierarchy as well.

The interesting part to verify is that in the cloned repository the
annotated tag does not appear in refs/tags/ immediately after
cloneing, but does appear there after the 'origin' is updated to
have the tag under refs/tags/ and then fetch

