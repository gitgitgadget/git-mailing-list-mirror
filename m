Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91473BA253
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323639; cv=none; b=LzjwNP6qeKEvu0d+QjfCH2vcaRP8X5hRT/VBtxB+DH+9UgIUXw67Huu/6PCtDLqKq4h6TgCfmPoL1ZP07Jc/HmkqJVAx5WA460LsxalO+8aK50ye7qooWIgMawcm9f2tOEoXGfuJ+SA1t6tu0G67bWV2dKk0sGMM3fBEfbZmaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323639; c=relaxed/simple;
	bh=vZ4swa+xxODExLmdtNu6dRua9TOMYMrC17d6RrMzpgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyaF3ZDpYNagkujkZktamrZ02inodwygjk9kB4iaZGDZGXxWrBCtn19NAXYwm9mIUuw10ePIJYs9qnKeT+H7VfCL6eMQRO2mQSK2kJfccR32slgiAPHi33w/rWJP3RrI918SFuBYCGVme2c7AItHVUK75Zmxh6420CahIJEfwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M5Kxke2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9cGE6nh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M5Kxke2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9cGE6nh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 22D4CEC0188;
	Mon,  1 Jun 2026 10:20:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 10:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780323637; x=1780410037; bh=vVsAiRxd2n
	5TWn8uSyy6/gbQPKW8jF5VoI+klHra8Rs=; b=M5Kxke2iITZLHMa6nbWeitAv4K
	0g2jRFZ0bL2zm7nMpt7+g00uLN2JA4fO5dealSJv2XLFSlRSgFhoDM1XfT0r/DG5
	lnOpoD6t8kmFRw7Tpb/IxDLwUqNAs4jnnJaQgcp7Dsaeor5Ug+lCIfVwIcWPuQu2
	c/Gbfp21C9f9chxs0h5lp7uaQY5NMzs9JVnKQklKONT3UzU/6ABM9QcZ7dOC5Uxj
	TTGPV8swWwfaXeh2Ss/KGOEVSlwJLaVnnSIaMDv39TwpPsqx1CS54kJRcPuhl3nN
	SgnLJ9T1m4UH2BUp1DadseYLv3DcH5inC+V5OUt+Dywl1Ls2FPaxdKZFU5TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780323637; x=1780410037; bh=vVsAiRxd2n5TWn8uSyy6/gbQPKW8jF5VoI+
	klHra8Rs=; b=g9cGE6nhdLcze4MFO8eAhSd0B4hAWZJjBi3PHKXFZDHk+ry41Ot
	5OkNTmaNE3mqHsXmvHqHbKyuVJM37NY24wUZEunTj1pIPMS915dDbMD9uLQZ3NxF
	OGT1Cq2Fx6N6yMWXV17603X2o0AiD3d2rKsS4GurhNUts3797VtCi4umW2zpipgw
	Q9UUSt7lr3/UtYM+69aVSE2b1MYACqtbSAEj39V6jyvtvnb+ZIG/2duBOwGGwsGV
	NErmUcFlz+4k9XslKrXUhTI85JcSmekSkCEUybs64NHY+EgeFHGdNQMXvBPxXysq
	K8BAd3crHfPF8/MII2vpXvg6ROvwg/dfijg==
X-ME-Sender: <xms:NJUdap8jMK4OkhYIcVzhg887HVgSG-9swV5Bu_A9J0aRJ4ZlDidYzQ>
    <xme:NJUdaleI3gvrnvZJb748kI5gwF62NCOtmFZrMdd5dsQh7uxl98Huu0cNw4hERRaf5
    6BOa1wELaimK6a9a52h22Rq1H9ub0zx5vxJ3lUV1y-CQrhEPjrb>
