Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62685626
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670581; cv=none; b=TL9drvJfOicozeflPb9Dg2BJ4f4xZbiouHGXiDKutFfJnYrHMEBJTl0Bh6iyYzflev1blqPBHaR6PGvySajETAiicHCGzp1ZG+Lj+kqzoSROAO6/y5qyD++1da2EV64yLxC33675pmTGqKB3aVIIkLTXlEzfj7RwBzydJ0Y2TtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670581; c=relaxed/simple;
	bh=4fUyUcGt/IYBIDNcO/4w9ocC1ROXEdG54UJh5DLYTdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUdObnmgszI9zNp12jOLRU5XXYFkSyd9s/CPwOTN0oJ1ND6YD2BgkF9SXZymbC6QSZJu6JXclY9zd4uCe/guaooIFxwl5MKYf9+VoSAqPeDet/1zpQ76y45dc8TAbUQ8W2uvLvpSEmE5a4sq5mv/I1rzodmW97JQN6E7V6uhbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OifbEAsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g107ncN1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OifbEAsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g107ncN1"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73D317A0127;
	Wed, 16 Jul 2025 08:56:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 16 Jul 2025 08:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752670577; x=1752756977; bh=81VYaIh9W2
	WBrahFbYbBiPbjz9OsYDAHzj4WT1pUK8s=; b=OifbEAsNd8jN0f7ChsymjB/dM1
	eJjRSH2Ri7oRV9ueVql6ogq7NMN4LSj8I200WjimKibJLnSXi8Z2WcekO+MyMwd6
	dRblQAjdGykTRWCxkyPdGzuN5quq0Enm30wsye5EBDNFMAG3QNoE0LGy+R/OIk4K
	oGdWbitOu457wFET+A+V6dnJnmVC3DunTBLfqWqjDsHiIFjbo5CbdKKJ/fcsMuPb
	vtS2oRvdLBVe5MHqAGeCkX5DrAeuMrG6KZ4dolHvu1Sj3oT8B01M5PY4r24zVfzO
	B/rjddopxuzdFJZN4YUc1+ZaCkXXZzf3lUgD1jDARkHv92EON7kIweOVpJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752670577; x=1752756977; bh=81VYaIh9W2WBrahFbYbBiPbjz9OsYDAHzj4
	WT1pUK8s=; b=g107ncN1LybqGLjtkADm1XLYRtPRzSql/BJfeSFizmpI3dbTixE
	R9a3tp3Upjca9C9HeFxjqqiT6iz/NnoA9ZkphX6BTGX7FpzZV+FdIQtF2LTD5QHg
	h14wQP5wWGYlaFAzH74XfA1BRsewYMyok/ItZljYKZOfDcE7vc9qNHJ8iY2/H7yQ
	/zwojRh9jcArYYunztJnR18RPUMoHX3RO/C6utn6Me2EEcGm5obf5OfUSHoN/D4U
	QqLuUs5bMQ3qKO7EcrqeVJOR+KqWbbsfXWOqbMek60KLz+Jz4hB2z7oZyHrD7Ju0
	4vFhBBhqKy+taBeqFHVgxEu9ORMKSwHZNUw==
X-ME-Sender: <xms:cKF3aGJz3FSs-ba9xNp1aj-y1aeYBIY3809ce9ztPl-9G7vKIj8ncQ>
    <xme:cKF3aHliIDmunuBcEzezBlB9n2NJxPi3SEP4kqWJT65sXMMrVup6rixS6P2QMlXbs
    du74eiqeBR4fZfAjQ>
X-ME-Received: <xmr:cKF3aGTxZG88UOT4XeQqQ7GLZaIyVITCcy4JCXF1gzG1mmsz1MwTy46TwhXJCVjJz6Hyi0V330XhXTnUeefZl9Kdmw1HrhhOn93Dk4pW6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhouges
    ughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:cKF3aBKz9ebraFTh6qrnG1KpgrOpGWpoyF3RwFwEPhF2pKY-dyaSyA>
    <xmx:cKF3aEBRROE4O5ad2w78vNl7ioqfPebQ2duBiU75htNV5aNHj7j9Yw>
    <xmx:cKF3aCCrKFVLgvHBmIstnxkUDIF5NlWByyUmyUeJtHIYBIneHtwWfg>
    <xmx:cKF3aODGMNOCjOzBGt7wcE_fNaT-Yhaq1V6-kE8U6VJFVVA8Efjuiw>
    <xmx:caF3aNGnojGH8QYvN3Z3jAep0vUiWpDVa2A2L6Oxyg7PY6cMkSvpoo2L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 08:56:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad529c35 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 16 Jul 2025 12:56:13 +0000 (UTC)
Date: Wed, 16 Jul 2025 14:56:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
Message-ID: <aHehaghOW16vPee7@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
 <xmqqbjpq1rs0.fsf@gitster.g>
 <aHY7LYHqVj-ECf_z@pks.im>
 <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
 <aHZ94u-xULDDBb7C@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZ94u-xULDDBb7C@pks.im>

On Tue, Jul 15, 2025 at 06:12:18PM +0200, Patrick Steinhardt wrote:
> On Tue, Jul 15, 2025 at 04:51:32PM +0100, Phillip Wood wrote:
> > On 15/07/2025 12:27, Patrick Steinhardt wrote:
> > > On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
> > > > Phillip Wood <phillip.wood123@gmail.com> writes:
> [snip]
> > >    - Not all configuration is equal. It may be perfectly fine to ignore
> > >      some configuration, but other configuration may very much be mission
> > >      critical. And whether or not configuration is important isn't really
> > >      something we can decide, as it will depend on the specific use case.
> > > 
> > > So I'm afraid that there just isn't a perfect solution here. Does it
> > > make sense to die due to a config key that isn't even used by a specific
> > > command? Maybe. And if not, which config keys _should_ make us die in
> > > case they are invalid?
> > > 
> > > The overall situation right now is a proper mess: we have config parsing
> > > cluttered everywhere, and the behaviour is just plain inconsistent. Some
> > > parsing is delayed, some isn't.
> > 
> > Indeed. My objection here was that we were delaying the parsing when it
> > wasn't delayed before. Is it feasible to call prepare_repo_settings() in
> > repo_config()? That would at least avoid the problem that moving config
> > settings into `struct repo_settings` changes when the settings are parsed
> > unless the command calls prepare_repo_settings() at start up. As far as I
> > remember `git config` uses config_with_options() so that would not be
> > adversely affected by such a change.
> 
> Hm, yeah, I think adding it to `repo_config()` might be a viable
> approach. I'll give it a try tomorrow and see what breaks :)

The answer is "quite a lot". I'm now 15 patches deep to try and fix
this and am nowhere close to a working state yet. The single biggest
issue is `core.shared_repository`, which is used in a ton of places and
which causes all kinds of pain.

I think I'll stop working on this for now, and would rather like to drop
the last three patches from this series so that we can move forward with
it.

Patrick
