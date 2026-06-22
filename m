Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178452F5485
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135369; cv=none; b=N6ksrQY3yBxDzdtFLXTXcsfY5D9Dzqnn5ODUAy1Npcs1xx4EyZXVgQ+xzDSusNwTXKeydZIuwwy9SRYYCEXePyvkQm5b7T7sqKI3D8fyheDfjpEUYeyU0gsAKz+v1BdHiOdA9N6hb9dI4e0K9ZUNsee/NsogMsZZRUtP697SAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135369; c=relaxed/simple;
	bh=6R5PstetF+2Eal3OlY6B1T4Oq9MXKodyK6D9CHuuNqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LErpyQH5LxGMzkBlA1YC035h5ur53+Oo57kIm6Ridcy+iVq/1+U6mgV4GW4KVs7YfCklLIwe0M+Bb4/ZZnXHDaoFHo12QiwgQd29QkwHMG4XwmHnmS66ouwmciFpRsEkO9Sf6plGQxH4IH7cqqMKLP/1aVvTPkhWxRzIVWI4/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTmwFJ3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dcUQoKwu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTmwFJ3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dcUQoKwu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D59BEC0389;
	Mon, 22 Jun 2026 09:36:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 09:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782135367; x=1782221767; bh=4LHat0xjq0
	kEVxT7HhvdA/Hb6dMJIort4MxVVx+ZZbM=; b=KTmwFJ3C+yPkFWSjNo21+Q2xxK
	aesgMWEDyfIe0Xu5md8w56xRk+hFqBO/VxbxZ+Z5Lu3eaIedCwfjKJhGp6MJdp+Y
	1KUfv4XxDth1Ik/aZ2E0L/fEMdwJ3V2SeKakH7H/gnK1PXp2XpUtDaLxnU5kOilG
	POANbQLtgODT1fTDto2gmPZM+V+CRtv+91jzERoFUNuTDdz3YmnNHSpsWVJuyD19
	DO5/htqzMV/7wssm9fYsxZra2HK8OnsiZ68QGKmc/Npc6e+ts+caJgR+aLnlSWOh
	0+wmkJ1p/koUB+2ujPREHVpA880RTqsf22zoQtfoBUJeTp5iV2ukNIjSTYKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782135367; x=1782221767; bh=4LHat0xjq0kEVxT7HhvdA/Hb6dMJIort4Mx
	VVx+ZZbM=; b=dcUQoKwu5wtS6tGFVKmc2GJIk7Jsf3wYrH06zl5NwcSZBvUPBUc
	ZbRCmc5DubOafaMaQiZqx3QGylAYHJSynz/mSY3vEGKFHZ7Yss3xZEEzpjkh1fA4
	h2gJwnIqJSZl4/R/e6jyaQkqD5wt1I+X8gvW9JpDbwSKz3GJexOzzlRMOSLSo9cW
	Y2x+ZRUH4Mzs5bq5mO07hFi5XVptmr7xgZkp6a3RA+DPfgEwhrvrpCP9nl5hQ3Yk
	M33sWz+Ap4mW8h+4DjHiwq0ZzXoLOumDqQKUb5xl09xFAurJzGZJTQrwOtScwoDl
	UWgZ2z+Ueh3QCPcjQL2sTD2FJqX+M3V8b3g==
X-ME-Sender: <xms:Rzo5av3Oc4aCVaN_HnH_C7yZvyqJutS_jxAsanbsF7lHcgymYAIniw>
    <xme:Rzo5apkClSVxOl30E8Jr71erP3FTwWtBbYUBn6P9e4QwjYqMMo17EznTGd5vEhy3W
    KuGDNAp8WyJaWONtZXFfYSYbkIqIEs23xwd9uyG5459UMyhVG0maQ>
