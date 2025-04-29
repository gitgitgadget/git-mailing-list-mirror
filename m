Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E7FC0B
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952405; cv=none; b=PQYrdbZqDdB1GUSKFLGSDxkpsHdSY3Ns1JeDthTPnTncVJTzRCzzhyKzuBeB3raeQTjusLVVFOgn3BgCwtR1sA/TLk0x2a2RUelyXbCZaNz7H2ddokB/FXbDkDaiU2fFT0I2PQQumaO8wkxA3IWPZ+6ne7yIv3857tjdJ5VgLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952405; c=relaxed/simple;
	bh=15KnxUXeehHxZjfELcQGuUG3ps/4nAtLQkDNxZ9ULxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dq67d2g6NdojFHMaWWuzrEZBK236VzLUaCF46+jOym60jhuyjz04LT/4Qpt35jockC1X18LRIRKCxf/67LSUj0lvIRkWa4GTbfzJkbS5oMpuobUV2J15fHQNfj0WLt9PcSBbzISJS4WQTTDTwoQuAxiQNIEWSchVQVHBW5kDpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fy8sJ4t7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vyjgIyfW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fy8sJ4t7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vyjgIyfW"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7590B11401FB;
	Tue, 29 Apr 2025 14:46:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 29 Apr 2025 14:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745952401; x=1746038801; bh=bzHtCdRy2B
	tnLbJ07kUhx4nzUtqgHL5lFgr4UlTZJNs=; b=Fy8sJ4t75ekwqMFPpJ+DqFL7/3
	8El7m7RLe46A+8KSoM7trnHUc0qGxNl3MyeBQB0uSF/rEYnGHKU78p+mjfPAZ+WE
	kfiRN6iQY0kjp263g8ARzLI0oNNRwPY0Yhi5Y6ilYvdqZo/03JEaTv3Bld8j0E5H
	p1thDg0lvh+M3nHxM1g+h6qV6YQXlIF1Zn48ACFQDiKnNAC0BynlXcd8O/M/4nz1
	dbMDG4iU8M4d8WJVw/Nz4D8JLGqa1hnhjRf7pg22ZjM+cRznq1rUzkchrvAooPI4
	MxDUQoUpBocr9jpeL2fReJ/GghCYCt7MxEx5f4vQp58HuEq+MTbLTdTdIdgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745952401; x=1746038801; bh=bzHtCdRy2BtnLbJ07kUhx4nzUtqgHL5lFgr
	4UlTZJNs=; b=vyjgIyfWgc4JR7QCf9nXwFXmNA2ao4GJPajWl3PWdX4aUiR+mQV
	/CJA81WRQqRVI6Y95gp8+5CdAMunbYTLXxXzu3XwpQY8KRZEUfyVLDg/zT29/3Ww
	AOnoTs0gRCRty34r+crjjHeIWhF8gezN5Vy4/36z8N9HF2C4C2G++o/K/9dKZzbt
	SY9KFVz/JNa+Se6VwpQn/xBDoKpzrzwnTCouUkhqipWu8q7sTbxXvlEgjbCKu/PO
	fSxHVzbFlzPsQjt5+hRwBS0iiNZhSddAOIY0zXVJnrpCNVqFUVGEEJwzJkQ+5Q+2
	1kTtdGn6DP/LC4Xe7dCZXoTwOrL1P6BHn+g==
X-ME-Sender: <xms:kR4RaLCvc5r29vCAZmbsywRgNlKmuRfnP9Je4Kj1_RjJtVHlh4ukvg>
    <xme:kR4RaBgKUJH9aZk6914ZRP_TYW9yhDNEpWLouHKHSd7uS00435cv7Gv2bIF7Z7T2y
    k17S-H6A1nX64aExg>
X-ME-Received: <xmr:kR4RaGk0pt2-IP51SSslHx6xytGjo7jjlDEGHkEhU5ZbxmrexlWulAvAZClq34KMk169VaIvO1798SvMbUtb4XAuKl21YtvIC0Ij>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgroh
    eskhhlvghrkhhsrdgsihiipdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:kR4RaNwSilYbMfEyJ7-lWkYQp5ebqjGxv4oiiNdKFXk_5Gj7_-33zw>
    <xmx:kR4RaAR0z0zIQy6Sb_Pcr3Cgyt2JDAc4inAeogBOPv373NJNziWNGQ>
    <xmx:kR4RaAaaJgPjS2Qg3merPpIYnyQzjbVqqsPYr8vuYSa-o5SQi-poyA>
    <xmx:kR4RaBSK9qmmzBKMXDAi6_KV9VD8wedU5d0ktyX53bAQJrteSl7LTA>
    <xmx:kR4RaHf_QdJPi9kPTMYSsBNCiG5xFYc-EcMXEG4X8ltPo_hccXxXJMqU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 14:46:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] replace-refs: fix support of qualified replace ref paths
In-Reply-To: <aBCt8YrqJ7IM0ld6@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Apr 2025 12:46:09 +0200")
References: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>
	<aBCt8YrqJ7IM0ld6@pks.im>
Date: Tue, 29 Apr 2025 11:46:39 -0700
Message-ID: <xmqqh6266c1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I wonder whether this really was an intentional choice or whether it is
> simply a bug that led to useful behaviour. In any case, git-replace(1)
> itself does not mention your behaviour at all -- it simply talks about
> the "name of the replace reference".

Yup, I am reasonbly sure that this was not a designed behaviour.  If
this were discovered during the original review, I would probably
have suggested tightening the rule to ignore anything with extra
levels in the middle.  It can be argued that it is too late, but
with this ...

>> The only way this didn't "work" is in the commit decoration process,

... where the "funny" replace refs are honored in some but not all
situations, it also can be argued that it is highly unlikely anybody
sane is actually depending on this "feature", so such a tightening
may not hurt too much.

The reason why I would slightly prefer tightening the rule, rather
than making the loophole even larger by adjusting the code for "the
commit decoration process", is what it means to have two different
replacement objects for the same object, which would naturally be
prevented from happening if we did not allow extra levels in the
middle.  Would one always consistently trump the other?  When a
filesystem rebalances, would we just pick one at randomly based
purely on the first one readdir() happened to return?  It smells
to lead to nothing but a confused mess.

Maybe the answer is "don't do it, then".  The same answer, however,
can be given for creating any extra level between refs/replace and
the object name itself, so...  I dunno.

> If we can agree that this is something that we want we should definitely
> amend git-replace(1) to document this new format.
>
> Which raises the question: is this something that we want? Are there any
> arguments that would speak against loosening the format of replace refs
> now?

"What if refs/replace/{a,b,c}/$name point at different objects?"
would be a solid reason why we shouldn't do this, but I personally
do not feel too strongly about it, as "don't do it, then" may be a
reasonable answer for such an insane scenario.
