Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6541876
	for <git@vger.kernel.org>; Mon, 26 May 2025 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241109; cv=none; b=UYeU8W0k5cZ9i3Ct4ILPYUUQaZXMEXwBt/u6kc6UBHX6wTyi9Ouo0MwYZNyUb73aJb334ZIkXFXysImXplYUMlTcPPVnPJiO7gKCW6QXoAhMLzbMZY8lklxo9wLMQZBKncWD3Qoq7pltndYiIq41j2WwpfHQFmIvN/ovXDgnBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241109; c=relaxed/simple;
	bh=DmwdhCl7WlfO45S0dR9cLccb4MTgpjcAhndUpko9Exg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtQmw/OFzo9qRbxSkyh4EizY6I4fKH13mq9q3CXD3dAXl4RCITltqI0avqFRntBDFn2RGZ4GuCohfJx5z5SrY7SLWfXhl5eqo3l3DbqM6tJIZrF/sr3YX4AsyJLzq2UV+Z9RjO321I/9qCpnT0ixFjBd2rCwg/++/foLzBCycR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LeLV9Rcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtqmpRwi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LeLV9Rcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtqmpRwi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 55165138041E;
	Mon, 26 May 2025 02:31:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 May 2025 02:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748241105; x=1748327505; bh=KMBHD4N1ir
	GNsUU4j0h1vKnKEN8KvxvpHnx0nVNg8S8=; b=LeLV9RcnE2+33zlSxPZ6QzE5qc
	wXDzQ0aeK7nDW02FQit9nnLhmLYJZcRDu0CpSAxfSzdQHQDquzL+Ujdq1XU9dG3W
	fWGsqypEYB4cQDSaUqvzOZPmHH9+Vn1dZdFg2tHVzXjDOEuwwQr/ID2rVZTsbJz7
	UvU6sba8GN3CM0CGQ4+UKOGRMy57H55sOZnsKGdCVNJxY8lD/imfVTuIz0+buIVB
	GsjiReQj0muQGwRRyhbTDZy+DVvJNWk4z6T5DiUU2aTyEhmd06bZtKkKLfygYNGJ
	xylp/e9T+P9fcp82FR55aB/qDvIUJoW/IYwzCPAjgVTnB65/3lMlAFpWlMTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748241105; x=1748327505; bh=KMBHD4N1irGNsUU4j0h1vKnKEN8KvxvpHnx
	0nVNg8S8=; b=AtqmpRwiGPsmL2YO5ZSXQUW10s5ELEaQY5QPV6CLti0G/NOiNA/
	Yh0R8lLZMTweVupa/ZhSLN9dnYl4ugrXQ962wNyFJqlG6vgFPE/bt3GP79S+mb/o
	keCmERqFXwWM3dE382B7ZLvy8gspd7dUEewi9X0999GlNMaxsoSVyVbPP57Gf8uW
	OFspdmslXGADOtPfL8p47pRr3OvcCCbQvhnkKpZ4XGeFBYtQJO8k1bKcHTIxk+hs
	fQ5/qaWuCZKImlom1Pr3mAGwzKVdgO3BR8yuGCQprYsx2Sq30IBdcvp+IhGDWpPc
	5FZSQfvbwoVXXskbckQe2FGRHfq08DpLxHA==
X-ME-Sender: <xms:0Qo0aGJcDXXoDlYRp6U2LXO8HGX0M4O51wIj2juaoDUMhNNrb_cNpg>
    <xme:0Qo0aOJ9_kW66ZfvMfyoyVXj8bNsOqiio5o7rdDEou3qxjslKNssXivCgb-0MUTad
    zTG-tDbEI98yredqg>
X-ME-Received: <xmr:0Qo0aGv9LHL4bUrMIMBMYR3DdByjpoAQe_utRJXtis3W05EDsaEtGnscmsPEH1zAe8Ih9iEBTtLgPJvuJCDjGqT82P4L1colzlEPGrxivcBdtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieekudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhhedtvdfhveelvdel
    fefhveefgeeugeehffeiueffgeeigeetheehudeffeeigfenucffohhmrghinhepnhhoth
    drlhhotggrlhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegsvghnrdhknhhosghl
    vgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:0Qo0aLZ0Xbb2bZ8MWb7J61a0KBzIujllwIUzoo2XxZoSa-xaU-fk_Q>
    <xmx:0Qo0aNb5sUTjNWbASYLBLYmaNhz0iqPaOpEPDk7mg9n856U8g7jrNQ>
    <xmx:0Qo0aHBAbIwhNIEjiZfzE4grTUpgXSZeUIEE6STAKE9xy1-csG7CMA>
    <xmx:0Qo0aDah2QXbBEgisFaOsG1WLwbjWn_6P_4mx0kpXOeXZI8-XJaLBw>
    <xmx:0Qo0aORMkO20pybjjzROjWFbFB4kgzzJl0cvqwV-c1Mx2muQG6zrn28A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 02:31:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 269de906 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 06:31:42 +0000 (UTC)
Date: Mon, 26 May 2025 08:31:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Message-ID: <aDQKyTOrh3yBe2ux@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im>
 <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
 <aC3SZtwQSt0mSVuo@pks.im>
 <zhkp5ieg7d3itnwzo6f435snmtb6kseunwgrj2omu4gqemistg@6af5cxhswamk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zhkp5ieg7d3itnwzo6f435snmtb6kseunwgrj2omu4gqemistg@6af5cxhswamk>

On Wed, May 21, 2025 at 10:50:03AM -0500, Justin Tobler wrote:
> On 25/05/21 03:17PM, Patrick Steinhardt wrote:
> > On Wed, May 21, 2025 at 02:07:25PM +0100, Phillip Wood wrote:
> > > On 21/05/2025 09:27, Patrick Steinhardt wrote:
> > > > I agree with what Junio mentioned in a parallel thread, especially
> > > > around Git hooks. The expectation there is that those may execute other
> > > > Git commands, and that should typically be using the same execution
> > > > environment as the original Git command that has been invoking the hook.
> > > > So refining this patch so that the mechanism is opt-in probably makes
> > > > sense.
> > > > 
> > > >      A slight tangent: I wonder whether it is even required nowadays to
> > > >      adapt PATH at all anymore. As far as I understand this was a
> > > >      requirement back when people still executed dashed binaries
> > > >      directly. But nowadays scripts don't really do that anymore, but
> > > >      instead use the git binary. And that one doesn't need PATH to be
> > > >      adapted at all, as it knows to listen to GIT_EXEC_PATH and its
> > > >      built-in path anyway.
> > > 
> > > But don't we still need to change PATH so that hooks, shell aliases, git
> > > rebase --exec, git bisect run, etc. still run the same git executable that
> > > started them? For example "/usr/bin/git -c alias.g=!git g --version" should
> > > report the version of /usr/bin/git, not ~/.local/bin/git which comes first
> > > in my PATH if git doesn't change it.
> > 
> > There's two parts to this: PATH and GIT_EXEC_PATH. We do have to adjust
> > PATH indeed to contain the location of the 'git' executable. But we also
> > add GIT_EXEC_PATH to it, which I'm less sure whether it's actually
> > needed.
> 
> In instances where GIT_EXEC_PATH is set on the parent process to
> override the default, wouldn't we also want this configuration to
> propagate to child Git processes?

Yes, but what we should be propagating is GIT_EXEC_PATH, not
GIT_EXEC_PATH inserted into PATH, shouldn't we?

Patrick
