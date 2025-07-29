Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252F28468C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771904; cv=none; b=FomgFUVap88NTnyo5qKLqmaa72UJBrBba5CB2hbKYV5vgpZO0lvBOnqvnu9rDUhOeTAGHhIMtQzbXRNHVcNC+ek3lU3ILphUtKbDGoaeclOYjvoF0N4FMUxlwinKRootUC+FKitJUQRcfwlAAIPxxjnjO8Nm6pTji5Xyh+vPIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771904; c=relaxed/simple;
	bh=pWdRGPp5VMIeYf7mSYeq7WuAuBxqVfrs5kxpteer/wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in2xHWcgdSWXzml/jQhHB74tlmnYMx8yfl24+SVc4vyTy5YYzXPAUnPZPSElPS7MalXimY77G8yiWrzRn67mDM4WzJaXZ6ThBJ5MG44MUb3Xq7+/nKXW7y+tRP/iybc9peFKfxaPAeIOLem+cWXQ1SUPUdjvSiyPIuXHw7shuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+Rkt2TH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJXckd8F; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+Rkt2TH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJXckd8F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A95B27A0093;
	Tue, 29 Jul 2025 02:51:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 29 Jul 2025 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753771900;
	 x=1753858300; bh=hCq+IBTsC+0DKwSQTBTkiifn0wX6R/W6nTHtN3r8/IU=; b=
	V+Rkt2THQaNuF2Ow6XXZGyxc16CpV0LsU6pT+o3vdtRa2xZqimWzOLxAlwt8HNma
	8cuLKlgWb4Bh7wLjKfeTZxzKmepOxHnY8ViMOlc14CVXz/Fkr9f6q7lxieSox3XI
	G0a0gqn009ssMADqbaBIU7tSs54bs0fFxzdCDbzSNsiHUXEZayhUh7rb02smiqTh
	QR27zPKp/1pCT9Uesu7LrqmyaTE+fbP9bbDaBYMWzoOjgoR+YVIIarrCMjum4KLs
	qnj/mrUqYsaTkTb+3eRB9pH0w3b1pXznCrsWjiGCygD5vc9XWGNuTYJvonjNC3WZ
	N1yYkqXjxHjwMYS9JzNbYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753771900; x=
	1753858300; bh=hCq+IBTsC+0DKwSQTBTkiifn0wX6R/W6nTHtN3r8/IU=; b=H
	JXckd8FrhMlYPHumiQSOPxx5x21Dz9r53chuHMqNz3dR9lGSChrS7ehe077rk2sp
	LWu7gedQhe1iZXfC7RAwnnqhvjpa9bNlXH2ytnZEGP2aUJe2aK5xn6roUxIFaUJH
	ryG2kNZPjSN8AJQ3zJIQZV7RD7uE0tKhumD8G/c3gg89Q/EfJHZN6KgP+fhrrVzL
	GIOx04OCy585n97A2AHyvC13hdEJjnqvuMe6w1/u0D9yqQO7PF65/LyvxneWAGz+
	Ci/m3qkxZWh8tvpg+3PxJWd7Op4YD14XGggGQXrK5+s026+0eJoMCR8L1ArMVRiP
	ZIg4fvnab4l03P17ofz8g==
X-ME-Sender: <xms:fG-IaMXMoHspiHUSBcNyXAdWqrGUVp2c7xKMs9dNUSap5hRHV9-UdA>
    <xme:fG-IaNjrmErwkdSq309Cymh-Oy6hN71u5hOBYgHqRNWK58wahxYzNQyjLG7UxuBBs
    VBLfcCXsCiuzNdevQ>
