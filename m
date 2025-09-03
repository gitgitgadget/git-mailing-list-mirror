Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCC2EA48F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902002; cv=none; b=taO4hKIRjFhrePke1kI33mQqB4KTKW5uMjL8BCQ64QI6SaUzZyVUMTbYa5niBqk1zZoOd6xXmnguzW6aYnaCAxz2Iv/Xr0jUy3T3vhjWHizatV2dR/DLd613Miol+eXwsF0JgD0TvkHiYRG9fwHFv5ObkjfcRjmwj6X9qccI5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902002; c=relaxed/simple;
	bh=WSOHPJIUGgz/6WXXB2NTkMpzLuEd3zbRcUY/lom0CLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j401YbVf9FJOYntVpqpmOgZr2Zxqb+0ncxJzG5DuZGgOAnAFH33ZTkR5rWXiWqby0m95AsGAjvj8jAsdv+7wVt1NVOqDKU8G3bUozT8vMsEH883j4afOAF0L5aH0YETxfY8CWYqvTddWQyRSQPBelfm2dlgrnOBU1Dnrw/gdY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6l7dYw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJnNDgpL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6l7dYw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJnNDgpL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EF35AEC033D;
	Wed,  3 Sep 2025 08:19:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Sep 2025 08:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756901999;
	 x=1756988399; bh=DfXsTdGGKJ6m53kK7dn2eOeEgPqApXAZ5Twr+5SgAaE=; b=
	X6l7dYw3zHy8zBdkWZlbIjxj9bhEyh0Qj8U04WjGeSKr+1Ghrkvb/Un/jTZs2Dh6
	XqpQGKGJvPprEWOQpIoZtgkerB7ogGhcsh7EL3jDKZm1KbWT021/bysjCvAwJR7u
	Yvoi3SnVYDLjr1luHtlJAnfJ+h6YyrG88I95kQ4es55bVgXbdxTTO+Y+QLBsONkN
	HxSfzpyvVOSo16skMLZDcmzkbRxaXoQDewmMsieYw8xt5lUqoVJYbUCGSCzsXi/6
	KP2boQYkn/DbzkQd5CigzGNOXueQ7QAjBvv5E2aqhSw/+skLD/DJ5i/QB4THM4lP
	iVY0kLrJ0HLRfJ074TpE/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756901999; x=
	1756988399; bh=DfXsTdGGKJ6m53kK7dn2eOeEgPqApXAZ5Twr+5SgAaE=; b=Q
	JnNDgpLmKsPMVuvm1qBtlslz6GPUtdf/ej96JYthIoAfrBNuPvfcYze+1UPVHva2
	B6TDwwdLdt4RO9IOeEUqEqT/uGDZk1hD1IdReVx+fsD/T5ntLYWJS8VGMc9gAxuy
	xUcBrlLJvnQ1KEVmTOPnZqcyKhCYcG6kCee4kwEL4GFipN7kvirqhpLQWtAhcdY9
	H+JMUWI6UCrI+U8eUAb0H7CjG2MGwJvXWp39MmE3CW6DNVVkgk3mZR1oHbG1UdEH
	NPRnzLNEQ2IHR3fye5FYt9LLxwrNl7cQjfFRso+C+KryxK9o1YpUU0GeWhEG3VYV
	pTWGI/jvtxJNpXOTcHQHg==
X-ME-Sender: <xms:bzK4aPyiItt21ab7_FHCGG90OQFJ1kSrNaA_ErPGXBpg6Cj0SttdnA>
    <xme:bzK4aE2pwR8QCnpqc9J8Lk1hqr8GIUWZdhyXW_9vslJPQxKDFMhg7Z29EeN8yrtxM
    GFt_lcy7PJiTngCtQ>
X-ME-Received: <xmr:bzK4aPyxO-uOl5cD9icATq6OmmG4CBUMIN_9spjwH9Xzwa31l9rPLb1dutwxSmLdhLgrJQ2zR2ntNciRAlLxW05k4GomoHNbrihG8Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:bzK4aLEEWK5lTv_n-McKTm1CVeD2Q2-Mmv6SQetQEg2owfVBQQt9Iw>
    <xmx:bzK4aCZlKnNDy3QDYyZssWm1s3SwQWnukF4xXSofKqc50bYvBLBHcQ>
    <xmx:bzK4aNCQz8YhYWYvA6P2ywC_SWE0lZLpmfwmerLndTvasqiqBO_PhQ>
    <xmx:bzK4aKmDpJAiu174GZb-aCO8VVWN9KGPVMZyNH7lO2ZBIWPtwxWZMw>
    <xmx:bzK4aMqq91aHtfGX_Q3VIa-U8xReyQ6sozs4my-cMx7cNxur65xb5U_S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:19:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e884d323 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:19:57 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:19:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 09/16] builtin/history: implement "reorder"
 subcommand
Message-ID: <aLgyai6muTkG21FM@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-9-964ac12f65bd@pks.im>
 <CALnO6CB=ZPO33gz0qyCGrC6E2_b2S1kGZkLd-q_CS37gupvPXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CB=ZPO33gz0qyCGrC6E2_b2S1kGZkLd-q_CS37gupvPXA@mail.gmail.com>

On Tue, Aug 26, 2025 at 09:03:18AM -0400, D. Ben Knoble wrote:
> On Sun, Aug 24, 2025 at 1:43 PM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index db5b292994..b36cd925dd 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -39,12 +40,18 @@ rewrite history in different ways:
> >  `drop <commit>`::
> >         Drop a commit from the history and reapply all children of that
> >         commit on top of the commit's parent. The commit that is to be
> > -       dropped must be reachable from the current `HEAD` commit.
> > +       dropped must be reachable from the currently checked-out commit.
> >  +
> >  Dropping the root commit converts the child of that commit into the new
> >  root commit. It is invalid to drop a root commit that does not have any
> >  child commits, as that would lead to an empty branch.
> 
> Fixup in the wrong commit, maybe?

Indeed, fixed now.

Patrick
