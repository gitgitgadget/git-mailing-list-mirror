Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE324A058
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844946; cv=none; b=EQiR8hGWWozOQWp3kSTbDHt5O3cGH05G4ctj5sqdCTSToAvVjvvRXx2bFmbQEoouMWaFgcUEpBBUHcHOYpj8I6ZvF1ssSS+wgzPQzRlJHGXfTRx7EAYtyMY+K/u9Beg4k4TDRyABV9KJVKiLxFuGaMl9dW+KH2EOpb79FqIz/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844946; c=relaxed/simple;
	bh=+cT0EcKFRVnaqsyuLfiFmPQy6wHn7OD5qJ5KVFCWWEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dk/EqHvf4E3R2tJ/moLA+dptFRoq1lei2EhnHn3jnbeV6LOlmivkcfwOCXcY4UpMmG1Vl65tzQ5ZzxC3LGS5AVAiVAFpx6wO3hQxvij0jTBhC1XSYkzFZAPKoeFHyHTH1AwSxGqZ+sBVagf56BB3qx2ctj86jaQ3vszirabwmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FjFtPQi+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIdOj7ko; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FjFtPQi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIdOj7ko"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A4F751D000F9;
	Mon, 15 Dec 2025 19:29:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 19:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765844942;
	 x=1765931342; bh=j70aP8gY7PQE74T8P2cJWftvy9GZtacsa2c/TxlWnaY=; b=
	FjFtPQi+Pl6aG5VqCiMYJjPj1Xsn60K4db30rfSDHKrJZGexhZxyTFBhwo4oOoTv
	KMe93C4uuy3UTbIcBHHyt9ohAlEz+A2IBiAf4lDKo2WL7kmTDO16Xp3OpRVwO/TX
	69iCiHvjPbeXwoI9wDvGDIn9dck8W5XqNNpap2FIM2Ntj5ojglsgNzUxF/Caoju2
	E7FrAHhuSdmsZJ/gsvAN2sE9dkLY//cP2/XVy3MLWO7uo277OBKpp2udyvBzTyLY
	ZnI3PPMZVWBsVWchK+0jCUXdOzUIfuW4SSeOHjWrYcVUpsu5aiAjlvgvMXPFI2TM
	HosXCZE52bVblPlGnntvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765844942; x=
	1765931342; bh=j70aP8gY7PQE74T8P2cJWftvy9GZtacsa2c/TxlWnaY=; b=E
	IdOj7koiTcU/7kGmATWEhGY02lZrkzY1nTp2WlzIDu7pOFrkl3fFXWPl+2JNDnMJ
	sBecGLtII2S3DdqUtCRe9irJTCuEvscHSuMpeCamOV1tjJBkHtwHEbH95ByniShk
	qjSqDynEI0vWF2UnhqVCH0aZZRUl/l941YJx79eLD80k8SOXVN+EhNcLxObxztj0
	SwkYsvY+tOPoVFBNaRUscy4z94VBMCBcNtafeabXlRyAsunKROFZyvR+IuG59rms
	KD7kdf2BSd5FkMLUsE5N4W9LQ1KgE03eyRG77+SqPTfqrix6VmZAfbLduDoNNI7w
	xe4p/ycsyTOSYHop4Uqow==
X-ME-Sender: <xms:zqdAaaa8Fu5Mpdqsu-_8VFSTITNF7QIp8dnmtHeHMMBYfszZqgreAg>
    <xme:zqdAaeHk4jjiR7IuGl-bgU-qZshX1hNmDkHsEnIhL6-Zngd6egXS7iWN9pzQ3aiYH
    fL6Y6hiX0RJEabGDmjW8AifdbZ7nBqPdyk40o0UknHjAnbnEUxTNw>
