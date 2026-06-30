Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334E3403F7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810325; cv=none; b=RYLWVcMZ8OW4jyosueMXnAm7GGarBDl5ay8zulCgKoknlCdBF9jUpgJL2+8lLWNCD9q5pAf1XgCzNnK6ZE1S4pM0CKVg2dtlQ6VrqthDldKcpElxMUcxSFI3e+G5hiaAimNAiqA2uhdVXIPipSo6dil6qqRQrY5fslmhNBtxDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810325; c=relaxed/simple;
	bh=r+RYV+rCUqBozviQnCAC8i6KHw+NnVy7UeJ6JOrgwnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeBdMQcCTTLoRO3N7SmOCpy7MJwr4VJC5czbiQZmXjtCgTUFFKlSmiZgf6x1tz3Ka8VO/Z3RC0bU/F+3t4WcwmF0dJAowV3QBQi/1wCjeEeldyWHyYX3qw8PZeQ8TgKTLX95NFYi7UTnFKg4wh+PnJaNrwboHe9iiOR9CBU1y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hQZkS8Ih; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbdHFdeP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hQZkS8Ih";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbdHFdeP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBE907A011C;
	Tue, 30 Jun 2026 05:05:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782810322; x=1782896722; bh=3RmLbqlPlp
	+g0oaBMaYBBzvHgHceZ5XFVQtrl9FeouI=; b=hQZkS8IhIsFDJqrGqwZxSU3VmE
	7Dl60Y7Pzdw9qbrpCwHiZaShSAQ89Jxpi0wkvpP05tUpOGdN5FOjdexf2Ich2h0O
	9I4GzdOcMAKHuJYxaHXy1tba8CSt3eg485MJ1HZAuuAkdIxvoydVpFxA/3lVR6fH
	EzbTuhi7FmwpZyRASWeZxmKBsQZA+N/QwJgRmIsvs/jED59y1+/6lyiX7kFmwlOe
	CjzGzW34QDPqS4oTmPszjnFqGRyxJCX2XlV4Wa8bNVOdeVtWndaAHSiSa7kpvk1T
	ubnnBMgXemMuYwiMR5TdzzCrH2hw7yDNxeh76nrzeZ4g8unPZw/4MElooyYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782810322; x=1782896722; bh=3RmLbqlPlp+g0oaBMaYBBzvHgHceZ5XFVQt
	rl9FeouI=; b=cbdHFdePZ/sIfTe0HEs2EHetdVZ+2BfOSTEPP5N/+jcYVRhyrau
	WwD+SFvsLu2+WxVFegeJTJW0pIJ480c0WrnXp/ntXj0GXxaFvtw/bbE24yG793Ag
	amfaafK268wFwHNQERIGZfWeWqU9vbrwm/IIu+6YZZJ1xtgka8492WiROkomd1OT
	+UgJ72lOjvYT46qUn0UBwapTW15ZvA5NPxPOZCl7RslxvsMagiWkiW9oH0arXAan
	VPD6ink6Qqe/cSCbuJlo22MEUTdW+7JCYx6LqV2ILXXOOJ5lGj6fEQy2QJ+YEWMp
	D9LfZaLzwt9kTSKwgZp6SN9BzyeSdLZM0Gg==
X-ME-Sender: <xms:0oZDauOQb19I9tZ8YjCZXnbmeNbH6g-URiLlEzAkY-LKDXIcP-_ymQ>
    <xme:0oZDaj9jH626Gb7a8-fcX5jDTJaaQNRoHTId7grxm_YfXiyRy3hID8fWdkrFwtE9M
    HxVoQ3ghaEmUqPoYhWoWIqQx8_7cJb1qElRhA5eTqQDuY1m3FBPMA>
