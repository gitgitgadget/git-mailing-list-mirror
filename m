Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BB125D0
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961863; cv=none; b=qnBfSTDuYjCk/DstrGGr1hC0218WW9IyquP63QH7j9/un4WyVpAsPpVcW5NheT3mzy0eZ5HuQeC603vex75QualMYM8dpuQ7LLKJV17DUFuTrokq5TJGqCKrAF5yfC49H1bq8S4JBugCKuVJ2sTt92QXFueyj2RqTioJPMF9eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961863; c=relaxed/simple;
	bh=W2V6+XtLJTiOGtBtcrsur6QCAhnI9tYwPmnjni+fuh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMdElWmTky9XvF68uChIpVT64GofzNsQ4DMsrvnD0RT0dqzY9jgtBWoNOu8tdln8mpt2VvdWx/vxGG+Qa9EjZOUg8IYcPiob4wqh+tBnrJIRpr+HYDlkDzr3baqO0l3O+Vow5V3MCRCD33JdJqyA08RyMKRabF7vf1N4h2yLPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgZs1ivE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pjhw4KbU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgZs1ivE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pjhw4KbU"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B826D1D00114;
	Fri, 13 Feb 2026 00:51:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 13 Feb 2026 00:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770961861; x=1771048261; bh=sCSHtwqqXd
	FzNUPkXP76eNa4M1bMplQI2iaLbhrj+WE=; b=lgZs1ivEPI7cU9BMw2ZVk4Y4bE
	pFa9rwY0iL++45dNIUiCCzGTgld2z3ipDSu3CZwWia4HhNzY5boV9g73H8qf0Zi/
	IHc0Ha283/4mPMQKI7T6/lilnoNiqyWJpZwO5sj5Xyhb8kP48CNdgjvtARmNsKj7
	+3q1AygxdefwdiPnaw6iCL4Xni42WOuto2MqNjVyseYWk2JcSa3Eh/x/E3cBDsQH
	MalM23oSA52VjoMMlR9wur/m+vOPtU4PVr36JJVxLElUV3cf9qfGKeiOUno+NPIC
	d3BzPhTgOmTe8UKU5kMgLp9lAi1svGCtk1UrwpdPHgjzUb2OZAGJEj3VJPYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770961861; x=1771048261; bh=sCSHtwqqXdFzNUPkXP76eNa4M1bMplQI2ia
	Lbhrj+WE=; b=pjhw4KbUMMyMHDI89GQytNatioQ2nNkX9bfRb6eI9m1uz6/AbpE
	KoGpS90khOKs6gRTDIiSqydnndkjRpMFFA/bIGCwf8aAXPgK80GCSlOO3zmA1rLY
	n0RLTuYdiZwDVcpjImCjfrS0yLI8xM6K/mNQ5DKJTjkJeWH5hXs+WUY6SzercHmn
	yRjoQSOyPLaJGCJCcNQ/+TQEKxQGK71LyWPkvugaGB/+RYpPisdiKOv0a5uj2spR
	MgVDvYXO3+AKpT2vid+Ucjke+2GBceTCnMD3Pg9jxyG8W79fBL/ZQdftBBeAKeiE
	JkxP/h95JbNWa9fTw1gxtub7eQlRtJEYjJg==
X-ME-Sender: <xms:xbuOaW4UrHzpIaTqZ6Kip7MbMbTxbDg--udKmKRUiQTN99tQ48wu2A>
    <xme:xbuOaV4mm8FtzLhom171Q0fXYBdapRhJrGuF9Y2MFa-ckSperSvavuu73zaaRZYCm
    8zq3ozwXMoeTLD5gdPdNyvR73ImQNgfHINHQ5M8nJBootrgouS2>
X-ME-Received: <xmr:xbuOaTHAeOr7tCSnwkis0XlmlKR0Z25_VCVWEkdEleJjTZ8CYho72DHNuTshk_ZSjxCUMqiV40vl2t-5CHK3SAFN1gSFab-O6nRoXuwBIf43>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xbuOaeQjHCUHYS9R9oncozB0KrvIZK026vLKZ3McReyfllo35b-kpw>
    <xmx:xbuOacudMM0Dp8_6FB_ba9EpP70SA-LverJKk0xltPbsbA9r1O_NlQ>
    <xmx:xbuOadx8MyoBTh5anRU9-F7DKmQZsvVbF6MFejJ4cEJrpgitlccZ8w>
    <xmx:xbuOaW6Efvg5s4RBr6lG4rGhIvAOsoSWnEufGBgkJPySvbIX5dTlyw>
    <xmx:xbuOaaTxeaBstzbwMcqSHypUBwe2tABQC_vdDYp7pZMzX_NlmkMQ-1ic>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 00:51:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97b48f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 05:51:00 +0000 (UTC)
Date: Fri, 13 Feb 2026 06:50:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Message-ID: <aY67wfgsxJhiSiEL@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
 <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
 <xmqq5x81ogsx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x81ogsx.fsf@gitster.g>

On Thu, Feb 12, 2026 at 12:19:58PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The git-history(1) command has the ability to perform a dry-run
> > that will not end up modifying any references. Instead, we'll only print
> > any ref updates that would happen as a consequence of performing the
> > operation.
> >
> > This mode is somewhat hidden though behind the "--ref-action=print"
> > option. This command line option has its origin in git-replay(1), where
> > it's probably an okayish interface as this command is sitting more on
> > the plumbing side of tools. But git-history(1) is a user-facing tool,
> > and this way of achieving a dry-run is way too technical and thus not
> > very discoverable.
> >
> > Besides usability issues, it also has another issue: the dry-run mode
> > will always operate as if the user wanted to rewrite all branches. But
> > in fact, the user also has the option to only update the HEAD reference,
> > and they might want to perform a dry-run of such an operation, too. We
> > could of course introduce "--ref-actoin=print-head", but that would
> > become even less ergonomic.
> >
> > Replace "--ref-action=print" with a new "--dry-run" toggle. This new
> > toggle works with both "--ref-action={head,branches}" and is way more
> > discoverable.
> >
> > Add a test to verify that both "--ref-action=" values behave as
> > expected.
> 
> This "--dry-run" mode still creates necessary new objects, right?
> 
> Describing this "--dry-run" as not updating any refs is a very good
> thing, which is what the documentation update says, but at the same
> time, we should clearly promise that the necessary new objects are
> still created, so should the user then choose to update refs to
> point at the reported objects, it will not result in a repository
> corruption.
> 
> Other than that, looking good.

Good point, will add.

Patrick
