Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B418AE2
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543966; cv=none; b=K+Cx6/R5SJsvDUTOJgBwTbkp5uYj+uD+ej3EiF4ra+BaEgzcYBI6cAEIiRqGbbkFELGcYIHSurhFpYbGBqNWU/1HgbQUjCHIKbwam4WkH82cShF5rOpMgCtSZcKdfj+K3/BJPgGhjw2lE1ctieL6fsh0TNwUrI6CMpVc84qATHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543966; c=relaxed/simple;
	bh=kzR9qRtnJpQP603Zasf5oFI73/97qUpoG8HbQotNzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LolGXhFbSu7pPvNn9Qum9B/VTjxm85FfVzvRds5Q7iVuyvI3nBhRaP2s9xgeSWe4jynIuSktT6c1Wwl50t5KX5XUOYbJemsLsk1pAHmbF1LerU2hpkKoJPSNfZu1hYLH6y3At3zLHqn8stMP5yufe23Bm7uPpi5ItDkqvIzyoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CSpUzw8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPYZrYus; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CSpUzw8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPYZrYus"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 611A811401B4;
	Wed, 22 Jan 2025 06:06:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jan 2025 06:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737543962; x=1737630362; bh=nKw+E4NbBm
	jyikWKflfZC9zIuWBBRwo75mA9l4gEUPk=; b=CSpUzw8nFyVErJAle38R+2xdjD
	zWgVymxxpfA9PYHe05uC9EEl+7pLmgFve3FDc9BdwJhI1fsRLIIj91xaFAj54aEU
	K5plHCFeVc412w34DPujGC4M4m1wn1kMosYODhH1SqdrLDQvsd9EhHXojMfIGwdC
	ox6wBw7khQNCFQN0m3QK/fI8iKCw98JK9dVrj3zpWjiz68tOWW61qU1x41XZOMlI
	xNEf/ht93rkvNszkDyjCHTycHnHszvFXlS8qu6pElRemocg75EDm1Q0wvHbTWF+3
	S/PsrZTNS07BeK04yknryjTsQnzAbZgTqE35LPAURBZ1W9oDgOpG0lSyEocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737543962; x=1737630362; bh=nKw+E4NbBmjyikWKflfZC9zIuWBBRwo75mA
	9l4gEUPk=; b=JPYZrYusVRxuVwU1e4qmG9yAhuFZ/d1goxArSdS5XbvM3qIPFz1
	NCPDA/yUu/+TC755q5naYH9anhp+mfgPmqEEooDYoAwgXjen/2LKJQTWnbDznIAV
	U1wgzzGxEd0dRIhxDx2WJZ0XKKBhHVRtlEZGUBN4gDVwDEMinefA5kH0YMWF6b2o
	vhWeTFVOxLZRMsHdiL0MuN2QQos+4jfPfk+HmXy+r6gblFX0qiZgUYouPqjq1Z9R
	hydhowy5sRDngG5hmuxG8U79X0bdqB0wNmVRD11j+mXwTNTwHlpfuo5zULhxVYdO
	INKv8LMtPWIVZGfeCxIfq2N7nWshaRairkQ==
X-ME-Sender: <xms:GdGQZ1t3a_9_S1x0gzK6ScTY5b87cTlrrcLxs5SZQXHHqypL7QGgBw>
    <xme:GdGQZ-ev14fPqKPYEzjHxXYe7wfcczA62dF6s7WFwwE6zFwR8H-tn-WEcEB-vRiaH
    aKtJVyFZVlDw6wcIw>
X-ME-Received: <xmr:GdGQZ4zHMxE6mxgGWwe8vKKsYK95h7D0BrthG9HRZgCEBck8KWBdjwkM-Yobzet5zdc3xmJQuFqpIi5cG2qNuK9ArNSaB_O_wOBMClMfuFRj6Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghr
    sehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkoh
    horhguihhnrghtvghsrdgtohhm
X-ME-Proxy: <xmx:GdGQZ8MqR3paB72ZlmlEQ5IFj5kyKTiZI8v8EstMDn7GOsAoF7NCvQ>
    <xmx:GdGQZ18rwMLqjseLlUCaMVrKaoJ56V5VQBfJP1O7t-DsXaKrr7gtKA>
    <xmx:GdGQZ8VtRHHSfkqOZbSueoczJiwBR7AZ0uvXAqwY5zB-ceOYH8UvPQ>
    <xmx:GdGQZ2dM-y5bJ_xChTANDOwwGXGS2rJaB52g5W7g2v6SaRgCzctJ5A>
    <xmx:GtGQZ1xp4ZFOD6eyZ7h0jOEIH73no4csoMIiPE77Db8C0MjS8bq1BNSb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:06:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09814ecb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:05:58 +0000 (UTC)
Date: Wed, 22 Jan 2025 12:05:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Robert Coup <robert.coup@koordinates.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v3 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z5DRESPpegE41xaT@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
 <20250120-pks-remote-branches-deprecation-v3-5-c7e539b6a84f@pks.im>
 <xmqqtt9ryi3f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt9ryi3f.fsf@gitster.g>

On Tue, Jan 21, 2025 at 01:25:56PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 1ad3e70a6b..e565b2b3fe 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -640,10 +640,12 @@ static int migrate_file(struct remote *remote)
> >  	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
> >  	for (i = 0; i < remote->fetch.nr; i++)
> >  		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
> > +#ifndef WITH_BREAKING_CHANGES
> >  	if (remote->origin == REMOTE_REMOTES)
> >  		unlink_or_warn(git_path("remotes/%s", remote->name));
> >  	else if (remote->origin == REMOTE_BRANCHES)
> >  		unlink_or_warn(git_path("branches/%s", remote->name));
> > +#endif /* WITH_BREAKING_CHANGES */
> >  	strbuf_release(&buf);
> 
> Interesting.  I wonder if our new warning should talk about whatever
> end-user facing interface that triggers this code path.  It would
> help them wean themselves away from the old interface, no?

Not quite sure that I understand what you're saying. Is it that we
should tell whether we were reading from "branches/" or "remotes/"? If
so we already do that.

> > diff --git a/remote.c b/remote.c
> > index 10104d11e3..5feb0ae886 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -293,6 +293,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
> >  	rewrite->instead_of_nr++;
> >  }
> >  
> > +#ifndef WITH_BREAKING_CHANGES
> >  static const char *skip_spaces(const char *s)
> >  {
> >  	while (isspace(*s))
> > @@ -308,6 +309,13 @@ static void read_remotes_file(struct remote_state *remote_state,
> >  
> >  	if (!f)
> >  		return;
> > +
> > +	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
> > +		  "for removal. If you still use the \"remotes/\" directory\n"
> > +		  "it is recommended to migrate to config-based remotes. If\n"
> 
> Do we have a way to concisely say "how" to do this?  If I am reading
> the caller of migrate_file() in builtin/remote.c, it would be
> 
>     $ git remote mv foo foo
> 
> for any foo in .git/remotes/* or .git/branches/* hierarchy?
> 
> Of course they may be an ancient leftover file that the user even no
> longer is aware of having, in which case
> 
>     $ rm .git/remotes/foo
> 
> might be an OK answer, but even then
> 
>     $ git remote rm foo
> 
> would probably be more appropriate.

Very good idea indeed. We also have tests that exercise this behaviour
in t5505 (with the slight exception that it is `git remote rename`, not
`git remote mv`).

Patrick