X-ME-Received: <xmr:Rzo5amW7dHk4IzQTH2A0zTOifA9kH5wYepTl1AX0DMXdNMhsExbInhfGkgKIjQpqsiHwsxqrSlgK6ClrGu53j_DC-WkFZcaOtzxssWTB7Q>
X-ME-Proxy-Cause: dmFkZTEBPzhaOuGrQtxcRvL2q6523i6wEhMw+tq/ptPnQjcJSw590biTAHKuSQQh4fRpd4
    MUSdflARDi/+JInvHVJxCl6PgPIuzi5tRqAq7VemUgBcO0B492oXRNYtPnyQMxjJtsptVm
    7VjOR54WdnInpbfXsC1+Qhk/KiHU2N5O+cetdulMrH7eeyTVkhoB5nszxo2XwvzUomLbmV
    rDauDQzTxe65rIsFYjfFOesblN3ny6O4FLDCN/xpsvP0/mwDiIk11SWqZIMJkwdIDaNRMd
    zbOcUtMDe5NCmYP8HjxDPvrz4ndIWJibyShPXCApwlFEYN71GFb8joeFbZdPRvoWsqGhgq
    LiEYO3lr1vlldtusr9yL2F90jIVxqr7TYn5hH9gH6qYykGji6wy2js62HtPHl5ht4qFpcz
    O9wIv/FLmK5mck+KS3/MwYlkfMHeLHMIz8UZfLLYe83TO9rEKF3T6GWSADBErH5AXio+9Z
    CQp4TJcqSIc+/vOaR2CFd5lGaYt6zwMusuc/HYFIjr8oOFTfe2ZRy97K1Glr+a+LQSTrjd
    TaQDUrJ8V2gCYpBrDDfq/JlrP0etRU9O4NozmLyTyWhZl3CbfisGVY/XtZCW/oIT0sCcq2
    qCUjgZ5IPCL5tkSUKXCnsCrEWA0XJvjvORpGo1RJFm/ISNQzCWsYRffM3eSQ
X-ME-Proxy: <xmx:Rzo5avtEQiMICOL0HBhUYEhmSQEedc-HKtGVQdygQGz4NBcWV0nrBw>
    <xmx:Rzo5apY6kdJLyXdtaTjTmcNUME-LBxshRUGPqv0ejAo3TIlg4rPu0w>
    <xmx:Rzo5auX9-Y71QCbnKoBwT3ARbz20A37M1-SJ6GskT60PiP6oUrbVFw>
    <xmx:Rzo5auQZGhfO8GUVoksNVnniSJtkcIp_p1_CK9BEifL4fRJRftpE8w>
    <xmx:Rzo5aiB6QCCh1ynnCMZCe_zDbq1PfV8vAPuvnM4d4LVDscgs5BwUXL6G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:36:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3651eed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 13:36:02 +0000 (UTC)
Date: Mon, 22 Jun 2026 15:36:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
Message-ID: <ajk6QGB8raf85CPo@pks.im>
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
 <xmqqv7bei2tf.fsf@gitster.g>
 <ajjspU7lJ01GgrBw@pks.im>
 <xmqqldc63f8g.fsf@gitster.g>
 <cdb16758-dd92-4b8c-8e82-8c607151449f@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb16758-dd92-4b8c-8e82-8c607151449f@redhat.com>

On Mon, Jun 22, 2026 at 03:13:05PM +0200, Paolo Bonzini wrote:
> On 6/22/26 14:57, Junio C Hamano wrote:
> > > [1]:https://github.com/mesonbuild/meson/
> > > commit/17d1cc60ed8246b8e7f0786421bf1cdf5cb19254
> > I took my inspiration for -Wl,-no-whatever from Paolo's other
> > attempt, referenced in
> > 
> >      https://github.com/mesonbuild/meson/issues/15553
> > 
> > which is
> > 
> >      https://github.com/mesonbuild/meson/
> > commit/7c901d7a8af214e31788eb6d1a1edd5b75124e66
> 
> Yeah, it makes sense for Meson to disable it unconditionally.  I wouldn't
> bother adding a check in meson.build though, since as Patrick mentioned it's
> mostly a nuisance.

Is this something you want to implement in Meson yourself? Otherwise I'm
happy to create a pull request.

Patrick