X-ME-Received: <xmr:NJUdaqGy04gVF_--Jz0BJ2DOVnPYfX_7XUonyqNY1hfbS521WU1sJKyzfH3ShG93Yi6i_6dEEEfLkc2KYrQdfHVUkPAr5UvGK59tHR-Z3EPN>
X-ME-Proxy-Cause: dmFkZTG3G0cVIAs1v/CfTQVGVXJE2xb9bLD2kvwhIFDdqojKS39hN3d8wETsqya+BRKKLZ
    FfeevzQiyYRSz4sBcL33IUIL6DBfgvJEyifS+CjpINQObOd9LUwkOpZNbwkCKMrHyAkXil
    JdLI4Gg8c3o+Z4eTn7SpiQNixVkliCyKWSg2OtKqgNb/Vh90rV5m7nqsQBIrEBvjCgdWmK
    FvzqmZpF9vWrAGBlYdjsdvhMKwNYMQONBGekIYDYX5Yaff7RB7GU+K2HaiSif5aGuLjgJv
    y+jsboWIgLvVZ1uMX0Pz6IVeHNn0S/zORUl/UbF6B1/j+JC4357NN6GQFJRVP0WgKb6uR8
    U6rSMy6JHzGKPf0K14Ln5og+q5hldnfUthua7yv9sJ7OfOTXn2HNdxc5J9nUJSb3dqgZJI
    hbVI8BzkRDXVQQkObA3YwpRZmZcOlQeMBxc/UDCGan27Eg35QYiPA9lpFDX4oMXwWk3j6A
    vqXwed0jLlh4OHuEEsgCk6WzkY5IRoakVQcj5BdhPux0kQVtn6rYwHBEDTwkFUTLa7y7lK
    zhC5gOVtUfP75CYVriVzxgxqu8AcQJuR3eMnjun8iXdm6jYaZ5KlbLAzagQ2JkDdc/k/am
    2jK5g7kbI70Bm9w3QMFx86RdWCvpsGrp1xEx6FCMwtFe9T7alfzMMlKR85/A
X-ME-Proxy: <xmx:NJUdarc1ncmqP6sMsbTkqg1nrzjypBwFmnXWENjRJdrR3doVvK9i6Q>
    <xmx:NJUdasFSubp2UtP6h-yELwkt30DNeoSPwoNkgYD0HuSn2oKK2qYZxA>
    <xmx:NJUdasViXAw4cloEb93Dbepajj4-z6DTL7bQPyUOBmrQ4IWMer0CIw>
    <xmx:NJUdarIZmZVBo_4sRPCtZ-R5-kFzTAZ7dKA9eEEZSw3Xl04KtXY-SQ>
    <xmx:NZUdak-aFm1FFvWqaHXUpv-DyTk8y6YM9O4sw9KFSWpf_m58X1QYlqMz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:20:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d37d6fbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 14:20:34 +0000 (UTC)
Date: Mon, 1 Jun 2026 16:20:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah2VL-ftCQelNoOc@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>

On Mon, Jun 01, 2026 at 02:48:05PM +0100, Phillip Wood wrote:
> 
> 
> On 01/06/2026 13:10, Patrick Steinhardt wrote:
> > On Mon, Jun 01, 2026 at 11:31:46AM +0200, Kristoffer Haugsbakk wrote:
> > > On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
> > > > diff --git a/git.c b/git.c
> > > > index a72394b599..6bf6a60360 100644
> > > > --- a/git.c
> > > > +++ b/git.c
> > > > @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
> > > >   	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
> > > >   	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
> > > >   	{ "init", cmd_init },
> > > > +#ifndef WITH_BREAKING_CHANGES
> > > >   	{ "init-db", cmd_init },
> > > 
> > > This can be marked as deprecated.
> > > 
> > > 	{ "init-db", cmd_init, DEPRECATED },
> > 
> > Ah, indeed! Added locally now, thanks.
> 
> Deprecating this command seems very sensible to me. As well as marking it
> deprecated, do we want to print a warning when it is run? I imagine anyone
> who has this command in their muscle memory is unlikely to be reading the
> man page on a regular basis so wont see the warning there.

I was wondering whether we want to call `you_still_use_that()` here. I
found it to be a bit heavy-handed as it's so trivial to replace with
git-init(1), but on the other hand it's a trivial thing to do.

Patrick
