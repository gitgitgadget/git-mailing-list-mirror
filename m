Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBD2F363A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928836; cv=none; b=ZvMi+u8EUm6xeZS2F3jAwRV9wDRDofMF5YL9bUOpl6gpDS/640hUVrqqo4qy3c7Cw1QP00Mce84pCXyAZhMJZF0dARy9H1nM8eIsOxNDP+fDLWmUMSMC3S1cxCF236RVUqTzHcXZ6+lwU7rdJd4oTw94SWVticXf/ItOjzxBCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928836; c=relaxed/simple;
	bh=tLtyn45PJTq98l0TWULg7wNtT7QYG1Rdn1CXwqEARhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaGpVJ8vRWc1sMtIsj0j7y2NQ79f4l6W7VBOr7chdC/EESNWYUeayPRBQ0NRLa6J8vC8lcPs5KTqhOz48Uj3VEXzak6fvkWoR0c7bYwpd52xdiyi7TRpVsEJD7Zf8WuViFeAp6ZYBujTApFSaPf2pblSDtollU9ZTEgRMzh3e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RHx5cAdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D4534n5c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RHx5cAdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4534n5c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CF74EC00C8;
	Mon, 15 Sep 2025 05:32:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 05:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928774; x=1758015174; bh=LlcExTdxeU
	3Ob5vUIhpk9dfT4meJiTJe4c9eEuiZPY8=; b=RHx5cAdolNj8qcaX5Xb6PVyppc
	RKL+yVh3Kzlbw3gcuwp5guLVY/2L0KoxLxVFHLIwzGcSJuB4KQvaKywHgoW4KFCL
	lAkxTfNRY3qRkQ8dT9BIhMgE4Rv1ZaP+zyhydaqy9bBvtA3UPFt6L9ubyN8h1yTY
	1wnT6i0JChX7311/P0hrmvHvnTJeOCRhv0mBZkbDD/WEIB0jvJjS0pT6geHXQu7O
	1pSt0MuUkFAAM9apZH6Dek+d+VJyg8nu8EJd7nAzsGhHlwTcCCFBsVRSr9tbiUxK
	CmXHv3BV3UCVu/CJnoz/WkwRG9kgqZIgEAfx9Ly2VQhfrImJ8OXPiSsT78iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928774; x=1758015174; bh=LlcExTdxeU3Ob5vUIhpk9dfT4meJiTJe4c9
	eEuiZPY8=; b=D4534n5c/oDGzE8W33cUEgSTWCCkVLnAFystCYf4F2O/0YU8H1l
	LTmVd3auH9hIhiS+qAQmy6K32WS1x0mI8o2IzAMZwehpY8iiRrvjeVIs2kDxgDZR
	8TNEgjExwGDoWG6VY2qJp+nF2+wDj9bMhJ2jy13C4IeZzp1QW2GGkZubdb5YTius
	rNOH2uVzEmqvDBTucylMskSPp8lVaWEE22UQWCwqULeGDY6njZ1rodTZRBPiyvLL
	C4JP6kHI+lban7dHpMHUoqWqJ53EKzAVsX4SEgXDMRbglLLmHneS9vNA6FYjGuWB
	4POSLjQrepzhxAMcUkjikcEZENcpk3JSPYw==
X-ME-Sender: <xms:Rt3HaG73WAuTHoyZQoLaf15QYNxGQderAAfKp3WiMxlOf_DY-DqWUw>
    <xme:Rt3HaFG81GgFVXu4yhRynD3zOenHpYejkjSuvVx9TEYr-ZD3Y7biuMJ7eQYpUPul2
    ZftUZ8vW5aAbiUBsg>
X-ME-Received: <xmr:Rt3HaGXyKH32ZCEu0GxEQTTBKS0nBNciX44PjbcCbrojyIcgscxBRxcqZX4_Qbp0_95iEIang632Z7wJpyiGLeMyfRTkKdH3RXcMMTN77wcatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrges
    fhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Rt3HaJVDFaJspuIjtyIyYdtxqg_qAZ3kdQkRIpJHqz0k2HuMCOpSQA>
    <xmx:Rt3HaMKE1dN9o9GZvONdMe65tHmteU0vN2uAl7zuTCs81PPRaHiNYg>
    <xmx:Rt3HaJCnJS1Xcv0CvqjvKJT4TcA7uMyXuevzJwAt6_da2uztWvBqCw>
    <xmx:Rt3HaMdt4HMlwzbrrA6BKMlHZHzvDPv6gZvU-QEmoRersKM9sldcwg>
    <xmx:Rt3HaB_eN5CdC8bAJTao7ZmXgdQKkhu8-mmAVL-pJnbXyDVjc-ouQn7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19df3f13 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:51 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 02/18] sequencer: add option to rewind HEAD after
 picking commits
Message-ID: <aMfdQFYdL1xoHADp@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-2-509053514755@pks.im>
 <f74b9dfe-b05c-431e-8872-92e2bbb75b8c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74b9dfe-b05c-431e-8872-92e2bbb75b8c@gmail.com>

On Wed, Sep 10, 2025 at 03:04:00PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 04/09/2025 15:27, Patrick Steinhardt wrote:
> > While the sequencer infrastructure knows to rewind "HEAD" to whatever it
> > was pointing to before a rebase, it doesn't do the same for non-rebase
> > operations like cherry-picks. This is because the expectation is that
> > the user directly picks commits on top of whatever "HEAD" points to, and
> > we advance the reference pointed to by "HEAD" instead of updating it
> > directly.
> > 
> > We're about to introduce a new command though that needs to detach
> > "HEAD" while being more similar to git-cherry-pick(1) rathen than to
> > git-rebase(1). As such, we'll want to restore "HEAD" to point to the
> > branch that we started on while not using the more heavy-weight rebase
> > machinery.
> > 
> > Introduce a new option `restore_head_target` to do so. Persist the
> > option into the sequencer configuration so that it persists across
> > different processes, e.g. when we need to stop due to a merge conflict.
> 
> As with the last patch, can we use this new option in "git rebase"? The
> sequencer is already a nest of conditionals, it would be nice to minimize
> the number of new ones.

You probably refer to the condition in `sequencer_pick_revisions()`
here? Everything else is basically new code.

Honestly, I don't dare touching that condition -- it's already quite
complex, and I wouldn't be surprised if changing it in any way would
cause regressions.

Patrick
