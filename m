Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8D338F29
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608251; cv=none; b=oYVSUgtroFw7LD8k7mP1ZU1nyQTG5XjraTL855XRBSbuW8KUB4usY4Kv2zM78rcQAFcY85EeRNC1rbHD9WG1HRowSUhj/MBQ03oieoOQvLHV2WqbkeH6cxFxmd9fMcC6x/9yNLeTC7ZJAfiip6MRrB90qseU3f+u+/ylJt0XLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608251; c=relaxed/simple;
	bh=a+f4Q4rUZ/o6d0IoXS3bpwkI/cC4iC48Y8SEk+Fhd7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rafrass0zGHcTWODaqX5E6mdIjj5eRseqgg8p/aJ2Y38PN+13KTjXJ/+2ZPMQfLMPQViMLvJRAf36Qg9t/11hMXvesaQItXLCMAaJddGMWlcZ9vxXPr/eUSKnIr7udUxlfaXx75nHbVnLKm6v2qOy4cg7ZvO0c8d4/Glb1p2dOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=pNvJ2OGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cIaZtgNZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="pNvJ2OGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cIaZtgNZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B198BEC05F7;
	Tue, 19 Aug 2025 08:57:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 08:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755608247;
	 x=1755694647; bh=LKXy++V02eTfoMBXFpYWJ24L9co59xI7iXkkl5XjtRc=; b=
	pNvJ2OGokuoiKciWbA0rIbT2llcJv76tu/PvKSqlhMWp0dmbG2Fs1QHl8Nc9RfXT
	wVJ9w7mYZTc8MISzZrM8wCWAWN59nE6tDecYGcHw1va1GY7GfD/abDjRmMKv1i1S
	sVWDcH86YAhOfZgZiV4eI9mbsioadYHMOlX/fJfK0ZotkVlOE9RQTA9L/rH3DtVT
	/kbznYkyrRHYhMHNvSUnV0iE87W8y7C+Svocy3zSOz7EOoBcTI6fViWerxCqPnQh
	eWF6ph2hANj4OQ+Uf+2lm6e3FiCIUcA/EPCppa1qBjpQ4FklQICStyHfhTa5hIN+
	zwY8zJxRhvnzbWrXeLmU/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755608247; x=
	1755694647; bh=LKXy++V02eTfoMBXFpYWJ24L9co59xI7iXkkl5XjtRc=; b=c
	IaZtgNZqvrpktI+YbG+KBIOYjUDSHl5FKdY64EYf4ZgQ/U+nqFvtCf86UoXD434P
	lzCDlcvzOSHpWF6X7567Ksyi7birD99j44NSDA0ZmLhtzDwgb6YRnfynzlUTwyXw
	TaLGi6gg+j4JPOQ6XyMTUT9L2LQYJ1e6EJHB8CBa+7A+/x9o/tKgZ9K22LA5YADw
	7QWJXAS9cduHZxzTaQYEt/1Nxmn9mdhrEZcSfOrkX6aFoxC1A8T3kAFrdi3VV6Mw
	5Y6ko2hhTNYa+5U8uacOi27Cy4Ry1acYjFiEDKjDN82puZdX4TSdxQukvW2g/0LI
	5ea3SPHo3lBroc+IxQRLA==
X-ME-Sender: <xms:t3SkaOx9rp3rJQ8qmqX3S5qxDnG9KC65te8s1zI5fGlSlZE-luUhdA>
    <xme:t3SkaKTB8-1cimOqwwbR7-xD-UVAzmMzBjfWSE7WyB94cs4l0XwuMW0zT-eQIdsnP
    mrzYyS5nKC8E1ymS2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfefteefteduudelffehueefgefhjeejffetudektdevtdfggedvgeeukeffuefhnecu
    ffhomhgrihhnpeifihiirghrugiiihhnvghsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgs
    pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t3SkaNMSICFEytUxdvzefAn5_DVkgforoIcDrddaYGkC8zhYj83Yaw>
    <xmx:t3SkaAtli6Yh-k6vl9rLMJyX3-Mo6Z89VTxrwda1tgGBxFMJDpK9BQ>
    <xmx:t3SkaIYGdmUesslsmliUzn1zdQ45IuPjBWqZLibAYV60EdWNUjus7A>
    <xmx:t3SkaKyhrYK3PgUBMQ0f1bf08u_CDxn8-M25ItU03dfTCTOy6_djhg>
    <xmx:t3SkaKlTi8wgmhm9F8VvmMKw1jfBa-jaQ6lrzEXkYiLU8mdHCWRiDgnH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A1ED7840B3; Tue, 19 Aug 2025 08:57:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOSFC39IWGa7
