Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485138F25E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565698; cv=none; b=rIQguwoOz7QuYEd2htlkoE4eaUGxI1ivi4oGhf/BccdHed1oPJ3M0M4fxPVatW7NlHxabBQDJzJ3wtruTIbLXjM1cOwVAWKBykjhHAyus85RyXW6E2rCZzXcIxhrYlco3ccnkAoepf8NbKHWSNgmvFLf4dVwGl+9tDzY7gZTT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565698; c=relaxed/simple;
	bh=IEwQsMY33iXBPmFrMLbu2FZOq5f3wLppO8aERuwMOME=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qfdRpz03IXkifxIGLIvSjhdVrvnaxO2s9apKgqeALtz0XYdLOvK6tYBIwc68XprzVQYZRFWywVrxU6To4rzircN/HlKUCYghNuTz7og6/879Un5yd2lA8XtOjGu8Ie8lt6nbGc6BLYoIESGq9PTZvHWVfWvvrgP6S+OH4OMTmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XR3lBHgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPd5+DCp; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XR3lBHgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPd5+DCp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0659F7A00C1;
	Thu,  4 Jun 2026 05:34:55 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 05:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780565695;
	 x=1780652095; bh=Oe4ivv4WATtiDGx+Ha1HcWYl0t0tP7ctCTTXuqJM6UI=; b=
	XR3lBHgLCtO5Aat+6GMHJtp9CJEo6Vf6z/oMeEZz01ZYkHZF3RgksT7i/fGJxPiy
	5diXcvJf4i+2PEcq2+NRIxa9xvO0vUnWuW3TO8zECXvKRtkXK9b0kMGHKSI8DD7V
	pLCNo3OuHmLf1S9WWq2NCCTSJmG73bHRqunWbNRSauk35jA5jjo73q/aReocuYfL
	Ot8jwD8g6Rb1p/11Ec2bV9dXgHCx9UimZkBGNDkjyGwaGj0j/51lcy6opHvdk+Cf
	AMHobOa1j/1+IbiG3/AQkvEtF1lYe4uYqcL4QGqOFDnqPQ/HzXZorP+0U1G17fR3
	ZmhuWWyygK3ejh2PBJA5sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780565695; x=
	1780652095; bh=Oe4ivv4WATtiDGx+Ha1HcWYl0t0tP7ctCTTXuqJM6UI=; b=M
	Pd5+DCpcvR63vc7YPOTlCRILRiwkepKxwcAefW8DtdEiIjIg5e0F6nmk8wRx0Mef
	5YA8hgpXTRcX9eM4+iiA9Oag0gejF3CxXJk9zrVU/Hj1VUVHnK2tJkpTxN0pgNUL
	1rKh9VEwLZ1Il2pOpDMUXWjaIaRQEaYZmtyrmB8gxsmeZcE8CUZYlsQfWMSTsgvH
	AIGUWviKnHq6u92h40pW+HQDlP50zY4CgTJJJXXGjg3/vph1HQbcqWjxVp5CwxlC
	fzylJ7AVF01DUsRzGwYQHj2s6m02biVFB3/QbFj9HzbGrxtIdtrMF8eNvtfKSKrU
	6T+GTmsBKWu5wSPD7kl7Q==
X-ME-Sender: <xms:v0YhavurSYRBs87X-mbAOiJJw6v45JBCSQG_FixL4E9ZPdDQBBUZLk8>
    <xme:v0YharSP1JSGltzeceLYfDw8-O3yF_a3itTtgifs4d9xhE2clheXg_69P3OcXRi7v
    4sVN4tn1AqrEdwMiduvCkNds7lJlU1ephTiTXOkII7N5m4xf5mrJIE>
X-ME-Proxy-Cause: dmFkZTFxUyYRtLNBR+jjhWGkJlYKDghNVE+GPBa8TDWLfYD+swgPZqSUvkkEwDZO/yvIM2
    /fE/pV1w2fhuTtWqx/+1YZva1NtOPuDQo8TXWaWLmPD4ZQkkiDfLEJybQbUgO12VzNv8kN
    905y0SQdmfZC2bYsmqie7WDJUb6fmV/AJjmD5zAs+ney6Wv/1OwqEt7zoCmtko5Ub5cBNg
    +L0osgdGuAFGk43FYZ1VBBcqMUudcKD2cNj2HnDenigRlJJottyG4PP+2Z1R/7cUTd5ZgI
    2RYA6nHfTZSeCyh41g0ad5kAsa0oHBV2WLykOJvJ6IGzd05XcSko2bZRctUHET18/gmBkT
    WNPiQOexcNr8ARPPmHD+oKbzleHuZXPgpfJzjRskRLGp9aHD2dPho034zINt8KNmqsfw+/
    GS8KfLDBrrMD8ER7Kdd/0aGnOO5JBJKA7GUNfdz0i7ZUkoMFr9gpOxKDEHJrKsojWVoPbO
    QVB4nTQCjgU5QIWTzmrjnyBl0rR0B8T4+Z+rvN9DkkyZCRm0dL//koBCVgi5CCcyzB/z6n
    FvusTGEjM3J9nd1y33dTJPM8sCjdgSrhJzo2/HX3hIRc5DBMxwzcX2hCp0LLsjzsyvksnu
    jwuxdTP7ltOVQUML8AhrO8wxC9qDmL1G3rnXxOWjsHesWKaG6r+NO83sqhlQ
X-ME-Proxy: <xmx:v0YhajrAtS5iRh3VoPijpAp4vKm610f-mu91vs9888g-2rLUkqylIw>
    <xmx:v0YhalZ4WZjWrpOUeadVSiJ7rLHRAhTOrMmqE7fw2dZjqrpyBdCfsw>
    <xmx:v0YhajT83i1tvLgB6FnS4Aj0VeUcEPzP3LNHdAzdPNT1PIpQEE7NnQ>
    <xmx:v0Yhak6bCYEatMrCMNPyEfNeHlhSl4BSgmai7iy67FqRbc6hCpaU3A>
    <xmx:v0YharPCw8oolEkWuoS42PnLDsz_6N5Jb7R89zoXRMI3c02vSZ2_uW-U>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E5E0302008E; Thu,  4 Jun 2026 05:34:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFuxotP96EDs
Date: Thu, 04 Jun 2026 11:34:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Rasmus Villemoes" <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <0299ea0d-a042-4457-bd7e-0904b38a219b@app.fastmail.com>
In-Reply-To: <87ecimhg8s.fsf@rasmusvillemoes.dk>
References: <87ecimhg8s.fsf@rasmusvillemoes.dk>
Subject: Re: git history feedback
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 4, 2026, at 10:17, Rasmus Villemoes wrote:
>[snip]
>
> So today I had occasion to put it to real use, and then I found two
> things I'd like to be able to do with it:
>
> When a commit needs to be split into three or more commits, it is a
> little cumbersome to do iteratively, since the new commit to split
> obviously has a new sha, so one first has to figure out what that new id
> is and then do another "git history split". For higher values of "three"
> that becomes rather tedious. So it would be nice if there was an
> iterative mode, which after splitting off the first commit would
> automatically start again with the new child commit.

For commit subject `anchor` I would do something like this.

1. `git history split :/anchor`
2. Split out the first commit with a new message; keep the `anchor`
   subject of the original
3. Repeat (1)

>[snip]
