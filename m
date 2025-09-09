Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859F306B33
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403636; cv=none; b=WPqtc5O+eEws7yufH92ffkPujTHdvagrVb9dSPFHsO2S2dE+7IGDtiWYpgbGOQcByb6MvN+8kF8Ixips0ioR3xNreISVKs22rDsAWfXJ0h+Dax8qBjIcuUdx+gJXQoqz5/OL9u7+m9FsrwtpTVjSfb5iV2StL4hW5L24fGcCQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403636; c=relaxed/simple;
	bh=eTB6ZVaWcq/seqFc6s6jGCmOpPFys2srzIo9YMpUg8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig94tAtzAf0RJDIREI/IHRoDC2a/Rvl6i//B5iRaH7BqooJmaC0Fja8uag+M1s1nX+kR9iNvSQtxIg6Ian6R1wP1LwZbL9wKPlbs55WJEqvsuJE6OnXwHlaCUdzwbwlsC9J9wrf+2cL4lJcg3U+pwKGRvQAjZcuRAb1H9dVIM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q3RN++9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzGSTPXv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q3RN++9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzGSTPXv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C3BAEC00FA;
	Tue,  9 Sep 2025 03:40:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 03:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757403634; x=1757490034; bh=mezwdprBkO
	XbHgRKCG4WCdBuHHJh3+vUGC+MOrfOVY4=; b=Q3RN++9YGB4MW18AFuzu71FwA1
	cHySDSsYCZuvKndukyeaJG8cPmmfyw5AJafvgcca19gRhNo0MbCnGGB8SAJr0fIj
	HN8T1xmMeq0INl2/1iPDsGw7ORBA1gnOqTvmvfpLMytBdkTCJHJauKnj7tX0vhgF
	fq4uDeaezRRjkgEYJQ8FFOggmdTalJ4ZtasIeDDJedavEyrhKhnnpEXU8XSgSRy3
	Xx+YPZHCMGx3+tsmcyVn8FCH7hwZ/uDcdfAED/NA49Ja0J4oftXiddwRbPkDmwKS
	GszIq4eSdDTzXjcIjvDVYQ7BQYPRq+VeG+fMHxsYfnHpm9Ga8PaCmRP/SWNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757403634; x=1757490034; bh=mezwdprBkOXbHgRKCG4WCdBuHHJh3+vUGC+
	MOrfOVY4=; b=IzGSTPXvldqc7A8w3lI2OIg2fnp5ydY98+12B9QYvSyKmkJ4MFr
	SoLbRDLKIVrnzeIsT3pcE5X5GntmQdwOf6BxrDpMzqZmNtaHnaEjf/1QFsmMSRnO
	CCv26iIiYPxCzzEU7RoAFRkdZJ7vj9BbfL689Z2x14lYqN/mqneK34L13DszHt3g
	JRXXWLgLTQLWU7edF2rygFnv55qB9vQzYDNPXmzsXf0rHBnIa0RMgVPYx2cFzu5f
	7sao9B7x6Zzhv98MCfD/3gGOXc9oPyf6USsHE+0IsHZUgtB6enb7QoMqK648iywO
	TaUw6eC7UVoo3paEkfgdN8bEPZsAubSsvZA==
X-ME-Sender: <xms:8dm_aOLLI16xiLvKa-fk05e9G_0-9V_UQgtMhHbOQFwtD7dgNCX-nw>
    <xme:8dm_aB0UaaKahmap8X4gwi8qsuTiNyg2CESL0-7mBRDJ1QDSTA3mCHyvxQ_uiYCy1
    eGMvC4maGcWrYDrZw>
X-ME-Received: <xmr:8dm_aLKfAHBZzuTBrHlJ2-lY1QQvlnZzzFqWjpknt9ppmt66hIKa7RHCMji9Qf5qGFEbPaMAD-XkomslfGmIhEv1orJVO_PlO3U0GxXNwbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8dm_aMjC8y-ooqAAleO1MklVLKD9UE64OceDQnMPnsidLco48nQDiA>
    <xmx:8dm_aLAWLEWSxbiPHsRLrIKiMUdk5vPZwGEqDUOU6_9G7HUiSExFOQ>
    <xmx:8dm_aO4xKC6hxIXfng_vZ6AETZo-U2L9sMOn64wOa_YxgLrrKKTNmA>
    <xmx:8dm_aAEn0_GldcOw0nYSHEv3qlbfcpH1qXJntcFvJ9p63rH4ORma4Q>
    <xmx:8tm_aK9nGeuT9KQwMcijaZ6xEaVtqDYNRC-0KNWIp63lpc9oAKXr9Z-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:40:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00ebaf59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:40:30 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:40:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 02/10] submodule: create new gitdirs under submodules
 path
Message-ID: <aL_Z6z1XZBEbNGV1@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908140117.262205-3-adrian.ratiu@collabora.com>

On Mon, Sep 08, 2025 at 05:01:09PM +0300, Adrian Ratiu wrote:
> This is in preparation for encoding the submodule names to avoid conflicts
> like submodules named foo and foo/bar together with case-insensitive file-
> system handling and other corner cases like reserved filenames on Windows.
> 
> Backward compatibility is kept with plain-name modules already existing at
> paths like .git/modules/<name>, however a clear separation between legacy
> (plain) and new (encoded) namespaces is desirable, to avoid situations like
> an existing plain-name module containing the encoding escape character/
> 
> Thus we split the new-style (encoded) gitdir name paths to .git/submodules,
> while legacy-style paths remain under .git/modules.
> 
> This is just a default directory change with the accompanying test updates,
> in preparation for the actual encoding additions in future commits.

One of the questions here is how this move will affect alternate
implementations of Git, like libgit2, JGit or Gitoxide. There's two
angles to this:

  - Git needs to handle that those implementations continue to write
    submodules into ".git/modules".

  - These implementations need to be able to handle the new-style paths.

The first item should work just fine, as we make sure that we handle
both paths. But do the other implementations need any adjustment? I
guess the answer is "yes", so we need to treat this as a backwards
incompatible change as they wouldn't be able to find the submodule
repositories anymore, right?

Ideally, the way that submodules were populated was less fragile. For
example, we could have a "submodule.*.repoPath" config key that gets
populated whenever we clone a submodule. If Git clients knew to use that
field they wouldn't have to second-guess where a previous Git client
stored a specific submodule, but they could just read that path and then
use whatever is stored therein. This would even allow for changes like
using a hash to encode the submodule name.

But to the best of my knowledge such a key does not currently exist,
which is too bad (please correct me if I'm wrong, I'm definitely not an
expert when it comes to submodules).

Patrick