X-ME-Received: <xmr:0oZDaqTphXdr1e64tmcsB_6GEL_BoPihyGCxR4LURNwZrOSog63dLOJsj3_QUAu3T6yu8tblfwa7AI2M-m_5FgvOXvTyzTR9lFFc-W_s0bGSVg>
X-ME-Proxy-Cause: dmFkZTE7h6oGF8vHMf0y2P/nZot2Nf7BJsYNv8G8sDRh6MnYNup9ZW2sTEoKfI/QhqiINI
    94q616JccLVx0CcwpGId/UxdDRBg9bOfbFyqucibXjex0Vhv7RJOhm/7olcD7p5K217xnS
    UBZz2TclTyeadCxQqR5XOFvcJL9SSmW2xOcfc45pGubk+anbpM1+J6lT72vRglFpnJUdEh
    nwG8Gqv5BHYPClUYZS0huArRLfGXCY8lsDN3wu6OtU6H3eNuSj+QPgJBSEkKbB8mEkGUdR
    GE2EfbO+aZgrY51rbCQqESXK976jsCLr5gdQnjNjqBvd/ZR5Qpi44mwSC8YTYVdeu6mEhp
    2pgsFHCKmhFNe5PGKMgP3dQJcnCKQ8Ie62D2OUXOaOLnFVVge74M5c2tq8km5e7XgMVYBj
    JpW0EnaBSuERiPU+PuIguLa9WSigfTKMRyMqwt68LnE5kyTBjsyzXaUsjXtlwWXWWdNrns
    Hw1urpJYiwlc21tSjZOSvVjiMQ09XRkadF7zre7rIzRbacQJHhINSRxCUtoPR8PX9MfLlP
    KWdtYbpas3oz3ZwozKSi5gLfRxsjqMep/sqiqo4U7lpVWKduNEthiFxE/w47dV4hnan5IF
    xfuqeIQNnkgTf2DdW0erlkeeBa+EiqWDiDoBW+j7MGkYOs2wQC8a1d9p6Jzg
X-ME-Proxy: <xmx:0oZDatngPaiaJNwVCmd0Vh2e61yxuqAsQUD51ErSoC5ib3uM-t6EOg>
    <xmx:0oZDaiToqF0Tj2cLcMDAOf-NDIrRpaXLT9GdOPKxeZE6hQZZoUT0bQ>
    <xmx:0oZDajN9QSkj1PMCL-E__xUkLojtk5TMLyopYIKO3s4Kutw4BqMv9A>
    <xmx:0oZDajU0TZQkWOxQXjSQgjwtWUKDqgXSrVposwq4tdufAiMyTINVVQ>
    <xmx:0oZDats1luC_aC0sfxnyDg24aWhGwZ3d_wD63TFLnV4Ji0OhzcNpSFad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 05:05:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6263d2ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 09:05:19 +0000 (UTC)
Date: Tue, 30 Jun 2026 11:05:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
Message-ID: <akOGzAq8Is7ghgIM@pks.im>
References: <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
 <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
 <20260628075716.GA3525066@coredump.intra.peff.net>
 <akIfsaVMB_S6kfJQ@pks.im>
 <xmqqldbxz9z4.fsf@gitster.g>
 <akKYv3nqX0BXcavu@pks.im>
 <xmqqik71xqtc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik71xqtc.fsf@gitster.g>

On Mon, Jun 29, 2026 at 09:19:11AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> pushes only to "cast in stone" branches.  If there are other
> >> branches that deserve to be tested with TEST_LONG upon other events
> >> that the existing GitHub Actions CI does not trigger, it may be good
> >> to have GitLab CI cover them, perhaps?
> >
> > I'm a bit hesitant to do such a split, mostly because the canonical
> > source of truth that the project typically uses is GitHub's CI. So I
> > want us at GitLab to be able to catch the same issues that GitHub would
> > flag. And if GitLab's CI stopped detecting everything that GitHub does,
> > then the result would likely be that we often create merge requests on
> > both platforms, which would only result in more wasted resources.
> 
> I didn't suggest splitting them into two circles that overlap but
> each with area only it covers, though.  GitLab's coverage can be
> superset to GitHub's and that would satify what I suggested.

Fair.

> FWIW, I do not consider GitHub's CI "the canonical source" at all.
> It is a very handy service to use to check how well we are doing,
> but from time to time it has its own hiccups ;-).

Well, GitLab of course has its own share of hiccups, like for example
the Chocolatey issues we've been facing.

> What can we do to make the visibility of GitLab's CI more prominent?
> 
> I know where the CI jobs that are triggered when I push out the
> integration branches are found at GitHub's website[*], but I do not
> think I know the corresponding one at GitLab, for example, and I
> think that is a shame.

The pipelines of the official mirror can be found at [1]. We might for
example add something like the below patch to our README.md to make it
more discoverable.

Patrick

[1]: https://gitlab.com/git-scm/git/-/pipelines

diff --git a/README.md b/README.md
index d87bca1b8c..9ad77fdf7e 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,5 @@
-[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitHub build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitLab build status](https://gitlab.com/git-scm/git/badges/master/pipeline.svg)](https://gitlab.com/git-scm/git/-/pipelines?ref=master)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
