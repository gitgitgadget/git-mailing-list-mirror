Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC611CCB4B
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221768; cv=none; b=FFgKmlv3Lo7mEkxsFeOzMl9PNPUkk3G6sBFbe7nREQIOzLo1m0O9HJoigDZ0qXc8vCSOV6cS5naQMw6KMJ5qGpDU//2X3mWYHXMO+WdzRpSQQ+xSIBwW2Z/A6Djmv9A4EzXSjN8u0YLB5VABG5fsWtAUVtxhvgcVnKCU0tLripw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221768; c=relaxed/simple;
	bh=4pwUIzd3hjiKoWDzTYJKngF52Uu/2r+WTVFS/jJd7os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgSbiFrtq7ZP4JTyJsCMXVR3jq/X4NJ1vW5yT5u2GtR8tci64RhNOXsrk5/K1w6486dle9uIXuTzLzOfXiFIebi8FhwC5Bf0RVZhaIrofr1oOE22TDjrzwo/dJLYYWmixFpoHnhajMqrA80y2cGbCpGu2UZ1dOhbxPKT7b+66YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZ1YLAAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TS8VX7w+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZ1YLAAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TS8VX7w+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B46525400C7;
	Wed,  9 Apr 2025 14:02:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 09 Apr 2025 14:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744221764; x=1744308164; bh=JOP/NRvc08
	SGrHWcGnJBqFsM0JaCTjMaazOA/aXNeSg=; b=WZ1YLAARX0+IZGeV4nh0r3IqeP
	B0aNZZYDzmOggaEtYROtqOxJBfdBer9rVV5q5Td/x/QE0hqOmmwxjjdo34HrIOLk
	ZKl4zCA+gzKWJZUaQY2wua599VOukrv0DhsQyr5k06r+XSoGdrnxxN8Vc3FnIQV8
	ldzQnf/p6hReES6fBha1/MdFezhg/y8eVzXfanZdl4MPuesRTSzN9A0A7pvZJ2Sg
	Ue5LXtLXVSnozS/u9vSrKtWs/W7twfUko5tO6c4M84O1sGzG0WMVL8qmqzAMC/aQ
	OXrbZM9PXJgIxG7f6zRSiu2sFL5mlB2AspIIBjgety0S+UK/M0RNZVsK7F+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744221764; x=1744308164; bh=JOP/NRvc08SGrHWcGnJBqFsM0JaCTjMaazO
	A/aXNeSg=; b=TS8VX7w+WsCBaxamj1WwjEglMOd0Gn3bk5UkkgKc4eXPmugl6TA
	SBkyUxTVIarubEns1/K3Pcq6oAY08n2y4ptbBwo9/5SUnVZgvgQKN65s15p0To2H
	ldzav1EmZZms54cfA7blt3vXDsaRM9pjnmMxFMnqsbJIUvzXfFJswtvHCU7q3uBx
	/Y0pMJp89BDVUI1zVCaOY096KYSNNNnyfL3qybitiYEIsH/z3Q3kS8ohVgrjEgDt
	cetU8J1MeoiJzL0DzxcGdfe0sB6t3LZXudkcS8XY4RXchupOSPiX6AI9TljI1GSg
	XjOKCHFLRn/gSvr2GV4ADLIbuCPSxLMO1zw==
X-ME-Sender: <xms:Q7b2Z5F1aLPqfqhN1VPVIeQVMEJYE60sRNF9WjJpP8mr4x1_QERq_Q>
    <xme:Q7b2Z-VwvKRCZEW8-hU4lUYTIvvZy-McQFCe_8nbI8_W8I2AjT5MdO1t3mDq-5coh
    r5GSyHpxiitQxtfUA>
X-ME-Received: <xmr:Q7b2Z7InJhKECpBJWRUY8LYRsu_rHR9lBmmFl9RcUOPJxS0Fnc8jsOQ8dEro_66fv0djjatRsq6INd7BRjxWb1w45MLLWl90yPhu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrh
    ihphhtohhnvggtthhorhdrtghomhdprhgtphhtthhopehthihtshhosehmihhtrdgvughu
    pdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghkvghmphhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgtohhtthesghhithgsuhhtlhgvrh
    drtghomhdprhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthho
    pehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q7b2Z_E-5DpLRdrLOo0_1WTrW5rwW4EC6T_B-3RpImcwBeQtBD6vEg>
    <xmx:Q7b2Z_UWK2Q94toUuHSRPQfCp8kUvduQ_9j0BtwuqZdxye1yuEOnsg>
    <xmx:Q7b2Z6OAu303YdR7IHQ2WdCsgD9Lm5KXG0q_UEX5G02dBDAFRmjvhw>
    <xmx:Q7b2Z-3ISWEynSqUT-W1XQtTR7qa4B_hjsmnXS3plTMkRh152P3c7A>
    <xmx:RLb2Z-OBGPBndbkPDaZUUn-qOk0OTxa5qIflmLxBEwC5RZJkSoYekgNE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 14:02:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <Z/amMj/eg0RbXdkS@ubby> (Nico Williams's message of "Wed, 9 Apr
	2025 11:54:10 -0500")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
Date: Wed, 09 Apr 2025 11:02:41 -0700
Message-ID: <xmqqv7rdqkla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> I don't find file rename heuristics to be "simple", and they're often

I think you need to re-read what Tytso wrote before reacting.  He
never said rename and copy heuristics is simple.  His statement was
that choosing *NOT* to record the "file A was renamed to B and C was
copied to D in this commit" in commit objects can be thought as a
choice to keep the system simple.

But the decision not to record renames and copies in commits is not
about simplicity but it is more about correctness.  People record
wrong renames and not all renaming changes are made with "git mv".

Through your GUI IDE, you may choose "Copy file" menu and make a
copy of an existing file F to file G, and edit file G extensively
and record the result in a commit.  No matter how heavy the edit
after copying is, your IDE would remember that G came originally by
copying from F so it should be able to record the fact that G was
copied from F in the resulting commit.

But recording that as a copy may be a *wrong* thing to do in the
first place.  The IDE cannot guess *why* you copied F to G in the
first place.  Perhaps it was because your project requires you to
reproduce boilerplate license notice in the comment at the beginning
of each and every file, and copying an existing file as a whole,
removing everything after that initial boilderplate comment, and
write everything else afresh was the easiest way for you to work.
If you inspect the resulting change brought in by the commit, with
intelligence, a human may say "G is a completely new file, even
though it shares the leading boilerplate comment with F and every
other file in the project".  Your IDE wouldn't say that.

We designed not to etch such wrong renames/copoies in stone by
recording them at the commit time.  Instead we compare the before
and after image to intuit the _intention_ of what the user wanted to
do _when_ you _ask_ (i.e. when you run "git diff" or "git log").
This has an additional benefit that the heuristics to find out about
renames and copies *can* be improved long after commits are made, so
a commit that used to be misidentified to have renamed a file (when
there is no such renaming) may later say that a file is removed and
a new file is made independently with newer version of Git.
