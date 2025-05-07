Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5462101B3
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601129; cv=none; b=LUxroa0rekyWkHWtywbRT8pTIvFZybf2FbII5a0T5AeDtVA6h0YqROKF5WotPdRHcpNtUswPexDLYcZ3JLY9zagMwRnCS+SmVR8eBCDBuxcNQWWxI5+Rg6Viq/v4BejNzIXGRarzRLQRCKdg9vH1Vm6gOZncT0EKVM527scTVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601129; c=relaxed/simple;
	bh=Z/WS6nCtELKW3C1wsKjzJOH6z8Mm5JlBibja9sE+eOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVjPdJVpKr0Gi80ZoWT4ZCegYvlyfUU6oIYl027DyXQqrXYYOACDKH2wiASyJnsm065FymO+wNySzCZ7vdvotMdKoGHVjXMsgf2Ey/qxOyjyviedVyWdooIzUpxxTQBAEdo544886tpFui/Q9bfVLBnUyW2e5soGitUsFd/Km2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JqR3a/Ya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yl4COVrM; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JqR3a/Ya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yl4COVrM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7043B114011D;
	Wed,  7 May 2025 02:58:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 02:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746601126; x=1746687526; bh=Yr4E4PMoTP
	NP3QKchKioZAwu0SZ2uxpzH0tsM5niAKc=; b=JqR3a/Ya+AW2TFkzrQro2KWLWs
	2mlARMFKIQQlkGfIqYqFi92htpk99xG0jK4y5t5Wqpy0iDqxObTmLvhcagMXW5XI
	2myUwcZ6en7WXuf2NXnvSTw1JzvDWQGOj0JuL3RFC14Ix9fzkzd2VKBgnmYshSYj
	Q9Dq9WGH++NXmXtqcgaan/hrHj/gBaEbCig+6GD6bYMw/LQ10vXiRjsvJwEJetTh
	nanJSl13vUFcM+UndRH02YsWdKfCunOQEbTBL1Qx2aMhsgzoMk92hAN2D4P/JojG
	JhQnFjuOboOioPKBJJbdl33QKoz4NOKog0pIiQhcjmUYAh+dDanbcb2HmWlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746601126; x=1746687526; bh=Yr4E4PMoTPNP3QKchKioZAwu0SZ2uxpzH0t
	sM5niAKc=; b=Yl4COVrMRmOt/YG1ULwwTXzYpWpZ09NhQji4pF8i4v88VtS6MBD
	g3oVEE/szfXxOmjw3fxHT6tZ/o/RXuU7qjH9yPCYHAZdjogmHSOp6emMOvEQHdTV
	KUr17Fc4fQOwKTSrMHNzRoPuA1zhhnknddPP3gWbAob1PkpsvuaL//ovjbxeimcy
	y5mSA+IRrhp7At/740ItU2Jlm5HXbfnD/5J5Cc3GTjQKmdOzhUM7fjvJJpOFQZrx
	XRwVaFcJpw/zTMANUaJjoHitSmNLVMJ3IsW4tVOEqq6PY8hLl8JY2t6c5qgw8ki0
	L66NkCOanJEsISMMbpW/kysPj5wtdBwOgfA==
X-ME-Sender: <xms:pgQbaMdavRi-q8HsrJubpnaaqRCx-1muA22pO1xgj35rLVQKBLOUrg>
    <xme:pgQbaOOMmDGoPcjG3TNGzFVJMa81xvoJ11JT5cr-6kdbWGVwqHuYAkR5RFvmbOluX
    oONYgjBr73-O-3Aow>
X-ME-Received: <xmr:pgQbaNhGLN8QKdzzwUG6M7HYrldo73s81ewQV_uuNq_KO2NcKQRgi_Y3C4-l1jUWPPvBQ8sGExtqedy9t0XOPGmW9gibPmAJHzsisBXIwHUQLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:pgQbaB-mg7FH6hf2mycaS_Yse3JbiI6p7uNeCAeqEdZK3XymTiVBIQ>
    <xmx:pgQbaItZJR8YO_hm6N24BLq8UaUtvDpYMpb1UNlVNCezWKoddX6HgQ>
    <xmx:pgQbaIGeZGiWcJPJKdCm7FMwi8reKrnoHr6do1ZJW253EOgRyQWUgQ>
    <xmx:pgQbaHP0yEjeFDwVPDhIGNCeHH1kEBbwXGf1b16PCvdAyiBiVt6PDA>
    <xmx:pgQbaIdkst7fRxbuMe5wba9N4L8afjO2fTYknEd1Up1RFeN-E2rVYQUS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 02:58:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97fdf648 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 06:58:41 +0000 (UTC)
Date: Wed, 7 May 2025 08:58:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] contrib: remove "git-resurrect.sh"
Message-ID: <aBsEooYbNl1cjlFO@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
 <xmqq34dhijnq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34dhijnq.fsf@gitster.g>

On Tue, May 06, 2025 at 01:11:37PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "git-resurrect.sh" script can be used to find traces of a branch tip
> > in the reflog and resurrect that branch. Despite a couple of global
> > cleanups, the script hasn't seen any activity since it was introduced in
> > e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
> > resurrect it, 2009-02-04).
> 
> A single-purpose thing that is done correctly on top of a right
> abstraction does not necessarily need further updates, so I doubt
> this paragraph contributes to the decision to remove the script in
> any way.
> 
> Having said that, I would not be surprised at all if large bugs
> still remain in the script.  The reason why we scarcely heard
> complaints about it is due to the fact that people simply are not
> aware of it, people do not lose branches too often, and when it
> happens, it is crystal clear what needs to be done with the output
> of "git reflog HEAD@{0}", once people learn about "git reflog".
> Even though it may be tedious to inspect "git reflog" output and
> pick the right record to use with "git branch" to resurrect, as long
> as it is a one-off thing, it would be more assuring to end-users than
> some rarely used script with no correctness guarantee magically picks
> a commit to place on the "resurrected" branch tip, I suspect.
> 
> So I personally do not think many people shed tears if we remove
> this script.  I am for its removal.
> 
> Do we have a better alternative we officially support, by the way?

Not that I'd know of, no, but I also had the same thought. If this was a
common scenario then we really should provide an easy user interface for
it. The question is whether it does come up often.

In any case, the best solution from my perspective would be to stop
deleting reflogs for deleted branches, even if only for the reftable
backend. We don't have to worry about file/directory conflicts there, so
there isn't really a good reason why reflogs need to be deleted with
their branch. I would even say that it's counter to the intent to
reflogs in the first place: the intent is to restore old versions of a
specific reference, and I cannot see a good reason why a user wouldn't
want to do that even for deleted refs.

If we did that, a user can trivially learn about the old state of that
branch (and even states before!) even after they have accidentally
deleted it. Just type `git reflog show refs/heads/branch` and you got
it. There wouldn't even be any extra need for a new command, this feels
simple enough to me.

Patrick
