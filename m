Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5F17557
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736013121; cv=none; b=fcm86iob1rAlUP32GjpMRjjlUn/vodawNpHOyD86G2FdooXCHznIzLyPPhv9Q4gib3RPvaZ32TCeXrzwiS+k6bXEdxhrzI3kbaLFTJ+ejzzK51eA4p0euCk5F8K7Iu2/u1r3sU7MeoieYYnQtrPXQe904y9bgFBzQDeEWx6qxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736013121; c=relaxed/simple;
	bh=isFaS5XjB4VQRkT6fH3ASOGB256NPrrlmEeau8a94cE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+OMi7/QMyydSuLKXPs4kayX3msGTGUodw/ISdoHl7oLb+skkjbLQ1M3lusdJ4PoCr563J/lhbT3mWU8CRifLxY1sltiB5sE3+VSjG/RtQDTK1dswrT6edDkdxVz3DSiAKFPIDCze01V/iEw2QcphZ/N/DM7cOyoNrhN+KRICd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QC4FFk1j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDNki6yR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QC4FFk1j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDNki6yR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E37713800D3;
	Sat,  4 Jan 2025 12:51:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 04 Jan 2025 12:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736013118; x=1736099518; bh=KYA1c7C/hI
	QgkBWlo5SXkyhfdFtDA1sALAdw3IyUtPw=; b=QC4FFk1jTU0+p+T397BzvmidId
	5YnjazXyBGSV4/fJYpWfRAQKb8pfkVGC409DmCH3+BQni9BlkNL3bK7It2Css8IX
	GLFlIg9HKp1qpfxM7yveRD4/21WsuGP3ovwDiat/pw1MPC0g9nUG6UuZqUgzK29O
	PEzdMjJyYNnzMVIieGKtw6mSqwHnF32z3Utz8bMZSp1zNz0GspZ7ZRqkC8LOQpkQ
	demAkZs2kzItEZKb6Ntx1u4dA66x977qQE0KBDZzH17xvdvdJpWzj+thjYtzbccO
	1XReAjPwoznZvn/tOK3RWROKoiZU8V+sWBGF2eg12zZucNOUII+8RPBPlZ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736013118; x=1736099518; bh=KYA1c7C/hIQgkBWlo5SXkyhfdFtDA1sALAd
	w3IyUtPw=; b=NDNki6yR9CJtxhJSzgJ3x+kHAKbUBC0ojZzqrmeyTDXZIHYhJ2K
	Hy9RtSjEs7jJSvxquV6wYA1hSFdUmqCvDAnwwReFzsT5aqpE/PoY496wsTZqumHs
	9pijVdLkSQISlRv+EMJhXbFqQoX35gjOJ0s+2epEngTRUY/3GHS9MIZ6tLuvHr+s
	/hunFqG2DZ1TuVRPNY5u8kI90hG4EqrTL2C2UWHkur8QaNcWyIecg2Fx3vFIMGeO
	m07xPCLghe+xN3WFM+H8Xpz5aOZAIb8gMTi+50j64AkqZt08Zo1Pt0NQ6FmuPqp8
	arkDzeg+dDlGSS7QFnDGp9MPEqaBkXYw7Aw==
X-ME-Sender: <xms:PnV5Z1ZE9dWpm7d0lhie9J84wzRzZF5_cGEJW_-0Tu0qYz5IWTXHog>
    <xme:PnV5Z8Z4EVDO2M6p7xe0zvZ0H8ZYUiC_AkPaFFvPUiy0I5PaDEWKmhNXwuB-ny4qR
    VoJW2z_vKF2nDsyQw>
X-ME-Received: <xmr:PnV5Z3-o2suAEkabm7DQdAPcEupR8Y-4WD7KoUxapwE5vorFmz-UUnXiCGaBz7odxrn_LB-Y4P7b4Ynx5JVV1twdSnhHSGVVcTl_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:PnV5ZzpEc_uczcrbik-NsosxJIB_sHFavfy7KUvi5scA7OO_u1yjGw>
    <xmx:PnV5ZwrtGw3AlswzoIAuqJJ8YIHEls5TrxSDQpqDGq4Z9aJ8_fsZDw>
    <xmx:PnV5Z5SF-V0mtyW3s6shaAFXFNms_g3a3Px4dZkTDJwcd-7RcKTchQ>
    <xmx:PnV5Z4ppTiAyNJMAebeTO2vOrxdlCyxcgOQyDvuuxewAw8UoY6CYpw>
    <xmx:PnV5Z1Cgxl41DROVrLHmag1qxgbo2joedBpBzzG3-Ee0JG8-fkpfJFHk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jan 2025 12:51:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <CABPp-BEzKyXY7YZOzedwQzAFqLiE_9oWsD=GByiDhi7go2aXNw@mail.gmail.com>
	(Elijah Newren's message of "Sat, 4 Jan 2025 07:55:27 -0800")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<xmqqed1i4pga.fsf@gitster.g>
	<CABPp-BEzKyXY7YZOzedwQzAFqLiE_9oWsD=GByiDhi7go2aXNw@mail.gmail.com>
Date: Sat, 04 Jan 2025 09:51:56 -0800
Message-ID: <xmqqy0zq31s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> In general what would we do if a string can be interpreted in
>> multiple ways in _different_ parts of the object-name codepaths.  We
>> all know that "affed" would trigger the "ambiguous object name"
>> error if there are more than one object whose object name begins
>> with "affed", but if "${garbage}-gaffed" can be interpreted as the
>> name of an object whose object name begins with "affed" and also can
>> be interpreted as the name of another object that sits at a path
>> that ends with "-gaffed" in some tree object, regardless of how the
>> leading part "${garbage}" looks like, it would be desirable if we
>> declared such a string as "ambiguous" the same way.
>
> How would that be desirable?

In "a:b/c-0-gabcde", *if* "a:b/c-0" *were* a valid way to spell a
valid refname, then the whole thing is an ambiguous object name,
i.e. it could be "something reachable from object 'a:b/c' whose
object name begins with abcde", or it could be "object at the path
b/c-0-gabcde in a tree-ish a", and in such a case our code should be
set up to allow us to give a "that's ambiguous" error, instead of
yielding the first possible interpretation (i.e. if we happen to
have checked the describe name first and "$garbage-0-gabcde", we
yield "abcde" before even checking if $garbage part gives a possible
leading part of a tree-ish; but if a future refactoring of the code
flips the order of checking, we may end up yielding 'an object at a
path, which ends with -0-gabcde, sitting in a tree-ish', without
checking if that could be a valid describe name).

Of course we should make sure that the syntax cannot be ambiguous
when we introduce a new syntax to represent a new feature ;-)

Now, I think ":" has always been a byte that is invalid as a part of
any refname, so "${garbage}-gabcde" with a colon in ${garbage}
cannot be a describe name.  So in the above about "a:b/c-0" is an
impossible example, but I was wondering more about the general
principle we should follow.