Date: Tue, 19 Aug 2025 08:57:07 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Chris Torek" <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <007dd7bb-352e-4682-8ca2-8256d9a47e07@app.fastmail.com>
In-Reply-To: <xmqqsehspdtr.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
 <xmqq349ty254.fsf@gitster.g>
 <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
 <xmqqsehspdtr.fsf@gitster.g>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Yes, you can lose your novice status and it is hard to take it back
> ;-)  I agree with you that the next best thing you can do is to see
> how well folks who still have that status do.

I've returned with some data! I got feedback on the `git-add` man page f=
rom
13 Git users. It's a group of pretty experienced users: half of them hav=
e been
using Git for 5-10 years, and about half for 10+ years. Even though ther=
e are
no "novices" here, they still provided useful feedback about what's conf=
using.

Here's what I took away from the feedback and a summary of the comments.=20
First, what I took away:

* The term "index" is hard to understand even for very experienced Git u=
sers,
  and even for some users who say that they are extremely comfortable wi=
th Git.
* The second sentence in the man page is too long and hard to parse.
* The "(quote your globs before the shell)" phrasing is confusing.
* I thought mentioning that you can use `git reset` to undo a `git add` =
was a
  good idea.
* Leaving something similar to the existing phrasing around "snapshot" s=
eems
  fine, nobody in this group was confused, though of course this is a gr=
oup
  of people who already understand how `git add` works.

Here's my summary of the comments on the existing man page. I collected =
them
using this little tool I built: https://text-feedback.wizardzines.com/gi=
t-add/.
I'm happy to also figure out how to best share the "raw" comments if fol=
ks would
find that helpful. I've quoted the current man page text for context.

> This command updates the index using the current content found in the =
working
> tree, to prepare the content staged for the next commit. It typically =
adds the
> current content of existing paths as a whole, but with some options it=
 can also
> be used to add content with only part of the changes made to the worki=
ng tree
> files applied, or remove paths that do not exist in the working tree a=
nymore.

This was the paragraph with the most "this is confusing" comments. Here =
are the
main themes:

1. 7 people (more than half) said that they find the term "index" confus=
ing. A
   few example quotes:
   * "updates the index" sounds like it increments something"
   * "Is the index not just the content that is staged for commit? Do I =
as an
	 end user need to care about the difference? I've not heard the staged
	 content referred to as the index before, even in git command outputs."
2. 3 people said the second sentence is too long and hard to parse
3. 2 people said that "It *typically* adds the current content of existi=
ng
   paths" is confusing (What's meant by "typically"? When does it not do=
 that?
   is this referring to git add -A?)

> The "index" holds a snapshot of the content of the working tree, and i=
t is
> this snapshot that is taken as the contents of the next commit. Thus a=
fter
> making any changes to the working tree, and before running the commit
> command, you must use the add command to add any new or modified
> files to the index.

Nobody said they were confused by this, other than continued confusion a=
round
the term "index", like:

* "Why quotes around "index" here but not when I first encounter the word
  index?"
* "I'm guessing index is used through git man pages and staging area is =
a newer
  way of saying this =F0=9F=A4=94"
* "Can we just say staging area? I don't think of adding changes to the =
"index""

Comments not related to the term "index":

* "Would prefer something more direct like "git lets you gradually build=
 the
  contents of the next commit by adding things to the staging area...""
* "I wish this came first in the description."
* One person said they appreciated "you must use the add command [after =
making
  any changes]", since that confused them when they started using git

> This command can be performed multiple times before a commit. It only =
adds the
> content of the specified file(s) at the time the add command is run; i=
f you
> want subsequent changes included in the next commit, then you must run=
 git add
> again to add the new content to the index.

No comments other than "Can be improved to be more clear."

> Ignored files reached by directory recursion or filename globbing perf=
ormed
> by Git (quote your globs before the shell)

4 people did not understand what "(quote your globs before the shell)" m=
eant.
("Does it mean that I need to escape glob quotation marks?").

> The git status command can be used to obtain a summary of which files =
have
> changes that are staged for the next commit.

Nobody said they were confused by this. One person said they were happy =
it was
mentioned, and one person suggested replacing "obtain" with "get".

Things people said they learned from the man page:

1. "I did not know that the globs would be treated potentially different=
ly if
   expanded by the shell before getting to git."
2. "I never knew git could do globbing."
3. "I didn't know you could remove paths with add"

Things people suggested adding:

1. "This should also document how to undo the effects of "git add". I'm =
always
   confused between how best to do so between "git restore" and "git res=
et"."
