Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA3AD4B
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822260; cv=none; b=e8l2Q1WKMn9EAslMtrPDRj6RtBF2CefIEJiqSim1VQZDad/k3aof6yP/SJGJjzbQyI6vBAAxl9WhJVfxJkq2DbiWielGiA8vqwTfKCRY2NKFZjlFmJAr1rdFLFnNN965lilEy6V2rvYa+s6kAtvR+Pzm+XqRb6SjiO3q97XN2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822260; c=relaxed/simple;
	bh=+k252ohxG1qFlqUhNpeXP6WfnCq/h9X3GA88iSPO8lM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=ux0izst66h3qu9dB2nNkiek2AK9l8c+qvV+I4avVbgG+ENABpc0/HhV9oOAGDNY8A+cyON63qwiGR7m0bop81Wf8UYl3Ntd2omoFz1kq13MAFkxGcvqVCxtHZwKfX4Zwht3TGqo4RXnMUb/+1Vfu53AhgTy5RqOhthRXZKd3BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kcRT0wpK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLcE6hZv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kcRT0wpK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLcE6hZv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E76A91380A87;
	Thu, 28 Nov 2024 14:30:56 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 14:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1732822256; x=1732908656; bh=lK
	GgzIfhiT1GNidqVpV7KK0+LVaKVdPa6X3zGuBubpM=; b=kcRT0wpKGTjmTuSmxC
	ErjwHa+EjWXYXTq/g6WEK4BxvV4H02gjSJXCJrfu2sCRFHkQW4xXPkUIlZMEOmxm
	NBDMKhRrAClAidRXe8KpLMs51ufjs9UuBoJFbKbRAcfBoDfpgBb0FgenHiJIwW3/
	/ov1plDpaar8DrfBjWifT95XqlGUdqsX8nVjDnY6lsPjSRKFUBfGHwYOuo/jtjGU
	qAh2zMAJfJnWkpZJGcwb1v8uY8cDyp6i+Rd/dkH+MmhSwrkEfehDbL6IOnKWVjf4
	zy5Q3+1MojRMBjPTrI2Dwq1ikRp9vgGOVCZB4E01Hed4UAwUdJ8C9ZZHL4ojIKtV
	Q4Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732822256; x=1732908656; bh=lKGgzIfhiT1GNidqVpV7KK0+LVaK
	VdPa6X3zGuBubpM=; b=mLcE6hZvejXTxgGzW5jecb52FoLNEFqbfshM2IQ3nu0n
	HQEjCGXlDhQ5f1da5HJDGux9xDYeNBlT/gjqg3/AN4g3pnqgwXJ7s8XWKda0VHNm
	MheKvMylgDKoDhDUL3hE+5cjGapK/0qjnjTWzCnkT3t5826mRDx6V/D/TrYhj7i+
	po5ECKWGrd8Hk0dRjbyQ77ehtf7Ec/nfnNu/Uk5NAHpCNAZs6nvSWDIrgfiZKSKA
	XVwEiauEzN9/ruWpT55ZIOJFD5JgxB7Q3PlsuA/iVbPUG0C9Voe+afYCF/oUhlsK
	KUeLmULTW4qrMswaT53RzOOuH28TpHruvsiYTYDQKg==
X-ME-Sender: <xms:8MRIZ7F8R-mpO_I43XY8zJ5TUg1f1onJ36PGz0Z_6EYHqHQHpEOCc3I>
    <xme:8MRIZ4U5mUb9a4HlnBrCdjIaXGNeI4qzWKNt_-0ZsRkFpWpllQdKilZeZHSiXCod4
    vtwXcHNDbmxtVCfsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffjedujedtgeehfffffffffeejffel
    teegkedtgfelgedtvdetgeehveekvdehkeenucffohhmrghinhepshhtrggtkhhovhgvrh
    hflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:8MRIZ9JT5wwMZoNZxWP9CnXg9encQWyMG_JipwE5jmRx6HUvU1W7uQ>
    <xmx:8MRIZ5HISPog7AjWwLqO3Z49ytlbcnJkVekFVouIcRVPv6RSA4cF5Q>
    <xmx:8MRIZxVwH9XP1Co6QsVcTDMAYobm0nwRxz0mvY6e2VDoc2Ook1i5nQ>
    <xmx:8MRIZ0MzWAdFQFMkxgf18aBGnkiZSoj41ETlKFDI8K1Wxr0ptgvzQQ>
    <xmx:8MRIZwf1P59go4UrCI-6nHz1P7crKtyFW_vslHOkoWtfO_09ARlhE1T3>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3E2B780068; Thu, 28 Nov 2024 14:30:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 20:30:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <702d88e9-c62d-482c-a457-6d6642e8488e@app.fastmail.com>
Subject: gitrevisions: be more chatty about shell metacharacter gotchas?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

See this question from today (+CC):

https://stackoverflow.com/q/79232719/1725151

The problem turned out to be:

> You are using the Windows command line CMD. This beast treats ^
> specially (it > is some sort of escape character). You have to type it
> twice for every occurrence where you need one of them: [...]

Now gitrevisions(7) already has this:

    Note
    This document shows the "raw" syntax as seen by git. The shell and
    other UIs might require additional quoting to protect special charac=
ters
    and to avoid word splitting.

All bases covered.

But, and I don=E2=80=99t know why I didn=E2=80=99t realize this sooner t=
han I did, but
this part:

    :/<text>, e.g. :/fix nasty bug
    [...]
    Depending on the given text, the shell=E2=80=99s word splitting rule=
s might require
    additional quoting.

I don=E2=80=99t recall reading this part (only glazing over it).  I did =
eventually
guess that I needed to

    :/'fix nasty bug'

because that part needs to be =E2=80=9Cone word=E2=80=9D.  Or something.=
  It can=E2=80=99t be split.

I think I=E2=80=99m a low-intermediate shell user.  I get by.  In a wider
perspective, git(1) (i.e. in a terminal context, mostly) is used by peop=
le
from a wide range of skill levels.  Many seem to (based on the question I
stumble over) mostly be using a terminal because they need to use git(1)=
 and
that=E2=80=99s about it.

So would it make sense to be a bit more chatty about these metacharacter
gotchas on this page?  Maybe add a =E2=80=9CNote=E2=80=9D on e.g. `^` th=
at these here (?)
popular shells use `^` as a metacharacter?

That would for sure be redundant.  But IMO good documentation finds a
balance between redundancy and other concerns.  Like in the form
of reminders and localized hints.

Also back to this paragraph:

    Depending on the given text, the shell=E2=80=99s word splitting rule=
s might require
    additional quoting.

Part of why my eyes might have glazed over (I think) is that this is very
technical phrasing.  Yes, technical phrasing in a technical manual.  To =
be
expected.  But the topic is the revision syntax; all of us Git users of
varying levels might be primed for less terse but more evident paragraphs
like

    Keep in mind that you probably should quote the search string.  A se=
arch
    string like `:/fix nasty bug` could be interpreted as just `:/fix`
    depending on how your shell splits words.  Try to stick to
    `:/'fix nasty bug'` or `:/"fix nasty bug"` (whichever is better in y=
our
    shell) for that reason.

Because this leads with what the gotcha and remedy is about.

Thoughts?
