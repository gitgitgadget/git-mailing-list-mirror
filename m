Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B11114
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754457478; cv=none; b=TEPbcW8FVOFahOKwF7k8giyvHm1AWe3xS8lPtX39DHEtpe7hDlsJHDxkgjeS2ID72Fj5Y0c2cTrPAyXHBHjEfI7mbXZqsK88D05jQYTrSZIJNtiUErI4QpWcL0lgsJtrrlBCQHmy96ZHXtvsgI6mzZvX4ljDRIsYXaV9vPLmWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754457478; c=relaxed/simple;
	bh=fDNsr5cb2u+hqjYM64S1S9Mqkl/QI/QbAbI3a6EkQZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3rXSFUR6/SQT8A0TNnbEjWw7bpikEAudxL76NlInMOppLDj9beohCcRXA/A7vwksBNLSJBZ6vx9DZH14l06gzGCrBTW6gzbBYTA9asru5MITsusksvnSubikhN6pn7g9R1XCvrILVCw+Pu7VYujc6aCQEbJJ+YbqiQnsjgkbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QxrD4DBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTxii3/F; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QxrD4DBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTxii3/F"
Received: from phl-compute-07.internal (unknown [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6606C1400089;
	Wed,  6 Aug 2025 01:17:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 06 Aug 2025 01:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754457475; x=1754543875; bh=WwZykho0YO
	lr9KEn/wu2lTahYvmYTTXmjPKx6LLyC0I=; b=QxrD4DBqc89eD6NK6KS/KvUGAJ
	1HvjIxYYOnmindoKzXPRWPSaumvwT0VFWiIeYHj5CiXUU3tQoC/IWF4quSlTIZxn
	Z+gcAugYP10sWtdl6AlpRppvwjyJzaeni8Fo2v3RGRphBpzHOc6XHcznNBhG4cmW
	llB+NovVUo/ONTawhGoQMtr5TSQajGikKqPpfn+WE7LR4qaIQC3QlbwbHiCu1t8j
	95/Bn2UAvEVqNvfzaoZVRWJ5vxlLiZu7tcd4+fsVKZZJPxrJlcBdKyAG1p2k23hL
	D2cWTdmghK4sJkTtO0EbNgdh03DY0xsosSq4GbTfl6O18SyO4B7Z6Xi+dOpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754457475; x=1754543875; bh=WwZykho0YOlr9KEn/wu2lTahYvmYTTXmjPK
	x6LLyC0I=; b=jTxii3/F7/F0j9mVHLWht55rkOkO60VL7DDuW7mgj/DNJUN+MjG
	GFWdt98SAODXLMpdaYpd/RT9MJE1lCO5Y6rP73rdi+jxtGTn6fde6+gMlc+iht8i
	E6fcyXJlYFlWuZz3yauGouwBn0ekVYs9QbnwYOXxZzlrChI19qCt3dCWp2B4FyhL
	r229FnBdHLFiCbU6adlXHgj9QMXT3Y2xb6+Pxf/URofuGWxQHiB82j4AjaRnx27S
	6DS56ZsevO+Ydk+s5DIVrPg7vpA3dUb+qe45lZgWWab6+0Ofe9U81ghgbO8h8Bhk
	3crCXwbZRWUXo2DFcaczUmYC9GpXR/9Y4sQ==
X-ME-Sender: <xms:guWSaM86LeBQu3P-W1s2hLQQtPeNaKqhSLaWc3VRkUi3N1TVeug9uw>
    <xme:guWSaNJerxfJeUwNB0CZ32Uykf03yB3saevd552HvTrP0V7Zly2xZ4-Uz5JGVZ26K
    B05CrEEMoqCnAD1eg>
X-ME-Received: <xmr:guWSaCd7YQ5ng0E8a6y6WuomTeOoGxPoxWlPc8Z4r3w7kIKdMAbe_Hb9qVZXlkgNKiyU-eW4pYYrWyCD8Npmk2H_7AIrnYDw6H2Nre8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesfhhmohhrshgthhgvlhdruggvvhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhhoshhtihigsegsshifrghprdhr
    uhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:guWSaM9IkHTbxswfJcoKhgwxKK2bckxvkF5JOIBq3UHCy-O41L_mgg>
    <xmx:guWSaPoY3XJKr38VRhbx8AiPgC-SHmFg7CcqeJab1gMUdpbIXXMI_w>
    <xmx:guWSaBC1FG33ZHWKklHhj4FzhDttxq_EUFUU7YYzn_0akXIDVHSNqQ>
    <xmx:guWSaBx8C9aq50PeXD1WrUoLMAeFr-WG1aO62YrtYf_eOUleMttsZQ>
    <xmx:g-WSaJ-jPL9L_WYOiYALoGfvyOntUlOYxbwYek4_ipqKj298XPVzdVwy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:17:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: FMorschel <git@fmorschel.dev>
Cc: git@vger.kernel.org,  j6t@kdbg.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  kostix@bswap.ru
Subject: Re: Feature Request: git mv --after (new flag)
In-Reply-To: <09e2fb55-2f04-44db-a062-fa6c2c01c8eb@fmorschel.dev> (FMorschel's
	message of "Tue, 05 Aug 2025 11:47:31 +0000")
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
	<0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
	<2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
	<hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
	<917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
	<ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
	<d7ey5l2bcy4xzidqyq5by4mrwgziahypvnco5ilbik4y3feqhj@vspbafxowl5l>
	<09e2fb55-2f04-44db-a062-fa6c2c01c8eb@fmorschel.dev>
Date: Tue, 05 Aug 2025 22:17:52 -0700
Message-ID: <xmqq34a5xc3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FMorschel <git@fmorschel.dev> writes:

>> But since the decision (of what is related to what) is that this 
>> should mainly be handled by the threshold (so git can figure it out 
>> for you) it's fine then.

The main idea behind the design is that Git can _afford_ to spend
more work at the time of investigating (e.g. when the user asks to
find where this single function came from and the tool answers that
it is the result of consolidating five duplicated functions) than
the time of recording commits (i.e. when it is not yet known what
questions the users will ask about the commit in the future), and
that Git can _improve_ over time how it figures out which removed
ones correspond to which added ones when it is asked to find out
moves and copies, exactly because we do not force people to record
moves at the time of the commit.

It does not preclude a new feature to allow you to tell, say, "git
blame", an extra piece of information to help the command you run,
like, "hey, Git, you may not realize it with the current heuristics
you have, but at commit X, lines N to M of path G was copied to
lines L to K of path F.  You can take that into account when you
figure out where the lines of the current file at path F came from".

You may even store that piece of information alongside commits in a
form that can be transferred across repositories, like notes.  The
important point is to keep such auxiliary pieces of information
outside the commit object, yet allow us to look it up for each
commit.
