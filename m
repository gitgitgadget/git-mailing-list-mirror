Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83730FC34
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074996; cv=none; b=e5irSqNl5tEX2g+W+x71tNqvnGAW7TAX8DIhQ8A9NXBTyZ3Tn97YQp6q9trHK/FdEy2GFet2CBovXC0FxOicHE/7QKUFPunpITrPpEV9302ZRPDH41IsrAjvUKXm7BFXYUiTBvZKLaZk7z7FQHlIa77ZPI11wgRqnTirT3xf8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074996; c=relaxed/simple;
	bh=XsVxjud8Rl+xiHZ620Co5P7BFwmrZTagEe1dO69GmKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFTlb/x9kvHymRuDcePLQ947yZ67muwIeZEI9ZutJ+2+fb8HV4iBpwKdBs+ALst58dG30cCXbSAxUjLT+Wqy4+5KWGuVnPE1BTtL+I+Ta/eH+pXLHd1z3MahK4cHq6/x9P+2FFmH1PdKszaI/fNT7v2lkM/or03s2JkYCw7FEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rucIyTrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+wA5lWH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rucIyTrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+wA5lWH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D1D11D0012E;
	Wed, 10 Jun 2026 03:03:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 10 Jun 2026 03:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781074993; x=1781161393; bh=AMD0eAIdjx
	GWG4hEL8dzT39nXrLN8saPgEJzJlTunYQ=; b=rucIyTrQ3SeDFp0PQDUQS+fMet
	nZB/7A7rh7RV58iEEKFGr0oeueDVfq4TZiU9Z2Loy+4adpdksJcuxkr1C+9/B1ON
	DYqVeCnV4eUlltaUsqZqFoens6VhxiYgq6E/dboE7TbBi0g8dFzNG1uQRp9GD61N
	kSCyQOlqDxYK6SuTdjHelc0NWqSWrFe287S2LLGQooilTZKXcD3gEQIfw+71mJZJ
	tUK9PKpqTGEAf9+v7v4/eUgFMV3HvRd3A7DUQs5LEkjvQM/Tt40vIuvgsNlNu4Fl
	9taguXU0cPm8uTE9d8bzucPP/Nup03WJI8sBjOwJDNpRDnocGa/GyZGI2R3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781074993; x=1781161393; bh=AMD0eAIdjxGWG4hEL8dzT39nXrLN8saPgEJ
	zJlTunYQ=; b=B+wA5lWHthAZbybYb4H9REHbU/RfBhkSFBJcOrYHDzBop7Qt58r
	2ya8rw1Brx2JaCbpskahA6Os5ZBj+T1IHMSpZ9hsbug2PsFGxW8Phhi7G44fYYln
	3/RJrP6LglxHP94zaUMzU/Qnbimi2vI7ZqZOzvmmHm4TlY2R41XzWcn822vYEtir
	WR+NNF1QrhRd1B3odGsvWcvf/ktH6td9w/ipcZeeJfDOb0of6U/VrZC6ElVsYdHa
	jUTEQ726LURqfsIY2Ghkwy/Ve3ZPNW709hhjFkpvGkLDcoH6U4NZIx+WHmH0P+2Z
	KXqb9J998IdFVsuuX3ZJTwh5eI5Yc24tpfQ==
X-ME-Sender: <xms:MQwpauvGXFS-J-1FfzPDtG87URAwFkDOyEx1jhEq2G04ifMY8Pr3Sw>
    <xme:MQwpalvYqW-DpXdWazDwsRmCSev70KaiM1vXNQgjHasKS0mydwDKmBnH8-l3PdG8j
    tsG8fWkBc3eHGBRa8MAA167hk0pKALPbuG-GzpAqQ0NGY7AxuZrAYE>
X-ME-Received: <xmr:MQwpasC82myYqpQtJJRHqrfHxyc1AdEFaTk4BCrURNNi973XCnIM3tIltGRBZWrNfFlChgrIH1pFIOnIty1iT41e2AKV3FWuUf4UsW-tmA>
X-ME-Proxy-Cause: dmFkZTGeHKzz+Dow2zOi8oOGSHGkrx3UL2rAoYLX8Mlca6P7E+HkdJmVbt/qpWQOzl0OnG
    0F/H456rJlVGHGgXvDZRULZnPFawrKMt97Jkg5+6c/4fHDz4nK8KJaI0NBgYHVB7pFXb+D
    ilGjDfnkLJ7Ko1uKiWVPjQlzz8T/1IP0V/jqk9BlPSgW86mWZpdizt3rVrMKVTCerfN9Jm
    j8TBJs9N3aOSUciyVpg+KkE3skdDBAmjFNf9Fbt9C158JbIL43WR9s9NOPvqiVPCuc6oNf
    ZSPZ3fsR3aeyEkgMm3PgFYWJh6vhPQLAs1NWLhGF16R8fMqsVlqqngmq1XbI3Zf6ruJqQj
    m3mr6WAtaaDWVT7weFMlomxphIdzjvlFMxY1r4y6ZKytmdEOB4qdM43Syn8yk1DuErEepW
    vQcHN5bLGuxAFQ9f78cquGmx1PcbncYqCtmwF2f4d97t21piMmEgTcWgY+OiZsxY4kyNuH
    Q80BxSEJBq/TeGF06mmIBqee0wGex7iSZglgT4ck9jVjwqOlyE2bjyk0lsDpMIHNy5wVfC
    RhxwmqokZavOQ/AyA8xspkJf5gcVHiV4E+fA6wzfkdx4nHvcgS/fYLIjQXNTNTE46kaDZ1
    XKleudxW8s9zbNTUhkOU3FTnp20CXng0qiphaXy46hvEL6+5rC431vVBKO+w
X-ME-Proxy: <xmx:MQwpavNLZu6Vl734RGA3GWhL6PI_iCgLglFnA9JPmx7HKOXDlJakag>
    <xmx:MQwpatx8g29VQsvxqvOrW7Y7yWnRlAqWiCI06Ql5PeGlIPZrcHQF3Q>
    <xmx:MQwpanUxR9KDtHffN47MsEmmm5cgIhNdg_uLnypokeByeY_sLBLqtQ>
    <xmx:MQwpanOIdQBTnfJ-cfsiuAOtLbazh9yYmT0Au9qphJ4J-Bl1cBoW7g>
    <xmx:MQwpas40X-Hsk8y2dhzdQbFBb1ZeDziRNRW6m5S3YK4D0sqO9OkrBckv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 03:03:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ce38c48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 07:03:10 +0000 (UTC)
Date: Wed, 10 Jun 2026 09:03:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	cat@malon.dev, kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
Message-ID: <aikMLBCC9Rc7q9S7@pks.im>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
 <xmqq4ijbsn2m.fsf@gitster.g>
 <CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
 <xmqqbjdj1q1s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjdj1q1s.fsf@gitster.g>

On Tue, Jun 09, 2026 at 12:17:51PM -0700, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
> 
> >> > I wonder if we should check that the committer identity is unchanged as
> >> > well in case anyone is using this to fix commits after committing with
> >> > the wrong identity.
> >
> > I think that if you reword a commit committed by someone else but end
> > up with no changes I want it to be kept as it was.
> 
> That depends on the reason why the feature to "reword" the commit is
> being used, and the use case Phillip is talking about is a bit
> different.

So the answer is "it depends". Maybe we should do handle this the same
as git-commit(1) does with its "--reset-author" flag?

Patrick
