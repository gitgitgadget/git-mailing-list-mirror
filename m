Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13B301464
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582875; cv=none; b=Ajagw+lF1N8Rh/6cqk+l5pnUhjNdRviefPrGMzbZBh4ZAIF3Wo69pkaNbZyU8n0VS2E8AW9FZWxdvN4QfhQMeoJQ/2VKZTYf0vR1DrL2rzGah56wBw4XdJd16Pe9/ZtmPome9uHH+iaQ3kEEDQUzAkpj6zzmQDZD+zvlACMORSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582875; c=relaxed/simple;
	bh=Uz0VGvxv8vaYteVEt3PVd1O6ZMkFbL8l3Xe6aKmrvL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFv2QCHfRRFfsZRX3MuIfrXdDdF4S3rhTlqfjITJrG1I9uzYbgezFwZ3QEC/IysEsYJh7Sb1hrOaNWxb97RZPfDsuieLNuKjxrpB6ezOYMQhgNuTmoUZxPitYktGm96AAYzS3hl1F+cDZ80puQ0CrFoGpPuJ+E6rRNsYjWPK9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GLJCgkem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ojwy4jKB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GLJCgkem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ojwy4jKB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3788A1400135;
	Mon,  1 Dec 2025 04:54:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Dec 2025 04:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764582871; x=1764669271; bh=u+woNwFAe6
	RPSB1yrHKFfDNalHTOsYGaHCNErz2fBbQ=; b=GLJCgkem7OCxNkocCaVi80Bw0m
	w7kUBTVsqzCfYaMbBU6HqJPcVoHVx8w7zWCodVlSnWW2K3HgR+S5Q1vR1OyTrGpF
	xlWJKenVfNvwm+99na2S1Dd/LQkdPbaPaMWXxq3wd4DmGZ91tlGBKUvgKcKHcSyd
	GrAcLmAsqJwpmmWFqPtfoKF/BcIQ5rKsFp7/GayHYgqysG6EwbCaJOM6xHpVHbYs
	n/ciKo+t3zUhGupGAo+IaxZyAnh4SUgPNmsCYL4IwZZJMdWYPrbJClDit6hmDLHA
	VAfy3dQLQwgLFwD0lxMViR/f0HWGzc5rb2XQo2bAtXXOfyQ3KszlXBvRx7lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764582871; x=1764669271; bh=u+woNwFAe6RPSB1yrHKFfDNalHTOsYGaHCN
	Erz2fBbQ=; b=Ojwy4jKB/2I5dMrJhniuRTj0cebZDqV9aCEI/MLh1Qq8Lkp81au
	Z9MI7N9RA7wwx/v3RpFgu57JRJKPM2sC2r57Y0x9YRKAa5c8Adg7OU1NbdT1Bn7V
	HiUgP4u2qYpdUBfn22sZMceq71+/YdxxDE6sg7+LlpuwU3dCBRwcPcuKSazy+NQD
	x7yfj1LxRTNdPi6vqkbELMSuzKS+M08o34FS24zPT97IrSFbL8KsWZ5bh/GTPiQp
	NI953Dd2zVn/5LVon3NOY4shX10oDiZgybKOWgT9TrOcG4rqYnriLoxJv6Imsw8e
	v3fgWCQvH0CbixHkSzfxMjOxqEm457PlA3Q==
X-ME-Sender: <xms:1mUtaTcVGxiX-PSX6bMpVwaN7q3SmRkXRg28JRJRtKo1UKF7KezVgQ>
    <xme:1mUtafMR37Ewzz3PNJQmUIjXZwSAEmfGpD4i5zrfNNPBh9bBpIH2Q7p1LVVWQdYIs
    Z_MYp9hxmJ7q19axtMiYWMKm5IC7R0x7I2juuhq9DLk7brFC13VLg>
X-ME-Received: <xmr:1mUtaaLsZ6BC__FetJhzYxH1IYvUGNIKv-AwQK5r1LfoCavc58t2aVYON22Ey8pb9wzlnTUPpKNrQbNjCyy3aJ5i27nRFPJeLxpvk6a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:12UtaQGWC3SX9-ECyrf8Z-jv-Jyy3Xijwh_eiqrfZBidXpIaj_BGLw>
    <xmx:12UtaSRCZuJRPSFUxHoXRmLFXGO_6QpozMRJo_p6J_M7DqTzNYQ0Mw>
    <xmx:12UtacFsvhMjPj_RohZVDqN8qQh8NRSQP1JDDuk_UZ2x04Ku8PX9SA>
    <xmx:12Utae9mSvnUGwN-mZcbicp1oj1pTj7N9EsnjXQ5OnfHgnzkmaEcWw>
    <xmx:12Utae0KjvPHWdMYtap2Ex8kPs5JCHJy0f11Wv9yBEVZZds166DiASbj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 04:54:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 607f2b80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 09:54:29 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:54:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #10; Sun, 30)
Message-ID: <aS1l0YuU9xOE7eog@pks.im>
References: <xmqq5xaqbxmk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xaqbxmk.fsf@gitster.g>

On Sun, Nov 30, 2025 at 09:05:07PM -0800, Junio C Hamano wrote:
> * ps/object-read-stream (2025-11-23) 20 commits
>  - streaming: drop redundant type and size pointers
>  - streaming: move into object database subsystem
>  - streaming: refactor interface to be object-database-centric
>  - streaming: move logic to read packed objects streams into backend
>  - streaming: move logic to read loose objects streams into backend
>  - streaming: make the `odb_read_stream` definition public
>  - streaming: get rid of `the_repository`
>  - streaming: rely on object sources to create object stream
>  - packfile: introduce function to read object info from a store
>  - streaming: move zlib stream into backends
>  - streaming: create structure for filtered object streams
>  - streaming: create structure for packed object streams
>  - streaming: create structure for loose object streams
>  - streaming: create structure for in-core object streams
>  - streaming: allocate stream inside the backend-specific logic
>  - streaming: explicitly pass packfile info when streaming a packed object
>  - streaming: propagate final object type via the stream
>  - streaming: drop the `open()` callback function
>  - streaming: rename `git_istream` into `odb_read_stream`
>  - Merge branch 'ps/object-source-loose' into ps/object-read-stream
> 
>  The "git_istream" abstraction has been revamped to make it easier
>  to interface with pluggable object database design.
> 
>  Will merge to 'next'?
>  source: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>

I think this topic should be ready for next. The latest version didn't
receive any feedback, but all it did is to improve some commit messages
and rename a function based on previous reviews.

> * ps/history (2025-10-27) 12 commits
>  - builtin/history: implement "split" subcommand
>  - cache-tree: allow writing in-memory index as tree
>  - add-patch: add support for in-memory index patching
>  - add-patch: remove dependency on "add-interactive" subsystem
>  - add-patch: split out `struct interactive_options`
>  - add-patch: split out header from "add-interactive.h"
>  - builtin/history: implement "reword" subcommand
>  - builtin: add new "history" command
>  - replay: stop using `the_repository`
>  - replay: extract logic to pick commits
>  - wt-status: provide function to expose status for trees
>  - Merge branch 'sa/replay-atomic-ref-updates' into ps/history
>  (this branch is used by pw/replay-drop-empty.)
> 
>  "git history" history rewriting UI.
> 
>  Expecting a reroll.
>  cf. <aRxDYkeAi8T-HH8M@pks.im>
>  source: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>

I'll address feedback on this topic later this week.

Thanks!

Patrick
