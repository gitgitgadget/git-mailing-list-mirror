Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D311547C9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578893; cv=none; b=ciQ+shmThGqSjKA6O1nfO88bkSVfp+B5S0Xs7DD7VaonAFagpQ9EmxYtw6wtNme8JscFfjbqATaVQSmWvY8P7f5yppwOET870Hhs/MXcLXnAnNTvBNRJnDW81csNYyqjc/z5+oxymF1Xd9vlJAey25yKrm0QojEt452c/sXxz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578893; c=relaxed/simple;
	bh=TQY3Evo4q3dK7PjWAmAmvxDp4x7njSEi7OS7aT3kDJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m48F1EdwPf2i7zFp5UvGviVtlBJlRckkbUDtF+VQXWTK16jmGVjlxvuDwfFnmFIyP25zZv4MHtMxCXgpIfHkds3AAXAKRev3lVApr+VjBqWFX3MNntMXYTN8fFlz12s1w5yVpBIiDNInZYN/7Zw/MrEnhUQJf6sg2qjSRqMQVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b4VVvGnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkOaB0ui; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b4VVvGnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkOaB0ui"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BE1F14002DC;
	Tue, 15 Jul 2025 07:28:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Jul 2025 07:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752578890; x=1752665290; bh=29LPKjaxLd
	VR7iekx1sJ/j13Qerc/98CXVhCc2S7Nrk=; b=b4VVvGnW+2QM7mcYFVz2d7/wLu
	O1CvQGb1vxpOo3f72DxsaOOd0Yhquco8VoPJRL7oeRu1uj83Jkn3vZfQZ89GkZFJ
	jtFNyhnpszdQwouaxHfHpmbsQkDdAjKEitBgKnNDP4g8mfOPAe6LYAueMhD+oT+v
	MzBSpViJhz83TsdOg4Vs4p8zqc1/wabGAN1zYKV58IDl6vIWPi740bupwOlIbmhk
	p2RyvsNYy/ZV4ck94ZF+aeTsrRZTBgL3ig0ysGqt/4peVyVCDmXphcdMg4kHlGn+
	y1IU6Sh51qPux8VWSDYhkiP6YaDOhODBvVdRRmzYBQyt4OhAD/cFQdpiIDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752578890; x=1752665290; bh=29LPKjaxLdVR7iekx1sJ/j13Qerc/98CXVh
	Cc2S7Nrk=; b=AkOaB0uiQWwnKUQGYyxFqEr3nMU71iTRNCG7sDuhnNT69MVAM8k
	9GIXObjuwPTm7wSqCavdTCEGpVVcI8zxXMRWWnvwqUIiwxK5dkfrIvrOfEewoCfH
	wi125zGxYkpVj/EC3Yhu22ggQD/dPaPlYnaoWUHzTEpP1Ly8BrygersnFvv+nDq5
	WvjlRnobXNS/LJyPa+8wLPakwqBvToECieJ13/JqHh59/kRcOhv4joGEt8l/ox39
	mwXz5gtPLlP3XcxKxTJhJNldv8y6riibcx/R6mP4gCpSgRiz5xbGVVKttJEIDkzc
	FGDLMHW64gq1D6qrQ4eZTVaLXlyd0sz68Gg==
X-ME-Sender: <xms:STt2aISYAjjT5b1uZGDuX8Vd6OfbBTQGG6rIF0igcAVVfuTgjvDCXg>
    <xme:STt2aAWWu6093ow6NcjPuO45K7RdIyxsM9iX2Du7yA0aX-TKTNu3SPK9uRNDnbuy_
    x9F_bj8w9iHleFXgg>
X-ME-Received: <xmr:STt2aCZsY_3NH31vOE1Rv3ejVMRyOi89V2_FwJF1TT94V4PkkP4Kr_kpZz05Dm46f1jSvqG6d_IBYjLLnRFlTH8YiFmbTrD-Lqkz66mKoxTX7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhgu
    vghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:STt2aO1lyIphqqq92qLPWEruKfNShNEF8LzR7K1Krt8pyCyQdCoSug>
    <xmx:STt2aMih-O2sZb0QLOLjeAmc8ResgSMkWeIv5m8xuCjI4QiT--5DWw>
    <xmx:STt2aKalgdALiLWjuhODTdEVCl8890GSoARFlN0pELDxNrebvDroRA>
    <xmx:STt2aESSOwaeDu016ACHw5E4sEvso8g3WBgU1I4NaTefVmEX9qvnAA>
    <xmx:Sjt2aHAFvzVb-r73KqmFbEocQhib7VsZWa659jHOjswMiHYf5a_l-H1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:28:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 13570223 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:28:07 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:27:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
Message-ID: <aHY7LYHqVj-ECf_z@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
 <xmqqbjpq1rs0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjpq1rs0.fsf@gitster.g>

On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > I do not think adding prepare_repo_settings() calls all over the place
> > is a good way forward as it makes it very easy to introduce
> > regressions like this. Our builtin commands parse the config at
> > startup for good reasons if we're going to move settings out of
> > git_default_core_config() we should ensure that they are still parsed
> > at startup.
> 
> I think that is a good guideline that applies not just to this
> series but to other topics that attempt to move globals to a member
> in struct repository (or repository_settings)

So... the only real solution that I can think about right now is to
start parsing the repository configuration whenever we instantiate any
repository. E.g., something like the below patch. This has the effect
that the repo settings would always be populated when we have a
repository at hand. Consequently, we wouldn't need to clutter those
`prepare_repo_settings()` calls everywhere anymore.

But there is a big question: what do we do with invalid configuration
then? Do we want to die immediately when we see such command? The answer
is probably going to be a solid "sometimes":

  - Some commands must function even with an invalid configuration. At
    the very least git-config(1) needs to handle this alright, as
    otherwise it might be impossible to unset/change invalid
    configuration. There may be other such examples.

  - Not all configuration is equal. It may be perfectly fine to ignore
    some configuration, but other configuration may very much be mission
    critical. And whether or not configuration is important isn't really
    something we can decide, as it will depend on the specific use case.

So I'm afraid that there just isn't a perfect solution here. Does it
make sense to die due to a config key that isn't even used by a specific
command? Maybe. And if not, which config keys _should_ make us die in
case they are invalid?

The overall situation right now is a proper mess: we have config parsing
cluttered everywhere, and the behaviour is just plain inconsistent. Some
parsing is delayed, some isn't. Some is per-repo, some is last-one-wins.
Some config keys will cause us to die in case they are misconfigured,
some will just be ignored.

So where do we want to end up?

My dream would be that all configuration were to be defined in one
central place. The configuration should be typed, there should be
verification for each value configured by the user. All configuration
gets parsed into a structure, and it can be parsed either via a
repository (in which case we take into account its local config), or
only via the global- and system-wide configuration. The whole config
needs to be parsed at startup so that issues like the reported one don't
happen where a subprocess that uses more config keys than the parent
process dies because one of the extra keys is misconfigured.

But I very much feel like this is a pipe dream right now. We already are
working on multiple fronts to modernize the code base, and I don't quite
feel like opening up _another_ large transformation right now.

So I don't quite know what to do while we're not there yet. Without this
large refactoring, all approaches feel like they aren't a perfect fit to
address the bigger issue.

Patrick

dif
