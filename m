Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5512EBB9A
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432138; cv=none; b=u0Zv63oQWJ7XS088sIf4Mmz3hPbbJaxjij2ne8Tcdf7al5JdqdfwuB9BCzzM10AqAiGBOLiAxnMlyxhSAWf0RIvDlsVfD76LJ79ZMwZI0ZcGsivl0ODe6/34JSmQYtoAygu2ZUnWTb8YQoAEujDA28hQOV43tPlvfMx5A3EeuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432138; c=relaxed/simple;
	bh=hEB7+cuMl0M0Zj/dnO26INxtf7TZqXnLqztBYZ5qDkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXp8xO2TVliXx7IybBkUmKIhMGlwrMSKd3O+/+/5GB76OrE9Zg/qONGk/Udpic1yrkR6qky6p7aoOkY6OlKxdMl3WMN73bgaIUg4v9C+TmQSRCcrqjwAEghHl8CZa2L6tlQcEGgVLn48HZ+hlrStbZWJPpgyTpvUD4xIzS9z2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DVhBPb5/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxQnsBUC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DVhBPb5/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxQnsBUC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 153DF1D000B4;
	Thu, 11 Dec 2025 00:48:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 11 Dec 2025 00:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765432135; x=1765518535; bh=9vSjbwk/zS
	e71iAB/ldC7Bz+FqmQ058wM9i8faL/ICI=; b=DVhBPb5/DbIlaFSpDMCVTk/pRM
	NjX/50J/GPhkd0oGWz4gctxYmqudGh+pLmF/He8a6GYUq77O/s5yheWTlpTXW49E
	QZ1idnnw9HtKwi27KJSFKslGlrXDrPDShCJR59WU5mMbX0sDQ5Y3xeEHC9sTDjun
	fNFuOxsBCDDUDM9eViQSML6BrmSJ7nI1vCvub61+MX4jirDOE+3NuhUXjhwndiE+
	AfV2vpNitRaCasB7mi6EEzmeKI3kTBC5+cz7lBs8JIjuedLSSv65XoZn7v8WruFr
	14ZKRscpWolZoHZdlv0Lgv6PW9xWF/9fEE/X3MeAX523Ma/zsAa0xp9kusNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765432135; x=1765518535; bh=9vSjbwk/zSe71iAB/ldC7Bz+FqmQ058wM9i
	8faL/ICI=; b=YxQnsBUCUd8+kwecoL5zjG54BeZ6QTBq30mbsN5BrSNx1wPdiem
	2gaDtXyqjFLGKAthNf2mzmY046GLjgq/cB6rxuZ2qQiBaRrz/WWYhPyHi8CWLXQG
	FPP13tA4wwIHzoLktF4IhgBJPBMc0yh5kEZTpTHxzAQvvDlvMK1Hy5iAuQsLYG4E
	IGaWJH0EYW8tWRdN/5KYzIbX8GieTxPXjlmkN2Af2d0pHlP/jwsxyewZg5ezU8Si
	7RJrjoEmAh600Ocx2qSofYRRT6PZF40jNfZODc/EsQIuc9MKIxjvJTy/+wMfJxRZ
	hsLrbGX/eRdvL7+HLLlwfd+2uFoL506FPjA==
X-ME-Sender: <xms:R1s6aT8fjVo_rSn6KLCSLCXYjX2FglvVm91YVc__xNUkM-psMhRhiA>
    <xme:R1s6aVuH0KChEY5mv1JJdfHgyk4SB7pIF85ZLzHqo0uu6HaeLMIh3JvWexCgwM39r
    Q4VcUrTUWBDEThYaMNYS21u_bNIZztM8pucyrollo_hv3SPbZBDSQ>
X-ME-Received: <xmr:R1s6aepZkrhVevtLwq8ac_emwgXaBA_0lkzWFu5JUwlQ6jwbJBqroBt58tbDlXRp91wSrh-ilQZDLiFqNJ1nwRhwEYmpVtD9ZkiM80GCf_8f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:R1s6aanNqgqjItLRiy01yuPqsQXB0spvUFlAx48xhMRbXCyzm6h4Zw>
    <xmx:R1s6aazkEQ_kwU9FEpv4IHt9PTytkVs3Gkp6uTzxG53CFSDM2WdGmA>
    <xmx:R1s6aanQOBJrOy6ZUttHnqpVJuDwR82eSn766sDUcrXVfx1LJhTcpA>
    <xmx:R1s6abdgCZNpJM2SZ5B74MRZLhe0IwjLUWFf2tCe6YSD1LVpeoqleg>
    <xmx:R1s6aSu2q2qkR4BhXnVl-jVitIJ_VIIvm_mVwatCiagZHb-8WuJxglQF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 00:48:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cebf3f18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 05:48:53 +0000 (UTC)
Date: Thu, 11 Dec 2025 06:48:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/gc: fix condition for whether to write
 commit graphs
Message-ID: <aTpbQt95JHeExceR@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-2-ef4250abb584@pks.im>
 <gdyc7mdim2p32fesvcb672ssozoom4pdi7dyygacj3s66v7gd4@ydzwijirha3a>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gdyc7mdim2p32fesvcb672ssozoom4pdi7dyygacj3s66v7gd4@ydzwijirha3a>

On Wed, Dec 10, 2025 at 01:49:39PM -0600, Justin Tobler wrote:
> On 25/12/05 09:19AM, Patrick Steinhardt wrote:
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 6b36f52df7..6f3117304f 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -206,6 +206,32 @@ test_expect_success 'commit-graph auto condition' '
> >  	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
> >  '
> >  
> > +test_expect_success 'commit-graph auto condition with merges' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git config set maintenance.auto false &&
> > +		git commit --allow-empty -m initial &&
> > +		git switch --create feature &&
> > +		git commit --allow-empty -m feature-1 &&
> > +		git commit --allow-empty -m feature-2 &&
> > +		git switch - &&
> > +		git commit --allow-empty -m main-1 &&
> > +		git commit --allow-empty -m main-2 &&
> > +		git merge feature &&
> > +		git branch -D feature &&
> 
> If we left the feature branch instead of deleting it, would that help
> test that commits are not counted twice?

Indeed! I couldn't make any sense of the results at the beginning of
writing this test, but now that I fixed the relveant bugs we can retain
the branch.

Patrick
