Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B112C465
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795618; cv=none; b=DQ7zcJItSlWTA5GSfVduHMyOBK3ugdIl/ph94o0wKVkIl7Wbol7rbrzIIQeTgV0unTLYlCGrYCgKCUH4mVmwF2oChrcWOM9mN0ojQQyoIJdFAX5uIsV7+ZhnUPH3jjoy1ryQC+tdp9RvCncK23cXUjrfTPWpUiPw12nq0hQbbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795618; c=relaxed/simple;
	bh=RZzPzSunklLGeKZzTj/tP3QA9UnrU8pWs+S0Z0cUG38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK5XTvP2azawucokLWM9PVwl+Jvo1/nkoM8RZMRd7ZMWT4O115SSsgaRidnBldjwBzln2ZfVXP9znBZguHIibrzbDu3ETxmqq+bVEb3Q3JpxswCST36PkDd0JrBj8WkDQsvUKThF07jki6SOQMYta9+ldsG9KQn80fN16i8oH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BfouaZ7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c14Ei0Yb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BfouaZ7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c14Ei0Yb"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 36268138FD03;
	Fri, 16 Aug 2024 04:06:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Aug 2024 04:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723795615; x=1723882015; bh=eRdCt0G6sK
	Ji3k9ujtM7HqaAHB7o+MCW2xT/5hRfetw=; b=BfouaZ7zZrTG6SamDCv3eNU3ni
	VU+BlQW9ypjjyB4Yl1k7WpWUmIwVk9V84lnETr2P+g/N08M3YMpIYAUxpPRL2+aO
	luY0dL5nCufgPQgu++5rBegr/7ZUsW2WKFMi+4KPN91rA+Eb7pfOojq3WVwfawhh
	CTj/gGuSi4ZfSRjF9b8GLHqWO/WA4scT9kmH34NuBWQ3LJgp3munRE0LLJoyTr4Z
	GK1z035RrPXjPSE7Tc87/tR0QaMYgZ7dmRxvcT4KiAv7SYnSmvYgAs1n2jlT0BWL
	3Xm8EliWIUGTK1pIxfBUdPM6qVnaEGcFjTVXdrtq8Qk6MWPWu50GGAGhwOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723795615; x=1723882015; bh=eRdCt0G6sKJi3k9ujtM7HqaAHB7o
	+MCW2xT/5hRfetw=; b=c14Ei0Yb64+hc5eyRzhDTNGpM24V+89HJykDDIOExn7V
	NKK3/j6k0g+EW5583eraVXQzdhTlAmGjBxXQ1BHFCnnIgi4IZduxrN869m8HdD+v
	GF04INRkIXCJWzs1RoIHYmNYoyx9u7DnmRc0iHkuUL5Dkqa2uJhVpNPcBfiXWzaJ
	FgNpkSLwljxefoEc5z4bvX2/g/qtfg4IEAHVYKHS5mqHtTnv5w6d0IPMz7Y8LlW/
	JeRoh4dV2ul1jDdzEaU6ddXTQkL13bhYdhKX9vejZNBdFWTa2aEd4bkOD/qS61Ji
	eDZKHal2ZD27+tvfsOwtNvLWxmVUi4o3CJPFZr0xrg==
X-ME-Sender: <xms:ngi_Zu5AvwaFF8pNhHwsGpVXz0PNylxC7NPQ6Yf0k6dj4752OyevJA>
    <xme:ngi_Zn6VIjsJ9miCLFFQSAcZVd-Uq9q5uJUmFDS_i_Y7qBhl7m1M8QXOsPYxCIopl
    9UTzODjo1zxrvOFaw>
X-ME-Received: <xmr:ngi_ZtcykUvX3MxM2L4cohtL4-koyyXMEuw4fsOtsaOh_zaSkkkd76wBdbWoq8psE6XaBGy-_IoW33H4-LRKqA9JIOE6w4r62IPReRjSnkzmMvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrghm
    vghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:ngi_ZrI7lzXxWBf_rwT2vbT03aFUQnHPSrOU-1iD20iJZvmEp8RnIw>
    <xmx:ngi_ZiIbYlED6h84FIQIa3c6t7JaOVjacCZxjMvroLzfccKFvDsoDQ>
    <xmx:ngi_Zsy1ZMsCDIgx825F2PDJJmCM20Gba4Y2JLklYEenhIBJt5pvVw>
    <xmx:ngi_ZmJB5AfeTKB9DwgFPHzDOL2G1SWxW9o6uXbmAR-jwYGmoTez9A>
    <xmx:nwi_Zkh--hqFZAuzpqgrf-MNdn3PHB25V5WZV1fbtWF5E6X5GW79OXmX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:06:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee950035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:06:31 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:06:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <Zr8InHskJNixuSWW@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
 <6bc170ff05d38845a012ce57e580a0ddd18f1143.1723712608.git.ps@pks.im>
 <xmqq4j7lvk5z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j7lvk5z.fsf@gitster.g>

On Thu, Aug 15, 2024 at 09:13:28AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/run-command.c b/run-command.c
> > index 45ba544932..94f2f3079f 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
> >  
> >  int prepare_auto_maintenance(int quiet, struct child_process *maint)
> >  {
> > -	int enabled;
> > +	int enabled, auto_detach;
> >  
> >  	if (!git_config_get_bool("maintenance.auto", &enabled) &&
> >  	    !enabled)
> >  		return 0;
> >  
> > +	/*
> > +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> > +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> > +	 * retain behaviour from when we used to run git-gc(1) here.
> > +	 */
> > +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> > +	    git_config_get_bool("gc.autodetach", &auto_detach))
> > +		auto_detach = 1;
> 
> I think this needs somehow documented.  Something like this,
> perhaps?

Indeed, I totally forgot doing that.

> --- c/Documentation/config/maintenance.txt
> +++ w/Documentation/config/maintenance.txt
> @@ -3,6 +3,15 @@ maintenance.auto::
>  	`git maintenance run --auto` after doing their normal work. Defaults
>  	to true.
>  
> +maintenance.autoDetach::
> +	Tasks that are run via `git maintenance run --auto` by
> +	default runs in the background, if the system supports it.
> +	Setting this configuration variable to `true` explicitly
> +	asks them to run in the background, and setting it to
> +	`false` forces them to run in the foreground.  If this
> +	variable is not set, `gc.autoDetach` works as a fallback
> +	variable and behaves the same way.

This isn't entirely true. `git maintenance run --auto` will not
background, because that'd change preexisting behaviour. It also would
not make a lot of sense, because here the `--auto` trigger tells the
command to do maintenance as-needed. Coupling that with whether or not
to detach was a misdesign of git-gc(1), I think. What it does control is
whether we detach or not when automatically executing maintenance via
`prepare_auto_maintenance()`.

Anyway, my fault for not documenting it, not yours for getting it
slightly wrong.

Patrick
