Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BB29A1
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340439; cv=none; b=fX+Zg6crn7+8OIgSylJeEDpoYfcpf7H4mdTIIyaDhHOK1oe+ePr4mxlq+4OnGWs7p5gwqe1Wu1/4tiWcaJWJwsOyN63k5Qgil6giZ1VXBksMZDUrDcnGfomf92M9pLhhc+u2PRZbJ3LyqiUYQGuU38rpxRm556nV6dZF1iXirtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340439; c=relaxed/simple;
	bh=38+3zAi8UTbZdoXbZqiYjZqIb9zoqzU1v1EcHJ8regw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V+d4Kq7/SNqCgjJrYev393MTscbUUhbjdshEbDkgQWf3j9f5ajtGELHZAOG+8kl1JYc1RBIdNxZYcYX5s71acj7BooLhol/UpUSbwXSfvdzv0lV2M3JES/Z2S08i62VHPPqqTi6Q0l+MMR/5LnZAr5CKMV+YUkAcLcBDDAJrjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EPbQmRYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xEaI5uzj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EPbQmRYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xEaI5uzj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A412B7A0103;
	Sun, 25 Jan 2026 06:27:17 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 25 Jan 2026 06:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769340437;
	 x=1769426837; bh=38+3zAi8UTbZdoXbZqiYjZqIb9zoqzU1v1EcHJ8regw=; b=
	EPbQmRYAurBfTHuKOgpPu32pRAz14q6FxR8dmwwKv3ZuyLaACYl3TPNYJQhU0B4o
	AylptOGheoWjTXI+b2dwtnxSgtZb6R5fHU09I3sy0YyQRmTNtFCRzZDZB+XfuLpk
	SgrZc4qqK3nfIbQZJfHZ1SPlg+lv0NDT57Lc68KRBrLSQCxFuDBes+247D5zwZrt
	x6oXuCoA6o0stzbPSU6aYt5btlracEfCBqYg8LctqHUfODBP7JcTGxO0JKMbmjvh
	sG5X8PMPVNAmIuDIQkij9BBQ3+RKt9E3L9skD89VxJI7cQmDvbTVUSJac9ijvScI
	kR5MbXzmYyQDXSrFvTnmzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769340437; x=
	1769426837; bh=38+3zAi8UTbZdoXbZqiYjZqIb9zoqzU1v1EcHJ8regw=; b=x
	EaI5uzjqnfXDf2+dEr0Zbpd2v/cNCzyPRd83rb6ZEZ7HwyE7Y1Vs6Ec9vAdu2zgr
	KJU1I5OOhJj9r9wQLM2PICavc4NQ2fCUzfiUEWiiI2Ky3gAzzsnG36YGKPDDkQVe
	oCt4j0lwzei3DILubXAIxuD6q/4PjR7nsIGcxXLOysaRzK3T12hqOkPBzx95D9lC
	vvxB5KduK8UbrgkydOoJOvMMm1zNtGUTf/Qn80RB624Rkf0IiGdO08P3oCsPYX90
	qRbq2pnkO8jhpS8NdMr+6VXkiohUvdZw6KwrEvn89EK1YnApNINOAXub1DhTmDdP
	odfDYoMjFsCfBcTN3QFQQ==
X-ME-Sender: <xms:Ff51aWFEBKUUa9kQVfyOrK15sY1_LwrrIscZjeqitUXMm3B6GHbAcYc>
    <xme:Ff51aSIXOxs4KFhjo9H9FY6CYeAqmcNoG0qbeKnrhJr91U8Emfvj6l82fyWctORKw
    uh97mRSM5X9WJY0nBEHiI9mprZZKHTV44qZnXh9RH-XSyUYB_0O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Ff51afA-aDapqZI3Mxu8YeH1Ff-gvYCA4wALzyIYIfWLHyBX7U7iGA>
    <xmx:Ff51adTv-OBAfSnwI6Hc2WqINZh_HUw-qpRY66oKOHIzTUb2S9EXiA>
    <xmx:Ff51adoQSMuf1ZtZrFeBiA5FAmtc_qHjxAcO15NaeL4oP6TediiPTQ>
    <xmx:Ff51afyJXOwMyEQrnxV5QkoNSpJM21XUbrQeBEWrc6bqWVSBoi8Z-w>
    <xmx:Ff51aRkxND5iFWEimgmodMAnC4SwfNWKO0hrlX0w9ziKN26zxlkOQukJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 13BBB1EA006B; Sun, 25 Jan 2026 06:27:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4LhpniH-T5F
Date: Sun, 25 Jan 2026 12:26:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Message-Id: <71c081da-e5de-49fd-a5fe-b61503e19eab@app.fastmail.com>
In-Reply-To: <aWnkJ_GpgbXBPwFp@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im> <87jyxjjejz.fsf@iotcl.com>
 <aWjVWC71rFeTsHLP@pks.im>
 <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
 <aWnkJ_GpgbXBPwFp@pks.im>
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more than one
 revision given
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, at 08:09, Patrick Steinhardt wrote:
> On Thu, Jan 15, 2026 at 03:34:50PM +0100, Kristoffer Haugsbakk wrote:
>> On Thu, Jan 15, 2026, at 12:54, Patrick Steinhardt wrote:
>> > On Thu, Jan 15, 2026 at 12:33:36PM +0100, Toon Claes wrote:
>> >>[snip]
>> >> I was thinking about mentioning something like "commit-ish" instea=
d, but
>> >> I felt "commit-ish" isn't a commonly used term toward end-users. L=
ooking
>> >> at gitglossary(7), it says "revision" is a "synonym for commit". I=
'm
>> >> happy to change this message, but I'm not sure s/revision/commit-i=
sh/ is
>> >> the best change for this.
>> >
>> > gitglossary(7) also defines commit-ish, but I guess you're right th=
at
>> > revision is the more common term. I'm a bit surprised that it's def=
ined
>> > to be a synonym for a commit, but oh, well.
>>
>> Surprised that =E2=80=9Crevision=E2=80=9D is a synonym for commit? Wh=
y is that?
>
> Because in my mind a revision can resolve to any object type.
> "<rev>^{<type>}" for example is a revision, but it can resolve for
> example to a tree if you say "HEAD^{tree}". Still a revision, but
> definitely does not resolve to a commit.
>
> Also, it's confusing to conflate the way to name a commit with a commit
> itself. "HEAD~10" is a revision, but taken by itself it's not a commit.
> It's not even clear whether it resolves, so it feels sensible to me to
> keep these two concepts separate from one another.

Maybe I didn=E2=80=99t read the context well enough. I always read =E2=80=
=9Crevision=E2=80=9D as
a generic word like =E2=80=9Ccommit=E2=80=9D. Not as the gitrevisions(7)=
 expressions.