X-ME-Received: <xmr:zqdAaTJuXnewamAYZziUgi4vv4l9NW-WUkZRCl6tM4whdNPrn37zCQ9A4GnznVuS7ZNg5gUsYJ_69SrIqVaNUblwky8ROaBIhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zqdAaRM3m-6ebaGV65cH3SXrPxoASgcYazJi1BwRR9nsmdDGbnkE3g>
    <xmx:zqdAabng77421jIYtf8eDiCW3tdDNkS-5-On7knFYhFN1Vd3pc9bqA>
    <xmx:zqdAad7f_fbSptzG-IVMvaJrojQikylogBgEjzhJpyuDppr09LDKDA>
    <xmx:zqdAaX2DbrkMBYTCNKuTNgPRP9JBJ58tL8O6kMxKEH-Y-FNTMnL_jg>
    <xmx:zqdAaSU0cyu1povt9K8qgA6LpoBCtdarJc8p5DQZghCnmaaxTk31yxLf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 19:29:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  "Christian Couder" <christian.couder@gmail.com>,  "Elijah Newren"
 <newren@gmail.com>,  "Siddharth Asthana" <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v2 0/3] doc: replay: improvements like "mention no
 output on conflicts"
In-Reply-To: <bf3f3633-5d0d-4fa4-9706-d99e32a3f91d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 15 Dec 2025 12:59:07 +0100")
References: <CV_replay_conflict.101@msgid.xyz>
	<V2_CV_replay_conflict.12f@msgid.xyz>
	<8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
	<bf3f3633-5d0d-4fa4-9706-d99e32a3f91d@app.fastmail.com>
Date: Tue, 16 Dec 2025 09:29:00 +0900
Message-ID: <xmqqa4zj6zhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Dec 15, 2025, at 11:13, Phillip Wood wrote:
>> On 13/12/2025 13:46, kristofferhaugsbakk@fastmail.com wrote:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> Explicitly say that conflicts do not give any output. I found this a bit
>>> confusing with the current doc since I am used to other commands
>>> complaining loudly.
>>>
>>> § Changes in v2
>>>
>>> Patch 2/3: improve `--contained` and mention that it requires `--onto`.
>>
>> The new text looks good, I don't really understand the commit message
>> but the intent of the change is clear enough.
>>
>> Thanks for improving the documentation
>
> Thank you. But I’m not glad that the commit message is not clear. I
> would need some guidance on how to write it because it seems clear to
> me. Something with my brain state I guess.

They are already in 'next', but let's see if there are pain points.

commit 8467c95419acaa826a6c1ca0db0f36a3fd614ae4
Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
Date:   Sat Dec 13 14:46:56 2025 +0100

    doc: replay: mention no output on conflicts
    
    Some commands will produce output on stderr if there are conflicts, but
    git-replay(1) is completely silent. Explicitly spell that out.
    
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks clear enough to me.


commit 03d7c9c457ba68f28269dcd607b9026ea6c6c9c8
Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
Date:   Sat Dec 13 14:46:57 2025 +0100

    replay: improve --contained and add to doc
    
    There is no documentation for `--contained`.
    
    Start by copying the text from `replay_options` in `builtin/
    replay.c`. But some people think that the existing text is a
    bit unclear; what does it mean for a branch to be contained
    in a revision range? Let’s include the implied commits here:
    the branches that point at commits in the range.
    
    Also use “update” instead of “advance”. “Update” is the verb
    commonly used in this context.
    
    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

As to the title, "improve --contained" hinted me there is some code
changes for behaviour, but there isn't, so that part may have been a
bit misleading.  "improve short-help of --contained and add to doc",
perhaps.

I think the problem people found in the second paragraph is because
it is so unclear what it is talking about if you read it without
looking at the patch text.  You started from the existing "advance
all branches contained in revision-range", taken from the existing
short-help in replay_options[].  But without seeing that "branches
contained" text, it is natural that readers find it hard to judge
the validity of "But some people think that..." claim themselves.

If I were writing this (but I will not rewind 'next' to do so),
I'd say something like:

    replay: improve the help of the `--contained` option and document it

    "git replay -h" explains "--contained" as

	advance all branches contained in revision-range

    but it may be unclear when exactly a branch is contained in a
    revision range.  Because the command updates a branch that
    points at a commit that gets rewritten to point at the result of
    the rewrite, "update branches that point at commits in the
    range" says what we want to say more clearly and concisely.

    The "--contained" option has no description in "git replay"
    documentation.  Use the improved phrase there, too.

probably.  In any case, it is a good exercise to see if the proposed
log message can be easily understood without looking at the code
change.


commit 9ba08b30a117e6925a9e5e87c92b37de7396d3a4
Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
Date:   Sat Dec 13 14:46:58 2025 +0100

    doc: replay: link section using markup
    
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking good.