X-ME-Received: <xmr:fG-IaMCYCVe0684wKE6II-GqMISEV92-bkWK-JkLnfZVgiRet4fNwx0Mo7olzqatDIX2R8TUgQ-Q5lrJFwpvb0JV9E5FiHkIhzKKsKRmND8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsii
    gvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fG-IaDsYkScJqhsoil4rIdpL9rR0bU2u6j8QSOY--RW7R9fHhqqBTQ>
    <xmx:fG-IaAdRqJWbaAY9vHXAxVnU80uRFK5Gfr3BcEvcfyYp2Vcc5jUhGA>
    <xmx:fG-IaI8arjhNlbwyjtqYHHPps93YI0xn5bYJkTkK7zM1WNlHZCw_mw>
    <xmx:fG-IaDSphT7aWEAn189htahvefOi9VesBT3HdeH18rS9o0tth9SwUw>
    <xmx:fG-IaI15lhbfrwEV9-rNnnpNbFJd5xG3ERr_hdx43GGGoSb5hQ6nZCDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 02:51:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bedba6d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 06:51:37 +0000 (UTC)
Date: Tue, 29 Jul 2025 08:51:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIhvcSHrRLG6wcMD@pks.im>
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>

On Mon, Jul 28, 2025 at 08:25:43PM -0400, Ben Knoble wrote:
> > Le 28 juil. 2025 à 11:37, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> a écrit :
> > ﻿On Fri, Jul 25, 2025, at 08:58, Patrick Steinhardt wrote:
> >> diff --git a/Documentation/git-reflog.adoc
> >> b/Documentation/git-reflog.adoc
> >> index c3801b82fb6..c8389810273 100644
> >> --- a/Documentation/git-reflog.adoc
> >> +++ b/Documentation/git-reflog.adoc
> >> @@ -12,6 +12,7 @@ SYNOPSIS
> >> git reflog [show] [<log-options>] [<ref>]
> >> git reflog list
> >> git reflog exists <ref>
> >> +git reflog write <ref> <old-oid> <new-oid> <message>
> >> git reflog delete [--rewrite] [--updateref]
> >>   [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> >> git reflog drop [--all [--single-worktree] | <refs>...]
> >> @@ -47,6 +48,12 @@ The "exists" subcommand checks whether a ref has a
> >> reflog.  It exits
> >> with zero status if the reflog exists, and non-zero status if it does
> >> not.
> >> +The "write" subcommand writes a single entry to the reflog of a given
> >> +reference. This new entry is appended to the reflog and will thus become
> >> +the most recent entry. Both the old and new object IDs must not be
> >> +abbreviated and must point to existing objects. The reflog message gets
> >> +normalized.
> >> +
> > 
> > You have to give the full refname to this subcommand.  `git reflog write
> > ... branch <msg>` will update the reflog for the one-level ref `branch`.
> > But I’m used to using git-reflog(1) with a name like `branch` and it
> > using `refs/heads/branch` if it exists.  At least that’s how the default
> > `git reflog show` behaves.
> > 
> > Which means that
> > 
> >   git reflog write ... refs/heads/branch <msg>
> >   git reflog branch
> > 
> > Will show that written reflog.
> > 
> > Whereas this
> > 
> >   git reflog write ... branch <msg>
> >   git reflog branch
> > 
> > Will show one entry since `branch` is the one-level ref `branch`, not
> > `refs/heads/branch`.  Now it looks like `write` truncated the reflog and
> > wrote a new reflog message (if you mistakenly think that `branch` is a
> > branch).
> 
> This quirk of update-ref bit me the first few times I used it, too. I
> think it’s at least documented there though.
> 
> > 
> > It isn’t clear to me how the current doc guides me in the correct
> > direction here.
> > 
> > I tried `git reflog drop`[1] and it can deal with a branch like
> > `branch`.  It doesn’t need to be told `refs/heads/branch`.
> 
> (Partly responding to comments about what to do with this) I think
> consistency would be best, and since “git reflog branch” is not
> abnormal we should continue to allow that. 

There's a big difference though: `git reflog drop` won't ever do
anything for a reflog that doesn't exist. Consequently, we know that our
DWIM mechanism can kick in and resolve the reference properly if such a
reflog exists.

But for `git reflog write` that's not the case, as you can write a
reflog message for a yet-nonexistent reflog. The DWIM mechanism cannot
kick in here as there is no reflog. So what do we do in that case? We
could of course just pick the first DWIM rule, which would be that we
decide to write the reflog for "refs/heads/$REFNAME". But... I dunno,
that feels too magicky to m
